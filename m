Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9597C5A79B;
	Tue, 22 Oct 2024 05:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729574893; cv=none; b=D4IqpvaGLZeqSIYRu2tFTIj3vVqjc0Qk5qQQc2T3cHufAmPL6VUPQ5eeoRNCkRcdwNz5S9k/X1Dqq5eYlEl2NUXThxjmN4IQrANPR/nEclvXifpeZk/E3wbsRrxEHXr+6veRisvBIiLqs7esOEkqPxwCTMhwUOPcLLEp2bANGiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729574893; c=relaxed/simple;
	bh=MU6k+o8mlxN01YgfI+hrtN6FEbvyXOUUdJtvRafczeE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O9zQeV5GRDp2Mm9qRnmadQmHLn9woIz57b0nlsWrfi9pQ8xXxOkQUCZGQKdCxpeVsi6WfOE6nAUFZOQFugmle2kzefeq0Ll3bp7OS6FtITCZTJncbjdXdpRpSfFktx3LkUxnsbjCl+I+ruLyRyOKdqZsg4FgFH205Pavyb/wJH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D30C4CEC3;
	Tue, 22 Oct 2024 05:28:12 +0000 (UTC)
Date: Tue, 22 Oct 2024 01:28:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] m68k: Add tracirqs
Message-ID: <20241022012809.1ef083cd@rorschach.local.home>
In-Reply-To: <20241021-add-m68k-tracing-support-v1-1-0883d704525b@yoseli.org>
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
	<20241021-add-m68k-tracing-support-v1-1-0883d704525b@yoseli.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 11:44:42 +0200
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:

> The TRACE_IRQFLAGS_SUPPORT requires the architecture to call
> trace_hardirqs_off() when interrupts are disabled and
> trace_hardirqs_on() when they are enabled.
> Add those calls to do_IRQ function.
> 
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---
>  arch/m68k/Kconfig      | 1 +
>  arch/m68k/kernel/irq.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index cc26df907bfe3c8143a931d259eceabb16af7411..ab3375475721fa63418c40d4ba6ac76679ebc77d 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -39,6 +39,7 @@ config M68K
>  	select OLD_SIGSUSPEND3
>  	select UACCESS_MEMCPY if !MMU
>  	select ZONE_DMA
> +	select TRACE_IRQFLAGS_SUPPORT
>  
>  config CPU_BIG_ENDIAN
>  	def_bool y
> diff --git a/arch/m68k/kernel/irq.c b/arch/m68k/kernel/irq.c
> index 9ab4f550342e5de11c528f55781432675ffd66bf..74cf60ebbc4bca51f3caa4046dbd2bdb02355711 100644
> --- a/arch/m68k/kernel/irq.c
> +++ b/arch/m68k/kernel/irq.c
> @@ -21,9 +21,11 @@ asmlinkage void do_IRQ(int irq, struct pt_regs *regs)
>  {
>  	struct pt_regs *oldregs = set_irq_regs(regs);
>  
> +	trace_hardirqs_off();
>  	irq_enter();
>  	generic_handle_irq(irq);
>  	irq_exit();
> +	trace_hardirqs_on();

This part of the patch shouldn't be needed because those shoudl be
called by irq_enter() and irq_exit(). Does this not work if you don't
have these?

-- Steve




>  
>  	set_irq_regs(oldregs);
>  }
> 

