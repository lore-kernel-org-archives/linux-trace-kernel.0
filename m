Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0BA199FBA;
	Thu, 29 Jan 2026 04:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769660655; cv=none; b=WVHsq/aTQjH7HnSGksKBelCHvR6iYm7WBGoQt+COADVDkwbH4qjp3XD9Uxit0l/f1TzhvhyTd84LPZyRYPS4/dmqTOjwZa6VeBJ4q3daTMEtufzb/B95sSn4/x4sQgXfTOhL10aykJyIH2na+BZlqZ1uUj9HyeUtq5tnQB6tkP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769660655; c=relaxed/simple;
	bh=t9xnxpQK9RLSI5mJrEEcX/s/HlA2IQ0v/xE6C33zm04=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LW6jHpbYKZOu+QURM3bAZuj9swtliOIZOHvwL/JJBopY65XE/AQN02Qx4jXQISPYpeldaj3JKKQGElZmbKF6z+zbShDJagljEQS/1fJ0n3aBcVZ5+dvBoWMgxyAZ/4u0eD9FYsPpCmxqIAyQjKna0bGtRh9VieK+Yw5WO/VcyDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2uXLMWn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2uXLMWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972ABC116D0;
	Thu, 29 Jan 2026 04:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769660654;
	bh=t9xnxpQK9RLSI5mJrEEcX/s/HlA2IQ0v/xE6C33zm04=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D2uXLMWnmVVYhhfIvx5vzJnnoEp7BhFv5nqLOWrcsn/1dy3tw73eFHNNFlseDJVnf
	 CQsAJC2e0f9LpaAXH/F2P0drZfTwvQqKE9F/GuHMNTwJbLSlppSqHpmChCmHQk+L/S
	 GsUvTugytATMcnpSl5nEZJi6ulWD6cUVpGFpk+iK4PV4ncHKYoc4HhS8L9WO61/oxW
	 YC7cifwRfRIYKEKWda4pmwcqnZuViHFR2XAfwf8ME/pP8gvXHd/O6wmSo/U9ckImKn
	 bIuzwD2RzisLaek4ivaZKkHNfVI9whSkSjHRRxpGfCuuZApSgBQQsUtnacfr8k40bC
	 rYsPOoch7BA1Q==
Date: Thu, 29 Jan 2026 13:24:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Cc: rostedt@goodmis.org, corbet@lwn.net, shuah@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 v5 2/3] tracing/fprobe: Support comma-separated
 symbols and :entry/:exit
Message-Id: <20260129132412.babdf9a72e72f0d8b6273510@kernel.org>
In-Reply-To: <20260118011815.56516-3-seokwoo.chung130@gmail.com>
References: <20260118011815.56516-1-seokwoo.chung130@gmail.com>
	<20260118011815.56516-3-seokwoo.chung130@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Jan 2026 20:18:14 -0500
"Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com> wrote:

