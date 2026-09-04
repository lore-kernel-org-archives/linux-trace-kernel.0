Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0C43F12CB;
	Fri,  4 Sep 2026 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525689; cv=none; b=rd9HVDXz39n5KLw8Oxkpd4CiGcNaWGPSpwq1oy8BWXHzJHnft/P+BQfZgn1RBM4Bz0tbVQrVguL/NoXNUtsZHALE73/1hEjTKfeabV6Kn9fUV9rp1bp8EcnVfQ1dAUDA3vnIh/Js4IDrriVDso26nkSu+8OS9U/xjrXOTNDyiB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525689; c=relaxed/simple;
	bh=W6JKX7ahqnb99xfBn6RyrSANuKyNMCi0bJovw3pOCDg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IzWxbUUHbyFCK9qMDRsxDfL9QAadqahSs+XAvAGoL1w1QPZjBs1fFZ0tM6sf2rl3TumQMuAVlcYxaEvaU7v9+IIbbBWKdTtuXN9OIQkXx2sjDddEdO7jCKVhozzKzOKlw5UUojZTnt9/VFbFTLIPNi4QUv+8KGHWycjQFYWptFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGf1RJU5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGf1RJU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDC71F00A3D;
	Fri,  4 Sep 2026 12:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788525688;
	bh=UMlLb9vJyOjadzPTuVKcm4BXcQdkedIOo1s9dZIX00Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oGf1RJU5E2E1hc5yPFBLMbMic0oPzVmytHmCYp83Bb8EV3snKTx2aN+oMdoFFx41W
	 oKPm6dxUIdKBNX6pT0C/ErlctSxqAtaSEHoTuQ94v2UZr0c1wqPLIjoy94H/styoVo
	 spI7SYRif4VdHtKYf1RJSFXUS3KD2xr1sXFB83AtUbj9CaKF+bLDSPFQerLyOd1DkB
	 kYcVMFBbi7D8YRAW3HRpsxtFJQkdPkyXpb3xsuHjXTc56iUBCV44aWVw3X1ALiVbI4
	 lD7LgdbE1kJ2QWoTsU661654/ppx4Itw9vxDUdFqE5DUT38FNEnDcuCrpTVvJZgGqb
	 8un7//vGps9Jg==
Date: Fri, 4 Sep 2026 21:41:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinke Han <jinkehan@didiglobal.com>
Cc: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
 <peterz@infradead.org>, <rppt@kernel.org>, <kees@kernel.org>,
 <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/kprobe: Fix crash when probe cs call
Message-Id: <20260904214122.15b0924c7ee32dbf0998d876@kernel.org>
In-Reply-To: <20260827025756.GA26653@didi-ThinkCentre-M920t-N000>
References: <20260827025756.GA26653@didi-ThinkCentre-M920t-N000>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Aug 2026 10:57:56 +0800
Jinke Han <jinkehan@didiglobal.com> wrote:

> When I used eBPF to probe the call instructions within a function,
> we encountered a kernel crash.
> 
> The ebpf tool probes the 257 offset of the __hrtimer_run_queues
> function.
> 
> <__hrtimer_run_queues+249>:  nopl   0x0(%rax,%rax,1)
> <__hrtimer_run_queues+254>:  mov    %r14,%rdi
> <__hrtimer_run_queues+257>:  cs call <__x86_indirect_thunk_r12>
> <__hrtimer_run_queues+263>:  mov    %eax,%r12d
> <__hrtimer_run_queues+266>:  xchg   %ax,%ax
> <__hrtimer_run_queues+268>:  mov    %r13,%rdi
> 
> The scene of kernel crash is as follows:
> 
> [73665.737181] BUG: unable to handle page fault for address: 00000000000f41c9
> [73665.744253] #PF: supervisor write access in kernel mode
> [73665.749643] #PF: error_code(0x0002) - not-present page
> [73665.754843] PGD 0 P4D 0
> [73665.757390] Oops: 0002 [#1] SMP NOPTI
> [73665.761073] CPU: 1 PID: 0 Comm: swapper/1 Kdump: loaded Tainted: P
> [73665.782671] RIP: 0010:__hrtimer_run_queues+0x106/0x230
> 
> Note that __hrtimer_run_queues+0x106 is __hrtimer_run_queues+262, which is
> at the 6th byte of the above cs call instruction. Since the cs call
> instruction occupies 6 bytes, the exception occurred in the middle of that
> call instruction.

Ah, OK. So it adds a dummy CS prefix for padding the instruction.
Also, please Cc probe patch to linux-trace-kernel@vger.kernel.org too.

> 
> The root cause is that when using eBPF tools to probe in the middle of a
> function, kprobe with int3 is used as the underlying implementation.
> During single-step emulation of the original call instruction,
> int3_emulate_call assumes that the probed call instruction is 5 bytes
> long. However, the actual CS-prefixed call instruction occupies 6 bytes,
> so it constructs an incorrect exception return address. When the CPU
> returns from the kprobe handler, the next instruction to be executed is at
> the address of the last byte of that CS call instruction. Coincidentally,
> starting from that address, the CPU fetches and decodes a completely
> different instruction, which ultimately triggers a kernel crash.
> 
> Fix the issue by using the actual instruction length obtained from
> the instruction decoder when constructing the exception return
> address, rather than relying on the hardcoded CALL_INSN_SIZE macro.
> 

OK, this fixes kprobe local, but for cleanliness, I have a comment.

> Cc: stable@kernel.org
> Fixes: 6256e668b7af ("x86/kprobes: Use int3 instead of debug trap for single-step")
> Signed-off-by: Jinke Han <jinkehan@didiglobal.com>
> ---
>  arch/x86/kernel/kprobes/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 4e5f8c1736ec..b50e4a60bdfe 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -511,9 +511,11 @@ NOKPROBE_SYMBOL(kprobe_emulate_ret);
>  static void kprobe_emulate_call(struct kprobe *p, struct pt_regs *regs)
>  {
>  	unsigned long func = regs->ip - INT3_INSN_SIZE + p->ainsn.size;
> +	unsigned long ip = func;
>  
>  	func += p->ainsn.rel32;

This looks a bit less readability because func is once have a return address
and later it becomes call address. Moreover int3_emulate_call() is kept broken :(.

> -	int3_emulate_call(regs, func);
> +	int3_emulate_push(regs, ip);
> +	int3_emulate_jmp(regs, func);

What about updating int3_emulate_call() to get ip (=return address) and func?

void int3_emulate_call(struct pt_regs *regs, unsigned long ip, unsigned long func)
{
	int3_emulate_push(regs, ip);
	int3_emulate_jmp(regs, func);
}

Then in  smp_text_poke_int3_handler(struct pt_regs *regs),  we will call:

	int3_emulate_call(regs, (long)ip, (long)ip + tpl->disp);

And in this, we simply call;

	unsigned long ip = regs->ip - INT3_INSN_SIZE + p->ainsn.size;

	int3_emulate_call(regs, ip, ip + p->ainsn.rel32);

(Note: currently smp_text_poke_batch() does not handle non-5 byte nop.
it checks the size.)

Thanks,

>  }
>  NOKPROBE_SYMBOL(kprobe_emulate_call);
>  
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
