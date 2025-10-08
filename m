Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7743F63CB;
	Wed,  8 Oct 2025 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759937118; cv=none; b=Got56CEozBdGmxiE76a9rUG3fE9raqwyKuui7LsWKHpDdSIp88nIEjvfc8LGdFT+YJWoLfDGPWJaCgjtvzeUJY7Ur9hrQdw57/eaRes050PYm1+QLjU8GxKrsOiBluKIH0dsd/M8nqKxi75gMMtPjD5y2su11UfU+behzPjbV4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759937118; c=relaxed/simple;
	bh=tf2OZBz7Fn2v7rVfb+J3dUP+sJ+ddhlD32tR0HcCvRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+9gnRH4DO1XkvHhDXkEEMyegFxcSWyip1VSPfOgD0zqqKL4nwlSaEJEkyftzORbCRKz4yVVYaSuJ7opMxUxVBiBJrqVOiNnnSnT77kirrq8KF3KsMLMYj5BGSf+PLF2fJ+6pGOysprfoX74IYz6SbjY3bD0fu2nHiWABM7Xxc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id BFB5B11A8D1;
	Wed,  8 Oct 2025 15:25:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 102C520026;
	Wed,  8 Oct 2025 15:25:05 +0000 (UTC)
Date: Wed, 8 Oct 2025 11:27:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sasha Levin <sashal@kernel.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing/irqsoff: Balance prolog on fgraph failure
Message-ID: <20251008112700.622df439@gandalf.local.home>
In-Reply-To: <20251006175848.1906912-2-sashal@kernel.org>
References: <20251006175848.1906912-1-sashal@kernel.org>
	<20251006175848.1906912-2-sashal@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 71bcmj9zymdz3bonjfb6bm5m36msntid
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 102C520026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18m/61Q64YlzFsn+00d5PucbweZ647RzXE=
X-HE-Tag: 1759937105-918818
X-HE-Meta: U2FsdGVkX1+g/oesg4HIQZkame07Pv77CKJ/t1FzvbaJ8KmMYr6GxTiZ6Nz45FsZCvH8o5zuAMEwQCc3geQNGCTmhvMpho81G2BfY+SEG2dPX7Zx/j/Wi7sQ7U7wi8jX4MHRA3m+pW8eHLZf+T5SYuXbTXPiMRdp+BJJ3J+9XkkqyZogqDnYhmsFamrVqP1UEUHIkqSjK7Nj1C/reNY+vJIl9p2iwvI/GDhNNEyoWGb1LLbOWIbmRaV+lUWKX7mB1Hygs1VIqX+rp/U1IUq+N2HDAyl3qi5P1SvLLzzkAaEJXKBvnjZ3p1n3k1eIlOZUqEVF14UkNFtgEt9H1YEaB9xn0I0SzKeE

On Mon,  6 Oct 2025 13:58:48 -0400
Sasha Levin <sashal@kernel.org> wrote:

> diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
> index 5496758b6c760..39152ef3d2432 100644
> --- a/kernel/trace/trace_irqsoff.c
> +++ b/kernel/trace/trace_irqsoff.c
> @@ -202,8 +202,10 @@ static int irqsoff_graph_entry(struct ftrace_graph_ent *trace,
>  		return 0;
>  
>  	calltime = fgraph_reserve_data(gops->idx, sizeof(*calltime));
> -	if (!calltime)
> +	if (!calltime) {
> +		local_dec(&data->disabled);
>  		return 0;
> +	}
>  
>  	*calltime = trace_clock_local();
>  
> @@ -233,8 +235,10 @@ static void irqsoff_graph_return(struct ftrace_graph_ret *trace,
>  
>  	rettime = trace_clock_local();
>  	calltime = fgraph_retrieve_data(gops->idx, &size);
> -	if (!calltime)
> +	if (!calltime) {
> +		local_dec(&data->disabled);
>  		return;
> +	}
>  
>  	trace_ctx = tracing_gen_ctx_flags(flags);
>  	__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
> -- 

Technically correct, but this would look better:

diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 5496758b6c76..4c45c49b06c8 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -184,7 +184,7 @@ static int irqsoff_graph_entry(struct ftrace_graph_ent *trace,
 	unsigned long flags;
 	unsigned int trace_ctx;
 	u64 *calltime;
-	int ret;
+	int ret = 0;
 
 	if (ftrace_graph_ignore_func(gops, trace))
 		return 0;
@@ -202,13 +202,11 @@ static int irqsoff_graph_entry(struct ftrace_graph_ent *trace,
 		return 0;
 
 	calltime = fgraph_reserve_data(gops->idx, sizeof(*calltime));
-	if (!calltime)
-		return 0;
-
-	*calltime = trace_clock_local();
-
-	trace_ctx = tracing_gen_ctx_flags(flags);
-	ret = __trace_graph_entry(tr, trace, trace_ctx);
+	if (calltime) {
+		*calltime = trace_clock_local();
+		trace_ctx = tracing_gen_ctx_flags(flags);
+		ret = __trace_graph_entry(tr, trace, trace_ctx);
+	}
 	local_dec(&data->disabled);
 
 	return ret;
@@ -233,11 +231,10 @@ static void irqsoff_graph_return(struct ftrace_graph_ret *trace,
 
 	rettime = trace_clock_local();
 	calltime = fgraph_retrieve_data(gops->idx, &size);
-	if (!calltime)
-		return;
-
-	trace_ctx = tracing_gen_ctx_flags(flags);
-	__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
+	if (calltime) {
+		trace_ctx = tracing_gen_ctx_flags(flags);
+		__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
+	}
 	local_dec(&data->disabled);
 }
 
-- Steve
