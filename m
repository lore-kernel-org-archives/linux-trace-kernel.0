Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ED5CA0FE5
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  1 Sep 2023 15:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350117AbjIAPL7 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 1 Sep 2023 11:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350114AbjIAPL7 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:11:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CDC10F8
        for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693581068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z8YZj7U283/XjuckA+i8EXyp3nE30BsVfSwsfevewvQ=;
        b=IMBcYv2DbA/6j9Mfzxf5pENJwGy7sbTOeujtC2ryDstk5omDUBN93gpOTAcCdkmC047Pv1
        Ah3t9Y01yVab/5DM/DzbHAqp8ii0ryAEsMXnyJ2MpRBvjr0ppuEub6HcaNnYLQ0SxIGaPR
        ay8A8iWHDThj/eMeYg546G0dh8Q+MlA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-3uY_UUUjNK2Mc0YnL1wBTQ-1; Fri, 01 Sep 2023 11:11:04 -0400
X-MC-Unique: 3uY_UUUjNK2Mc0YnL1wBTQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B8B23C025BD;
        Fri,  1 Sep 2023 15:11:04 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.39.193.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 66C442012F37;
        Fri,  1 Sep 2023 15:11:03 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 3/4] tracing/filters: Change parse_pred() cpulist ternary into an if block
Date:   Fri,  1 Sep 2023 17:10:38 +0200
Message-Id: <20230901151039.125186-4-vschneid@redhat.com>
In-Reply-To: <20230901151039.125186-1-vschneid@redhat.com>
References: <20230901151039.125186-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Review comments noted that an if block would be clearer than a ternary, so
swap it out.

No change in behaviour intended

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/trace/trace_events_filter.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index eb331e8b00b61..09b4733a2933d 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1782,13 +1782,17 @@ static int parse_pred(const char *str, void *data,
 				FILTER_PRED_FN_CPUMASK;
 		} else if (field->filter_type == FILTER_CPU) {
 			if (single) {
-				pred->op = pred->op == OP_BAND ? OP_EQ : pred->op;
+				if (pred->op == OP_BAND)
+					pred->op = OP_EQ;
+
 				pred->fn_num = FILTER_PRED_FN_CPU;
 			} else {
 				pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
 			}
 		} else if (single) {
-			pred->op = pred->op == OP_BAND ? OP_EQ : pred->op;
+			if (pred->op == OP_BAND)
+				pred->op = OP_EQ;
+
 			pred->fn_num = select_comparison_fn(pred->op, field->size, false);
 			if (pred->op == OP_NE)
 				pred->not = 1;
-- 
2.31.1

