Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60A9288C21;
	Mon, 19 May 2025 16:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671431; cv=none; b=JeogPziBlrAZqfK4FaFO/rC9Qt6N/YCbBn7LJRiBYPw/UBVFWyWcAmyPb4EsFPkAy7n+Me3uaHh7SWXTUCCtJ+LuhmfwZQ2kg2+aDJKMDVVvK9NQZYlDjiv0X1i8MMzCMywkND0bhaG7d3a8/htNv3yppQM1eLBmMgeI5FptJ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671431; c=relaxed/simple;
	bh=UNbvV6wmNjcbacGds8xFAjj2VpWeSkjDPtLp3906aSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdVss8Zc0M7eaRVVtAoZT5S2EBjICTtLM9EStnCGgcGfvX4KpGR9mKPnDbxLTLHrmOala85/x4ShF3CmVCBA4NGxjSgW5v0NS2xBc6vn4RPT3BlfTJW4qqnmaAWtWJ99i1gX8qBPe2uJHJkF5HwuaQB23zU0zGhiNioqzC0flO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09C361655;
	Mon, 19 May 2025 09:16:56 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8161B3F5A1;
	Mon, 19 May 2025 09:17:07 -0700 (PDT)
Date: Mon, 19 May 2025 17:17:02 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 17/22] arm64: mm: Add page fault trace points
Message-ID: <aCtZfiU8bgkSAgLh@J2N7QTR9R3>
References: <cover.1745999587.git.namcao@linutronix.de>
 <554038c996662282df8a9d0482ef06f8d44fccc5.1745999587.git.namcao@linutronix.de>
 <20250516140449.GB13612@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516140449.GB13612@willie-the-truck>

On Fri, May 16, 2025 at 03:04:50PM +0100, Will Deacon wrote:
> On Wed, Apr 30, 2025 at 01:02:32PM +0200, Nam Cao wrote:
> > Add page fault trace points, which are useful to implement RV monitor which
> > watches page faults.
> > 
> > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > ---
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: linux-arm-kernel@lists.infradead.org
> > ---
> >  arch/arm64/mm/fault.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index ef63651099a9..e3f096b0dffd 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -44,6 +44,9 @@
> >  #include <asm/tlbflush.h>
> >  #include <asm/traps.h>
> >  
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/exceptions.h>
> > +
> >  struct fault_info {
> >  	int	(*fn)(unsigned long far, unsigned long esr,
> >  		      struct pt_regs *regs);
> > @@ -559,6 +562,11 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
> >  	if (kprobe_page_fault(regs, esr))
> >  		return 0;
> >  
> > +	if (user_mode(regs))
> > +		trace_page_fault_user(addr, regs, esr);
> > +	else
> > +		trace_page_fault_kernel(addr, regs, esr);
> 
> Why is this after kprobe_page_fault()?

The kprobe_page_fault() gunk is doing something quite different, and is
poorly named. That's trying to fixup the PC (and some other state) to
hide kprobe details from the fault handling logic when an out-of-line
copy of an instruction somehow triggers a fault.

Logically, that *should* happen before the tracepoints, and shouldn't be
moved later. For other reasons it needs to be even earlier in the fault
handling flow, and is currently far too late, but that only ends up
mattering int he presence of other kernel bugs. For now I think it
should stay where it is.

More details below, for the curious and/or deranged.

The kprobe_page_fault() gunk is trying to fix up the case where an
instruction has been kprobed, an out-of-line copy of that instruction is
being stepped, and the out-of-line instruction has triggered a fault.
When that happens, kprobe_page_fault() tries to reset the faulting PC
and DAIF such that it looks like the fault was taken from the original
PC of the probed instruction.

The real logic for that happens in kprobe_fault_handler(), which adjusts
the values in pt_regs, but does not handle the live DAIF value. It also
doesn't handle the PMR when pNMI is in use. Due to this, the fault
handler can run with DAIF bits masked unexpectedly, and a subsequent
exception return *could* go wrong.

Luckily all code with an extable entry has been blacklisted for kprobes
since commit:

  888b3c8720e0a403 ("arm64: Treat all entry code as non-kprobe-able")

... so we should only get here if there's another kernel bug that causes
an unmarked dereference of a faulting address, in which case we're
likely to BUG() anyway.

The real fix would be to hoist this out to the arm64 entry code (and
handle similar for other EL1 exceptions), and get rid of all the
__kprobes annotations inthe fault code.

Mark.
