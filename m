Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901E9C41513
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 24 Jul 2023 14:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjGXOJH (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 24 Jul 2023 10:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjGXOI5 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:08:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21ED1BE2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:08:40 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R8hlS2y8gzHqZr;
        Mon, 24 Jul 2023 22:05:56 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 22:08:29 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <cuigaosheng1@huawei.com>
CC:     <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH 3/4] tracing: Fix kernel-doc warnings in trace_events_trigger.c
Date:   Mon, 24 Jul 2023 22:08:26 +0800
Message-ID: <20230724140827.1023266-4-cuigaosheng1@huawei.com>
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

kernel/trace/trace_events_trigger.c:59: warning: Function parameter
or member 'buffer' not described in 'event_triggers_call'
kernel/trace/trace_events_trigger.c:59: warning: Function parameter
or member 'event' not described in 'event_triggers_call'

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 kernel/trace/trace_events_trigger.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index e535959939d3..46439e3bcec4 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -31,7 +31,9 @@ void trigger_data_free(struct event_trigger_data *data)
 /**
  * event_triggers_call - Call triggers associated with a trace event
  * @file: The trace_event_file associated with the event
+ * @buffer: The ring buffer that the event is being written to
  * @rec: The trace entry for the event, NULL for unconditional invocation
+ * @event: The event meta data in the ring buffer
  *
  * For each trigger associated with an event, invoke the trigger
  * function registered with the associated trigger command.  If rec is
-- 
2.25.1

