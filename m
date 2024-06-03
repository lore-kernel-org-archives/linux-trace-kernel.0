Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF9413B2A9;
	Mon,  3 Jun 2024 19:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444221; cv=none; b=bnBFno6oBYh4jlSD1IQNQeOr+oh/ZsL/Nj1YCqvzAZrwBlASzy1hOUCaIL9Pn/+u0fr+41KMvsq+SqGtzaghaqJ6HIKFzx8xcc/pvaswxdCoVUo8xn3Vnb4cBn4pXTIGT/nEXOlT358iJltn9l/KJ7DOcwhIkQdnwXmovF7aMEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444221; c=relaxed/simple;
	bh=IrGXoX934uCRSpDT1wpnKtUAmJ47P6I0zTZYEgLz2K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FcOAoMuntTZNqY8DQUywZyaTC0VXaUF2xEaHc0ym+SFS+wNIzrGhYS7NOMfX5GUNxa/Pz4TNCeVQZMfUo+0I1F3uG/ijYXOK4K/5rBL6rn0SWu/U4AOxuNB6oF+yIv2BNkXcPQoUOhGA7JSKnZd7KAGrDQWcm4xFwCxXC+outrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=d+fP0GQ4; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="d+fP0GQ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1717444209;
	bh=IrGXoX934uCRSpDT1wpnKtUAmJ47P6I0zTZYEgLz2K0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d+fP0GQ4bbpq+dAhoAw8HhLMmuoVB3QqKJGj0KRWPVAVRfIcK0ceBuzPpood8WjkO
	 eoBF72myCGy5NlMssgK0v56T0kLY0juDehQh8D6CHVqge0V1lkRv5FYPUh8L0vl1f4
	 TTr4syTHgy7JB5SnnDUon39jf/iyZDnjRO7+vk/HLdrAAolzqtMPf0HWnv2LRgiEr7
	 +PJaRFf30VXcm2JMOiK9chh7TFuIbl0FUvJm8DuaD+Cbm+jjeCGnfwLZhmrqUuLgkp
	 qBlOP2n3JmPTWd6dcE353dzC3XLKs5GE2vD5s1j2Q/mw2K6IVQSm16JFeT+urovB9p
	 /c0vV+P5/6oDA==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4VtPTF28zNz12nF;
	Mon,  3 Jun 2024 15:50:09 -0400 (EDT)
Message-ID: <fbfec8d9-d0ed-4384-bbd2-dd5c1e568ed1@efficios.com>
Date: Mon, 3 Jun 2024 15:50:55 -0400
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tracing/fprobe: Support raw tracepoint events on
 modules
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: don <zds100@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <171723014778.258703.6731294779199848686.stgit@devnote2>
 <171723016594.258703.1629777910752596529.stgit@devnote2>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <171723016594.258703.1629777910752596529.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-06-01 04:22, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Support raw tracepoint event on module by fprobe events.
> Since it only uses for_each_kernel_tracepoint() to find a tracepoint,
> the tracepoints on modules are not handled. Thus if user specified a
> tracepoint on a module, it shows an error.
> This adds new for_each_module_tracepoint() API to tracepoint subsystem,
> and uses it to find tracepoints on modules.

Hi Masami,

Why prevent module unload when a fprobe tracepoint is attached to a
module ? This changes the kernel's behavior significantly just for the
sake of instrumentation.

As an alternative, LTTng-modules attach/detach to/from modules with the
coming/going notifiers, so the instrumentation gets removed when a
module is unloaded rather than preventing its unload by holding a module
reference count. I would recommend a similar approach for fprobe.

Thanks,

Mathieu


