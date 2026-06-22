Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BFD344DAD;
	Mon, 22 Jun 2026 03:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782100700; cv=none; b=piocObYK1ruefea0q33TSKymKlokwwR1PlzJHz2kQC14NEcP+9urQ6pOs1tVS1VK/Wl3Mve9YdEk1IBSdO52wpUffEbUPoDJ1caPzWYuxG+ahTj8ganC6lNvAPGCHAAPhTAQZhIayeAOPe+vx782cKRg971PJ+Ykjk5phHZrQNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782100700; c=relaxed/simple;
	bh=kqbTJioe56eAEWkpe07u5NZxwS4AEsxVYuTTCGz79kA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=f4qvMgP6bpf2xdNaoOlT2Ybl5SxlUti5odFdegvmdKSfEgo/r9L6EylHfO5ZovFIHZ8pTh1LNaEuj2lFQKpLaUyajxHyAGQcEjRBYJTbtQZ+Y64sLPRlVID7DlzQCytmqkN1U92+b56/6eNo7uGQCwfG1535EUXa7NktNVuyfDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lyh2zPMX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lyh2zPMX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE9D1F000E9;
	Mon, 22 Jun 2026 03:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782100697;
	bh=x22Q8iJQQqMBkDLEZYqH0+ZY4hv9lO+kL+4BTFfGJmw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Lyh2zPMXPcohZyPV9D+9i6Z8UX86SN2mHWMhjMUNMpU3Sd5UtX9ABsMzjrIsnxjUy
	 RBotyM0BSQh89iyn4U8lhJ3jqhQjVBN0ohs6alMa62zSIIwioA0KdhTpxMRCa3Buwd
	 6HndXrDlRXHtUQ1LKJSs+9WUn+7kS6mnrazBmVmGMU8NEyfgkre1z1v/KUhxYUpyq6
	 07zo/KQwUpyM451bQZ0CJJG97FqAgBkxAShfZqWh8VjQHfDFgMPMXi6iM7tylrrVgT
	 7dGMDvdYQvQbUppJn7+O/2SY55gjEQwPa1HeSffr9TvoVuY1dnCSV/zVSMDo+MDMCI
	 GvfRDO4+egWdg==
Date: Mon, 22 Jun 2026 12:58:15 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: eprobe: read the complete FILTER_PTR_STRING
 pointer
Message-Id: <20260622125815.7416792c020bd3d81c01e51b@kernel.org>
In-Reply-To: <ajasLMUt_AMM3ztH@akranes.kaiser.cx>
References: <20260615145500.2662456-1-martin@kaiser.cx>
	<20260616110910.e6420488b6a798d49951cde9@kernel.org>
	<ajJbkeK0zXb8MtcS@akranes.kaiser.cx>
	<20260618105227.c58c85e9cb19bce673d9a79b@kernel.org>
	<ajasLMUt_AMM3ztH@akranes.kaiser.cx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Jun 2026 17:05:16 +0200
Martin Kaiser <martin@kaiser.cx> wrote:

> Thus wrote Masami Hiramatsu (mhiramat@kernel.org):
> 
> > Ah, OK. I understand the problem.
> 
> >  - ring buffer and its records should be self-contained.
> >  - In most cases, events use __data_loc/__rel_loc or fixed array to store
> >    strings.
> >  - only syscall events exposes the char *, which is not recommended but
> >    important to debug user space. (not for dereference)
> 
> > The example usage of FILTER_PTR_STRING is actually using FILTER_STATIC_STRING
> > now, so FILTER_PTR_STRING is left broken. (hmm, but there are many
> >  "const char *" are used especially under rcu events...)
> 
> > OK, can you update your patch description to use rcu events?
> 
> I've just sent a v2 with an rcu event as an example.

OK, let me check.

> 
> > BTW, I think those also should be decoded from enum value in the events,
> > or use __rel_loc. Since it is not self-contained. (it's a TODO item)
> 
> That makes sense. But it needs a bit more space in the ringbuffer for each
> event.

Yeah, but it just exposes the raw kernel address to users. That's not good.


> 
> > > > I think better solution is fixing sycall tracer.
> 
> > > I would say that syscall trace is doing the right thing. The ringbuffer entry
> > > is a struct syscall_trace_enter, the syscall arguments are unsigned longs.
> > > They are written in ftrace_syscall_enter, this looks correct to me.
> 
> > OK, I thought the filename points the ringbuffer, but it actually points
> > the user space. (saving a raw parameter values) So it is OK.
> 
> > For eprobe users, it should not access to the user space data directly
> > because it can cause page fault in the kernel without fixup. It may work
> > on x86, but it doesn't work on other architecture which has separated
> > address space for user space. To avoid such mistake, it saves actual
> > string in the ringbuffer as __filename_val.
> 
> > Hmm, this must be documented in eprobe example code...
> 
> Could we use is_kernel() from kallsyms.h to check the address?

No, it is hard to identify a given unsigned long value is an address
of kernel space or not.

> 
> Or should we forbid string and ustring fetch types in eprobes if the
> base field is a FILTER_PTR_STRING?

No, it depends on user to use string or ustring. The "ustring" fetch
type can handle it correctly.

The problem is that the event does not provide the information that
the string is in user space or not. But actually, for syscall events
all data pointed by syscall parameter should be in the user space.

So feel free to add a new FILTER type to syscall events and use that
to check it should use ustring type or not, if you want.

Thank you,

> 
> Best regards,
> Martin
> 
> > > A const char * syscall argument is using FILTER_PTR_STRING, the unsigned long
> > > argument from the ringbuffer is read as a char and then converted to a
> > > truncated pointer.
> 
> 
> > Thanks,
> 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
