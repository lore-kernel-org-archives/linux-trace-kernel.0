Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A02C54EAA
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 23 Jan 2023 18:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjAWSFJ (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 23 Jan 2023 13:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbjAWSFE (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:05:04 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9083303D7
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Jan 2023 10:05:03 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 572115616BDD; Mon, 23 Jan 2023 09:37:56 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     linux-mm@kvack.org
Cc:     shr@devkernel.io, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH v1 06/20] mm: add new prctl option to get and set ksm for a process
Date:   Mon, 23 Jan 2023 09:37:34 -0800
Message-Id: <20230123173748.1734238-7-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230123173748.1734238-1-shr@devkernel.io>
References: <20230123173748.1734238-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

This adds two new options to the prctl system call
- enable ksm for all vmas of a process (if the vmas support it).
- query if ksm has been enabled for a process.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 include/uapi/linux/prctl.h |  2 ++
 kernel/sys.c               | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index a5e06dcbba13..b8ba85f18e43 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -284,4 +284,6 @@ struct prctl_mm_map {
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
=20
+#define PR_SET_MEMORY_MERGE		65
+#define PR_GET_MEMORY_MERGE		66
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 5fd54bf0e886..de218e3b6f42 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -15,6 +15,7 @@
 #include <linux/highuid.h>
 #include <linux/fs.h>
 #include <linux/kmod.h>
+#include <linux/ksm.h>
 #include <linux/perf_event.h>
 #include <linux/resource.h>
 #include <linux/kernel.h>
@@ -2626,6 +2627,34 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long,=
 arg2, unsigned long, arg3,
 	case PR_SET_VMA:
 		error =3D prctl_set_vma(arg2, arg3, arg4, arg5);
 		break;
+#ifdef CONFIG_KSM
+	case PR_SET_MEMORY_MERGE:
+		if (!capable(CAP_SYS_RESOURCE))
+			return -EPERM;
+
+		if (arg2) {
+			if (mmap_write_lock_killable(me->mm))
+				return -EINTR;
+
+			if (test_bit(MMF_VM_MERGEABLE, &me->mm->flags))
+				error =3D -EINVAL;
+			else if (!test_bit(MMF_VM_MERGE_ANY, &me->mm->flags))
+				error =3D __ksm_enter(me->mm, MMF_VM_MERGE_ANY);
+			mmap_write_unlock(me->mm);
+		} else {
+			__ksm_exit(me->mm, MMF_VM_MERGE_ANY);
+		}
+		break;
+	case PR_GET_MEMORY_MERGE:
+		if (!capable(CAP_SYS_RESOURCE))
+			return -EPERM;
+
+		if (arg2 || arg3 || arg4 || arg5)
+			return -EINVAL;
+
+		error =3D !!test_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
+		break;
+#endif
 	default:
 		error =3D -EINVAL;
 		break;
--=20
2.30.2

