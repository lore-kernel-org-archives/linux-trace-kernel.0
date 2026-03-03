Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AACA73463;
	Tue,  3 Mar 2026 04:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772511429; cv=none; b=fDa6+MCg8jhVHIY9D1esQpiviozKaOBRP+ogNAmCjXkH2CfH4XP4icx6oL5s+/1h/NRTJDqi0bI+PLdxW+CdrZ6xi7PQ1ZWiedZyp1SjjbQQ10IL9p/ck41UHp/XNM7LiISzULOxTeW9DIlf/x2fENMu1VFzFa6LksERgcXIy0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772511429; c=relaxed/simple;
	bh=5b41ls3baZU1MEfL569cSMAClH+iBzJL1gCNZQJRTnA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nJJycblhH/q0Z68DIhFLku4Pn8k/LIKfNflE1BPi6zqS2BhRh/JHg+hlTnNnw7ErTEiciAk44uptFByC0wq341+3zvIRpDy88Gt3IxNMELuZ8+zoE/sKoT8ocNLAnVsXsXHBLAioAasjv/7rEEOiaC9DhvlhFDjIELCmYj2zVk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XC5/CtuA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XC5/CtuA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337EDC116C6;
	Tue,  3 Mar 2026 04:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772511429;
	bh=5b41ls3baZU1MEfL569cSMAClH+iBzJL1gCNZQJRTnA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XC5/CtuA80ilBo3nXy0LvUAvwLIqf5J4IyWd7FUT2+jDrwGW4knWRKuXrUOYKN5IM
	 YL6DjsZ2JmA1GoaA2hF3/DLjflSy3MtIzkKxdXqlmzxTyJQ6LlzWYDtzQ68KkB97cD
	 /mh7n+yc9Gyo6Te5kp8As37mYKTKK2/IV7aWoWd3LRXX9xT20zlUkz1AN7+DvmyWTA
	 ZrzBQSYqdYJdOpR9Ici1T4f1wW18F0dinGTw13LFCXyCJ/vY1y519NEDZq8Q1xrXxf
	 rfBSElGwax+6DPfk4UA3hF7LxuJydKpHTRAxWAp66ppHsbN2YJV9BiDRPBpX89FJZX
	 qFv7R2heqmuTw==
Date: Tue, 3 Mar 2026 13:17:06 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ftrace: Disable preemption in the tracepoint callbacks
 handling filtered pids
Message-Id: <20260303131706.96057f61a48a34c43ce1e396@kernel.org>
In-Reply-To: <20260302213546.156e3e4f@gandalf.local.home>
References: <20260302213546.156e3e4f@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Mar 2026 21:35:46 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When function trace PID filtering is enabled, the function tracer will
> attach a callback to the fork tracepoint as well as the exit tracepoint
> that will add the forked child PID to the PID filtering list as well as
> remove the PID that is exiting.
> 
> Commit a46023d5616e ("tracing: Guard __DECLARE_TRACE() use of
> __DO_TRACE_CALL() with SRCU-fast") removed the disabling of preemption
> when calling tracepoint callbacks.
> 
> The callbacks used for the PID filtering accounting depended on preemption
> being disabled, and now the trigger a "suspicious RCU usage" warning message.
> 
> Make them explicitly disable preemption.
> 

Hmm, we still have another "WARNING: suspicious RCU usage" 

[37] event tracing - restricts events based on pid notrace filtering[  155.874095] 
[  155.874869] =============================
[  155.876037] WARNING: suspicious RCU usage
[  155.877287] 7.0.0-rc1-00004-g8cd473a19bc7 #7 Not tainted
[  155.879263] -----------------------------
[  155.882839] kernel/trace/trace_events.c:1057 suspicious rcu_dereference_check() usage!
[  155.889281] 
[  155.889281] other info that might help us debug this:
[  155.889281] 
[  155.894519] 
[  155.894519] rcu_scheduler_active = 2, debug_locks = 1
[  155.898068] no locks held by ftracetest/4364.
[  155.900524] 
[  155.900524] stack backtrace:
[  155.902645] CPU: 1 UID: 0 PID: 4364 Comm: ftracetest Not tainted 7.0.0-rc1-00004-g8cd473a19bc7 #7 PREEMPT(lazy) 
[  155.902648] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
[  155.902651] Call Trace:
[  155.902655]  <TASK>
[  155.902659]  dump_stack_lvl+0x67/0x90
[  155.902665]  lockdep_rcu_suspicious+0x154/0x1a0
[  155.902672]  event_filter_pid_sched_process_fork+0x9a/0xd0
[  155.902678]  kernel_clone+0x367/0x3a0
[  155.902689]  __x64_sys_clone+0x116/0x140
[  155.902696]  do_syscall_64+0x158/0x460
[  155.902700]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  155.902702]  ? trace_irq_disable+0x1d/0xc0
[  155.902709]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  155.902711] RIP: 0033:0x4697c3
[  155.902716] Code: 1f 84 00 00 00 00 00 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
[  155.902718] RSP: 002b:00007ffc41150428 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
[  155.902721] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004697c3
[  155.902722] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
[  155.902724] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000003fccf990
[  155.902725] R10: 000000003fccd690 R11: 0000000000000246 R12: 0000000000000001
[  155.902726] R13: 000000003fce8103 R14: 0000000000000001 R15: 0000000000000000
[  155.902733]  </TASK>
[  155.902747] 

It seems we need 2 more guard()s.

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 9928da636c9d..3b3aaf4831e9 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1039,6 +1039,7 @@ event_filter_pid_sched_process_exit(void *data, struct task_struct *task)
 	struct trace_pid_list *pid_list;
 	struct trace_array *tr = data;
 
+	guard(preempt)();
 	pid_list = rcu_dereference_raw(tr->filtered_pids);
 	trace_filter_add_remove_task(pid_list, NULL, task);
 
@@ -1054,6 +1055,7 @@ event_filter_pid_sched_process_fork(void *data,
 	struct trace_pid_list *pid_list;
 	struct trace_array *tr = data;
 
+	guard(preempt)();
 	pid_list = rcu_dereference_sched(tr->filtered_pids);
 	trace_filter_add_remove_task(pid_list, self, task);
 

Thanks,

> Fixes: a46023d5616e ("tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ftrace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 1ce17c8af409..5274e0cab8f3 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -8611,6 +8611,7 @@ ftrace_pid_follow_sched_process_fork(void *data,
>  	struct trace_pid_list *pid_list;
>  	struct trace_array *tr = data;
>  
> +	guard(preempt)();
>  	pid_list = rcu_dereference_sched(tr->function_pids);
>  	trace_filter_add_remove_task(pid_list, self, task);
>  
> @@ -8624,6 +8625,7 @@ ftrace_pid_follow_sched_process_exit(void *data, struct task_struct *task)
>  	struct trace_pid_list *pid_list;
>  	struct trace_array *tr = data;
>  
> +	guard(preempt)();
>  	pid_list = rcu_dereference_sched(tr->function_pids);
>  	trace_filter_add_remove_task(pid_list, NULL, task);
>  
> -- 
> 2.51.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
