Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640141;
	b=JghXyoZ/1FMaHh7kpapm/2Cz7ODpVhCQElPIEI90bx3tRz/IFeVFHMzW0Zym4EIE9Bra
	 kj2Hec860i1hNFAqeP+NGLoVpEz0DAYA+4Jr6L09+LBCL1GCBtxWTNpWap8w0JSj56Q29
	 Uq9AIWvZ1ihwTrwIITIPh9QexxA8nrtpOokovY63zDZ/Y1A48FQkiAUUzc420bSBDVLPQ
	 Isf1oVk5FlhbTbtFqmogIWDNM53ASE4AAiaarEW9VJGZB2jbO1fYBDK90maAt1xGexZaI
	 3Ba4gp9idmGbNX5nhT2TY8wooUc2daFDl1vy0By7KDpbPaO5r41mCnZU4TSlSOQs6cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640141;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=hDso38Lo6BucfYQi/WKDSXYlCRCkhjHvbZZQPjbIWjU=;
	b=ju58iSc0LvyTWQbEoSJhHJYBX747hovO4v8pILXX3rZoPQRLwzreudDpb5z3XaYY/7/L
	 4VMzDW6J9KKM0LLMtODt0cfdja5TxhoabcssMMpBg4+N4xXbWzXxHqSxQ+uQRP1qC7CQK
	 f7qklTdVzAb1yRPhuiJ3CLNOStae1ecyf6a6ubQ4QmvQWMPeVPcsv1hHN71YLQUmwRYPc
	 Ou7FETNydspXeLKI03t/boLj1z5HQ5nevNJTVpx6amo25rEjlSQhgo4+hCt1K86cI5djk
	 sn3ipNfJiJ5YYYAGGUHvOJCb1ZhvoNyu4YSQaLkvffDwhCoyTElORie6pSTsnTzAKVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=l3r8EZp1;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B67606BA52;
	Mon,  2 Nov 2026 17:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98B67606BA52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=l3r8EZp1
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 0F66E1A01A1;
	Mon,  2 Nov 2026 17:22:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 0EEF21A;
	Mon,  2 Nov 2026 17:22:16 +0000 (UTC)
Date: Mon, 2 Nov 2026 12:22:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Xiang Mei
 <xmei5@asu.edu>
Subject: Re: [PATCH v3] ftrace: Complete subops teardown on shutdown failure
Message-ID: <20261102111707.484df6f5@gandalf.local.home>
In-Reply-To: <20261031175213.704021-1-bestswngs@gmail.com>
References: <20261031175213.704021-1-bestswngs@gmail.com>
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
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 0EEF21A
X-Stat-Signature: 6us6zc4xqhyfrbsbmtpgp36jpowasxze
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19B/jQdySa7H6oYtXfs6XggTV84APC5CfA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=hDso38Lo6BucfYQi/WKDSXYlCRCkhjHvbZZQPjbIWjU=; b=l3r8EZp15VGz0B+EBzA4KkLIJEv9ZnGsgR18Hya3MX5c+CnI0G/3KDQMWWRFiiG1+qJEunBjjq4kU/4/b5I4bdxUduKLvBDCyO/o4ZTdxSDAR04S9RpU6WSOysjImgK3em0JxRGvtO1tlUipa2lVgBiKCVUorzZzw3/w2fm9V5c=
X-HE-Tag: 1793640136-409405
X-HE-Meta: U2FsdGVkX1/BX7i1uokAGBDczCBHFjkFoapCL+fxaJiUtIo2gt2S5MdJA3a7Ax9WkRxxoTaK6GNcj4pHn4LMcHTy/NBiISz6GANBb3cUalEm+BhwtDDxLEfIY+t2YMK7lBGniOT+2+86xEMyVk0trSn7TjBJDeXhNQKdzjdfSiTXRBkhjAWWCBE5jqR7kv7vPJJHmG7NQSjxgJqBbc47NP4YiNgT9Sa1qEm6FkOvdKNYqAztE1spmlwZvTmnRwRTdFIT/IRSvovCbNUdHq7gUppyJybL7umAUnT2vf1+4UOEqoXwMwpskZBqyzCPitoUc2UieyL56C+gtZaswryrRHgNqo7D4dtAcvFEazJxVIXhKCEXgGFgOGoa4sy8/RCx3Iw4AAW0Byg=

On Sat, 31 Oct 2026 10:52:13 -0700
Weiming Shi <bestswngs@gmail.com> wrote:

> ftrace_shutdown_subops() unlinks a subop before rebuilding the manager
> hashes, but leaves it enabled and managed when rebuilding or updating
> fails. unregister_ftrace_graph() cannot recover from that partial
> teardown, and a later registration can corrupt the empty manager state.
> 
> Always detach and clear the subop once shutdown begins. Keep conservative
> manager hashes behind per-subop filtering when an update fails, and disable
> direct graph dispatch until those hashes are exact again. If the last
> manager cannot be shut down, disable ftrace and normalize its list, flags,
> count, and hashes before the caller releases the graph operation.

What exactly is the above saying? It looks like pure AI output (non human
readable). AKA, AI slop!

