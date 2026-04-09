Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B2A37C10C;
	Thu,  9 Apr 2026 10:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775730894; cv=none; b=cBjl8dOgt1xho/J/dVsm2PEMaW6k54WjKIR6iSZRC/q8XBa7o2b5RgQeo1lEDT15GLybC6Ulu0N99DpwVaIyp0BJ6WDQHQR5A1n+hAS4N2neuvxoAjx4ojW3yPBJlGgs2PiPPa2Hm4DS3crcgDnnXstseJyy8FVSdHik6gonZaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775730894; c=relaxed/simple;
	bh=TYbR6YNgEJ9OPB7a4kSY2YSUDCBSFQ5do4hn/+fq0a4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PBnq/kcnWAsmHv6FX+EL7R4ItXg1Hb/Hu77AoE/TFvApuDIpVoz9i8RVzLuJSbe2z2p8Unn7yI8VgJHKIHkovhOJeLS86EGUd0fMG62ozE+DeKz6F4rR9DOALa8dBwChKZoT8lo4GxLQqf55BVnt0L1BmwImG61vtQKpL60XXs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBg7LKP3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBg7LKP3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60247C4CEF7;
	Thu,  9 Apr 2026 10:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775730894;
	bh=TYbR6YNgEJ9OPB7a4kSY2YSUDCBSFQ5do4hn/+fq0a4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aBg7LKP3r8NEV/xakEQTOkI4qW68PyK3O6H0CmGDJ4OQxyGdvkmXI7Ofialci73rU
	 RbP/bXPo65UZLj5lgp+nlZ1DwGKpGSHWgAFWWS3ZmOI5bGvntFhHNc33WGOr6q6p/y
	 O2DVB+p10pCU9IAJlnY7UIW4OI7yyPMGK070GS4lEEoJABUNNroxBDRzwYkA0oAVGK
	 38GRAefsOvLcpmUo5PwFG+6eHqel0IhA7KAEuaGoW4Jo//g81lNaXpqN0uN1Y5GOcA
	 n9wr1NUZ+9A3xnSfhVdG7uCDgbV8ZwbFLURl/DQp0wLRkOH3CWhn71opmmXEu1zqfS
	 P8smM2GKIJWmA==
Date: Thu, 9 Apr 2026 19:34:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Menglong Dong
 <menglong8.dong@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, jiang.biao@linux.dev,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/fprobe: Check the same type fprobe on table as
 the unregistered one
Message-Id: <20260409193451.f57f409b88d61e8eb0cd0a02@kernel.org>
In-Reply-To: <20260408110237.08d982fab08356bc8d48af45@kernel.org>
References: <177555745233.1441308.6535024692186959381.stgit@mhiramat.tok.corp.google.com>
	<20260408110237.08d982fab08356bc8d48af45@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Apr 2026 11:02:37 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hmm,
> 
> I also found another problem when probing module with fprobe.
> 
> /sys/kernel/tracing # insmod xt_LOG.ko 
> /sys/kernel/tracing # echo 'f:test log_tg*' > dynamic_events 
> /sys/kernel/tracing # echo 1 > events/fprobes/test/enable 
> /sys/kernel/tracing # cat enabled_functions 
> log_tg [xt_LOG] (1)             tramp: 0xffffffffa0004000 (fprobe_ftrace_entry+0x0/0x490) ->fprobe_ftrace_entry+0x0/0x490
> log_tg_check [xt_LOG] (1)               tramp: 0xffffffffa0004000 (fprobe_ftrace_entry+0x0/0x490) ->fprobe_ftrace_entry+0x0/0x490
> log_tg_destroy [xt_LOG] (1)             tramp: 0xffffffffa0004000 (fprobe_ftrace_entry+0x0/0x490) ->fprobe_ftrace_entry+0x0/0x490
> /sys/kernel/tracing # wc -l enabled_functions 
> 3 enabled_functions
> /sys/kernel/tracing # rmmod xt_LOG
> /sys/kernel/tracing # wc -l enabled_functions 
> 34085 enabled_functions
> 
> It seems to reverse the selected functions if the hash is empty...

