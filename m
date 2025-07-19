Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305CA23CE;
	Sat, 19 Jul 2025 01:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752887521; cv=none; b=ShkZmXnlaHqbUWfZrRvPWxYfXTig6yyLACuD/9FFrQguXNbuWn9Qc83kwqfTIzDHCograke6kgyNm74AleSQlM8NcMCz2TGMbmrubPElCdq3zl7UCQfuTECcnWJcwyjCPI/hj1IPQfK0g2fEDbnO8gVZ7ww1rv+rMNXUK5LcIkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752887521; c=relaxed/simple;
	bh=YJvtRO5/wZ3DGV4Bgxz8YaNNdwthfz+kByHZysWMU60=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ryXFeyt4dArErD61UiUQWRtvKjPN/la4+noStw+yZJ8FRnap74L0YDaGCyHglUplnCcQRYaPhNAmUWn5ir+KXRkxV8lG2CVvfj3Dt5h26w5aKED1O0W5Ln6HIc72dVa4th2GCoLDIEC2NjODMDWcdg1XdarxY8w96r6A0OwGAGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oA9VbVZQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oA9VbVZQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8535AC4CEEB;
	Sat, 19 Jul 2025 01:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752887520;
	bh=YJvtRO5/wZ3DGV4Bgxz8YaNNdwthfz+kByHZysWMU60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oA9VbVZQ24AybQuLRHgjlF6KGFpGxZlwpqTwHuSOoFoSJ+Kqx/Wej+c/H1qC61Xpr
	 3yh1Bqpr7RVsJ9MeE8aETyk3XOtpMFCn30BtXh7ztGi1VpqLOcCkZlTSkdJAsxEB+U
	 takjhCTa9V54GWUjFCZUXvBSMX8vk9VZwZy2DSar8EMfQU88X49FMhYg3WlpbIj+KR
	 0O5kshccjXe3Yk59k2pkrXyumz//zRBVF1u7j0lUVT0z4psmY+8rroecQ9xNL20nv8
	 6Gsbnk6lW7Q5AW/XYrtqDNjUlbx7QiVrk/TW+FMDW/xNz3RLVvNdo7554DpE6AEJjk
	 lDwkd98GzMrsQ==
Date: Sat, 19 Jul 2025 10:11:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] tracing: eprobe-event: Allocate string buffers from
 heap
Message-Id: <20250719101156.f9edeca2680e54aa184c439a@kernel.org>
In-Reply-To: <20250718135549.387b98ab@batman.local.home>
References: <175283843771.343578.8524137568048302760.stgit@devnote2>
	<175283848063.343578.12113784863348416166.stgit@devnote2>
	<20250718135549.387b98ab@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Jul 2025 13:55:49 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 18 Jul 2025 20:34:40 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Allocate temporary string buffers for parsing eprobe-events
> > from heap instead of stack.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_eprobe.c |   24 ++++++++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> > index 1e18a8619b40..75d8208cd859 100644
> > --- a/kernel/trace/trace_eprobe.c
> > +++ b/kernel/trace/trace_eprobe.c
> > @@ -9,6 +9,7 @@
> >   * Copyright (C) 2021, VMware Inc, Tzvetomir Stoyanov tz.stoyanov@gmail.com>
> >   *
> >   */
> > +#include <linux/cleanup.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> >  #include <linux/ftrace.h>
> > @@ -871,10 +872,10 @@ static int __trace_eprobe_create(int argc, const char *argv[])
> >  	const char *event = NULL, *group = EPROBE_EVENT_SYSTEM;
> >  	const char *sys_event = NULL, *sys_name = NULL;
> >  	struct trace_event_call *event_call;
> > +	char *buf1 __free(kfree) = NULL;
> > +	char *buf2 __free(kfree) = NULL;
> > +	char *gbuf __free(kfree) = NULL;
> >  	struct trace_eprobe *ep = NULL;
> > -	char buf1[MAX_EVENT_NAME_LEN];
> > -	char buf2[MAX_EVENT_NAME_LEN];
> > -	char gbuf[MAX_EVENT_NAME_LEN];
> >  	int ret = 0, filter_idx = 0;
> >  	int i, filter_cnt;
> >  
> > @@ -885,6 +886,11 @@ static int __trace_eprobe_create(int argc, const char *argv[])
> >  
> >  	event = strchr(&argv[0][1], ':');
> >  	if (event) {
> > +		gbuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
> > +		if (!gbuf) {
> > +			ret = -ENOMEM;
> > +			goto parse_error;
> > +		}
> >  		event++;
> >  		ret = traceprobe_parse_event_name(&event, &group, gbuf,
> >  						  event - argv[0]);
> > @@ -894,6 +900,12 @@ static int __trace_eprobe_create(int argc, const char *argv[])
> >  
> >  	trace_probe_log_set_index(1);
> >  	sys_event = argv[1];
> > +
> > +	buf2 = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
> > +	if (!buf2) {
> > +		ret = -ENOMEM;
> > +		goto parse_error;
> > +	}
> >  	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2, 0);
> >  	if (ret || !sys_event || !sys_name) {
> >  		trace_probe_log_err(0, NO_EVENT_INFO);
> > @@ -901,7 +913,11 @@ static int __trace_eprobe_create(int argc, const char *argv[])
> >  	}
> >  
> >  	if (!event) {
> > -		strscpy(buf1, sys_event, MAX_EVENT_NAME_LEN);
> > +		buf1 = kstrdup(sys_event, GFP_KERNEL);
> > +		if (!buf1) {
> > +			ret = -ENOMEM;
> > +			goto error;
> > +		}
> 
> I kinda hate all these updating of "ret" before jumping to error.

Agreed.

> 
> >  		event = buf1;
> >  	}
> >  
> 
> What about this:

Looks good to me. Note that eventually I will use cleanup.h to
remove gotos from this function as same as other probes too.

Anyway, in this series I will use the below code.

Thank you!

> 
> -- Steve
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index 916555f0de81..48cc1079a1dd 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -9,6 +9,7 @@
>   * Copyright (C) 2021, VMware Inc, Tzvetomir Stoyanov tz.stoyanov@gmail.com>
>   *
>   */
> +#include <linux/cleanup.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/ftrace.h>
> @@ -869,10 +870,10 @@ static int __trace_eprobe_create(int argc, const char *argv[])
>  	const char *event = NULL, *group = EPROBE_EVENT_SYSTEM;
>  	const char *sys_event = NULL, *sys_name = NULL;
>  	struct trace_event_call *event_call;
> +	char *buf1 __free(kfree) = NULL;
> +	char *buf2 __free(kfree) = NULL;
> +	char *gbuf __free(kfree) = NULL;
>  	struct trace_eprobe *ep = NULL;
> -	char buf1[MAX_EVENT_NAME_LEN];
> -	char buf2[MAX_EVENT_NAME_LEN];
> -	char gbuf[MAX_EVENT_NAME_LEN];
>  	int ret = 0, filter_idx = 0;
>  	int i, filter_cnt;
>  
> @@ -883,6 +884,9 @@ static int __trace_eprobe_create(int argc, const char *argv[])
>  
>  	event = strchr(&argv[0][1], ':');
>  	if (event) {
> +		gbuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
> +		if (!gbuf)
> +			goto mem_error;
>  		event++;
>  		ret = traceprobe_parse_event_name(&event, &group, gbuf,
>  						  event - argv[0]);
> @@ -892,6 +896,10 @@ static int __trace_eprobe_create(int argc, const char *argv[])
>  
>  	trace_probe_log_set_index(1);
>  	sys_event = argv[1];
> +
> +	buf2 = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
> +	if (!buf2)
> +		goto mem_error;
>  	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2, 0);
>  	if (ret || !sys_event || !sys_name) {
>  		trace_probe_log_err(0, NO_EVENT_INFO);
> @@ -899,7 +907,9 @@ static int __trace_eprobe_create(int argc, const char *argv[])
>  	}
>  
>  	if (!event) {
> -		strscpy(buf1, sys_event, MAX_EVENT_NAME_LEN);
> +		buf1 = kstrdup(sys_event, GFP_KERNEL);
> +		if (!buf1)
> +			goto mem_error;
>  		event = buf1;
>  	}
>  
> @@ -972,6 +982,9 @@ static int __trace_eprobe_create(int argc, const char *argv[])
>  	trace_probe_log_clear();
>  	return ret;
>  
> +mem_error:
> +	ret = -ENOMEM;
> +	goto error;
>  parse_error:
>  	ret = -EINVAL;
>  error:


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