Is it fixing something when a subop is unregistered but fails? Where
exactly is the failure? What failed? Have an example of what happened?

Direct calls is mentioned once, but there seems to be a bit of changes for
that too. Some of it looks like it should be a separate patch.

> 
> Cc: stable@vger.kernel.org
> Fixes: 0ae6b8ce200d ("ftrace: Fix accounting of subop hashes")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: OpenAI Codex <noreply@openai.com>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  kernel/trace/fgraph.c          | 35 +++++++++++++++++----
>  kernel/trace/ftrace.c          | 57 +++++++++++++++++++++-------------
>  kernel/trace/ftrace_internal.h |  3 ++
>  3 files changed, 68 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index ed455b535..1a8e092ec 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -1306,7 +1306,7 @@ static void ftrace_graph_enable_direct(bool enable_branch, struct fgraph_ops *go
>  
>  	static_call_update(fgraph_func, func);
>  	static_call_update(fgraph_retfunc, retfunc);
> -	if (enable_branch)
> +	if (enable_branch && !static_key_enabled(&fgraph_do_direct.key))
>  		static_branch_enable(&fgraph_do_direct);

Ug that is horrible. If anything static_branch_enable() should handle this.
Or we have to have another type of accounting.


>  }
>  
> @@ -1315,13 +1315,27 @@ static void ftrace_graph_disable_direct(bool disable_branch)
>  	if (FGRAPH_NO_DIRECT)
>  		return;
>  
> -	if (disable_branch)
> +	if (disable_branch && static_key_enabled(&fgraph_do_direct.key))
>  		static_branch_disable(&fgraph_do_direct);

Same.

>  	static_call_update(fgraph_func, ftrace_graph_entry_stub);
>  	static_call_update(fgraph_retfunc, ftrace_graph_ret_stub);
>  	fgraph_direct_gops = &fgraph_stub;
>  }
>  
> +void fgraph_update_direct_func(struct ftrace_ops *ops, bool enable)

What is this for? It requires a kerneldoc as it is not a static function.

It also looks unrelated to the partial shutdown. Is his needed as a
separate patch?

