Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0F9EB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 15 Jun 2023 07:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244342AbjFOHB2 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 15 Jun 2023 03:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244478AbjFOHBV (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:01:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55E4198D
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686812438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tWug6tK250qyQQCYO8fMKWJIjS1otJVNG8Ic8LjsM4w=;
        b=B4/Oxpz8NPZ7E5eZtE8Gc3K+aZpAD9xTzew36PrJE5cGSCr+N8BMChXDVAK3eoed1JfudT
        o5FliXANT1nP98ebGIA9YJOovHLm0NTE6G1ddGANmvCL30Vnaexx5nvPojOJPi2zsPOBgE
        hxnSAt9MAP+wMKDK2AnIfjHgD5olmu4=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-6QejhJFVPM6OshINmQD7CA-1; Thu, 15 Jun 2023 03:00:37 -0400
X-MC-Unique: 6QejhJFVPM6OshINmQD7CA-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6b2ac1fe3d6so5838077a34.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686812436; x=1689404436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWug6tK250qyQQCYO8fMKWJIjS1otJVNG8Ic8LjsM4w=;
        b=AV/nFBdLg0PjpvISZgGEz1LFntKPPmCEGfWY5E1q+WbsXZz0QV5lbn3NyDAaaMwYMc
         JMN0+hXaWObZGh3Q799PjhdCWDS1ElLV6aGmUf+pO8BOwd/cnm+Y3kuFJOUwHQLo9UUi
         IlzU14wIWtWdDrFKjRQqVJN4QfOwy/B9oqZUOAhYVqK2R3oyrZ4mlSxY+Uei69mm1QEm
         aZp9/3hrnNJ3xaLBCHO9NlszJJB2b5XMTswsHyjYItsg5RgThoETSZdN0QbO4KjlJvj+
         rdtm/vaR25cZtQegBbKtbuvsdpM1+xpENxIu8WnE41kNkyEtQGconqRpuMG71F2LZ8Og
         dncA==
X-Gm-Message-State: AC+VfDxMP0tvT2Biax93d+MnVQUPVmGplcRkn8Z1CNFTwPcFm6uoc4bC
        L0/y/kk6vNOp+7SSJ7o5O+7GE2VvNHQv/zt5TSaX9Bm/UqWj8Txm9rMwuNXh7VAYHkth3SDPQuK
        toxSCF/bDi3CeJZ/eEyZKd+VE8rE+OOyq
X-Received: by 2002:a05:6830:10d5:b0:6b0:a7f8:aef3 with SMTP id z21-20020a05683010d500b006b0a7f8aef3mr14682454oto.25.1686812436207;
        Thu, 15 Jun 2023 00:00:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5/Pe39HUBrfVOWKfPiOSlYTCdt0+Mvaw05lad9KQQ6R9Ij0haub1MnBrBtdB77e23r6sRdnQ==
X-Received: by 2002:a05:6830:10d5:b0:6b0:a7f8:aef3 with SMTP id z21-20020a05683010d500b006b0a7f8aef3mr14682438oto.25.1686812435989;
        Thu, 15 Jun 2023 00:00:35 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a800:60ac:48e:4eb0:11b4:f1e8])
        by smtp.gmail.com with ESMTPSA id d4-20020a0568301b6400b006b2b51fd2ebsm6472317ote.81.2023.06.15.00.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 00:00:35 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH v5 1/2] trace,smp: Add tracepoints around remotelly called functions
Date:   Thu, 15 Jun 2023 03:59:45 -0300
Message-ID: <20230615065944.188876-5-leobras@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230615065944.188876-3-leobras@redhat.com>
References: <20230615065944.188876-3-leobras@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

The recently added ipi_send_{cpu,cpumask} tracepoints allow finding sources
of IPIs targeting CPUs running latency-sensitive applications.

For NOHZ_FULL CPUs, all IPIs are interference, and those tracepoints are
sufficient to find them and work on getting rid of them. In some setups
however, not *all* IPIs are to be suppressed, but long-running IPI
callbacks can still be problematic.

