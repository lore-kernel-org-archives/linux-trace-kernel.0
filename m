Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD7AA47;
	Sat, 19 Oct 2024 01:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729302184; cv=none; b=FG9osowPn8fOgt7NhDinHF9xjxn/GFehtxuCkodV1G6MHgg14VMFaGH6HGZhF/0Y2C4DZafinM+O4Fw6iqSHsf2Qg+Jqe0n6TjLCr5Ziz72lL0NiAaX5SC11hRVTaQaVCAWHXsRjvQlXBMFX2lHo5oCPqvIg0rsif4Wcr9kuh5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729302184; c=relaxed/simple;
	bh=ng9xrP9CuT3TijTfoUoNcV4QdHhaTc1apnWi9RNDcog=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YY1EDooWSgOHhZPXeF4sKao9pS8a/+dPmWFi4KIXil6NK+4oAb8fnxXxXTHVsZJ3CM5FclxYN9qhtUSP1RxOm/J1H+QCM0OUySI2OVsjDrPLIrELFKKmtRStov+8Bg4fxs0nT+nI2Gy/YL1P7KbqONc9BlMBWm9HawGcM20ktG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663CAC4CEC3;
	Sat, 19 Oct 2024 01:43:02 +0000 (UTC)
Date: Fri, 18 Oct 2024 21:43:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] fgraph: Use CPU hotplug mechanism to initialize idle shadow
 stacks
Message-ID: <20241018214300.6df82178@rorschach>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The function graph infrastructure allocates a shadow stack for every task
when enabled. This includes the idle tasks. The first time the function
graph is invoked, the shadow stacks are created and never freed until the
task exits. This includes the idle tasks.

Only the idle tasks that were for online CPUs had their shadow stacks
created when function graph tracing started. If function graph tracing is
enabled and a CPU comes online, the idle task representing that CPU will
not have its shadow stack created, and all function graph tracing for that
idle task will be silently dropped.

Instead, use the CPU hotplug mechanism to allocate the idle shadow stacks.
This will include idle tasks for CPUs that come online during tracing.

This issue can be reproduced by:

 # cd /sys/kernel/tracing
 # echo 0 > /sys/devices/system/cpu/cpu1/online
 # echo 0 > set_ftrace_pid
 # echo function_graph > current_tracer
 # echo 1 > options/funcgraph-proc
 # echo 1 > /sys/devices/system/cpu/cpu1
 # grep '<idle>' per_cpu/cpu1/trace | head

Before, nothing would show up.

After:
 1)    <idle>-0    |   0.811 us    |                        __enqueue_entity();
 1)    <idle>-0    |   5.626 us    |                      } /* enqueue_entity */
 1)    <idle>-0    |               |                      dl_server_update_idle_time() {
 1)    <idle>-0    |               |                        dl_scaled_delta_exec() {
 1)    <idle>-0    |   0.450 us    |                          arch_scale_cpu_capacity();
 1)    <idle>-0    |   1.242 us    |                        }
 1)    <idle>-0    |   1.908 us    |                      }
 1)    <idle>-0    |               |                      dl_server_start() {
 1)    <idle>-0    |               |                        enqueue_dl_entity() {
 1)    <idle>-0    |               |                          task_contending() {

Note, if tracing stops and restarts, the old way would then initialize
the onlined CPUs.

Cc: stable@vger.kernel.org
Fixes: 868baf07b1a25 ("ftrace: Fix memory leak with function graph and cpu hotplug")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index d7d4fb403f6f..43f4e3f57438 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1160,19 +1160,13 @@ void fgraph_update_pid_func(void)
 static int start_graph_tracing(void)
 {
 	unsigned long **ret_stack_list;
-	int ret, cpu;
+	int ret;
 
 	ret_stack_list = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
 
 	if (!ret_stack_list)
 		return -ENOMEM;
 
-	/* The cpu_boot init_task->ret_stack will never be freed */
-	for_each_online_cpu(cpu) {
-		if (!idle_task(cpu)->ret_stack)
-			ftrace_graph_init_idle_task(idle_task(cpu), cpu);
-	}
-
 	do {
 		ret = alloc_retstack_tasklist(ret_stack_list);
 	} while (ret == -EAGAIN);
@@ -1242,14 +1236,34 @@ static void ftrace_graph_disable_direct(bool disable_branch)
 	fgraph_direct_gops = &fgraph_stub;
 }
 
+/* The cpu_boot init_task->ret_stack will never be freed */
+static int fgraph_cpu_init(unsigned int cpu)
+{
+	if (!idle_task(cpu)->ret_stack)
+		ftrace_graph_init_idle_task(idle_task(cpu), cpu);
+	return 0;
+}
+
 int register_ftrace_graph(struct fgraph_ops *gops)
 {
+	static bool fgraph_initialized;
 	int command = 0;
 	int ret = 0;
 	int i = -1;
 
 	mutex_lock(&ftrace_lock);
 
+	if (!fgraph_initialized) {
+		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "fgraph_idle_init",
+					fgraph_cpu_init, NULL);
+		if (ret < 0) {
+			pr_warn("fgraph: Error to init cpu hotplug support\n");
+			return ret;
+		}
+		fgraph_initialized = true;
+		ret = 0;
+	}
+
 	if (!fgraph_array[0]) {
 		/* The array must always have real data on it */
 		for (i = 0; i < FGRAPH_ARRAY_SIZE; i++)
-- 
2.45.2

