Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42CBEB64DD
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  9 Aug 2023 07:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjHIHQg (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 9 Aug 2023 03:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjHIHQf (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:16:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01401724
        for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:16:34 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RLLqf5v1vz9tH1;
        Wed,  9 Aug 2023 15:13:02 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 15:16:31 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <linux-trace-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] ftrace: Use LIST_HEAD to initialize clear_hash
Date:   Wed, 9 Aug 2023 15:15:51 +0800
Message-ID: <20230809071551.913041-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Use LIST_HEAD() to initialize clear_hash instead of open-coding it.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 kernel/trace/ftrace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 05c0024815bf..668202731d92 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7142,9 +7142,7 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 	struct dyn_ftrace key;
 	struct ftrace_mod_map *mod_map = NULL;
 	struct ftrace_init_func *func, *func_next;
-	struct list_head clear_hash;
-
-	INIT_LIST_HEAD(&clear_hash);
+	LIST_HEAD(clear_hash);
 
 	key.ip = start;
 	key.flags = end;	/* overload flags, as it is unsigned long */
-- 
2.34.1

