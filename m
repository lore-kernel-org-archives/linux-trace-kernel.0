Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E19D28E7;
	Wed, 18 Jun 2025 03:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750217502; cv=none; b=bzdaBCV4IIBJE9FQ0FXzpckIrePcfoBtJg7+OQKjpqMBZz5t9j9ReUDYjAhHkRohBiB2BCc5/L2RMdawWs3Tt898JmoooJF5bG0yrIsa9hYmUbAa+ZUDEsHZkt+vQ+ZJ1OBR59D1wXbMvWzWHuLjnLaN2qGOm5iyeGvexJmK27U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750217502; c=relaxed/simple;
	bh=qiXjYyYiHs9o2tujiuKXcSr2tT5qv9+1nLdbnaj4/Zw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dxCZ5yHHkdZjwVwB8Cjd8pC7ZQjpHcvHTB4PxgNgjxiYbi1981klyQnsaKwokvm36NSRWUY2GzAPmxbg+33OIVX2AjTtZp4Uq/PjtRE/xi0c9Qw/FBd4unPxnC81mHUhao2UhJliP8iIOMw7rJLHIMkzp5e/FQMbb3yHW+PcfT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAWIe7Ki; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAWIe7Ki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D55C4CEE7;
	Wed, 18 Jun 2025 03:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750217501;
	bh=qiXjYyYiHs9o2tujiuKXcSr2tT5qv9+1nLdbnaj4/Zw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cAWIe7Ki/f+tOPAPdxO+BPa1gyZvXtrx8uAPoNnF6537jrPvzlcLLHHDK6thMjS2o
	 FZoIvGV7zANqYUjk89yLJBh040OIcN1rQCiKT5Ih0WuKCSpAFuvA1Qo0BVL812uaxh
	 8HTK8/cCmA78wNln7KWVmkdQnkpQ3RiUJf2dhyYdM+IMAuvigFB8Pqt/8ZYz7ZdxdB
	 ZGNLvqquSxWA4tilbfT2GZ4PfM2m58lV/vx6la0wxco62m9bHJQBXRkHjzS7qc8wiC
	 MdWw+QTY3ESUax29R98XIFr5lhAi0FF4MtTcZ2bbLSoor5KRtKljuCBZ5Uj2wjuhA9
	 nnT9RKJUE76ew==
Date: Wed, 18 Jun 2025 12:31:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, duchangbin <changbin.du@huawei.com>
Subject: Re: [PATCH] fgraph: Do not enable function_graph tracer when
 setting funcgraph-args
