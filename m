Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CBB22424E;
	Fri, 21 Mar 2025 16:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575928; cv=none; b=W5GRf4somBS5iwnqZSRHXG3Z9nM4DEdW5H2fji+IHCyesN3dJzZYs3Gvo2F+aZsp6Je52xqU17qpV+PiCephK0/iQQIGlht3nQgd91/r0OezOz8MAUjlPp1qS1rUWkUUnoSSSYX9b9FvsKtKAq/pFyKRvQa+etsu8KWM84B8Cms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575928; c=relaxed/simple;
	bh=useTzo/q+bv3eroECGQhoSbUudJUBr4Yk/xpsMRuUCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puktvsDl0engnyNJoosJqXSSa7Epj1gYD+HCeXI2ZkRtPJSpjwy7mNzRHfHSAldDXR0/tCtv9PFBz1Ya5V0XqgctpauSlzKDCxHYqAtW/BTXMMDBR5dIizr1hTJl+irOhIL0b9MuV/1eXZp2qfZnRkohl6XpekGYmkKoOF52v2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4966C4CEE3;
	Fri, 21 Mar 2025 16:52:06 +0000 (UTC)
Date: Fri, 21 Mar 2025 12:52:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] tracing: Show last module text symbols in the
 stacktrace
Message-ID: <20250321125203.61585a02@batman.local.home>
In-Reply-To: <174230516153.2909896.11459658533253319657.stgit@mhiramat.tok.corp.google.com>
References: <174230514441.2909896.16487286892751735867.stgit@mhiramat.tok.corp.google.com>
	<174230516153.2909896.11459658533253319657.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 22:39:21 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:


> +/**
> + * trace_adjust_address() - Adjust prev boot address to current address.
> + * @tr: Persistent ring buffer's trace_array.
> + * @addr: Address in @tr which is adjusted.
> + */
> +unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr)
> +{
> +	struct trace_scratch *tscratch;
> +	struct trace_mod_entry *entry;
> +	long *module_delta;
> +	int idx = 0, nr_entries;
> +
> +	/* If we don't have last boot delta, return the address */
> +	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
> +		return addr;
> +
> +	tscratch = tr->scratch;
> +	/* if there is no tscrach, module_delta must be NULL. */
> +	module_delta = READ_ONCE(tr->module_delta);

What protects this from being freed after it is read?

> +	if (!module_delta || tscratch->entries[0].mod_addr > addr)
> +		return addr + tr->text_delta;
> +
> +	/* Note that entries must be sorted. */
> +	nr_entries = tscratch->nr_entries;
> +	if (nr_entries == 1 ||
> +	    tscratch->entries[nr_entries - 1].mod_addr < addr)
> +		idx = nr_entries - 1;
> +	else {
> +		entry = __inline_bsearch((void *)addr,
> +				tscratch->entries,
> +				nr_entries - 1,
> +				sizeof(tscratch->entries[0]),
> +				cmp_mod_entry);
> +		if (entry)
> +			idx = entry - tscratch->entries;
> +	}
> +
> +	return addr + module_delta[idx];
> +}
> +
>  #ifdef CONFIG_MODULES
>  static int save_mod(struct module *mod, void *data)
>  {
> @@ -6036,6 +6088,7 @@ static int save_mod(struct module *mod, void *data)
>  static void update_last_data(struct trace_array *tr)
>  {
>  	struct trace_scratch *tscratch;
> +	long *module_delta;
>  
>  	if (!(tr->flags & TRACE_ARRAY_FL_BOOT))
>  		return;
> @@ -6070,6 +6123,8 @@ static void update_last_data(struct trace_array *tr)
>  		return;
>  
>  	tscratch = tr->scratch;
> +	module_delta = READ_ONCE(tr->module_delta);

Say if a reader read tr->module_delta before the NULL write.

> +	WRITE_ONCE(tr->module_delta, NULL);
>  
>  	/* Set the persistent ring buffer meta data to this address */
>  #ifdef CONFIG_RANDOMIZE_BASE
> @@ -6078,6 +6133,8 @@ static void update_last_data(struct trace_array *tr)
>  	tscratch->kaslr_addr = 0;
>  #endif
>  	tr->flags &= ~TRACE_ARRAY_FL_LAST_BOOT;
> +
> +	kfree(module_delta);

Why is this safe?

I don't see any synchronization between setting NULL and freeing this,
like RCU would do.

-- Steve


>  }
> 
