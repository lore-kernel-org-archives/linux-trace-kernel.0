Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C402314F98;
	Mon, 24 Mar 2025 02:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742783751; cv=none; b=jo4LKu1NUmc+Ev8U6oUsRCUpo+5wHYMuqtsgESE3dTzrDIcP46rcaZsbm+9tPL+CQFvrYm9hufc2d8hmPSqOD1Rbi6KIcXh88NDGS7i6JpscTjfq7WeuO39LMwCBZlPuiLTQDJXVHdDvtyUaAPQQk9IM9GuHdAM2lR779+/d/uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742783751; c=relaxed/simple;
	bh=xAFn0lYBGzrmag+aR3lSQ/jnbdF7nDNylnf7HpAI05U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IDesyb9R4mpa1MZ/DN4pQbTRn/2yL2PIeDFdhTRVvY5sjNX0mC68ZqpqvGTkKO7zhJbaUr364qDkpjYwhkLHhuWNPybnYLIk1J52kYsWLusYBfxteCsgdIvO25JDODWKGDz5LbQhSNAnk7TQe+/xlz4v/aT4+afxUf1kT5uTozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBAO8AHM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBAO8AHM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070CBC4CEE8;
	Mon, 24 Mar 2025 02:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742783751;
	bh=xAFn0lYBGzrmag+aR3lSQ/jnbdF7nDNylnf7HpAI05U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WBAO8AHMOxOeZjkDJmvhOuBONAVHCS2C3jtZSx/UZyEqFnCgQq0mLv49MYg5jJQD0
	 tiHHfXHdW7X4kclgspl7Q4PbT0bX0q54fnpSMWRhpdtu0KGw5jTiql5iFFne8+EoZO
	 +LZjhgRM3/wLA2kdJrnYcCeosHcVdQx0PNkF4ZgZ3kierqCR0keocHgRTLDp2fhEUL
	 z3FXwGKdTIbQneZCg0GBSg319fevISnYeEmYcHj248mCsApkOGiq1IXHmaa0ki9MTK
	 L/HLM8lqgcoSWMVu3DVZlSQogOF6WeErP45etQewAhQfeUzeHbvy6Hmpz0OUn1sAiQ
	 S8Z+AOflrHGYQ==
Date: Mon, 24 Mar 2025 11:35:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] tracing: Show last module text symbols in the
 stacktrace
Message-Id: <20250324113547.681fe2cd2f90a00a1e74c1a0@kernel.org>
In-Reply-To: <20250321125203.61585a02@batman.local.home>
References: <174230514441.2909896.16487286892751735867.stgit@mhiramat.tok.corp.google.com>
	<174230516153.2909896.11459658533253319657.stgit@mhiramat.tok.corp.google.com>
	<20250321125203.61585a02@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Mar 2025 12:52:03 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 18 Mar 2025 22:39:21 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> 
> > +/**
> > + * trace_adjust_address() - Adjust prev boot address to current address.
> > + * @tr: Persistent ring buffer's trace_array.
> > + * @addr: Address in @tr which is adjusted.
> > + */
> > +unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr)
> > +{
> > +	struct trace_scratch *tscratch;
> > +	struct trace_mod_entry *entry;
> > +	long *module_delta;
> > +	int idx = 0, nr_entries;
> > +
> > +	/* If we don't have last boot delta, return the address */
> > +	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
> > +		return addr;
> > +
> > +	tscratch = tr->scratch;
> > +	/* if there is no tscrach, module_delta must be NULL. */
> > +	module_delta = READ_ONCE(tr->module_delta);
> 
> What protects this from being freed after it is read?
> 
> > +	if (!module_delta || tscratch->entries[0].mod_addr > addr)
> > +		return addr + tr->text_delta;
> > +
> > +	/* Note that entries must be sorted. */
> > +	nr_entries = tscratch->nr_entries;
> > +	if (nr_entries == 1 ||
> > +	    tscratch->entries[nr_entries - 1].mod_addr < addr)
> > +		idx = nr_entries - 1;
> > +	else {
> > +		entry = __inline_bsearch((void *)addr,
> > +				tscratch->entries,
> > +				nr_entries - 1,
> > +				sizeof(tscratch->entries[0]),
> > +				cmp_mod_entry);
> > +		if (entry)
> > +			idx = entry - tscratch->entries;
> > +	}
> > +
> > +	return addr + module_delta[idx];
> > +}
> > +
> >  #ifdef CONFIG_MODULES
> >  static int save_mod(struct module *mod, void *data)
> >  {
> > @@ -6036,6 +6088,7 @@ static int save_mod(struct module *mod, void *data)
> >  static void update_last_data(struct trace_array *tr)
> >  {
> >  	struct trace_scratch *tscratch;
> > +	long *module_delta;
> >  
> >  	if (!(tr->flags & TRACE_ARRAY_FL_BOOT))
> >  		return;
> > @@ -6070,6 +6123,8 @@ static void update_last_data(struct trace_array *tr)
> >  		return;
> >  
> >  	tscratch = tr->scratch;
> > +	module_delta = READ_ONCE(tr->module_delta);
> 
> Say if a reader read tr->module_delta before the NULL write.
> 
> > +	WRITE_ONCE(tr->module_delta, NULL);
> >  
> >  	/* Set the persistent ring buffer meta data to this address */
> >  #ifdef CONFIG_RANDOMIZE_BASE
> > @@ -6078,6 +6133,8 @@ static void update_last_data(struct trace_array *tr)
> >  	tscratch->kaslr_addr = 0;
> >  #endif
> >  	tr->flags &= ~TRACE_ARRAY_FL_LAST_BOOT;
> > +
> > +	kfree(module_delta);
> 
> Why is this safe?
> 
> I don't see any synchronization between setting NULL and freeing this,
> like RCU would do.

Ah, I thought it is OK that module_delta = NULL for kfree(), but
there could be UAF case?  update_last_data() is protected by trace_types_lock,
so update_last_data() itself is serialized. But trace_adjust_address() is
not. Hmm, yeah, it is not enough checking by TRACE_ARRAY_FL_LAST_BOOT flag.

OK, then what about this?

- free module_delta with rcu_free()
- protect trace_adjust_address() by rcu_read_lock()

Thank you,

> 
> -- Steve
> 
> 
> >  }
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
