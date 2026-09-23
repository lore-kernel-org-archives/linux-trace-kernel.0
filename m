Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DE753B353
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Sep 2026 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175270; cv=none; b=LJX2nxQqv3xgdnuqP1KNroRmpIk+PSWvrvhnZb9m8ISAjEHRT1sA9L7hHfDbwKAkBvpJUd7Xu5HSsgdZYDEtn/+n0jDhLX5iP0xDAw/N1me0Mmc17E3YHCtrrd5QzqNJQU19VPPfNJtiNdhDyPOyif5+9sVR6yQCKgsghUJuadU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175270; c=relaxed/simple;
	bh=BQ3AIo9FaExG3aW1u0QXqsgAz+u3CyxtPn+zj7VYhc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stAGnsMElnGGYr5Zj2WiTqj1gAR1Eii3oHCgsx1ku1sXz4vS7W/JH150coeBp+mrNMlvGGdz4GvAw7fT1yuNNXIUI4qGhW8WiaUZ+cg9hvXdndmuHyYXmjLXOBkb+YB3pztsyqayyPBVLKsrpKRa7VtOZ2OW0Z18I3wPJOX8qIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCFSrIC0; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCFSrIC0"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c537df4daaso495142b6e.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Sep 2026 07:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790175268; x=1790780068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8imZswOXgJq9Cx5JQERORsPUChw1RLSPP9EHDsUeryo=;
        b=YCFSrIC0lwqobzyWufIQdV+GBzHpF+Ee2UQ6PKXA4ZgCLCa7gB5Jz2XhCrot7XSWHz
         G2QmyzOtR8zr5vIXqYv1vEPXJP2+4+HNbP3nUdWcjpGD0JVWP+vUefUe1HjtNWT/drAK
         du5NHAcJ9ssvnENlG7L0+pdUJo6HpKdO7FLb5fpPBLDFxSLVI/T55x2ic2ssthOEIQLn
         7oTrle9afXPxeRPfcqoURZRVqPJhpUfjILLJ+qA+Nx3U5Y9hDImkoElfAK6b6Gdtyuom
         7y5jRKpmuL54MnNrysbt0YjJ62Wj0f3UvDhJyU+1RtnE2zkJ0C4lsUJT8zmC9+I9vGDy
         RQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790175268; x=1790780068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8imZswOXgJq9Cx5JQERORsPUChw1RLSPP9EHDsUeryo=;
        b=tV2u+Nl2KwIEhL6uftA54KuH7Ws7VrBLBMiRFWkosBw8xVSG1MRfxzrDAUBnSEyrYr
         A2NHY6GHB/6Z3bq+zfU4uexEoNyqpKjioXJxF+f8UJKhKNUyQVsfNs0PjtbjUzvu1Eqd
         NJQw5Jzk7IjGMYlX5bmv1m9pyWI+jYL/a0qJrGxoNr77nZkdrEQK7WMMcuwWGk2t4xXg
         zhCNalmCnERKUfABXlZNhTx1OnWpECagQIBCibboJuV2pDGUF2JlFaCbM3+IjK7hpP0w
         S7l78cvMlJn0MK+0187t7rMol72UY9J17F8mxJ8dVsm1Ll07yEpUBu9n1HitnPzkZvPZ
         q+Cg==
X-Forwarded-Encrypted: i=1; AKwUvBxjGmS9V+BVMxl2UHaBmgKHtWxt5VUDDdf7rXxOitDsa6i6rwZVjQr/97hD1DcJcf0yo5G3jToTSr/i3DZyzaaiOLc=@vger.kernel.org
X-Gm-Message-State: AFuF++k2kyEXPfCn3EKjab3832M3JzXArxEseoqggkPrvWanc7vfA713
	T2MSj0hwLi+rp0rHzznG7aXgQuW3aaBrmKBsYZNjH3I0so+OQLyU3ZEu
