Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B68A2C0F81;
	Fri, 30 Jan 2026 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769779492; cv=none; b=EbB5QpWuGDKi3eIpptRilcs0+aJwD2aA0gm8gqLyP6IbsPt78joHsrecTJPbnKAQlD0LtSePHq2tULI2bNGgB7hVSj3G3H9mPyRMdly7RABIvc9JjSahKrO9t5hYm5hcqjYtOaFArxuRR4gK7JO8zlpYP0Zb42A/nsRzVDKh+Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769779492; c=relaxed/simple;
	bh=/0GtwHky32P8HvYvPanrDvkBOq9l3/DB6LEAYqcFGlk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=I6DtwLuv2oYhMRfyXMFVbs5PDe5Mttqtfyqx7oKIkRMqPxJUZMsEYl+TOYVfkH0m80shquaisVZzxcZVOSoQVMuey0bnoXbawpWPs56HTDLWK82woPd2V4kggWzdQvUkb28IJCOjc/9ixN92IXRp7CTWyFzFpMNB8IkRZsWOI+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJcnfgGC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJcnfgGC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1220BC4CEF7;
	Fri, 30 Jan 2026 13:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769779491;
	bh=/0GtwHky32P8HvYvPanrDvkBOq9l3/DB6LEAYqcFGlk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uJcnfgGCUDaQoD4ouUp/F0R3mbsmg15TjnUeDvwug9MmOHC1o8SwhsCv+0JWcGSGa
	 VKBhyBmoMQtxIbl8A2GAjWit7ADNuHbKO8NLspvxIH7uuRl80XqkS8m/IcGOPkNPS4
	 AWvBd2lNg3h4ehDdsDY/JXneDi1WPiwHazSPWgRhLb3/7mEC9JqHc8sdBE06FLr3J9
	 /nn9Jg+gRc3qtRcvkZ0TkpuLwI3O0h9bEEpTn0fPxLWAHb027njWoDi84BG2rnp4U3
	 5a1edMrCKmsw+IzK0r/E7Z/BC4C+694kDQMU5vI52qwrxO1SdYhIpsfVwK/uTrOw27
	 C7wtn2slbLL4A==
Date: Fri, 30 Jan 2026 22:24:49 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] tracing/Documentation: Add a section about
 backup instance
Message-Id: <20260130222449.bc25b973597721b6a22e4f6d@kernel.org>
In-Reply-To: <20260129151900.44b6182c@gandalf.local.home>
References: <176955897718.2786091.11948759407196200082.stgit@mhiramat.tok.corp.google.com>
	<176955901173.2786091.7719483008240216705.stgit@mhiramat.tok.corp.google.com>
	<20260129151900.44b6182c@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 15:19:00 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 28 Jan 2026 09:10:11 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add a section about backup instance to the debugging.rst.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Documentation/trace/debugging.rst |   19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/Documentation/trace/debugging.rst b/Documentation/trace/debugging.rst
> > index 4d88c346fc38..73e2154bcf98 100644
> > --- a/Documentation/trace/debugging.rst
> > +++ b/Documentation/trace/debugging.rst
> > @@ -159,3 +159,22 @@ If setting it from the kernel command line, it is recommended to also
> >  disable tracing with the "traceoff" flag, and enable tracing after boot up.
> >  Otherwise the trace from the most recent boot will be mixed with the trace
> >  from the previous boot, and may make it confusing to read.
> > +
> > +Using a backup instance for keeping previous boot data
> > +------------------------------------------------------
> > +
> > +It is also possible to record trace data at system boot time by specifying
> > +events with the persistent ring buffer, but in this case the data before the
> > +reboot will be lost before it can be read. This problem can be solved by a
> > +backup instance. From the kernel command line::
> > +
> > +  reserve_mem=12M:4096:trace trace_instance=boot_map@trace,sched,irq trace_instance=backup=boot_map
> > +
> > +When the boot up, the previous data in the`boot_map` is copied to "backup"
> 
>   s/When the boot up/On boot up/                   copied to the "backup"

Ah, thanks,

> 
> > +instance, and the "sched:*" and "irq:*" events for current boot are traced on
> 
>                                                   for the current boot are traced in
> 
> 
> > +"boot_map". Thus user can read the previous boot data from the "backup" instance

   ^ the "boot_map".

> 
>                Thus the user
> 
> > +without stopping trace.
> 
>            stopping the trace.

OK.

> 
> > +
> > +Note that this "backup" instance is readonly, and will be removed automatically
> > +if you clear the trace data or read out all trace data from "trace_pipe" or
> > +"trace_pipe_raw" files.
> > \ No newline at end of file
> 
> Definite articles are a pain ;-)

Thanks!

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
