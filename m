Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F726158553;
	Mon,  7 Apr 2025 23:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069965; cv=none; b=fLJGHQW9YCOMrQtWOjQx4RkpNDED7BwXGcEl+GPAH10r/7t43Lki0ROCcnstLwrzETPEteh48TtbPPrk/i1akz2usMvQYd/FxYRU6SmaLntGaQ5wybPQenBFPu9LT5FOl5gdvsuo6X6awfglnryTWTDIVJCAEP1MZ6LwODLwK14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069965; c=relaxed/simple;
	bh=dzGktIUZU1o/dBewqA+of++k9Aa6ip9OH8DCeWqgB94=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=p6E5+vcZaHH9Ejf5IfXZlUk3oyASjXGcRLu/0JuUkPnnWl7EnAKjU1JbYdik7l0iasHArmTTvSSrqW2JvqSeY5DWNjd94+qSWDd7UDgCOYEX7doQTPToow+q6VvdBsQDl8nI2EwJURiXXs09Neh+1qdcnK2ISZTW+p7GaGFF3Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRGcSRDD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRGcSRDD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74629C4CEDD;
	Mon,  7 Apr 2025 23:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744069964;
	bh=dzGktIUZU1o/dBewqA+of++k9Aa6ip9OH8DCeWqgB94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vRGcSRDDfe0LXL6fTXSLBDk8LBfDhfwIIsFAv1MgBr9vlsUa0dB4DGwUw1e6yUO8T
	 R8vGRH8kCukD/H6lwKZ7ON27cQkowDMFGKmLSATTM15M7ti93q6S3NmMOj5K3OiYgx
	 CQ3KxTWKRUp+NEdnL+oeFtQ37vEsV6aPlNriz0t+6kVX1L8pOMxYwAPvXfiPNYagK2
	 caWm/xYWvzKg3DeWFf9lPeFs2T0i1tEmhQvcwaircIoznzJoEt0xps5UXgkJyDjP5a
	 e5DKoGsx3AmdZ45EVha03nkgeB+/pyATc7QTk7bnk4DnH/RWqrxEe7XOZYn3OMdBV3
	 M4lPQH3amzL7w==
Date: Tue, 8 Apr 2025 08:52:41 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] tracing: fprobe: Cleanup fprobe hash when module
 unloading
Message-Id: <20250408085241.cfd5f87e8197fa6f938e87b0@kernel.org>
In-Reply-To: <174343534473.843280.13988101014957210732.stgit@devnote2>
References: <174343532655.843280.15317319860632975273.stgit@devnote2>
	<174343534473.843280.13988101014957210732.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Apr 2025 00:35:44 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Cleanup fprobe address hash table on module unloading because the
> target symbols will be disappeared when unloading module and not
> sure the same symbol is mapped on the same address.
> 
> Note that this is at least disables the fprobes if a part of target
> symbols on the unloaded modules. Unlike kprobes, fprobe does not
> re-enable the probe point by itself. To do that, the caller should
> take care register/unregister fprobe when loading/unloading modules.
> This simplifies the fprobe state managememt related to the module
> loading/unloading.
> 

I think this is a kind of fix for commit 4346ba160409 ("fprobe: Rewrite
 fprobe on function-graph tracer") which introduced the fprobe_hlist_node.

Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")

Thanks,

> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/fprobe.c |  103 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 101 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index cb86f90d4b1e..95c6e3473a76 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -89,8 +89,11 @@ static bool delete_fprobe_node(struct fprobe_hlist_node *node)
>  {
>  	lockdep_assert_held(&fprobe_mutex);
>  
> -	WRITE_ONCE(node->fp, NULL);
> -	hlist_del_rcu(&node->hlist);
> +	/* Avoid double deleting */
> +	if (READ_ONCE(node->fp) != NULL) {
> +		WRITE_ONCE(node->fp, NULL);
> +		hlist_del_rcu(&node->hlist);
> +	}
>  	return !!find_first_fprobe_node(node->addr);
>  }
>  
> @@ -411,6 +414,102 @@ static void fprobe_graph_remove_ips(unsigned long *addrs, int num)
>  		ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 1, 0);
>  }
>  
> +#ifdef CONFIG_MODULES
> +
> +#define FPROBE_IPS_BATCH_INIT 8
> +/* instruction pointer address list */
> +struct fprobe_addr_list {
> +	int index;
> +	int size;
> +	unsigned long *addrs;
> +};
> +
> +static int fprobe_addr_list_add(struct fprobe_addr_list *alist, unsigned long addr)
> +{
> +	unsigned long *addrs;
> +
> +	if (alist->index >= alist->size)
> +		return -ENOMEM;
> +
> +	alist->addrs[alist->index++] = addr;
> +	if (alist->index < alist->size)
> +		return 0;
> +
> +	/* Expand the address list */
> +	addrs = kcalloc(alist->size * 2, sizeof(*addrs), GFP_KERNEL);
> +	if (!addrs)
> +		return -ENOMEM;
> +
> +	memcpy(addrs, alist->addrs, alist->size * sizeof(*addrs));
> +	alist->size *= 2;
> +	kfree(alist->addrs);
> +	alist->addrs = addrs;
> +
> +	return 0;
> +}
> +
> +static void fprobe_remove_node_in_module(struct module *mod, struct hlist_head *head,
> +					struct fprobe_addr_list *alist)
> +{
> +	struct fprobe_hlist_node *node;
> +	int ret = 0;
> +
> +	hlist_for_each_entry_rcu(node, head, hlist) {
> +		if (!within_module(node->addr, mod))
> +			continue;
> +		if (delete_fprobe_node(node))
> +			continue;
> +		/*
> +		 * If failed to update alist, just continue to update hlist.
> +		 * Therefore, at list user handler will not hit anymore.
> +		 */
> +		if (!ret)
> +			ret = fprobe_addr_list_add(alist, node->addr);
> +	}
> +}
> +
> +/* Handle module unloading to manage fprobe_ip_table. */
> +static int fprobe_module_callback(struct notifier_block *nb,
> +				  unsigned long val, void *data)
> +{
> +	struct fprobe_addr_list alist = {.size = FPROBE_IPS_BATCH_INIT};
> +	struct module *mod = data;
> +	int i;
> +
> +	if (val != MODULE_STATE_GOING)
> +		return NOTIFY_DONE;
> +
> +	alist.addrs = kcalloc(alist.size, sizeof(*alist.addrs), GFP_KERNEL);
> +	/* If failed to alloc memory, we can not remove ips from hash. */
> +	if (!alist.addrs)
> +		return NOTIFY_DONE;
> +
> +	mutex_lock(&fprobe_mutex);
> +	for (i = 0; i < FPROBE_IP_TABLE_SIZE; i++)
> +		fprobe_remove_node_in_module(mod, &fprobe_ip_table[i], &alist);
> +
> +	if (alist.index < alist.size && alist.index > 0)
> +		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
> +				      alist.addrs, alist.index, 1, 0);
> +	mutex_unlock(&fprobe_mutex);
> +
> +	kfree(alist.addrs);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block fprobe_module_nb = {
> +	.notifier_call = fprobe_module_callback,
> +	.priority = 0,
> +};
> +
> +static int __init init_fprobe_module(void)
> +{
> +	return register_module_notifier(&fprobe_module_nb);
> +}
> +early_initcall(init_fprobe_module);
> +#endif
> +
>  static int symbols_cmp(const void *a, const void *b)
>  {
>  	const char **str_a = (const char **) a;
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
