Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D2CC001DF
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 24 Jul 2023 14:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjGXOJG (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 24 Jul 2023 10:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjGXOI4 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:08:56 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B081BDF
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:08:39 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R8hnR2HkTz1KCCx;
        Mon, 24 Jul 2023 22:07:39 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 22:08:29 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <cuigaosheng1@huawei.com>
CC:     <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH 4/4] tracing: Fix kernel-doc warnings in trace_seq.c
Date:   Mon, 24 Jul 2023 22:08:27 +0800
Message-ID: <20230724140827.1023266-5-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230724140827.1023266-1-cuigaosheng1@huawei.com>
References: <20230724140827.1023266-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Fix kernel-doc warning:

kernel/trace/trace_seq.c:142: warning: Function parameter or member
'args' not described in 'trace_seq_vprintf'

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 kernel/trace/trace_seq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index e5e299260d0c..bac06ee3b98b 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -131,6 +131,7 @@ EXPORT_SYMBOL_GPL(trace_seq_bitmask);
  * trace_seq_vprintf - sequence printing of trace information
  * @s: trace sequence descriptor
  * @fmt: printf format string
+ * @args: Arguments for the format string
  *
  * The tracer may use either sequence operations or its own
  * copy to user routines. To simplify formatting of a trace
-- 
2.25.1

