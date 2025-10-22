Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FF122D4E9;
	Wed, 22 Oct 2025 22:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761173563; cv=none; b=d+fodT5xtRRLCmc3IGa0WbUDUBcDc+dfK9S3SowP1hlP3AQZMUbpPy07YfBd/eQJO/Yqfc1lvqUx+damXvtdYBIx3JU1bHI6K1T/WCH1a4pV28oqAYdsgyMdgEWuCS+iZs+ndAIYV/tUY9DdVlN/Bt1ZVnPVqXm7kW79scvyt74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761173563; c=relaxed/simple;
	bh=Wm/ckbgUKXf3zfHORTTggg4sYZPiF19095C/Ve2uhIk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pMAKX4XGYpoHMIlU9rjcGH8nguL8SYvwKQspmUgVZsAM2KWufjEz/MyuzLK37hC9ZgTY+ZVRjinXN2AUHV/Z7//qvpChOcaqsUHXGThbzTWHW5XMHIL0TkIm1bTj74a5Z7c1vcx09U8KQo227HNPRCKdobHKWDjjLulX92l5Opo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lASh8C+l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lASh8C+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3B3C4CEE7;
	Wed, 22 Oct 2025 22:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761173563;
	bh=Wm/ckbgUKXf3zfHORTTggg4sYZPiF19095C/Ve2uhIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lASh8C+l/byala0UUt/I+eAp2W9jEZSw+d611+S66om1c8sz2Do+gdUo0dZPjjAZi
	 Hvx8qdrIHxIif+Fpt7nGhhEvCXCjfTqpDTUn8X1GF/wBi9zHZgSLHAOeYtHDjau/uu
	 pAS6GOVPjMvJKHL50WKdRxlw7+ef+fXjkVDETcvV+gdJuHgwOksZ/YMN+Kx1dzhT6K
	 OZRx747NH7ksUrsqR41NSuYesD28QV3TILtVIFkHA/5JxPT26K4O5WUO2lKvNfnEQJ
	 2KNUvtOTR2pY0PD82QO2+KkAmnNzgtD8Q7EL8epk196smccm++zmZqMauuGqm+rkyv
	 ultVDajf6nORA==
Date: Thu, 23 Oct 2025 07:52:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 jiang.biao@linux.dev, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] tracing: fprobe: optimization for entry only
 case
Message-Id: <20251023075239.12ec605954eda85c198f1e20@kernel.org>
In-Reply-To: <20251015083238.2374294-2-dongml2@chinatelecom.cn>
References: <20251015083238.2374294-1-dongml2@chinatelecom.cn>
	<20251015083238.2374294-2-dongml2@chinatelecom.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 15 Oct 2025 16:32:37 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> For now, fgraph is used for the fprobe, even if we need trace the entry
> only. However, the performance of ftrace is better than fgraph, and we
> can use ftrace_ops for this case.
> 
> Then performance of kprobe-multi increases from 54M to 69M. Before this
> commit:
> 
>   $ ./benchs/run_bench_trigger.sh kprobe-multi
>   kprobe-multi   :   54.663 ± 0.493M/s
> 
> After this commit:
> 
>   $ ./benchs/run_bench_trigger.sh kprobe-multi
>   kprobe-multi   :   69.447 ± 0.143M/s
> 
> Mitigation is disable during the bench testing above.
> 

Looks good to me. Thanks!

> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v4:
> - fallback to fgraph if FTRACE_OPS_FL_SAVE_REGS not supported
> 
> v3:
> - add some comment to the rcu_read_lock() in fprobe_ftrace_entry()
> 
> v2:
> - add some document for fprobe_fgraph_entry as Masami suggested
> - merge the rename of fprobe_entry into current patch
> - use ftrace_test_recursion_trylock() in fprobe_ftrace_entry()
> ---
>  kernel/trace/fprobe.c | 128 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 119 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 99d83c08b9e2..ecd623eef68b 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -254,8 +254,106 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
>  	return ret;
>  }
>  
> -static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> -			struct ftrace_regs *fregs)
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +/* ftrace_ops callback, this processes fprobes which have only entry_handler. */
> +static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
> +	struct ftrace_ops *ops, struct ftrace_regs *fregs)
> +{
> +	struct fprobe_hlist_node *node;
> +	struct rhlist_head *head, *pos;
> +	struct fprobe *fp;
> +	int bit;
> +
> +	bit = ftrace_test_recursion_trylock(ip, parent_ip);
> +	if (bit < 0)
> +		return;
> +
> +	/*
> +	 * ftrace_test_recursion_trylock() disables preemption, but
> +	 * rhltable_lookup() checks whether rcu_read_lcok is held.
> +	 * So we take rcu_read_lock() here.
> +	 */
> +	rcu_read_lock();
> +	head = rhltable_lookup(&fprobe_ip_table, &ip, fprobe_rht_params);
> +
> +	rhl_for_each_entry_rcu(node, pos, head, hlist) {
> +		if (node->addr != ip)
> +			break;
> +		fp = READ_ONCE(node->fp);
> +		if (unlikely(!fp || fprobe_disabled(fp) || fp->exit_handler))
> +			continue;
> +
> +		if (fprobe_shared_with_kprobes(fp))
> +			__fprobe_kprobe_handler(ip, parent_ip, fp, fregs, NULL);
> +		else
> +			__fprobe_handler(ip, parent_ip, fp, fregs, NULL);
> +	}
> +	rcu_read_unlock();
> +	ftrace_test_recursion_unlock(bit);
> +}
> +NOKPROBE_SYMBOL(fprobe_ftrace_entry);
> +
> +static struct ftrace_ops fprobe_ftrace_ops = {
> +	.func	= fprobe_ftrace_entry,
> +	.flags	= FTRACE_OPS_FL_SAVE_REGS,
> +};
> +static int fprobe_ftrace_active;
> +
> +static int fprobe_ftrace_add_ips(unsigned long *addrs, int num)
> +{
> +	int ret;
> +
> +	lockdep_assert_held(&fprobe_mutex);
> +
> +	ret = ftrace_set_filter_ips(&fprobe_ftrace_ops, addrs, num, 0, 0);
> +	if (ret)
> +		return ret;
> +
> +	if (!fprobe_ftrace_active) {
> +		ret = register_ftrace_function(&fprobe_ftrace_ops);
> +		if (ret) {
> +			ftrace_free_filter(&fprobe_ftrace_ops);
> +			return ret;
> +		}
> +	}
> +	fprobe_ftrace_active++;
> +	return 0;
> +}
> +
> +static void fprobe_ftrace_remove_ips(unsigned long *addrs, int num)
> +{
> +	lockdep_assert_held(&fprobe_mutex);
> +
> +	fprobe_ftrace_active--;
> +	if (!fprobe_ftrace_active)
> +		unregister_ftrace_function(&fprobe_ftrace_ops);
> +	if (num)
> +		ftrace_set_filter_ips(&fprobe_ftrace_ops, addrs, num, 1, 0);
> +}
> +
> +static bool fprobe_is_ftrace(struct fprobe *fp)
> +{
> +	return !fp->exit_handler;
> +}
> +#else
> +static int fprobe_ftrace_add_ips(unsigned long *addrs, int num)
> +{
> +	return -ENOENT;
> +}
> +
> +static void fprobe_ftrace_remove_ips(unsigned long *addrs, int num)
> +{
> +}
> +
> +static bool fprobe_is_ftrace(struct fprobe *fp)
> +{
> +	return false;
> +}
> +#endif
> +
> +/* fgraph_ops callback, this processes fprobes which have exit_handler. */
> +static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> +			       struct ftrace_regs *fregs)
>  {
>  	unsigned long *fgraph_data = NULL;
>  	unsigned long func = trace->func;
> @@ -292,7 +390,7 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
>  				if (node->addr != func)
>  					continue;
>  				fp = READ_ONCE(node->fp);
> -				if (fp && !fprobe_disabled(fp))
> +				if (fp && !fprobe_disabled(fp) && !fprobe_is_ftrace(fp))
>  					fp->nmissed++;
>  			}
>  			return 0;
> @@ -312,7 +410,7 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
>  		if (node->addr != func)
>  			continue;
>  		fp = READ_ONCE(node->fp);
> -		if (!fp || fprobe_disabled(fp))
> +		if (unlikely(!fp || fprobe_disabled(fp) || fprobe_is_ftrace(fp)))
>  			continue;
>  
>  		data_size = fp->entry_data_size;
> @@ -340,7 +438,7 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
>  	/* If any exit_handler is set, data must be used. */
>  	return used != 0;
>  }
> -NOKPROBE_SYMBOL(fprobe_entry);
> +NOKPROBE_SYMBOL(fprobe_fgraph_entry);
>  
>  static void fprobe_return(struct ftrace_graph_ret *trace,
>  			  struct fgraph_ops *gops,
> @@ -379,7 +477,7 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
>  NOKPROBE_SYMBOL(fprobe_return);
>  
>  static struct fgraph_ops fprobe_graph_ops = {
> -	.entryfunc	= fprobe_entry,
> +	.entryfunc	= fprobe_fgraph_entry,
>  	.retfunc	= fprobe_return,
>  };
>  static int fprobe_graph_active;
> @@ -498,9 +596,14 @@ static int fprobe_module_callback(struct notifier_block *nb,
>  	} while (node == ERR_PTR(-EAGAIN));
>  	rhashtable_walk_exit(&iter);
>  
> -	if (alist.index > 0)
> +	if (alist.index > 0) {
>  		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
>  				      alist.addrs, alist.index, 1, 0);
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +		ftrace_set_filter_ips(&fprobe_ftrace_ops,
> +				      alist.addrs, alist.index, 1, 0);
> +#endif
> +	}
>  	mutex_unlock(&fprobe_mutex);
>  
>  	kfree(alist.addrs);
> @@ -733,7 +836,11 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
>  	mutex_lock(&fprobe_mutex);
>  
>  	hlist_array = fp->hlist_array;
> -	ret = fprobe_graph_add_ips(addrs, num);
> +	if (fprobe_is_ftrace(fp))
> +		ret = fprobe_ftrace_add_ips(addrs, num);
> +	else
> +		ret = fprobe_graph_add_ips(addrs, num);
> +
>  	if (!ret) {
>  		add_fprobe_hash(fp);
>  		for (i = 0; i < hlist_array->size; i++) {
> @@ -829,7 +936,10 @@ int unregister_fprobe(struct fprobe *fp)
>  	}
>  	del_fprobe_hash(fp);
>  
> -	fprobe_graph_remove_ips(addrs, count);
> +	if (fprobe_is_ftrace(fp))
> +		fprobe_ftrace_remove_ips(addrs, count);
> +	else
> +		fprobe_graph_remove_ips(addrs, count);
>  
>  	kfree_rcu(hlist_array, rcu);
>  	fp->hlist_array = NULL;
> -- 
> 2.51.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
