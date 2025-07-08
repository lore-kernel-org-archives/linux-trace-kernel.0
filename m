Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ECB7DA66;
	Tue,  8 Jul 2025 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980581; cv=none; b=KfPUqPPZSZ+/sB6fJq6fvSHm+HxXUdhTWtdwz5cVkigsIz9Q2s/DdiyOM7FBtHLwbJwr1uGuLe33w4RBRzJtc5zL4esepGYf7Jz5ftPBayneOvveGEsB93x3AbpqPuGuIB1Ob2AuqrtIFpNdb9776P2do6OycOQadaE8v342ZXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980581; c=relaxed/simple;
	bh=ZVuGtT3ao2Ck2P52Yl7IlTc1f1jQlD2bbjiW0uGFG2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOocV0Mt8FYtdbX/f2SSKq1kFdW7pVhpOM5vs+cfq87asOz2NCPAKxiG5FWqDjokihM2CrDRfHFRQ7/kS1W2cTONrk0NxAr2FQjr7cVxSlNQZ0BWN/l06IyRqJqenwLncsWs5gSO/G2ivSyjqPrqgCm14ejpnBjZ1zeisTQo3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlwxyWQr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlwxyWQr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B063CC4CEED;
	Tue,  8 Jul 2025 13:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751980581;
	bh=ZVuGtT3ao2Ck2P52Yl7IlTc1f1jQlD2bbjiW0uGFG2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZlwxyWQrU4D9ttuSdSt+Sc8ZcPHgsF1iOwCTCH7vcSUtRV0HIPaO2Gcy6UilNpeRl
	 sWzJCrcQlwpTM0RonjYNtTlYAwaqsD+pYEny8GbdC2XxIoRaDp5ute8gV7BGAjq1Df
	 2u+vulci9U9x6IbsqfjRoxyRP1Y1mbaTcZkyUwhJRkLXttBCjD5nnfhgBJz3Z6+fsv
	 wPL7IvHYhFGZwI8FF2NRGCJoGXlG7MfkXjcKC7VIMEpVyaxaRaS9Io0SnGJ1tvDO2x
	 Jz7uI3OpFqxmbcDTEyqXOuQiZEh8AGgcuHKOkNsDPD327mOfR7EtTv5wt2Z9PrKI7q
	 QewJ1L5zROtbA==
Date: Tue, 8 Jul 2025 14:16:16 +0100
From: Will Deacon <will@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 17/22] arm64: mm: Add page fault trace points
Message-ID: <aG0aIKzxApp9j7X0@willie-the-truck>
References: <cover.1747649899.git.namcao@linutronix.de>
 <61063f55e2c2df6db69cb63eac9d6653f38fbfbd.1747649899.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61063f55e2c2df6db69cb63eac9d6653f38fbfbd.1747649899.git.namcao@linutronix.de>

On Mon, May 19, 2025 at 12:27:35PM +0200, Nam Cao wrote:
> Add page fault trace points, which are useful to implement RV monitor which
> watches page faults.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm64/mm/fault.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index ec0a337891dd..d917556869f9 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -44,6 +44,9 @@
>  #include <asm/tlbflush.h>
>  #include <asm/traps.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/exceptions.h>
> +
>  struct fault_info {
>  	int	(*fn)(unsigned long far, unsigned long esr,
>  		      struct pt_regs *regs);
> @@ -556,6 +559,11 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>  	int si_code;
>  	int pkey = -1;
>  
> +	if (user_mode(regs))
> +		trace_page_fault_user(addr, regs, esr);
> +	else
> +		trace_page_fault_kernel(addr, regs, esr);
> +
>  	if (kprobe_page_fault(regs, esr))
>  		return 0;

As per the discussion with Steve on v6, I still object to relying on the
arch code to call all these different trace helpers (rv, kprobes, perf)
in the right place and consistently with each other.

In:

https://lore.kernel.org/r/20250519120837.794f6738@batman.local.home

Steve suggested wrapping some of this up in a core function to help with
that.

Will
