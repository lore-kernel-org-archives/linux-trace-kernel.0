Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193BD15F3E0;
	Thu, 11 Jul 2024 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706393; cv=none; b=M3Iz5hWKCix9mzJEVHcH1jHtB2j36fcyfZkNq794wrP9TyXivuaXxizYra1DHPXRylyHynBCwlux25FQUfpYGd4CSg/tG8mFnFCu7Si2i35773W+wLvRg35DJyZq48WDbfWcPDodq0ti/SJSGtYC0RxYMeumfPaV1muh1nBKxxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706393; c=relaxed/simple;
	bh=FHtR7Le/pcFbduWry3sn6ZwXUjgZS7NcvdrZwRRZGEg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jC4Xjdrmldb7gepHGUA8fDN44gxpPioE9f5BUnq48tVN+pN4tMsUiQaS2gj7IYyPAhPvsRnT16jrQN/rxPEbuzg1jLUPH5cn4t21n1WcNwyoyIW1V80wAx60VWzdkKsVEHOlU+8aedaPvr3O6G04nQ7tlwP3RaMNoT4d2Jac6c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXyDIA12; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXyDIA12"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714C1C116B1;
	Thu, 11 Jul 2024 13:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720706392;
	bh=FHtR7Le/pcFbduWry3sn6ZwXUjgZS7NcvdrZwRRZGEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PXyDIA12BIDFwWzR+Yr9MQsWSRU9BqpNwJifNM2hUeMA1DVnKnI69fGvJJdf19LEL
	 1tFi858EvgUoqXYhTePpH8PLUw+WrcufDHcua5GlKmv6OLDdN2pCuZuymCIQkXyve6
	 SzzvjNNe/XBrWo+qaIkoTxJ1lKKz9O/Jpzfaoajgt3ULb1DmzcStoGCbfiRPL09WcF
	 RiZMNUUpJeYFCEpC48K308j1njvKbKgsbJm04obvEW6/Fr0PPeKWeghKQZxzsjrPbB
	 sonLIm6x/l4tq212o49Z5DD5YL503RbCxrH8kl9Cr6oajVYmGROIv2XVGnsYeFdaYh
	 4FVg+LvUSZISg==
Date: Thu, 11 Jul 2024 22:59:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, oleg@redhat.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org, clm@meta.com,
 paulmck@kernel.org
Subject: Re: [PATCH v2 04/11] perf/uprobe: RCU-ify find_uprobe()
Message-Id: <20240711225947.72717378bc039555f9345814@kernel.org>
In-Reply-To: <20240711110400.635302571@infradead.org>
References: <20240711110235.098009979@infradead.org>
	<20240711110400.635302571@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 13:02:39 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> With handle_swbp() triggering concurrently on (all) CPUs, tree_lock
