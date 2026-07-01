Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE7C126C03;
	Wed,  1 Jul 2026 00:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782867114; cv=none; b=fQhRvPdrxRImzbnPgAHGriv+8RqShgQ1mCL21eLp4LqPQm5C19aMy46OEX0eOFPm83UNnMl9S80pvQXwGie/MC9GdOzA1Li0MtgwCbl9+OgWPubjidyV5XR1yk4Rl8A0LJXxcMc1AJdmVYaZZgUcZZcQMVNfEYQXnRAYHytZyts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782867114; c=relaxed/simple;
	bh=7NJl4JeMESMSex9GUk4mtHlH8Z94Fc/bJaETk+YnUoo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ogOFRLK9c+evxdSrNJz85/C9BjqKY7tfRx64o+spNACvmYHWxbneCvfOO+TxVb7fULgpG4/aJjvmjhHjti4xibk0hq3m2csh3APzUnQDoOi1Cn5+vv6IBVAzH0AB/AJR/A6A/Kk1Zl6zDKvP67XpEiGRAY4lzNd6qlg16j29O/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X16rURSX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X16rURSX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AE31F000E9;
	Wed,  1 Jul 2026 00:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782867112;
	bh=zLi7Vg2dPMjNzDP//hBvVKYr8bQb2SeKAXa4U7pR2ko=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=X16rURSX7a1ZcuXZZyv6neAvXp/8RmXIg4iNMWu0ldcqoTZnWIQEA5unHAhf05B0W
	 KDL4T0J2SCUMMy3LySSpl/9vdzfM5Q5xkdqOMgcruvjKPysnycz2jVDDK7yGNlWDak
	 Im33dqEQkGfLOv/LNRfa08VpbdEPD67NDcpkApBWvRXx9evaS4QiY62zdICz5M2Pir
	 RcqqHI+b64K71nvGvaMDv5fA/kXkz/AWXTqxbUt1gQvuhgU4X9fHSYUWWKtOfeHY8C
	 UL52V/WOFdtKzPNdjAcs1JsdpOQUzEIiB0xnl+CRTwvFUg2LsOnGl/SRlxgKwlWRFP
	 A7t6FuHcTZteQ==
Date: Tue, 30 Jun 2026 18:51:49 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>, Masami Hiramatsu <mhiramat@kernel.org>
cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Albert Ou <aou@eecs.berkeley.edu>, Steven Rostedt <rostedt@goodmis.org>, 
    linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
    linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: probes: save original sp in rethook trampoline
In-Reply-To: <20260701073335.548d8f0b435b1a5fb4e41a69@kernel.org>
Message-ID: <d588ef0f-6eb0-665b-871f-5fb5a6c90547@kernel.org>
References: <20260630194010.1824039-1-martin@kaiser.cx> <20260701073335.548d8f0b435b1a5fb4e41a69@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 1 Jul 2026, Masami Hiramatsu wrote:

> On Tue, 30 Jun 2026 21:40:03 +0200
> Martin Kaiser <martin@kaiser.cx> wrote:
> 
> > Reading a word from the stack in a kretprobe crashes a risc-v kernel.
> > 
> > $ cd /sys/kernel/tracing/
> > $ echo 'r n_tty_write $stack0' > dynamic_events
> > $ echo 1 > events/kprobes/enable
> > Unable to handle kernel paging request at virtual address 0000000200000128
> > ...
> > [<ffffffff80016d16>] regs_get_kernel_stack_nth+0x26/0x38
> > [<ffffffff80177196>] process_fetch_insn+0x3ee/0x760
> > [<ffffffff80177836>] kretprobe_trace_func+0x116/0x1f0
> > [<ffffffff8017795a>] kretprobe_dispatcher+0x4a/0x58
> > [<ffffffff8013572e>] kretprobe_rethook_handler+0x5e/0x90
> > [<ffffffff80180838>] rethook_trampoline_handler+0x70/0x108
> > [<ffffffff8001ba32>] arch_rethook_trampoline_callback+0x12/0x1c
> > [<ffffffff8001ba84>] arch_rethook_trampoline+0x48/0x94
> > [<ffffffff8067872a>] tty_write+0x1a/0x30
> > 
> > In regs_get_kernel_stack_nth, regs->sp contains an arbitrary value.
> > 
> > arch_rethook_trampoline saves the registers from the probed function in a
> > struct pt_regs. sp is not saved. Instead, sp is decremented for
> > arch_rethook_trampoline's local stack.
> > 
> > Fix this crash and save the original sp along with the other registers.
> > Use a0 as a temporary register, it is overwritten anyway.
> 
> Good catch!
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> I would like this to be handled by the RISC-V maintainers.

Thanks, added a Fixes: tag and cc'ed stable, and queued for v7.2-rc.


- Paul