> +{
> +	struct fgraph_ops *gops;
> +
> +	if (ftrace_graph_active != 1 || !(ops->flags & FTRACE_OPS_FL_GRAPH))
> +		return;
> +
> +	gops = container_of(ops, struct fgraph_ops, ops);
> +	if (enable)
> +		ftrace_graph_enable_direct(true, gops);
> +	else
> +		ftrace_graph_disable_direct(true);
> +}
> +
>  /* The cpu_boot init_task->ret_stack will never be freed */
>  static int fgraph_cpu_init(unsigned int cpu)
>  {
> @@ -1406,16 +1420,24 @@ int register_ftrace_graph(struct fgraph_ops *gops)
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
>  		ftrace_graph_active--;
> +		gops->ops.flags &= ~FTRACE_OPS_FL_GRAPH;

Hmm, clearing the flag looks like a separate bug that should be fixed in
its own patch.


>  		gops->saved_func = NULL;
>  		fgraph_lru_release_index(i);
> -		if (!ftrace_graph_active)
> +		if (ftrace_graph_active == 1) {
> +			ftrace_graph_enable_direct(true, NULL);
> +		} else if (!ftrace_graph_active) {
> +			ftrace_graph_disable_direct(false);
>  			unregister_pm_notifier(&ftrace_suspend_notifier);
> +		}

Nit, but I would have the above opposite. That is, don't make the current
if statement the else, unless there's a good reason to. Because it makes
reviewing harder.

		if (!ftrace_graph_active) {
			ftrace_graph_disable_direct(false);
 			unregister_pm_notifier(&ftrace_suspend_notifier);
		} else if (ftrace_graph_active == 1) {
			ftrace_graph_enable_direct(true, NULL);
		}


>  	}
>  	return ret;
>  }
> @@ -1423,6 +1445,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  void unregister_ftrace_graph(struct fgraph_ops *gops)
>  {
>  	int command = 0;
> +	int ret;
>  
>  	if (WARN_ONCE(!(gops->ops.flags & FTRACE_OPS_FL_GRAPH),
>  		      "function graph ops unregistered without registering"))
> @@ -1447,9 +1470,9 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
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
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 673a54fdf..831f04de6 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -3667,6 +3667,8 @@ static int rebuild_hashes(struct ftrace_hash **filter_hash, struct ftrace_hash *
>  	bool first = true;
>  	int ret;
>  
> +	*filter_hash = EMPTY_HASH;
> +	*notrace_hash = EMPTY_HASH;
>  	temp_hash.filter_hash = EMPTY_HASH;
>  	temp_hash.notrace_hash = EMPTY_HASH;
>  
> @@ -3708,7 +3710,13 @@ static int rebuild_hashes(struct ftrace_hash **filter_hash, struct ftrace_hash *
>   * will not affect functions that are being traced by other subops that
>   * still exist in @ops.
>   *
> - * If the last subops is removed from @ops, then @ops is shutdown normally.
> + * Once removal starts, @subops is detached even if rebuilding the manager
> + * hashes fails. The old manager hashes are conservative in that case and the
> + * remaining subops continue to filter callbacks. If the last-manager shutdown
> + * fails, ftrace is disabled before the manager state is discarded.
> + *
> + * Return: 0 on success or a negative error code if the manager could not be
> + * updated or shut down.
>   */
>  int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command)
>  {
> @@ -3716,9 +3724,6 @@ int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, in
>  	struct ftrace_hash *notrace_hash = EMPTY_HASH;
>  	int ret;
>  
> -	if (unlikely(ftrace_disabled))
> -		return -ENODEV;

Wait! Why this???

> -
>  	if (WARN_ON_ONCE(!(subops->flags & FTRACE_OPS_FL_ENABLED)))
>  		return -EINVAL;
>  
> @@ -3727,36 +3732,45 @@ int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, in
>  	if (list_empty(&ops->subop_list)) {
>  		/* Last one, just disable the current ops */
>  
> -		ret = ftrace_shutdown(ops, command);
> +		if (unlikely(ftrace_disabled))
> +			ret = -ENODEV;
> +		else
> +			ret = ftrace_shutdown(ops, command);

Ug no!

>  		if (ret < 0) {
> -			list_add(&subops->list, &ops->subop_list);
> -			return ret;
> +			bool enabled = ops->flags & FTRACE_OPS_FL_ENABLED;
> +
> +			FTRACE_WARN_ON_ONCE(!ftrace_disabled);
> +			remove_ftrace_ops(&ftrace_ops_list, ops);
> +			if (enabled && ftrace_start_up > 0)
> +				ftrace_start_up--;
> +			ops->flags &= ~(FTRACE_OPS_FL_ENABLED |
> +					FTRACE_OPS_FL_ADDING |
> +					FTRACE_OPS_FL_REMOVING);
> +			ops->func = ops->saved_func;

Please explain the above.

>  		}
>  
> -		subops->flags &= ~FTRACE_OPS_FL_ENABLED;
> -
>  		free_ftrace_hash(ops->func_hash->filter_hash);
>  		free_ftrace_hash(ops->func_hash->notrace_hash);
>  		ops->func_hash->filter_hash = EMPTY_HASH;
>  		ops->func_hash->notrace_hash = EMPTY_HASH;
> -		subops->flags &= ~(FTRACE_OPS_FL_ENABLED | FTRACE_OPS_FL_SUBOP);
> -		subops->managed = NULL;
> +		goto out;
> +	}
>  
> -		return 0;
> +	if (unlikely(ftrace_disabled)) {
> +		ret = -ENODEV;
> +		goto out;
>  	}
>  
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


The above is doing a lot without really explaining why.

-- Steve

>  	free_ftrace_hash(filter_hash);
>  	free_ftrace_hash(notrace_hash);
>  	return ret;
> @@ -3767,8 +3781,8 @@ static int ftrace_hash_move_and_update_subops(struct ftrace_ops *subops,
>  					      struct ftrace_hash *hash)
>  {
>  	struct ftrace_ops *ops = subops->managed;
> -	struct ftrace_hash *notrace_hash;
> -	struct ftrace_hash *filter_hash;
> +	struct ftrace_hash *notrace_hash = EMPTY_HASH;
> +	struct ftrace_hash *filter_hash = EMPTY_HASH;
>  	struct ftrace_hash *save_hash;
>  	struct ftrace_hash *new_hash;
>  	int ret;
> @@ -3800,6 +3814,7 @@ static int ftrace_hash_move_and_update_subops(struct ftrace_ops *subops,
>  	} else {
>  		free_ftrace_hash_rcu(save_hash);
>  	}
> +	fgraph_update_direct_func(subops, !ret);
>  	return ret;
>  }
>  
> diff --git a/kernel/trace/ftrace_internal.h b/kernel/trace/ftrace_internal.h
> index 3235470e6..3d5934b1c 100644
> --- a/kernel/trace/ftrace_internal.h
> +++ b/kernel/trace/ftrace_internal.h
> @@ -16,6 +16,7 @@ int ftrace_startup(struct ftrace_ops *ops, int command);
>  int ftrace_shutdown(struct ftrace_ops *ops, int command);
>  int ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs);
>  int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command);
> +/* Once started, shutdown always detaches @subops, even when it returns an error. */
>  int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command);
>  
>  #else /* !CONFIG_DYNAMIC_FTRACE */
> @@ -52,6 +53,7 @@ static inline int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_o
>  
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  extern int ftrace_graph_active;
> +void fgraph_update_direct_func(struct ftrace_ops *ops, bool enable);
>  # ifdef CONFIG_DYNAMIC_FTRACE
>  extern void fgraph_update_pid_func(void);
>  # else
> @@ -59,6 +61,7 @@ static inline void fgraph_update_pid_func(void) {}
>  # endif
>  #else /* !CONFIG_FUNCTION_GRAPH_TRACER */
>  # define ftrace_graph_active 0
> +static inline void fgraph_update_direct_func(struct ftrace_ops *ops, bool enable) {}
>  static inline void fgraph_update_pid_func(void) {}
>  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
>  

