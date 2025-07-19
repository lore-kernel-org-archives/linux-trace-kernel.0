Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751DC23CE;
	Sat, 19 Jul 2025 00:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752885198; cv=none; b=oArtf+JaD2JA7Dfqn6uHtu1STSh2RxWCI0AZtreXufQpl16BG4epMe+V+5Rt77mEmcP0Ux3PH3p+0dA5/e85wYMgnt5PqHNjSzRacyrellJwLdnig+jJzCX0P6Zz7txtbGaT9xWkx4GM1fOlmrIWXalP67g51XVA6pSXdSpt0h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752885198; c=relaxed/simple;
	bh=IKdWOuH1Cz2/le0dawobJNZYJuvUACKwnfdlhD9hMJk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=J4ex0t1NNJQB1eLGVIDzebBdvmiyn3dkqg6ErJijWFENMA55lUJtDp6Zzohv7CwbsgRJPQ76qPe+JoUjHJvFiZjMX0cejksoFYfptorGQ7luP7pJRhzXHo7sxCMSwnJSq5OpN+259YrTCshsBLO+zAWvLtur6xykgyUlD4Dsn5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niuhIcbP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niuhIcbP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03688C4CEEB;
	Sat, 19 Jul 2025 00:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752885198;
	bh=IKdWOuH1Cz2/le0dawobJNZYJuvUACKwnfdlhD9hMJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=niuhIcbPQc73G8/rbUlX9L+9eJLujz23MdY1XD/zZuKOX1BlflcHFDz6sLNRY9w/f
	 KnsT7VtCDARC8UmoizkvebsHot2mP8JZ62r1dM+HvGbL75LYuwCTrto7MPvSBO3YIU
	 zXw9t0CtTX7LjsxJsfUGtUb5lN+09RTqK+jCaIrGMjhMunu//wTr5vJu0zv9EFIrQ2
	 YdYUtbmjoTv+aNo0UU4mD1ar3XJEWauifolpl0HlCxnxMM1Q5rjhbsafp0JBi94rDj
	 00J/KqjtI1+eU1S6Raigmwgun1cQBkZWEwBub+YZtFVuhuNAV0LVRZ3KgNVy5zyX16
	 /x4R7kWd+W27Q==
Date: Sat, 19 Jul 2025 09:33:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] tracing: probe: Allocate traceprobe_parse_context
 from heap
Message-Id: <20250719093314.053bae15fe65df0484c312a5@kernel.org>
In-Reply-To: <20250718125820.0d0ae198@batman.local.home>
References: <175283843771.343578.8524137568048302760.stgit@devnote2>
	<175283844827.343578.10408845752163723065.stgit@devnote2>
	<20250718125820.0d0ae198@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Jul 2025 12:58:20 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 18 Jul 2025 20:34:08 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> > index 854e5668f5ee..7bc4c84464e4 100644
> > --- a/kernel/trace/trace_probe.h
> > +++ b/kernel/trace/trace_probe.h
> > @@ -10,6 +10,7 @@
> >   * Author:     Srikar Dronamraju
> >   */
> >  
> > +#include <linux/cleanup.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/slab.h>
> >  #include <linux/smp.h>
> 
> Nit, but let's keep the "upside-down x-mas tree" format:
> 
> #include <linux/seq_file.h>
> #include <linux/cleanup.h>
> #include <linux/slab.h>
> #include <linux/smp.h>

Isn't it for variable rules?
I saw some examples of sorting headers by A-Z.

> 
> 
> > @@ -438,6 +439,14 @@ extern void traceprobe_free_probe_arg(struct probe_arg *arg);
> >   * this MUST be called for clean up the context and return a resource.
> >   */
> >  void traceprobe_finish_parse(struct traceprobe_parse_context *ctx);
> > +static inline void traceprobe_free_parse_ctx(struct traceprobe_parse_context *ctx)
> > +{
> > +	traceprobe_finish_parse(ctx);
> > +	kfree(ctx);
> > +}
> > +
> > +DEFINE_FREE(traceprobe_parse_context, struct traceprobe_parse_context *,
> > +		if (!IS_ERR_OR_NULL(_T)) traceprobe_free_parse_ctx(_T))
> 
> ctx will either be allocated or NULL, I think the above could be:
> 
> 		if (_T) traceprobe_free_parse_ctx(_T))

OK.

> 
> 
> >  
> >  extern int traceprobe_split_symbol_offset(char *symbol, long *offset);
> >  int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
> > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > index f95a2c3d5b1b..1fd479718d03 100644
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -537,6 +537,7 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
> >   */
> >  static int __trace_uprobe_create(int argc, const char **argv)
> >  {
> > +	struct traceprobe_parse_context *ctx __free(traceprobe_parse_context) = NULL;
> >  	struct trace_uprobe *tu;
> >  	const char *event = NULL, *group = UPROBE_EVENT_SYSTEM;
> >  	char *arg, *filename, *rctr, *rctr_end, *tmp;
> > @@ -693,15 +694,17 @@ static int __trace_uprobe_create(int argc, const char **argv)
> >  	tu->path = path;
> >  	tu->filename = filename;
> >  
> > +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> > +	if (!ctx) {
> > +		ret = -ENOMEM;
> > +		goto error;
> > +	}
> > +	ctx->flags = (is_return ? TPARG_FL_RETURN : 0) | TPARG_FL_USER;
> > +
> >  	/* parse arguments */
> >  	for (i = 0; i < argc; i++) {
> > -		struct traceprobe_parse_context ctx = {
> > -			.flags = (is_return ? TPARG_FL_RETURN : 0) | TPARG_FL_USER,
> > -		};
> > -
> >  		trace_probe_log_set_index(i + 2);
> > -		ret = traceprobe_parse_probe_arg(&tu->tp, i, argv[i], &ctx);
> > -		traceprobe_finish_parse(&ctx);
> > +		ret = traceprobe_parse_probe_arg(&tu->tp, i, argv[i], ctx);
> 
> Doesn't this change the semantics a bit?

Yes, and we don't need to allocate ctx each time because probe target
point is always same (not different for each field). In this case,
we don't need to allocate/free each time.

> 
> Before this change, traceprobe_finish_parse(&ctx) is called for every
> iteration of the loop. Now we only do it when it exits the function.

Yes, but that is not a good way to use the ctx. As same as kprobe and
fprobe events, it is designed to be the same through parsing one probe,
not each field.

For the uprobe case, this is just passing ctx->flags, others are mostly
unused or temporarily used in field parsing. So allocating from stack
frame, it is OK. But allocating from heap, it involves slab allocation
and free each time. I think it is just inefficient. 

Hmm, but eprobe seems doing the same mistake. Let me split that part
to fix to keep using the same ctx through parsing one probe.


Thank you,

> 
> -- Steve
> 
> 
> >  		if (ret)
> >  			goto error;
> >  	}
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