Message-Id: <20250618123139.b322cd50c669370ce051ea9b@kernel.org>
In-Reply-To: <20250617120830.24fbdd62@gandalf.local.home>
References: <20250617120830.24fbdd62@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Jun 2025 12:08:30 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When setting the funcgraph-args option when function graph tracer is net
> enabled, it incorrectly enables it. Worse, it unregisters itself when it
> was never registered. Then when it gets enabled again, it will register
> itself a second time causing a WARNing.
> 
>  ~# echo 1 > /sys/kernel/tracing/options/funcgraph-args
>  ~# head -20 /sys/kernel/tracing/trace
>  # tracer: nop
>  #
>  # entries-in-buffer/entries-written: 813/26317372   #P:8
>  #
>  #                                _-----=> irqs-off/BH-disabled
>  #                               / _----=> need-resched
>  #                              | / _---=> hardirq/softirq
>  #                              || / _--=> preempt-depth
>  #                              ||| / _-=> migrate-disable
>  #                              |||| /     delay
>  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>  #              | |         |   |||||     |         |
>            <idle>-0       [007] d..4.   358.966010:  7)   1.692 us    |          fetch_next_timer_interrupt(basej=4294981640, basem=357956000000, base_local=0xffff88823c3ae040, base_global=0xffff88823c3af300, tevt=0xffff888100e47cb8);
>            <idle>-0       [007] d..4.   358.966012:  7)               |          tmigr_cpu_deactivate(nextexp=357988000000) {
>            <idle>-0       [007] d..4.   358.966013:  7)               |            _raw_spin_lock(lock=0xffff88823c3b2320) {
>            <idle>-0       [007] d..4.   358.966014:  7)   0.981 us    |              preempt_count_add(val=1);
>            <idle>-0       [007] d..5.   358.966017:  7)   1.058 us    |              do_raw_spin_lock(lock=0xffff88823c3b2320);
>            <idle>-0       [007] d..4.   358.966019:  7)   5.824 us    |            }
>            <idle>-0       [007] d..5.   358.966021:  7)               |            tmigr_inactive_up(group=0xffff888100cb9000, child=0x0, data=0xffff888100e47bc0) {
>            <idle>-0       [007] d..5.   358.966022:  7)               |              tmigr_update_events(group=0xffff888100cb9000, child=0x0, data=0xffff888100e47bc0) {
> 
> Notice the "tracer: nop" at the top there. The current tracer is the "nop"
> tracer, but the content is obviously the function graph tracer.
> 
> Enabling function graph tracing will cause it to register again and
> trigger a warning in the accounting:
> 
>  ~# echo function_graph > /sys/kernel/tracing/current_tracer
>  -bash: echo: write error: Device or resource busy
> 
> With the dmesg of:
> 
>  ------------[ cut here ]------------
>  WARNING: CPU: 7 PID: 1095 at kernel/trace/ftrace.c:3509 ftrace_startup_subops+0xc1e/0x1000
>  Modules linked in: kvm_intel kvm irqbypass
>  CPU: 7 UID: 0 PID: 1095 Comm: bash Not tainted 6.16.0-rc2-test-00006-gea03de4105d3 #24 PREEMPT
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>  RIP: 0010:ftrace_startup_subops+0xc1e/0x1000
>  Code: 48 b8 22 01 00 00 00 00 ad de 49 89 84 24 88 01 00 00 8b 44 24 08 89 04 24 e9 c3 f7 ff ff c7 04 24 ed ff ff ff e9 b7 f7 ff ff <0f> 0b c7 04 24 f0 ff ff ff e9 a9 f7 ff ff c7 04 24 f4 ff ff ff e9
>  RSP: 0018:ffff888133cff948 EFLAGS: 00010202
>  RAX: 0000000000000001 RBX: 1ffff1102679ff31 RCX: 0000000000000000
>  RDX: 1ffffffff0b27a60 RSI: ffffffff8593d2f0 RDI: ffffffff85941140
>  RBP: 00000000000c2041 R08: ffffffffffffffff R09: ffffed1020240221
>  R10: ffff88810120110f R11: ffffed1020240214 R12: ffffffff8593d2f0
>  R13: ffffffff8593d300 R14: ffffffff85941140 R15: ffffffff85631100
>  FS:  00007f7ec6f28740(0000) GS:ffff8882b5251000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f7ec6f181c0 CR3: 000000012f1d0005 CR4: 0000000000172ef0
>  Call Trace:
>   <TASK>
>   ? __pfx_ftrace_startup_subops+0x10/0x10
>   ? find_held_lock+0x2b/0x80
>   ? ftrace_stub_direct_tramp+0x10/0x10
>   ? ftrace_stub_direct_tramp+0x10/0x10
>   ? trace_preempt_on+0xd0/0x110
>   ? __pfx_trace_graph_entry_args+0x10/0x10
>   register_ftrace_graph+0x4d2/0x1020
>   ? tracing_reset_online_cpus+0x14b/0x1e0
>   ? __pfx_register_ftrace_graph+0x10/0x10
>   ? ring_buffer_record_enable+0x16/0x20
>   ? tracing_reset_online_cpus+0x153/0x1e0
>   ? __pfx_tracing_reset_online_cpus+0x10/0x10
>   ? __pfx_trace_graph_return+0x10/0x10
>   graph_trace_init+0xfd/0x160
>   tracing_set_tracer+0x500/0xa80
>   ? __pfx_tracing_set_tracer+0x10/0x10
>   ? lock_release+0x181/0x2d0
>   ? _copy_from_user+0x26/0xa0
>   tracing_set_trace_write+0x132/0x1e0
>   ? __pfx_tracing_set_trace_write+0x10/0x10
>   ? ftrace_graph_func+0xcc/0x140
>   ? ftrace_stub_direct_tramp+0x10/0x10
>   ? ftrace_stub_direct_tramp+0x10/0x10
>   ? ftrace_stub_direct_tramp+0x10/0x10
>   vfs_write+0x1d0/0xe90
>   ? __pfx_vfs_write+0x10/0x10
> 
> Have the setting of the funcgraph-args check if function_graph tracer is
> the current tracer of the instance, and if not, do nothing, as there's
> nothing to do (the option is checked when function_graph tracing starts).
> 

OK, this looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Cc: stable@vger.kernel.org
> Fixes: c7a60a733c373 ("ftrace: Have funcgraph-args take affect during tracing")
> Reported-by: duchangbin <changbin.du@huawei.com>
> Closes: https://lore.kernel.org/all/4ab1a7bdd0174ab09c7b0d68cdbff9a4@huawei.com/
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_functions_graph.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> index 9234e2c39abf..b6211c304c7f 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -455,10 +455,16 @@ static int graph_trace_init(struct trace_array *tr)
>  	return 0;
>  }
>  
> +static struct tracer graph_trace;
> +
>  static int ftrace_graph_trace_args(struct trace_array *tr, int set)
>  {
>  	trace_func_graph_ent_t entry;
>  
> +	/* Do nothing if the current tracer is no this tracer */
> +	if (tr->current_trace != &graph_trace)
> +		return 0;
> +
>  	if (set)
>  		entry = trace_graph_entry_args;
>  	else
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
