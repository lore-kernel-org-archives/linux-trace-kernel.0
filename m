Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E173AC4332F
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 10 Nov 2022 18:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiKJSB2 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 10 Nov 2022 13:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbiKJSAc (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:00:32 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8664C27A
        for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:00:23 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 8so1594244qka.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Et1X+XM5fz2xtP+ITAFoJHCq9rWg7jnFKDCEn93tI0w=;
        b=yd5jeI1hY/+LxyfHKPlQ3pdxEvZ2OvrqsusceNeDZmLDTsiz/CR/P3kDGFOuwtOIHG
         5k3Ga+baG6IjD9jXYUBg36KK4zn+XIwEia+/9LF2AloJaNRFqfagPRzF7toNZgsf6qpG
         +BVZc0fHtCgSltVBbMSGUS8ELKgOrR1D7NBOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Et1X+XM5fz2xtP+ITAFoJHCq9rWg7jnFKDCEn93tI0w=;
        b=j3dYE5CHp7zIjQ8p6iYE4gJBOfyybJEAoLV40L5P6OSRXZquAmeuo3ZI0Q8xfXqP+N
         gD9/hWxp5HbV43vypQfmcO60zUL3a/CZXnKlOU933SUynFgoTu928RgUh7pBIU4YPYDG
         Dk2E6XsQHMUe1RmaHStKJ1aQ13KtTFKWZaaqSfeIyVs+a25Ceg66xgjxmOfj+OOvC5n0
         j+gRKpl3HkqG63/C+po00eR7TyH/n3nfPVlhGPfjv+PI5w4HBFazLKA5fhHHAQvJ06Qc
         jooQp/wYu/4n03OafywvKILsURNL8JiSfToD5tyrVP2kcRTkHMSSD8IAz73Rk8k/7SHm
         v1IA==
X-Gm-Message-State: ACrzQf2pvawZB69ZyLSnoVjWZGbeTdVtNEJKCf4n3gFlbKmtPfQinJpF
        cR1P2aXtBpqv/jUURnvLPtUpWg==
X-Google-Smtp-Source: AMsMyM5z27aXeY9xP52aJvvrW1WK+yuVG20PxCWmE67x+csLD1IWbZr5iVQ2z0iChlRjjA84POjlPQ==
X-Received: by 2002:a05:620a:1270:b0:6f8:1e94:ffbd with SMTP id b16-20020a05620a127000b006f81e94ffbdmr1527616qkl.539.1668103222860;
        Thu, 10 Nov 2022 10:00:22 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id r16-20020ae9d610000000b006ee7e223bb8sm12975962qkk.39.2022.11.10.10.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:00:22 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ross Zwisler <zwisler@google.com>
Subject: [PATCH v2] tracing: Dump instance traces into dmesg on ftrace_dump_on_oops
Date:   Thu, 10 Nov 2022 17:59:59 +0000
Message-Id: <20221110175959.3240475-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Currently ftrace only dumps the global trace buffer on an OOPs. For
debugging a production usecase, I'd like to dump instance traces as
well, into the kernel logs. The reason is we cannot use the global trace
buffer as it may be used for other purposes.

This patch adds support for dumping the trace buffer instances along
with the global trace buffer.

The instance traces are dumped first, and then the global trace buffer.

Cc: Ross Zwisler <zwisler@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/trace/trace.c | 67 ++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 28 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 47a44b055a1d..2cc75497d6d3 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9914,12 +9914,12 @@ trace_printk_seq(struct trace_seq *s)
 	trace_seq_init(s);
 }
 
-void trace_init_global_iter(struct trace_iterator *iter)
+void trace_init_iter_with_tr(struct trace_iterator *iter, struct trace_array *tr)
 {
-	iter->tr = &global_trace;
+	iter->tr = tr;
 	iter->trace = iter->tr->current_trace;
 	iter->cpu_file = RING_BUFFER_ALL_CPUS;
-	iter->array_buffer = &global_trace.array_buffer;
+	iter->array_buffer = &tr->array_buffer;
 
 	if (iter->trace && iter->trace->open)
 		iter->trace->open(iter);
@@ -9939,36 +9939,14 @@ void trace_init_global_iter(struct trace_iterator *iter)
 	iter->fmt_size = STATIC_FMT_BUF_SIZE;
 }
 
-void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
+void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode oops_dump_mode)
 {
-	/* use static because iter can be a bit big for the stack */
 	static struct trace_iterator iter;
-	static atomic_t dump_running;
-	struct trace_array *tr = &global_trace;
 	unsigned int old_userobj;
-	unsigned long flags;
 	int cnt = 0, cpu;
 
-	/* Only allow one dump user at a time. */
-	if (atomic_inc_return(&dump_running) != 1) {
-		atomic_dec(&dump_running);
-		return;
-	}
-
-	/*
-	 * Always turn off tracing when we dump.
-	 * We don't need to show trace output of what happens
-	 * between multiple crashes.
-	 *
-	 * If the user does a sysrq-z, then they can re-enable
-	 * tracing with echo 1 > tracing_on.
-	 */
-	tracing_off();
-
-	local_irq_save(flags);
-
 	/* Simulate the iterator */
-	trace_init_global_iter(&iter);
+	trace_init_iter_with_tr(&iter, tr);
 
 	for_each_tracing_cpu(cpu) {
 		atomic_inc(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
@@ -9993,7 +9971,10 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 		iter.cpu_file = RING_BUFFER_ALL_CPUS;
 	}
 
-	printk(KERN_TRACE "Dumping ftrace buffer:\n");
+	if (tr == &global_trace)
+		printk(KERN_TRACE "Dumping ftrace buffer:\n");
+	else
+		printk(KERN_TRACE "Dumping ftrace instance %s buffer:\n", tr->name);
 
 	/* Did function tracer already get disabled? */
 	if (ftrace_is_dead()) {
@@ -10041,6 +10022,36 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 	for_each_tracing_cpu(cpu) {
 		atomic_dec(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
 	}
+}
+
+void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
+{
+	/* use static because iter can be a bit big for the stack */
+	static atomic_t dump_running;
+	struct trace_array *tr;
+	unsigned long flags;
+
+	/* Only allow one dump user at a time. */
+	if (atomic_inc_return(&dump_running) != 1) {
+		atomic_dec(&dump_running);
+		return;
+	}
+
+	/*
+	 * Always turn off tracing when we dump.
+	 * We don't need to show trace output of what happens
+	 * between multiple crashes.
+	 *
+	 * If the user does a sysrq-z, then they can re-enable
+	 * tracing with echo 1 > tracing_on.
+	 */
+	tracing_off();
+	local_irq_save(flags);
+
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		ftrace_dump_one(tr, oops_dump_mode);
+	}
+
 	atomic_dec(&dump_running);
 	local_irq_restore(flags);
 }
-- 
2.38.1.493.g58b659f92b-goog

