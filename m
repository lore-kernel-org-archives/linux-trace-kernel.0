Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D24487BE;
	Wed,  8 Apr 2026 01:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775610472; cv=none; b=qK6tZwEgSroQBBfYHB6+lMVZWGp6H6H36s4YU4T1DUvh5muhpH0xCaToWnp6wPelIkxPAnED5QCbJ3fX06/gDexL6T3L0+93hS1ijTdTwN1TexGrQAYPb8tjqTjzfy9HFJWpXOTisSGn1gXdNHK/dfiNe13B0cwQG9UB49lPdYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775610472; c=relaxed/simple;
	bh=wfR5HZf+4BIjFePtnRblEBRH17ol/UQ6L9E3R+cKiUc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OBlR3391GLcucCT85OUGlz/qyeaRIStctxcykWN8MaR4IK41qkffefkrJTs5cIXjW/SacaTWttmsFIeRd/ZaCrlxQ3k+xu8uUAYcacCjPAqc9ht4sQdWczpdwak1azE6vD5/kT7lyZvIaTvLypkf70sAUc8eO47VdsevUMHibi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnPUDM2T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnPUDM2T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8523BC116C6;
	Wed,  8 Apr 2026 01:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775610472;
	bh=wfR5HZf+4BIjFePtnRblEBRH17ol/UQ6L9E3R+cKiUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UnPUDM2TBHJd2cGof6psR+AclN6uf/p5PJALCXAtu/TI4x8AfezHkg7RWZUD+URFL
	 KaCntmFSGSApGxvQ+zxdZGWNb9dt2DiHmMBu5vtNsVQp8econRvzX30lmQP+09INOy
	 Ppn9UWREnCsvoH3qeLfMKTScRXLln0/BFtZ0e3CB2Tgx/8pNJHmi8rFwFq2foTPiCL
	 Qrrh87i9iHNLsk/RQ8fIjH380YeBwCP82Z1sQDEntC+xfG4F/TvsRxRmoMRhpD1VSN
	 4o/h/XjhVuOg4oKue33nUCOw+WUDO4PN5IMYi5S5mbeyyRFdiQkc4p9jRyuwapwBou
	 LG0ldNz8uKLBg==
Date: Wed, 8 Apr 2026 10:07:49 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Menglong Dong
 <menglong8.dong@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, jiang.biao@linux.dev,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/fprobe: Check the same type fprobe on table as
 the unregistered one
Message-Id: <20260408100749.24a082590f8638d57e247b46@kernel.org>
In-Reply-To: <177555745233.1441308.6535024692186959381.stgit@mhiramat.tok.corp.google.com>
References: <177555745233.1441308.6535024692186959381.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

Sashiko reported another concern in module callback [1].
Let me fix it.

[1] https://sashiko.dev/#/patchset/177555745233.1441308.6535024692186959381.stgit%40mhiramat.tok.corp.google.com

Thanks,

