Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0FCFC1D;
	Fri, 16 May 2025 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747404296; cv=none; b=L4RV4rD5noqxQ4+Ge8YVa66cjlz8UabsiXGM/xlfGP9QrTKAdHCqziqSEWZDv/ah8mLLQx5iR5UvlPTbOX9uD8OTGc65HBR534yK7T1Vkim+T03lUPEDvCWNjAxZi9TTp0uOVaUjxtktdc9P7T5WGAkMbPC3gDFGqPCrPz53fkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747404296; c=relaxed/simple;
	bh=AcX7tJ/ZUkuJv8Tg+tmGlLiFwaFyI1AG9s7LQ2m9uK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njcl3vDJH+uHd1YQ0ZiaJN3Kgo4IFPXjWVM6crvlXVeqHM5001hFKcKIym4PcR3Gj2Xu4mubkzWzs9acO+mU4/ggXt47VZ3q/y5G4WFc4XCGzKMcMXMxfjWjff2uv/5F7lbj5wBzbxprMpiznWB+m31LsUXwrfk6nnz/7HAEkrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWXEi9y0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWXEi9y0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE4EC4CEE4;
	Fri, 16 May 2025 14:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747404295;
	bh=AcX7tJ/ZUkuJv8Tg+tmGlLiFwaFyI1AG9s7LQ2m9uK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FWXEi9y0sujjRRuBmABfYG8aC8Yb7Ogj/u2xJ6sng23hf5pdWO2uNgvuZ7suPU89g
	 VuOGWbFRg0G4wOkLNGFvFjeRM03/+EX2ebf8mpM+ftoXYYW5TWTBNpKt2d1IWXM87n
	 si6S4k12240nPIvNtouc1TuXPp7VzoppyggtYqcCCJ3Mtz/q6UHkkiovr3bA5YwQPw
	 bvsaONlIpfUmZhIt2kfPfx/PST5Mi5+tl9UivVejq4c0RWDco1eOMGWGMEI1Phr482
	 GSlJDRrPzIxp+85quro+fUgIgRxIDepmx0Xk9fHJjDw8nm2BxRnMiw2v+vLKc4p6Ri
	 AHbivDFiHCJHA==
Date: Fri, 16 May 2025 15:04:50 +0100
From: Will Deacon <will@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 17/22] arm64: mm: Add page fault trace points
Message-ID: <20250516140449.GB13612@willie-the-truck>
References: <cover.1745999587.git.namcao@linutronix.de>
 <554038c996662282df8a9d0482ef06f8d44fccc5.1745999587.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <554038c996662282df8a9d0482ef06f8d44fccc5.1745999587.git.namcao@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Apr 30, 2025 at 01:02:32PM +0200, Nam Cao wrote:
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
> index ef63651099a9..e3f096b0dffd 100644
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
> @@ -559,6 +562,11 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>  	if (kprobe_page_fault(regs, esr))
>  		return 0;
>  
> +	if (user_mode(regs))
> +		trace_page_fault_user(addr, regs, esr);
> +	else
> +		trace_page_fault_kernel(addr, regs, esr);

Why is this after kprobe_page_fault()?

It's also a shame that the RV monitor can't hook into perf, as we
already have a sw event for page faults that you could use instead of
adding something new.

Will
