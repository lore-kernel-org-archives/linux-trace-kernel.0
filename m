Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5094F2773CA;
	Wed,  8 Jul 2026 00:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783472047; cv=none; b=Zm2ebO09G8ETzZcUm5fx1XP12Z+hHg4PZ5KPr2px7FdvV90YpiB4+gUmt93phuXYcNwVh/xvW8vS8psn3wY5aADLmw8I0H4+BCoZUS5Jbq2Mpd3b9CKQotjtwRPduqs8UU+Jm64T9GNpMP22Xq/tx411e/MTT1BEgQ9877Gra2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783472047; c=relaxed/simple;
	bh=tUJbjm6u8/OwE0AN2uGJm/jHmgzQ4lzZVHcv+o0WZP8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sM0bnc18r3Q7o5inbh65Es4LO5j+GikzVTF3aUPTh+dJbW5nVtMdULHMYLJLLLDyh+kGKD1ws/Zy1BoT+YLlsm0HvEtxAsn23KV49btPvLCiqTSUkFx3EPgFudLF8YXlN7LFeabk+KWAZ6VqvIYgy/QGU5poIFfUKgqKBNTO6mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2Jx82ND; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2Jx82ND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CA91F000E9;
	Wed,  8 Jul 2026 00:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783472046;
	bh=ZPa4plMMy8iNMbmyGa8gqrqo+2w2vQ9zdj+sw1yvhu4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N2Jx82NDbi6EzBMJXNZ+eQya5X1w9wWA/Dumuygz7IlwXT7d5gZZcIGhWwpYmv49U
	 cObt4MJcGrCZpDMIVerxelhPQY3BRpujm7Gx77KwqWJjQJRUoLBr1INMp+x4EYHZWa
	 5UNPl+F7ChI/S4WckCJCNrJ9TsBSOfbP4tpZ1joBzf1xyia0VcPLzYbVyqsKcA5ENq
	 1GqQSMvbxl0FoEKTukuqOwz+DwpjEjHkYvbb1FJeEyGAVtctAS8iOO40k6vKB+/Eqm
	 OaEfG9ICQlsQ24OMyY6SnZJgI8L5e/WWHdUklazZ1NXLmCgHNaq31J1HSqLAW4z48v
	 8lg3xJJ85tjSQ==
Date: Wed, 8 Jul 2026 09:54:00 +0900
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
Subject: Re: [RFC 2/3] arm64: kprobes: Allow reentering kprobes while
 single-stepping
Message-Id: <20260708095400.7582bc9589fd9da925aa9c1d@kernel.org>
In-Reply-To: <20260706083636.159883-3-hupu@transsion.com>
References: <20260704234730.46d51c47d75e7d208e7bec9f@kernel.org>
	<20260706083636.159883-1-hupu@transsion.com>
	<20260706083636.159883-3-hupu@transsion.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Jul 2026 08:36:49 +0000
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

Can you also check the Sashiko comment?

https://sashiko.dev/#/patchset/20260706083636.159883-1-hupu%40transsion.com?part=2

This seems indicating potentially brakage of reenter kprobes on arm64.
But is it possible to hit another kprobe while SS on arm64? It is
the same question about the previous one, can NMI happens during
the single stepping? (maybe yes, because it is non-maskable)

Anyway, for making it safer, we need to add saved_irqflags to prev_kprobe.

Thank you,

> 
> Signed-off-by: Pu Hu <hupu@transsion.com>
> Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>
> ---
>  arch/arm64/kernel/probes/kprobes.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index e4d2852ce2fb..764b2228cca0 100644
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