> 
> Reported-by: don <zds100@gmail.com>
> Closes: https://lore.kernel.org/all/20240530215718.aeec973a1d0bf058d39cb1e3@kernel.org/
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>   Changes in v2:
>    - Fix build errors with CONFIG_MODULES=y.
> ---
>   kernel/trace/trace_fprobe.c |   46 ++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 38 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index 62e6a8f4aae9..1d8a983e1edc 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -385,6 +385,7 @@ static struct trace_fprobe *alloc_trace_fprobe(const char *group,
>   					       const char *event,
>   					       const char *symbol,
>   					       struct tracepoint *tpoint,
> +					       struct module *mod,
>   					       int maxactive,
>   					       int nargs, bool is_return)
>   {
> @@ -405,6 +406,7 @@ static struct trace_fprobe *alloc_trace_fprobe(const char *group,
>   		tf->fp.entry_handler = fentry_dispatcher;
>   
>   	tf->tpoint = tpoint;
> +	tf->mod = mod;
>   	tf->fp.nr_maxactive = maxactive;
>   
>   	ret = trace_probe_init(&tf->tp, event, group, false, nargs);
> @@ -895,8 +897,23 @@ static struct notifier_block tracepoint_module_nb = {
>   struct __find_tracepoint_cb_data {
>   	const char *tp_name;
>   	struct tracepoint *tpoint;
> +	struct module *mod;
>   };
>   
> +static void __find_tracepoint_module_cb(struct tracepoint *tp, void *priv)
> +{
> +	struct __find_tracepoint_cb_data *data = priv;
> +
> +	if (!data->tpoint && !strcmp(data->tp_name, tp->name)) {
> +		data->tpoint = tp;
> +		data->mod = __module_text_address((unsigned long)tp->probestub);
> +		if (!try_module_get(data->mod)) {
> +			data->tpoint = NULL;
> +			data->mod = NULL;
> +		}
> +	}
> +}
> +
>   static void __find_tracepoint_cb(struct tracepoint *tp, void *priv)
>   {
>   	struct __find_tracepoint_cb_data *data = priv;
> @@ -905,14 +922,28 @@ static void __find_tracepoint_cb(struct tracepoint *tp, void *priv)
>   		data->tpoint = tp;
>   }
>   
> -static struct tracepoint *find_tracepoint(const char *tp_name)
> +/*
> + * Find a tracepoint from kernel and module. If the tracepoint is in a module,
> + * this increments the module refcount to prevent unloading until the
> + * trace_fprobe is registered to the list. After registering the trace_fprobe
> + * on the trace_fprobe list, the module refcount is decremented because
> + * tracepoint_probe_module_cb will handle it.
> + */
> +static struct tracepoint *find_tracepoint(const char *tp_name,
> +					  struct module **tp_mod)
>   {
>   	struct __find_tracepoint_cb_data data = {
>   		.tp_name = tp_name,
> +		.mod = NULL,
>   	};
>   
>   	for_each_kernel_tracepoint(__find_tracepoint_cb, &data);
>   
> +	if (!data.tpoint && IS_ENABLED(CONFIG_MODULES)) {
> +		for_each_module_tracepoint(__find_tracepoint_module_cb, &data);
> +		*tp_mod = data.mod;
> +	}
> +
>   	return data.tpoint;
>   }
>   
> @@ -996,6 +1027,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>   	char abuf[MAX_BTF_ARGS_LEN];
>   	char *dbuf = NULL;
>   	bool is_tracepoint = false;
> +	struct module *tp_mod = NULL;
>   	struct tracepoint *tpoint = NULL;
>   	struct traceprobe_parse_context ctx = {
>   		.flags = TPARG_FL_KERNEL | TPARG_FL_FPROBE,
> @@ -1080,7 +1112,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>   
>   	if (is_tracepoint) {
>   		ctx.flags |= TPARG_FL_TPOINT;
> -		tpoint = find_tracepoint(symbol);
> +		tpoint = find_tracepoint(symbol, &tp_mod);
>   		if (!tpoint) {
>   			trace_probe_log_set_index(1);
>   			trace_probe_log_err(0, NO_TRACEPOINT);
> @@ -1110,8 +1142,8 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>   		goto out;
>   
>   	/* setup a probe */
> -	tf = alloc_trace_fprobe(group, event, symbol, tpoint, maxactive,
> -				argc, is_return);
> +	tf = alloc_trace_fprobe(group, event, symbol, tpoint, tp_mod,
> +				maxactive, argc, is_return);
>   	if (IS_ERR(tf)) {
>   		ret = PTR_ERR(tf);
>   		/* This must return -ENOMEM, else there is a bug */
> @@ -1119,10 +1151,6 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>   		goto out;	/* We know tf is not allocated */
>   	}
>   
> -	if (is_tracepoint)
> -		tf->mod = __module_text_address(
> -				(unsigned long)tf->tpoint->probestub);
> -
>   	/* parse arguments */
>   	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
>   		trace_probe_log_set_index(i + 2);
> @@ -1155,6 +1183,8 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>   	}
>   
>   out:
> +	if (tp_mod)
> +		module_put(tp_mod);
>   	traceprobe_finish_parse(&ctx);
>   	trace_probe_log_clear();
>   	kfree(new_argv);
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

