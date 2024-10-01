Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349D0A5F;
	Tue,  1 Oct 2024 01:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727747879; cv=none; b=qC9B4j1Pqm6v9l9MuuYWiV/4V2TPjkV5n4GLrBBxBGMhEViwBd2RbdILbPCZ82ZOaYP+4ibHRvfXJ2Gsu3FST0KfOiGVQJ4GE76MOJdsQ9H7PYPJFsA6j+MOtR29unTHeHNT70tyVUEveXHs33tJ9LmhOcz12Esn3dHzRtoDRJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727747879; c=relaxed/simple;
	bh=IYEMmh/FsI2Dol2j7J7yefHUkiDeEMb7ZjHXw8AaVy4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Sv4AAln0Pu+Coryiu/I6CHUYtNjEWPk6an1PTGosiV7iTt5ShmaZmoEnp439feJajG3svTMcfzy7DM9GPh6GbFasP0sEthdZKQWn+aOOKOdb6tzFa+v1lkP13xAlh5H+rJ2yvJf8goVud1zF5j5PdnUvQl33bOtlYZ5G1ltzO5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDWPDii8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDWPDii8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88933C4CEC7;
	Tue,  1 Oct 2024 01:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727747879;
	bh=IYEMmh/FsI2Dol2j7J7yefHUkiDeEMb7ZjHXw8AaVy4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pDWPDii8fCQnzNfylwXI5t/KB4gMatH/u/1Lus+CoQQGVv8EnqgLWSm7hlN9x5eNX
	 dL0LtoGdsxTfo6HpvjBJph8kHlmsCMQfh8KaTTGcX/ToPFtQCwtg8BSbwVBzLzhN33
	 KFmXaGmz7S968N4dvxEfEbVFW/eoDDmt0/eS5doa+/izqXBm3xvdp9Fl4QjFyGCulU
	 UyanrmFW6xjylrGilbVZYaR76R0MRsj0pDvQvCk7+4fZzE7DXTxSwfHNFRluAGDeNk
	 bljeN3UYNmTbvUY0eOIWD3npibDIVpDPq6UdijjUO+8R/m8RJ5S6Ds7IGtKnyCvFQ+
	 dNRgf7gyLhiZA==
Date: Tue, 1 Oct 2024 10:57:53 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v14 03/19] function_graph: Pass ftrace_regs to entryfunc
Message-Id: <20241001105753.723314ca371e9f484c88bcac@kernel.org>
In-Reply-To: <20240930144659.5aaf7be4@gandalf.local.home>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
	<172615372005.133222.15797801841635819220.stgit@devnote2>
	<20240915044614.5721947e@rorschach.local.home>
	<20240917082624.GC27290@willie-the-truck>
	<20240930144659.5aaf7be4@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 14:46:59 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 17 Sep 2024 09:26:25 +0100
> Will Deacon <will@kernel.org> wrote:
> 
> > On Sun, Sep 15, 2024 at 04:46:14AM -0400, Steven Rostedt wrote:
> > > Can I get an Acked-by from the AARCH64 maintainers for this patch?  
> > 
> > Sorry, I wasn't CC'd on the thread, so I missed this.
> 
> Here's the lore link that starts it all:
> 
>   https://lore.kernel.org/all/172615368656.133222.2336770908714920670.stgit@devnote2/
> 
> There's also a v15:
> 
>    https://lore.kernel.org/linux-trace-kernel/172639136989.366111.11359590127009702129.stgit@devnote2/
> 
> > 
> > > On Fri, 13 Sep 2024 00:08:40 +0900
> > > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > >   
> > > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > 
> > > > Pass ftrace_regs to the fgraph_ops::entryfunc(). If ftrace_regs is not
> > > > available, it passes a NULL instead. User callback function can access
> > > > some registers (including return address) via this ftrace_regs.  
> > 
> > Under which circumstances is 'ftrace_regs' NULL?
> 
> When the arch does not define: HAVE_DYNAMIC_FTRACE_WITH_ARGS or
> HAVE_DYNAMIC_FTRACE_WITH_REGS
> 
> If HAVE_DYNAMIC_FTRACE_WITH_REGS is defined but not the WITH_ARGS, and the
> ops used to register the function callback does not set FTRACE_OPS_FL_SAVE_REGS.
> 
> Otherwise it should be set.

I will add this condition in the description in next version.

Thank you,


> 
> > 
> > The arm64 implementation of ftrace_graph_func() is:
> > 
> > > > diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> > > > index a650f5e11fc5..bc647b725e6a 100644
> > > > --- a/arch/arm64/kernel/ftrace.c
> > > > +++ b/arch/arm64/kernel/ftrace.c
> > > > @@ -481,7 +481,25 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
> > > >  void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> > > >  		       struct ftrace_ops *op, struct ftrace_regs *fregs)
> > > >  {
> > > > -	prepare_ftrace_return(ip, &fregs->lr, fregs->fp);
> > > > +	unsigned long return_hooker = (unsigned long)&return_to_handler;
> > > > +	unsigned long frame_pointer = fregs->fp;  
> > 
> > Which dereferences the unchecked pointer here ^^.
> 
> Just above the visible portion of the patch, we have:
> 
> #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>                        struct ftrace_ops *op, struct ftrace_regs *fregs)
> {
> 
> Which means fregs will be available. The "WITH_ARGS" config tells us that
> the arch will supply the function with valid fregs to the ftrace callback
> (which this is).
> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
