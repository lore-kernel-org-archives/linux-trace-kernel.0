Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED99A32;
	Sun,  4 May 2025 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746376351; cv=none; b=Z/uXmM4RU2LJ5NowskDgtYeXF7Xtigp79Nw0eC0F7bwz50IQexpQSylIjlSMQBcZFJxZXw2vuqKWVp75Hk06DiQ+vup1iX4QZi4FN07MjkxVzqT2SlJYpvj1wHQi3KftVl9iVcAqI4+YqS7g9UjE0GrG3ntIxOhmTyb+qhfVmeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746376351; c=relaxed/simple;
	bh=hmp8bmebK/XUogdmeUKVsx4nHOIXyITtmgo2diK2Le4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XF+87NwQKPJ145pAmLuNsYy1HfUv9Jd7CwKpnEtkUIQgewwaYmqJmIGJdtscHDfqug3v7ZpMozMPk2XFRZp1kzstlDX5qhEMAKRKJJ/8CZBn1Ug6WL5KYDs9Lbc5YEzjDLR7cdJWNgFvwUOu/SzXdVJz/sLwD7loMQLpzuK4Ttg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504D1C4CEE7;
	Sun,  4 May 2025 16:32:29 +0000 (UTC)
Date: Sun, 4 May 2025 12:32:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v7 00/17] unwind_user: perf: x86: Deferred unwinding
 infrastructure
Message-ID: <20250504123228.0e8a92ae@batman.local.home>
In-Reply-To: <aBc2ZBlQTpybK3Z-@gmail.com>
References: <20250502164746.178864972@goodmis.org>
	<aBc2ZBlQTpybK3Z-@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 4 May 2025 11:41:56 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> >       unwind_user: Add user space unwinding API
> >       unwind_user: Add frame pointer support
> >       unwind_user/x86: Enable frame pointer unwinding on x86
> >       perf/x86: Rename and move get_segment_base() and make it global
> >       unwind_user: Add compat mode frame pointer support
> >       unwind_user/x86: Enable compat mode frame pointer unwinding on x86
> >       unwind_user/deferred: Add unwind cache  
> 
> What is the cost of 'caching' here? Will we double-buffer the tracing 
> data before it reaches its single primary tooling user, with no use of 
> any actual 'caching', which will be scenario in like 99.9% of the 
> everyday usecases when this facility is used?

I'm sorry, I may not understand the question here.

The cache doesn't add any extra buffer. The previous patch (Add unwind
deferred trace) allocates "entries" the first time a trace is done to
save the user stacktrace into the buffer. It will not free the entries
(until exit of the task) to save from having to allocate the entries
again.

If for some reason an interrupt happens while it is recording the trace
and the interrupt requests another trace, without the cache, it will do
the work of walking the user stack trace again.

The "cache" code, simply keeps information around to know that the
current trace is still valid, and that it doesn't need to do the work
of walking the user stack to produce the stack again.

> 
> >       unwind_user/deferred: Add deferred unwinding interface
> >       unwind_user/deferred: Make unwind deferral requests NMI-safe
> >       perf: Remove get_perf_callchain() init_nr argument
> >       perf: Have get_perf_callchain() return NULL if crosstask and user are set
> >       perf: Simplify get_perf_callchain() user logic
> >       perf: Skip user unwind if the task is a kernel thread.  
> 
> Please don't leave periods in titles.

OK, will fix.

Thanks for looking at this Ingo!

-- Steve
