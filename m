Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A561C862C;
	Fri, 18 Jul 2025 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857912; cv=none; b=rS45cv5iJF009mSGykTO2aGzl3LTg1iOe5sNmnTH/NSrls0KVEAKbRU05bSclTjtus4nVKLCz/bJTFyBBnD0UQnwyXijTjsQvuAgn9E7/ygMCz6WzZVm9O/RBBuUrUkctbQcImG3510RmYysSzBqLKggaJREvjqCJDEWeiW3zDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857912; c=relaxed/simple;
	bh=0CzCSY33oaNk+GLhEcS7DTvGRo9zr83z7R/QoPUgD3I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VFh4m7uRiTUV6HJR1kzZgjBgpHqaPepoYNyG5IL2aGJ/LjlCEz+Td8jd0rIoffTujMNhxXpyLGEl/9IopY8xdwokMx7dg5pRcILzSou48elUBiFAsyNmVe0Otq5r5c+4uLn+EbwcesKlmrQCaCv4jpm0n6tp+cWTYxmU4XxNBl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 749C9140153;
	Fri, 18 Jul 2025 16:58:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id CE2B220027;
	Fri, 18 Jul 2025 16:58:21 +0000 (UTC)
Date: Fri, 18 Jul 2025 12:58:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] tracing: probe: Allocate traceprobe_parse_context
 from heap
Message-ID: <20250718125820.0d0ae198@batman.local.home>
In-Reply-To: <175283844827.343578.10408845752163723065.stgit@devnote2>
References: <175283843771.343578.8524137568048302760.stgit@devnote2>
	<175283844827.343578.10408845752163723065.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: mrhbyjtgw7fhpnq51dbmwu8ph7rr8uz3
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: CE2B220027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18tdA0PzEE4imGFZXZbmXbx7Dk2dPM2Aqg=
X-HE-Tag: 1752857901-942319
X-HE-Meta: U2FsdGVkX19gc8p0G2ARNLs8R5kTfwvUFLGlpdCYRRivM+8FBwVAnke86Cz3rnRbXFXBD0MQ5fT5DqJnjLYs3UNctn1ffra5bALQFodgTdcy+QiY0JkPZQyl0BMb9xYEkTTYqY0nNfxUIw83RF7BN+OYb1b1/7KXWk8Qk2pmdiW8VqnKaO+X1uLGamDPzmW+ZTtKyFDfVNTOvxCFjb8XY6Wu5BB5uGgTkUKjN06QVPjfRadu9ndQVZkvtEnfgrWejL1JvqSAKoz8Zg2lHPYpPUfPPLMUaEHAKtolEOhypYmNtiByGHuxF+6g81Tzx7oimzK+xvWhkx9YJkd2bx8yjCgQ89S+5aSDPgyjP+GPoiQb8ofEyzx9rKsweNyl6vYh

On Fri, 18 Jul 2025 20:34:08 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 854e5668f5ee..7bc4c84464e4 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -10,6 +10,7 @@
>   * Author:     Srikar Dronamraju
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
>  #include <linux/smp.h>

Nit, but let's keep the "upside-down x-mas tree" format:

#include <linux/seq_file.h>
#include <linux/cleanup.h>
#include <linux/slab.h>
#include <linux/smp.h>


> @@ -438,6 +439,14 @@ extern void traceprobe_free_probe_arg(struct probe_arg *arg);
>   * this MUST be called for clean up the context and return a resource.
>   */
>  void traceprobe_finish_parse(struct traceprobe_parse_context *ctx);
> +static inline void traceprobe_free_parse_ctx(struct traceprobe_parse_context *ctx)
> +{
> +	traceprobe_finish_parse(ctx);
> +	kfree(ctx);
> +}
> +
> +DEFINE_FREE(traceprobe_parse_context, struct traceprobe_parse_context *,
> +		if (!IS_ERR_OR_NULL(_T)) traceprobe_free_parse_ctx(_T))

ctx will either be allocated or NULL, I think the above could be:

		if (_T) traceprobe_free_parse_ctx(_T))


>  
>  extern int traceprobe_split_symbol_offset(char *symbol, long *offset);
>  int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index f95a2c3d5b1b..1fd479718d03 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -537,6 +537,7 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
>   */
>  static int __trace_uprobe_create(int argc, const char **argv)
>  {
> +	struct traceprobe_parse_context *ctx __free(traceprobe_parse_context) = NULL;
>  	struct trace_uprobe *tu;
>  	const char *event = NULL, *group = UPROBE_EVENT_SYSTEM;
>  	char *arg, *filename, *rctr, *rctr_end, *tmp;
> @@ -693,15 +694,17 @@ static int __trace_uprobe_create(int argc, const char **argv)
>  	tu->path = path;
>  	tu->filename = filename;
>  
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +	ctx->flags = (is_return ? TPARG_FL_RETURN : 0) | TPARG_FL_USER;
> +
>  	/* parse arguments */
>  	for (i = 0; i < argc; i++) {
> -		struct traceprobe_parse_context ctx = {
> -			.flags = (is_return ? TPARG_FL_RETURN : 0) | TPARG_FL_USER,
> -		};
> -
>  		trace_probe_log_set_index(i + 2);
> -		ret = traceprobe_parse_probe_arg(&tu->tp, i, argv[i], &ctx);
> -		traceprobe_finish_parse(&ctx);
> +		ret = traceprobe_parse_probe_arg(&tu->tp, i, argv[i], ctx);

Doesn't this change the semantics a bit?

Before this change, traceprobe_finish_parse(&ctx) is called for every
iteration of the loop. Now we only do it when it exits the function.

-- Steve


>  		if (ret)
>  			goto error;
>  	}

