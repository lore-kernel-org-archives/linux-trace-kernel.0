Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A6F304964;
	Fri, 21 Nov 2025 23:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763769370; cv=none; b=XphHvtO2Vh0wOcVTpnH43Xdm9XvFMq7PI/JPilOWygYYuDDc2ypXfe5uWrA0cfqJ1AjN9wUAQIXs4uaFsUlJkYT6/lPIRb1xx9nZyhZYncinhzYQaaA172sFvweaRj0v2S1DN134wvJ91EMTIL6qGVZ9MuNma+i/yK2bLLMPrnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763769370; c=relaxed/simple;
	bh=hFS1H7s+n6wxx4sNWsBn9U9gqltc8N9oalZyrh3BJB8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=stgrLor4KIUrejtCDznkLtYwCQsJ+PgVNRb5N3xvlvGJ+PRED0dM0BZeF+wfQ0I87Yp8biD75f8GeL5JsdeVJgBCv3i8ZmGjk1yWL3zI7YY23DLO1KCeGbR8615AatzaOdeJFOOsHlRt5qdnw/XsFe8vpIpmP0VUZJoswUoA6tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBvDZ4yX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBvDZ4yX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA709C4CEF1;
	Fri, 21 Nov 2025 23:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763769368;
	bh=hFS1H7s+n6wxx4sNWsBn9U9gqltc8N9oalZyrh3BJB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hBvDZ4yX4oYyVeitxkfBjXvTuap7ljWLZD5PReKxHiroaJQT5xI4sRt39Kf61dQ0t
	 p6Xl/ak6Fe1DMi5aGwPCAdrUnimj4LvKAm6PREcwWA08cNxjidaucyc4IAd9jWCxma
	 CTUTRnX7wqCeLwK200cYstpgTMlZQYdl3T6ndVk9I6Is8yXbTDhlg4sSDxfGPiJB1d
	 rqpCO5Ti+dfQ74YZAM6v0vUIcnsYlcJMaFZRmivvqLIoO4NEjrHajfKHqfOhbA1Xdp
	 2vrXbe8NiCBe54y516sH2wi0+aX38xENbcPE37wS6kc+ksNwhaZXPuJrFBGXMoOoJr
	 vfnchvqcU9Z2Q==
Date: Sat, 22 Nov 2025 08:56:04 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Add boot-time backup of persistent ring buffer
Message-Id: <20251122085604.5ed2625d37666601a4d93cc6@kernel.org>
In-Reply-To: <20251121134840.0a92f49a@gandalf.local.home>
References: <176370846529.314463.7508792463190591259.stgit@mhiramat.tok.corp.google.com>
	<20251121134840.0a92f49a@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Nov 2025 13:48:40 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 21 Nov 2025 16:01:05 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++---
> >  kernel/trace/trace.h |    1 +
> >  2 files changed, 55 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 33fcde91924c..616d24580371 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -10523,6 +10523,8 @@ static int __remove_instance(struct trace_array *tr)
> >  		reserve_mem_release_by_name(tr->range_name);
> >  		kfree(tr->range_name);
> >  	}
> > +	if (tr->flags & TRACE_ARRAY_FL_VMALLOC)
> > +		vfree((void *)tr->range_addr_start);
> 
> The ring buffer user space mapping expects the ring buffer to be real
> memory. Thus, virtual mapping is not supported. Either we need to allocate
> normal memory, or the mmap function of his array must return an error.

Hmm, I think allocating contiguous memory at boot is not realistic,
and mmap support is a lower priority than a single copy at boot time.

