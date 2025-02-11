Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B13C1F8EF2;
	Tue, 11 Feb 2025 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739271794; cv=none; b=XueTJqA6ZPJiESbgPnNrB/0tpjwxis9knpU7mK61I5Bo6OsbZ0HX3MgotzqdkCfYyED2Fh+nIgfNxrYs7jRmhmeyb8OjwUCjM/l/vnyGrVgWZ18V6I7nb6jU2jJrtk7HQ4WkxzEy2THjvKk4Tzbpn8wGWkdXgiVr1wiwfQEOHZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739271794; c=relaxed/simple;
	bh=l59H9En63D++FSO4xg+piyAjm5nOsgHd8/3riuUMV9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qS4YPXkk4nwzp7PpxTUIzO+nGuUdL/Hc5o5JaK4gbzZX5VcB5vzAxAfTcD2MCQulgpBgUrU8iSyx9l0INw+KPaJXV8NyXhf+/BQJfSFxK49fK5ODLlnSqngyCvOMx2tgTyxdz+fGGzCJDqAwxGjrVtp8aGS9wTIJhKQlGpuxyyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jpKYMTjo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jpKYMTjo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bNv9liwRwk9eDm6CIKT9HsZI2RZveFR6cSx+ZSqLPjM=; b=jpKYMTjonhpvy8Dvn5w+yPFLcY
	WI3sQNlzIYzIABZJ7TLuwQMU54lmeb2XlOZtXE+heosNSSPgJL2oYxlTawNMQvNDzhpb9dab92dD9
	DWCl7CiGuCe1c57NbtePQzdXFVgd3+RWdE0YodtsTTwjgPB8iJIhfpZnu92AaX6wVROvdvcp//6cQ
	pT89jZxYsoagLVIeP6xl0FgqwNf52ECraRJM1xBlkHVQQGQ8bARMZI97EPePtVA59JCq7z9A8uTpS
	lD8LGGqS3cXFXg1HS4xMU8Nv6oTJx0dH7wEF3wxouAGYe/V4jwi+0y9UQepMmrqkJ0izVuZW+nzYd
	LTU/oxlw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tho2m-000000010UJ-1yTA;
	Tue, 11 Feb 2025 11:03:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 199233004AF; Tue, 11 Feb 2025 12:03:08 +0100 (CET)
Date: Tue, 11 Feb 2025 12:03:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v1 03/11] sched: Add sched tracepoints for RV task model
Message-ID: <20250211110307.GE29593@noisy.programming.kicks-ass.net>
References: <20250211074622.58590-1-gmonaco@redhat.com>
 <20250211074622.58590-4-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211074622.58590-4-gmonaco@redhat.com>

On Tue, Feb 11, 2025 at 08:46:10AM +0100, Gabriele Monaco wrote:

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 9632e3318e0d6..9ff0658095240 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -46,6 +46,7 @@
>  #include <linux/rv.h>
>  #include <linux/livepatch_sched.h>
>  #include <linux/uidgid_types.h>
> +#include <linux/tracepoint-defs.h>
>  #include <asm/kmap_size.h>
>  
>  /* task_struct member predeclarations (sorted alphabetically): */
> @@ -186,6 +187,12 @@ struct user_event_mm;
>  # define debug_rtlock_wait_restore_state()	do { } while (0)
>  #endif
>  
> +#define trace_set_current_state(state_value)                     \
> +	do {                                                     \
> +		if (tracepoint_enabled(sched_set_state_tp))      \
> +			do_trace_set_current_state(state_value); \
> +	} while (0)

Yeah, this is much nicer, thanks!

>  /*
>   * set_current_state() includes a barrier so that the write of current->__state
>   * is correctly serialised wrt the caller's subsequent test of whether to
> @@ -226,12 +233,14 @@ struct user_event_mm;
>  #define __set_current_state(state_value)				\
>  	do {								\
>  		debug_normal_state_change((state_value));		\
> +		trace_set_current_state(state_value);			\
>  		WRITE_ONCE(current->__state, (state_value));		\
>  	} while (0)
>  
>  #define set_current_state(state_value)					\
>  	do {								\
>  		debug_normal_state_change((state_value));		\
> +		trace_set_current_state(state_value);			\
>  		smp_store_mb(current->__state, (state_value));		\
>  	} while (0)
>  
> @@ -247,6 +256,7 @@ struct user_event_mm;
>  									\
>  		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
>  		debug_special_state_change((state_value));		\
> +		trace_set_current_state(state_value);			\
>  		WRITE_ONCE(current->__state, (state_value));		\
>  		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
>  	} while (0)
> @@ -282,6 +292,7 @@ struct user_event_mm;
>  		raw_spin_lock(&current->pi_lock);			\
>  		current->saved_state = current->__state;		\
>  		debug_rtlock_wait_set_state();				\
> +		trace_set_current_state(TASK_RTLOCK_WAIT);		\
>  		WRITE_ONCE(current->__state, TASK_RTLOCK_WAIT);		\
>  		raw_spin_unlock(&current->pi_lock);			\
>  	} while (0);
> @@ -291,6 +302,7 @@ struct user_event_mm;
>  		lockdep_assert_irqs_disabled();				\
>  		raw_spin_lock(&current->pi_lock);			\
>  		debug_rtlock_wait_restore_state();			\
> +		trace_set_current_state(TASK_RUNNING);			\
>  		WRITE_ONCE(current->__state, current->saved_state);	\
>  		current->saved_state = TASK_RUNNING;			\
>  		raw_spin_unlock(&current->pi_lock);			\


> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 165c90ba64ea9..9e33728bb57e8 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -491,6 +491,15 @@ sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
>  
>  #endif /* CONFIG_SCHED_CORE */
>  
> +/* need a wrapper since we may need to trace from modules */
> +EXPORT_TRACEPOINT_SYMBOL(sched_set_state_tp);

_GPL

> +
> +void do_trace_set_current_state(int state_value)
> +{
> +	trace_sched_set_state_tp(current, current->__state, state_value);

Should this be:

	__do_trace_sched_set_state_tp() ?

> +}
> +EXPORT_SYMBOL(do_trace_set_current_state);

_GPL

