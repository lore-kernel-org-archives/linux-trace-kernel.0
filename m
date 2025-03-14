Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCE73C6BA;
	Fri, 14 Mar 2025 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955141; cv=none; b=PPHAkSR2eVpFs1t7qvhyXEo+NilAYkj9suhrZMZ2aMD9YwqxHj7ae7BlMeO4kwiGG1m2/fNciXvO+0ebNXnyaugr5xOfJ/qwOV+cZ8hfS2kbDy2KieOM8vOWl0VjiTPJNRmqNuFf4hBk/x38BlXjbDtXt2NYgytG0+rLzX+tbfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955141; c=relaxed/simple;
	bh=C3ajX4JAUrPquYgWiiRnIxeWnSa1+l96cAGrlH5vXnE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gCwV5gblvJ0lEjDKedm5fkUJjKrtgZdD4KkI1gn3HWPWJl88+mtdZtCzwA7jIXbvc6HCejPezODhNaUTnl1S1pb9WgJU6vN7tI1AVWnAcbYb2hFGJYAjFGXeYbij1wbIMx7S+9TualLCVNodp1cxNH3ifg+5CAyvfG7xE+RG33g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215A4C4CEE3;
	Fri, 14 Mar 2025 12:25:37 +0000 (UTC)
Date: Fri, 14 Mar 2025 08:25:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Mladek <pmladek@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-mm@kvack.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Michael Petlan
 <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, Suren
 Baghdasaryan <surenb@google.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Tamir Duberstein <tamird@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RESEND][PATCH] tracing: gfp: Remove duplication of recording
 GFP flags
Message-ID: <20250314082534.57ef07c4@batman.local.home>
In-Reply-To: <20250313125313.4f3d98f4@batman.local.home>
References: <20250225135611.1942b65c@gandalf.local.home>
	<Z9L5HsVzQ0bVZtjp@pathway.suse.cz>
	<20250313125313.4f3d98f4@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 12:53:13 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > --- a/include/trace/events/mmflags.h
> > +++ b/include/trace/events/mmflags.h
> > @@ -101,7 +101,7 @@ TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
> >  	gfpflag_string(GFP_DMA32),		\
> >  	gfpflag_string(__GFP_RECLAIM),		\
> >  	TRACE_GFP_FLAGS				\
> > -	{ 0, "none" }
> > +	{ 0, NULL }
> >  
> >  #define show_gfp_flags(flags)						\
> >  	(flags) ? __print_flags(flags, "|", __def_gfpflag_names		\
> > 
> > It seems to be safe because the callers end up the cycle when .name == NULL.
> > 
> > I think that it actually allows to remove similar trailing {} but I am not sure
> > if we want it.  
> 
> Hmm, I could get rid of that last one with this patch. What do you think?

OK, I think this is too hacky, and it only affects tracing if there's a
flag not defined (which never happened so I didn't see this issue).

I'll just go with your approach.

You want to send a formal patch?

-- Steve
