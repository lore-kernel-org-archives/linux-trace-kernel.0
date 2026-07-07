Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09782348C70;
	Tue,  7 Jul 2026 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437264; cv=none; b=G/dGmSem2xqcmv7UPXu4HGPdSdoRLQlUm7kainNZ+VVfGC5JcNvXq9QbxLXF8cg1Ivx5IG+EOzhpIO7psvVsGvyCqykvh1VeDm5HuxqLXENQPKHCXx2XBZI/DLzcfRZuPMTiITkGOMjVhT9qJv/rIK5eq9sdkRD6LBKYkQF58Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437264; c=relaxed/simple;
	bh=HSak7QPdbaYKDPbofbC3f3ugOAa81eud4njBhRO89lE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JDViVJliBZQa8JDBTfScHdyyq8QraT01Etq+rzRTbuJE3P7m6n5iIEyEeuQFS16WL/l2K0IW6vzJRfAQIk9aoVJixcjWjgPmPdJoG6c+0/+qTnatpvldcmV19h2xRf61nrXG1FM4Y8GdcKdmlYWlAT3eUzngQSfFhwZo0H0k9LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 90D9D8DAB0;
	Tue,  7 Jul 2026 15:14:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 93AA080013;
	Tue,  7 Jul 2026 15:14:12 +0000 (UTC)
Date: Tue, 7 Jul 2026 11:14:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yuanhe Shu <xiangzao@linux.alibaba.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, "sashiko-bot@kernel.org"
 <sashiko-bot@kernel.org>, "sashiko-reviews@lists.linux.dev"
 <sashiko-reviews@lists.linux.dev>
Subject: Re: [PATCH] tracing: Fix NULL pointer dereference in
 func_set_flag()
Message-ID: <20260707111415.660f706b@gandalf.local.home>
In-Reply-To: <20260624061715.1445655-1-xiangzao@linux.alibaba.com>
References: <20260624061715.1445655-1-xiangzao@linux.alibaba.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1na5enskhkbw57cpmcad84hnqu3nrmb5
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 93AA080013
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Grlqimhawef4jRxoekUo1j+AlmOFoB3I=
X-HE-Tag: 1783437252-353159
X-HE-Meta: U2FsdGVkX18GDdMOd1Pysl31j3+ubjs/5N2yJ+WJBwAWfGA/isI4S9WFr42ZE30auxddwtOSyiPq/G5Lw81OQbDEeEJGY/KeByRS/Agh4qgWC0qZ2CiH2gbJQszePYwzwNCXehTPdMd0bpMXQmdFWrEpsAX4M39K2rXWzCrGEMA35Xxi/fjZeTj4GAcOXoUXvjW1gnsOFg8iALxMqHzzOQxrw+mxwYNMcXPdhcffsBv3mQDGgazqRiLDPrhtK2aFvPjn5ECgaL76nuNapNi2Q9p56KbM1Al8keFJqNZz2lxK1AGbyhsE7HoLzsnoK4JA49BtUbmvxv4GJhosxT1Kf970kIbXGJgUmemG9wCkfQgAT0dc4jVVM7RZGl0j3fJ7oaK/HbOGHEjA7Ez6G02y2RR9dPwAFbjKWZNeVXI2FBGucDZq22lPIw==


From: https://sashiko.dev/#/patchset/20260624061715.1445655-1-xiangzao%40linux.alibaba.com

> commit 2140381622b995438751cdb59eb4bae6923f6a60
> Author: Yuanhe Shu <xiangzao@linux.alibaba.com>
> tracing: Fix NULL pointer dereference in func_set_flag()
> This commit fixes a NULL pointer dereference in func_set_flag() by
> moving the tracer type check before dereferencing tr->current_trace_flags.
> > diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> > index f283391a4dc80..cd37f20137581 100644
> > --- a/kernel/trace/trace_functions.c
> > +++ b/kernel/trace/trace_functions.c
> > @@ -458,12 +458,12 @@ func_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
> >  	ftrace_func_t func;
> >  	u32 new_flags;
> >  
> > -	/* Do nothing if already set. */
> > -	if (!!set == !!(tr->current_trace_flags->val & bit))
> > +	/* We can change this flag only when current tracer is function. */
> > +	if (tr->current_trace != &function_trace)
> >  		return 0;
> >  
> > -	/* We can change this flag only when not running. */
> > -	if (tr->current_trace != &function_trace)
> > +	/* Do nothing if already set. */
> > +	if (!!set == !!(tr->current_trace_flags->val & bit))
> >  		return 0;
>
> This isn't a bug introduced by this patch, but while reviewing this fix for
> tr->current_trace_flags, I noticed a similar NULL pointer dereference
> can occur in print_graph_function() in kernel/trace/trace_functions_graph.c.
> If a user enables the function_graph tracer, populating the ring buffer
> with graph events, and then switches to a tracer that lacks flags and
> does not automatically clear the ring buffer (such as hwlat, osnoise, or
> timerlat), tr->current_trace_flags becomes NULL.
> When the user subsequently reads the trace buffer, the fallback event handler
> calls print_graph_function(), which unconditionally dereferences
> tr->current_trace_flags:
>
> kernel/trace/trace_functions_graph.c:print_graph_function() {
>     struct trace_array *tr = iter->tr;
>     return print_graph_function_flags(iter, tr->current_trace_flags->val);
> }
>
> Does this unconditional dereference of tr->current_trace_flags->val also
> need a similar safety check to prevent a kernel crash?

No, because even though hwlat, osnoise and timerlat may not clear the main
ring buffer, it reads it differently. Thus the print_graph_function will
not be called.

Unless you can figure out a way to get to that function with one of those
other tracers?

-- Steve
