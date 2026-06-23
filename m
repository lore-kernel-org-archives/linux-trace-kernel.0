Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0032D3CE49E;
	Tue, 23 Jun 2026 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204219; cv=none; b=Iy9BxoGAvSdVvgDJHDKUNfVTLg55cPa4+afJ6la75lBjH75SL6XMmYHUXdWqfH2M1fr6rBtmGOn1QI0k7IVpE1mdOoAyM2EAcn8QpPFfjSIGZtlBV92T8IWpzYLXWeVpFx5IIMFeAkhdB05O5eRRh/GAZ5sHAyE2K9ercGGDMsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204219; c=relaxed/simple;
	bh=aMNvEBdsapeIjp5S3edzfJzm1T04ix/yUPD1ciALOyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAfyOeMLNyJ8vYGjq38sYKEazhs6y+iHoXG+fOfY5QfKKDHuN/Wi7sVi2yMFXWR8dwxGi526RrQT/k2n8UdP8m5Z8GqJEK2t+G+cLRvJRVYRYrK2k6O2yyNsMXJTxzcDBQA13ghrERkxZexSlK9YNGHTS706tnqY4CmP+ELkkEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DkZtZUzo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DkZtZUzo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7B9f8KJqQW/qNEKY7zLt1W8cCF6Dyzcel40tBiWAoig=; b=DkZtZUzozoodzGIs/ahPi1DUFR
	rs4DACh5j+SP1NTbfdtWRzoxFN1t02JFb7cDN5rrMnDHkua4KgwwDuG1gj2LkenLJrIADfXoAAwmw
	O+yUzdytdYpK+wEjLFSxxAF/1tFqa1OLS3lzu7nCVA9h8Y46arOcRR2fmF5WN/2o9U8f+thAra5tG
	E1CgoAn99KKBgnRqOhltaplpgV/TbujnLL85zC/2Xi6GeBxyYwQXNdOc/ff+Unn8DyCoHwFHytrlD
	kcECm8HSKp4kmTlrmnIvpn6qbueOysPnoGlwB3fQRfHT22c+e8tz5wjLb0zK5tiiYkAImibKWtMvE
	XXYw2CEg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbwjA-00000005poi-2MbV;
	Tue, 23 Jun 2026 08:43:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 710EB30324A; Tue, 23 Jun 2026 10:43:27 +0200 (CEST)
Date: Tue, 23 Jun 2026 10:43:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Windsor <dwindsor@gmail.com>
Cc: mhiramat@kernel.org, oleg@redhat.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, shuah@kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/uprobes: Keep shadow stack in sync for emulated
 CALLs
Message-ID: <20260623084327.GU48970@noisy.programming.kicks-ass.net>
References: <20260622183109.1137245-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622183109.1137245-1-dwindsor@gmail.com>

On Mon, Jun 22, 2026 at 02:31:08PM -0400, David Windsor wrote:
> Uprobe CALL emulation updates the normal user stack, but not the CET user
> shadow stack. The subsequent RET then sees a stale shadow stack entry and
> raises #CP.
> 
> Update the relative CALL emulation and XOL CALL fixup paths to keep the
> shadow stack in sync.
> 
> Fixes: 488af8ea7131 ("x86/shstk: Wire in shadow stack interface")

I can confirm this patch fixes the included test case, so yay for that.

However, should this not be:

Fixes: 1713b63a07a2 ("x86/shstk: Make return uprobe work with shadow stack")

?

> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
>  arch/x86/kernel/uprobes.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index ebb1baf1eb1d..ae32013a7097 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -1246,8 +1246,12 @@ static int default_post_xol_op(struct arch_uprobe *auprobe, struct pt_regs *regs
>  		long correction = utask->vaddr - utask->xol_vaddr;
>  		regs->ip += correction;
>  	} else if (auprobe->defparam.fixups & UPROBE_FIX_CALL) {
> +		unsigned long retaddr = utask->vaddr + auprobe->defparam.ilen;
> +
>  		regs->sp += sizeof_long(regs); /* Pop incorrect return address */
> -		if (emulate_push_stack(regs, utask->vaddr + auprobe->defparam.ilen))
> +		if (emulate_push_stack(regs, retaddr))
> +			return -ERESTART;
> +		if (shstk_update_last_frame(retaddr))
>  			return -ERESTART;
>  	}
>  	/* popf; tell the caller to not touch TF */
> @@ -1338,6 +1342,10 @@ static bool branch_emulate_op(struct arch_uprobe *auprobe, struct pt_regs *regs)
>  		 */
>  		if (emulate_push_stack(regs, new_ip))
>  			return false;
> +		if (shstk_push(new_ip) == -EFAULT) {
> +			regs->sp += sizeof_long(regs);
> +			return false;
> +		}
>  	} else if (!check_jmp_cond(auprobe, regs)) {
>  		offs = 0;
>  	}
> -- 
> 2.43.0
