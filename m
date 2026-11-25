Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620369;
	b=BnscGsoapZq76yznzzHf/Q6lDlXBl7G4tqEJWmT+mVcG8LBfeF9xQ2s7uX3cMODcYXNE
	 JHx7tysmCzUWFg/iEhXVQBrETKq5ZYl4/sR1xC+J7H8vT5IZnvUQOnv4Rf2lTk4oEEoif
	 NVLUtIGf6MzrsUX/FTuLg+U7411QxkaViiRuIIS9giI+BrLJhNqMjKqS9q7oAq/6IfkJ6
	 dguMhGk+qWK0YkV0/iPEPDeerbCTJaugt3PcQe5Uw1ttJ9yrfkXqwanVfXQzNE0U2xt3h
	 nNV89uXlWAIlZnCBRPNMQsimYDxPfMRCh2Q9b/O5f+6K9unTwVEbUpxsXgXnPUz32iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620369;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Spam-Status:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=kLRSqhthNKHEid4YdXhMHVFOwwUEjYlMjOdcQvui2w8=;
	b=feJUjTVC6J2JwkzldnRpfETg91BPUiPM/Fh9HJHp+AjZpDFm9LolWi1R39EKe0VyvaXN
	 a8Sxz+yzioflsGfioSjOexAylLxN96OLUx37qsVtY8wilxmMD88T7AHnMt6kIBcQv+U05
	 /B+vHfdBFSyQYhab5rT+0AQ5Z7jmL59AhOeJZ6iahgaK/Ge9+TEN4YbxLFXjrE6OLobzk
	 Bpj/H+z0tMk71jMSGQVgm7zCA2T3uBSIuQyuaxveetvIPanLhJRzjI3Uq6fNvFmePcIgF
	 NuYbeeH9U/owN4SDazUcxqpf6rsDC63nQ99IGhwGJSCqiPyg/mrkNuP6j1wHzFXwXJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=nGQtR2in;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7357606A321;
	Wed, 25 Nov 2026 15:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7357606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=nGQtR2in
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id DE1181C49E7;
	Wed, 25 Nov 2026 15:26:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id B333720011;
	Wed, 25 Nov 2026 15:26:03 +0000 (UTC)
Date: Wed, 25 Nov 2026 10:26:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 co+bba0c6b49150bef3@bugs.sh, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH v2] ftrace: Finish removing subops after a hash update
 failure
Message-ID: <20261125102602.66ac1738@gandalf.local.home>
In-Reply-To: <20261122155620.319722-1-bestswngs@gmail.com>
References: <20261122155620.319722-1-bestswngs@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: yunqkykr44y68g46yttpestf93a736iy
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: B333720011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18XGbK9YlXzeXLRTO3wKXV8MPSLDtkSaqA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=kLRSqhthNKHEid4YdXhMHVFOwwUEjYlMjOdcQvui2w8=; b=nGQtR2infcBalURerEOwR+6wSCoeHtoecxicHrqtuysUQO4yHsNZRtNQLK5GWcPfcj+NJ/mJ0LuLSPzRLjXgxc+9QIMrh1vanGGyXd5EjNnrxJCzyb54wSF3gUCLKm4eGYImRuZWD8fSgugirWVDn2/ieTfNmTWY9rBAwQUNpFo=
X-HE-Tag: 1795620363-163407
X-HE-Meta: U2FsdGVkX19pIJziAfrxOEeFsxKsLMlF7ydUSndr3Hr5DnQZZJyeIFF4o1+sjzFeUl7BqyE8SGkRCUNEqFuO6TWxSWj7x9qJ2nPr/5C9xWzNPq2bz3R2cltUEOvavPde7jiV55idvWo8BivlK2Sgwt3kZNAuRnPjR2AkTZq+hVVFOseB17k+VUIgo9AaCGoXdZTF57bx1JeNnKy2B02vkhfNwiq1R5KsOSUzSK8KZ0qT8xdOREJB3NaFIw2UbhGgJEruJUVBx4aDcBKMKh1WCGBmccVz/61AeQsxUEggURl/f1aRFK6TRHhFQGGhkdv4NpD5TZA+hvr9etlh/c6qzAPfI6IYXz0nn8BG/+JsPBbBh4GSwmL5Sg==

