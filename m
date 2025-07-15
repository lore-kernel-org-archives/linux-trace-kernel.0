Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D27BA42;
	Tue, 15 Jul 2025 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586297; cv=none; b=nfnlcQpEOZguorrJ9WzX3yrzyykoWXCVh3ZQGJiwjJ87zhQaU2d52ED48R3aSVVl4sioNdb7fLpb1Dijwlypm2u74loDP44ZoW96QlYg2St9w2iiVneJwzxZ2ZPt/YUCfdlXWrg93DTuslv0vcaje6DtFZeiEPbYZ/xsshqfODY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586297; c=relaxed/simple;
	bh=3qlg0SCNcg8nKs+ycOKHvY064/ex0vaLBe/HisISSaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmmeaLo9zi7davCIJorEhLXTUt8ttLzJrjtCwrJXZyKrsl2UMjBBUe+XZXnEqa3p0cj16y2b6/t/42wRmvInvWf+vA9q82q9WhOamIDKJldYR2rRLGSBYiuVVai4Arj6zPgReaDvdPENXPGSRzk8q3/KALxf+Smm62uvd2zhxPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SviX5acN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GGv12Rg2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SviX5acN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GGv12Rg2"
Date: Tue, 15 Jul 2025 15:31:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752586294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=joOFFAAY8AYV/4LY8627HFskz6QEGnW/9xaT8auIfuo=;
	b=SviX5acNSqCWkmpRxHMexOAoIu9URZfsVbTsQI3SRxptnXwXmArcprncFBz7Ig76QH3QSH
	gZKk7ALmkGj5GHAICMMBFtO/px50l5T2I/6NAx0hXqabMYYLfMiiBlDA75q+KakwkmNh1A
	85oy+RsfJcQNYFDXJdwUP22houo6rdzpK5KRnFvIE/yK9+4h1YeqOb8CMABziNzD0MFd3s
	rS/neYrkdwmbgwzSC1ngmw5Gp7H/XAYmUOCDXlj5kmVA8OGO7IdVh63UmRe+5M6Gct79fY
	7jyxoF88HfwtNqwrTtiKr01O5CmsifSokJ1JjWEms69+D/Yc9N0a4dJAeeEnUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752586294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=joOFFAAY8AYV/4LY8627HFskz6QEGnW/9xaT8auIfuo=;
	b=GGv12Rg2+mLFhFwugX+3vHNk4RRbpwu/P5RqOZBT75BAVDK4nV/yOJUpYeIIhbeUSkL39W
	1ndNqBMvAf7PazDg==
From: Nam Cao <namcao@linutronix.de>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/2] panic: Fix up description of vpanic()
Message-ID: <20250715133133.XyZEBK7y@linutronix.de>
References: <cover.1752232374.git.namcao@linutronix.de>
 <23a7e8add6546b155371b7e0fbb37bb1def13d6e.1752232374.git.namcao@linutronix.de>
 <20250715145601.2489a701c86ae48a75d1995f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715145601.2489a701c86ae48a75d1995f@kernel.org>

On Tue, Jul 15, 2025 at 02:56:01PM +0900, Masami Hiramatsu wrote:
> On Fri, 11 Jul 2025 13:20:43 +0200
> Nam Cao <namcao@linutronix.de> wrote:
> >  /**
> > - * panic - halt the system
> > + * vpanic - halt the system
> 
> Shouldn't we make a copy the doc for the panic() (keep the text as it is)
> and change the short explanation?
> 
> panic - halt the system
> @fmt: ...
> 
> vpanic - halt the system with va_list
> @fmt: ...
> @args: ...
> 
>  From the newbie's viewpoint, as far as we keep providing the same
> function, it is better to keep the same document to avoid confusion.

That would be nice for sure. But I think the counter arguments are
stronger:

  - Two copies need to be maintained

  - panic() is only a few lines, and it is obvious at first glance that it
    is simply a thin wrapper around vpanic()

So I think it is better to leave it as is.

Best regards,
Nam
