Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795364626;
	b=fAT4cCzbA75jenxuKa1c+qQukVEtScIQwj+Mzs8ytq4fwuoSRfpGRIVMOE3pmvTWrHzP
	 dmGrSHL2SzYBUaGonRP/tA9+btEySihwh0Hj1+sNkDNVwNpyoscqJrAXO2r9CFT4WE650
	 2T4RvJnGoCkzzE+I/+5y6QRPFD2lbQ2iBiDReIC9TNKaTX+URl5jiwTrSbLFXcAjXPTb0
	 G4Q6XVb/hldog+NcAsvf3CxM10t3tNuzH8xqQ/1fCRb8jj0667pGVJQGHcG8kXc+m1+dZ
	 mqtSD2t4FA9YqW9nys/VKOttJxAoifAWLWGvuvkLurvEhf87t3YEYKu6n9/Mgt/sKFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795364626;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Lo2HCtzdYoxMD+V8EX9WHHjmc1/XdQxN1XdnA69lyHo=;
	b=U1lqXtswv2CnQT9J++EDpg9kfNetVtzBbcAl71MFQjd6s3yZCn2RE/X1AMKHv4R1JEWQ
	 StdLl2E8gIZBPMWkkqKL8f8Ow/luhko6+QDhR6QA7+2oYlSYK4E5TQg16tl50gTvg2pi+
	 zuMJCCQyab2rjXO5CUB7fSNsKZZsLRRmtTd/C3rGAIm5rdbF3UN++3MfMx0wGfpHpoA21
	 V34oafMwF+fMV0PIAYvM/N4DQ9IRw4G3PcnZU2KntHJoGgwwiA/A5UoOi7HajNub3etRX
	 GsVm8huMx/NlDSLxBrkchANFr59JJTdyH7cwoHtxLlVofaCdahRnetSQep6Z0xjvEIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oSGUosr8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CCC606A320
	for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Nov 2026 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oSGUosr8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE391F000C6;
	Sun, 22 Nov 2026 16:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795364625;
	bh=Lo2HCtzdYoxMD+V8EX9WHHjmc1/XdQxN1XdnA69lyHo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oSGUosr8P3NgAzsYFxv54EDYPM+S4otBpBOUh+ivQnQ1m2F8q9WYuMlwGHckrMaF8
	 5hOKBOTF7AuiUWh0YLAi9JVhWWFG5hSvW2KPGhL0ZYsv39Pc06FyzTtGim+hhios8l
	 9r22TdpBGATf+H/f8J7rnK/nKQck7hov5K2p8TY4IroZbrPWJOEk6HE9fY4qXFo+zr
	 2HAApMiiGeLmbQXK/bns1VPdT01xpbUH5EG0rzd+C3f4RTNKuKV85kbfLCFOT80JRJ
	 iVDTibIwfp4c5reXBa9MfZILmZXg4dYCUz8Yqr+6oWJ/cXYE1aypV4oiLdB2QjWdKr
	 58l6hS/6RGQhQ==
Message-ID: <sashiko-outbox-228095@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ftrace: Finish removing subops after a hash update
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Weiming Shi" <bestswngs@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261122155620.319722-1-bestswngs@gmail.com>
References: <20261122155620.319722-1-bestswngs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 16:23:45 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] fgraph: unnecessary Tasks RCU waits in
  unregister_ftrace_graph_finish()
- [Low] ftrace: commit message omits reproduction commands requested on
  v1
--

commit 74af33bd06338337070f4988ba978b843a4c1bea
Author: Weiming Shi <bestswngs@gmail.com>

