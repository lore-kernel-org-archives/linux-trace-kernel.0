Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AADEB64DD
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  4 Aug 2023 01:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjHDBoo (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 3 Aug 2023 21:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjHDBon (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 21:44:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F04A4488
        for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Aug 2023 18:44:42 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RH7l14YhrzVk1l;
        Fri,  4 Aug 2023 09:42:53 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 09:44:40 +0800
From:   Zhang Zekun <zhangzekun11@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mark.rutland@arm.com>, <linux-trace-kernel@vger.kernel.org>
CC:     <zhangzekun11@huawei.com>
Subject: [PATCH] ftrace: Remove empty declaration ftrace_enable_daemon() and ftrace_disable_daemon()
Date:   Fri, 4 Aug 2023 09:36:36 +0800
Message-ID: <20230804013636.115940-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

The definition of ftrace_enable_daemon() and ftrace_disable_daemon() has
been removed since commit cb7be3b2fc2c ("ftrace: remove daemon"), remain
the declarations in the header files, so remove it.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 include/linux/ftrace.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index aad9cf8876b5..e8921871ef9a 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -862,13 +862,8 @@ extern int skip_trace(unsigned long ip);
 extern void ftrace_module_init(struct module *mod);
 extern void ftrace_module_enable(struct module *mod);
 extern void ftrace_release_mod(struct module *mod);
-
-extern void ftrace_disable_daemon(void);
-extern void ftrace_enable_daemon(void);
 #else /* CONFIG_DYNAMIC_FTRACE */
 static inline int skip_trace(unsigned long ip) { return 0; }
-static inline void ftrace_disable_daemon(void) { }
-static inline void ftrace_enable_daemon(void) { }
 static inline void ftrace_module_init(struct module *mod) { }
 static inline void ftrace_module_enable(struct module *mod) { }
 static inline void ftrace_release_mod(struct module *mod) { }
-- 
2.17.1