> becomes a bottleneck. Avoid treelock by doing RCU lookups of the
> uprobe.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/events/uprobes.c |   49 +++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 40 insertions(+), 9 deletions(-)
> 
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -40,6 +40,7 @@ static struct rb_root uprobes_tree = RB_
>  #define no_uprobe_events()	RB_EMPTY_ROOT(&uprobes_tree)
>  
>  static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
> +static seqcount_rwlock_t uprobes_seqcount = SEQCNT_RWLOCK_ZERO(uprobes_seqcount, &uprobes_treelock);
>  
>  #define UPROBES_HASH_SZ	13
>  /* serialize uprobe->pending_list */
> @@ -54,6 +55,7 @@ DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem)
>  struct uprobe {
>  	struct rb_node		rb_node;	/* node in the rb tree */
>  	refcount_t		ref;
> +	struct rcu_head		rcu;
>  	struct rw_semaphore	register_rwsem;
>  	struct rw_semaphore	consumer_rwsem;
>  	struct list_head	pending_list;
> @@ -587,12 +589,25 @@ set_orig_insn(struct arch_uprobe *auprob
>  			*(uprobe_opcode_t *)&auprobe->insn);
>  }
>  
> +static struct uprobe *try_get_uprobe(struct uprobe *uprobe)
> +{
> +	if (refcount_inc_not_zero(&uprobe->ref))
> +		return uprobe;
> +	return NULL;
> +}
> +
>  static struct uprobe *get_uprobe(struct uprobe *uprobe)
>  {
>  	refcount_inc(&uprobe->ref);
>  	return uprobe;
>  }
>  
> +static void uprobe_free_rcu(struct rcu_head *rcu)
> +{
> +	struct uprobe *uprobe = container_of(rcu, struct uprobe, rcu);
> +	kfree(uprobe);
> +}
> +
>  static void put_uprobe(struct uprobe *uprobe)
>  {
>  	if (refcount_dec_and_test(&uprobe->ref)) {
> @@ -604,7 +619,7 @@ static void put_uprobe(struct uprobe *up
>  		mutex_lock(&delayed_uprobe_lock);
>  		delayed_uprobe_remove(uprobe, NULL);
>  		mutex_unlock(&delayed_uprobe_lock);
> -		kfree(uprobe);
> +		call_rcu(&uprobe->rcu, uprobe_free_rcu);
>  	}
>  }
>  
> @@ -653,10 +668,10 @@ static struct uprobe *__find_uprobe(stru
>  		.inode = inode,
>  		.offset = offset,
>  	};
> -	struct rb_node *node = rb_find(&key, &uprobes_tree, __uprobe_cmp_key);
> +	struct rb_node *node = rb_find_rcu(&key, &uprobes_tree, __uprobe_cmp_key);
>  
>  	if (node)
> -		return get_uprobe(__node_2_uprobe(node));
> +		return try_get_uprobe(__node_2_uprobe(node));
>  
>  	return NULL;
>  }
> @@ -667,20 +682,32 @@ static struct uprobe *__find_uprobe(stru
>   */
>  static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
>  {
> -	struct uprobe *uprobe;
> +	unsigned int seq;
>  
> -	read_lock(&uprobes_treelock);
> -	uprobe = __find_uprobe(inode, offset);
> -	read_unlock(&uprobes_treelock);
> +	guard(rcu)();
>  
> -	return uprobe;
> +	do {
> +		seq = read_seqcount_begin(&uprobes_seqcount);
> +		struct uprobe *uprobe = __find_uprobe(inode, offset);
> +		if (uprobe) {
> +			/*
> +			 * Lockless RB-tree lookups are prone to false-negatives.
> +			 * If they find something, it's good. If they do not find,
> +			 * it needs to be validated.
> +			 */
> +			return uprobe;
> +		}
> +	} while (read_seqcount_retry(&uprobes_seqcount, seq));
> +
> +	/* Really didn't find anything. */
> +	return NULL;
>  }
>  
>  static struct uprobe *__insert_uprobe(struct uprobe *uprobe)
>  {
>  	struct rb_node *node;
>  
> -	node = rb_find_add(&uprobe->rb_node, &uprobes_tree, __uprobe_cmp);
> +	node = rb_find_add_rcu(&uprobe->rb_node, &uprobes_tree, __uprobe_cmp);
>  	if (node)
>  		return get_uprobe(__node_2_uprobe(node));
>  
> @@ -702,7 +729,9 @@ static struct uprobe *insert_uprobe(stru
>  	struct uprobe *u;
>  
>  	write_lock(&uprobes_treelock);
> +	write_seqcount_begin(&uprobes_seqcount);
>  	u = __insert_uprobe(uprobe);
> +	write_seqcount_end(&uprobes_seqcount);
>  	write_unlock(&uprobes_treelock);
>  
>  	return u;
> @@ -936,7 +965,9 @@ static void delete_uprobe(struct uprobe
>  		return;
>  
>  	write_lock(&uprobes_treelock);
> +	write_seqcount_begin(&uprobes_seqcount);
>  	rb_erase(&uprobe->rb_node, &uprobes_tree);
> +	write_seqcount_end(&uprobes_seqcount);
>  	write_unlock(&uprobes_treelock);
>  	RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
>  	put_uprobe(uprobe);
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
