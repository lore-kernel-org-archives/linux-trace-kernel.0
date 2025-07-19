Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF60AD23;
	Sat, 19 Jul 2025 01:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752887826; cv=none; b=RUnqJnuARgVa/n9Wfiz5fh/1bFgZnpEftMo7aUMinozs9k44bXviKTg7WaCkiikY+1Om7XkdZQFphhrEA67nIpms4umodYLobBY4jmlU2iiojvRANYmtC81ILIOEnGSFeasLwaFtu/ngUf4IvFkTj3a+q5dbfN2NrzLpl3pEalU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752887826; c=relaxed/simple;
	bh=FPWiPcjYSntguei1vjfZ6WAkudlepH1LgXSxbOmd/q0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eb7KUIGcK08jLRA+1jhySyCJn6lVaKKB/Vm1YWFR4GXrbi60NllHDgoaolNx48sYphoyLH1M8VZQX7FDOkIwZPSqWQmFKpuH0AmPVPbg1lw2U1OJOIb9ddL2yWMah4Lh8azeVc9BuCZmIMkeAsYbZeE4PJj38GYGU1s+lfUcdvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvL54+0o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvL54+0o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C812C4CEEB;
	Sat, 19 Jul 2025 01:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752887825;
	bh=FPWiPcjYSntguei1vjfZ6WAkudlepH1LgXSxbOmd/q0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lvL54+0oybb/4AfrH/Uc9gVtF1zi9VLicG/hkBWxbjHYh4nJEM2RIuajYWB008ZAv
	 lFkV/028zFCxQiaMeJ23pc2XdWt5wJZrVqrvjVNM9ORBJ0CqtgbVxqb0iZpySuanAp
	 aRqlsh+c7YNACM69GPd2zE72bdVsdfRlICe38oxAytFN6q10kLvCYeu45Ld9XqF67v
	 S97RS3N8FWuEUZ5C0BVssNeHFV3uQ1phSmVg41x/X9NxO+/awsINQFatn60fZeDSOF
	 xIqR+GzcJ7tIlBJ7NoVXuniMY8RtrEBElb+lMBGNhy/TbOOLSwiP0vAxLHpZ3JciL/
	 Z7Z232V2LlFEQ==
Date: Sat, 19 Jul 2025 10:17:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] tracing: kprobe-event: Allocate string buffers from
 heap
Message-Id: <20250719101701.0df8cde9709bdd9f0075c82a@kernel.org>
In-Reply-To: <20250718134627.5d483ca4@batman.local.home>
References: <175283843771.343578.8524137568048302760.stgit@devnote2>
	<175283846936.343578.3747359008449354291.stgit@devnote2>
	<20250718134627.5d483ca4@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Jul 2025 13:46:27 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 18 Jul 2025 20:34:29 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Allocate temporary string buffers for parsing kprobe-events
