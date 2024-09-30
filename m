Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F085466B;
	Mon, 30 Sep 2024 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727721974; cv=none; b=s3Xfj8D6xNRUsJdoZ3yzDWvkKGvdzNrrDBS8fPXRYnHvE4VTH/IebghyPcexFqQFSb++lmM1oCKKVIQGa9s7HoNRDrGAnAHDzv5i2OjDqQT1nFbxwRGeUyc4ODhFOOiIZjbl9NiACjxCBeZXcLvcqCw/AkYkDGrnq67jTxUV1nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727721974; c=relaxed/simple;
	bh=oqnR++eHSeXxHBLJ2jhhdXfRPnc4oY+RWNgdjtKWP6g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FccdSkwbXgk63RvrN3EW2caRKyTp1pprT+A0DWNW8FCg2+tIvt7AJhk6nAsSyQd7fk0fWPQ4EcgYrvD/BKXGEHvf2CY6XQ4M7vrfQMoJP8uVCJSo1wA8ClLmOUHHt6WvnFpbGHg7f7WWidjPcZGQ9fK9nUqIoPMfIkjP26Tqzp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9D1C4CEC7;
	Mon, 30 Sep 2024 18:46:12 +0000 (UTC)
Date: Mon, 30 Sep 2024 14:46:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v14 03/19] function_graph: Pass ftrace_regs to entryfunc
Message-ID: <20240930144659.5aaf7be4@gandalf.local.home>
In-Reply-To: <20240917082624.GC27290@willie-the-truck>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
	<172615372005.133222.15797801841635819220.stgit@devnote2>
	<20240915044614.5721947e@rorschach.local.home>
	<20240917082624.GC27290@willie-the-truck>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Sep 2024 09:26:25 +0100
Will Deacon <will@kernel.org> wrote:

> On Sun, Sep 15, 2024 at 04:46:14AM -0400, Steven Rostedt wrote:
> > Can I get an Acked-by from the AARCH64 maintainers for this patch?  
> 
> Sorry, I wasn't CC'd on the thread, so I missed this.

Here's the lore link that starts it all:

  https://lore.kernel.org/all/172615368656.133222.2336770908714920670.stgit@devnote2/

There's also a v15:

   https://lore.kernel.org/linux-trace-kernel/172639136989.366111.11359590127009702129.stgit@devnote2/

> 
> > On Fri, 13 Sep 2024 00:08:40 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> >   
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > Pass ftrace_regs to the fgraph_ops::entryfunc(). If ftrace_regs is not
> > > available, it passes a NULL instead. User callback function can access
> > > some registers (including return address) via this ftrace_regs.  
> 
> Under which circumstances is 'ftrace_regs' NULL?

When the arch does not define: HAVE_DYNAMIC_FTRACE_WITH_ARGS or
HAVE_DYNAMIC_FTRACE_WITH_REGS

If HAVE_DYNAMIC_FTRACE_WITH_REGS is defined but not the WITH_ARGS, and the
ops used to register the function callback does not set FTRACE_OPS_FL_SAVE_REGS.

Otherwise it should be set.

> 
> The arm64 implementation of ftrace_graph_func() is:
> 
> > > diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> > > index a650f5e11fc5..bc647b725e6a 100644
> > > --- a/arch/arm64/kernel/ftrace.c
> > > +++ b/arch/arm64/kernel/ftrace.c
> > > @@ -481,7 +481,25 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
> > >  void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> > >  		       struct ftrace_ops *op, struct ftrace_regs *fregs)
> > >  {
> > > -	prepare_ftrace_return(ip, &fregs->lr, fregs->fp);
> > > +	unsigned long return_hooker = (unsigned long)&return_to_handler;
> > > +	unsigned long frame_pointer = fregs->fp;  
> 
> Which dereferences the unchecked pointer here ^^.

Just above the visible portion of the patch, we have:

#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
                       struct ftrace_ops *op, struct ftrace_regs *fregs)
{

Which means fregs will be available. The "WITH_ARGS" config tells us that
the arch will supply the function with valid fregs to the ftrace callback
(which this is).

-- Steve

