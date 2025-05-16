Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF21186E2D;
	Fri, 16 May 2025 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747408189; cv=none; b=ZsBLaRXmccAkY1Kz1Mb6NsvZOIovrvt7OUy4Abpxsdm/2ajTsfYmRhXAu6kIdK3NXKopw4nMSyPQ4ou2mRJC/mPpg/Cz3YTuSzKttqQ2k6ZcCl1dOAvqWO7l46h8snzwG8Aqlp2KIFwB5/gmVpRrd0ltcswi1mlhKdRe3QXctj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747408189; c=relaxed/simple;
	bh=AGNxXQkRFR7nwQ36UCJWoGogHgB8n2JhXEW3VD97w2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnzKVBo/VJhnN9AeopXUljf1SjNZA6hfXvyVEIww32qy/ANKnfwFK7BjlmrN3GwFp8Qk3FHNfGhCcv9oX3+LVb1smMcnt0hF5Yem2uRQOYnQn2pkW0sJtkMYReHgi/2cA6cB7M8QDApFWMkyCoB7vJ2FxzIYI1BAbWlzrk7OLkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DpATQzQp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wR/KQUOJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DpATQzQp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wR/KQUOJ"
Date: Fri, 16 May 2025 17:09:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747408186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/HywNmkLx1a2fIwQ1MKGECZwlag+2mOKKM/v1tKzG9U=;
	b=DpATQzQpiMsmPc2dhSdfVki2qv6V1T1FPApCFSccA9IexCrgo2HB6JnP6pUYc3iw5MyxLZ
	xKzvlkMvWYlaH45FAVBUTVvTU5haDKGLfNd08lgD7hrcGUzND18JozDr6Y2WjzFOaPoMKc
	VOovosrPDxZAMpEy/HQkzkoR/pitXOdNXw/dIlChjfxH6jWf+hS1b/FhIMaQdp6SyAtA2r
	UAlU1AGVoybWkKhjEEFINDuk7bnnuwKebThPxam1EjJkX0r5jfWQ3X3FOjRoHSjVueroZ8
	QnGxdWjnpNnTEKgSmOr9k5GVS0zYLZEcdI/XysSksx/SrmEI1LFY3Yu1xaHTbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747408186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/HywNmkLx1a2fIwQ1MKGECZwlag+2mOKKM/v1tKzG9U=;
	b=wR/KQUOJAaOhA0xA2yD2/13hVP4puE4PEPSgv/ajVZtt+MDrPHQjqUr8yfTUyxJ89ar4PI
	XIK0P0YYX/bvWDCQ==
From: Nam Cao <namcao@linutronix.de>
To: Will Deacon <will@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 17/22] arm64: mm: Add page fault trace points
Message-ID: <20250516150928.4Y7is6pg@linutronix.de>
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

This is me being incompetent, sorry about that. It is more logical to put
them at the beginning.

Best regards,
Nam
