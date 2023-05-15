Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99F4C77B7D
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 15 May 2023 18:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243410AbjEOScc (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 15 May 2023 14:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243627AbjEOScU (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:32:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D60189B5
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 May 2023 11:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684175485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DcXHSTN5+9crGs0d1ByPA1BOvgEKNfvLeXclyFifNvo=;
        b=MzgbVqi8vS8cM52gKgdHsLVYDWSb/AeouATFOwHtfN5KQNz9pRrDJXt2wqMAQCVRFIF2pE
        atCgvtS13cxs3svPtNsS4KdzzygCdhyIq/VOQ0YOw3dTM+yo1ztH2MEPvsw5eWg+8yGhth
        ylCJSfCL0TAsM8FduDhXzYu/bcvr5Ek=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-N9b2xPWSMSmY6EtcTczs3w-1; Mon, 15 May 2023 14:31:24 -0400
X-MC-Unique: N9b2xPWSMSmY6EtcTczs3w-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-54f618e51f7so2437582eaf.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 May 2023 11:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684175483; x=1686767483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcXHSTN5+9crGs0d1ByPA1BOvgEKNfvLeXclyFifNvo=;
        b=aTe5Fgm1Pb5C7eVBoCEV6QqF0u6gfAp1Cqk8tPz/t9xlZM5gOC8SAm7WJGfNahc1Sq
         ggsjZ4PyZ4Jm6nZI/jC82p05ksfwonfuWee8qcEq4oKH3EeYeZ4fTKABc8uwEqed6d2R
         1El+0ZRXQDyWmZhoDoB8NmMGpHCnT0pRr6YltGE0q54pQxdGAEGM7QYawVdGEDpAfYJJ
         dwEgnBca6YY+txOj1r3oeLEpg+oxZ6Ul1DAhU4IQKT7MAVQkX3vVe0lKwRmR99kCjAm6
         LhyWZ2aIOD1FT5np/sA41Rvpcb32DAN2DPw/M2QgVvZgb1O4p8M7IDX8EQPExzKSq1GM
         1XGg==
X-Gm-Message-State: AC+VfDzyed0gPLEMDt3ZABkTmsRQtXCtcqjWNra9OC5yF4C1xnBq/Sdc
        ttKh2UliFMNhWDAakf3EUj4fC54v7d8R3aAsDFwk6KgjacmfQqeUOxS/UUl1Rjwo7sryhdIAxLv
        KSlwz0G9dV4C7shSfb9yE47FghTdCT7RG
X-Received: by 2002:a05:6871:40f:b0:187:c066:a395 with SMTP id d15-20020a056871040f00b00187c066a395mr16141518oag.0.1684175483573;
        Mon, 15 May 2023 11:31:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7FlCRobycL533zZedNWGUsksKyld4HpV5MvQyWK6XXNRovrdvGIesK3IN2aMnipjczwWzz7Q==
X-Received: by 2002:a05:6871:40f:b0:187:c066:a395 with SMTP id d15-20020a056871040f00b00187c066a395mr16141506oag.0.1684175483343;
        Mon, 15 May 2023 11:31:23 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a803:46cc:5b68:5c23:dd7a:8cb3])
        by smtp.gmail.com with ESMTPSA id ea20-20020a056870071400b001964dc3dadesm6094075oab.45.2023.05.15.11.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 11:31:22 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH v4 1/2] trace,smp: Add tracepoints around remotelly called functions
Date:   Mon, 15 May 2023 15:30:45 -0300
Message-Id: <20230515183045.654199-2-leobras@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515183045.654199-1-leobras@redhat.com>
References: <20230515183045.654199-1-leobras@redhat.com>
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
 include/trace/events/smp.h | 45 ++++++++++++++++++++++++++++++++++++++
 kernel/smp.c               | 25 ++++++++++++++++-----
 2 files changed, 64 insertions(+), 6 deletions(-)
 create mode 100644 include/trace/events/smp.h

diff --git a/include/trace/events/smp.h b/include/trace/events/smp.h
new file mode 100644
index 000000000000..547f536e7ecd
--- /dev/null
+++ b/include/trace/events/smp.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM smp
+
+#if !defined(_TRACE_SMP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SMP_H
+
+#include <linux/tracepoint.h>
+
+/*
+ * Tracepoints for a function which is called as an effect of smp_call_function.*
+ */
+DECLARE_EVENT_CLASS(csd_function,
+
+	TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
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
+	TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
+	TP_ARGS(func, csd)
+);
+
+DEFINE_EVENT(csd_function, csd_function_exit,
+	TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
+	TP_ARGS(func, csd)
+);
+
+#endif /* _TRACE_SMP_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/smp.c b/kernel/smp.c
index 919387be6d4e..eecdd452619c 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -27,6 +27,9 @@
 #include <linux/jump_label.h>
 
 #include <trace/events/ipi.h>
+#define CREATE_TRACE_POINTS
+#include <trace/events/smp.h>
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
+		csd_do_func(func, info, csd);
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
2.40.1

