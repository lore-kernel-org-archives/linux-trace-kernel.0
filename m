Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D319EB8FAD
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  6 Sep 2023 08:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjIFITh (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 6 Sep 2023 04:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjIFITg (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:19:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422CABF;
        Wed,  6 Sep 2023 01:19:32 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RgZtn5NTXzhZHc;
        Wed,  6 Sep 2023 16:15:29 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 6 Sep 2023 16:19:28 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <yeweihua4@huawei.com>,
        <zhengyejian1@huawei.com>
Subject: [PATCH] ring-buffer: Avoid softlockup in ring_buffer_resize()
Date:   Wed, 6 Sep 2023 16:19:30 +0800
Message-ID: <20230906081930.3939106-1-zhengyejian1@huawei.com>
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

When user resize all trace ring buffer through file 'buffer_size_kb',
then in ring_buffer_resize(), kernel allocates buffer pages for each
cpu in a loop.

If the kernel preemption model is PREEMPT_NONE and there are many cpus
and there are many buffer pages to be allocated, it may not give up cpu
for a long time and finally cause a softlockup.

To avoid it, call cond_resched() after each cpu buffer allocation.

Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/trace/ring_buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 78502d4c7214..72ccf75defd0 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2198,6 +2198,8 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 				err = -ENOMEM;
 				goto out_err;
 			}
+
+			cond_resched();
 		}
 
 		cpus_read_lock();
-- 
2.25.1