So I think there are several ways to fix this issue.

 - Introduce a new flag for ftrace_ops, which is "empty means empty".

 - Improve ftrace to automatically remove module function entries
   from registered ftrace_ops. (currently it is done for the ftrace_ops
   in trace_array list, but not for ftrace_ops list.)

 - While walking over the fprobe_ip_tables, try to find existing
   enabled fprobe node. If it does not exist, unregister ftrace_ops.

 - Count the ftrace_ops hash table size and if it is expected to be 0,
   unregister the ftrace_ops.

The first 2 are changing ftrace (but cleaner). The latter 2 only
changes fprobes, but relatively ugly. I think the 2nd one will be
the best because we already have done for ftrace_ops of ring-buffer
instances.

Thanks,


> 
> Thanks,
> 
> On Tue,  7 Apr 2026 19:24:12 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Commit 2c67dc457bc6 ("tracing: fprobe: optimization for entry only case")
> > introduced a different ftrace_ops for entry-only fprobes.
> > 
> > However, when unregistering an fprobe, the kernel only checks if another
> > fprobe exists at the same address, without checking which type of fprobe
> > it is.
> > If different fprobes are registered at the same address, the same address
> > will be registered in both fgraph_ops and ftrace_ops, but only one of
> > them will be deleted when unregistering. (the one removed first will not
> > be deleted from the ops).
> > 
> > This results in junk entries remaining in either fgraph_ops or ftrace_ops.
> > For example:
> >  =======
> >  cd /sys/kernel/tracing
> > 
> >  # 'Add entry and exit events on the same place'
> >  echo 'f:event1 vfs_read' >> dynamic_events
> >  echo 'f:event2 vfs_read%return' >> dynamic_events
> > 
> >  # 'Enable both of them'
> >  echo 1 > events/fprobes/enable
> >  cat enabled_functions
> > vfs_read (2)            ->arch_ftrace_ops_list_func+0x0/0x210
> > 
> >  # 'Disable and remove exit event'
> >  echo 0 > events/fprobes/event2/enable
> >  echo -:event2 >> dynamic_events
> > 
> >  # 'Disable and remove all events'
> >  echo 0 > events/fprobes/enable
> >  echo > dynamic_events
> > 
> >  # 'Add another event'
> >  echo 'f:event3 vfs_open%return' > dynamic_events
> >  cat dynamic_events
> > f:fprobes/event3 vfs_open%return
> > 
> >  echo 1 > events/fprobes/enable
> >  cat enabled_functions
> > vfs_open (1)            tramp: 0xffffffffa0001000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60    subops: {ent:fprobe_fgraph_entry+0x0/0x620 ret:fprobe_return+0x0/0x150}
> > vfs_read (1)            tramp: 0xffffffffa0001000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60    subops: {ent:fprobe_fgraph_entry+0x0/0x620 ret:fprobe_return+0x0/0x150}
> >  =======
> > 
> > As you can see, an entry for the vfs_read remains.
> > 
> > To fix this issue, when unregistering, the kernel should also check if
> > there is the same type of fprobes still exist at the same address, and
> > if not, delete its entry from either fgraph_ops or ftrace_ops.
> > 
> > Fixes: 2c67dc457bc6 ("tracing: fprobe: optimization for entry only case")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/fprobe.c |   77 +++++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 62 insertions(+), 15 deletions(-)
> > 
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index dcadf1d23b8a..7f75e6e4462c 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -85,11 +85,9 @@ static int insert_fprobe_node(struct fprobe_hlist_node *node)
> >  	return rhltable_insert(&fprobe_ip_table, &node->hlist, fprobe_rht_params);
> >  }
> >  
> > -/* Return true if there are synonims */
> > -static bool delete_fprobe_node(struct fprobe_hlist_node *node)
> > +static void delete_fprobe_node(struct fprobe_hlist_node *node)
> >  {
> >  	lockdep_assert_held(&fprobe_mutex);
> > -	bool ret;
> >  
> >  	/* Avoid double deleting */
> >  	if (READ_ONCE(node->fp) != NULL) {
> > @@ -97,13 +95,6 @@ static bool delete_fprobe_node(struct fprobe_hlist_node *node)
> >  		rhltable_remove(&fprobe_ip_table, &node->hlist,
> >  				fprobe_rht_params);
> >  	}
> > -
> > -	rcu_read_lock();
> > -	ret = !!rhltable_lookup(&fprobe_ip_table, &node->addr,
> > -				fprobe_rht_params);
> > -	rcu_read_unlock();
> > -
> > -	return ret;
> >  }
> >  
> >  /* Check existence of the fprobe */
> > @@ -337,6 +328,32 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
> >  	return !fp->exit_handler;
> >  }
> >  
> > +static bool fprobe_exists_on_hash(unsigned long ip, bool ftrace)
> > +{
> > +	struct rhlist_head *head, *pos;
> > +	struct fprobe_hlist_node *node;
> > +	struct fprobe *fp;
> > +
> > +	guard(rcu)();
> > +	head = rhltable_lookup(&fprobe_ip_table, &ip,
> > +				fprobe_rht_params);
> > +	if (!head)
> > +		return false;
> > +	/* We have to check the same type on the list. */
> > +	rhl_for_each_entry_rcu(node, pos, head, hlist) {
> > +		if (node->addr != ip)
> > +			break;
> > +		fp = READ_ONCE(node->fp);
> > +		if (likely(fp)) {
> > +			if ((!ftrace && fp->exit_handler) ||
> > +			    (ftrace && !fp->exit_handler))
> > +				return true;
> > +		}
> > +	}
> > +
> > +	return false;
> > +}
> > +
> >  #ifdef CONFIG_MODULES
> >  static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove,
> >  			   int reset)
> > @@ -360,6 +377,29 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
> >  	return false;
> >  }
> >  
> > +static bool fprobe_exists_on_hash(unsigned long ip, bool ftrace __maybe_unused)
> > +{
> > +	struct rhlist_head *head, *pos;
> > +	struct fprobe_hlist_node *node;
> > +	struct fprobe *fp;
> > +
> > +	guard(rcu)();
> > +	head = rhltable_lookup(&fprobe_ip_table, &ip,
> > +				fprobe_rht_params);
> > +	if (!head)
> > +		return false;
> > +	/* We only need to check fp is there. */
> > +	rhl_for_each_entry_rcu(node, pos, head, hlist) {
> > +		if (node->addr != ip)
> > +			break;
> > +		fp = READ_ONCE(node->fp);
> > +		if (likely(fp))
> > +			return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> >  #ifdef CONFIG_MODULES
> >  static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove,
> >  			   int reset)
> > @@ -574,15 +614,20 @@ static int fprobe_addr_list_add(struct fprobe_addr_list *alist, unsigned long ad
> >  static void fprobe_remove_node_in_module(struct module *mod, struct fprobe_hlist_node *node,
> >  					 struct fprobe_addr_list *alist)
> >  {
> > +	lockdep_assert_in_rcu_read_lock();
> > +
> >  	if (!within_module(node->addr, mod))
> >  		return;
> > -	if (delete_fprobe_node(node))
> > -		return;
> > +
> > +	delete_fprobe_node(node);
> >  	/*
> > -	 * If failed to update alist, just continue to update hlist.
> > +	 * Ignore failure of updating alist, but continue to update hlist.
> >  	 * Therefore, at list user handler will not hit anymore.
> > +	 * And don't care the type here, because all fprobes on the same
> > +	 * address must be removed eventually.
> >  	 */
> > -	fprobe_addr_list_add(alist, node->addr);
> > +	if (!rhltable_lookup(&fprobe_ip_table, &node->addr, fprobe_rht_params))
> > +		fprobe_addr_list_add(alist, node->addr);
> >  }
> >  
> >  /* Handle module unloading to manage fprobe_ip_table. */
> > @@ -943,7 +988,9 @@ int unregister_fprobe(struct fprobe *fp)
> >  	/* Remove non-synonim ips from table and hash */
> >  	count = 0;
> >  	for (i = 0; i < hlist_array->size; i++) {
> > -		if (!delete_fprobe_node(&hlist_array->array[i]))
> > +		delete_fprobe_node(&hlist_array->array[i]);
> > +		if (!fprobe_exists_on_hash(hlist_array->array[i].addr,
> > +					   fprobe_is_ftrace(fp)))
> >  			addrs[count++] = hlist_array->array[i].addr;
> >  	}
> >  	del_fprobe_hash(fp);
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
