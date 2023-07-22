Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4279EB64DA
	for <linux-trace-kernel@archiver.kernel.org>; Sat, 22 Jul 2023 03:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjGVDVx (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 21 Jul 2023 23:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGVDVw (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 23:21:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4675C3A9C;
        Fri, 21 Jul 2023 20:21:51 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R7BTT5lrVztQr4;
        Sat, 22 Jul 2023 11:18:37 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 22 Jul
 2023 11:21:47 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH -next] tracing: Remove unused extern declaration tracing_map_set_field_descr()
Date:   Sat, 22 Jul 2023 11:21:23 +0800
Message-ID: <20230722032123.24664-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Since commit 08d43a5fa063 ("tracing: Add lock-free tracing_map"),
this is never used, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/trace/tracing_map.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/trace/tracing_map.h b/kernel/trace/tracing_map.h
index 2c765ee2a4d4..99c37eeebc16 100644
--- a/kernel/trace/tracing_map.h
+++ b/kernel/trace/tracing_map.h
@@ -272,10 +272,6 @@ extern u64 tracing_map_read_sum(struct tracing_map_elt *elt, unsigned int i);
 extern u64 tracing_map_read_var(struct tracing_map_elt *elt, unsigned int i);
 extern u64 tracing_map_read_var_once(struct tracing_map_elt *elt, unsigned int i);
 
-extern void tracing_map_set_field_descr(struct tracing_map *map,
-					unsigned int i,
-					unsigned int key_offset,
-					tracing_map_cmp_fn_t cmp_fn);
 extern int
 tracing_map_sort_entries(struct tracing_map *map,
 			 struct tracing_map_sort_key *sort_keys,
-- 
2.34.1

