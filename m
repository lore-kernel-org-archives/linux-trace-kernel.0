Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C867826A1C4;
	Fri, 10 Jul 2026 05:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783660182; cv=none; b=MTJrWNBHaKPAVCWPvagh62+vKscI83rEg81d6WDGLNQMRbLklH27u0TIGLST5xH1oWwizrqazAftsYTyIl9+ad0/NRsWGhQ3VxnmSzIeVmp0jctMnH1t91ruzke8gF4Kj1Ul8bfJkl8Jpv4fXjD7wQDdQQ0NNsHCgDDL4MbQ6xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783660182; c=relaxed/simple;
	bh=0oASfdtSkBx2RepbUZpcih1U7xj0IUPhyZ9OhgcqHzc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZY2puBteVHjwWb0PJB2G7l9dzYcjehekyXgQ4x30XC24E+uApmVMWVe2jG4BV2m5JcpznOLSG7ItrzTDCCt/mq74BmeO47njy8BuVWZ1YBzo8scfMypWwYauMGftKILYkR1Z43/G68EKcVKmjFLxQdkm1xReclTVw0Z0396N3us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RV6c1iXa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RV6c1iXa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD641F000E9;
	Fri, 10 Jul 2026 05:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783660181;
	bh=/gvB5qwbT78hXA6WigUj4DzknIHPDynctPCi9ezZArQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RV6c1iXakob2plSYioZq0ZlQFxbU0si4E0zbzqFMhpsnIOL/qW84hVY3I/rBp5KA6
	 8jpgSJr3mGUxqYb/QpBzEOqPCMAm4KDqMvOFIY4umfyT/9gwFRbUIhZ1HWTJ3Dx5Ok
	 s2KJUJqmWTd3MvL7/D5HJXiOseK9GWy8mtpjqoRhSXe1KQemCk3LuPvymovPU+SsIz
	 7l+sQk1Hg9fW2P4OvWMqa1I8el+LjzM0gEX2DAr0ZPhfWrVhdntU0er+Z1FYce0wRg
	 m4EREBILvvVmtbsc4BdUA+1gmoBfAYJeTeHhFBq9sHZjQFKw7Xr/oNgEhcLmJsQ9GR
	 IrpcOLcYdb/1A==
Date: Fri, 10 Jul 2026 14:09:36 +0900
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
Subject: Re: [RFC v2 2/3] arm64: kprobes: Allow reentering kprobes while
 single-stepping
Message-Id: <20260710140936.8788416564452e490c71634c@kernel.org>
In-Reply-To: <20260709142215.226872-3-hupu@transsion.com>
References: <20260709142215.226872-1-hupu@transsion.com>
	<20260709142215.226872-3-hupu@transsion.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jul 2026 14:22:25 +0000
Pu Hu <hupu@transsion.com> wrote:

> From: Pu Hu <hupu@transsion.com>
> 
> A kprobe can be hit while another kprobe is in KPROBE_HIT_SS state. This
> can happen when tracing or perf code runs from the debug exception path
> while the first kprobe is preparing or executing its out-of-line
> single-step instruction.
> 
> Currently arm64 treats a kprobe hit in KPROBE_HIT_SS as unrecoverable,
> the same as a hit in KPROBE_REENTER. This is too strict. A hit in
> KPROBE_HIT_SS is still a one-level reentry and can be handled by saving
> the current kprobe state and setting up single-step for the new probe,
> just like reentry from KPROBE_HIT_ACTIVE or KPROBE_HIT_SSDONE.
> 
> The truly unrecoverable case is hitting another kprobe while already in
> KPROBE_REENTER, because the reentry save area has already been consumed.
> 
> Move KPROBE_HIT_SS to the recoverable reentry cases and leave
> KPROBE_REENTER as the unrecoverable nested reentry case.
> 
> This mirrors the x86 fix in commit 6a5022a56ac3
> ("kprobes/x86: Allow to handle reentered kprobe on single-stepping").
> 

Hi, as Sashiko commented, we have to save the saved_irqflag to
prev_kprobbe.

https://sashiko.dev/#/patchset/20260709142215.226872-1-hupu%40transsion.com?part=2

Thank you,

> Signed-off-by: Pu Hu <hupu@transsion.com>
> Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>
> ---
>  arch/arm64/kernel/probes/kprobes.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 798e4b091d1a..2ca5916eca2f 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -240,10 +240,16 @@ static int __kprobes reenter_kprobe(struct kprobe *p,
>  	switch (kcb->kprobe_status) {
>  	case KPROBE_HIT_SSDONE:
>  	case KPROBE_HIT_ACTIVE:
> +	case KPROBE_HIT_SS:
> +		/*
> +		 * A probe can be hit while another kprobe is preparing or
> +		 * executing its XOL single-step instruction. This is still a
> +		 * recoverable one-level reentry, so handle it in the same way as
> +		 * reentry from KPROBE_HIT_ACTIVE or KPROBE_HIT_SSDONE.
> +		 */
>  		kprobes_inc_nmissed_count(p);
>  		setup_singlestep(p, regs, kcb, 1);
>  		break;
> -	case KPROBE_HIT_SS:
>  	case KPROBE_REENTER:
>  		pr_warn("Failed to recover from reentered kprobes.\n");
>  		dump_kprobe(p);
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
