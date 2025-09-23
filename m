Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39202594BD;
	Tue, 23 Sep 2025 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624698; cv=none; b=syHshpdFIcaDgIIwyn47i6aNFd/tLfaQJamnY+/QU7rnBmjtAuLi1JcNLq7thbE8AlHd6I5tdX5nXbqYE4mJndOalr3e3S6wvClodnRKXGezU9Etdt9b/hOBGIAcN1fC2p9ev/tE54Ivt/+lBMoow76jZlqupZyq16SrH2RhPR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624698; c=relaxed/simple;
	bh=HK7XH7Zdx42B1St/VmVmTEivRyAOokNd58xFAhZnBeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Swii4myOI4C1qDUdORpZjxDr5LZalwTaROu0pRuByXQDaHdVhY6on7PpwyqukwWtQ/2FCYsfsarkZcsmL33SCQdmVAFfjBrozp8pH5Qx3KGISEMEaM5aTJe5DT42SsdE0xlXof6GMOvhTu8R0/Dqy5BxULABk++ap9q0MnInHw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hxtp9JEG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hxtp9JEG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6niV9LF8ivGxzBwxlAX/aJR2l+FBxOoCnfdCxOKaYiU=; b=Hxtp9JEGYAZAcCjZ+GRNlF6lbm
	pwVpZaao1LImFc10D3RqIjfXB29iqwZzvQu408AmgpEC+8yQJfBbHo6skgtXgKDfAHQ1hYZSZgUYW
	M8BkIeYrAPq1pp1XzYO+gGpUWHMxMk7uhi+jPbKXyyI3Vji5D2LrWsWXswrQvYJaj/1UgyrkrFx17
	CHIeI6ckEFTB0jBwfBRaHpX8konRIXFlxg0VasiyrahI8wQHgGM57X0Ep0uuZkewuwpStOppvL2Pa
	BiXuw1RcSwo8hgL5h0wmyTdllzxxeW3a2n9xpm68DatJkYESE3TtIy7fvRszRtZdAIBU34CdO1mEb
	n3q7c2hg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v10cN-0000000AC75-0wKm;
	Tue, 23 Sep 2025 10:51:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C775330049C; Tue, 23 Sep 2025 12:51:30 +0200 (CEST)
Date: Tue, 23 Sep 2025 12:51:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH v2 1/2] unwind_user/x86: Enable frame pointer unwinding
 on x86
Message-ID: <20250923105130.GG3419281@noisy.programming.kicks-ass.net>
References: <20250827193644.527334838@kernel.org>
 <20250827193828.347397433@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827193828.347397433@kernel.org>

On Wed, Aug 27, 2025 at 03:36:45PM -0400, Steven Rostedt wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Use ARCH_INIT_USER_FP_FRAME to describe how frame pointers are unwound
> on x86, and enable CONFIG_HAVE_UNWIND_USER_FP accordingly so the
> unwind_user interfaces can be used.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  arch/x86/Kconfig                   |  1 +
>  arch/x86/include/asm/unwind_user.h | 11 +++++++++++
>  2 files changed, 12 insertions(+)
>  create mode 100644 arch/x86/include/asm/unwind_user.h
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 58d890fe2100..8f94c58d4de8 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -299,6 +299,7 @@ config X86
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
>  	select HAVE_UNSTABLE_SCHED_CLOCK
> +	select HAVE_UNWIND_USER_FP		if X86_64
>  	select HAVE_USER_RETURN_NOTIFIER
>  	select HAVE_GENERIC_VDSO
>  	select VDSO_GETRANDOM			if X86_64
> diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
> new file mode 100644
> index 000000000000..8597857bf896
> --- /dev/null
> +++ b/arch/x86/include/asm/unwind_user.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_UNWIND_USER_H
> +#define _ASM_X86_UNWIND_USER_H
> +
> +#define ARCH_INIT_USER_FP_FRAME							\
> +	.cfa_off	= (s32)sizeof(long) *  2,				\
> +	.ra_off		= (s32)sizeof(long) * -1,				\
> +	.fp_off		= (s32)sizeof(long) * -2,				\
> +	.use_fp		= true,
> +
> +#endif /* _ASM_X86_UNWIND_USER_H */

Moo, and now you have me look at unwind/user.c:

        /* Make sure that the address is word aligned */
        shift = sizeof(long) == 4 ? 2 : 3;
        if (cfa & ((1 << shift) - 1))
                return -EINVAL;

Isn't that just:

	if (cfa & (sizeof(long) - 1))

?

Let me go add a patch to clean that up...
