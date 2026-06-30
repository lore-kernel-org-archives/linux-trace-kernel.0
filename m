Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B94326F288;
	Tue, 30 Jun 2026 22:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858821; cv=none; b=luQu+SJMj5q7Kb8T6Ol4zgjh0xIS31MJ54CQ2B/Mj1w/4rH0ADwuJytfJyTGPCrMf3d+pIU98gula8LKRj2XKsfeILL0Y0TJWETl4UhRd7CzuwnghxzGRirvM/VBGPCZP/AlncD3tTG4twfz52xryxcFaqS3V9aKujxBdG/6QUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858821; c=relaxed/simple;
	bh=PfDhfTCty8cy50XxomBebJUpYHTYGZnqKnEiOdT6AGc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=G6R8f8sp6+L7FT/EKOhT5J1l+zfQO7eVI3KRvaXi/Lgl9Xw1hQz455tssJIqhjfxyKGp0JHnIeyJhRzo8Qwh5Ww5djHmD0UimKMHMfPeT3peSyzO5FIJIhhrZp8ENYc4VdqkRnvphlGujIpWGHNkOMDLCZUdYf25uILurcDDp0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqPNRRhk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqPNRRhk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966701F000E9;
	Tue, 30 Jun 2026 22:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782858819;
	bh=nfsKD9GM3ZJvGDmqQFlRaZt3ShaCsQhGyjSUxj31w/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mqPNRRhkZE9AmyWatl9oPrw5D8gb2kOs8ITdoOEP9s2ZjxiM/LsTaETgg7Ay3lSaU
	 5XelscLjQY+z2464u0pya13QkL4J5v4gCN7aMhYLAxiKK4tSAz7HdWPJuIZSg+1ISb
	 JBXY4tnBSfa5T3RfZ/VD3/p0VHFs5FgzmgGM8qZFwaDUAl05KONAMsZJd/S+1I6QXv
	 mxuUIeFMSMaqc5wRFtIL0mnX6MSK6Mpa/6YIL/gTAAdyj7ZiWEXmxgosf0dB8uyyRI
	 F5vpySITWhkX1rPbPbP2JpibpL8PQIzVV29okmuThGV022pWt5eKUoRh0Ba4WhAtO0
	 ttEFBiBlgqi4A==
Date: Wed, 1 Jul 2026 07:33:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: probes: save original sp in rethook trampoline
Message-Id: <20260701073335.548d8f0b435b1a5fb4e41a69@kernel.org>
In-Reply-To: <20260630194010.1824039-1-martin@kaiser.cx>
References: <20260630194010.1824039-1-martin@kaiser.cx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 21:40:03 +0200
Martin Kaiser <martin@kaiser.cx> wrote:

> Reading a word from the stack in a kretprobe crashes a risc-v kernel.
> 
> $ cd /sys/kernel/tracing/
> $ echo 'r n_tty_write $stack0' > dynamic_events
> $ echo 1 > events/kprobes/enable
> Unable to handle kernel paging request at virtual address 0000000200000128
> ...
> [<ffffffff80016d16>] regs_get_kernel_stack_nth+0x26/0x38
> [<ffffffff80177196>] process_fetch_insn+0x3ee/0x760
> [<ffffffff80177836>] kretprobe_trace_func+0x116/0x1f0
> [<ffffffff8017795a>] kretprobe_dispatcher+0x4a/0x58
> [<ffffffff8013572e>] kretprobe_rethook_handler+0x5e/0x90
> [<ffffffff80180838>] rethook_trampoline_handler+0x70/0x108
> [<ffffffff8001ba32>] arch_rethook_trampoline_callback+0x12/0x1c
> [<ffffffff8001ba84>] arch_rethook_trampoline+0x48/0x94
> [<ffffffff8067872a>] tty_write+0x1a/0x30
> 
> In regs_get_kernel_stack_nth, regs->sp contains an arbitrary value.
> 
> arch_rethook_trampoline saves the registers from the probed function in a
> struct pt_regs. sp is not saved. Instead, sp is decremented for
> arch_rethook_trampoline's local stack.
> 
> Fix this crash and save the original sp along with the other registers.
> Use a0 as a temporary register, it is overwritten anyway.

Good catch!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

I would like this to be handled by the RISC-V maintainers.

Thank you,

> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  arch/riscv/kernel/probes/rethook_trampoline.S | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/kernel/probes/rethook_trampoline.S b/arch/riscv/kernel/probes/rethook_trampoline.S
> index f2cd83d9b0f0..c3aa8d8cf5af 100644
> --- a/arch/riscv/kernel/probes/rethook_trampoline.S
> +++ b/arch/riscv/kernel/probes/rethook_trampoline.S
> @@ -41,6 +41,9 @@
>  	REG_S x29, PT_T4(sp)
>  	REG_S x30, PT_T5(sp)
>  	REG_S x31, PT_T6(sp)
> +	/* save original sp */
> +	addi a0, sp, PT_SIZE_ON_STACK
> +	REG_S a0, PT_SP(sp)
>  	.endm
>  
>  	.macro restore_all_base_regs
> -- 
> 2.43.7
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
