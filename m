Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C833EB64DA
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  7 Jul 2023 17:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjGGRYM (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 7 Jul 2023 13:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjGGRXv (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:23:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FF62690
        for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Jul 2023 10:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688750550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eoYdZ3j5mn2MTw1iUVYlPJSnwNWgHj3M8L9iz2kPLwU=;
        b=LZbRuc/BU+5/WOr1yJuHLdcm7ZPjqW5EEt5Lz+BtI89i+BKCZsgttthlnda40t9U5ev5v2
        eZDkw4vfr8pqJKZWZs/7H6tGrc/9lEKB1ztkIGB+FdMVAMfqDIZssrbL7KbIDqIyQz4XEQ
        LDjitag52kmkukaFO3sYGAvg/JjHqNQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-8Elu-Jy4N9m2zwot3temYw-1; Fri, 07 Jul 2023 13:22:25 -0400
X-MC-Unique: 8Elu-Jy4N9m2zwot3temYw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44CBF83FC20;
        Fri,  7 Jul 2023 17:22:25 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.164])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BDADB1454142;
        Fri,  7 Jul 2023 17:22:23 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v2 7/9] tracing/filters: Optimise CPU vs cpumask filtering when the user mask is a single CPU
Date:   Fri,  7 Jul 2023 18:21:53 +0100
Message-Id: <20230707172155.70873-8-vschneid@redhat.com>
In-Reply-To: <20230707172155.70873-1-vschneid@redhat.com>
References: <20230707172155.70873-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Steven noted that when the user-provided cpumask contains a single CPU,
then the filtering function can use a scalar as input instead of a
full-fledged cpumask.

In this case we can directly re-use filter_pred_cpu(), we just need to
transform '&' into '==' before executing it.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/trace/trace_events_filter.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 54d642fabb7f1..fd72dacc5d1b8 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1750,7 +1750,7 @@ static int parse_pred(const char *str, void *data,
 		 * then we can treat it as a scalar input.
 		 */
 		single = cpumask_weight(pred->mask) == 1;
-		if (single && field->filter_type != FILTER_CPU) {
+		if (single) {
 			pred->val = cpumask_first(pred->mask);
 			kfree(pred->mask);
 		}
@@ -1760,7 +1760,12 @@ static int parse_pred(const char *str, void *data,
 				FILTER_PRED_FN_CPUMASK_CPU :
 				FILTER_PRED_FN_CPUMASK;
 		} else if (field->filter_type == FILTER_CPU) {
-			pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
+			if (single) {
+				pred->op = pred->op == OP_BAND ? OP_EQ : pred->op;
+				pred->fn_num = FILTER_PRED_FN_CPU;
+			} else {
+				pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
+			}
 		} else if (single) {
 			pred->op = pred->op == OP_BAND ? OP_EQ : pred->op;
 			pred->fn_num = select_comparison_fn(pred->op, field->size, false);
-- 
2.31.1

