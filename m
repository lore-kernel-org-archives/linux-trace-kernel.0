Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2E01F7557;
	Fri, 27 Dec 2024 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735319928; cv=none; b=WF/gvtMQIzvQp4Ov6H1FrOA9J3DXaa7wdslg9c+KxnBedtRU2+rLu+3C56YSXyr2TxaXsmVsGUZqaq77ppblVZxXR0RIAzgQHCvsvynkrXtqy6prVobjFC9XCIbxONutLyEgMC5KG5cosQ+cerUlRHM/6u3otRuJZu0Pz/ugLqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735319928; c=relaxed/simple;
	bh=cyPvuQG7rkgpWUrFujtHBOQ2InrAHxiLlkoqpRdbE34=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQ902vtB8hl1OXLOgwJF4UDUW0ScJaIMHWCz29+dxudQW1kjpT02E8k5hgrRaOHjoC1wvsmAkVSkI1zG5M2X6/ebnVQK7S100I0WwcREfQtJoPaXeDSkFNGzjq4xxKqiakxGB4s/dXVCDR/bd5IVNOFNCpxtUTW/Ym+d2y4mFLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E66C4CED0;
	Fri, 27 Dec 2024 17:18:45 +0000 (UTC)
Date: Fri, 27 Dec 2024 12:19:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel
 Gomez <da.gomez@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>, "Paul E
 . McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Huacai Chen <chenhuacai@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev
Subject: Re: [PATCH v2 19/28] LoongArch: ftrace: Use RCU in all users of
 __module_text_address().
Message-ID: <20241227121946.1643decf@gandalf.local.home>
In-Reply-To: <20241220174731.514432-20-bigeasy@linutronix.de>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
	<20241220174731.514432-20-bigeasy@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 18:41:33 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> --- a/arch/loongarch/kernel/ftrace_dyn.c
> +++ b/arch/loongarch/kernel/ftrace_dyn.c
> @@ -85,14 +85,13 @@ static bool ftrace_find_callable_addr(struct dyn_ftrace *rec, struct module *mod
>  	 * dealing with an out-of-range condition, we can assume it
>  	 * is due to a module being loaded far away from the kernel.
>  	 *
> -	 * NOTE: __module_text_address() must be called with preemption
> -	 * disabled, but we can rely on ftrace_lock to ensure that 'mod'
> +	 * NOTE: __module_text_address() must be called within a RCU read
> +	 * section, but we can rely on ftrace_lock to ensure that 'mod'
>  	 * retains its validity throughout the remainder of this code.
>  	 */
>  	if (!mod) {
> -		preempt_disable();
> +		guard(rcu)();
>  		mod = __module_text_address(pc);
> -		preempt_enable();
>  	}
>  
>  	if (WARN_ON(!mod))
> -- 

I personally dislike swapping one line of protection for the guard() code.

Although, I do think scoped_guard() can work.

That is:

	if (!mod) {
		read_rcu_lock();
		mod = __module_text_address(pc);
		read_rcu_unlock();
	}

Is easier to understand than:

	if (!mod) {
		guard(rcu)();
		mod = __module_text_address(pc);
	}

Because it makes me wonder, why use a guard() for a one liner?

But, when I saw your other patch, if we had:

	if (!mod) {
		scoped_guard(rcu)()
			mod = __module_text_address(pc);
	}

To me, hat looks much better than the guard() as it is obvious to what the
code is protecting. Even though, I still prefer the explicit, lock/unlock.
Maybe, just because I'm more used to it.

IMHO, guard() is for complex functions that are error prone. A single line
is not something that is error prone (unless you don't match the lock and
unlock properly, but that's pretty obvious when that happens).

But this is just my own opinion.

-- Steve