> ftrace: Finish removing subops after a hash update failure
>
> When removing a non-final graph subop, ftrace_shutdown_subops() first
> detaches it, then rebuilds and installs the manager hashes. If
> rebuild_hashes() fails, the subop stays detached with its ENABLED and
> SUBOP flags and manager pointer intact. If ftrace_update_ops() fails, the
> subop is added back even though unregister_ftrace_graph() has already
> removed its graph slot.
>
> In the fprobe path, ftrace_free_filter() then warns and returns, while
> __fprobe_graph_unregister() marks the shared graph operation unregistered.
> A later registration follows the stale SUBOP state into an empty manager
> list. rebuild_hashes() leaves its output pointers uninitialized in that
> case, and ops_equal() dereferences one of them.
>
> Complete non-final removal on both manager-hash failure paths and
> initialize empty rebuild outputs to EMPTY_HASH. Keep direct dispatch
> disabled after an update failure because the old manager hashes may cover
> functions needed only by the removed subop; normal dispatch still applies
> the remaining subops' filters.
>
> Completing removal also lets the caller free the subop filter. Split graph
> unregistration into removal and callback-wait helpers so Tasks RCU waits
> run before saved_func or the operation can be released. For asynchronous
> fprobe removal, remove the graph operation immediately and defer the wait
> and filter release to a worker that is flushed before reuse. Gate return
> callbacks on fprobe_graph_registered while cleanup is pending.
>
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc0000000802: 0000 [#1] SMP KASAN NOPTI
> KASAN: probably user-memory-access in range [0x0000000000004010-0x0000000=
000004017]
> RIP: ops_equal (kernel/trace/trace.h:1011 kernel/trace/ftrace.c:3416)
> Call Trace:
>  ftrace_update_ops (kernel/trace/ftrace.c:3464)
>  ftrace_hash_move_and_update_subops.isra.0 (kernel/trace/ftrace.c:3795)
>  ftrace_hash_move_and_update_ops (kernel/trace/ftrace.c:5095)
>  ftrace_set_hash (kernel/trace/ftrace.c:6006)
>  ftrace_set_filter_ips (kernel/trace/ftrace.c:6020 kernel/trace/ftrace.c:=
6769)
>  register_fprobe_ips (kernel/trace/fprobe.c:290 kernel/trace/fprobe.c:102=
0)
>  register_fprobe (kernel/trace/fprobe.c:979)
>  __register_trace_fprobe.part.0 (kernel/trace/trace_fprobe.c:838)
>  enable_trace_fprobe (kernel/trace/trace_fprobe.c:823 kernel/trace/trace_=
fprobe.c:1483)
>  fprobe_register (kernel/trace/trace_fprobe.c:1553)
>  __ftrace_event_enable_disable (kernel/trace/trace_events.c:913)
>  event_enable_write (kernel/trace/trace_events.c:943 kernel/trace/trace_e=
vents.c:1995)
>  vfs_write (fs/read_write.c:665)
>  ksys_write (fs/read_write.c:719)
>  do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.=
c:89)
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> Kernel panic - not syncing: Fatal exception
>
> Cc: stable@vger.kernel.org
> Fixes: 0ae6b8ce200d ("ftrace: Fix accounting of subop hashes")
> Reported-by: <co+bba0c6b49150bef3@bugs.sh>
> Link: https://lore.kernel.org/r/20261103175832.3374540-2-bestswngs@gmail.=
com
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

[Severity: Low]
As reported by Steven Rostedt on v1 [1], could the commit message include t=
he
command lines that trigger the stale SUBOP state and the ops_equal() crash?

> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index ed455b53513be..92186e7f5d698 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c

[ ... ]

> @@ -1460,7 +1478,28 @@ void unregister_ftrace_graph(struct fgraph_ops *go=
ps)
>  		unregister_pm_notifier(&ftrace_suspend_notifier);
>  		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
>  	}
> -	gops->saved_func =3D NULL;
>   out:
>  	gops->ops.flags &=3D ~FTRACE_OPS_FL_GRAPH;
> +	return removed;
> +}
> +
> +/**
> + * unregister_ftrace_graph_finish - wait for callbacks using a removed o=
peration
> + * @gops: graph operation previously removed by unregister_ftrace_graph_=
start()
> + *
> + * Wait for existing graph readers, then clear the saved callback. This =
may
> + * sleep. The caller may release @gops and its filter after this returns.
> + */
> +void unregister_ftrace_graph_finish(struct fgraph_ops *gops)
> +{
> +	/* Graph callbacks can run where RCU is not watching. */
> +	synchronize_rcu_tasks_rude();
> +	synchronize_rcu_tasks();
> +	gops->saved_func =3D NULL;
> +}

[Severity: Low]
As reported by Steven Rostedt on v1 [2], does
unregister_ftrace_graph_finish() need synchronize_rcu_tasks_rude() and
synchronize_rcu_tasks() instead of synchronize_rcu()?

Both function_graph_enter_regs() and __ftrace_return_to_handler() enter via
ftrace_test_recursion_trylock() -> trace_test_and_set_recursion(), which
checks that RCU is watching via trace_warn_on_no_rcu() and disables
preemption across all graph callbacks.  Using Tasks RCU here is inaccurate
and stalls graph unregistration and fprobe cleanup waiting for voluntary
context switches across all runnable tasks.

[1] https://lore.kernel.org/r/20261118134146.3577fcad@gandalf.local.home
[2] https://lore.kernel.org/r/20261118134146.3577fcad@gandalf.local.home

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122155620.3197=
22-1-bestswngs@gmail.com?part=3D1
