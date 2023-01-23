Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A85C05027
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 23 Jan 2023 18:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbjAWSC3 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 23 Jan 2023 13:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjAWSC2 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:02:28 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90CFEF82
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Jan 2023 10:02:27 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 530B85616BDB; Mon, 23 Jan 2023 09:37:56 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     linux-mm@kvack.org
Cc:     shr@devkernel.io, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH v1 05/20] mm: support disabling of ksm for a process
Date:   Mon, 23 Jan 2023 09:37:33 -0800
Message-Id: <20230123173748.1734238-6-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230123173748.1734238-1-shr@devkernel.io>
References: <20230123173748.1734238-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

This adds the ability to disable ksm for a process if ksm has been
enabled for the process.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 mm/ksm.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 967eda719fab..5fa6b46dfa3b 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2588,6 +2588,27 @@ int __ksm_enter(struct mm_struct *mm, int flag)
 	return 0;
 }
=20
+static void unmerge_vmas(struct mm_struct *mm)
+{
+	struct vm_area_struct *vma;
+	struct vma_iterator vmi;
+
+	vma_iter_init(&vmi, mm, 0);
+
+	mmap_read_lock(mm);
+	for_each_vma(vmi, vma) {
+		if (vma->vm_flags & VM_MERGEABLE) {
+			unsigned long flags =3D vma->vm_flags;
+
+			if (ksm_madvise(vma, vma->vm_start, vma->vm_end, MADV_UNMERGEABLE, &f=
lags))
+				continue;
+
+			vma->vm_flags =3D flags;
+		}
+	}
+	mmap_read_unlock(mm);
+}
+
 void __ksm_exit(struct mm_struct *mm, int flag)
 {
 	struct ksm_mm_slot *mm_slot;
@@ -2595,8 +2616,10 @@ void __ksm_exit(struct mm_struct *mm, int flag)
 	int easy_to_free =3D 0;
=20
 	if (!(current->flags & PF_EXITING) && flag =3D=3D MMF_VM_MERGE_ANY &&
-	    test_bit(MMF_VM_MERGE_ANY, &mm->flags))
+		test_bit(MMF_VM_MERGE_ANY, &mm->flags)) {
 		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
+		unmerge_vmas(mm);
+	}
=20
 	/*
 	 * This process is exiting: if it's straightforward (as is the
--=20
2.30.2

