Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33183246ED;
	Wed,  1 Apr 2026 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074448; cv=none; b=j4UF6CU3lbAmS1fF3JCPAwNM0L2v3e3AsyM2Y6JCjYS0+moCIj6Ki2FBRe/65ThMu3ET+CsbH0l4na23bq8Ut+njzR995jCx4hS0K50cghLw2N/1HZHAU/VbLfW1JGe6IHY9iZJp8S75wckCXmRv/yMx8RIVnyLhSD9a6t1nKJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074448; c=relaxed/simple;
	bh=nT7zV27BGvtA0dl6cLGU90r9otFBzX/43fgikqgq+f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OThArRJP7HiiR8elxfB8AIzZxdO+L4kgEYKVbCS/b4hhj901XRsrHH30aMq5l3VkgnhaULsrl3LIp3VTxn6JUHiQLO9cdPIHR20eSkDVkWKW2ejceAusSdDlmKLRya/MEleaWsWaYVWMwE2MnVvLNYXgzPe0TaeiPQSIVSKCb4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZhEXJxnf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZhEXJxnf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8XkBwRgetFLQArOMdEL+5A0BYIF+Nz4AlkIK7OD5i9A=; b=ZhEXJxnfvG6PYELgHW5j0hVnt3
	CdjUVwPyvzNNAaThZElajtKBomf1KezJH/ApxlYuzwiIiz+5h6RmtLHJIuiG0Th4GWY19Hc16WF0F
	82yV6e+aUI3m0iSuj4ReekOhFBWFzoky6f3jIxgjV5fCV5QarRXO9oU/s79fhQXBvaeLlJ5mA6BAp
	EQvZPxFCgmThtuIVtpY/YI9JRaq3kc7Cpd5ga9o70g3VVRJwo4W1sZO/+wMKr9eiggu/ytem2Qwt4
	rWY5ZdoHDCJWenUiAkZ1dBiA7gatxd7Y8ElMoWo5TwJFH3A/7CC/ixW3nRBDpVZJ2mxW7swgwOgFY
	9tbwg+4Q==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w81wt-0000000AyR7-3DE8;
	Wed, 01 Apr 2026 20:14:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 57C5430301D; Wed, 01 Apr 2026 22:13:58 +0200 (CEST)
Date: Wed, 1 Apr 2026 22:13:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brian Geffon <bgeffon@google.com>, John Stultz <jstultz@google.com>,
	Ian Rogers <irogers@google.com>,
	Suleiman Souhlal <suleiman@google.com>
Subject: Re: [PATCH v3 0/3] tracing: Read user data from futex system call
 trace event
Message-ID: <20260401201358.GA3254421@noisy.programming.kicks-ass.net>
References: <20260331181349.062575155@kernel.org>
 <87zf3m7a0o.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zf3m7a0o.ffs@tglx>

On Wed, Apr 01, 2026 at 09:31:19PM +0200, Thomas Gleixner wrote:

> Stick 100 lines of python into tools/tracing and be done with it. I'm
> happy to contribute to that.
> 
> Aside of that:
> 
>   Putting the decoder (futex_print_syscall) into the futex code itself
>   is admittedly a smart move to offload the work of keeping that up to
>   date to the people who are actually working on futexes.
> 
> TBH, I'm not interested to deal with that at all. If you want this
> ftrace magic pretty printing, then stick it into kernel/trace or if
> there is a real technical reason (hint there is none) into
> kernel/futex/trace.c and take ownership of it. But please do not burden
> others with your fancy toy of the day.

Him putting it near futex is my fault. I really hate having this
description nonsense separate -- *IF* is has to exist at all.

That said, I was thinking of Sasha's syscall api endeavour, I feel that
if we do any of this, it should all come from the same one place.
