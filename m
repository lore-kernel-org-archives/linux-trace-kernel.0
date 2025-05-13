Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1A125525C;
	Tue, 13 May 2025 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747138891; cv=none; b=sjcCsWou4FWLO0//U5hsEY8Ijz0RnHxre74PlqSzrovJF1aOeD38EixWD9J7Z2zCLBlFDUwsbYPqwjgzv9sN1PBwfUosUElUZpD3MzDON98mrRTml5blb/GPVF/xXNsR7TuhTlx0FAKc0X30DEh1MNuh1cnuJFvrD8ERDhxY3PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747138891; c=relaxed/simple;
	bh=Yd99bDXYuiczj4hfSvGvriMsbruLksA9MnpAor8YBSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qOB7U4Ib0J4qqiONcUG2RjzIDEpXpD14S3loNXthYZyMnwp/RbmbbEalXuMH9H5kVp+Zku9JbwGGIuLqTwvrcJacTft7K8m0TCFSl/AEREy96oRAasHBqxLefiptHODrlja+M+9ieoGRIZD/c5NONgfRmGucGsASNArUZ0WDM0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjI8c+Wr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjI8c+Wr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB100C4CEE4;
	Tue, 13 May 2025 12:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747138890;
	bh=Yd99bDXYuiczj4hfSvGvriMsbruLksA9MnpAor8YBSw=;
	h=From:To:Cc:Subject:Date:From;
	b=cjI8c+WrnDleOF9Hgo9N+DCxFXrtrWTK7Zxg63ED3Me789Z9lSp7/OsDLzjM3A4yu
	 +RnudhXbwE00DgEih4o9DxF9akDQWlU3GfCZu0ObRAnTRgw3Gj+OdmRmZk7NB6daj5
	 uR53q2UXCv8iwxkiEIedQVm70TGo42j96ra1OHwdSFaL4ye8edKxMngDAa49fNP2VH
	 VgP370Ff3PMrqqIeaSudLfL+5RhDoET7ewNmHMOQZ8Ia5PDXAsgO90zproaxZa8pkS
	 00wEPR3oKDRSvi32fDWxRIu/ZEfK3a636rGDNkK7mDK3weR+kXoQZrS5cQUdmJswJy
	 EKLFcDwHsEsfA==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH mm-stable] uprobes: Revert ref_ctr_offset in uprobe_unregister error path
Date: Tue, 13 May 2025 14:21:25 +0200
Message-ID: <20250513122125.1617722-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Olsa <olsajiri@gmail.com>

There's error path that could lead to inactive uprobe:

  1) uprobe_register succeeds - updates instruction to int3 and
     changes ref_ctr from 0 to 1
  2) uprobe_unregister fails  - int3 stays in place, but ref_ctr
     is changed to 0 (it's not restored to 1 in the fail path)
     uprobe is leaked
  3) another uprobe_register comes and re-uses the leaked uprobe
     and succeds - but int3 is already in place, so ref_ctr update
     is skipped and it stays 0 - uprobe CAN NOT be triggered now
  4) uprobe_unregister fails because ref_ctr value is unexpected

Fixing this by reverting the updated ref_ctr value back to 1 in step 2),
which is the case when uprobe_unregister fails (int3 stays in place),
but we have already updated refctr.

The new scenario will go as follows:

  1) uprobe_register succeeds - updates instruction to int3 and
     changes ref_ctr from 0 to 1
  2) uprobe_unregister fails  - int3 stays in place and ref_ctr
     is reverted to 1..  uprobe is leaked
  3) another uprobe_register comes and re-uses the leaked uprobe
     and succeds - but int3 is already in place, so ref_ctr update
     is skipped and it stays 1 - uprobe CAN be triggered now
  4) uprobe_unregister succeeds

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
Please note it's based on mm-stable branch, because it has the
latest uprobe_write_opcode rewrite changes.

 kernel/events/uprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4c965ba77f9f..84ee7b590861 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -581,8 +581,8 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 
 out:
 	/* Revert back reference counter if instruction update failed. */
-	if (ret < 0 && is_register && ref_ctr_updated)
-		update_ref_ctr(uprobe, mm, -1);
+	if (ret < 0 && ref_ctr_updated)
+		update_ref_ctr(uprobe, mm, is_register ? -1 : 1);
 
 	/* try collapse pmd for compound page */
 	if (ret > 0)
-- 
2.49.0

