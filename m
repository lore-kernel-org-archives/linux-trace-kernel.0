Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B163F223322;
	Thu, 26 Jun 2025 23:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750979322; cv=none; b=MCci3vUe3yk93AQPGQSlpDyGeT98+Fyh9zVmR8g7UOMBUdyaPGefPcKQHtzhC8rbPxsyXxdoja3fD4sddfcKY0d0Juk1QSltLHkqn5zJKOGZEMvzIcGR5qGRCktzATzjN2JjqhuKsCFs6vNWEnBTiBczBa2ri83iJJnIup3V2PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750979322; c=relaxed/simple;
	bh=UUr8FzPiktkBZJ2d4QowulP+RVgywfBLN92oFo1ekHk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LVK7uQCIxjv5ypuTlweGD5t236Ds/7e+3HJaszpNJTsSilFa0UlPLdLjFaqTQVpHTY1TCHVKnkpLOFXvHFV1y1geDfwMYxOoZCjZ+szcALECFNJv/kVkwrzESkreWWwC52zcK8RSiriymYJQFrdsuJB83yKfgEl1FoL8jlsdz/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 7C1C61A0459;
	Thu, 26 Jun 2025 23:08:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id A500C20012;
	Thu, 26 Jun 2025 23:08:27 +0000 (UTC)
Date: Thu, 26 Jun 2025 19:08:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Boqun Feng
 <boqun.feng@gmail.com>, David Woodhouse <dwmw@amazon.co.uk>, Thomas
 Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org (open list),
 linux-trace-kernel@vger.kernel.org (open list:TRACING), Arnaldo Carvalho de
 Melo <acme@kernel.org>, Clark Williams <williams@redhat.com>, Gabriele
 Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH 1/2] trace/preemptirq: reduce overhead of
 irq_enable/disable tracepoints
Message-ID: <20250626190854.34e45844@gandalf.local.home>
In-Reply-To: <20250626142017.26372-2-wander@redhat.com>
References: <20250626142017.26372-1-wander@redhat.com>
	<20250626142017.26372-2-wander@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: np8ecthm4p5opaginotk5af69w1i6iu4
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: A500C20012
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19xrRdarAPJHKUnjJU/J0TCMGTLiqmWhco=
X-HE-Tag: 1750979307-994917
X-HE-Meta: U2FsdGVkX1+Oey4VKkDBuCtOP2oHzTjqRyM6vWhT2zArSVk/TmLh3vU9jhdRdtEHjgUv9wmo91HJg9wNsIvIHhFU5Ojaan2kXG4xTyP8Pma0fzZ9+4U6uOPuuxkjx+gYGj3bgWpOcbcMUNzUR1cXtNSYWCtn9JlP8t0appKIlvvOSpDDEVi9H0JbioZIRMo6as5MEBR9uNb6R68b8utIddw06/BIdBosG1HC0ZdtqDyik3mSX8OiG/xo7FP8CXV+veZS+F4WdFFJ9ScjitXGe7mIffgvMMEpfEFVLnSuM4zYvch0HleTnyueMCY4LV+B6OM+zTr0ZCa+nQz/Y9YoIQM0MH1E2MKz

On Thu, 26 Jun 2025 11:20:09 -0300
Wander Lairson Costa <wander@redhat.com> wrote:


> @@ -197,9 +198,13 @@ extern void warn_bogus_irq_restore(void);
>   */
>  #ifdef CONFIG_TRACE_IRQFLAGS
>  
> +DECLARE_TRACEPOINT(irq_enable);
> +DECLARE_TRACEPOINT(irq_disable);
> +
>  #define local_irq_enable()				\
>  	do {						\
> -		trace_hardirqs_on();			\
> +		if (tracepoint_enabled(irq_enable))	\
> +			trace_hardirqs_on();		\

If you have both this and lockdep enabled, then this has to be called
regardless if tracing is enabled or not. So this should be:

		if (IS_ENABLED(CONFIG_PROVE_LOCKING) || \
		    tracepoint_enabled(irq_enable))


>  		raw_local_irq_enable();			\
>  	} while (0)
>  
> @@ -207,28 +212,32 @@ extern void warn_bogus_irq_restore(void);
>  	do {						\
>  		bool was_disabled = raw_irqs_disabled();\
>  		raw_local_irq_disable();		\
> -		if (!was_disabled)			\
> +		if (tracepoint_enabled(irq_disable) &&	\
> +		    !was_disabled)			\

And this should be:

		if (IS_ENABLED(CONFIG_PROVE_LOCKING) || \
		    (tracepoint_enabled(irq_disable) && \
		     !was_disabled))


>  			trace_hardirqs_off();		\
>  	} while (0)
>  
>  #define local_irq_save(flags)				\
>  	do {						\
>  		raw_local_irq_save(flags);		\
> -		if (!raw_irqs_disabled_flags(flags))	\
> +		if (tracepoint_enabled(irq_disable) &&	\
> +		    !raw_irqs_disabled_flags(flags))	\
>  			trace_hardirqs_off();		\
>  	} while (0)
>  
>  #define local_irq_restore(flags)			\
>  	do {						\
> -		if (!raw_irqs_disabled_flags(flags))	\
> +		if (tracepoint_enabled(irq_enable) &&	\
> +		    !raw_irqs_disabled_flags(flags))	\
>  			trace_hardirqs_on();		\

Same with these.

-- Steve

>  		raw_local_irq_restore(flags);		\
>  	} while (0)
>  
> -#define safe_halt()				\
> -	do {					\
> -		trace_hardirqs_on();		\
> -		raw_safe_halt();		\
> +#define safe_halt()					\
> +	do {						\
> +		if (tracepoint_enabled(irq_enable))	\
> +			trace_hardirqs_on();		\
> +		raw_safe_halt();			\
>  	} while (0)
>  
>  
> diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
> index 0c42b15c3800..90ee65db4516 100644
> --- a/kernel/trace/trace_preemptirq.c
> +++ b/kernel/trace/trace_preemptirq.c
> @@ -111,6 +111,9 @@ void trace_hardirqs_off(void)
>  }
>  EXPORT_SYMBOL(trace_hardirqs_off);
>  NOKPROBE_SYMBOL(trace_hardirqs_off);
> +
> +EXPORT_TRACEPOINT_SYMBOL(irq_disable);
> +EXPORT_TRACEPOINT_SYMBOL(irq_enable);
>  #endif /* CONFIG_TRACE_IRQFLAGS */
>  
>  #ifdef CONFIG_TRACE_PREEMPT_TOGGLE

