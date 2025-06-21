Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3111A157A67;
	Sat, 21 Jun 2025 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750496237; cv=none; b=g/MQUYT7ag72ObTN/JzGuPAyVPEIrXbNFRNqG/pYHpgf3vUW41DFWSKSI50BgWeupT7m2SE7orp2gFB/Oz8mMTW91Up8OhWZaBP86eph3xSmpn4E2Zj5Q8UXFn+xPGEtAE906t2pwBZzhq2Z1jcnKZOV3w9fEisdV2pbBL2Zcms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750496237; c=relaxed/simple;
	bh=z1609bAgBUIp/jgJsQxGpB32Y6A5jwc17jZ0FZC0UkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZXzjTP58Y3n/ZJg1TmeRlIbWuU3438ZcjUtEepaF79ayAsvfGpHrrT/WPpK08hmEmm7djAQP2kB7yZ5QGSwmxM76QFkEoum6+FyRWJE1jljq/VgslrwQJgBh23qbBV1LOp7cRlorb/14r7qw6wKvxM/PAEjn0boqMTWIUNuEX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bstSyS5a; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bstSyS5a"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lXj6aZd0B3JE/QjD5McyxMpqZnX6HWv51quwI3Qk/SM=; b=bstSyS5ao+0n9VhZ4/1lrbqEju
	mk9NP8v43SFdpDSpYBiEf4gP0sGo7ChvsPRsM1uiIsy1tqH3P4b8ceaeZhW9Pv2AmRLHi0M+zPDM7
	IPlSZ2CGeWxkKv6pPc77hap9VfgHMEosvWvK/YEJEGd3eIovqhPYZWx7VPz7AuMDZ4IXW2VYGDGg+
	2N1hDpPgV6xnYU0qg+OuzLe7y7iaZFhpKvARv03+bt5pln7tTKlBEA8VExCiKx0yvrOL//0B6H9id
	rxQoGkfVLSQOFQwrlVMUR0S4eY/E12UGBMKViP7F2d/yS/+m6ieFByafsQM9S3VZ8Cp5/p21jdvaa
	MvG5HwGg==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSu28-00000004ssa-2awj;
	Sat, 21 Jun 2025 08:57:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 921163087E7; Sat, 21 Jun 2025 10:57:06 +0200 (CEST)
Date: Sat, 21 Jun 2025 10:57:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] lockdep: Fix inconsistency in irq tracking on NMIs
Message-ID: <20250621085706.GM1613200@noisy.programming.kicks-ass.net>
References: <20250620125112.33978-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620125112.33978-2-gmonaco@redhat.com>

On Fri, Jun 20, 2025 at 02:51:13PM +0200, Gabriele Monaco wrote:

>  local_irq_enable()
>    void trace_hardirqs_on(void)
>    {
>    	if (tracing_irq_cpu) {
>    		trace(irq_enable);
>    		tracing_irq_cpu = 0;
>    	}
> 
>                 /*
>                  * NMI here
>                  * tracing_irq_cpu == 0 (done tracing)
>                  * lockdep_hardirqs_enabled == 0 (IRQs still disabled)
>                  */
> 
>                                    irqentry_nmi_enter()
>                                        irq_state.lockdep = 0
>                                        trace(irq_disable);

				So you're saying this ^^^^^ is the
				actual problem?

> 
>                                    irqentry_nmi_exit()
>                                        // irq_state.lockdep == 0
>                                        // do not trace(irq_enable)

                                Because this ^^^^ might lead one to
				believe the lack of trace(irq_enable)
				is the problem.

>    	lockdep_hardirqs_on();
>    }


Because I'm thinking the trace(irq_disable) is actually correct. We are
entering an NMI handler, and that very much has IRQs disabled.

> Prevent this scenario by checking lockdep_hardirqs_enabled to trace also
> on nmi_entry.
> 
> Fixes: ba1f2b2eaa2a ("x86/entry: Fix NMI vs IRQ state tracking")
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: linux-trace-kernel@vger.kernel.org
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>  kernel/entry/common.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index a8dd1f27417cf..7369132c00ba4 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -326,13 +326,15 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
>  	irq_state.lockdep = lockdep_hardirqs_enabled();
>  
>  	__nmi_enter();
> -	lockdep_hardirqs_off(CALLER_ADDR0);
> +	if (irq_state.lockdep)
> +		lockdep_hardirqs_off(CALLER_ADDR0);

This isn't needed... it is perfectly fine calling lockdep_hardirq_off()
again here. You'll hit the redundant_hardirqs_off counter.

>  	lockdep_hardirq_enter();
>  	ct_nmi_enter();
>  
>  	instrumentation_begin();
>  	kmsan_unpoison_entry_regs(regs);
> -	trace_hardirqs_off_finish();
> +	if (irq_state.lockdep)
> +		trace_hardirqs_off_finish();

So I really think you're doing the wrong thing here. We traced IRQs are
enabled, but then take an NMI, meaning IRQs are very much disabled. So
we want this irqs_off to fire.

The much more fun case is:

	if (tracing_irq_cpu) {
		trace(irq_enable);
		<NMI>

Because then it will see tracing_irq_cpu set, but also have issued
irq_enable and not issue irq_disable, and then things are really messed
up.


So yes, you found a fun case, but your solution seemed aimed at pleasing
the model, rather than reality.

