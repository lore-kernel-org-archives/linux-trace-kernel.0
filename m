Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6434A4821
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365678; cv=none; b=WJYi/ryfiHPlFmpQ+UMavWskR8j3iiCsiQCY4nlkOvzzZal8yRlrKHjmYs+GIOGjQMLk2k4yI/GKAuzSNt3/pXkQMLvkDMEtlTVGbBkq/P2LTF1aDwmUNAVT1d3tdMgwiAHbwz7IcAtfW8HlixwDUYj9MYpbR/DwWs2JRQL9ffA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365678; c=relaxed/simple;
	bh=LrnTiATodKIjWKRDIv4ElAvxo/d4BQOsumIuUq0rCAU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ppWuZf6juahuD7ta4H5/HnzoRkpBBOvgrf100TDoPNaFnaEqFKmUcHKNnHhm7T04xuwBx82pyhVbjQFW63tdABN8/lnry0YOcupn7/6rYgjXjjAh6sIbrN9zNzTkH2OHiAUSpcrpgNoB6aVO8tZKqDmRHj09wzbgIJ0ZS2lEVws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=Emb5gaYV; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="Emb5gaYV"
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 2BA9BC0246;
	Wed,  2 Sep 2026 16:14:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 924142E;
	Wed,  2 Sep 2026 16:14:26 +0000 (UTC)
Date: Wed, 2 Sep 2026 12:15:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Take trace_array reference when opening
 options file
Message-ID: <20260902121527.5dd570f1@gandalf.local.home>
In-Reply-To: <20260902160208.12BE51F000E9@smtp.kernel.org>
References: <20260902114502.723d8243@gandalf.local.home>
	<20260902160208.12BE51F000E9@smtp.kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zscdojjhkyzadznbtcrmuxwnxkt8aikr
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 924142E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+r9pViHn10AQUfLtwvMOvN6UzmYIP48/c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=64Z4TXYbX6k5raPc0LziLia4jXpu+NuEyRr2f47P1gM=; b=Emb5gaYV2GL5leKLtFy2ymPELZ0udIWd5XgBvz7YoeAWF00pwFc5HC0xEcOYIwyZEOXa57KpvqVClpG3/NPv+mfw8+e23VBM9OUh8pag+TdypCU981wLC6Q3hacwicFdolYjPyF4fnNopiTzfUxWiIG/fLvmSOzyYHX19lnu/Kc=
X-HE-Tag: 1788365666-120534
X-HE-Meta: U2FsdGVkX18zdKVyHoAC2FJuNLLebtw31Le5avm2M1x3fNwcDFW5M5BrYmohk2yf0Okr+YY0azAyXeZXedd3b8pIytP29iSdewquXb/4U7BrsMaq1tOeyjY9iGekRS6C3uBJU6TT0Lta6qwLW2PBBD+Ruz2gZSaxx+i31JjtR8txBFuJY53P0PaCmLzzMvra+J5OCVXP+oSaMuS4H0M0MvxKpdkyyfK/VMnwCQt8YN9waf8bn9pgzq4Sn/ViFsjGD9q2+i9HHkV9EANRj1Rk9baD9bOUwl29SXqLD/0kQ5OF2SLqVYMf6eqo0/qnni+zj4y/h8r65hG4jrUomlweNK9j8LirgXxM

On Wed, 02 Sep 2026 16:02:07 +0000
sashiko-bot@kernel.org wrote:

> 
> [Severity: Low]
> Does the pointer comparison in the code still trigger a compiler warning?
> The patch notes mention adding a (void *) typecast to fix a kernel test
> robot warning, but the cast appears to be missing from the submitted code.
> 

Bah! I forgot to hit git commit -a --amend before sending the patch!


> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index d3005279165d9..3e001ed8cf376 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c  
> 
> [ ... ]
> 
> > +static int trace_array_options_get(void *tr_index)
> > +{
> > +	struct trace_array *tr;
> > +	int ret;
> > +
> > +	ret = security_locked_down(LOCKDOWN_TRACEFS);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (tracing_disabled)
> > +		return -ENODEV;
> > +
> > +	guard(mutex)(&trace_types_lock);
> > +	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> > +		if (tr_index >= &tr->trace_flags_index[0] &&
> > +		    tr_index < &tr->trace_flags_index[TRACE_FLAGS_MAX_SIZE])  
> 
> [Severity: Critical]
> This is a pre-existing issue, but does this validation logic remain
> vulnerable to an ABA (slab reuse) problem? If an unprivileged user holds
> an O_PATH file descriptor to a freed instance's options file, the inode
> is kept alive with a dangling i_private pointer.
> 
> If a new instance is created and allocated at the exact same memory
> address, wouldn't this bounds check falsely succeed on the dangling
> pointer, granting read and write access to the new (potentially root-created)
> trace_array options? This same ABA flaw seems to exist in the general
> trace_array_get() function as well.

As said before, we don't care.

> 
> > +			return __trace_array_get(tr);  
> 
> [Severity: Low]
> Is __trace_array_get() defined anywhere in the kernel? It looks like
> this might cause a build failure because the function is neither declared
> nor defined.
> 
> > +	}
> > +	return -ENODEV;
> > +}  
> 
> [ ... ]
> 
> >  static const struct file_operations trace_options_core_fops = {
> > -	.open = tracing_open_generic,
> > -	.read = trace_options_core_read,
> > -	.write = trace_options_core_write,
> > -	.llseek = generic_file_llseek,
> > +	.open		= trace_options_open,
> > +	.read		= trace_options_core_read,
> > +	.write		= trace_options_core_write,
> > +	.llseek		= generic_file_llseek,
> > +	.release	= trace_options_release,
> >  };  
> 
> [Severity: Critical]
> This is a pre-existing issue, but by only updating trace_options_core_fops,
> do tracer-specific options and other per-instance files remain vulnerable
> to the exact same use-after-free? 
> 
> Files like trace_options_fops, set_tracer_fops, and tracing_max_lat_fops
> still use tracing_open_generic for their open callbacks, which fails to
> take a reference to the instance's trace_array.
> 

The trace_options_fops does indeed have the issue as it uses topts->tr
where it can not trust the topts. But set_tracer_fops and
tracing_max_lat_fops use tracing_open_generic_tr().

Are you using the master branch of the repo? That's from 2022 and very old.

I'll set the default branch to be the for-next branch so hopefully you
don't report old bugs that have been fixed a long time ago anymore.

-- Steve


