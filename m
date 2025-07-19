Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0608F7082F;
	Sat, 19 Jul 2025 00:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752886660; cv=none; b=CRzcllYN7MMlkxgNxyWREGjkimiW7qriSEZj0nYUpx/5XVBu/jKDS3ItycMNk/ZNcskUsKbQw+f0crmKoHQ7rRik6j1Fb+i1AC9IAPWBbs1Ah6I1lBrIIrteVT5rihoL17Wcj+D+d1SAfRrxF7+nv12sAFmAiNomh9FBpaDg9e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752886660; c=relaxed/simple;
	bh=RG6q47bjYE6sPNF6G0Grvd2OLPc0Ef/vf4FePJwVfsE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=J2EybE0efAjYR4LNk8I0eMuDAyaP+AHQ2yfR2MKm0wnYL1aQF+xmLXTyUx5yYAPOiyAlBh7Kbit4ezXK4PLNSToXYXNBDQx5fadmxnyDEBVUzLxDlSOSswfWJlIV8YbHdlQDwVXq1baZRp5AmLcX2Fanoq+y4SDPVu7cZOc2kSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXb2L0Cg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXb2L0Cg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5040FC4CEEB;
	Sat, 19 Jul 2025 00:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752886657;
	bh=RG6q47bjYE6sPNF6G0Grvd2OLPc0Ef/vf4FePJwVfsE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PXb2L0CgEeyeo2s/dPMM4c+lQDAOVyjWqs+xIJeWy9cqhSE24pzmXbUx9ZFflL5ek
	 +Ug6Gw54fuDClR4cNKQP+95OMOw1wT3bAOB2mAt6G+6dbNh0s8pkcaLUKQDVbgUOqF
	 eY+ihhqXyrbY12qrvM136ZROmg8IhKFt5B43MlSjzqr7Y9lSY0qqXx7EtIlAkCoFUd
	 SYalKevwSWTdcwh5dlxY0G9h4Uf8JyMipr5C7I1ZCKfWJoOcpTGhJa2QhmLlF9KqZg
	 gBWZ/OCGM4cb0SVvIGm6NFiGno/kEOsVtHBNw+gf9dbsEjj94Ed+6K1MxuKYOfUI/1
	 kk91/XMIi8cLw==
Date: Sat, 19 Jul 2025 09:57:33 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] tracing: fprobe-event: Allocate string buffers from
 heap
Message-Id: <20250719095733.0fd0cc95a41a2f0bde589c2a@kernel.org>
In-Reply-To: <20250718133907.6e56a3fa@batman.local.home>
References: <175283843771.343578.8524137568048302760.stgit@devnote2>
	<175283845881.343578.10010946807218897188.stgit@devnote2>
	<20250718133907.6e56a3fa@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Jul 2025 13:39:07 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 18 Jul 2025 20:34:19 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Allocate temporary string buffers for fprobe-event from heap
