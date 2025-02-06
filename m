Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58801514EE;
	Thu,  6 Feb 2025 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738829988; cv=none; b=f1g3ZGncBWhGVOf8f68gBc0dIO/W1kZKs/8E72MQb2GyyQoBkCNf35tORlIyj+p8/+KtjEV8FaDhKWx38L9T0MVvWKZ1Ca1y5D9HJdrAFHIFK+e1tE0Qr2MCTdbIpdK+Vl6soMD8/xfbZYKlZiS/tsQ3znqM0tf75jGrZk8wjs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738829988; c=relaxed/simple;
	bh=UjhJAx5LANpkIPy610Vv1aSkTacicPmELW+A2J/coHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5o1onbaw5vaUgcMX3RVYMmBpgdhsSp/dnJK0tM6iP30T3zZAnvFbFjxTBE9jjFtLBpiAKtTK0rKunDmQH1zK8UdDmsLNPw7t+clmEm5ECAr/+gg/PLvcej8gPmN6Ubp/PlYmZZpnKQDvrbdgnSrkbr4NMTIQ+DHuFnxMDpm93s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e+cuqC3e; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e+cuqC3e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cekbhiScKH6qHE8Ivy8vR6tcjSV4jV1i0jovRwNgyJQ=; b=e+cuqC3e3AJEx4xjkAfRb62MdU
	MpH7zT8EdbvQQBznPGmz+N8pvQrTwLKJ7pxqS1S31JmazuYTijpiRgC/5nhf0X+7gIzAboo/Y47Ya
	ZmIMXrhyRi5xkOdFcMMgY1gFyr/ukVDym8kUk7GeF4AMkSEX6nGAcJm9Ms/wEvS1IngDlztBjt9Or
	KoRxvBd9zP/yHyyEOlVQG9uiFtfA76l8rZljtB/YfXED5ZmX/fwBGrp5OuBqm9fZVdK6LDCQV2u7Z
	aw0hgWAzB6Wl0e3xtjJdedvT1yJpLnOw4HBG605ljzaRWnQ6K8CgyX1gKwwQp5zxnEtyKPrvkPzSK
	/blkU8LA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tfx6u-0000000GsP7-05Lm;
	Thu, 06 Feb 2025 08:19:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 04BC930031C; Thu,  6 Feb 2025 09:19:43 +0100 (CET)
Date: Thu, 6 Feb 2025 09:19:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 03/11] sched: Add sched tracepoints for RV task model
Message-ID: <20250206081942.GJ7145@noisy.programming.kicks-ass.net>
References: <20250206080952.98478-1-gmonaco@redhat.com>
 <20250206080952.98478-4-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206080952.98478-4-gmonaco@redhat.com>

On Thu, Feb 06, 2025 at 09:09:39AM +0100, Gabriele Monaco wrote:

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 9632e3318e0d6..af9fa18035c71 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -226,12 +226,14 @@ struct user_event_mm;
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
> @@ -247,6 +249,7 @@ struct user_event_mm;
>  									\
>  		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
>  		debug_special_state_change((state_value));		\
> +		trace_set_current_state(state_value);			\
>  		WRITE_ONCE(current->__state, (state_value));		\
>  		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
>  	} while (0)
> @@ -282,6 +285,7 @@ struct user_event_mm;
>  		raw_spin_lock(&current->pi_lock);			\
>  		current->saved_state = current->__state;		\
>  		debug_rtlock_wait_set_state();				\
> +		trace_set_current_state(TASK_RTLOCK_WAIT);		\
>  		WRITE_ONCE(current->__state, TASK_RTLOCK_WAIT);		\
>  		raw_spin_unlock(&current->pi_lock);			\
>  	} while (0);
> @@ -291,6 +295,7 @@ struct user_event_mm;
>  		lockdep_assert_irqs_disabled();				\
>  		raw_spin_lock(&current->pi_lock);			\
>  		debug_rtlock_wait_restore_state();			\
> +		trace_set_current_state(TASK_RUNNING);			\
>  		WRITE_ONCE(current->__state, current->saved_state);	\
>  		current->saved_state = TASK_RUNNING;			\
>  		raw_spin_unlock(&current->pi_lock);			\

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 165c90ba64ea9..fb5f8aa61ef5d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -491,6 +491,12 @@ sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
>  
>  #endif /* CONFIG_SCHED_CORE */
>  
> +void trace_set_current_state(int state_value)
> +{
> +	trace_sched_set_state_tp(current, current->__state, state_value);
> +}
> +EXPORT_SYMBOL(trace_set_current_state);

Urgh, why !?!
