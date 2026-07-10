Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27353CC314;
	Fri, 10 Jul 2026 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676343; cv=none; b=OEy98mduPRRMLJE5JEKmNH1tHcPAOzuVxtCsAUoOAjVsCPF8yeIqTznw7Xck5rj8+AZx1a0jcU6jeDjw6cr/vVBjBdHLfmZ0TcBodg5IKbUyiU368GpPqPqZW3pt9l9nD/MKb8t4+xTagXw26D67U7Rn2HFfKCIMU0//RHCP40s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676343; c=relaxed/simple;
	bh=3uptIh4kH4uuhdSTDTQhxoio/E/E4znWTE9Ba/A0eN8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OzlmcbCADA3X2C1YQcBPe4QXqOe9EjXPnufCgmCFjUH2LBGHW25U/PeHuVQlnIITF7dIjY2cWIo5Kp634eQjEDivGD/1plAZwHlTo1W/JsfJrm10IMEMy0fxwF6RcF91aVSrKKEGNX+60czVEHsKLtWsjFMNBlpfdn6tTIkjhOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwqUo2Xw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwqUo2Xw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F861F000E9;
	Fri, 10 Jul 2026 09:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676342;
	bh=SpPmgVAbTqTg+8Z+cURPU9o5tBpGFPOz/CFMP1thnYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nwqUo2XwIK1CUSX4u96yKUmYFTfaY0KNnM2Df1B0jS7IL0HOQK0wh2tAFA3U7f6op
	 mfYUT/rDSTfCjcvhMA0wmfp3w9PXoCpfO6/xjcfzWnGVByvpnaqY5hdVUld6qilGLh
	 fe6OMXZD4hBuegBjqKLuGl3xK81IMOVXVgY2jzHL00I13nmrjZZVFYz7KmN9uEftCx
	 6NOivea/jMhQAexnD4dTnRVb6h4t6VK3YDWNX8xi9B9WErd7F03mXvsGtxU3KxUSNi
	 rZwnCfNYrcDpb5UEU4l1Hf+FxaWyjf3368m+ru7JpYZer6gVRPEgtImvUFNXF0MbfC
	 DVt7/ctdmoVWw==
Date: Fri, 10 Jul 2026 18:38:57 +0900
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
Subject: Re: [RFC v3 2/2] arm64: kprobes: Allow reentering kprobes while
 single-stepping
Message-Id: <20260710183857.176dc60026ea9fcbe4984b1d@kernel.org>
In-Reply-To: <20260710063242.228714-3-hupu@transsion.com>
References: <20260710063242.228714-1-hupu@transsion.com>
	<20260710063242.228714-3-hupu@transsion.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jul 2026 06:32:55 +0000
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
> This change also requires saving saved_irqflag in struct prev_kprobe.
> When a nested kprobe calls kprobes_save_local_irqflag(), it overwrites
> kcb->saved_irqflag with the currently masked DAIF value, losing the
> outer kprobe's original DAIF state. Without this fix, when the outer
> kprobe's single-step finishes, kprobes_restore_local_irqflag() applies
> the wrong DAIF mask and leaves interrupts permanently disabled.
> 
> Extend struct prev_kprobe with a saved_irqflag field and save/restore it
> alongside kp and status. This ensures the outer kprobe's original
> interrupt state is preserved across reentry.
> 
> This mirrors the x86 fix in commit 6a5022a56ac3
> ("kprobes/x86: Allow to handle reentered kprobe on single-stepping").
> 

OK, this looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

for this series.

Will, Catalin, can you pick this series?

Thanks!

> Signed-off-by: Pu Hu <hupu@transsion.com>
> Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>
> ---
>  arch/arm64/include/asm/kprobes.h   |  6 ++++++
>  arch/arm64/kernel/probes/kprobes.c | 23 ++++++++++++++++++++++-
>  2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
> index f2782560647b..35ce2c94040e 100644
> --- a/arch/arm64/include/asm/kprobes.h
> +++ b/arch/arm64/include/asm/kprobes.h
> @@ -26,6 +26,12 @@
>  struct prev_kprobe {
>  	struct kprobe *kp;
>  	unsigned int status;
> +
> +	/*
> +	 * The original DAIF state of the outer kprobe, saved here before
> +	 * a nested kprobe overwrites kcb->saved_irqflag during reentry.
> +	 */
> +	unsigned long saved_irqflag;
>  };
>  
>  /* per-cpu kprobe control block */
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 798e4b091d1a..4e0efad5caf2 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -174,12 +174,27 @@ static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
>  {
>  	kcb->prev_kprobe.kp = kprobe_running();
>  	kcb->prev_kprobe.status = kcb->kprobe_status;
> +
> +	/*
> +	 * Save the outer kprobe's original DAIF flags before the nested
> +	 * kprobe calls kprobes_save_local_irqflag() and overwrites
> +	 * kcb->saved_irqflag. Without this, the outer kprobe will restore
> +	 * the wrong DAIF state and leave interrupts permanently masked.
> +	 */
> +	kcb->prev_kprobe.saved_irqflag = kcb->saved_irqflag;
>  }
>  
>  static void __kprobes restore_previous_kprobe(struct kprobe_ctlblk *kcb)
>  {
>  	__this_cpu_write(current_kprobe, kcb->prev_kprobe.kp);
>  	kcb->kprobe_status = kcb->prev_kprobe.status;
> +
> +	/*
> +	 * Restore the outer kprobe's saved_irqflag so that when its
> +	 * single-step completes, kprobes_restore_local_irqflag() uses
> +	 * the correct original DAIF value.
> +	 */
> +	kcb->saved_irqflag = kcb->prev_kprobe.saved_irqflag;
>  }
>  
>  static void __kprobes set_current_kprobe(struct kprobe *p)
> @@ -240,10 +255,16 @@ static int __kprobes reenter_kprobe(struct kprobe *p,
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
