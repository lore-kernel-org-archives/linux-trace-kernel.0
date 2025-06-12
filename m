Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0F415624B;
	Thu, 12 Jun 2025 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749735494; cv=none; b=gbMsuDgGtY6CysxolW18586INq/AH+5kQ9Mn7Jom5DwcB2ZtmKcQaWBRlAMPnLMpBuuOR4wv2h9RXj8e0JIjsc/8WYW8P6bxvxh7m23OahZfhsNwBnp9orWg8sac7SFLRUzVPrXCxn7rQzJboHa+3TrBOpNpaJiuuP+m8/ibRz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749735494; c=relaxed/simple;
	bh=szU490pY/xtwR8j/yoCyjtlrIVxHF7cdPSe2QLHVMf0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DUWjQCwqVOJB6oWm9CnMk8UpPIU0mM27pYfr10N+sFzpZEhiJSNBEYhOGFjF6uyAznGsNaq7GJUzZXn0f8xiNzU/lYDIkMt5yqtVH9KgqGezsglk7o1bhfpHZLzMHfHTdwepdMrPG3G1A/oyguDu9qT9146rWpgA34fNDm11a38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 6120E5B400;
	Thu, 12 Jun 2025 13:38:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 9E84A17;
	Thu, 12 Jun 2025 13:38:02 +0000 (UTC)
Date: Thu, 12 Jun 2025 09:38:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>, Valentin Schneider
 <vschneid@redhat.com>
Subject: [PATCH] tracing/ipi: Hide ARM specific IPI trace events from other
 architectures
Message-ID: <20250612093802.77cdcc9c@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 9E84A17
X-Stat-Signature: of9cdjmkm34d8mn47z5ss4s5f1kzzb3s
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18lwVEvWrQ8W0t+uSfL2Sw31sYeE07hWtU=
X-HE-Tag: 1749735482-515476
X-HE-Meta: U2FsdGVkX19RG2c28YS+jzUwsVxPN6BgeLy+uYYqrKJoCA8x2JMOxdz+yLPs6JOYVFsvo2WDoqefcjXvLPJLQr+hRDQT/414xh20Qb3K/kJb3YG+uavlhZD0braKYV289hiR4UbM14bPtouqkQdlwf5Jr0rE0UzCeWSoJMMGdQ+0XKO5kJ9sEvqWV+tTYwKJhvuz8mKJhlDncHRMG7y26U13rlilD/nop9NTEo+ClNb5SUOY5PSmNCmlr+1cnOBDoNYpeIaV50pACSKzq87z7pD//TF/37kU956X9NggJCL8piYM7ziXet6smsU5Q+4IUEuF/SxizyHm+KlZlTdXPYSQ1TPoSUWI2JUIeK4STP3JuyUd4Lnuidj04YzdRP1M

From: Steven Rostedt <rostedt@goodmis.org>

The IPI trace events ipi_raise, ipi_handler, ipi_entry and ipi_exit are
only used by the arm and arm64 architectures. As each trace event can take
up to 5K in size, regardless if they are used or not, add #ifdef around
these events so that they are only defined for arm and they do not waste
memory in other architectures.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Note, I'll be adding code soon that will make unused events cause a warning.

 include/trace/events/ipi.h | 58 ++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/include/trace/events/ipi.h b/include/trace/events/ipi.h
index 3de9bfc982ce..e5c7998f636c 100644
--- a/include/trace/events/ipi.h
+++ b/include/trace/events/ipi.h
@@ -7,34 +7,6 @@
 
 #include <linux/tracepoint.h>
 
-/**
- * ipi_raise - called when a smp cross call is made
- *
- * @mask: mask of recipient CPUs for the IPI
- * @reason: string identifying the IPI purpose
- *
- * It is necessary for @reason to be a static string declared with
- * __tracepoint_string.
- */
-TRACE_EVENT(ipi_raise,
-
-	TP_PROTO(const struct cpumask *mask, const char *reason),
-
-	TP_ARGS(mask, reason),
-
-	TP_STRUCT__entry(
-		__bitmask(target_cpus, nr_cpumask_bits)
-		__field(const char *, reason)
-	),
-
-	TP_fast_assign(
-		__assign_bitmask(target_cpus, cpumask_bits(mask), nr_cpumask_bits);
-		__entry->reason = reason;
-	),
-
-	TP_printk("target_mask=%s (%s)", __get_bitmask(target_cpus), __entry->reason)
-);
-
 TRACE_EVENT(ipi_send_cpu,
 
 	TP_PROTO(const unsigned int cpu, unsigned long callsite, void *callback),
@@ -79,6 +51,35 @@ TRACE_EVENT(ipi_send_cpumask,
 		  __get_cpumask(cpumask), __entry->callsite, __entry->callback)
 );
 
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+/**
+ * ipi_raise - called when a smp cross call is made
+ *
+ * @mask: mask of recipient CPUs for the IPI
+ * @reason: string identifying the IPI purpose
+ *
+ * It is necessary for @reason to be a static string declared with
+ * __tracepoint_string.
+ */
+TRACE_EVENT(ipi_raise,
+
+	TP_PROTO(const struct cpumask *mask, const char *reason),
+
+	TP_ARGS(mask, reason),
+
+	TP_STRUCT__entry(
+		__bitmask(target_cpus, nr_cpumask_bits)
+		__field(const char *, reason)
+	),
+
+	TP_fast_assign(
+		__assign_bitmask(target_cpus, cpumask_bits(mask), nr_cpumask_bits);
+		__entry->reason = reason;
+	),
+
+	TP_printk("target_mask=%s (%s)", __get_bitmask(target_cpus), __entry->reason)
+);
+
 DECLARE_EVENT_CLASS(ipi_handler,
 
 	TP_PROTO(const char *reason),
@@ -127,6 +128,7 @@ DEFINE_EVENT(ipi_handler, ipi_exit,
 
 	TP_ARGS(reason)
 );
+#endif /* defined(CONFIG_ARM) || defined(CONFIG_ARM64) */
 
 #endif /* _TRACE_IPI_H */
 
-- 
2.47.2

