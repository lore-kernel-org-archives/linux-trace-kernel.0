Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774C942E00D;
	Wed,  8 Jul 2026 11:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783511994; cv=none; b=kEpe2214sZoxNBUTY43JUfCK2rUOm8rAqK0oUEj1ltdrYfk+3IGsCO/ngClNEcY8zwkvXdNg2O+RGAOw1r5y4K0y8Yv+ntE3+pMAU3mKhwcKs4fh701yTkJGAw9z+901XRIK7jOWRwaeqIjAFrHjIbf0fgX9v1FVOQqc1JVMV3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783511994; c=relaxed/simple;
	bh=a6WG+kQe6kDv68M8SKegLG5uBcuIQ8EBZBXr26WEF9E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tQ08/4usfympP89yXUpI6lrwa2Fucl3WaGyi4N4AD9fwyBK2Q5gIkfBdhJ9u7iCqyse8Mxo17+yYdZ6CwnaYxGY4ez3Mb+riAMBRcFdcXsO4bQxHcvQHVypJlIlKzvb0Q8WKsD0LWK0cADNTmuXlljSJ9m4fL3Np6Naiqittmn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMUxbtXk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMUxbtXk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8775A1F000E9;
	Wed,  8 Jul 2026 11:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783511993;
	bh=SjYX5JDUJ3OuVa6TYMKH9yZVpovHAlUp4/LPh7CQQoI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jMUxbtXkzuWyjEopqq8rBRhapg+vkMaB+UQ9CWLLzO5JBI+hkHuVMMuirf533S7ES
	 pL0WBC/DY+E9S3JduF4d8AavabUwq5d1ea72n8q9282RelKY/RSiL4yI7qZ0HeHdX3
	 dLQ4QhB8bM+qpkR5oIwntdWVMWoTgyTbSDk7TIw+De3FddQyGN6egGsvTHDqUnVV+r
	 gJwCvT87whNT/V/KjHi/49S5zM1lPhvywv9BlrS9smK/rSTX8T4bJMtQRW5Rman9AU
	 jYAAS7G6yNYFAWmsMMfyc80j5i4JkcXgaqsxk+SaXWcFWihDTtRCIYhtLpbqhRbw4l
	 ZORJI1NqTPfSg==
Date: Wed, 8 Jul 2026 20:59:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Hongyan Xia <hongyan.xia@transsion.com>
Cc: Pu Hu <hupu@transsion.com>, "ada.coupriediaz@arm.com"
 <ada.coupriediaz@arm.com>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "davem@davemloft.net" <davem@davemloft.net>,
 Jiazi Li <jiazi.li@transsion.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>, "naveen@kernel.org"
 <naveen@kernel.org>, "will@kernel.org" <will@kernel.org>,
 "yang@os.amperecomputing.com" <yang@os.amperecomputing.com>
Subject: Re: [RFC 1/3] arm64: kprobes: Do not handle non-XOL faults as
 kprobe faults
Message-Id: <20260708205947.4af54d7638f115e915e9c7ee@kernel.org>
In-Reply-To: <c33043c2-f931-4687-ad16-2d60ab12faca@transsion.com>
References: <20260704234730.46d51c47d75e7d208e7bec9f@kernel.org>
	<20260706083636.159883-1-hupu@transsion.com>
	<20260706083636.159883-2-hupu@transsion.com>
	<20260708094623.9a1d40bed37bce3c7969ad20@kernel.org>
	<8cc07468-804e-4ee1-acad-77bc99af74c6@transsion.com>
	<20260708164224.c080a1e834f02ac953007e5c@kernel.org>
	<c33043c2-f931-4687-ad16-2d60ab12faca@transsion.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Jul 2026 08:55:37 +0000
Hongyan Xia <hongyan.xia@transsion.com> wrote:

