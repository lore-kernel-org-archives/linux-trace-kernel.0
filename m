Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED36E79D2;
	Thu, 12 Jun 2025 00:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749686656; cv=none; b=p+6n5RuChP/WoTt+bDiVoVkgBndlI1c7ri4goZ1HD/2tbV5EEqhFVzh6JW/xiXxuXsVD62WEha8/jeuDYeAl5a4uOqe/CTuHXAMG/s1MAkhs6i9Jz5ksJOOxhXu+dj38YUpt0Kl18dS9sVtmt06tpqs8CLe6mHDkbpAKiDkOAQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749686656; c=relaxed/simple;
	bh=bNiddbebwxgrO+T2YxvgJlpp7XYCaOnNp2ptHJCxou8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZKZecASLvCeAvpIVDgqRv9JWDfy/xf2G32R34yZoUFMhT90fkMpbNrIDBPe9qZYMnFpp3UzW1bitYso80JvFQ4RwXDq58L+cG4j/HMhHXk6SrNtvDHkdfG+79Ivu9m7HGO2TJ+DZcwB0id2ibnIFyz2mB+OncGe7I13kGjttM2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeWBbH4N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeWBbH4N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD72C4CEE3;
	Thu, 12 Jun 2025 00:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749686655;
	bh=bNiddbebwxgrO+T2YxvgJlpp7XYCaOnNp2ptHJCxou8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JeWBbH4NIbAluoyWqsLBvZcssk1mVO4c9x2vHAvkGTYjC11VLW4n68jQReiDS1TXo
	 aTGWcYJq13beLyiTK6sSL+MkspAbu7av9QNHFRv5rHDFgOlXXfAPF0/HI7i1TEfVoK
	 pD1S7881KP5PIAEcfpvB+hZWG8xH7X/+jO/rVehOFqF0gJVcm9R5gLRFSi7uJelx+b
	 Z5lyx9F1VcnGe4G5gpSjrc3h/XVIPERnVinRGF1HVkvkHsm3BGBh8qXcPvGqzh4839
	 ZfdYFY1i6pZieUhJdN8wvZ3/Dm8DnkO+wPOPsHFnPHhJhBcDU7BxvzwqVaFi2NILRI
	 YUJyRgPjUOCzg==
Date: Thu, 12 Jun 2025 09:04:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Naresh Kamboju
 <naresh.kamboju@linaro.org>, open list <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd
 Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, Anders
 Roxell <anders.roxell@linaro.org>
Subject: Re: [RFC PATCH 2/2] x86: alternative: Invalidate the cache for
 updated instructions
Message-Id: <20250612090411.fe1cf10c61be1db40920dac8@kernel.org>
In-Reply-To: <20250611114243.43a9e3e2@batman.local.home>
References: <20250610234307.c675969e83ce53bb856e94d7@kernel.org>
	<174956686826.1494782.11512582667456262594.stgit@mhiramat.tok.corp.google.com>
	<20250610115030.0d60da65@gandalf.local.home>
	<20250611192610.6edf9713f6ee84c26f653ea5@kernel.org>
	<20250611102010.1bf7c264@batman.local.home>
	<20250611114243.43a9e3e2@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 11:42:43 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 11 Jun 2025 10:20:10 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > If interrupts are enabled when the break point hits and just enters the
> > int3 handler, does that also mean it can schedule?
> 
> I added this:
> 
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index c5c897a86418..0f3153322ad2 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -854,6 +854,8 @@ static bool do_int3(struct pt_regs *regs)
>  {
>  	int res;
>  
> +	if (!irqs_disabled())
> +		printk("IRQS NOT DISABLED\n");
>  #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
>  	if (kgdb_ll_trap(DIE_INT3, "int3", regs, 0, X86_TRAP_BP,
>  			 SIGTRAP) == NOTIFY_STOP)
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index ecfe7b497cad..2856805d9ed1 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -2728,6 +2728,12 @@ noinstr int smp_text_poke_int3_handler(struct pt_regs *regs)
>  	int ret = 0;
>  	void *ip;
>  
> +	if (!irqs_disabled()) {
> +		instrumentation_begin();
> +		printk("IRQS NOT DISABLED\n");
> +		instrumentation_end();
> +	}
> +
>  	if (user_mode(regs))
>  		return 0;
>  
> 
> 
> And it didn't trigger when enabling function tracing. Are you sure
> interrupts are enabled here?

Oops, I saw Xen's code. I confirmed that the asm_exc_int3 is
registered as GATE_INTERRUPT. Hmm. Thus this might be a qemu
bug as Peter said, because there is no chance to interrupt
the IPI after hitting #BP.

Thank you,

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