On Sun, 22 Nov 2026 07:56:19 -0800
Weiming Shi <bestswngs@gmail.com> wrote:

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
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000802: 0000 [#1] SMP KASAN NOPTI
> KASAN: probably user-memory-access in range [0x0000000000004010-0x0000000000004017]
> RIP: ops_equal (kernel/trace/trace.h:1011 kernel/trace/ftrace.c:3416)

So you can only trigger this via fault injection. That needs to be
explicitly stated in the change log.

> Call Trace:
>  ftrace_update_ops (kernel/trace/ftrace.c:3464)
>  ftrace_hash_move_and_update_subops.isra.0 (kernel/trace/ftrace.c:3795)
>  ftrace_hash_move_and_update_ops (kernel/trace/ftrace.c:5095)
>  ftrace_set_hash (kernel/trace/ftrace.c:6006)
>  ftrace_set_filter_ips (kernel/trace/ftrace.c:6020 kernel/trace/ftrace.c:6769)
>  register_fprobe_ips (kernel/trace/fprobe.c:290 kernel/trace/fprobe.c:1020)
>  register_fprobe (kernel/trace/fprobe.c:979)
>  __register_trace_fprobe.part.0 (kernel/trace/trace_fprobe.c:838)
>  enable_trace_fprobe (kernel/trace/trace_fprobe.c:823 kernel/trace/trace_fprobe.c:1483)
>  fprobe_register (kernel/trace/trace_fprobe.c:1553)
>  __ftrace_event_enable_disable (kernel/trace/trace_events.c:913)
>  event_enable_write (kernel/trace/trace_events.c:943 kernel/trace/trace_events.c:1995)
>  vfs_write (fs/read_write.c:665)
>  ksys_write (fs/read_write.c:719)
>  do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:89)
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> Kernel panic - not syncing: Fatal exception
> 
> Cc: stable@vger.kernel.org

I wouldn't even add stable as this is something that can only happen when
the system is already having issues.