> On 7/8/2026 3:42 PM, Masami Hiramatsu wrote:
> > On Wed, 8 Jul 2026 05:57:24 +0000
> > Hongyan Xia <hongyan.xia@transsion.com> wrote:
> >
> >> Hi Masami,
> >>
> >> On 7/8/2026 8:46 AM, Masami Hiramatsu wrote:
> >>> On Mon, 6 Jul 2026 08:36:48 +0000
> >>> Pu Hu <hupu@transsion.com> wrote:
> >>>
> >>>> From: Pu Hu <hupu@transsion.com>
> >>>>
> >>>> kprobe_fault_handler() handles faults taken while kprobes is in
> >>>> KPROBE_HIT_SS or KPROBE_REENTER state as faults caused by the
> >>>> single-stepped instruction.
> >>>>
> >>>> That assumption is not always true. While a kprobe is preparing or
> >>>> executing the out-of-line single-step instruction, other code may run
> >>>> in that window. For example, perf or trace code can be invoked from the
> >>>> debug exception path and may take a fault of its own. In that case the
> >>>> fault did not happen on the kprobe XOL instruction, but the kprobe fault
> >>>> handler may still try to recover it as a kprobe single-step fault.
> >>>>
> >>>> This can corrupt the exception recovery flow and leave the real fault to
> >>>> be handled with a wrong PC. A typical reproducer is running simpleperf
> >>>> with preemptirq tracepoints and dwarf callchains while a kprobe is
> >>>> installed on a frequently executed kernel function.
> >>>>
> >>>> Fix this by handling faults in KPROBE_HIT_SS/KPROBE_REENTER only when
> >>>> the faulting PC points at the current kprobe's XOL instruction. Faults
> >>>> from any other PC are left to the normal fault handling path.
> >>>>
> >>>> This follows the same idea as the x86 fix in commit 6381c24cd6d5
> >>>> ("kprobes/x86: Fix page-fault handling logic").
> >>>>
> >>>> Signed-off-by: Pu Hu <hupu@transsion.com>
> >>>> Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>
> >>>> ---
> >>>>    arch/arm64/kernel/probes/kprobes.c | 14 ++++++++++++++
> >>>>    1 file changed, 14 insertions(+)
> >>>>
> >>>> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> >>>> index 43a0361a8bf0..e4d2852ce2fb 100644
> >>>> --- a/arch/arm64/kernel/probes/kprobes.c
> >>>> +++ b/arch/arm64/kernel/probes/kprobes.c
> >>>> @@ -285,6 +285,20 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
> >>>>         switch (kcb->kprobe_status) {
> >>>>         case KPROBE_HIT_SS:
> >>>>         case KPROBE_REENTER:
> >>>> +             /*
> >>>> +              * A fault taken while a kprobe is single-stepping is not
> >>>> +              * necessarily caused by the instruction in the XOL slot. For
> >>>> +              * example, tracing or perf code running in this window may take
> >>>> +              * an unrelated fault.
> >>>> +              *
> >>>> +              * Handle the fault here only when the faulting PC is the XOL
> >>>> +              * instruction of the current kprobe. Otherwise let the normal
> >>>> +              * fault handling path deal with it.
> >>>> +              */
> >>>> +             if (cur->ainsn.xol_insn &&
> >>>> +                     instruction_pointer(regs) != (unsigned long)cur->ainsn.xol_insn)
> >>>> +                     break;
> >>>
> >>> Can you check Sashiko's comments[1]?
> >>>
> >>> [1] https://sashiko.dev/#/patchset/20260706083636.159883-1-hupu%40transsion.com?part=1
> >>>
> >>> It seems that it complains about simulated kprobe's case.
> >>> In that case, cur->ainsn.xol_insn == NULL. The simulation should be done
> >>> in the kprobe context (which is a debug trap). I'm not sure the arm64
> >>> can cause NMI in that context, but if it happens and causes a fault,
> >>> it may cause a problem.
> >>>
> >>> So I think we can just ignore the fault on the simulated kprobes.
> >>>
> >>> To ensure that, you can just add:
> >>>
> >>>           if (cur && !cur->ainsn.xol_insn)
> >>>                   return 0;
> >>>
> >>> at the entry of this function. (and remove redundant cur->ainsn.xol_insn check)
> >>
> >> Right, both cases:
> >>
> >> 1. single-step XOL
> >> 2. simulated
> >>
> >> have this problem and this patch fixed 1. 2 remains unchanged.
> >>
> >> Ideally we should fix both, but the simulated case seems more
> >> complicated, and at least we didn't make things worse for 2. So I wonder
> >> if we can analyze 2 more thoroughly and fix it in a separate patch.
> >
> > OK, but basically this fault handler is only for the SS XOL,
> > not for simulated one (as same as x86). So just skip the
> > simulated case is enough in this patch.
> > (Note that x86 also have simulated path, and that is not handled
> > by the fault handler)
> 
> Hmm, what happens if the original PC is a simulated instruction that has
> a recoverable ex_table entry that handles potential page fault,

That should never happen. BPF trampoline code may populate extable
entries, but kprobe doesn't. For the simulated instruction, as far
as I can see, there are 2 operations 
 - simulate_ldr_literal
 - simulate_ldrsw_literal
will involve the memory access and both are accessing PC-relative
kernel data, which should be mapped.

load_addr = addr + ldr_displacement(opcode);
...
set_x_reg(regs, xn, READ_ONCE(*(u64 *)load_addr));

this directly accessing the memory without using extable.


> and this
> PC also has an attached kprobe?

You meant that putting kprobes in simulate_* functions?
Those have __kprobes attribute, so kprobe can not probe it.
(It should use NOKPROBE_SYMBOL...)

> Then the simulated case should be able
> to enter kprobe_fault_handler()?
> 
> .ex_table:
>         insn foo, handler bar
> 
> foo:
>         LDR symbol # Load PC-relative. Simulated. Kprobe attached.
>         ret
> 
> When foo is called and the kprobe fires, it enters simulated path but
> then LDR triggers a page fault. It then enters kprobe_fault_handler() to
> fixup the PC. Then the fixup_exception() of the normal page fault finds
> the ex_table entry and this case is successfully handled?

To do that, you need to update the simulate_ldr* to use uaccess API
(_ASM_EXTABLE_UACCESS* macros) AND allow kprobes to probe those functions.

> 
> Looks like this handler can be entered by simulated instructions? Or
> this is only theoretical and whoever arrange code like this should be
> fired immediately?

So the simulated instructions never cause fault, or if it causes a fault
that means the original code has a bug. (Of course there is room to
improve the bug message so that it decodes the address probed by kprobe
when a bug occurs.)

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