Add a pair of tracepoints to mark the start and end of processing a CSD IPI
callback, similar to what exists for softirq, workqueue or timer callbacks.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 include/trace/events/csd.h | 45 ++++++++++++++++++++++++++++++++++++++
 kernel/smp.c               | 25 ++++++++++++++++-----
 2 files changed, 64 insertions(+), 6 deletions(-)
 create mode 100644 include/trace/events/csd.h

diff --git a/include/trace/events/csd.h b/include/trace/events/csd.h
new file mode 100644
index 000000000000..af1df5200ae6
--- /dev/null
+++ b/include/trace/events/csd.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM csd
+
+#if !defined(_TRACE_CSD_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_CSD_H
+
+#include <linux/tracepoint.h>
+
+/*
+ * Tracepoints for a function which is called as an effect of smp_call_function.*
+ */
+DECLARE_EVENT_CLASS(csd_function,
+
+	TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
+
+	TP_ARGS(func, csd),
+
+	TP_STRUCT__entry(
+		__field(void *,	func)
+		__field(void *,	csd)
+	),
+
+	TP_fast_assign(
+		__entry->func	= func;
+		__entry->csd	= csd;
+	),
+
+	TP_printk("func=%ps, csd=%p", __entry->func, __entry->csd)
+);
+
+DEFINE_EVENT(csd_function, csd_function_entry,
+	TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
+	TP_ARGS(func, csd)
+);
+
+DEFINE_EVENT(csd_function, csd_function_exit,
+	TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
+	TP_ARGS(func, csd)
+);
+
+#endif /* _TRACE_CSD_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/smp.c b/kernel/smp.c
index 919387be6d4e..7199b5a22043 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -27,6 +27,9 @@
 #include <linux/jump_label.h>
 
 #include <trace/events/ipi.h>
+#define CREATE_TRACE_POINTS
+#include <trace/events/csd.h>
+#undef CREATE_TRACE_POINTS
 
 #include "smpboot.h"
 #include "sched/smp.h"
@@ -121,6 +124,14 @@ send_call_function_ipi_mask(struct cpumask *mask)
 	arch_send_call_function_ipi_mask(mask);
 }
 
+static __always_inline void
+csd_do_func(smp_call_func_t func, void *info, struct __call_single_data *csd)
+{
+	trace_csd_function_entry(func, csd);
+	func(info);
+	trace_csd_function_exit(func, csd);
+}
+
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
 
 static DEFINE_STATIC_KEY_MAYBE(CONFIG_CSD_LOCK_WAIT_DEBUG_DEFAULT, csdlock_debug_enabled);
@@ -375,7 +386,7 @@ static int generic_exec_single(int cpu, call_single_data_t *csd)
 		csd_lock_record(csd);
 		csd_unlock(csd);
 		local_irq_save(flags);
-		func(info);
+		csd_do_func(func, info, NULL);
 		csd_lock_record(NULL);
 		local_irq_restore(flags);
 		return 0;
@@ -477,7 +488,7 @@ static void __flush_smp_call_function_queue(bool warn_cpu_offline)
 			}
 
 			csd_lock_record(csd);
-			func(info);
+			csd_do_func(func, info, csd);
 			csd_unlock(csd);
 			csd_lock_record(NULL);
 		} else {
@@ -508,7 +519,7 @@ static void __flush_smp_call_function_queue(bool warn_cpu_offline)
 
 				csd_lock_record(csd);
 				csd_unlock(csd);
-				func(info);
+				csd_do_func(func, info, csd);
 				csd_lock_record(NULL);
 			} else if (type == CSD_TYPE_IRQ_WORK) {
 				irq_work_single(csd);
@@ -522,8 +533,10 @@ static void __flush_smp_call_function_queue(bool warn_cpu_offline)
 	/*
 	 * Third; only CSD_TYPE_TTWU is left, issue those.
 	 */
-	if (entry)
-		sched_ttwu_pending(entry);
+	if (entry) {
+		csd = llist_entry(entry, typeof(*csd), node.llist);
+		csd_do_func(sched_ttwu_pending, entry, csd);
+	}
 }
 
 
@@ -816,7 +829,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		unsigned long flags;
 
 		local_irq_save(flags);
-		func(info);
+		csd_do_func(func, info, NULL);
 		local_irq_restore(flags);
 	}
 
-- 
2.41.0

