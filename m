Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7B7C00528
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 24 Jul 2023 14:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjGXOJG (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 24 Jul 2023 10:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjGXOI4 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:08:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20A2172B
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:08:40 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R8hnP5SCdzrRvL;
        Mon, 24 Jul 2023 22:07:37 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 22:08:28 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <cuigaosheng1@huawei.com>
CC:     <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH 1/4] ring-buffer: Fix kernel-doc warnings in ring_buffer.c
Date:   Mon, 24 Jul 2023 22:08:24 +0800
Message-ID: <20230724140827.1023266-2-cuigaosheng1@huawei.com>
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

Fix kernel-doc warnings:

kernel/trace/ring_buffer.c:954: warning: Function parameter or
member 'cpu' not described in 'ring_buffer_wake_waiters'
kernel/trace/ring_buffer.c:3383: warning: Excess function parameter
'event' description in 'ring_buffer_unlock_commit'
kernel/trace/ring_buffer.c:5359: warning: Excess function parameter
'cpu' description in 'ring_buffer_reset_online_cpus'

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 kernel/trace/ring_buffer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 14d8001140c8..ef5fabaa46e8 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -946,6 +946,7 @@ static void rb_wake_up_waiters(struct irq_work *work)
 /**
  * ring_buffer_wake_waiters - wake up any waiters on this ring buffer
  * @buffer: The ring buffer to wake waiters on
+ * @cpu: The CPU buffer to wake waiters on
  *
  * In the case of a file that represents a ring buffer is closing,
  * it is prudent to wake up any waiters that are on this.
@@ -3373,7 +3374,6 @@ void ring_buffer_nest_end(struct trace_buffer *buffer)
 /**
  * ring_buffer_unlock_commit - commit a reserved
  * @buffer: The buffer to commit to
- * @event: The event pointer to commit.
  *
  * This commits the data to the ring buffer, and releases any locks held.
  *
@@ -5353,7 +5353,6 @@ EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
 /**
  * ring_buffer_reset_online_cpus - reset a ring buffer per CPU buffer
  * @buffer: The ring buffer to reset a per cpu buffer of
- * @cpu: The CPU buffer to be reset
  */
 void ring_buffer_reset_online_cpus(struct trace_buffer *buffer)
 {
-- 
2.25.1

