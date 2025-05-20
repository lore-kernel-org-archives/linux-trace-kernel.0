Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6D024679C;
	Tue, 20 May 2025 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750506; cv=none; b=dvAfHWX+6wSo7ESM7B6VapBk+TTJ3jKZIajcC5TUq6hraR45ggrUr00wz3nYx07Lq54qKNaVm41DmoFZxqx/jwrP5+EQuD2jYXQtpUDhbdp8bUxruPfqIARiY+9vx8q5SGGDe7OYEHLMSHrN4zczhzNnRGmdUJkdRZ9KkcYJiUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750506; c=relaxed/simple;
	bh=LFQufN+AWf8VXZCCvIGwfEDPP4LEHOeX0XvuqmXIuHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdhLZ5zn6XC3h96cIcfvL75F0tlUCwQwSdk9mtvCaPJuWhVOUiIJrMU9OF1dTmhSgrYQnyA8xDOLQZhRVHEZWJns3YZDj7zdSUbjIsdLRWyE9oFTlee6wGElmYut8El6HwPw0DzNBSOK4dvkmSsrDXSks0cCXjoonhrCceoqqCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991D0C4CEEF;
	Tue, 20 May 2025 14:15:04 +0000 (UTC)
Date: Tue, 20 May 2025 15:15:01 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 17/22] arm64: mm: Add page fault trace points
Message-ID: <aCyOZVVioijWpEPY@arm.com>
References: <cover.1747046848.git.namcao@linutronix.de>
 <f5fccde2326a896e5c568ef06a4dbd9aa7465f6a.1747046848.git.namcao@linutronix.de>
 <aCtE-RvyN6XJQjTo@arm.com>
 <20250520122548.lkvaylSB@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520122548.lkvaylSB@linutronix.de>

On Tue, May 20, 2025 at 02:25:48PM +0200, Nam Cao wrote:
> On Mon, May 19, 2025 at 03:49:29PM +0100, Catalin Marinas wrote:
> > On Mon, May 12, 2025 at 12:51:00PM +0200, Nam Cao wrote:
> > > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > > index ec0a337891dd..55094030e377 100644
> > > --- a/arch/arm64/mm/fault.c
> > > +++ b/arch/arm64/mm/fault.c
> > > @@ -44,6 +44,9 @@
> > >  #include <asm/tlbflush.h>
> > >  #include <asm/traps.h>
> > >  
> > > +#define CREATE_TRACE_POINTS
> > > +#include <trace/events/exceptions.h>
> > > +
> > >  struct fault_info {
> > >  	int	(*fn)(unsigned long far, unsigned long esr,
> > >  		      struct pt_regs *regs);
> > > @@ -559,6 +562,11 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
> > >  	if (kprobe_page_fault(regs, esr))
> > >  		return 0;
> > >  
> > > +	if (user_mode(regs))
> > > +		trace_page_fault_user(addr, regs, esr);
> > > +	else
> > > +		trace_page_fault_kernel(addr, regs, esr);
> > 
> > What are the semantics for these tracepoints? When are they supposed to
> > be called? In the RV context context I guess you only care about the
> > benign, recoverable faults that would affect timing. These tracepoints
> > were generalised from the x86 code but I don't know enough about it to
> > tell when they would be invoked.
> > 
> > For arm64, we also have the do_translation_fault() path for example that
> > may or may not need to log such trace events.
> 
> These tracepoints are invoked for x86 page fault exceptions. Are arm64's
> translation faults considered equivalent to x86 page faults?

Probably. We route permission or access flag faults via do_page_fault()
directly while missing page table entries via do_translation_fault().
The latter end up in do_page_fault() only if the faulting address is in
the user address range.

My point was that we may not always invoke the trace callbacks if, for
example, the user tries to access the kernel space (and results in a
SIGSEGV). While that's fine for RV, I wanted to know what is expected of
these trace points in general. Do we need to log such SIGSEGV-generating
events? We do log them if there's a permission fault.

-- 
Catalin
