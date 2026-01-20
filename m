Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F393BF2EF;
	Tue, 20 Jan 2026 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768942233; cv=none; b=VjnBOzMQ8Ezy+u1aw3xd26yACS8VT5R9LRR4DLqaHiIQhG7JDr9VlYKH9vFZOv5YBJ4SCyIl1h44VOtNZQabV3aYikJKP3mJ7+9r0ZFevl0YN1L2uI1RYZYBhte95rLdhjoezlW1Ge3Vf1Nsy2k8MyB0br56NAJ8LD9tLc6g8D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768942233; c=relaxed/simple;
	bh=rpRZpV3FMkK3I6Msimm2uVhMDG5RHUvCYbjEqE3O7yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFwZrAznpphkuBoT0F56zpKBWjPPUSBBAC16CJG9I95vMeI6yeICPmftBNStcwUHKCg7Hts50rGPasBqTLssBMGJt8SNnUvk2DQOQg9Fs4waQbIddPSer+2Im3lXwAoVg4tvkeBaT4Pufixp3OwxSsIW7hslfaXjTXe3Y/Qmx0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 1D7438C2F3;
	Tue, 20 Jan 2026 20:50:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id E3C8D60011;
	Tue, 20 Jan 2026 20:50:25 +0000 (UTC)
Date: Tue, 20 Jan 2026 15:50:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Cc: mhiramat@kernel.org, corbet@lwn.net, shuah@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 1/3] tracing/fprobe: Support comma-separated symbols
 and :entry/:exit
Message-ID: <20260120155047.4ef3c378@gandalf.local.home>
In-Reply-To: <20260114221341.128038-2-seokwoo.chung130@gmail.com>
References: <20251126184110.72241-1-seokwoo.chung130@gmail.com>
	<20260114221341.128038-1-seokwoo.chung130@gmail.com>
	<20260114221341.128038-2-seokwoo.chung130@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: E3C8D60011
X-Stat-Signature: jrtmepm1z88w1mizsqhattj3o37we6ky
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/nEHTVmKHy7dTLOhobmuf1oJYfvo/7lZs=
X-HE-Tag: 1768942225-38081
X-HE-Meta: U2FsdGVkX1+c7yx+1EdcoVJUqwtcYG1SyA1BnPp8inHrIvYWuEQpayjTmEVNiRif/GOqf/zOAK3zCZbEIMgZJeBlF8bv/JbH6cST2RI77gKiXajEHw8S9RYN8gTPvQE+L6BZFOLG4hU5K0fKE0Ts8HswieGtCrZXh1cqIx/w9tUWSaCdwrWUAOhnwlXFZ6gYPw5hd8hmxQNdwOa5SKzYPRjReCKjHQ+dqIuw/Ei9sW8YucIM7jek09N7n5X3OKhLC0cUDT7vWXrBNediIc/ED4L2+P1jJgV/bXF10cbM0nYnPTahgsPQAmQudEwtp7i19u9GdiMcLzH4D8Pgz1ahNxawfUklpENa

On Wed, 14 Jan 2026 17:13:38 -0500
"Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com> wrote:

Missing change log. The subject is the "what" the patch is doing, the
change log needs the "why".

