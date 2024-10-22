Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31713153BE4;
	Tue, 22 Oct 2024 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581264; cv=none; b=lTio/RucFI8X+P9lC8dfCsMkZefCDe1IAwbBIoMkRsL+NoFAFDxYchu80W8Edomwe9OvIHrLsoTDXn/A4ovjf0MTOiNcZ32DeM8v9vZj4JxFpTR/oloQdFNR9VwluRFWzrIpNwju8OIL9hKUQhWCyL27Aj618VHDli2e1M3D9+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581264; c=relaxed/simple;
	bh=kwGzMaCTwZNlmr7cTlrGkXOAsf0h9e0Emk902bwUv/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QxjPIVXhJDMzLbiv/1l0UcHkIu+l2WQQVG5ZTBGtgHt/QRptzwN3DmFEHeM00xg3KEOPmoIaiu10ESec9g/a0ZdFrYDxzPWqRG9fXeYY/+FWGIAIIuSHDR5I8gAr2zYeAcXDJc8yyTjM1QCnEuSTmhlBQJKOnVA9UYt8kOeCOPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B357CC4CEC3;
	Tue, 22 Oct 2024 07:14:21 +0000 (UTC)
Date: Tue, 22 Oct 2024 03:14:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Peter
 Zijlstra <peterz@infradead.org>, tglx@linutronix.de, mingo@kernel.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, ankur.a.arora@oracle.com, efault@gmx.de, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 1/3] tracing: Replace TRACE_FLAG_IRQS_NOSUPPORT with
 its config option.
Message-ID: <20241022031418.12154e63@rorschach.local.home>
In-Reply-To: <20241021151257.102296-2-bigeasy@linutronix.de>
References: <20241021151257.102296-1-bigeasy@linutronix.de>
	<20241021151257.102296-2-bigeasy@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 17:08:40 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The TRACE_FLAG_IRQS_NOSUPPORT flag is used by tracing_gen_ctx.*() to
> signal that CONFIG_TRACE_IRQFLAGS_SUPPORT is not enabled and tracing IRQ
> flags is not supported.
> 
> This could be replaced by using the 0 as flags and then deducting that
> there is no IRQFLAGS_SUPPORT based on the config option. The downside is
> that without CONFIG_TRACE_IRQFLAGS_SUPPORT we can not distinguish
> between no-IRQ passed flags and callers which passed 0. On the upside we
> have room for one additional flags which could be used for LAZY_PREEMPTION.
> 
> Remove TRACE_FLAG_IRQS_NOSUPPORT and set it flags are 0 and
> CONFIG_TRACE_IRQFLAGS_SUPPORT is not set.

We could also add that we have:

#
# Minimum requirements an architecture has to meet for us to
# be able to offer generic tracing facilities:
#
config TRACING_SUPPORT
        bool
        depends on TRACE_IRQFLAGS_SUPPORT
        depends on STACKTRACE_SUPPORT
        default y

So this can't even be built without TRACE_IRQFLAGS_SUPPORT!

> 
> [bigeasy: Commit descrption.]
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/trace_events.h |    7 +++----
>  kernel/trace/trace_output.c  |    2 +-
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -184,8 +184,7 @@ unsigned int tracing_gen_ctx_irq_test(un
>  
>  enum trace_flag_type {
>  	TRACE_FLAG_IRQS_OFF		= 0x01,
> -	TRACE_FLAG_IRQS_NOSUPPORT	= 0x02,
> -	TRACE_FLAG_NEED_RESCHED		= 0x04,
> +	TRACE_FLAG_NEED_RESCHED		= 0x02,

These flags are user visible (I probably should move them into uapi).
They are parsed by libtraceevent.

Please just remove NOSUPPORT and do not touch NEED_RESCHED.


>  	TRACE_FLAG_HARDIRQ		= 0x08,
>  	TRACE_FLAG_SOFTIRQ		= 0x10,
>  	TRACE_FLAG_PREEMPT_RESCHED	= 0x20,
> @@ -211,11 +210,11 @@ static inline unsigned int tracing_gen_c
>  
>  static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
>  {
> -	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
> +	return tracing_gen_ctx_irq_test(0);
>  }
>  static inline unsigned int tracing_gen_ctx(void)
>  {
> -	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
> +	return tracing_gen_ctx_irq_test(0);
>  }
>  #endif
>  
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -460,7 +460,7 @@ int trace_print_lat_fmt(struct trace_seq
>  		(entry->flags & TRACE_FLAG_IRQS_OFF && bh_off) ? 'D' :
>  		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' :
>  		bh_off ? 'b' :
> -		(entry->flags & TRACE_FLAG_IRQS_NOSUPPORT) ? 'X' :
> +		!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_SUPPORT) ? 'X' :

Probably can even remove this check.

-- Steve

>  		'.';
>  
>  	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED |

