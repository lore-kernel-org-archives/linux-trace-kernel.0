Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44AC2F509E;
	Wed, 16 Jul 2025 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669671; cv=none; b=bUa2NDaZLg6Pw2ko0Sun0QGXZC5uFhHmK5C2U3M1pkKfBS2Dk5CR8PzT5bS4bX5S+rsgf6GIQFN53c4w/ZM0JEhGl9iNRwqw8ZUylIMxjYY4UP1ZN5JOA0LyFgGLXyUAZSZxD6JcYy2pKCTEINVeLyE/TqB+XvxRXJvuMb9ZHgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669671; c=relaxed/simple;
	bh=d6vf6YT0Cqo3aoayFnwgxe9EnRiYFPMOe4uh0hRHtl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TE2uXX/5QfhGIBTP3z9RJtc0X/G0OBEkvXg2GQFckZqAwYYpXt4wffm6o4CzzA2TPMNrWWd+/uLVgt7P6tTJ1IZpRYy3ZCGC1ce4k7bJNfeycHC5bVEzva7Jtx/V/7/rRXVU7axT0gkkak1AgXBm7t6XAGhx8gSCJlPJGAp2GHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CGvR57ax; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CGvR57ax"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UT8NqHgSNeioPkyLMeWHt1AfXpAfZ7XlwNxV5qFIAPk=; b=CGvR57axiNuhVKMDLoeKJy064f
	AiRcir4FpDSLNgl9Ww6nza8xMIQeTpVgXnJV9o5KabSQeXiIr/PAjqagTM8/2WCRhYOr7xULzBMmf
	CN3ESdc2/g2k0RtHJepg6vjSoGBudSN2oZT1Q8xQ7RFhpBXh2LuRfBUCY25yK58xxViXaYrSNmHUF
	o7uTjl/O7SoGEAkb57bi4kWmlZwbzR4kE2xecC00xOJaqKRR87C3YLKJP9edWfGdj9zU0Nm6uqJy8
	G04gJDUGYKKMbcCgn0f+AWTbyVhsUkGUKavqbMpFqRZvk2hhXDPLCcjcXzCUty9QJLc7rGxdSyJTW
	hh60rJVg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc1Ra-0000000GZ8m-0j8B;
	Wed, 16 Jul 2025 12:41:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B0BA2300186; Wed, 16 Jul 2025 14:41:05 +0200 (CEST)
Date: Wed, 16 Jul 2025 14:41:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 01/17] tools/rv: Do not skip idle in trace
Message-ID: <20250716124105.GX1613200@noisy.programming.kicks-ass.net>
References: <20250715071434.22508-1-gmonaco@redhat.com>
 <20250715071434.22508-2-gmonaco@redhat.com>
 <20250716115027.GV1613200@noisy.programming.kicks-ass.net>
 <21b23f125e20102440e36da08a039d88bdf58eb1.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21b23f125e20102440e36da08a039d88bdf58eb1.camel@redhat.com>

On Wed, Jul 16, 2025 at 02:18:28PM +0200, Gabriele Monaco wrote:
> 
> 
> On Wed, 2025-07-16 at 13:50 +0200, Peter Zijlstra wrote:
> > On Tue, Jul 15, 2025 at 09:14:18AM +0200, Gabriele Monaco wrote:
> > > Currently, the userspace RV tool skips trace events triggered by
> > > the RV
> > > tool itself, this can be changed by passing the parameter -s, which
> > > sets
> > > the variable config_my_pid to 0 (instead of the tool's PID).
> > > The current condition for per-task monitors (config_has_id) does
> > > not
> > > check that config_my_pid isn't 0 to skip. In case we pass -s, we
> > > show
> > > events triggered by RV but don't show those triggered by idle (PID
> > > 0).
> > > 
> > > Fix the condition to account this scenario.
> > 
> > The distinction between !my_pid and has_id is that you can in fact
> > trace
> > pid-0 if you want?
> > 
> 
> Yes pretty much, no flag is meant to skip events from pid-0.

> > > -	if (config_has_id && (config_my_pid == id))
> > > +	if (config_my_pid && config_has_id && (config_my_pid == id))

But should we then not write:

	if (config_has_id && (config_my_pid == id))

