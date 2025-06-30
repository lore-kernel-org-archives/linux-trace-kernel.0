Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295FC2E7F31
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Jun 2025 19:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751313213; cv=none; b=Ir4mhrF8ngL76JH/wWtp+gMOHFLXtJ9pflud7+YpYjaR39+r0eGCfsbs++iA6JuQILhguqPr+DR6AUM3vlKtPF18kaP69ICShsYGKDXKrzf3Jyp2UKiLrRrRtt+j0tg9/2QkJQrNC0n3TMGGHDDlnVk8Sr+EvENZX/zf/5qCLYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751313213; c=relaxed/simple;
	bh=rysp77v0m2sVwjmkmSgFE5NF/p+PFjSMmBieBHk2lsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ks6o8Q7zvVUuFhqMEgYFYZp5ltY4hycN179HxvHkOs26D4YfeINJfSG4MVs6G4pWdtulcxobUBqb2p7Y+nRv0ZIBFHFOXF/p1BanrBab9A2l+z6na5uvGR7dYH0JpK7vyXAsdrzEAL9p9p9eD0ByY1m1s/N8EbVeaW+StviVmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=alxL+S+F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alxL+S+F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751313211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CXZLUBjW746zrWrHi02YgbbLPfAn2nFzYFn+w9qge5E=;
	b=alxL+S+FesKVInxMnZ1EgQ1CduBjvcFcAVtXy6I1S5dCjQCjhsI9PQZmlEBDxQxaMXl9i3
	u48nyKQHrbPkFN/d19M/RSiAcT79roC2zS1S3fGFr1fPZ9wha2yzXD9KXIn+N/+oQFVma4
	1XUwd6b9/Ugf6JLG12NLDufutQa8Zjo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-lfhuDkGWOYOpv_KEXkk15g-1; Mon,
 30 Jun 2025 15:53:27 -0400
X-MC-Unique: lfhuDkGWOYOpv_KEXkk15g-1
X-Mimecast-MFC-AGG-ID: lfhuDkGWOYOpv_KEXkk15g_1751313205
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B08318DA5C2;
	Mon, 30 Jun 2025 19:53:25 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.65.29])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D2BA19560A7;
	Mon, 30 Jun 2025 19:53:18 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v2 1/2] trace/preemptirq: reduce overhead of irq_enable/disable tracepoints
Date: Mon, 30 Jun 2025 16:52:38 -0300
Message-ID: <20250630195243.701516-2-wander@redhat.com>
In-Reply-To: <20250630195243.701516-1-wander@redhat.com>
References: <20250630195243.701516-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The irqsoff tracer is rarely enabled in production systems due to the
non-negligible overhead it introduces—even when unused. This is caused
by how trace_hardirqs_on/off() are always invoked in
local_irq_enable/disable(), evaluate the tracepoint static key.

This patch reduces the overhead in the common case where the tracepoint
is disabled by performing the static key check earlier, avoiding the
call to trace_hardirqs_on/off() entirely.

This makes the impact of disabled preemptirq IRQ tracing negligible in
performance-sensitive environments.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/irqflags.h        | 30 +++++++++++++++++++++---------
 kernel/trace/trace_preemptirq.c |  3 +++
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 57b074e0cfbb..40e456fa3d10 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -17,6 +17,7 @@
 #include <linux/cleanup.h>
 #include <asm/irqflags.h>
 #include <asm/percpu.h>
+#include <linux/tracepoint-defs.h>
 
 struct task_struct;
 
@@ -197,9 +198,17 @@ extern void warn_bogus_irq_restore(void);
  */
 #ifdef CONFIG_TRACE_IRQFLAGS
 
+DECLARE_TRACEPOINT(irq_enable);
+DECLARE_TRACEPOINT(irq_disable);
+
+#define __trace_enabled(tp)				\
+	(IS_ENABLED(CONFIG_PROVE_LOCKING) ||		\
+	 tracepoint_enabled(tp))
+
 #define local_irq_enable()				\
 	do {						\
-		trace_hardirqs_on();			\
+		if (__trace_enabled(irq_enable))	\
+			trace_hardirqs_on();		\
 		raw_local_irq_enable();			\
 	} while (0)
 
@@ -207,31 +216,34 @@ extern void warn_bogus_irq_restore(void);
 	do {						\
 		bool was_disabled = raw_irqs_disabled();\
 		raw_local_irq_disable();		\
-		if (!was_disabled)			\
+		if (__trace_enabled(irq_disable) &&	\
+		    !was_disabled)			\
 			trace_hardirqs_off();		\
 	} while (0)
 
 #define local_irq_save(flags)				\
 	do {						\
 		raw_local_irq_save(flags);		\
-		if (!raw_irqs_disabled_flags(flags))	\
+		if (__trace_enabled(irq_disable) &&	\
+		    !raw_irqs_disabled_flags(flags))	\
 			trace_hardirqs_off();		\
 	} while (0)
 
 #define local_irq_restore(flags)			\
 	do {						\
-		if (!raw_irqs_disabled_flags(flags))	\
+		if (__trace_enabled(irq_enable) &&	\
+		    !raw_irqs_disabled_flags(flags))	\
 			trace_hardirqs_on();		\
 		raw_local_irq_restore(flags);		\
 	} while (0)
 
-#define safe_halt()				\
-	do {					\
-		trace_hardirqs_on();		\
-		raw_safe_halt();		\
+#define safe_halt()					\
+	do {						\
+		if (__trace_enabled(irq_enable))	\
+			trace_hardirqs_on();		\
+		raw_safe_halt();			\
 	} while (0)
 
-
 #else /* !CONFIG_TRACE_IRQFLAGS */
 
 #define local_irq_enable()	do { raw_local_irq_enable(); } while (0)
diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index 0c42b15c3800..90ee65db4516 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -111,6 +111,9 @@ void trace_hardirqs_off(void)
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
 NOKPROBE_SYMBOL(trace_hardirqs_off);
+
+EXPORT_TRACEPOINT_SYMBOL(irq_disable);
+EXPORT_TRACEPOINT_SYMBOL(irq_enable);
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
 #ifdef CONFIG_TRACE_PREEMPT_TOGGLE
-- 
2.50.0

