Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A9919994C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246904; cv=none; b=iULnhLI/WRCusvLdh24WFIYW2odZFImUPLDU7+YVU9nGX4sWj6zTlvlfRaok6MD2Js7snr3ehZnyoPRCsSdKVus0Ahj8xcb20E3UPxo7XrWyZmm9vB6eMpBwak9h+k6mjyLmUws6lwkU0o1AP2iQVkpZIIGIOqw3pshxc7u9V8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246904; c=relaxed/simple;
	bh=fSpoUOJjTQB5ZDB5cQn1y/+Ul7d+TOCVAD+4W2KUbsM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=As92ALjnOgmEWGralrUWORoLvd91q9RXvbjBcZjIMFRAemvKvBAuwsDewahmukvHyD/uX6L0vW7cqaaXuW6EnCm+OEk60vq+GFtggylOypwhclI69XtHxow7RE3vf/fahJ0MpuvnuaocfulYLdxgz3oP33RL9JxHBqD7Ib/Rmqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EvV7XxW1; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EvV7XxW1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724246899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eQUk5BmPvnlUH/liWbXAjE9cWgM4lXW3TSxeiUPl4o4=;
	b=EvV7XxW1f0Io08jJ8gLxvsK1rS4TrcsfLI9xCSrrIBXdroM4ubLRLRvxUtJFv5oh0hjchv
	/93Vbyr8dY4QwgExqze6qhdPRxwi4F4EQAtcICGATur/+W+Y17cJskPm764QK3pI7+y9O7
	/JmyO9wmJw8rZtnKgueB4G1eF8AL5Gw=
From: Jeff Xie <jeff.xie@linux.dev>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiehuan09@gmail.com,
	Jeff Xie <jeff.xie@linux.dev>
Subject: [PATCH] ftrace: Get the true parent ip for function tracer
Date: Wed, 21 Aug 2024 21:27:55 +0800
Message-Id: <20240821132755.2766674-1-jeff.xie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, when using both function tracer and function graph simultaneously,
it is found that function tracer sometimes captures a fake parent ip(return_to_handler)
instead of the true parent ip.

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
 kernel/trace/trace_functions.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 3b0cea37e029..273b8c7eeb2d 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -176,6 +176,19 @@ static void function_trace_start(struct trace_array *tr)
 	tracing_reset_online_cpus(&tr->array_buffer);
 }
 
+static unsigned long
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
+
 static void
 function_trace_call(unsigned long ip, unsigned long parent_ip,
 		    struct ftrace_ops *op, struct ftrace_regs *fregs)
@@ -193,6 +206,8 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 	if (bit < 0)
 		return;
 
+	parent_ip = function_get_true_parent_ip(parent_ip, fregs);
+
 	trace_ctx = tracing_gen_ctx();
 
 	cpu = smp_processor_id();
@@ -241,6 +256,7 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
 	 * recursive protection is performed.
 	 */
 	local_irq_save(flags);
+	parent_ip = function_get_true_parent_ip(parent_ip, fregs);
 	cpu = raw_smp_processor_id();
 	data = per_cpu_ptr(tr->array_buffer.data, cpu);
 	disabled = atomic_inc_return(&data->disabled);
@@ -309,6 +325,7 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 	if (bit < 0)
 		return;
 
+	parent_ip = function_get_true_parent_ip(parent_ip, fregs);
 	cpu = smp_processor_id();
 	data = per_cpu_ptr(tr->array_buffer.data, cpu);
 	if (atomic_read(&data->disabled))
@@ -356,6 +373,7 @@ function_stack_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 	 * recursive protection is performed.
 	 */
 	local_irq_save(flags);
+	parent_ip = function_get_true_parent_ip(parent_ip, fregs);
 	cpu = raw_smp_processor_id();
 	data = per_cpu_ptr(tr->array_buffer.data, cpu);
 	disabled = atomic_inc_return(&data->disabled);
-- 
2.34.1

