Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8816A224FD;
	Wed,  7 May 2025 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746653007; cv=none; b=mgJtLU39ax5WekeSn7gtR+Mfgd0RfKizqwG2LFS9T9L/kyvIClVSp4eqYRmVQTJyvjpyUo06KiBgTMNZ1XJ8DGtKJfhseVMVvUBnHHr5CuUavJf4neQneSubC3rxbLcik2JpocbHqUw2buvhb5eVj4hXFAJACom7HS4+CaB3IBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746653007; c=relaxed/simple;
	bh=FAIQMKiykvkTzVoLTFr11xLp7rRqPJwVZU4rGE4p0DY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CIBQrT0jdxdAt8AmCrBmuBRUEPEPXVw3k4PVdtov9dU3M+SlTtQfwMbqRJLJp0nWOzdcGdW8jbblymM5SoWPw6T22xhix7PcD6im+vF3xcdSqvOBiLE2VgZtrwSrgBgBRd4Uj0yTwhwjPVSxFDKS34AmJqZKzJ6Zkd6PhyHQQU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C9EC4CEE2;
	Wed,  7 May 2025 21:23:26 +0000 (UTC)
Date: Wed, 7 May 2025 17:23:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>, Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 john.ogness@linutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 17/22] arm64: mm: Add page fault trace points
Message-ID: <20250507172336.081a41eb@gandalf.local.home>
In-Reply-To: <554038c996662282df8a9d0482ef06f8d44fccc5.1745999587.git.namcao@linutronix.de>
References: <cover.1745999587.git.namcao@linutronix.de>
	<554038c996662282df8a9d0482ef06f8d44fccc5.1745999587.git.namcao@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Can I get an Acked-by from the ARM64 maintainers?

Thanks,

-- Steve


On Wed, 30 Apr 2025 13:02:32 +0200
Nam Cao <namcao@linutronix.de> wrote:

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
> +
>  	/*
>  	 * If we're in an interrupt or have no user context, we must not take
>  	 * the fault.

