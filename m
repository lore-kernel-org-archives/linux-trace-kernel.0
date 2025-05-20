Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985C633F3;
	Tue, 20 May 2025 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747744345; cv=none; b=aoipRTq3C5qCEFAA1dtYq3Z7Dlf3MjtCZ6yRZnqrAJwTAL3UUqmnf/DMQ/dZWrBiHGYEV6zlGDc+0tGnQ1tOJ6o8rX3W4bBzb010/AE5SM9EIRk0Rv8A1R5m8bvlDYOv+Z0pG3w+fLFAk8JL4MhsOHTfUea0MeuwzUVtSy9W7LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747744345; c=relaxed/simple;
	bh=6txSALMLb+dCskHPkdAxPCvoltw2CKwvqVATLo9J0uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTRYtRWQWGFleYqFotdpdy8NMW1uuZeN/6AaILy1OYkFHAl2ZelxRxwM3BMuBR2j+ZnEaYcFA97jY/CiQtxW5hyJoVscAfUtbd91RdWSbxTL6cO1SFKswqRTHO8eoWJn/aIwMz/wT2TBPhg+9mhzgddEtWQivF9F1iL8W7SS6TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMEa3po3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMEa3po3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B413C4CEF2;
	Tue, 20 May 2025 12:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747744345;
	bh=6txSALMLb+dCskHPkdAxPCvoltw2CKwvqVATLo9J0uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eMEa3po3VUmMBkINcJHkPTKGF7YsD3KtMT2IvPwlFtgKcVEPaERspam4hX7ZTGNLx
	 Rm30FBBZGi1yXyXrkzPHG9VTmFNm+ZgNjt4UYgZLgVdh0NAk+mIQRfDtfqmXKoUYV+
	 gg8pAiEbhArjrYH8VLsG/Mv/ChbLDi33R+tVn2DipunlW13zf1xsgWepFQfpWICTHE
	 HFZvBomv+AEnQAF4pJFE5zQoqTTgN4MoK4RqKdOsnYOsP4t3ulDeWMbSoC+mHLOM82
	 DWtw0P8BqcmNxzSkth2dJXnyamhyeHnMNQiJMjpYNToJDW9N9aMmwfsk7QHhzzSufc
	 AB/eIyXdubskw==
Date: Tue, 20 May 2025 13:32:19 +0100
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 17/22] arm64: mm: Add page fault trace points
Message-ID: <20250520123219.GA18565@willie-the-truck>
References: <cover.1745999587.git.namcao@linutronix.de>
 <554038c996662282df8a9d0482ef06f8d44fccc5.1745999587.git.namcao@linutronix.de>
 <20250516140449.GB13612@willie-the-truck>
 <aCtZfiU8bgkSAgLh@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCtZfiU8bgkSAgLh@J2N7QTR9R3>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, May 19, 2025 at 05:17:02PM +0100, Mark Rutland wrote:
> On Fri, May 16, 2025 at 03:04:50PM +0100, Will Deacon wrote:
> > On Wed, Apr 30, 2025 at 01:02:32PM +0200, Nam Cao wrote:
> > > Add page fault trace points, which are useful to implement RV monitor which
> > > watches page faults.
> > > 
> > > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > > ---
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > ---
> > >  arch/arm64/mm/fault.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > > index ef63651099a9..e3f096b0dffd 100644
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
> > Why is this after kprobe_page_fault()?
> 
> The kprobe_page_fault() gunk is doing something quite different, and is
> poorly named. That's trying to fixup the PC (and some other state) to
> hide kprobe details from the fault handling logic when an out-of-line
> copy of an instruction somehow triggers a fault.
> 
> Logically, that *should* happen before the tracepoints, and shouldn't be
> moved later. For other reasons it needs to be even earlier in the fault
> handling flow, and is currently far too late, but that only ends up
> mattering int he presence of other kernel bugs. For now I think it
> should stay where it is.

I thought these tracepoints were intended to be used by RV, in which
case I'd have thought we'd want as much coverage as possible to reason
about what the kernel is actually doing.

> More details below, for the curious and/or deranged.
> 
> The kprobe_page_fault() gunk is trying to fix up the case where an
> instruction has been kprobed, an out-of-line copy of that instruction is
> being stepped, and the out-of-line instruction has triggered a fault.
> When that happens, kprobe_page_fault() tries to reset the faulting PC
> and DAIF such that it looks like the fault was taken from the original
> PC of the probed instruction.
> 
> The real logic for that happens in kprobe_fault_handler(), which adjusts
> the values in pt_regs, but does not handle the live DAIF value. It also
> doesn't handle the PMR when pNMI is in use. Due to this, the fault
> handler can run with DAIF bits masked unexpectedly, and a subsequent
> exception return *could* go wrong.
> 
> Luckily all code with an extable entry has been blacklisted for kprobes
> since commit:
> 
>   888b3c8720e0a403 ("arm64: Treat all entry code as non-kprobe-able")
> 
> ... so we should only get here if there's another kernel bug that causes
> an unmarked dereference of a faulting address, in which case we're
> likely to BUG() anyway.
> 
> The real fix would be to hoist this out to the arm64 entry code (and
> handle similar for other EL1 exceptions), and get rid of all the
> __kprobes annotations inthe fault code.

This seems to be an argument for removing kprobe_page_fault() entirely,
which is fine, but while it exists it's not obvious to me how it's
supposed to interact with RV.

I suppose the pragmatic thing to do would be to align as closely as
possible with x86, but any documentation/guidance/tests to help us
maintain that would be really helpful. Otherwise, this feels like we're
going to have a repeat of the syscall entry mess where the interaction
with ptrace, audit, seccomp etc was perpetually broken in user-visible
ways.

Will
