Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B751D554;
	Tue, 20 May 2025 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747743957; cv=none; b=fJasJqMcLwrtMTAe35eQdAPoRd5J7ucym9fcBZqqdSMS+LIdug8Swv226OsVMsNQMM167mqSrjheRQTIRfjQvb2XvqxWKNqp5EZzQJ3EW9jIjczxqAUNq+H9+jWMmPH7E39mzXbgJt1R+ktODRfsh+vwtN/HTE1vhIHCudJFFoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747743957; c=relaxed/simple;
	bh=Y6CaI2q2RPnBtH0aFQYa1UfbCr7K8MmVtvr+f/2NXeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYI9eTcPfzSumGwlYAqDsVIYi9BVuyCAvSkkKhiuDUgWPgkYB3tifYktUDnfbjchT05P/o8l6bzYzcvLmN3/n+mUH0QEJnKQXOK88NUGfMXJf1op08loagoUV7juyWxNeb0LAmTltZxLsVS7agGU7Et8b5v3yaOZNBvi3qSrIDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=na/fp7+E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=owAcx9aw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="na/fp7+E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="owAcx9aw"
Date: Tue, 20 May 2025 14:25:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747743953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IUjRkJXP7J4Xa8+xLBblWyMlboCDcuea5nf6Fk3YYEU=;
	b=na/fp7+EL7fi0Gx8gkAbP3CnXTBJrb0NdTin6LhExr7vPTMKqZxed7SL7e1qPbxtMqlNaF
	e1uRhBCoBELWYJZtbRSZs475oOEcOzgqUCFs3eqDUrmXEdwps4g5Dub8Z6cITy9iPOdCRz
	LTQHrBYUeiZlcuDn2vQD4YTbGI5PQ5EdU34seaUKybcHbADSR3B95ZJJQpbtkYOkUs7tOE
	KFBY/J1VwFNhjZZzh+LGhsBr0KOLKnu/zdS+Aka++2V1GkBNyWWidpw0aI91LPrPBfaxLY
	sjZyn8laciBBcR1qTYIP5HAer9yb351PJEkY7Czh0jU3C4G7qvEdWYq7/GX3gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747743953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IUjRkJXP7J4Xa8+xLBblWyMlboCDcuea5nf6Fk3YYEU=;
	b=owAcx9awdFFz1d81x33l6VUVWMl7LqJIFmZbfh3RQVJqXYSdoqZiWQeQwVWcPaAe/8UzeM
	ofs0KFl6bR62dRDA==
From: Nam Cao <namcao@linutronix.de>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 17/22] arm64: mm: Add page fault trace points
Message-ID: <20250520122548.lkvaylSB@linutronix.de>
References: <cover.1747046848.git.namcao@linutronix.de>
 <f5fccde2326a896e5c568ef06a4dbd9aa7465f6a.1747046848.git.namcao@linutronix.de>
 <aCtE-RvyN6XJQjTo@arm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCtE-RvyN6XJQjTo@arm.com>

On Mon, May 19, 2025 at 03:49:29PM +0100, Catalin Marinas wrote:
> On Mon, May 12, 2025 at 12:51:00PM +0200, Nam Cao wrote:
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index ec0a337891dd..55094030e377 100644
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
> What are the semantics for these tracepoints? When are they supposed to
> be called? In the RV context context I guess you only care about the
> benign, recoverable faults that would affect timing. These tracepoints
> were generalised from the x86 code but I don't know enough about it to
> tell when they would be invoked.
> 
> For arm64, we also have the do_translation_fault() path for example that
> may or may not need to log such trace events.

These tracepoints are invoked for x86 page fault exceptions. Are arm64's
translation faults considered equivalent to x86 page faults?

Best regards,
Nam