> Fixes: 0ae6b8ce200d ("ftrace: Fix accounting of subop hashes")
> Reported-by: <co+bba0c6b49150bef3@bugs.sh>
> Link: https://lore.kernel.org/r/20261103175832.3374540-2-bestswngs@gmail.com
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> Changes in v2:
> - Merge the dependent teardown and graph-reader fixes.
> - Use Tasks RCU waits and defer the fprobe callback wait and filter release
>   to a worker.
> - Rebase onto 4405c18c95d2 and decode the reproduced crash trace.
> - v1: https://lore.kernel.org/r/20261103175832.3374540-2-bestswngs@gmail.com
> 
>  kernel/trace/fgraph.c          | 53 +++++++++++++++++++++++++++++-----
>  kernel/trace/fprobe.c          | 21 +++++++++++---
>  kernel/trace/ftrace.c          | 22 +++++++++-----
>  kernel/trace/ftrace_internal.h |  2 ++
>  4 files changed, 79 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 6d87143b3..3760795d3 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -1406,8 +1406,11 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  	gops->ops.flags |= FTRACE_OPS_FL_GRAPH;
>  
>  	ret = ftrace_startup_subops(&graph_ops, &gops->ops, command);
> -	if (!ret)
> +	if (!ret) {
>  		fgraph_array[i] = gops;
> +		if (ftrace_graph_active == 1)
> +			ftrace_graph_enable_direct(true, gops);
> +	}
>  
>  error:
>  	if (ret) {
> @@ -1420,13 +1423,27 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  	return ret;
>  }
>  
> -void unregister_ftrace_graph(struct fgraph_ops *gops)
> +/**
> + * unregister_ftrace_graph_start - remove a function graph operation
> + * @gops: graph operation to remove
> + *
> + * Remove @gops from graph dispatch, release its array slot, and update the
> + * graph and subop state. Existing graph callbacks may still be using @gops
> + * after this returns.
> + *
> + * Return: true if @gops was removed. The caller must then invoke
> + * unregister_ftrace_graph_finish() exactly once before releasing @gops or its
> + * filter, even if the subop hash update failed.
> + */
> +bool unregister_ftrace_graph_start(struct fgraph_ops *gops)
>  {
>  	int command = 0;
> +	int ret = -EINVAL;
> +	bool removed = false;
>  
>  	if (WARN_ONCE(!(gops->ops.flags & FTRACE_OPS_FL_GRAPH),
>  		      "function graph ops unregistered without registering"))
> -		return;
> +		return false;
>  
>  	guard(mutex)(&ftrace_lock);
>  
> @@ -1440,16 +1457,17 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
>  	if (fgraph_lru_release_index(gops->idx) < 0)
>  		goto out;
>  
> -	fgraph_array[gops->idx] = &fgraph_stub;
> +	WRITE_ONCE(fgraph_array[gops->idx], &fgraph_stub);
> +	removed = true;
>  
>  	ftrace_graph_active--;
>  
>  	if (!ftrace_graph_active)
>  		command = FTRACE_STOP_FUNC_RET;
>  
> -	ftrace_shutdown_subops(&graph_ops, &gops->ops, command);
> +	ret = ftrace_shutdown_subops(&graph_ops, &gops->ops, command);
>  
> -	if (ftrace_graph_active == 1)
> +	if (ftrace_graph_active == 1 && !ret)
>  		ftrace_graph_enable_direct(true, NULL);
>  	else if (!ftrace_graph_active)
>  		ftrace_graph_disable_direct(false);
> @@ -1460,7 +1478,28 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
>  		unregister_pm_notifier(&ftrace_suspend_notifier);
>  		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
>  	}
> -	gops->saved_func = NULL;
>   out:
>  	gops->ops.flags &= ~FTRACE_OPS_FL_GRAPH;
> +	return removed;
> +}
> +
> +/**
> + * unregister_ftrace_graph_finish - wait for callbacks using a removed operation
> + * @gops: graph operation previously removed by unregister_ftrace_graph_start()
> + *
> + * Wait for existing graph readers, then clear the saved callback. This may
> + * sleep. The caller may release @gops and its filter after this returns.
> + */
> +void unregister_ftrace_graph_finish(struct fgraph_ops *gops)
> +{
> +	/* Graph callbacks can run where RCU is not watching. */
> +	synchronize_rcu_tasks_rude();

Graph callbacks should never be running when RCU is not watching. If it is,
then that is a bug.

> +	synchronize_rcu_tasks();
> +	gops->saved_func = NULL;
> +}
> +
> +void unregister_ftrace_graph(struct fgraph_ops *gops)
> +{
> +	if (unregister_ftrace_graph_start(gops))
> +		unregister_ftrace_graph_finish(gops);
>  }
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 47d565a1e..29fc2bfc4 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -14,9 +14,11 @@
>  #include <linux/rhashtable.h>
>  #include <linux/slab.h>
>  #include <linux/sort.h>
> +#include <linux/workqueue.h>
>  
>  #include <asm/fprobe.h>
>  
> +#include "ftrace_internal.h"
>  #include "trace.h"
>  
>  #define FPROBE_IP_HASH_BITS 8
> @@ -279,6 +281,14 @@ static struct fgraph_ops fprobe_graph_ops = {
>  static int nr_fgraph_fprobes;
>  /* Is fprobe_graph_ops registered? */
>  static bool fprobe_graph_registered;
> +static void fprobe_graph_cleanup_workfn(struct work_struct *work);
> +static DECLARE_WORK(fprobe_graph_cleanup_work, fprobe_graph_cleanup_workfn);
> +
> +static void fprobe_graph_cleanup_workfn(struct work_struct *work)
> +{
> +	unregister_ftrace_graph_finish(&fprobe_graph_ops);
> +	ftrace_free_filter(&fprobe_graph_ops.ops);
> +}
>  
>  /* Add @addrs to the ftrace filter and register fgraph if needed. */
>  static int fprobe_graph_add_ips(unsigned long *addrs, int num)
> @@ -286,6 +296,7 @@ static int fprobe_graph_add_ips(unsigned long *addrs, int num)
>  	int ret;
>  
>  	lockdep_assert_held(&fprobe_mutex);
> +	flush_work(&fprobe_graph_cleanup_work);
>  
>  	ret = ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 0, 0);
>  	if (ret)
> @@ -297,7 +308,7 @@ static int fprobe_graph_add_ips(unsigned long *addrs, int num)
>  			ftrace_free_filter(&fprobe_graph_ops.ops);
>  			return ret;
>  		}
> -		fprobe_graph_registered = true;
> +		WRITE_ONCE(fprobe_graph_registered, true);

