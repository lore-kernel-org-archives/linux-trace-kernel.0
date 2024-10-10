Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5421C8FBA;
	Thu, 10 Oct 2024 14:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569180; cv=none; b=PkuqnW8hUDJHc9NobpCFPN2P3z7v8syP511gyrvgXkmoDMGehTl645oGsvsA1+Mp5o2vqwQFpcuuHY+CFxlLerPVL2E2romLQRcocU0H7oWYflyhurAm2v8YiVneyIivbfmhABBuWqd6CkpFShYRJcQiw0TimR+vhtGD3ooDSA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569180; c=relaxed/simple;
	bh=JutsYus4gJc7pvGb6/yexVCO//qodS3hmI4MIw7beGY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=D5JtluQl1GcYGbO+nEAA2fB8yH8DB5+jXu2vDdoxgECojrquTKbL2CJq91LukEACMumW3ItNLPnButWpz2iOdN9ZUh7xWMqtFhx3zm/Fdo6LyMChVLClTuBcxi/78S8NT8KpcBtlrLS3CvRfLhSetYZwR1aByu0w2Ax+U+TTABc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEJwP06b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEJwP06b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85F4C4CEC5;
	Thu, 10 Oct 2024 14:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728569177;
	bh=JutsYus4gJc7pvGb6/yexVCO//qodS3hmI4MIw7beGY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pEJwP06ba+Sf56kqjzkH6tDMcZ6NNTrf/vGq5oeWM978Gec16yGQcglIdgXMRk5e2
	 riImnfHItHW4ubKvg9TSNc1/2ew83Y96as/t5+lraVj5sDhJPPb5OfC/Nya5VhlWl1
	 PxVnWKcQne3NWQeFLjO0V2NEWOKp18DgAa6QMb9SzDvH5j5oCG7V2HUI2Y2moYsWGG
	 0ew2wZ3fx5Ix93q7noQI3L/ULhXJOrddrYW/F9uvKpQMqJvbCujFuZm5JkFf5s487a
	 bjeqGbBEH72SDXGn+18T0Q4PB8zxolXmiQ/qUbV4LrQjB8EsK8uNFHApPhFw8yZe0n
	 W4oLjRwze7/LQ==
Date: Thu, 10 Oct 2024 23:06:13 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/fgraph: Simplify return address printing in
 function graph tracer
Message-Id: <20241010230613.9eb8d8e156789037bf52593b@kernel.org>
In-Reply-To: <CAErzpmtyA9hh611jGS=FHT9K4YyfsRv5=9mg6YLD2m5XQS8dyw@mail.gmail.com>
References: <172851694646.226680.6609563595100451829.stgit@devnote2>
	<CAErzpmtyA9hh611jGS=FHT9K4YyfsRv5=9mg6YLD2m5XQS8dyw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 10 Oct 2024 10:40:02 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> On Thu, Oct 10, 2024 at 7:35 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > Simplify return address printing in the function graph tracer by removing
> > fgraph_extras. Since this feature is only used by the function graph
> > tracer and the feature flags can directly accessible from the function
> > graph tracer, fgraph_extras can be removed from the fgraph callback.
> >
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  include/linux/ftrace.h               |   16 ++++--------
> >  kernel/trace/fgraph.c                |   45 ++++++++++++++++++++++------------
> >  kernel/trace/ftrace.c                |    3 +-
> >  kernel/trace/trace.h                 |    3 +-
> >  kernel/trace/trace_functions_graph.c |   14 +++++------
> >  kernel/trace/trace_irqsoff.c         |    3 +-
> >  kernel/trace/trace_sched_wakeup.c    |    3 +-
> >  kernel/trace/trace_selftest.c        |    8 ++----
> >  8 files changed, 48 insertions(+), 47 deletions(-)
> >
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 2ac3b3b53cd0..997e1f0335b6 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -1068,29 +1068,20 @@ struct ftrace_graph_ret {
> >         unsigned long long rettime;
> >  } __packed;
> >
> > -struct fgraph_extras;
> >  struct fgraph_ops;
> >
> >  /* Type of the callback handlers for tracing function graph*/
> >  typedef void (*trace_func_graph_ret_t)(struct ftrace_graph_ret *,
> >                                        struct fgraph_ops *); /* return */
> >  typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *,
> > -                                     struct fgraph_ops *,
> > -                                     struct fgraph_extras *); /* entry */
> > +                                     struct fgraph_ops *); /* entry */
> >
> >  extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
> > -                                  struct fgraph_ops *gops,
> > -                                  struct fgraph_extras *extras);
> > +                                  struct fgraph_ops *gops);
> >  bool ftrace_pids_enabled(struct ftrace_ops *ops);
> >
> >  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> >
> > -/* Used to convey some extra datas when creating a graph entry */
> > -struct fgraph_extras {
> > -       u32 flags;
> > -       unsigned long retaddr;
> > -};
> > -
> >  struct fgraph_ops {
> >         trace_func_graph_ent_t          entryfunc;
> >         trace_func_graph_ret_t          retfunc;
> > @@ -1131,12 +1122,15 @@ function_graph_enter(unsigned long ret, unsigned long func,
> >
> >  struct ftrace_ret_stack *
> >  ftrace_graph_get_ret_stack(struct task_struct *task, int skip);
> > +unsigned long ftrace_graph_top_ret_addr(struct task_struct *task);
> >
> >  unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
> >                                     unsigned long ret, unsigned long *retp);
> >  unsigned long *fgraph_get_task_var(struct fgraph_ops *gops);
> >
> >  u32 graph_tracer_flags_get(u32 flags);
> > +#define graph_tracer_flags_is_set(flags)       \
> > +       (graph_tracer_flags_get(flags) == (flags))
> 
> Do we need to retain the function graph_tracer_flags_get? it will be
> only invoked in the
> file trace_functions_graph.c, so we may access the tracer_flags
> variable directly.

Good catch!
Let me send v2.

Thanks!


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
