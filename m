Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113312D2483;
	Wed,  8 Jul 2026 00:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783471590; cv=none; b=Fe3ZCI0rhx3EChDqIhZDVWmCK4M3AeJLanoTpyzv2cjvZydsEiDIjkmu99O5+EOm+qHxBI/L5DleS48LHBMVkvhThWIU32dqajIp5bygc3gjLRfs/SeeLYnHkYmY91SvL21N03SLrY+MEr/xgOxvUNbxyU5T21SGDiY4QGsJuDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783471590; c=relaxed/simple;
	bh=Bf9P83x7fUMk5dMzGeq1exjWqLHn/K3DrteWzcxMP2g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uqyBx8uxmGK0jl856S6igWHh05XCM6YOyPCL/1vmxo3IFT18dB3/4B/088w94zfwNnTzePT/CtG6hXgTkf33P+o5SfZgf2C2GcBHsO4BBJhVX+jjIjGuBLmhoWZpnwJCWlGSSwWEcvYwwPLOZB33Qm5UeeUboQ7+uo3mlf/yYM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7Ptf35v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7Ptf35v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0441F000E9;
	Wed,  8 Jul 2026 00:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783471588;
	bh=keo6DKBVRQlMRYR2cMCSZGrBdCB2jtcmPI/WxsveT7I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M7Ptf35vHckLNyx0hWFY/ZsncP1KLGIyG0swnIYTD4a1Jwt8HFdo6nn7gYXsCBdNT
	 7tBtlKDIhYHW6s5cQM6sWUzYjeCcQseHduDGX6LeMR4KvXSlNpOXSO7cZ3NJ8cBjm4
	 CBirzszAGLXDoGfttKBNqH78NtwjMJfEmR3KnvlZ2gv2u1uscOjnvLgZy8JYzm/Ou1
	 j0FF//87lWZxy6yaVedBWw0jIVIHjwN3eJDjV+dUJfNQKVfRw7rs3oADI/9BQRXmE0
	 2nBNkXiSCipzjJOxnxiccCiECEOvQP1/KMIDrszQNr5yxASJKJpo3rMyv+t/mKonD/
	 HYKJmNIpyEURw==
Date: Wed, 8 Jul 2026 09:46:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Pu Hu <hupu@transsion.com>
Cc: "ada.coupriediaz@arm.com" <ada.coupriediaz@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "davem@davemloft.net"
 <davem@davemloft.net>, Hongyan Xia <hongyan.xia@transsion.com>, Jiazi Li
 <jiazi.li@transsion.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>, "naveen@kernel.org"
 <naveen@kernel.org>, "will@kernel.org" <will@kernel.org>,
 "yang@os.amperecomputing.com" <yang@os.amperecomputing.com>
Subject: Re: [RFC 1/3] arm64: kprobes: Do not handle non-XOL faults as
 kprobe faults
Message-Id: <20260708094623.9a1d40bed37bce3c7969ad20@kernel.org>
In-Reply-To: <20260706083636.159883-2-hupu@transsion.com>
References: <20260704234730.46d51c47d75e7d208e7bec9f@kernel.org>
	<20260706083636.159883-1-hupu@transsion.com>
	<20260706083636.159883-2-hupu@transsion.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Jul 2026 08:36:48 +0000
Pu Hu <hupu@transsion.com> wrote:

> From: Pu Hu <hupu@transsion.com>
> 
> kprobe_fault_handler() handles faults taken while kprobes is in
> KPROBE_HIT_SS or KPROBE_REENTER state as faults caused by the
> single-stepped instruction.
> 
> That assumption is not always true. While a kprobe is preparing or
> executing the out-of-line single-step instruction, other code may run
> in that window. For example, perf or trace code can be invoked from the
> debug exception path and may take a fault of its own. In that case the
> fault did not happen on the kprobe XOL instruction, but the kprobe fault
> handler may still try to recover it as a kprobe single-step fault.
> 
> This can corrupt the exception recovery flow and leave the real fault to
> be handled with a wrong PC. A typical reproducer is running simpleperf
> with preemptirq tracepoints and dwarf callchains while a kprobe is
> installed on a frequently executed kernel function.
> 
> Fix this by handling faults in KPROBE_HIT_SS/KPROBE_REENTER only when
> the faulting PC points at the current kprobe's XOL instruction. Faults
> from any other PC are left to the normal fault handling path.
> 
> This follows the same idea as the x86 fix in commit 6381c24cd6d5
> ("kprobes/x86: Fix page-fault handling logic").
> 
> Signed-off-by: Pu Hu <hupu@transsion.com>
> Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>
> ---
>  arch/arm64/kernel/probes/kprobes.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 43a0361a8bf0..e4d2852ce2fb 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -285,6 +285,20 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
>  	switch (kcb->kprobe_status) {
>  	case KPROBE_HIT_SS:
>  	case KPROBE_REENTER:
> +		/*
> +		 * A fault taken while a kprobe is single-stepping is not
> +		 * necessarily caused by the instruction in the XOL slot. For
> +		 * example, tracing or perf code running in this window may take
> +		 * an unrelated fault.
> +		 *
> +		 * Handle the fault here only when the faulting PC is the XOL
> +		 * instruction of the current kprobe. Otherwise let the normal
> +		 * fault handling path deal with it.
> +		 */
> +		if (cur->ainsn.xol_insn &&
> +			instruction_pointer(regs) != (unsigned long)cur->ainsn.xol_insn)
> +			break;

Can you check Sashiko's comments[1]?

[1] https://sashiko.dev/#/patchset/20260706083636.159883-1-hupu%40transsion.com?part=1

It seems that it complains about simulated kprobe's case.
In that case, cur->ainsn.xol_insn == NULL. The simulation should be done
in the kprobe context (which is a debug trap). I'm not sure the arm64
can cause NMI in that context, but if it happens and causes a fault,
it may cause a problem.

So I think we can just ignore the fault on the simulated kprobes.

To ensure that, you can just add:

	if (cur && !cur->ainsn.xol_insn)
		return 0;

at the entry of this function. (and remove redundant cur->ainsn.xol_insn check)

Thank you,

> +
>  		/*
>  		 * We are here because the instruction being single
>  		 * stepped caused a page fault. We reset the current
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
