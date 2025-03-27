Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C497A155C83;
	Thu, 27 Mar 2025 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743090503; cv=none; b=E3Lxf02vTVn6NxgShzG2YzfxDgVLxHZ4vWmvuxOskRU1incdG6XV5E/MQqjYc7jK88kTP15I995ca+gH2CVxOL1XsQH9kKOfq7KacQO3+O5Yu0JEAGIK2Z2tP2j7iw2zZR1+iW5tR/UrWUUXy5BB11NPEU6p7PsqJhG2YyxULr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743090503; c=relaxed/simple;
	bh=47j3I74ks2/O4s0BYb1TImz8jQ4IkN1cpagyuQxWYLA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=s+VxkusMMxTsRRQngh2kPZTjqLvOCexUwsNx3IE+fIR7f1Nd/uPvZUOY3T3HeoNMdedn72bTGKIE7H+8QukRIT10FJEv6AakzSugxE9ezyOM/MT8V8xnTPLKAGPU9R0nF7K6cTCE/v60Ws1sP74uyP/MDI5azycv1qwtvFMuzhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E94C4CEDD;
	Thu, 27 Mar 2025 15:48:22 +0000 (UTC)
Date: Thu, 27 Mar 2025 11:49:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Libo Chen <libo.chen@oracle.com>
Subject: [PATCH] tracing: Verify event formats that have "%*p.."
Message-ID: <20250327114911.2c713511@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The trace event verifier checks the formats of trace events to make sure
that they do not point at memory that is not in the trace event itself or
in data that will never be freed. If an event references data that was
allocated when the event triggered and that same data is freed before the
event is read, then the kernel can crash by reading freed memory.

The verifier runs at boot up (or module load) and scans the print formats
of the events and checks their arguments to make sure that dereferenced
pointers are safe. If the format uses "%*p.." the verifier will ignore it,
and that could be dangerous. Cover this case as well.

Also add to the sample code a use case of "%*pbl".

Link: https://lore.kernel.org/all/bcba4d76-2c3f-4d11-baf0-02905db953dd@oracle.com/

Reported-by: Libo Chen <libo.chen@oracle.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c                | 7 +++++++
 samples/trace_events/trace-events-sample.h | 8 ++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 7b3ef1d26167..34e7b4af9f88 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -470,6 +470,7 @@ static void test_event_printk(struct trace_event_call *call)
 			case '%':
 				continue;
 			case 'p':
+ do_pointer:
 				/* Find dereferencing fields */
 				switch (fmt[i + 1]) {
 				case 'B': case 'R': case 'r':
@@ -498,6 +499,12 @@ static void test_event_printk(struct trace_event_call *call)
 						continue;
 					if (fmt[i + j] == '*') {
 						star = true;
+						/* Handle %*pbl case */
+						if (!j && fmt[i + 1] == 'p') {
+							arg++;
+							i++;
+							goto do_pointer;
+						}
 						continue;
 					}
 					if ((fmt[i + j] == 's')) {
diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 999f78d380ae..0622c9e3f2be 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -319,7 +319,8 @@ TRACE_EVENT(foo_bar,
 		__assign_cpumask(cpum, cpumask_bits(mask));
 	),
 
-	TP_printk("foo %s %d %s %s %s %s %s %s (%s) (%s) %s", __entry->foo, __entry->bar,
+	TP_printk("foo %s %d %s %s %s %s %s %s (%s) (%s) %s [%d] %*pbl",
+		  __entry->foo, __entry->bar,
 
 /*
  * Notice here the use of some helper functions. This includes:
@@ -370,7 +371,10 @@ TRACE_EVENT(foo_bar,
 
 		  __get_str(str), __get_str(lstr),
 		  __get_bitmask(cpus), __get_cpumask(cpum),
-		  __get_str(vstr))
+		  __get_str(vstr),
+	         __get_dynamic_array_len(cpus),
+	         __get_dynamic_array_len(cpus),
+	         __get_dynamic_array(cpus))
 );
 
 /*
-- 
2.47.2

