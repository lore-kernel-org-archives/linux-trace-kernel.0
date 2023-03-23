Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D408C7619A
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 23 Mar 2023 11:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjCWLm2 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 23 Mar 2023 07:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjCWLm1 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:42:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218B3F746;
        Thu, 23 Mar 2023 04:42:23 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pj3JY4vKzzSnvy;
        Thu, 23 Mar 2023 19:38:53 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 19:42:19 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <louhongxiang@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH] trace:cma: remove unnecessary event class cma_alloc_class
Date:   Thu, 23 Mar 2023 19:41:36 +0800
Message-ID: <20230323114136.177677-1-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

After commit cb6c33d4dc09 ("cma: tracing: print alloc result in
trace_cma_alloc_finish"), cma_alloc_class has only one event which is
cma_alloc_busy_retry. So we can remove the cma_alloc_class.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 include/trace/events/cma.h | 58 ++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/include/trace/events/cma.h b/include/trace/events/cma.h
index ef75ea606ab2..25103e67737c 100644
--- a/include/trace/events/cma.h
+++ b/include/trace/events/cma.h
@@ -8,37 +8,6 @@
 #include <linux/types.h>
 #include <linux/tracepoint.h>
 
-DECLARE_EVENT_CLASS(cma_alloc_class,
-
-	TP_PROTO(const char *name, unsigned long pfn, const struct page *page,
-		 unsigned long count, unsigned int align),
-
-	TP_ARGS(name, pfn, page, count, align),
-
-	TP_STRUCT__entry(
-		__string(name, name)
-		__field(unsigned long, pfn)
-		__field(const struct page *, page)
-		__field(unsigned long, count)
-		__field(unsigned int, align)
-	),
-
-	TP_fast_assign(
-		__assign_str(name, name);
-		__entry->pfn = pfn;
-		__entry->page = page;
-		__entry->count = count;
-		__entry->align = align;
-	),
-
-	TP_printk("name=%s pfn=0x%lx page=%p count=%lu align=%u",
-		  __get_str(name),
-		  __entry->pfn,
-		  __entry->page,
-		  __entry->count,
-		  __entry->align)
-);
-
 TRACE_EVENT(cma_release,
 
 	TP_PROTO(const char *name, unsigned long pfn, const struct page *page,
@@ -125,12 +94,35 @@ TRACE_EVENT(cma_alloc_finish,
 		  __entry->errorno)
 );
 
-DEFINE_EVENT(cma_alloc_class, cma_alloc_busy_retry,
+TRACE_EVENT(cma_alloc_busy_retry,
 
 	TP_PROTO(const char *name, unsigned long pfn, const struct page *page,
 		 unsigned long count, unsigned int align),
 
-	TP_ARGS(name, pfn, page, count, align)
+	TP_ARGS(name, pfn, page, count, align),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(unsigned long, pfn)
+		__field(const struct page *, page)
+		__field(unsigned long, count)
+		__field(unsigned int, align)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->pfn = pfn;
+		__entry->page = page;
+		__entry->count = count;
+		__entry->align = align;
+	),
+
+	TP_printk("name=%s pfn=0x%lx page=%p count=%lu align=%u",
+		  __get_str(name),
+		  __entry->pfn,
+		  __entry->page,
+		  __entry->count,
+		  __entry->align)
 );
 
 #endif /* _TRACE_CMA_H */
-- 
2.35.3

