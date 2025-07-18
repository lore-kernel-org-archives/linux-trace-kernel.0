Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA28156678;
	Fri, 18 Jul 2025 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752860354; cv=none; b=WsZQgv0yCTf9q6h+UXRkS1ZR5kj6LiOkLTNFmA430/NJI9TC4ZW+qXdjSq0nSQO9cybLbLmZCCj0t0QO0BmYFHD39lbk8+YGutzY33qe0uTT87IffAWzReiTPHjX+nQ2AcCV6UzxxQJ8PtaZO2O9N07uXxMUHd52JeYTXDS7oNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752860354; c=relaxed/simple;
	bh=5Rk/G7wsR0SP1jYxjf6PluXIyHe7/NFMk+1LySyLWSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MIpzY7IySin0H5JH+D7v01Ihj3DwEcRpc81s9YJw+hZOa3bbcDEWUtjq2xyydVDyjH4AI6w6pSdvWniFCqyhGr4nEKBwz6FNNc1IrE6zsVwUac2dIOdjlVx/Spc8o1xfpru9QZWk2meL9+1Z4mnoojJj5um7pqP6dDXxZ3wweGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id E3703C016F;
	Fri, 18 Jul 2025 17:39:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 4002C6000F;
	Fri, 18 Jul 2025 17:39:08 +0000 (UTC)
Date: Fri, 18 Jul 2025 13:39:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] tracing: fprobe-event: Allocate string buffers from
 heap
Message-ID: <20250718133907.6e56a3fa@batman.local.home>
In-Reply-To: <175283845881.343578.10010946807218897188.stgit@devnote2>
References: <175283843771.343578.8524137568048302760.stgit@devnote2>
	<175283845881.343578.10010946807218897188.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4002C6000F
X-Stat-Signature: pqz9gbzk837n1g88pn1xbtzzf6kkkzm3
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Oaf5WJqTst86BCkvqjzIGjaQw+0fUXAw=
X-HE-Tag: 1752860348-939073
X-HE-Meta: U2FsdGVkX1/c/3+Ayp0hT81n12/xrsmZzRdOGAxjRULOdE2aRkfXQMZCWe5aqOdSHM7RTFmxgahPAbiMO4VPVVDVseffe4rSRQNULKBXrOy7CjQgzzM7QiqLhHZ9Izw1wYDOxWixL6T4IV0IK639xa/sB3Xwx3StXpN4p0mLn4D9H9ouhwU8siNZpU9bavK9uA739nGXhdsaIMOKquIMZHe3qDpphEvnTTbZP/VQmL3SlJhMLuIzJwBKHAbhFkW1aFbCxwhhGPx7JwjoDkfKP/ZJhYO8i8EHfJg4t573iuX3APyGzyCthqGX9czORRhgg12+VB59RND5p7v0/a5E53kXPObQI0G5eU0XQqIOD+pgSl7Je+GVpw==

On Fri, 18 Jul 2025 20:34:19 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Allocate temporary string buffers for fprobe-event from heap
> instead of stack. This fixes the stack frame exceed limit error.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506240416.nZIhDXoO-lkp@intel.com/
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_fprobe.c |   39 ++++++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index 264cf7fc9a1d..fd1036e27309 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -1234,18 +1234,18 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
>  	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
>  	 */
>  	struct trace_fprobe *tf __free(free_trace_fprobe) = NULL;
> -	struct module *mod __free(module_put) = NULL;
> -	int i, new_argc = 0, ret = 0;
> -	bool is_return = false;
> -	char *symbol __free(kfree) = NULL;
>  	const char *event = NULL, *group = FPROBE_EVENT_SYSTEM;
> +	struct module *mod __free(module_put) = NULL;
>  	const char **new_argv __free(kfree) = NULL;
> -	char buf[MAX_EVENT_NAME_LEN];
> -	char gbuf[MAX_EVENT_NAME_LEN];
> -	char sbuf[KSYM_NAME_LEN];
> -	char abuf[MAX_BTF_ARGS_LEN];
> +	char *symbol __free(kfree) = NULL;
> +	char *ebuf __free(kfree) = NULL;
> +	char *gbuf __free(kfree) = NULL;
> +	char *sbuf __free(kfree) = NULL;
> +	char *abuf __free(kfree) = NULL;
>  	char *dbuf __free(kfree) = NULL;
> +	int i, new_argc = 0, ret = 0;
>  	bool is_tracepoint = false;
> +	bool is_return = false;
>  
>  	if ((argv[0][0] != 'f' && argv[0][0] != 't') || argc < 2)
>  		return -ECANCELED;
> @@ -1273,6 +1273,9 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
>  
>  	trace_probe_log_set_index(0);
>  	if (event) {
> +		gbuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
> +		if (!gbuf)
> +			return -ENOMEM;
>  		ret = traceprobe_parse_event_name(&event, &group, gbuf,
>  						  event - argv[0]);
>  		if (ret)
> @@ -1280,15 +1283,18 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
>  	}
>  
>  	if (!event) {
> +		ebuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);

ebuf and gbuf are used with the same length. Why not just keep them
using the same buffer? It worked before this patch, it should work
after too.

	buf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
	if (!buf)
		return -ENOMEM;

	if (event) {
		[..]
	}

	if (!event) {
		[..]
	}

And not require two different variables that will add two exit codes
when one would do.

-- Steve


> +		if (!ebuf)
> +			return -ENOMEM;
>  		/* Make a new event name */
>  		if (is_tracepoint)
> -			snprintf(buf, MAX_EVENT_NAME_LEN, "%s%s",
> +			snprintf(ebuf, MAX_EVENT_NAME_LEN, "%s%s",
>  				 isdigit(*symbol) ? "_" : "", symbol);
>  		else
> -			snprintf(buf, MAX_EVENT_NAME_LEN, "%s__%s", symbol,
> +			snprintf(ebuf, MAX_EVENT_NAME_LEN, "%s__%s", symbol,
>  				 is_return ? "exit" : "entry");
> -		sanitize_event_name(buf);
> -		event = buf;
> +		sanitize_event_name(ebuf);
> +		event = ebuf;
>  	}
>  
>  	if (is_return)
> @@ -1304,13 +1310,20 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
>  		ctx->flags |= TPARG_FL_TPOINT;
>  		mod = NULL;
>  		tpoint = find_tracepoint(symbol, &mod);
> -		if (tpoint)
> +		if (tpoint) {
> +			sbuf = kmalloc(KSYM_NAME_LEN, GFP_KERNEL);
> +			if (!sbuf)
> +				return -ENOMEM;
>  			ctx->funcname = kallsyms_lookup((unsigned long)tpoint->probestub,
>  							NULL, NULL, NULL, sbuf);
> +		}
>  	}
>  	if (!ctx->funcname)
>  		ctx->funcname = symbol;
>  
> +	abuf = kmalloc(MAX_BTF_ARGS_LEN, GFP_KERNEL);
> +	if (!abuf)
> +		return -ENOMEM;
>  	argc -= 2; argv += 2;
>  	new_argv = traceprobe_expand_meta_args(argc, argv, &new_argc,
>  					       abuf, MAX_BTF_ARGS_LEN, ctx);

