Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC934EB64DA
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  7 Jul 2023 17:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjGGRYG (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 7 Jul 2023 13:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjGGRXu (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:23:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801792685
        for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Jul 2023 10:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688750545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=07XsHvqnmvZKa7o2IK/zebs5uLAhltI+FwSlNCiWefo=;
        b=CFo8gUiBA8NbpA4kO9pls7atKlFMmiEULa7o4Kr1YlVt23BkFuoffAfeyiisaymhP5yZ8X
        nhHTleIkBJdUOkNHJCME2HO988BYgG3mCde3OLPZenZvJiBdPy9OYBXa3jpn8LEIMOP/lc
        Xmmw9q4Qk/RJIKgHnjiFjKwfcEmmUo8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-T692DJ9FPqK6du0vkEWOmw-1; Fri, 07 Jul 2023 13:22:22 -0400
X-MC-Unique: T692DJ9FPqK6du0vkEWOmw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 119CB185A794;
        Fri,  7 Jul 2023 17:22:22 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.164])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B97211454142;
        Fri,  7 Jul 2023 17:22:20 +0000 (UTC)
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
Subject: [PATCH v2 5/9] tracing/filters: Optimise cpumask vs cpumask filtering when user mask is a single CPU
Date:   Fri,  7 Jul 2023 18:21:51 +0100
Message-Id: <20230707172155.70873-6-vschneid@redhat.com>
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

Reuse do_filter_scalar_cpumask() when the input mask has a weight of one.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/trace/trace_events_filter.c | 35 +++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 3009d0c61b532..2fe65ddeb34ef 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -70,6 +70,7 @@ enum filter_pred_fn {
 	FILTER_PRED_FN_CPU,
 	FILTER_PRED_FN_CPU_CPUMASK,
 	FILTER_PRED_FN_CPUMASK,
+	FILTER_PRED_FN_CPUMASK_CPU,
 	FILTER_PRED_FN_FUNCTION,
 	FILTER_PRED_FN_,
 	FILTER_PRED_TEST_VISITED,
@@ -957,6 +958,22 @@ static int filter_pred_cpumask(struct filter_pred *pred, void *event)
 	return do_filter_cpumask(pred->op, mask, cmp);
 }
 
+/* Filter predicate for cpumask field vs user-provided scalar  */
+static int filter_pred_cpumask_cpu(struct filter_pred *pred, void *event)
+{
+	u32 item = *(u32 *)(event + pred->offset);
+	int loc = item & 0xffff;
+	const struct cpumask *mask = (event + loc);
+	unsigned int cpu = pred->val;
+
+	/*
+	 * This inverts the usual usage of the function (field is first element,
+	 * user parameter is second), but that's fine because the (scalar, mask)
+	 * operations used are symmetric.
+	 */
+	return do_filter_scalar_cpumask(pred->op, cpu, mask);
+}
+
 /* Filter predicate for COMM. */
 static int filter_pred_comm(struct filter_pred *pred, void *event)
 {
@@ -1453,6 +1470,8 @@ static int filter_pred_fn_call(struct filter_pred *pred, void *event)
 		return filter_pred_cpu_cpumask(pred, event);
 	case FILTER_PRED_FN_CPUMASK:
 		return filter_pred_cpumask(pred, event);
+	case FILTER_PRED_FN_CPUMASK_CPU:
+		return filter_pred_cpumask_cpu(pred, event);
 	case FILTER_PRED_FN_FUNCTION:
 		return filter_pred_function(pred, event);
 	case FILTER_PRED_TEST_VISITED:
@@ -1666,6 +1685,7 @@ static int parse_pred(const char *str, void *data,
 
 	} else if (!strncmp(str + i, "CPUS", 4)) {
 		unsigned int maskstart;
+		bool single;
 		char *tmp;
 
 		switch (field->filter_type) {
@@ -1724,8 +1744,21 @@ static int parse_pred(const char *str, void *data,
 
 		/* Move along */
 		i++;
+
+		/*
+		 * Optimisation: if the user-provided mask has a weight of one
+		 * then we can treat it as a scalar input.
+		 */
+		single = cpumask_weight(pred->mask) == 1;
+		if (single && field->filter_type == FILTER_CPUMASK) {
+			pred->val = cpumask_first(pred->mask);
+			kfree(pred->mask);
+		}
+
 		if (field->filter_type == FILTER_CPUMASK) {
-			pred->fn_num = FILTER_PRED_FN_CPUMASK;
+			pred->fn_num = single ?
+				FILTER_PRED_FN_CPUMASK_CPU :
+				FILTER_PRED_FN_CPUMASK;
 		} else if (field->filter_type == FILTER_CPU) {
 			pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
 		} else {
-- 
2.31.1