> - Update DEFINE_FREE to use standard __free()
> - Extend fprobe to support multiple symbols per event. Add parsing logic for
>   lists, ! exclusions, and explicit suffixes. Update tracefs/README to reflect
>   the new syntax
> 
> Signed-off-by: Seokwoo Chung (Ryan) <seokwoo.chung130@gmail.com>
> ---
>  kernel/trace/trace.c        |   3 +-
>  kernel/trace/trace_fprobe.c | 209 +++++++++++++++++++++++++++---------
>  2 files changed, 163 insertions(+), 49 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index baec63134ab6..10cdcc7b194e 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5578,7 +5578,8 @@ static const char readme_msg[] =
>  	"\t           r[maxactive][:[<group>/][<event>]] <place> [<args>]\n"
>  #endif
>  #ifdef CONFIG_FPROBE_EVENTS
> -	"\t           f[:[<group>/][<event>]] <func-name>[%return] [<args>]\n"
> +	"\t           f[:[<group>/][<event>]] <func-name>[:entry|:exit] [<args>]\n"
> +	"\t		(single symbols still accept %return)\n"
>  	"\t           t[:[<group>/][<event>]] <tracepoint> [<args>]\n"
>  #endif
>  #ifdef CONFIG_HIST_TRIGGERS
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index 262c0556e4af..5a2a41eea603 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -187,11 +187,14 @@ DEFINE_FREE(tuser_put, struct tracepoint_user *,
>   */
>  struct trace_fprobe {
>  	struct dyn_event	devent;
> +	char			*filter;
>  	struct fprobe		fp;
> +	bool			list_mode;
> +	char			*nofilter;
>  	const char		*symbol;
> +	struct trace_probe	tp;
>  	bool			tprobe;
>  	struct tracepoint_user	*tuser;
> -	struct trace_probe	tp;
>  };
>  
>  static bool is_trace_fprobe(struct dyn_event *ev)
> @@ -559,6 +562,8 @@ static void free_trace_fprobe(struct trace_fprobe *tf)
>  		trace_probe_cleanup(&tf->tp);
>  		if (tf->tuser)
>  			tracepoint_user_put(tf->tuser);
> +		kfree(tf->filter);
> +		kfree(tf->nofilter);
>  		kfree(tf->symbol);
>  		kfree(tf);
>  	}
> @@ -838,7 +843,12 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
>  	if (trace_fprobe_is_tracepoint(tf))
>  		return __regsiter_tracepoint_fprobe(tf);
>  
> -	/* TODO: handle filter, nofilter or symbol list */
> +	/* Registration path:
> +	 * - list_mode: pass filter/nofilter
> +	 * - single: pass symbol only (legacy)
> +	 */
> +	if (tf->list_mode)
> +		return register_fprobe(&tf->fp, tf->filter, tf->nofilter);
>  	return register_fprobe(&tf->fp, tf->symbol, NULL);
>  }
>  
> @@ -1154,60 +1164,119 @@ static struct notifier_block tprobe_event_module_nb = {
>  };
>  #endif /* CONFIG_MODULES */
>  
> -static int parse_symbol_and_return(int argc, const char *argv[],
> -				   char **symbol, bool *is_return,
> -				   bool is_tracepoint)
> +static bool has_wildcard(const char *s)
>  {
> -	char *tmp = strchr(argv[1], '%');
> -	int i;
> +	return s && (strchr(s, '*') || strchr(s, '?'));
> +}
>  
> -	if (tmp) {
> -		int len = tmp - argv[1];
> +static int parse_fprobe_spec(const char *in, bool is_tracepoint,
> +		char **base, bool *is_return, bool *list_mode,
> +		char **filter, char **nofilter)
> +{
> +	char *work __free(kfree) = NULL;
> +	char *b __free(kfree) = NULL;
> +	char *f __free(kfree) = NULL;
> +	char *nf __free(kfree) = NULL;
> +	bool legacy_ret = false;
> +	bool list = false;
> +	const char *p;
> +	int ret = 0;
>  
> -		if (!is_tracepoint && !strcmp(tmp, "%return")) {
> -			*is_return = true;
> -		} else {
> -			trace_probe_log_err(len, BAD_ADDR_SUFFIX);
> -			return -EINVAL;
> -		}
> -		*symbol = kmemdup_nul(argv[1], len, GFP_KERNEL);
> -	} else
> -		*symbol = kstrdup(argv[1], GFP_KERNEL);
> -	if (!*symbol)
> -		return -ENOMEM;
> +	if (!in || !base || !is_return || !list_mode || !filter || !nofilter)
> +		return -EINVAL;
>  
> -	if (*is_return)
> -		return 0;
> +	*base = NULL; *filter = NULL; *nofilter = NULL;
> +	*is_return = false; *list_mode = false;
>  
>  	if (is_tracepoint) {
> -		tmp = *symbol;
> -		while (*tmp && (isalnum(*tmp) || *tmp == '_'))
> -			tmp++;
> -		if (*tmp) {
> -			/* find a wrong character. */
> -			trace_probe_log_err(tmp - *symbol, BAD_TP_NAME);
> -			kfree(*symbol);
> -			*symbol = NULL;
> +		if (strchr(in, ',') || strchr(in, ':'))
>  			return -EINVAL;
> -		}
> +		if (strstr(in, "%return"))
> +			return -EINVAL;

These checks look redundant. because below ensures there is no
',', '/' and '%'.

> +		for (p = in; *p; p++)
> +			if (!isalnum(*p) && *p != '_')
> +				return -EINVAL;

Please report parse error via trace_probe_log_err() function so that
user can check what was wrong via tracefs/error_log file. E.g.

	trace_probe_log_err(p - in, BAD_TP_NAME);


> +		b = kstrdup(in, GFP_KERNEL);
> +		if (!b)
> +			return -ENOMEM;

Note: ENOMEM does not need to report via error_log.

> +		*base = no_free_ptr(b);
> +		return 0;
>  	}
>  
> -	/* If there is $retval, this should be a return fprobe. */
> -	for (i = 2; i < argc; i++) {
> -		tmp = strstr(argv[i], "$retval");
> -		if (tmp && !isalnum(tmp[7]) && tmp[7] != '_') {
> -			if (is_tracepoint) {
> -				trace_probe_log_set_index(i);
> -				trace_probe_log_err(tmp - argv[i], RETVAL_ON_PROBE);
> -				kfree(*symbol);
> -				*symbol = NULL;
> +	work = kstrdup(in, GFP_KERNEL);
> +	if (!work)
> +		return -ENOMEM;
> +
> +	p = strstr(work, "%return");
> +	if (p && p[7] == '\0') {
> +		*is_return = true;
> +		legacy_ret = true;
> +		*(char *)p = '\0';
> +	} else {
> +		/*
> +		 * If "symbol:entry" or "symbol:exit" is given, it is new
> +		 * style probe.
> +		 */
> +		p = strrchr(work, ':');
> +		if (p) {
> +			if (!strcmp(p, ":exit")) {
> +				*is_return = true;
> +				*(char *)p = '\0';
> +			} else if (!strcmp(p, ":entry")) {
> +				*(char *)p = '\0';
> +			} else {
>  				return -EINVAL;
>  			}
> -			*is_return = true;
> -			break;
>  		}
>  	}
> -	return 0;
> +
> +	list = !!strchr(work, ',');
> +	
> +	if (list && legacy_ret) {
> +		return -EINVAL;
> +	}

You don't need braces for the above block.

> +
> +	if (legacy_ret)
> +		*is_return = true;
> +
> +	b = kstrdup(work, GFP_KERNEL);
> +	if (!b)
> +		return -ENOMEM;
> +
> +	if (list) {

Could you make this block as an independent function?

> +		char *tmp = b, *tok;
> +		size_t fsz, nfsz;
> +
> +		fsz = nfsz = strlen(b) + 1;
> +
> +		f = kzalloc(fsz, GFP_KERNEL);
> +		nf = kzalloc(nfsz, GFP_KERNEL);
> +		if (!f || !nf)
> +			return -ENOMEM;
> +
> +		while ((tok = strsep(&tmp, ",")) != NULL) {
> +			char *dst;
> +			bool neg = (*tok == '!');
> +
> +			if (*tok == '\0') {
> +				trace_probe_log_err(tmp - b - 1, BAD_TP_NAME);
> +				return -EINVAL;

You missed close brace '}' here. And that makes the build failure.
Can you fix it and run all tests under tools/testing/selftests/ftrace/
with your change?

Thank you,


> +
> +			if (neg)
> +				tok++;
> +			dst = neg ? nf : f;
> +			if (dst[0] != '\0')
> +				strcat(dst, ",");
> +			strcat(dst, tok);
> +		}
> +		*list_mode = true;
> +	}
> +
> +	*base = no_free_ptr(b);
> +	*filter = no_free_ptr(f);
> +	*nofilter = no_free_ptr(nf);
> +
> +	return ret;
>  }
>  
>  static int trace_fprobe_create_internal(int argc, const char *argv[],
> @@ -1241,6 +1310,8 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
>  	const char *event = NULL, *group = FPROBE_EVENT_SYSTEM;
>  	struct module *mod __free(module_put) = NULL;
>  	const char **new_argv __free(kfree) = NULL;
> +	char *parsed_nofilter __free(kfree) = NULL;
> +	char *parsed_filter __free(kfree) = NULL;
>  	char *symbol __free(kfree) = NULL;
>  	char *ebuf __free(kfree) = NULL;
>  	char *gbuf __free(kfree) = NULL;
> @@ -1249,6 +1320,7 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
>  	char *dbuf __free(kfree) = NULL;
>  	int i, new_argc = 0, ret = 0;
>  	bool is_tracepoint = false;
> +	bool list_mode = false;
>  	bool is_return = false;
>  
>  	if ((argv[0][0] != 'f' && argv[0][0] != 't') || argc < 2)
> @@ -1270,11 +1342,26 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
>  
>  	trace_probe_log_set_index(1);
>  
> -	/* a symbol(or tracepoint) must be specified */
> -	ret = parse_symbol_and_return(argc, argv, &symbol, &is_return, is_tracepoint);
> +	/* Parse spec early (single vs list, suffix, base symbol) */
> +	ret = parse_fprobe_spec(argv[1], is_tracepoint, &symbol, &is_return,
> +			&list_mode, &parsed_filter, &parsed_nofilter);
>  	if (ret < 0)
>  		return -EINVAL;
>  
> +	for (i = 2; i < argc; i++) {
> +		char *tmp = strstr(argv[i], "$retval");
> +
> +		if (tmp && !isalnum(tmp[7]) && tmp[7] != '_') {
> +			if (is_tracepoint) {
> +				trace_probe_log_set_index(i);
> +				trace_probe_log_err(tmp - argv[i], RETVAL_ON_PROBE);
> +				return -EINVAL;
> +			}
> +			is_return = true;
> +			break;
> +		}
> +	}
> +
>  	trace_probe_log_set_index(0);
>  	if (event) {
>  		gbuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
> @@ -1287,6 +1374,15 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
>  	}
>  
>  	if (!event) {
> +		/*
> +		 * Event name rules:
> +		 * - For list/wildcard: require explicit [GROUP/]EVENT
> +		 * - For single literal: autogenerate symbol__entry/symbol__exit
> +		 */
> +		if (list_mode || has_wildcard(symbol)) {
> +			trace_probe_log_err(0, NO_GROUP_NAME);
> +			return -EINVAL;
> +		}
>  		ebuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
>  		if (!ebuf)
>  			return -ENOMEM;
> @@ -1322,7 +1418,8 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
>  							NULL, NULL, NULL, sbuf);
>  		}
>  	}
> -	if (!ctx->funcname)
> +
> +	if (!list_mode && !has_wildcard(symbol) && !is_tracepoint)
>  		ctx->funcname = symbol;
>  
>  	abuf = kmalloc(MAX_BTF_ARGS_LEN, GFP_KERNEL);
> @@ -1356,6 +1453,21 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
>  		return ret;
>  	}
>  
> +	/* carry list parsing result into tf */
> +	if (!is_tracepoint) {
> +		tf->list_mode = list_mode;
> +		if (parsed_filter) {
> +			tf->filter = kstrdup(parsed_filter, GFP_KERNEL);
> +			if (!tf->filter)
> +				return -ENOMEM;
> +		}
> +		if (parsed_nofilter) {
> +			tf->nofilter = kstrdup(parsed_nofilter, GFP_KERNEL);
> +			if (!tf->nofilter)
> +				return -ENOMEM;
> +		}
> +	}
> +
>  	/* parse arguments */
>  	for (i = 0; i < argc; i++) {
>  		trace_probe_log_set_index(i + 2);
> @@ -1442,8 +1554,9 @@ static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev)
>  	seq_printf(m, ":%s/%s", trace_probe_group_name(&tf->tp),
>  				trace_probe_name(&tf->tp));
>  
> -	seq_printf(m, " %s%s", trace_fprobe_symbol(tf),
> -			       trace_fprobe_is_return(tf) ? "%return" : "");
> +	seq_printf(m, " %s", trace_fprobe_symbol(tf));
> +	if (!trace_fprobe_is_tracepoint(tf) && trace_fprobe_is_return(tf))
> +		seq_puts(m, ":exit");
>  
>  	for (i = 0; i < tf->tp.nr_args; i++)
>  		seq_printf(m, " %s=%s", tf->tp.args[i].name, tf->tp.args[i].comm);
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
