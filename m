Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923BCC001DE
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 31 Jul 2023 11:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjGaLbj (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 31 Jul 2023 07:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjGaLbi (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:31:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2836CD
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:31:35 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RDwy82xB5zVjn2;
        Mon, 31 Jul 2023 19:29:52 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 19:31:33 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH -next] ring-buffer: remove kernel-doc warnings
Date:   Mon, 31 Jul 2023 19:31:03 +0800
Message-ID: <20230731113103.215441-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Remove kernel-doc warnings:

kernel/trace/ring_buffer.c:955: warning: Function parameter or member
'cpu' not described in 'ring_buffer_wake_waiters'
kernel/trace/ring_buffer.c:3386: warning: Excess function parameter
'event' description in 'ring_buffer_unlock_commit'
kernel/trace/ring_buffer.c:5362: warning: Excess function parameter 'cpu'
description in 'ring_buffer_reset_online_cpus'

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
---
 kernel/trace/ring_buffer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index de061dd47313..236b6b19dab9 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -947,6 +947,7 @@ static void rb_wake_up_waiters(struct irq_work *work)
 /**
  * ring_buffer_wake_waiters - wake up any waiters on this ring buffer
  * @buffer: The ring buffer to wake waiters on
+ * @cpu: The cpu of the ring_buffer to wake waiters on
  *
  * In the case of a file that represents a ring buffer is closing,
  * it is prudent to wake up any waiters that are on this.
@@ -3376,7 +3377,6 @@ void ring_buffer_nest_end(struct trace_buffer *buffer)
 /**
  * ring_buffer_unlock_commit - commit a reserved
  * @buffer: The buffer to commit to
- * @event: The event pointer to commit.
  *
  * This commits the data to the ring buffer, and releases any locks held.
  *
@@ -5356,7 +5356,6 @@ EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
 /**
  * ring_buffer_reset_online_cpus - reset a ring buffer per CPU buffer
  * @buffer: The ring buffer to reset a per cpu buffer of
- * @cpu: The CPU buffer to be reset
  */
 void ring_buffer_reset_online_cpus(struct trace_buffer *buffer)
 {
-- 
2.17.1