On Tue,  7 Apr 2026 19:24:12 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Commit 2c67dc457bc6 ("tracing: fprobe: optimization for entry only case")
> introduced a different ftrace_ops for entry-only fprobes.
> 
> However, when unregistering an fprobe, the kernel only checks if another
> fprobe exists at the same address, without checking which type of fprobe
> it is.
> If different fprobes are registered at the same address, the same address
> will be registered in both fgraph_ops and ftrace_ops, but only one of
> them will be deleted when unregistering. (the one removed first will not
> be deleted from the ops).
> 
> This results in junk entries remaining in either fgraph_ops or ftrace_ops.
> For example:
>  =======
>  cd /sys/kernel/tracing
> 
>  # 'Add entry and exit events on the same place'
>  echo 'f:event1 vfs_read' >> dynamic_events
>  echo 'f:event2 vfs_read%return' >> dynamic_events
> 
>  # 'Enable both of them'
>  echo 1 > events/fprobes/enable
>  cat enabled_functions
> vfs_read (2)            ->arch_ftrace_ops_list_func+0x0/0x210
> 
>  # 'Disable and remove exit event'
>  echo 0 > events/fprobes/event2/enable
>  echo -:event2 >> dynamic_events
> 
>  # 'Disable and remove all events'
>  echo 0 > events/fprobes/enable
>  echo > dynamic_events
> 
>  # 'Add another event'
>  echo 'f:event3 vfs_open%return' > dynamic_events
>  cat dynamic_events
> f:fprobes/event3 vfs_open%return
> 
>  echo 1 > events/fprobes/enable
>  cat enabled_functions
> vfs_open (1)            tramp: 0xffffffffa0001000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60    subops: {ent:fprobe_fgraph_entry+0x0/0x620 ret:fprobe_return+0x0/0x150}
> vfs_read (1)            tramp: 0xffffffffa0001000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60    subops: {ent:fprobe_fgraph_entry+0x0/0x620 ret:fprobe_return+0x0/0x150}
>  =======
> 
> As you can see, an entry for the vfs_read remains.
> 
> To fix this issue, when unregistering, the kernel should also check if
> there is the same type of fprobes still exist at the same address, and
> if not, delete its entry from either fgraph_ops or ftrace_ops.
> 
> Fixes: 2c67dc457bc6 ("tracing: fprobe: optimization for entry only case")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/fprobe.c |   77 +++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 62 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index dcadf1d23b8a..7f75e6e4462c 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -85,11 +85,9 @@ static int insert_fprobe_node(struct fprobe_hlist_node *node)
>  	return rhltable_insert(&fprobe_ip_table, &node->hlist, fprobe_rht_params);
>  }
>  
> -/* Return true if there are synonims */
> -static bool delete_fprobe_node(struct fprobe_hlist_node *node)
> +static void delete_fprobe_node(struct fprobe_hlist_node *node)
>  {
>  	lockdep_assert_held(&fprobe_mutex);
> -	bool ret;
>  
>  	/* Avoid double deleting */
>  	if (READ_ONCE(node->fp) != NULL) {
> @@ -97,13 +95,6 @@ static bool delete_fprobe_node(struct fprobe_hlist_node *node)
>  		rhltable_remove(&fprobe_ip_table, &node->hlist,
>  				fprobe_rht_params);
>  	}
> -
> -	rcu_read_lock();
> -	ret = !!rhltable_lookup(&fprobe_ip_table, &node->addr,
> -				fprobe_rht_params);
> -	rcu_read_unlock();
> -
> -	return ret;
>  }
>  
>  /* Check existence of the fprobe */
> @@ -337,6 +328,32 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
>  	return !fp->exit_handler;
>  }
>  
> +static bool fprobe_exists_on_hash(unsigned long ip, bool ftrace)
> +{
> +	struct rhlist_head *head, *pos;
> +	struct fprobe_hlist_node *node;
> +	struct fprobe *fp;
> +
> +	guard(rcu)();
> +	head = rhltable_lookup(&fprobe_ip_table, &ip,
> +				fprobe_rht_params);
> +	if (!head)
> +		return false;
> +	/* We have to check the same type on the list. */
> +	rhl_for_each_entry_rcu(node, pos, head, hlist) {
> +		if (node->addr != ip)
> +			break;
> +		fp = READ_ONCE(node->fp);
> +		if (likely(fp)) {
> +			if ((!ftrace && fp->exit_handler) ||
> +			    (ftrace && !fp->exit_handler))
> +				return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
>  #ifdef CONFIG_MODULES
>  static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove,
>  			   int reset)
> @@ -360,6 +377,29 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
>  	return false;
>  }
>  
> +static bool fprobe_exists_on_hash(unsigned long ip, bool ftrace __maybe_unused)
> +{
> +	struct rhlist_head *head, *pos;
> +	struct fprobe_hlist_node *node;
> +	struct fprobe *fp;
> +
> +	guard(rcu)();
> +	head = rhltable_lookup(&fprobe_ip_table, &ip,
> +				fprobe_rht_params);
> +	if (!head)
> +		return false;
> +	/* We only need to check fp is there. */
> +	rhl_for_each_entry_rcu(node, pos, head, hlist) {
> +		if (node->addr != ip)
> +			break;
> +		fp = READ_ONCE(node->fp);
> +		if (likely(fp))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  #ifdef CONFIG_MODULES
>  static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove,
>  			   int reset)
> @@ -574,15 +614,20 @@ static int fprobe_addr_list_add(struct fprobe_addr_list *alist, unsigned long ad
>  static void fprobe_remove_node_in_module(struct module *mod, struct fprobe_hlist_node *node,
>  					 struct fprobe_addr_list *alist)
>  {
> +	lockdep_assert_in_rcu_read_lock();
> +
>  	if (!within_module(node->addr, mod))
>  		return;
> -	if (delete_fprobe_node(node))
> -		return;
> +
> +	delete_fprobe_node(node);
>  	/*
> -	 * If failed to update alist, just continue to update hlist.
> +	 * Ignore failure of updating alist, but continue to update hlist.
>  	 * Therefore, at list user handler will not hit anymore.
> +	 * And don't care the type here, because all fprobes on the same
> +	 * address must be removed eventually.
>  	 */
> -	fprobe_addr_list_add(alist, node->addr);
> +	if (!rhltable_lookup(&fprobe_ip_table, &node->addr, fprobe_rht_params))
> +		fprobe_addr_list_add(alist, node->addr);
>  }
>  
>  /* Handle module unloading to manage fprobe_ip_table. */
> @@ -943,7 +988,9 @@ int unregister_fprobe(struct fprobe *fp)
>  	/* Remove non-synonim ips from table and hash */
>  	count = 0;
>  	for (i = 0; i < hlist_array->size; i++) {
> -		if (!delete_fprobe_node(&hlist_array->array[i]))
> +		delete_fprobe_node(&hlist_array->array[i]);
> +		if (!fprobe_exists_on_hash(hlist_array->array[i].addr,
> +					   fprobe_is_ftrace(fp)))
>  			addrs[count++] = hlist_array->array[i].addr;
>  	}
>  	del_fprobe_hash(fp);
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