Why the WRITE_ONCE()?

>  	}
>  	return 0;
>  }
> @@ -305,9 +316,9 @@ static int fprobe_graph_add_ips(unsigned long *addrs, int num)
>  static void __fprobe_graph_unregister(void)
>  {
>  	if (fprobe_graph_registered) {
> -		unregister_ftrace_graph(&fprobe_graph_ops);
> -		ftrace_free_filter(&fprobe_graph_ops.ops);
> -		fprobe_graph_registered = false;
> +		WRITE_ONCE(fprobe_graph_registered, false);

Again, what's with the WRITE_ONCE()?

> +		if (unregister_ftrace_graph_start(&fprobe_graph_ops))
> +			schedule_work(&fprobe_graph_cleanup_work);
>  	}
>  }
>  
> @@ -679,6 +690,8 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
>  	ret_ip = ftrace_regs_get_instruction_pointer(fregs);
>  
>  	guard(rcu_sched_notrace)();
> +	if (!READ_ONCE(fprobe_graph_registered))

Can you explain the READ_ONCE()?

-- Steve

> +		return;
>  
>  	curr = 0;
>  	while (size_words > curr) {
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index c7d74b33d..7c712d99f 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -3672,6 +3672,8 @@ static int rebuild_hashes(struct ftrace_hash **filter_hash, struct ftrace_hash *
>  	bool first = true;
>  	int ret;
>  
> +	*filter_hash = EMPTY_HASH;
> +	*notrace_hash = EMPTY_HASH;
>  	temp_hash.filter_hash = EMPTY_HASH;
>  	temp_hash.notrace_hash = EMPTY_HASH;
>  
> @@ -3713,7 +3715,13 @@ static int rebuild_hashes(struct ftrace_hash **filter_hash, struct ftrace_hash *
>   * will not affect functions that are being traced by other subops that
>   * still exist in @ops.
>   *
> - * If the last subops is removed from @ops, then @ops is shutdown normally.
> + * If @subops is the last subop, @ops is shut down normally. Otherwise,
> + * @subops is detached even if the manager hash update fails. The manager
> + * hashes may be partially updated, but still cover all functions required by
> + * the remaining subops.
> + *
> + * Return: 0 on success, or a negative error code on shutdown or hash update
> + * failure.
>   */
>  int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command)
>  {
> @@ -3753,15 +3761,13 @@ int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, in
>  	/* Rebuild the hashes without subops */
>  	ret = rebuild_hashes(&filter_hash, &notrace_hash, ops);
>  	if (ret < 0)
> -		return ret;
> +		goto out;
>  
>  	ret = ftrace_update_ops(ops, filter_hash, notrace_hash);
> -	if (ret < 0) {
> -		list_add(&subops->list, &ops->subop_list);
> -	} else {
> -		subops->flags &= ~(FTRACE_OPS_FL_ENABLED | FTRACE_OPS_FL_SUBOP);
> -		subops->managed = NULL;
> -	}
> +
> +out:
> +	subops->flags &= ~(FTRACE_OPS_FL_ENABLED | FTRACE_OPS_FL_SUBOP);
> +	subops->managed = NULL;
>  	free_ftrace_hash(filter_hash);
>  	free_ftrace_hash(notrace_hash);
>  	return ret;
> diff --git a/kernel/trace/ftrace_internal.h b/kernel/trace/ftrace_internal.h
> index 3235470e6..abb7776a2 100644
> --- a/kernel/trace/ftrace_internal.h
> +++ b/kernel/trace/ftrace_internal.h
> @@ -52,6 +52,8 @@ static inline int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_o
>  
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  extern int ftrace_graph_active;
> +bool unregister_ftrace_graph_start(struct fgraph_ops *gops);
> +void unregister_ftrace_graph_finish(struct fgraph_ops *gops);
>  # ifdef CONFIG_DYNAMIC_FTRACE
>  extern void fgraph_update_pid_func(void);
>  # else