> >  
> >  	for (i = 0; i < tr->nr_topts; i++) {
> >  		kfree(tr->topts[i].topts);
> > @@ -11328,6 +11330,41 @@ __init static void do_allocate_snapshot(const char *name)
> >  static inline void do_allocate_snapshot(const char *name) { }
> >  #endif
> >  
> > +__init static int backup_instance_area(const char *backup,
> > +				       unsigned long *addr, phys_addr_t *size)
> > +{
> > +	struct trace_array *backup_tr;
> > +	void *allocated_vaddr = NULL;
> > +
> > +	backup_tr = trace_array_get_by_name(backup, NULL);
> > +	if (!backup_tr) {
> > +		pr_warn("Tracing: Instance %s is not found.\n", backup);
> > +		return -ENOENT;
> > +	}
> 
> Add space.

OK

> 
> > +	if (!(backup_tr->flags & TRACE_ARRAY_FL_BOOT)) {
> > +		pr_warn("Tracing: Instance %s is not boot mapped.\n", backup);
> > +		trace_array_put(backup_tr);
> > +		return -EINVAL;
> > +	}
> > +
> > +	*size = backup_tr->range_addr_size;
> > +
> > +	allocated_vaddr = vzalloc(*size);
> > +	if (!allocated_vaddr) {
> > +		pr_warn("Tracing: Failed to allocate memory for copying instance %s (size 0x%lx)\n",
> > +			backup, (unsigned long)*size);
> > +		trace_array_put(backup_tr);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	memcpy(allocated_vaddr,
> > +		(void *)backup_tr->range_addr_start, (size_t)*size);
> > +	*addr = (unsigned long)allocated_vaddr;
> > +
> > +	trace_array_put(backup_tr);
> > +	return 0;
> > +}
> > +
> >  __init static void enable_instances(void)
> >  {
> >  	struct trace_array *tr;
> > @@ -11350,11 +11387,15 @@ __init static void enable_instances(void)
> >  		char *flag_delim;
> >  		char *addr_delim;
> >  		char *rname __free(kfree) = NULL;
> > +		char *backup;
> >  
> >  		tok = strsep(&curr_str, ",");
> >  
> > -		flag_delim = strchr(tok, '^');
> > -		addr_delim = strchr(tok, '@');
> > +		name = strsep(&tok, "=");
> > +		backup = tok;
> > +
> > +		flag_delim = strchr(name, '^');
> > +		addr_delim = strchr(name, '@');
> >  
> >  		if (addr_delim)
> >  			*addr_delim++ = '\0';
> > @@ -11362,7 +11403,10 @@ __init static void enable_instances(void)
> >  		if (flag_delim)
> >  			*flag_delim++ = '\0';
> >  
> > -		name = tok;
> > +		if (backup) {
> > +			if (backup_instance_area(backup, &addr, &size) < 0)
> > +				continue;
> > +		}
> >  
> >  		if (flag_delim) {
> >  			char *flag;
> > @@ -11458,7 +11502,13 @@ __init static void enable_instances(void)
> >  			tr->ref++;
> >  		}
> >  
> > -		if (start) {
> > +		/*
> > +		 * Backup buffers can be freed but need vfree().
> > +		 */
> > +		if (backup)
> > +			tr->flags |= TRACE_ARRAY_FL_VMALLOC;
> > +
> > +		if (start || backup) {
> >  			tr->flags |= TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT;
> >  			tr->range_name = no_free_ptr(rname);
> >  		}
> 
> This would then need:
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index d1e527cf2aae..104e385e718e 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8791,8 +8791,8 @@ static int tracing_buffers_mmap(struct file *filp, struct vm_area_struct *vma)
>  	struct trace_iterator *iter = &info->iter;
>  	int ret = 0;
>  
> -	/* A memmap'ed buffer is not supported for user space mmap */
> -	if (iter->tr->flags & TRACE_ARRAY_FL_MEMMAP)
> +	/* A memmap'ed and backup buffers are not supported for user space mmap */
> +	if (iter->tr->flags & (TRACE_ARRAY_FL_MEMMAP | TRACE_ARRAY_FL_VMALLOC))
>  		return -ENODEV;
>  
>  	ret = get_snapshot_map(iter->tr);
> 

Ah, thanks for the code :)

> 
> As without it, when I tried mmapping the backup buffer I got this;
> 
> [  251.615441] BUG: unable to handle page fault for address: ffffd1c31e0000c8
> [  251.615447] #PF: supervisor read access in kernel mode
> [  251.615449] #PF: error_code(0x0000) - not-present page
> [  251.615451] PGD 0 P4D 0 
> [  251.615456] Oops: Oops: 0000 [#1] SMP PTI
> [  251.615463] CPU: 6 UID: 0 PID: 1450 Comm: mmap-rb-lib Not tainted 6.18.0-rc3-ftest-00018-g02548113c2f6 #287 PREEMPT_{RT,LAZY} 
> [  251.615469] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> [  251.615471] RIP: 0010:validate_page_before_insert+0x5/0x90
> [  251.615479] Code: 48 c1 e8 0e 89 c2 83 e2 01 89 d0 c3 cc cc cc cc 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 <48> 8b 46 08 a8 01 75 5d 66 90 48 89 f0 8b 50 34 85 d2 74 68 48 89
> [  251.615481] RSP: 0018:ffffa52b443d7988 EFLAGS: 00010246
> [  251.615484] RAX: ffff8a84dcac4000 RBX: 00007f07e0c10000 RCX: 0000000108d2f067
> [  251.615486] RDX: 0000000108d2f067 RSI: ffffd1c31e0000c0 RDI: ffff8a84dd865700
> [  251.615487] RBP: 0000000000000000 R08: 000000005ab70715 R09: 0000000000000009
> [  251.615489] R10: 0000000000000009 R11: ffff8a84c9320fb8 R12: ffff8a84dd865700
> [  251.615490] R13: 0000000000000000 R14: ffffd1c31e0000c0 R15: ffff8a84c8d2f080
> [  251.615492] FS:  00007f07e0e8e740(0000) GS:ffff8a86afbb7000(0000) knlGS:0000000000000000
> [  251.615494] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  251.615496] CR2: ffffd1c31e0000c8 CR3: 000000011c390006 CR4: 0000000000170ef0
> [  251.615501] Call Trace:
> [  251.615502]  <TASK>
> [  251.615504]  vm_insert_pages+0x157/0x360
> [  251.615513]  __rb_map_vma+0x1ef/0x390
> [  251.615521]  ring_buffer_map+0x261/0x370
> [  251.615527]  tracing_buffers_mmap+0x7e/0x100
> [  251.615532]  __mmap_region+0x831/0xe00
> [  251.615554]  do_mmap+0x4bf/0x6b0
> [  251.615560]  vm_mmap_pgoff+0x126/0x230
> [  251.615569]  ksys_mmap_pgoff+0x162/0x220
> [  251.615573]  do_syscall_64+0x76/0x9a0
> [  251.615581]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  251.615584] RIP: 0033:0x7f07e0f9dde2
> [  251.615589] Code: 00 00 00 0f 1f 44 00 00 
> 
> -- Steve
> 
> 
> > diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> > index 58be6d741d72..9e5186c96e9c 100644
> > --- a/kernel/trace/trace.h
> > +++ b/kernel/trace/trace.h
> > @@ -453,6 +453,7 @@ enum {
> >  	TRACE_ARRAY_FL_LAST_BOOT	= BIT(2),
> >  	TRACE_ARRAY_FL_MOD_INIT		= BIT(3),
> >  	TRACE_ARRAY_FL_MEMMAP		= BIT(4),
> > +	TRACE_ARRAY_FL_VMALLOC		= BIT(5),
> >  };
> >  
> >  #ifdef CONFIG_MODULES
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