> Signed-off-by: Seokwoo Chung (Ryan) <seokwoo.chung130@gmail.com>
> ---
>  kernel/trace/trace.c        |  4 +--
>  kernel/trace/trace_fprobe.c | 49 ++++++++++++++++++++-----------------
>  kernel/trace/trace_probe.h  |  2 ++
>  3 files changed, 31 insertions(+), 24 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 10cdcc7b194e..73b59d47dfe7 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5578,8 +5578,8 @@ static const char readme_msg[] =
>  	"\t           r[maxactive][:[<group>/][<event>]] <place> [<args>]\n"
>  #endif
>  #ifdef CONFIG_FPROBE_EVENTS
> -	"\t           f[:[<group>/][<event>]] <func-name>[:entry|:exit] [<args>]\n"
> -	"\t		(single symbols still accept %return)\n"
> +	"\t           f[:[<group>/][<event>]] <func-name>[%return] [<args>]\n"
> +	"\t	      f[:[<group>/][<event>]] <func-list>[:entry|:exit] [<args>]\n" 
>  	"\t           t[:[<group>/][<event>]] <tracepoint> [<args>]\n"
>  #endif
>  #ifdef CONFIG_HIST_TRIGGERS
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index 5a2a41eea603..1663c341ddb4 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -187,16 +187,23 @@ DEFINE_FREE(tuser_put, struct tracepoint_user *,
>   */
>  struct trace_fprobe {
>  	struct dyn_event	devent;
> -	char			*filter;
> +
>  	struct fprobe		fp;
> -	bool			list_mode;
> -	char			*nofilter;
>  	const char		*symbol;
> -	struct trace_probe	tp;
> +	char			*filter;
> +	char			*nofilter;
> +
>  	bool			tprobe;
>  	struct tracepoint_user	*tuser;
> +
> +	struct trace_probe tp;

Why is this being updated? Nothing in the change log says why?

>  };
>  
> +static inline bool trace_fprobe_has_list(const struct trace_fprobe *tf)
> +{
> +	return tf->filter || tf->nofilter;
> +}
> +
>  static bool is_trace_fprobe(struct dyn_event *ev)
>  {
>  	return ev->ops == &trace_fprobe_ops;
> @@ -847,7 +854,7 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
>  	 * - list_mode: pass filter/nofilter
>  	 * - single: pass symbol only (legacy)
>  	 */
> -	if (tf->list_mode)
> +	if (trace_fprobe_has_list(tf))
>  		return register_fprobe(&tf->fp, tf->filter, tf->nofilter);
>  	return register_fprobe(&tf->fp, tf->symbol, NULL);
>  }
> @@ -1188,11 +1195,18 @@ static int parse_fprobe_spec(const char *in, bool is_tracepoint,
>  	*base = NULL; *filter = NULL; *nofilter = NULL;
>  	*is_return = false; *list_mode = false;
>  
> -	if (is_tracepoint) {
> +	if (is_tracepoint) 
> +	{
>  		if (strchr(in, ',') || strchr(in, ':'))
> +		{
> +			trace_probe_log_err(0, BAD_TP_NAME);
>  			return -EINVAL;
> +		}
>  		if (strstr(in, "%return"))
> +		{
> +			trace_probe_log_err(p - in, BAD_TP_NAME);
>  			return -EINVAL;
> +		}
>  		for (p = in; *p; p++)
>  			if (!isalnum(*p) && *p != '_')
>  				return -EINVAL;
> @@ -1225,6 +1239,7 @@ static int parse_fprobe_spec(const char *in, bool is_tracepoint,
>  			} else if (!strcmp(p, ":entry")) {
>  				*(char *)p = '\0';
>  			} else {
> +				trace_probe_log_err(p - work, BAD_LIST_SUFFIX);
>  				return -EINVAL;
>  			}
>  		}
> @@ -1233,6 +1248,7 @@ static int parse_fprobe_spec(const char *in, bool is_tracepoint,
>  	list = !!strchr(work, ',');
>  	
>  	if (list && legacy_ret) {
> +		trace_probe_log_err(p - work, BAD_LEGACY_RET);
>  		return -EINVAL;
>  	}
>  
> @@ -1245,12 +1261,9 @@ static int parse_fprobe_spec(const char *in, bool is_tracepoint,
>  
>  	if (list) {
>  		char *tmp = b, *tok;
> -		size_t fsz, nfsz;
>  
> -		fsz = nfsz = strlen(b) + 1;
> -
> -		f = kzalloc(fsz, GFP_KERNEL);
> -		nf = kzalloc(nfsz, GFP_KERNEL);
> +		f = kzalloc(strlen(b) + 1, GFP_KERNEL);
> +		nf = kzalloc(strlen(b) + 1, GFP_KERNEL);
>  		if (!f || !nf)
>  			return -ENOMEM;
>  
> @@ -1261,6 +1274,7 @@ static int parse_fprobe_spec(const char *in, bool is_tracepoint,
>  			if (*tok == '\0') {
>  				trace_probe_log_err(tmp - b - 1, BAD_TP_NAME);
>  				return -EINVAL;
> +			}
>  
>  			if (neg)
>  				tok++;
> @@ -1455,17 +1469,8 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
>  
>  	/* carry list parsing result into tf */
>  	if (!is_tracepoint) {
> -		tf->list_mode = list_mode;
> -		if (parsed_filter) {
> -			tf->filter = kstrdup(parsed_filter, GFP_KERNEL);
> -			if (!tf->filter)
> -				return -ENOMEM;
> -		}
> -		if (parsed_nofilter) {
> -			tf->nofilter = kstrdup(parsed_nofilter, GFP_KERNEL);
> -			if (!tf->nofilter)
> -				return -ENOMEM;
> -		}
> +		tf->filter = no_free_ptr(parsed_filter);
> +		tf->nofilter = no_free_ptr(parsed_nofilter);
>  	}
>  
>  	/* parse arguments */
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 9fc56c937130..b8b0544eb7cd 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -494,9 +494,11 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
>  	C(BAD_PROBE_ADDR,	"Invalid probed address or symbol"),	\
>  	C(NON_UNIQ_SYMBOL,	"The symbol is not unique"),		\
>  	C(BAD_RETPROBE,		"Retprobe address must be an function entry"), \
> +	C(BAD_LEGACY_RET,	"Legacy %return not allowed with list"), \
>  	C(NO_TRACEPOINT,	"Tracepoint is not found"),		\
>  	C(BAD_TP_NAME,		"Invalid character in tracepoint name"),\
>  	C(BAD_ADDR_SUFFIX,	"Invalid probed address suffix"), \
> +	C(BAD_LIST_SUFFIX,	"Bad list suffix"), \
>  	C(NO_GROUP_NAME,	"Group name is not specified"),		\
>  	C(GROUP_TOO_LONG,	"Group name is too long"),		\
>  	C(BAD_GROUP_NAME,	"Group name must follow the same rules as C identifiers"), \

This definitely needs discussion on why this is needed.

-- Steve