> > from heap instead of stack.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_kprobe.c |   39 +++++++++++++++++++++++++--------------
> >  1 file changed, 25 insertions(+), 14 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 15d7a381a128..793af6000f16 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -861,20 +861,20 @@ static int trace_kprobe_create_internal(int argc, const char *argv[],
> >  	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
> >  	 */
> >  	struct trace_kprobe *tk __free(free_trace_kprobe) = NULL;
> > +	const char *event = NULL, *group = KPROBE_EVENT_SYSTEM;
> > +	const char **new_argv __free(kfree) = NULL;
> >  	int i, len, new_argc = 0, ret = 0;
> > -	bool is_return = false;
> >  	char *symbol __free(kfree) = NULL;
> > -	char *tmp = NULL;
> > -	const char **new_argv __free(kfree) = NULL;
> > -	const char *event = NULL, *group = KPROBE_EVENT_SYSTEM;
> > +	char *ebuf __free(kfree) = NULL;
> > +	char *gbuf __free(kfree) = NULL;
> > +	char *abuf __free(kfree) = NULL;
> > +	char *dbuf __free(kfree) = NULL;
> >  	enum probe_print_type ptype;
> > +	bool is_return = false;
> >  	int maxactive = 0;
> > -	long offset = 0;
> >  	void *addr = NULL;
> > -	char buf[MAX_EVENT_NAME_LEN];
> > -	char gbuf[MAX_EVENT_NAME_LEN];
> > -	char abuf[MAX_BTF_ARGS_LEN];
> > -	char *dbuf __free(kfree) = NULL;
> > +	char *tmp = NULL;
> > +	long offset = 0;
> >  
> >  	switch (argv[0][0]) {
> >  	case 'r':
> > @@ -893,6 +893,8 @@ static int trace_kprobe_create_internal(int argc, const char *argv[],
> >  		event++;
> >  
> >  	if (isdigit(argv[0][1])) {
> > +		char *buf __free(kfree) = NULL;
> 
> So this gets freed when this if block ends, right?

Yes, because in this block, "buf" is used as a really temporary
buffer.

> 
> > +
> >  		if (!is_return) {
> >  			trace_probe_log_err(1, BAD_MAXACT_TYPE);
> >  			return -EINVAL;
> > @@ -905,7 +907,7 @@ static int trace_kprobe_create_internal(int argc, const char *argv[],
> >  			trace_probe_log_err(1, BAD_MAXACT);
> >  			return -EINVAL;
> >  		}
> > -		memcpy(buf, &argv[0][1], len);
> > +		buf = kmemdup(&argv[0][1], len + 1, GFP_KERNEL);
> >  		buf[len] = '\0';
> >  		ret = kstrtouint(buf, 0, &maxactive);
> >  		if (ret || !maxactive) {
> > @@ -973,6 +975,9 @@ static int trace_kprobe_create_internal(int argc, const char *argv[],
> >  
> >  	trace_probe_log_set_index(0);
> >  	if (event) {
> > +		gbuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
> > +		if (!gbuf)
> > +			return -ENOMEM;
> >  		ret = traceprobe_parse_event_name(&event, &group, gbuf,
> >  						  event - argv[0]);
> 
> And you can't use the same trick here because
> traceprobe_parse_event_name() assigns "group" to gbuf and is used
> outside this if block.

Yes, that holds the group name used until parsing the probe.

> 
> I notice there's no comment that states this. At the very minimum,
> traceprobe_parse_event_name() should have a kerneldoc comment above its
> definition and state this.

Yeah, that function should be docummented, it is a bit complicated.

> But that's not an issue with this patch
> series. Just an observation. Thus...
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thank you!

> 
> -- Steve
> 
> 
> >  		if (ret)
> > @@ -981,16 +986,22 @@ static int trace_kprobe_create_internal(int argc, const char *argv[],
> >  
> >  	if (!event) {
> >  		/* Make a new event name */
> > +		ebuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
> > +		if (!ebuf)
> > +			return -ENOMEM;
> >  		if (symbol)
> > -			snprintf(buf, MAX_EVENT_NAME_LEN, "%c_%s_%ld",
> > +			snprintf(ebuf, MAX_EVENT_NAME_LEN, "%c_%s_%ld",
> >  				 is_return ? 'r' : 'p', symbol, offset);
> >  		else
> > -			snprintf(buf, MAX_EVENT_NAME_LEN, "%c_0x%p",
> > +			snprintf(ebuf, MAX_EVENT_NAME_LEN, "%c_0x%p",
> >  				 is_return ? 'r' : 'p', addr);
> > -		sanitize_event_name(buf);
> > -		event = buf;
> > +		sanitize_event_name(ebuf);
> > +		event = ebuf;
> >  	}
> >  
> > +	abuf = kmalloc(MAX_BTF_ARGS_LEN, GFP_KERNEL);
> > +	if (!abuf)
> > +		return -ENOMEM;
> >  	argc -= 2; argv += 2;
> >  	ctx->funcname = symbol;
> >  	new_argv = traceprobe_expand_meta_args(argc, argv, &new_argc,
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