X-Gm-Gg: AYBFou3PAoRfLTr0MGVOaVxfuqlkgqEzs3ROIZQlMe6JPZuO+sVE+LlYX3VFWJF8oMq
	RhoKWza3tJ8FpO/TUiPEh5efB6KOlpXmB93XanoIsuZUgwD2wvriar3kZYgaKWwlQmw6JnLPZph
	//uC+4GckmlKAuCKiEwWyjw1wD/dQR/nInE6gE+Hdp4yTc4aj0ReHnMTRBrksHbvXlccHWpdEpR
	+yWenrc2NbRNNjrlm7X8F9QpoLeOpHCaclXBAH62oVhtJZOKEoMYxgptPrKrXPp9xAVLKY8pl1G
	g92V4KyhG15OQxTAiqPumTqdujv5dt7pqLYA1yahDT8XQomZi7ZG0dKFlw+DIEDn1lV65Y13Aol
	h17oDWyepKmrqo7CAMRI9ha36xszNQysz2lSaBbevubuGSz021jpNHoHXbUz0wTntw2gafzTI0N
	aY3ovezwQPxSrpvOBGtDYkoH2dgawxiA8IL1XYrwOr7m/uhZTk7kUBvVJ6d17RrcA6Nr0trg==
X-Received: by 2002:a05:6808:4f60:b0:4d6:9283:1bdd with SMTP id 5614622812f47-4d69283317bmr1082080b6e.58.1790175268279;
        Wed, 23 Sep 2026 07:54:28 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4d5c4bf8e14sm2290752b6e.14.2026.09.23.07.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:54:27 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Allen Pais <allen.lkml@gmail.com>,
	sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] sparc64: uprobes: fix relbranch_fixup() for BPr, FBfcc and FBPfcc
Date: Wed, 23 Sep 2026 09:54:26 -0500
Message-ID: <20260923145426.421639-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923144909.414968-1-danishkhateeb03@gmail.com>
References: <20260923144909.414968-1-danishkhateeb03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uprobes single-step a copy of the probed instruction in an XOL slot.
When the copy is a taken PC-relative branch, its target is relative to
the slot, and relbranch_fixup() moves it back to the probed code. Like
its kprobes counterpart, it only recognizes call, BPcc and Bicc. After a
taken BPr (brz, brnz, ...), FBfcc or FBPfcc, the task continues at the
slot's address plus the branch displacement, inside the XOL page, and
dies with SIGILL.

GCC often emits a BPr as a function's first instruction, so a plain
function-entry uprobe can kill the probed program. In QEMU sun4u, with a
uprobe on a "brz,pn %o0, 1f", the first call with %o0 == 0 ends with

  init: potentially unexpected fatal signal 4.
  TSTATE: 0000000082000203 TPC: fffffffbffffe01c TNPC: fffffffbffffe020

where the task's [uprobes] mapping is fffffffbffffe000-fffffffc00000000.
FBfcc and FBPfcc behave the same.

Add the missing branch formats, as for kprobes.

Fixes: e8f4aa6087fa ("sparc64:Support User Probes for sparc")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---
 arch/sparc/kernel/uprobes.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/uprobes.c b/arch/sparc/kernel/uprobes.c
index c8cac64e9988..c8ba033427ba 100644
--- a/arch/sparc/kernel/uprobes.c
+++ b/arch/sparc/kernel/uprobes.c
@@ -97,12 +97,15 @@ static unsigned long relbranch_fixup(u32 insn, struct uprobe_task *utask,
 	if (regs->tnpc == regs->tpc + 0x4UL)
 		return utask->autask.saved_tnpc + 0x4UL;
 
-	/* The three cases are call, branch w/prediction,
-	 * and traditional branch.
+	/* The cases are call and the branches with a PC-relative
+	 * displacement.
 	 */
-	if ((insn & 0xc0000000) == 0x40000000 ||
-	    (insn & 0xc1c00000) == 0x00400000 ||
-	    (insn & 0xc1c00000) == 0x00800000) {
+	if ((insn & 0xc0000000) == 0x40000000 ||	/* call */
+	    (insn & 0xc1c00000) == 0x00400000 ||	/* BPcc */
+	    (insn & 0xc1c00000) == 0x00800000 ||	/* Bicc */
+	    (insn & 0xd1c00000) == 0x00c00000 ||	/* BPr */
+	    (insn & 0xc1c00000) == 0x01400000 ||	/* FBPfcc */
+	    (insn & 0xc1c00000) == 0x01800000) {	/* FBfcc */
 		unsigned long real_pc = (unsigned long) utask->vaddr;
 		unsigned long ixol_addr = utask->xol_vaddr;
 
-- 
2.55.0

