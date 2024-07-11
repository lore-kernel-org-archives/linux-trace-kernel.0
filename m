Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C8B15957E;
	Thu, 11 Jul 2024 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714017; cv=none; b=bhpdJmvxRM9i7AoASXuyaJ6MyXGIoXNUILQDkbY/JET6/RO4qPs7h2ktPyyIvKOijvWl4f8KJOY2PvIX6zPi9I/D9EhPpGJEoBDR5WrcdKIIuMmOU+U9UIdDB7bQBmfFwt5PSgUHhW4L27R/Oir/9zaHv8O5LxYMPJ9DS4ICVz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714017; c=relaxed/simple;
	bh=EYH+M99SRudXDUFJIpNYR6cWEdr01nHFRFQWzFsF4SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyopiyKIpoSz0Dfza5OMUJb7gTvx6xWUVH+RYX02nPEatmitjE4hRJ1YP7gEZvLBlSGGGTzN/NzhCnFZKvHZoWd8ZbJDvqmFhDkafQHvGyQrb0YKQANDM3wo0oWfd8IRZIrs5ICnoOuzQZXw1zSrJQwUaXVZDdx/qOZUtKyxgb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l91vLQFX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l91vLQFX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4N7UMnqLPZtaeDiATujThtv1TVkAjKCUtfVGJAv//C0=; b=l91vLQFX1yoJ0q3HXPakSxROn/
	9o/m04A3YGlgpW59SKbKI88gN29sSm8aywhv63zVPCRt0QDHs+8lYQKtTPlYfv5z+Mx/htzZww4g9
	peSZoUpvKuvkFmkoO+5NB57rk5GSOycW5uScOMGQQ4wMyfn/yVIkABZKWIdRceoJ/xkOBjI0kW9OQ
	qdQBd+FjQzI+4eO4Scp9mYeYENs/6vImAIsM5T6botPXz+jbEW7eKOaHLaq8Pw2faHvqUdV80/Y/x
	7uR70ZgF5azsSqClNZn9GaHxETll5fce5pFeEhSTUFJL8ZxRd106UiPcgEv0JX76iZz6WVwxYI5vr
	j0GrZYrg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRwJl-0000000180t-3gaO;
	Thu, 11 Jul 2024 16:06:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4D57F30050D; Thu, 11 Jul 2024 18:06:49 +0200 (CEST)
Date: Thu, 11 Jul 2024 18:06:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, jolsa@kernel.org, clm@meta.com,
	paulmck@kernel.org
Subject: Re: [PATCH v2 11/11] perf/uprobe: Add uretprobe timer
Message-ID: <20240711160649.GA38270@noisy.programming.kicks-ass.net>
References: <20240711110235.098009979@infradead.org>
 <20240711110401.412779774@infradead.org>
 <20240711131918.GC16902@redhat.com>
 <20240711150054.GA3285@noisy.programming.kicks-ass.net>
 <20240711155542.GA34311@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711155542.GA34311@noisy.programming.kicks-ass.net>

On Thu, Jul 11, 2024 at 05:55:42PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 11, 2024 at 05:00:54PM +0200, Peter Zijlstra wrote:
> 
> > Let me ponder that a little, I *can* make it work, but all 'solutions'
> > I've come up with so far are really rather vile.
> 
> This is the least horrible solution I could come up with...
> 
> ---
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -83,6 +83,7 @@ struct uprobe_task {
>  
>  	struct timer_list		ri_timer;
>  	struct callback_head		ri_task_work;
> +	bool				ri_work_pending;
>  	struct task_struct		*task;
>  };
>  
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1797,9 +1797,8 @@ void uprobe_free_utask(struct task_struc
>  	t->utask = NULL;
>  }
>  
> -static void return_instance_task_work(struct callback_head *head)
> +static void __return_instance_put(struct uprobe_task *utask)
>  {
> -	struct uprobe_task *utask = container_of(head, struct uprobe_task, ri_task_work);
>  	struct return_instance *ri;
>  
>  	for (ri = utask->return_instances; ri; ri = ri->next) {
> @@ -1815,9 +1814,43 @@ static void return_instance_task_work(st
>  	}
>  }
>  
> +static void return_instance_task_work(struct callback_head *head)
> +{
> +	struct uprobe_task *utask = container_of(head, struct uprobe_task, ri_task_work);
> +	utask->ri_work_pending = false;
> +	__return_instance_put(utask);
> +}
> +
> +static int return_instance_blocked(struct task_struct *p, void *arg)
> +{
> +	unsigned int state = READ_ONCE(p->__state);
> +
> +	if (state == TASK_RUNNING || state == TASK_WAKING)
> +		return 0;
> +
> +	smp_rmb();
> +	if (p->on_rq)
> +		return 0;
> +
> +	/*
> +	 * Per __task_needs_rq_locked() we now have: !p->on_cpu and only hold
> +	 * p->pi_lock, and can consiter the task fully blocked.
> +	 */
> +
> +	__return_instance_put(p->utask);

PREEMPT_RT might not like this though, doing the full RI iteration under
a raw_spinlock_t...

I just can't think of anything saner just now. Oh well, let me go make
dinner, perhaps something will come to me.
