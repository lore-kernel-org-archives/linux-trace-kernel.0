Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8447AC38142
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 23 Jan 2023 17:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjAWR7n (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 23 Jan 2023 12:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjAWR7m (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:59:42 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56962ED7E
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:59:40 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 45FC35616BD5; Mon, 23 Jan 2023 09:37:56 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     linux-mm@kvack.org
Cc:     shr@devkernel.io, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH v1 02/20] mm: add flag to __ksm_enter
Date:   Mon, 23 Jan 2023 09:37:30 -0800
Message-Id: <20230123173748.1734238-3-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230123173748.1734238-1-shr@devkernel.io>
References: <20230123173748.1734238-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

This change adds the flag parameter to __ksm_enter. This allows to
distinguish if ksm was called by prctl or madvise.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 include/linux/ksm.h | 6 ++++--
 mm/ksm.c            | 9 +++++----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 7e232ba59b86..50e6b56092f3 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -18,13 +18,15 @@
 #ifdef CONFIG_KSM
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, unsigned long *vm_flags);
-int __ksm_enter(struct mm_struct *mm);
 void __ksm_exit(struct mm_struct *mm);
+int __ksm_enter(struct mm_struct *mm, int flag);
=20
 static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm=
)
 {
+	if (test_bit(MMF_VM_MERGE_ANY, &oldmm->flags))
+		return __ksm_enter(mm, MMF_VM_MERGE_ANY);
 	if (test_bit(MMF_VM_MERGEABLE, &oldmm->flags))
-		return __ksm_enter(mm);
+		return __ksm_enter(mm, MMF_VM_MERGEABLE);
 	return 0;
 }
=20
diff --git a/mm/ksm.c b/mm/ksm.c
index dd02780c387f..d84a244fe224 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2493,8 +2493,9 @@ int ksm_madvise(struct vm_area_struct *vma, unsigne=
d long start,
 			return 0;
 #endif
=20
-		if (!test_bit(MMF_VM_MERGEABLE, &mm->flags)) {
-			err =3D __ksm_enter(mm);
+		if (!test_bit(MMF_VM_MERGEABLE, &mm->flags) &&
+		    !test_bit(MMF_VM_MERGE_ANY, &mm->flags)) {
+			err =3D __ksm_enter(mm, MMF_VM_MERGEABLE);
 			if (err)
 				return err;
 		}
@@ -2520,7 +2521,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigne=
d long start,
 }
 EXPORT_SYMBOL_GPL(ksm_madvise);
=20
-int __ksm_enter(struct mm_struct *mm)
+int __ksm_enter(struct mm_struct *mm, int flag)
 {
 	struct ksm_mm_slot *mm_slot;
 	struct mm_slot *slot;
@@ -2553,7 +2554,7 @@ int __ksm_enter(struct mm_struct *mm)
 		list_add_tail(&slot->mm_node, &ksm_scan.mm_slot->slot.mm_node);
 	spin_unlock(&ksm_mmlist_lock);
=20
-	set_bit(MMF_VM_MERGEABLE, &mm->flags);
+	set_bit(flag, &mm->flags);
 	mmgrab(mm);
=20
 	if (needs_wakeup)
--=20
2.30.2

