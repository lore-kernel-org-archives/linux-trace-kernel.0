Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDE38634A;
	Mon, 19 May 2025 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747666173; cv=none; b=txF2yVFbZmVSwwv/sUDaLPpvxDaHF+w0KjKMVCykQS4KCNTjpJzzzYd5TUUtkH3Bj/Zkg8cRQCpKDKqooRsWa2qwKz5Lq7LKFztADhu+lQbmWarO28645PIhoGP+ayXLHMWTXYcrzyH81HHGGe3+zeEaWdKypjl+ZFFk5XO3hgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747666173; c=relaxed/simple;
	bh=ARdIMG9Onv+Lf/M5D9jqGsE2v2eAGKcGuwAltmeCirM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxOU/l7wKXhOoUMfwmYvb3qWGhdZnjrftWk6Z5yKBB+46jqY6ksGiLlVpbYYA+nFc4H5SUSWiuUerBzDGSmJk3YW9ACxjrOS0HpbEAMdbF4dB0wXyUQ4BGehPHX4sfMLJsgFJ0L4FNviUMp7sQzw92WML6s5uWIgsZobJCIT5Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBACC4CEEF;
	Mon, 19 May 2025 14:49:31 +0000 (UTC)
Date: Mon, 19 May 2025 15:49:29 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 17/22] arm64: mm: Add page fault trace points
Message-ID: <aCtE-RvyN6XJQjTo@arm.com>
References: <cover.1747046848.git.namcao@linutronix.de>
 <f5fccde2326a896e5c568ef06a4dbd9aa7465f6a.1747046848.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5fccde2326a896e5c568ef06a4dbd9aa7465f6a.1747046848.git.namcao@linutronix.de>

On Mon, May 12, 2025 at 12:51:00PM +0200, Nam Cao wrote:
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index ec0a337891dd..55094030e377 100644
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

What are the semantics for these tracepoints? When are they supposed to
be called? In the RV context context I guess you only care about the
benign, recoverable faults that would affect timing. These tracepoints
were generalised from the x86 code but I don't know enough about it to
tell when they would be invoked.

For arm64, we also have the do_translation_fault() path for example that
may or may not need to log such trace events.

-- 
Catalin
