Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3397158D8F;
	Tue, 17 Sep 2024 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726567734; cv=none; b=FxRG6gLLT2I+tM5sa//OaAYuhAXLqIXtjNa4juzLBoL0nInEv21vaqa6b44ytr4QXlSooRGp1onkP2QpfqAJHGPzvCxkPKo/sz40y+CiamAhLEXKJcUgx9IMj3bfgxw9k5cT83adhx3ti9CSirW7hQmynsAiyognW7Z7rlLjj1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726567734; c=relaxed/simple;
	bh=+p+xzX06Jj/qgHQUUsyqMfiIDzxXJxTBwKU5YNzm6aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKti/vhFAlWfso/HaNsftVyBPi6GEKZfuoSnrPm2mFoOhz+eJU5x4UPxgAdfMZ9YDqo/Pt31caIMJq2yImDV/becAOFfmiK8Zo0M9D5+X3KCWalKx8ykyEk+lnR/y/Eua3TDLk/cigYxl5zc+XW+Iuzdic7nzvAJQSC0mF12O3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7T5lCk5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7T5lCk5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5243BC4CEC5;
	Tue, 17 Sep 2024 10:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726567734;
	bh=+p+xzX06Jj/qgHQUUsyqMfiIDzxXJxTBwKU5YNzm6aE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V7T5lCk5nRzzKAhyIkC6pLUkkNBm9pTCQq2/12J0Pc/Uze6ei05mfSz4Fr+XtaV2G
	 jHprXcyCpfQcU/8wHY5VRw09tfgnj3qGtNr1k29ejZsi6kh/p0UUvZ9zYG5aY3+JHP
	 /ZtrwCM08+NCT7aGwBjfL4/1x/pVHFSD+grUyT+SnU126u1yRm2KgE2DBzp65iC96t
	 Xf5+zbcXwPLKX/h7xy9x3H65XWbKBOvVWqq9/Hc1bFGHyKi8wQ3ABHpJ2+SylHHGC9
	 0SzNm81H7ohWIuRyigQBcl/X6sKK2cCUskdg3iu3svC//jbOv787dtvKRmC1hE7TYL
	 O9xBlVa51CegA==
Date: Tue, 17 Sep 2024 11:08:48 +0100
From: Will Deacon <will@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Florent Revest <revest@chromium.org>,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v14 05/19] function_graph: Pass ftrace_regs to retfunc
Message-ID: <20240917100848.GB27384@willie-the-truck>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
 <172615374207.133222.13117574733580053025.stgit@devnote2>
 <20240915044920.29a86d25@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915044920.29a86d25@rorschach.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Sep 15, 2024 at 04:49:20AM -0400, Steven Rostedt wrote:
> On Fri, 13 Sep 2024 00:09:02 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Pass ftrace_regs to the fgraph_ops::retfunc(). If ftrace_regs is not
> > available, it passes a NULL instead. User callback function can access
> > some registers (including return address) via this ftrace_regs.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v8:
> >   - Pass ftrace_regs to retfunc, instead of adding retregfunc.
> >  Changes in v6:
> >   - update to use ftrace_regs_get_return_value() because of reordering
> >     patches.
> >  Changes in v3:
> >   - Update for new multiple fgraph.
> >   - Save the return address to instruction pointer in ftrace_regs.
> > ---
> >  include/linux/ftrace.h               |    3 ++-
> >  kernel/trace/fgraph.c                |   16 +++++++++++-----
> >  kernel/trace/ftrace.c                |    3 ++-
> >  kernel/trace/trace.h                 |    3 ++-
> >  kernel/trace/trace_functions_graph.c |    7 ++++---
> >  kernel/trace/trace_irqsoff.c         |    3 ++-
> >  kernel/trace/trace_sched_wakeup.c    |    3 ++-
> >  kernel/trace/trace_selftest.c        |    3 ++-
> >  8 files changed, 27 insertions(+), 14 deletions(-)
> > 
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 13987cd63553..e7c41d9988e1 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -1069,7 +1069,8 @@ struct fgraph_ops;
> >  
> >  /* Type of the callback handlers for tracing function graph*/
> >  typedef void (*trace_func_graph_ret_t)(struct ftrace_graph_ret *,
> > -				       struct fgraph_ops *); /* return */
> > +				       struct fgraph_ops *,
> > +				       struct ftrace_regs *); /* return */
> >  typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *,
> >  				      struct fgraph_ops *,
> >  				      struct ftrace_regs *); /* entry */
> > diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> > index 30bebe43607d..6a3e2db16aa4 100644
> > --- a/kernel/trace/fgraph.c
> > +++ b/kernel/trace/fgraph.c
> > @@ -297,7 +297,8 @@ static int entry_run(struct ftrace_graph_ent *trace, struct fgraph_ops *ops,
> >  }
> >  
> >  /* ftrace_graph_return set to this to tell some archs to run function graph */
> > -static void return_run(struct ftrace_graph_ret *trace, struct fgraph_ops *ops)
> > +static void return_run(struct ftrace_graph_ret *trace, struct fgraph_ops *ops,
> > +		       struct ftrace_regs *fregs)
> >  {
> >  }
> >  
> > @@ -491,7 +492,8 @@ int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
> >  }
> >  
> >  static void ftrace_graph_ret_stub(struct ftrace_graph_ret *trace,
> > -				  struct fgraph_ops *gops)
> > +				  struct fgraph_ops *gops,
> > +				  struct ftrace_regs *fregs)
> >  {
> >  }
> >  
> > @@ -787,6 +789,9 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
> >  	}
> >  
> >  	trace.rettime = trace_clock_local();
> > +	if (fregs)
> > +		ftrace_regs_set_instruction_pointer(fregs, ret);

Where does the instruction pointer get used after this? The arm64
'return_to_handler' function doesn't look at it when we return.

Will
