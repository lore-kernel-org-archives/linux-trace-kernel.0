Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D996A22F01;
	Tue, 15 Apr 2025 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744720694; cv=none; b=XzeeVz50Jwhds0f6rbzaO1o54jbPTaqJ8Tkz6ZU/rhiJHIZIuM73Y+YfYsun43L4Ta0xD4NzZvm9Rr0ZOBXWOgoW4eQzJ3qwZF4EmdC3F1kVHPBwiPPdphfBHtIVgdkG6KpZUERKhsZ1gplaQRYOljoeiyahpR/U+YvwM0TLxqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744720694; c=relaxed/simple;
	bh=zL1jWmoE1Xg/EnZtmsy/sYnq64rgv0mlAeMkBTHwOAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWc/L7E0f2C5n4ZHVy9tpQxnB3scPOABi8k/KVwgJ3RbqQ1bZOk1wkdrMAZJvZ1gAB5N7p0kJAB2xtBQZj01Ls76rChNmQcPohVlsLlRPVuoeEXfSpZ0tuGbzb+nLhUGuh5tpREb4nZPd16p6lFbo3cPHS0uzEJJUQ73O5BdQSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ejf15B0G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uXHBILYw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ejf15B0G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uXHBILYw"
Date: Tue, 15 Apr 2025 14:38:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744720690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nzawNatPbq1ZNSb9ZVxi6008X2uDX4ctY3uXm4ZDLKc=;
	b=Ejf15B0G6V/V4b0G5v0K7G9W/9PynAnMz3ByOriTZzIq8uLtTwq/TztJPm7gIviwMkz3Kf
	n+SAP8ZLJmyRV4ouj/H8QqBot3o0aMi9V62ibzRBZeqYQNt9ouocjl5uL2ME39YppXevRm
	G+wBc3EWYtn29qYJ1fzP/Wmm8gtqH5SWS7kcaOUl2JGCN5TQilRLROj+NKi2XjHwtSvD+Y
	3NBL+oppuHwSju1FksExSQsk5xOTKagBDpX8Xfp5DA4wuUgeD99x+ITsWklHKRKdiY2P2K
	df+fVysMmQJa8BtbWzr86y5i0Yp1xh7BFjend7Z4zqMUVxuk8KhEBJXosw8rDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744720690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nzawNatPbq1ZNSb9ZVxi6008X2uDX4ctY3uXm4ZDLKc=;
	b=uXHBILYw21rrPrwmTaF++U0ZD1onpTceW7OBoUTuHRM0SLb3jzBEUCaGIaT9v6RAqz0WIp
	NxpopC2Q8LmvviAQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 19/22] rv: Add rtapp_pagefault monitor
Message-ID: <20250415123807.2MahJd60@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
 <f57547af5e8c836f5c548f624e61f3e0002ce0b4.1744355018.git.namcao@linutronix.de>
 <4d5dd1b919aada32ddf4dbce895f19e558343ee9.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d5dd1b919aada32ddf4dbce895f19e558343ee9.camel@redhat.com>

On Tue, Apr 15, 2025 at 02:31:43PM +0200, Gabriele Monaco wrote:
> On Fri, 2025-04-11 at 09:37 +0200, Nam Cao wrote:
> > +static int __init register_pagefault(void)
> > +{
> > +	rv_register_monitor(&rv_pagefault, &rv_rtapp);
> > +	return 0;
> 
> Any reason why you aren't returning the error value from the monitor
> registration?

Copy-paste from dot2k :P

> Other than that, the monitor seems neat and reasonably easy to
> generate.
> 
> May not be necessary in this series, but try to keep compatibility with
> the userspace RV tool as well, you need to have some special case in
> its tracing components because fields are not matching:
>  # rv mon sleep -t
>          rcuc/11-108      [011] event <CANT FIND FIELD final_state>   
> (null) x (null)                   -> (null)                   Y
>          rcuc/11-108      [011] event <CANT FIND FIELD final_state>   
> (null) x (null)                   -> (null)                   Y
>       ktimers/11-109      [011] event <CANT FIND FIELD final_state>   
> (null) x (null)                   -> (null)                   Y

I have this userspace RV tool in my "later" TODO list, if that's okay.

Honestly, I haven't looked at what it does yet. perf already does what I
need.

Best regards,
Nam
