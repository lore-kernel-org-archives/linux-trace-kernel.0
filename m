Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C5238DD3;
	Wed, 11 Mar 2026 20:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261982; cv=none; b=os42F0jddyYkE94BbJVQKu9c+yLNdYqAh6DetCtjzqUjgI0SkXdxD2dGeG3o/2svayEyk40yUme3M5OZ609RHUykuu/yYym5vE/AudkvABd5MdNL9NuHTgsb1sktap47LfVEb3hkGJWTcIiDUKv16bX7XyQMEqSIDHT6izLxRx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261982; c=relaxed/simple;
	bh=XO3nJXDLmPdJziK40A0EIpa5YxvGQHpw7+p2SjQZ0hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzafHL0len42dvKur7UsEIdHTjgq/5F+Jw8K6mrcUY8qCfxbAiSU0+ofSLbiWVsxATRzkJ1aiRPfV4XVEkjOfNOKJ9UHeB/J7MIFVDOdOKPzAWv/o9vXVZfICyWfoMFdE/u4amE9lPGGc2RTViq2aa0bjMt359EMXaFWEGfMhFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VqQBUvXq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VqQBUvXq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/qLvj6q7NkzGzj4h7z3VGCQ+W39uMOZd6RJ8cDnjTd4=; b=VqQBUvXqmmFL56xF8+1/eSJ5OJ
	MPagWEktgA5MeeHvQJQwcj/hudbV26kPGWr4HKPPM3DM8yUqPm0iw4XNBNBFS9pFk8xq/j2mxqKX3
	hEcqOUltouWFRuxzRse4bwGhA2GNY5eKNyk9qLyk8LDAVkHLfshDWmnxKGPGApLoyYlOwJMYhhzG/
	1+mHtcpBr7BiztUhZyqVL3HByTMd/OsVPPllgcgMoPyBaCYU8sYRi+OajKPVc+Jcud9VPlYokm5Bu
	LNKB+TcVjyWFQapCfZMJym5s4fLSVK/tJqPEA4LNEwMRPHrXapl+/gMT3pNf1kWnjDZ8JcuiLk7VQ
	EHs4jG9g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0QRZ-0000000AI3j-2Yz7;
	Wed, 11 Mar 2026 20:46:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0042F302EC2; Wed, 11 Mar 2026 21:46:07 +0100 (CET)
Date: Wed, 11 Mar 2026 21:46:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Wander Lairson Costa <wander@redhat.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
	acme@kernel.org, williams@redhat.com, gmonaco@redhat.com,
	Vineeth Pillai <vineethrp@google.com>
Subject: Re: [PATCH v3 4/4] trace/preemptirq: Implement trace_irqflags hooks
Message-ID: <20260311204607.GF2277644@noisy.programming.kicks-ass.net>
References: <20260311125021.197638-1-wander@redhat.com>
 <20260311125021.197638-5-wander@redhat.com>
 <20260311194305.GT606826@noisy.programming.kicks-ass.net>
 <20260311154842.0823790f@gandalf.local.home>
 <20260311195310.GU606826@noisy.programming.kicks-ass.net>
 <20260311160714.1e6b7a37@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311160714.1e6b7a37@gandalf.local.home>

On Wed, Mar 11, 2026 at 04:07:14PM -0400, Steven Rostedt wrote:
> On Wed, 11 Mar 2026 20:53:10 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > Which basically is just __do_trace_<event>(), but as a wrapper that can
> > > handle updates that may be needed, but supplies a proper API where thing
> > > wont randomly break when __do_trace_<event>() changes.  
> > 
> > That's like a 3 line patch, hardly worth the effort. Its not like it'll
> > be hard to find and fix any users if you do ever change that.
> 
> No, but I prefer clean code, and not hacks that use internal functions with
> underscores in their names. Not to mention, it properly handles different
> cases:
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 22ca1c8b54f3..07219316a8e1 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -294,6 +294,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  			WARN_ONCE(!rcu_is_watching(),			\
>  				  "RCU not watching for tracepoint");	\
>  		}							\
> +	}								\
> +	static inline void trace_invoke_##name(proto)			\
> +	{								\
> +		__do_trace_##name(args);				\
>  	}
>  
>  #define __DECLARE_TRACE_SYSCALL(name, proto, args, data_proto)		\
> @@ -313,6 +317,11 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  			WARN_ONCE(!rcu_is_watching(),			\
>  				  "RCU not watching for tracepoint");	\
>  		}							\
> +	}								\
> +	static inline void trace_invoke_##name(proto)			\
> +	{								\
> +		might_fault();						\
> +		__do_trace_##name(args);				\
>  	}
> 
> 
> Then it goes through and updates every location that has a:
> 
> 	if (trace_<event>_enabled()) {
> 		[..]
> 		trace_<event>();
> 	}

We have Cocinelle for that :-), and while I absolutely suck at writing
Cocinelle, I had some limited success using Gemini to write some for me
the other day.
