Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DA22D8DDF;
	Wed,  1 Apr 2026 03:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775013344; cv=none; b=AWb/d1uW/lcV9X1pG7V/uD3VNOTeZyoHg5vAemOat0aeJxMoOyMFjjIf8OB7Xdf9sLpRrhBg4HvK0L9LH7KTrDm44AdJviwz1FKCW85qx96OoZLCT6qS7uCHHxuPbb8L/e/P5YV9laNRagnyPgyxituyBwbJSPd8LFVomRXUOiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775013344; c=relaxed/simple;
	bh=iXtdxDrs/JwBE/9OE5aHMpX1Tzmj1vsGg/Eyk9YIkHc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=obJs/Lkdj4UnWoPOLkDvOow81kJbEMby+wiQenF62w1Rmt+nzIeL4ZQBIRnvGh9aulNipZhnG3Q2SgHHyu7c7HDCXXKQJ3sOlmTn2Io0O6t1RcPjbJ+Wdjixhb2q9B/G9SyKb91lSXaJkBBBr4OuAifltDZzzXDCpBOrLx16/l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCMSNFFY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCMSNFFY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD74C19423;
	Wed,  1 Apr 2026 03:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775013344;
	bh=iXtdxDrs/JwBE/9OE5aHMpX1Tzmj1vsGg/Eyk9YIkHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TCMSNFFY7EVxEoBQ3IZs045lZ0QVs+sgQB6OJkX1pVH15HiM2FGnmO4FnsUbJbKi4
	 kA+1ma8hz3xd63fjmVgjoO2VDhx5mnXih7BF1TBiwI/TsRS4aChlNTF4/jUqI9zvJ4
	 fJpnEbm2lHGHKjOuVRUZXEIY00nCG0EqqvBj6eam0gYqQ0fm2cqEgGYEWrrrn05g4M
	 MYHsultZb9yeKZT1FF/K0gl5GeD/vCdvqCWOM2NKLkrW0GZaNzNA54/evlvsBe21eD
	 rcwqU/3bsctrP0GtrtnHgm3n1Qlkbs4LR18PARUa7fW8KukLGVqz8olgqBjiYAcBxh
	 IBUANc/Et8xLA==
Date: Wed, 1 Apr 2026 12:15:41 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/3] tracing/Documentation: Add a section about
 backup instance
Message-Id: <20260401121541.e2c8c549ae172ccf2d5e3035@kernel.org>
In-Reply-To: <20260331172105.609d59aa@gandalf.local.home>
References: <177497473558.569199.6527680985537865638.stgit@mhiramat.tok.corp.google.com>
	<177497476117.569199.18085846838539980210.stgit@mhiramat.tok.corp.google.com>
	<20260331172105.609d59aa@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 17:21:05 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed,  1 Apr 2026 01:32:41 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add a section about backup instance to the debugging.rst.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >   Changes in v6:
> >    - Fix typos.
> > ---
> >  Documentation/trace/debugging.rst |   19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/Documentation/trace/debugging.rst b/Documentation/trace/debugging.rst
> > index 4d88c346fc38..15857951b506 100644
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
> 
> The above didn't actually work well without my patch to enable events on
> the persistent ring buffer with the backup. But keep it, as it will work
> with my patch ;-)

Ah, thanks!
Let me rebase on it.


> 
> -- Steve
> 
> 
> > +
> > +On boot up, the previous data in the "boot_map" is copied to the "backup"
> > +instance, and the "sched:*" and "irq:*" events for the current boot are traced
> > +in the "boot_map". Thus the user can read the previous boot data from the "backup"
> > +instance without stopping the trace.
> > +
> > +Note that this "backup" instance is readonly, and will be removed automatically
> > +if you clear the trace data or read out all trace data from the "trace_pipe"
> > +or the "trace_pipe_raw" files.
> > \ No newline at end of file
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
