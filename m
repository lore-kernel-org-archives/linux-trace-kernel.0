Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AEB270548;
	Mon,  5 May 2025 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480148; cv=none; b=nYUv7NwF80djl6aNFf8ZNVpxG+M/31YBIg3LV/ntVRHYxM23d+CabS0sT1y8+BdXMLRejjI5DbEkVR51fHoL/jAAYgRESeHCRWSmGWVKbvRQ+Y+fs/73+2OMgXXZU6rf+SNyj1YC0L8/SmAE/NDjQEL2swlmxlQpChsPsfb4rrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480148; c=relaxed/simple;
	bh=eGoXC6PxV7+R1ceOCIV5HnJX5yRFgYWLtD6ouKR5GnQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GwBLsl9NhMA2kYyv7P2k+h9nWQjMqkyY27FfVPxzxxGlY7gz8X8weDu+U7PTN4dhUfCd6dLfA2OjV9NmnFHqhn3MSqeMLVKLW1uKLZpzQPWVA5JM2VU+/29pFJXFB6T587jtMxlRE6g+HFjE+vNq3B78qK0g/MIkpOufmqRyZfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D349C4CEEE;
	Mon,  5 May 2025 21:22:28 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uC3Gk-00000000yBG-3YLk;
	Mon, 05 May 2025 17:22:34 -0400
Message-ID: <20250505212234.696945463@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 05 May 2025 17:21:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 01/13] tracing/mmiotrace: Remove reference to unused per CPU data pointer
References: <20250505212104.986494754@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The mmiotracer referenced the per CPU array_buffer->data descriptor but
never actually used it. Remove the references to it.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_mmiotrace.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
index ba5858866b2f..c706544be60c 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -291,7 +291,6 @@ __init static int init_mmio_trace(void)
 device_initcall(init_mmio_trace);
 
 static void __trace_mmiotrace_rw(struct trace_array *tr,
-				struct trace_array_cpu *data,
 				struct mmiotrace_rw *rw)
 {
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
@@ -315,12 +314,10 @@ static void __trace_mmiotrace_rw(struct trace_array *tr,
 void mmio_trace_rw(struct mmiotrace_rw *rw)
 {
 	struct trace_array *tr = mmio_trace_array;
-	struct trace_array_cpu *data = per_cpu_ptr(tr->array_buffer.data, smp_processor_id());
-	__trace_mmiotrace_rw(tr, data, rw);
+	__trace_mmiotrace_rw(tr, rw);
 }
 
 static void __trace_mmiotrace_map(struct trace_array *tr,
-				struct trace_array_cpu *data,
 				struct mmiotrace_map *map)
 {
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
@@ -344,12 +341,7 @@ static void __trace_mmiotrace_map(struct trace_array *tr,
 void mmio_trace_mapping(struct mmiotrace_map *map)
 {
 	struct trace_array *tr = mmio_trace_array;
-	struct trace_array_cpu *data;
-
-	preempt_disable();
-	data = per_cpu_ptr(tr->array_buffer.data, smp_processor_id());
-	__trace_mmiotrace_map(tr, data, map);
-	preempt_enable();
+	__trace_mmiotrace_map(tr, map);
 }
 
 int mmio_trace_printk(const char *fmt, va_list args)
-- 
2.47.2