> > instead of stack. This fixes the stack frame exceed limit error.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202506240416.nZIhDXoO-lkp@intel.com/
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_fprobe.c |   39 ++++++++++++++++++++++++++-------------
> >  1 file changed, 26 insertions(+), 13 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> > index 264cf7fc9a1d..fd1036e27309 100644
> > --- a/kernel/trace/trace_fprobe.c
> > +++ b/kernel/trace/trace_fprobe.c
> > @@ -1234,18 +1234,18 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
> >  	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
> >  	 */
> >  	struct trace_fprobe *tf __free(free_trace_fprobe) = NULL;
> > -	struct module *mod __free(module_put) = NULL;
> > -	int i, new_argc = 0, ret = 0;
> > -	bool is_return = false;
> > -	char *symbol __free(kfree) = NULL;
> >  	const char *event = NULL, *group = FPROBE_EVENT_SYSTEM;
> > +	struct module *mod __free(module_put) = NULL;
> >  	const char **new_argv __free(kfree) = NULL;
> > -	char buf[MAX_EVENT_NAME_LEN];
> > -	char gbuf[MAX_EVENT_NAME_LEN];
> > -	char sbuf[KSYM_NAME_LEN];
> > -	char abuf[MAX_BTF_ARGS_LEN];
> > +	char *symbol __free(kfree) = NULL;
> > +	char *ebuf __free(kfree) = NULL;
> > +	char *gbuf __free(kfree) = NULL;
> > +	char *sbuf __free(kfree) = NULL;
> > +	char *abuf __free(kfree) = NULL;
> >  	char *dbuf __free(kfree) = NULL;
> > +	int i, new_argc = 0, ret = 0;
> >  	bool is_tracepoint = false;
> > +	bool is_return = false;
> >  
> >  	if ((argv[0][0] != 'f' && argv[0][0] != 't') || argc < 2)
> >  		return -ECANCELED;
> > @@ -1273,6 +1273,9 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
> >  
> >  	trace_probe_log_set_index(0);
> >  	if (event) {
> > +		gbuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
> > +		if (!gbuf)
> > +			return -ENOMEM;
> >  		ret = traceprobe_parse_event_name(&event, &group, gbuf,
> >  						  event - argv[0]);
> >  		if (ret)
> > @@ -1280,15 +1283,18 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
> >  	}
> >  
> >  	if (!event) {
> > +		ebuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
> 
> ebuf and gbuf are used with the same length. Why not just keep them
> using the same buffer? It worked before this patch, it should work
> after too.

Actually, ebug and gbuf can be used the same time. The first "event" could
have only "group name" by commit 95c104c378dc ("tracing: Auto generate event
name when creating a group of events"). In this case, after calling
traceprobe_parse_event_name(), "event" can be NULL.
(see kernel/trace/trace_probe.c:283)

In this case, gbuf is storing splitted "group name" and
ebuf is storing auto generated "event name".

Oops, and eprobe does not handle this case. Let me fix that first.

Thank you,

> 
> 	buf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
> 	if (!buf)
> 		return -ENOMEM;
> 
> 	if (event) {
> 		[..]
> 	}
> 
> 	if (!event) {
> 		[..]
> 	}
> 
> And not require two different variables that will add two exit codes
> when one would do.
> 
> -- Steve
> 
> 
> > +		if (!ebuf)
> > +			return -ENOMEM;
> >  		/* Make a new event name */
> >  		if (is_tracepoint)
> > -			snprintf(buf, MAX_EVENT_NAME_LEN, "%s%s",
> > +			snprintf(ebuf, MAX_EVENT_NAME_LEN, "%s%s",
> >  				 isdigit(*symbol) ? "_" : "", symbol);
> >  		else
> > -			snprintf(buf, MAX_EVENT_NAME_LEN, "%s__%s", symbol,
> > +			snprintf(ebuf, MAX_EVENT_NAME_LEN, "%s__%s", symbol,
> >  				 is_return ? "exit" : "entry");
> > -		sanitize_event_name(buf);
> > -		event = buf;
> > +		sanitize_event_name(ebuf);
> > +		event = ebuf;
> >  	}
> >  
> >  	if (is_return)
> > @@ -1304,13 +1310,20 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
> >  		ctx->flags |= TPARG_FL_TPOINT;
> >  		mod = NULL;
> >  		tpoint = find_tracepoint(symbol, &mod);
> > -		if (tpoint)
> > +		if (tpoint) {
> > +			sbuf = kmalloc(KSYM_NAME_LEN, GFP_KERNEL);
> > +			if (!sbuf)
> > +				return -ENOMEM;
> >  			ctx->funcname = kallsyms_lookup((unsigned long)tpoint->probestub,
> >  							NULL, NULL, NULL, sbuf);
> > +		}
> >  	}
> >  	if (!ctx->funcname)
> >  		ctx->funcname = symbol;
> >  
> > +	abuf = kmalloc(MAX_BTF_ARGS_LEN, GFP_KERNEL);
> > +	if (!abuf)
> > +		return -ENOMEM;
> >  	argc -= 2; argv += 2;
> >  	new_argv = traceprobe_expand_meta_args(argc, argv, &new_argc,
> >  					       abuf, MAX_BTF_ARGS_LEN, ctx);
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
