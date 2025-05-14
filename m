Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379261FC7CB;
	Wed, 14 May 2025 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747217898; cv=none; b=ZoGgbvrkfJTiKwFqeizdCM0s48qbdgN4Ljx8iS8rGtoBE5DG55m5ZnfDTykhQUKbk0X8ZBdl2gnmNZnFzbMRetmu57OH0Me+YPkEaP9YhAOhSrf7ThhbQi/+MFt5uwriQYsU+x24UTAcZcyAWgmuj4GtrdtyDSETT291J1mmv2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747217898; c=relaxed/simple;
	bh=2KqiSzP97xegJkde8GYrdE5rWOsaoq9MUHsXADNhDjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OjsGtGZva7yhY+Cd4e2sZDrClXFuT/Q0Nu6r+5siWIgt24eYveRJ+ReqxJo1wrwPyIwO6PwhzVjGWHEvcnOyvsraJ6umDZYBgFRlt8AZ+bXIaeK9zkK6dkrJCUrhww++5NLoB9Z0H3MHkRrxKwBK1mK1jUhE++spRkjikKqGQQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlkbRTt3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlkbRTt3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A47C4CEF0;
	Wed, 14 May 2025 10:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747217895;
	bh=2KqiSzP97xegJkde8GYrdE5rWOsaoq9MUHsXADNhDjQ=;
	h=From:To:Cc:Subject:Date:From;
	b=GlkbRTt38U1WxtmMJdG/jVyzt1P42XPReCS77wZFYAQ7IYra7UT6Eo7GxLfZO/gcN
	 r3qkX6Ci50jsHO5E9f2dysEpgzq53jgmA1uUL07SeLjHkIkJRowyONnTMFdNU5zrkf
	 2bRXZ7/GkrUKnhFihkvb3cHQa06WZxktq0djLOFzWvfpyhsqAiNv3/l1N33KEaV9hz
	 3ceLUcLiFX1CFFdGRbko2cjVL58cClAMbo5/C5mHTsb+o461GTVoWV4w+PSeElU8SO
	 m2KU6rIc/yNJ110JOlzHQRmswoT30e2r8kK8/KVvMHygRvlzo0lO6H6AUJsO9lLn7/
	 1/sDEjE2SFYVQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: David Hildenbrand <david@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv2 mm-stable] uprobes: Revert ref_ctr_offset in uprobe_unregister error path
Date: Wed, 14 May 2025 12:18:09 +0200
Message-ID: <20250514101809.2010193-1-jolsa@kernel.org>
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

Fixes: 1cc33161a83d ("uprobes: Support SDT markers having reference count (semaphore)")
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
v2 changes:
- adding proper Fixes tag and acks

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

