Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4911EB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 10 Jul 2023 09:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjGJJc3 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 10 Jul 2023 05:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjGJJbz (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:31:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF692D45;
        Mon, 10 Jul 2023 02:30:20 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QzzFR1QR2zTmRB;
        Mon, 10 Jul 2023 17:28:11 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 17:29:21 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <zhengyejian1@huawei.com>
Subject: [PATCH] ftrace: Fix possible warning on checking all pages used in ftrace_process_locs()
Date:   Tue, 11 Jul 2023 05:29:58 +0800
Message-ID: <20230710212958.274126-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

As comments in ftrace_process_locs(), there may be NULL pointers in
mcount_loc section:
 > Some architecture linkers will pad between
 > the different mcount_loc sections of different
 > object files to satisfy alignments.
 > Skip any NULL pointers.

After 20e5227e9f55 ("ftrace: allow NULL pointers in mcount_loc"),
NULL pointers will be accounted when allocating ftrace pages but
skipped before adding into ftrace pages, this may result in some
pages not being used. Then after 706c81f87f84 ("ftrace: Remove extra
helper functions"), warning may occur at:
  WARN_ON(pg->next);

So we may need to skip NULL pointers before allocating ftrace pages.

Fixes: 706c81f87f84 ("ftrace: Remove extra helper functions")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/trace/ftrace.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 3740aca79fe7..5b474165df31 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6485,6 +6485,16 @@ static int ftrace_process_locs(struct module *mod,
 	if (!count)
 		return 0;
 
+	p = start;
+	while (p < end) {
+		/*
+		 * Refer to conments below, there may be NULL pointers,
+		 * skip them before allocating pages
+		 */
+		addr = ftrace_call_adjust(*p++);
+		if (!addr)
+			count--;
+	}
 	/*
 	 * Sorting mcount in vmlinux at build time depend on
 	 * CONFIG_BUILDTIME_MCOUNT_SORT, while mcount loc in
-- 
2.25.1

