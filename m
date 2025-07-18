Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3B017A2F5;
	Fri, 18 Jul 2025 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752860799; cv=none; b=dxqUsU1Mx9RbQBzGMpUm4rqqYHp1U43yo1OhEuzThSiyrbYRvhIwnXP95dCJUm5Uy+74Nlu9bxAqb5YAsjBD59B5Bf/AA4Q8+oW53tqOeBEN7ZFV75FGzH3XSEX+LLc+7R8Nj572D2c1YnGqsPVQ/xPY83BXE7f2WcTBy+tRGZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752860799; c=relaxed/simple;
	bh=oBz/Fp1EodKwOhBcnhDmslhGP47e5o6kukJjwTdnwmk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TSFukugVH8oGmycVvoiyWoh+opvCtkQKqyrdEcJTBWAS6QExRIYrePIxJL3mflSPruTkY3Bp9V1GlXZDni66kcd0k8ixwZ4s8wlrwz2JtCAKS6lR6p0u3aAVU5R9IGzNbk9Zo4m3Ai2MNmesNMI0OixStAtMT3uA6nUwFzUheOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 29497B6582;
	Fri, 18 Jul 2025 17:46:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 799EF2002B;
	Fri, 18 Jul 2025 17:46:28 +0000 (UTC)
Date: Fri, 18 Jul 2025 13:46:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] tracing: kprobe-event: Allocate string buffers from
 heap
Message-ID: <20250718134627.5d483ca4@batman.local.home>
In-Reply-To: <175283846936.343578.3747359008449354291.stgit@devnote2>
References: <175283843771.343578.8524137568048302760.stgit@devnote2>
	<175283846936.343578.3747359008449354291.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 799EF2002B
X-Stat-Signature: pjxx5y3m8aq9wx17o1mkubzcpyzcshwa
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18zFTNJoWRCnrYe1mzILyAs45AHpmpIQJM=
X-HE-Tag: 1752860788-768703
X-HE-Meta: U2FsdGVkX1983FXNaEcUe10BALS9kFAXrTbh2q/p/7XpZPwlKHaAButfT8iJhMWfJJcBwTo6L0gpfT54as+VIVNglLtiQ3twha0cJtGStmBhj956TZ/vmKp9pneeqj3gzmEbb1oJtMGN8l5UrZfB1wgzDdSp5Usv8ONuIuqTWAYnfpGa9atRlU0dMRsz2krTUtnB6lrq/cOaj8MqcX64x/NQUKDmIzZmQ+p40w/hnu7U9r5Td8EotEVKc6G7wLmx6TUSQIaPOY0VPmGO54XMUUteDEhjOhdZ2geqXG9/rRhBGKf40gOjLy1+6lrOqjDaFEIbLAPOqKM9akCePkBHC4d1ttQwWgsyNgA7nie9jO67X9HK/32VzC7i0ZLQp/psHqNns//CDX8iCp1Qp/MHcw==

On Fri, 18 Jul 2025 20:34:29 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Allocate temporary string buffers for parsing kprobe-events
> from heap instead of stack.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_kprobe.c |   39 +++++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 15d7a381a128..793af6000f16 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -861,20 +861,20 @@ static int trace_kprobe_create_internal(int argc, const char *argv[],
>  	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
>  	 */
>  	struct trace_kprobe *tk __free(free_trace_kprobe) = NULL;
> +	const char *event = NULL, *group = KPROBE_EVENT_SYSTEM;
> +	const char **new_argv __free(kfree) = NULL;
>  	int i, len, new_argc = 0, ret = 0;
> -	bool is_return = false;
>  	char *symbol __free(kfree) = NULL;
> -	char *tmp = NULL;
> -	const char **new_argv __free(kfree) = NULL;
> -	const char *event = NULL, *group = KPROBE_EVENT_SYSTEM;
> +	char *ebuf __free(kfree) = NULL;
> +	char *gbuf __free(kfree) = NULL;
> +	char *abuf __free(kfree) = NULL;
> +	char *dbuf __free(kfree) = NULL;
>  	enum probe_print_type ptype;
> +	bool is_return = false;
>  	int maxactive = 0;
> -	long offset = 0;
>  	void *addr = NULL;
> -	char buf[MAX_EVENT_NAME_LEN];
> -	char gbuf[MAX_EVENT_NAME_LEN];
> -	char abuf[MAX_BTF_ARGS_LEN];
> -	char *dbuf __free(kfree) = NULL;
> +	char *tmp = NULL;
> +	long offset = 0;
>  
>  	switch (argv[0][0]) {
>  	case 'r':
> @@ -893,6 +893,8 @@ static int trace_kprobe_create_internal(int argc, const char *argv[],
>  		event++;
>  
>  	if (isdigit(argv[0][1])) {
> +		char *buf __free(kfree) = NULL;

So this gets freed when this if block ends, right?

> +
>  		if (!is_return) {
>  			trace_probe_log_err(1, BAD_MAXACT_TYPE);
>  			return -EINVAL;
> @@ -905,7 +907,7 @@ static int trace_kprobe_create_internal(int argc, const char *argv[],
>  			trace_probe_log_err(1, BAD_MAXACT);
>  			return -EINVAL;
>  		}
> -		memcpy(buf, &argv[0][1], len);
> +		buf = kmemdup(&argv[0][1], len + 1, GFP_KERNEL);
>  		buf[len] = '\0';
>  		ret = kstrtouint(buf, 0, &maxactive);
>  		if (ret || !maxactive) {
> @@ -973,6 +975,9 @@ static int trace_kprobe_create_internal(int argc, const char *argv[],
>  
>  	trace_probe_log_set_index(0);
>  	if (event) {
> +		gbuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
> +		if (!gbuf)
> +			return -ENOMEM;
>  		ret = traceprobe_parse_event_name(&event, &group, gbuf,
>  						  event - argv[0]);

And you can't use the same trick here because
traceprobe_parse_event_name() assigns "group" to gbuf and is used
outside this if block.

I notice there's no comment that states this. At the very minimum,
traceprobe_parse_event_name() should have a kerneldoc comment above its
definition and state this. But that's not an issue with this patch
series. Just an observation. Thus...

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


>  		if (ret)
> @@ -981,16 +986,22 @@ static int trace_kprobe_create_internal(int argc, const char *argv[],
>  
>  	if (!event) {
>  		/* Make a new event name */
> +		ebuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
> +		if (!ebuf)
> +			return -ENOMEM;
>  		if (symbol)
> -			snprintf(buf, MAX_EVENT_NAME_LEN, "%c_%s_%ld",
> +			snprintf(ebuf, MAX_EVENT_NAME_LEN, "%c_%s_%ld",
>  				 is_return ? 'r' : 'p', symbol, offset);
>  		else
> -			snprintf(buf, MAX_EVENT_NAME_LEN, "%c_0x%p",
> +			snprintf(ebuf, MAX_EVENT_NAME_LEN, "%c_0x%p",
>  				 is_return ? 'r' : 'p', addr);
> -		sanitize_event_name(buf);
> -		event = buf;
> +		sanitize_event_name(ebuf);
> +		event = ebuf;
>  	}
>  
> +	abuf = kmalloc(MAX_BTF_ARGS_LEN, GFP_KERNEL);
> +	if (!abuf)
> +		return -ENOMEM;
>  	argc -= 2; argv += 2;
>  	ctx->funcname = symbol;
>  	new_argv = traceprobe_expand_meta_args(argc, argv, &new_argc,

