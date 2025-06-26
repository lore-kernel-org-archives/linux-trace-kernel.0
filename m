Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286BA2EAB66
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Jun 2025 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947680; cv=none; b=OsKi/5RKZ1+lMfaEqSXWF6Lih1e796C21tZDiyDrcyr7K+ZYpNZE+IYl5aOEhTeHspb6bimDuqi0fLQew5AXEi2CdrkOI5zIZQK6GPitYShno8gnAZzqDJJ2PcDkyWwn1NtWgfyiMnnK5U/6ElE/DVAAORB3/G7sUVPNYhJ1V3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947680; c=relaxed/simple;
	bh=05qRlITEeVufiSoFd2KryeXWiRNzVpA6+iPegXXOeVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XD3l1nJgUgvBcsrrh1JQFScloQB0sbb6fSfXAV6Jeg9X/onWK9GH/qaEXc6INEVUJnTd5ikotp9BDDWLsIj5h92TmFVC/s7dNrPsKXE4Fz0FepNYw/NQPN0CNLSNlrGQmk63utZDIpBKd7fEbCUDziAJK5gd5vx5AISysbc9vVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S0BbwLa7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0BbwLa7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750947676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w1ag8oa4qWQl60jCaAXgmy6offy0L6bYu4nDEDKkM/M=;
	b=S0BbwLa7mlRo1PzI659VubfbCuQMJTi9SoUuPR2OdDu7rZPIGXCN4V2CdfshjtSzAg64VA
	G+k+UEa6tbbg6m718MpT7iYgTlPs+rhy/WW4+me2Rh1M9E0PRryBSHd1xlIxkCmKLgFMgv
	lc7W6BUXAPlHjX/YJfWMkisSn2IWTI8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-o0fBIu3KPguISuhHfeOLQg-1; Thu,
 26 Jun 2025 10:21:10 -0400
X-MC-Unique: o0fBIu3KPguISuhHfeOLQg-1
X-Mimecast-MFC-AGG-ID: o0fBIu3KPguISuhHfeOLQg_1750947667
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0085E1883815;
	Thu, 26 Jun 2025 14:20:47 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.64.203])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7B4B618046C6;
	Thu, 26 Jun 2025 14:20:39 +0000 (UTC)
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
	Boqun Feng <boqun.feng@gmail.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Wander Lairson Costa <wander@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 1/2] trace/preemptirq: reduce overhead of irq_enable/disable tracepoints
Date: Thu, 26 Jun 2025 11:20:09 -0300
Message-ID: <20250626142017.26372-2-wander@redhat.com>
In-Reply-To: <20250626142017.26372-1-wander@redhat.com>
References: <20250626142017.26372-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
 include/linux/irqflags.h        | 25 +++++++++++++++++--------
 kernel/trace/trace_preemptirq.c |  3 +++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 57b074e0cfbb..54f931db7e3b 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -17,6 +17,7 @@
 #include <linux/cleanup.h>
 #include <asm/irqflags.h>
 #include <asm/percpu.h>
+#include <linux/tracepoint-defs.h>
 
 struct task_struct;
 
@@ -197,9 +198,13 @@ extern void warn_bogus_irq_restore(void);
  */
 #ifdef CONFIG_TRACE_IRQFLAGS
 
+DECLARE_TRACEPOINT(irq_enable);
+DECLARE_TRACEPOINT(irq_disable);
+
 #define local_irq_enable()				\
 	do {						\
-		trace_hardirqs_on();			\
+		if (tracepoint_enabled(irq_enable))	\
+			trace_hardirqs_on();		\
 		raw_local_irq_enable();			\
 	} while (0)
 
@@ -207,28 +212,32 @@ extern void warn_bogus_irq_restore(void);
 	do {						\
 		bool was_disabled = raw_irqs_disabled();\
 		raw_local_irq_disable();		\
-		if (!was_disabled)			\
+		if (tracepoint_enabled(irq_disable) &&	\
+		    !was_disabled)			\
 			trace_hardirqs_off();		\
 	} while (0)
 
 #define local_irq_save(flags)				\
 	do {						\
 		raw_local_irq_save(flags);		\
-		if (!raw_irqs_disabled_flags(flags))	\
+		if (tracepoint_enabled(irq_disable) &&	\
+		    !raw_irqs_disabled_flags(flags))	\
 			trace_hardirqs_off();		\
 	} while (0)
 
 #define local_irq_restore(flags)			\
 	do {						\
-		if (!raw_irqs_disabled_flags(flags))	\
+		if (tracepoint_enabled(irq_enable) &&	\
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
+		if (tracepoint_enabled(irq_enable))	\
+			trace_hardirqs_on();		\
+		raw_safe_halt();			\
 	} while (0)
 
 
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

