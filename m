Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAF72EBBA8;
	Wed,  8 Oct 2025 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936946; cv=none; b=ADQgEQODswgLlM4IxFf0Dlje2KHflcOdGfLLES+aUdW3R+0NNubqU12xsMeLDTX69aQRuyxPip8/GlMMHgrebj0UI671vIcXfxQuBcb05kASHAxKqcHkaVOEm3Y8MB0b0DlH58Roql1hJzf0dw8g3XXlq0u2z+57Z0hCtlUwxAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936946; c=relaxed/simple;
	bh=uS3x5HWfAOiuRhFovDGOd4azvewpNkYCCS1T7U+icyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h2jrS7EwOXs9CT9QxvIRM86SicQkPUp3YczhH/9uSYNgIsgXUv1MJsvt/roFr6faQlE9bmg6td5VFBaHATB2KZfp0VA/fQCkPdWG/bCpFdsoTv8R78OIQWX0UgTN0iKOtSTBtgYhf4N1fxznedliVGsuVwvyVGEN+8MWur74AEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 14B1059C33;
	Wed,  8 Oct 2025 15:22:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 60EE820027;
	Wed,  8 Oct 2025 15:22:20 +0000 (UTC)
Date: Wed, 8 Oct 2025 11:24:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sasha Levin <sashal@kernel.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing/wakeup: Balance prolog on fgraph failure
Message-ID: <20251008112414.03d5d803@gandalf.local.home>
In-Reply-To: <20251006175848.1906912-1-sashal@kernel.org>
References: <20251006175848.1906912-1-sashal@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 17kdbnhybw7bnke7y6eng9wjsuyocdu6
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 60EE820027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX188/wSdqsK8NGl+nzxPL4f8OR7UbtW6K1k=
X-HE-Tag: 1759936940-26348
X-HE-Meta: U2FsdGVkX1/kJOAgpGVnRSE9d8qFQiwJUCu0rhghrtYYotvpAia6E1zbI1Fsq00UUJGL0aMt1UUv+B1Q0y/6QnGS8kRpfRLjvHoKZb1Q8sskVOJOscRxVRSqxfOlcXOTvjow2xa/+6daFEynqCmgKR8NJg1BwxA1rTJCQX+1pL4eFaKWa8YaOsM+z+Gyuxx0hqsXQgs2PV53fb3lUAZ3oqTlA7ynk3B0DM1Jvab2ODG3XDp+iQc+H6Kdd7vcZSLWvnUf/mFbQ7vZkqixWnlI6b+Cd0zhTAFeKdHMb9lXSp3yP3eYINx+AuCW70aqvcUp+LW7rfhe6Nuyrf9CoOh6feUmboWLXRUu

On Mon,  6 Oct 2025 13:58:47 -0400
Sasha Levin <sashal@kernel.org> wrote:

> diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
> index bf1cb80742aed..fa48bbdf0851c 100644
> --- a/kernel/trace/trace_sched_wakeup.c
> +++ b/kernel/trace/trace_sched_wakeup.c
> @@ -138,8 +138,11 @@ static int wakeup_graph_entry(struct ftrace_graph_ent *trace,
>  		return 0;
>  
>  	calltime = fgraph_reserve_data(gops->idx, sizeof(*calltime));
> -	if (!calltime)
> +	if (!calltime) {
> +		local_dec(&data->disabled);
> +		preempt_enable_notrace();
>  		return 0;
> +	}
>  
>  	*calltime = trace_clock_local();
>  
> @@ -169,8 +172,11 @@ static void wakeup_graph_return(struct ftrace_graph_ret *trace,
>  	rettime = trace_clock_local();
>  
>  	calltime = fgraph_retrieve_data(gops->idx, &size);
> -	if (!calltime)
> +	if (!calltime) {
> +		local_dec(&data->disabled);
> +		preempt_enable_notrace();
>  		return;
> +	}
>  
>  	__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
>  	local_dec(&data->disabled);

Technically correct, but this would look better:

diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index bf1cb80742ae..e3f2e4f56faa 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -138,12 +138,10 @@ static int wakeup_graph_entry(struct ftrace_graph_ent *trace,
 		return 0;
 
 	calltime = fgraph_reserve_data(gops->idx, sizeof(*calltime));
-	if (!calltime)
-		return 0;
-
-	*calltime = trace_clock_local();
-
-	ret = __trace_graph_entry(tr, trace, trace_ctx);
+	if (calltime) {
+		*calltime = trace_clock_local();
+		ret = __trace_graph_entry(tr, trace, trace_ctx);
+	}
 	local_dec(&data->disabled);
 	preempt_enable_notrace();
 
@@ -169,12 +167,10 @@ static void wakeup_graph_return(struct ftrace_graph_ret *trace,
 	rettime = trace_clock_local();
 
 	calltime = fgraph_retrieve_data(gops->idx, &size);
-	if (!calltime)
-		return;
+	if (calltime)
+		__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
 
-	__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
 	local_dec(&data->disabled);
-
 	preempt_enable_notrace();
 	return;
 }


-- Steve
