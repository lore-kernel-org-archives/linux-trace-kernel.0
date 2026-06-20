Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DC21F0E25;
	Sat, 20 Jun 2026 15:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781967923; cv=none; b=VvfSZHYWSEqBnJ11tngwB4jjLVid3PH34Hssr1ej/f6bVJkJESVKPnpiEvTjPEfZqV1oVk8vcek/tr7uxGBOidrKN2w5UIny11K/x2a0V8h7rXXL42L5oGhcF+b5vTOmmpn6OrDcncRquuj5/GoOB8Mc3mwq1BQWR0YjC4zVVi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781967923; c=relaxed/simple;
	bh=i/lFBjfhRjswt5VdmV2knGCyJh2j2qjUqOqlSlh5Ghw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCmOPWiv404GJKX5c4Z0pKJ8aBdLVweRF2uUH83onYcTROCUaWgPzghy5KzFT83g6s0cX5/BoNDVMLoE1GGwEcGG2h1WQNxiq7dl8UEBaacGf7An7N2yDdIR/bFZtz5W+XqaJ+TLu7siuRqUBk2/jeN7j8EabqiD7eSfuq6t6IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from martin by akranes.kaiser.cx with local (Exim 4.98.2)
	(envelope-from <martin@akranes.kaiser.cx>)
	id 1waxG0-00000001cxJ-3duY;
	Sat, 20 Jun 2026 17:05:16 +0200
Date: Sat, 20 Jun 2026 17:05:16 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: eprobe: read the complete FILTER_PTR_STRING
 pointer
Message-ID: <ajasLMUt_AMM3ztH@akranes.kaiser.cx>
References: <20260615145500.2662456-1-martin@kaiser.cx>
 <20260616110910.e6420488b6a798d49951cde9@kernel.org>
 <ajJbkeK0zXb8MtcS@akranes.kaiser.cx>
 <20260618105227.c58c85e9cb19bce673d9a79b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618105227.c58c85e9cb19bce673d9a79b@kernel.org>
Sender: "Martin Kaiser,,," <martin@akranes.kaiser.cx>

Thus wrote Masami Hiramatsu (mhiramat@kernel.org):

> Ah, OK. I understand the problem.

>  - ring buffer and its records should be self-contained.
>  - In most cases, events use __data_loc/__rel_loc or fixed array to store
>    strings.
>  - only syscall events exposes the char *, which is not recommended but
>    important to debug user space. (not for dereference)

> The example usage of FILTER_PTR_STRING is actually using FILTER_STATIC_STRING
> now, so FILTER_PTR_STRING is left broken. (hmm, but there are many
>  "const char *" are used especially under rcu events...)

> OK, can you update your patch description to use rcu events?

I've just sent a v2 with an rcu event as an example.

> BTW, I think those also should be decoded from enum value in the events,
> or use __rel_loc. Since it is not self-contained. (it's a TODO item)

That makes sense. But it needs a bit more space in the ringbuffer for each
event.

> > > I think better solution is fixing sycall tracer.

> > I would say that syscall trace is doing the right thing. The ringbuffer entry
> > is a struct syscall_trace_enter, the syscall arguments are unsigned longs.
> > They are written in ftrace_syscall_enter, this looks correct to me.

> OK, I thought the filename points the ringbuffer, but it actually points
> the user space. (saving a raw parameter values) So it is OK.

> For eprobe users, it should not access to the user space data directly
> because it can cause page fault in the kernel without fixup. It may work
> on x86, but it doesn't work on other architecture which has separated
> address space for user space. To avoid such mistake, it saves actual
> string in the ringbuffer as __filename_val.

> Hmm, this must be documented in eprobe example code...

Could we use is_kernel() from kallsyms.h to check the address?

Or should we forbid string and ustring fetch types in eprobes if the
base field is a FILTER_PTR_STRING?

Best regards,
Martin

> > A const char * syscall argument is using FILTER_PTR_STRING, the unsigned long
> > argument from the ringbuffer is read as a char and then converted to a
> > truncated pointer.


> Thanks,

> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
