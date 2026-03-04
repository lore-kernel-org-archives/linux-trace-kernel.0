Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C435A39184B;
	Wed,  4 Mar 2026 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772615277; cv=none; b=b//V9e0z6tKRVsCd6ykQlPimzvLAHBJ436SpoaXrBiMib+pV/yygLV7iuH/NFG7+4/oig6G+nORxincEGi6AasdJzt+jFXxDDBnZYsi3U+AhDZn0G+dXPZ7dKCvhtXnt4/vlgWdFnD3o34BE1n13FDPlhvyeQkLpYXZ3jK3CPDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772615277; c=relaxed/simple;
	bh=0ndxhIbv4Nmekwmaxp7xs2nbFjmj2fwOjqgDnKz2kVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Auh0XBdxOQ+0VQwcZw5Nb1UVUN1Al5uPtXTJzIAwSDaJSMCUWqQ0vHPT4MWO1thVfWMWf5GhfEsyKS4dGFUHI27AoWGG1cRgz/J6W40sq2q1/ZwgFuhBARgl1h9UfRJ0Z2RbVNSO1ufRI5ucNgtPZURAzIhNnpHO6gzdPbrKckY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HY4ll8nn; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HY4ll8nn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=528kpb4hJlDj60saOz+eXCumS52TDhSc2tNXOZkBgkE=; b=HY4ll8nnFVGqUScD/eN5pfMxTE
	hOcVqpbYH0nqV8kVYJe9j/pZOTyAKdAcoEiT5TWSo8FmmCC4ryKnpICterZ9AW6+AbMMRVDSlmRNF
	DINWXMAEhzeGHDUAfNvWBjbprA5oXvxu6TnMs720P5+L1OITQ2JIB8jqJH6bAwH3VhpB7V/iTlleZ
	vF7Ix1fB2whrFtrZhZZsZw5ZxD88OqeOBCw5JE+7Zxoi0YC0tQ2EgN/4Ie5umaYTikFJ0eWvfdqXV
	gLqPTwgjnrqTedK9/QZdxf9qEsyMmeUmPid73EFZj/CHYo/+FX2e7R6xUdVHJ8f932Jmv+njgdp5Y
	+ih/MJ0A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxiCs-00000004DCT-0LIR;
	Wed, 04 Mar 2026 09:07:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7A855300B40; Wed, 04 Mar 2026 10:07:48 +0100 (CET)
Date: Wed, 4 Mar 2026 10:07:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Brian Geffon <bgeffon@google.com>, John Stultz <jstultz@google.com>,
	Ian Rogers <irogers@google.com>,
	Suleiman Souhlal <suleiman@google.com>
Subject: Re: [PATCH 1/2] tracing: Have futex syscall trace event show
 specific user data
Message-ID: <20260304090748.GO606826@noisy.programming.kicks-ass.net>
References: <20260303214735.002154462@kernel.org>
 <20260303214942.428502100@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303214942.428502100@kernel.org>

On Tue, Mar 03, 2026 at 04:47:36PM -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Add specific reporting of the futex system call. This allows for debugging
> the futex code a bit easier. Instead of just showing the values passed
> into the futex system call, read the value of the user space memory
> pointed to by the addr parameter.
> 
> Also make the op parameter more readable by parsing the values to show
> what the command is:
> 
>  futex_requeue_p-3251    [002] .....  2101.068479: sys_futex(uaddr: 0x55e79a4da834 (0x80000cb1), FUTEX_LOCK_PI|FUTEX_PRIVATE_FLAG, val: 0)
>  futex_requeue_p-3248    [001] .....  2101.068970: sys_futex(uaddr: 0x7f859072f990 (0xcb2), FUTEX_WAIT_BITSET|FUTEX_CLOCK_REALTIME, val: 3250)
>  futex_requeue_p-3252    [005] .....  2101.069108: sys_futex(uaddr: 0x55e79a4da838 (0), FUTEX_WAIT_REQUEUE_PI|FUTEX_PRIVATE_FLAG, val: 0, timespec: 0x7ffe61076aa0, uaddr2: 0x55e79a4da834, uaddr2: 94453214586932, val3: 0)
>  futex_requeue_p-3252    [005] .....  2101.069410: sys_futex(uaddr: 0x55e79a4da834 (0x80000cb1), FUTEX_LOCK_PI|FUTEX_PRIVATE_FLAG, val: 0)
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_syscalls.c | 266 +++++++++++++++++++++++++++++++++-
>  1 file changed, 263 insertions(+), 3 deletions(-)

Egads, I really dislike how all sorts of syscall crud is 'duplicated' in
this file, rather than near or in the actual syscall definition.

