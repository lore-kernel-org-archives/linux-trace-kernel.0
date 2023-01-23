Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43757C38142
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 23 Jan 2023 17:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjAWR64 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 23 Jan 2023 12:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjAWR64 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:58:56 -0500
X-Greylist: delayed 107 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 09:58:54 PST
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8A423D81
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:58:54 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 6B83A5616BE7; Mon, 23 Jan 2023 09:37:56 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     linux-mm@kvack.org
Cc:     shr@devkernel.io, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH v1 11/20] mm: calculate ksm process profit metric
Date:   Mon, 23 Jan 2023 09:37:39 -0800
Message-Id: <20230123173748.1734238-12-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230123173748.1734238-1-shr@devkernel.io>
References: <20230123173748.1734238-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

The ksm documentation mentions the process profit metric and how to
calculate it. This adds the calculation of the metric.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 include/linux/ksm.h | 4 ++++
 mm/ksm.c            | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index d38a05a36298..a18cd03efcfb 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -55,6 +55,10 @@ struct page *ksm_might_need_to_copy(struct page *page,
 void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc);
 void folio_migrate_ksm(struct folio *newfolio, struct folio *folio);
=20
+#ifdef CONFIG_PROC_FS
+long ksm_process_profit(struct mm_struct *);
+#endif /* CONFIG_PROC_FS */
+
 #else  /* !CONFIG_KSM */
=20
 static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm=
)
diff --git a/mm/ksm.c b/mm/ksm.c
index d29454a802a0..288689b59527 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2935,6 +2935,14 @@ static void wait_while_offlining(void)
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
=20
+#ifdef CONFIG_PROC_FS
+long ksm_process_profit(struct mm_struct *mm)
+{
+	return (long)mm->ksm_merging_pages * PAGE_SIZE -
+		mm->ksm_rmap_items * sizeof(struct ksm_rmap_item);
+}
+#endif /* CONFIG_PROC_FS */
+
 #ifdef CONFIG_SYSFS
 /*
  * This all compiles without CONFIG_SYSFS, but is a waste of space.
--=20
2.30.2

