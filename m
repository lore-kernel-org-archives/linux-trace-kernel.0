Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC0728F5;
	Wed, 18 Jun 2025 03:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750215628; cv=none; b=lGbcwPF+9AaD7z36CGYynCZPb9M5H6smPr4kY75A/V2bLNLQj4BYPXkGh3GFd3uDxcBbZSqQpzvZWCx5xk03E21zPgJTGHALVIgrsIluEhsCW47KQfiP0VYfpjVgGFQjoFa8FTmM2eeRg6/S9/U1FYymSA3kRP9MXamx+D7mvQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750215628; c=relaxed/simple;
	bh=9wc5jRY5rLEMxwr49N7ddLKbSh0kSv0kAEPoZVEa3+w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iy1SJrcI6ARd6qjaLTwoWdOz9I57iyAVMTv0hxVLxFq0QgzGZNjtJOwHffyv5s8lOZRf9UMTiBZIXDpM4iHueBzXxX3W7Q80rMjVy3qVKi3+h8dvT2C5jLwZjZnMchAYVe1eGA7dbdRBOV43/q7M0cdCW1euoSEKYChNkv52ucM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 0039A161A80;
	Wed, 18 Jun 2025 03:00:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 2CCA61C;
	Wed, 18 Jun 2025 03:00:18 +0000 (UTC)
Date: Tue, 17 Jun 2025 23:00:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: duchangbin <changbin.du@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] fgraph: Do not enable function_graph tracer when
 setting funcgraph-args
Message-ID: <20250617230024.322758dc@gandalf.local.home>
In-Reply-To: <ad0745b53e5046b79378bdc12ddfdd51@huawei.com>
References: <20250617120830.24fbdd62@gandalf.local.home>
	<ad0745b53e5046b79378bdc12ddfdd51@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: uwywh6gmmid5rnp6izj7nwosewmdkk19
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 2CCA61C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX187zWngaOSMo2W3DS+ig99B503hNMQcEWE=
X-HE-Tag: 1750215618-978374
X-HE-Meta: U2FsdGVkX1/+GHGpiUbSjHCNqwS4a/YB2HixuKWW/3DZ/bnTaQe+Qg3H6v1ur2Y+IEr6pTs2Q4lgVJnZhFaGSa82bz3kPEEkw5lLpkgFH91Diw/0FfJMJu4rYViIYzIsiFGAwu15kn/xi6LRKtAZBi1mKAQxsXJy2JmtPyqRnROzxHCiDakeJDAZg8yT/ygG0oKXJnoGIf/ZwVsBAbVRtGdQF7mQEJUqSjzXSzARNIok5o55Ue8w2/44S8n+tyockqNca98RV2eULrDiVVd16e5P4Srz5W2nsJTSOypFx7B/Sruto7vfYR6lEx52zfv53c4JfjwrNXP0hwhANwD6eChcDH7g5xo7

On Wed, 18 Jun 2025 02:40:21 +0000
duchangbin <changbin.du@huawei.com> wrote:

> > diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> > index 9234e2c39abf..b6211c304c7f 100644
> > --- a/kernel/trace/trace_functions_graph.c
> > +++ b/kernel/trace/trace_functions_graph.c
> > @@ -455,10 +455,16 @@ static int graph_trace_init(struct trace_array *tr)
> >  	return 0;
> >  }
> >  
> > +static struct tracer graph_trace;
> > +
> >  static int ftrace_graph_trace_args(struct trace_array *tr, int set)
> >  {
> >  	trace_func_graph_ent_t entry;
> >  
> > +	/* Do nothing if the current tracer is no this tracer */  
> typo: no -> not

Oops, thanks.

> 
> > +	if (tr->current_trace != &graph_trace)
> > +		return 0;
> > +  
> This can fix the issue. But how are tr->current_trace and &graph_trace linked?
> When are they equal?

register_tracer() passes in what tr->current_trace gets set to when the
tracer is active.

-- Steve


> 
> >  	if (set)
> >  		entry = trace_graph_entry_args;
> >  	else
> > -- 
> > 2.47.2
