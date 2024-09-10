Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424991E493;
	Tue, 10 Sep 2024 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725975419; cv=none; b=JF7XVlAD9CqurTbVsn09NY9ydfDmJFnvesbF3Tfb/NU2QKqC5Ljqa2xFNjFTGUz7xc14duAU3+e4KAImSe7uJZvHoFHOpWm+AF+6IIuRqkaQPwtUBoHjA4K3QhWSb+j+7RMzZ2plIeacl6xBphWq04sAOX62TvL4gMwVk6v2D7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725975419; c=relaxed/simple;
	bh=MRyIuk75cNycoDIWEe25HknN6HDBEFn4cs9EvCXb/Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hjvAK9tkgjODCWrZd2FxHQwOIPoOJJI4P2Eeixr8sbzwwad/zI4vybV9jQO4yJMtpc4Xvjm9L+L3Z5q/YiCMdlx1sgRe23ICfMJujcgBec4erZ+sMKGc73KOQbkZzU04gneABuOnZ2Euxz+vz1qJVodFBrydMLcDm/Wo4PWVm7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vhg3qb3U; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vhg3qb3U"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725975414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DsYhFPpwGXfFBCLrjay/9yjiae/aL9oR9b1RDsnzoKs=;
	b=vhg3qb3U1s5Cijl0B7jnzV5tBpyJNIvlWY0cbpiMjPzZGNOECp72ue4Km5jPRrAK86Lf+Y
	QO+qF14kEIb8D59sYMBhcm8PNjfBo9Htyc6SPTPtsQeWg2jcOW6Mq7ARa7K82ut+N8sk/J
	DQ7qKfjwv9JLwtlkVrTs1L8qRpHZ97o=
From: Jeff Xie <jeff.xie@linux.dev>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiehuan09@gmail.com,
	dolinux.peng@gmail.com,
	chensong_2000@189.cn,
	Jeff Xie <jeff.xie@linux.dev>
Subject: [PATCH v3] ftrace: Get the true parent ip for function tracer
Date: Tue, 10 Sep 2024 21:36:20 +0800
Message-ID: <20240910133620.19711-1-jeff.xie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When using both function tracer and function graph simultaneously,
it is found that function tracer sometimes captures a fake parent ip
(return_to_handler) instead of the true parent ip.

This issue is easy to reproduce. Below are my reproduction steps:

jeff-labs:~/bin # ./trace-net.sh

jeff-labs:~/bin # cat /sys/kernel/debug/tracing/instances/foo/trace | grep return_to_handler
    trace-net.sh-405     [001] ...2.    31.859501: avc_has_perm+0x4/0x190 <-return_to_handler+0x0/0x40
    trace-net.sh-405     [001] ...2.    31.859503: simple_setattr+0x4/0x70 <-return_to_handler+0x0/0x40
    trace-net.sh-405     [001] ...2.    31.859503: truncate_pagecache+0x4/0x60 <-return_to_handler+0x0/0x40
    trace-net.sh-405     [001] ...2.    31.859505: unmap_mapping_range+0x4/0x140 <-return_to_handler+0x0/0x40
    trace-net.sh-405     [001] ...3.    31.859508: _raw_spin_unlock+0x4/0x30 <-return_to_handler+0x0/0x40
    [...]

The following is my simple trace script:

<snip>
jeff-labs:~/bin # cat ./trace-net.sh
TRACE_PATH="/sys/kernel/debug/tracing"

set_events() {
        echo 1 > $1/events/net/enable
        echo 1 > $1/events/tcp/enable
        echo 1 > $1/events/sock/enable
        echo 1 > $1/events/napi/enable
        echo 1 > $1/events/fib/enable
        echo 1 > $1/events/neigh/enable
}

set_events ${TRACE_PATH}
echo 1 > ${TRACE_PATH}/options/sym-offset
echo 1 > ${TRACE_PATH}/options/funcgraph-tail
echo 1 > ${TRACE_PATH}/options/funcgraph-proc
echo 1 > ${TRACE_PATH}/options/funcgraph-abstime

echo 'tcp_orphan*' > ${TRACE_PATH}/set_ftrace_notrace
echo function_graph > ${TRACE_PATH}/current_tracer

INSTANCE_FOO=${TRACE_PATH}/instances/foo
if [ ! -e $INSTANCE_FOO ]; then
        mkdir ${INSTANCE_FOO}
fi
set_events ${INSTANCE_FOO}
echo 1 > ${INSTANCE_FOO}/options/sym-offset
echo 'tcp_orphan*' > ${INSTANCE_FOO}/set_ftrace_notrace
echo function > ${INSTANCE_FOO}/current_tracer

echo 1 > ${TRACE_PATH}/tracing_on
echo 1 > ${INSTANCE_FOO}/tracing_on

echo > ${TRACE_PATH}/trace
echo > ${INSTANCE_FOO}/trace
</snip>

Signed-off-by: Jeff Xie <jeff.xie@linux.dev>
---
v3:
- fixed build error when CONFIG_FUNCTION_GRAPH_TRACER=n suggested by Masami

v2:
- Adding __always_inline to function_get_true_parent_ip suggested by Steve

 kernel/trace/trace_functions.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 3b0cea37e029..5dc5fcdf4e6f 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -176,6 +176,27 @@ static void function_trace_start(struct trace_array *tr)
 	tracing_reset_online_cpus(&tr->array_buffer);
 }
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+static __always_inline unsigned long
+function_get_true_parent_ip(unsigned long parent_ip, struct ftrace_regs *fregs)
+{
+	unsigned long true_parent_ip;
+	int idx = 0;
+
+	true_parent_ip = parent_ip;
+	if (unlikely(parent_ip == (unsigned long)&return_to_handler))
+		true_parent_ip = ftrace_graph_ret_addr(current, &idx, parent_ip,
+				(unsigned long *)fregs->regs.sp);
+	return true_parent_ip;
+}
+#else
+static __always_inline unsigned long
+function_get_true_parent_ip(unsigned long parent_ip, struct ftrace_regs *fregs)
+{
+	return parent_ip;
+}
+#endif
+
 static void
 function_trace_call(unsigned long ip, unsigned long parent_ip,
 		    struct ftrace_ops *op, struct ftrace_regs *fregs)
@@ -193,6 +214,8 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 	if (bit < 0)
 		return;
 
+	parent_ip = function_get_true_parent_ip(parent_ip, fregs);
+
 	trace_ctx = tracing_gen_ctx();
 
 	cpu = smp_processor_id();
@@ -241,6 +264,7 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
 	 * recursive protection is performed.
 	 */
 	local_irq_save(flags);
+	parent_ip = function_get_true_parent_ip(parent_ip, fregs);
 	cpu = raw_smp_processor_id();
 	data = per_cpu_ptr(tr->array_buffer.data, cpu);
 	disabled = atomic_inc_return(&data->disabled);
@@ -309,6 +333,7 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 	if (bit < 0)
 		return;
 
+	parent_ip = function_get_true_parent_ip(parent_ip, fregs);
 	cpu = smp_processor_id();
 	data = per_cpu_ptr(tr->array_buffer.data, cpu);
 	if (atomic_read(&data->disabled))
@@ -356,6 +381,7 @@ function_stack_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 	 * recursive protection is performed.
 	 */
 	local_irq_save(flags);
+	parent_ip = function_get_true_parent_ip(parent_ip, fregs);
 	cpu = raw_smp_processor_id();
 	data = per_cpu_ptr(tr->array_buffer.data, cpu);
 	disabled = atomic_inc_return(&data->disabled);
-- 
2.43.0

