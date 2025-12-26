Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B810F2;
	Fri, 26 Dec 2025 18:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766773846; cv=none; b=gHWR9pcAZxeBctmbHqIUxLu/9XMYBJhWmR5D2SVXkvILb3Ts4+j27N1Jl7i0XHOKcWWtDPz13Pv14hJWYwUS5bf94cU4wyJorake38JjTaEyq1ATZIT8613S28NQiCKE7BvidV0iEo8vjEhlQsXtLFyP5MBynZZOfOAdvYfTAQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766773846; c=relaxed/simple;
	bh=Nrqte1iemsbmyo6M5aRKykHBEktSKxizmZ5yPO/kY6o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLNbSJx9oQp/Lkse1TQND8v3nzKgLa94M1QBz17bSZ+evL9GCw7jsB64ybjGdHzJn2HNediKWMdqxNu7tk33pBk9lp02ww/do83vuUb30uruL2KQjTR+UM4DNbHojE2xLTiSmT12UwIsX4Sx/bNp85l0OHRu8bLYi9xE+MlhpkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 08EA456241;
	Fri, 26 Dec 2025 18:30:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id DF26A20027;
	Fri, 26 Dec 2025 18:30:39 +0000 (UTC)
Date: Fri, 26 Dec 2025 13:30:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, Gabriele Paoloni
 <gpaoloni@redhat.com>, keisuke.nishimura@inria.fr, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: drop unneeded assignment to soft_mode
Message-ID: <20251226133038.593d7914@gandalf.local.home>
In-Reply-To: <20251226110531.4129794-1-Julia.Lawall@inria.fr>
References: <20251226110531.4129794-1-Julia.Lawall@inria.fr>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DF26A20027
X-Stat-Signature: b6g8ct16muo847kutr586uztrnphreq1
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Zl+gPJ5/tREaqpTjSfWnol3WMpOFy6QM=
X-HE-Tag: 1766773839-161655
X-HE-Meta: U2FsdGVkX18Igoow7qABmB9uUgxRpQ99sooxBsalcqIOzQqm1KMtfdKxQumgSGSr4ZislgttXpL9/JF4X6gK3l7PsXBo1QEIAiCveKdKIaFPvn/zYqYarQ6ca+ukB2yDNgMF1tck3fCj7Zb/fuf6/Dxi3oTixtrc3JIOgbfV2po3eoE+Q6eF734JdYGSw67hhnxSDeRO0Cd5sAczEbHMeVVu9o5ZG9Rt7HcBJjq8naGsAOMIHQSHqCTEIbYDoSp3oPfl0YUUKP+YexWgQv/7Aq+dhI/UC+Y3VSK24sh78MjcFnIoDM6ULU635+bvs4ID

On Fri, 26 Dec 2025 12:05:31 +0100
Julia Lawall <Julia.Lawall@inria.fr> wrote:

> soft_mode is not read in the enable case, so drop the assignment.
> Drop also the comment text that refers to the assignment and realign
> the comment.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
> 
> Since soft_more is not used, there is no direct line from the goal of
> verification to finding this problem.

While reviewing the verification text awhile ago, I had made this same
patch. But it never got queued :-p

Anyway, since you officially posted your patch, I'll take it instead ;-)

-- Steve


> 
> kernel/trace/trace_events.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 76067529db61..137b4d9bb116 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -826,16 +826,15 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
>  		 * When soft_disable is set and enable is set, we want to
>  		 * register the tracepoint for the event, but leave the event
>  		 * as is. That means, if the event was already enabled, we do
> -		 * nothing (but set soft_mode). If the event is disabled, we
> -		 * set SOFT_DISABLED before enabling the event tracepoint, so
> -		 * it still seems to be disabled.
> +		 * nothing. If the event is disabled, we set SOFT_DISABLED
> +		 * before enabling the event tracepoint, so it still seems
> +		 * to be disabled.
>  		 */
>  		if (!soft_disable)
>  			clear_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags);
>  		else {
>  			if (atomic_inc_return(&file->sm_ref) > 1)
>  				break;
> -			soft_mode = true;
>  			/* Enable use of trace_buffered_event */
>  			trace_buffered_event_enable();
>  		}

