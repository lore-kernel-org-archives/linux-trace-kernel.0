Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DF013A863;
	Tue,  4 Jun 2024 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513972; cv=none; b=oUVs8AOjAul1PeENOf+v5Ji7PVIIcxQ9Ire0Fjpk4KvJU70F5KE36XV1czqYnqVjE2cWvsCj3299h+G9Q0XTLCnuvgmCa6WlfxPpUPwpev1j2qeME7mjEeT0JQAcY9z/BQJCkxX5dRJjP0iHbnCQ4J8ReuDhmaNbIFxLCymis3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513972; c=relaxed/simple;
	bh=snGZE3s9qsesS9xe2bi91BaKQseWkzGOPHp3Bh1sXPo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oBZ73mTQE2LDYIaGm+nj5W+DbMwyNp9TaFon69VuNuAPy2u1I0dEmt0Xg7x+MnEFZ7TtLdBk89gSprP0EU+1LP0dG8P2FDmVyY8X9ltUfUdngkG5vpESWubHNbDBOTo10rXhr4xcnbltxQxWNxJkTCDQTFVuwXq0Uxx8w+pTUuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE5AC2BBFC;
	Tue,  4 Jun 2024 15:12:50 +0000 (UTC)
Date: Tue, 4 Jun 2024 11:12:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, don
 <zds100@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] tracing/fprobe: Support raw tracepoint events on
 modules
Message-ID: <20240604111249.78c48ac7@gandalf.local.home>
In-Reply-To: <20240604084955.29b9440687522a1347e0e7cd@kernel.org>
References: <171723014778.258703.6731294779199848686.stgit@devnote2>
	<171723016594.258703.1629777910752596529.stgit@devnote2>
	<fbfec8d9-d0ed-4384-bbd2-dd5c1e568ed1@efficios.com>
	<20240604084955.29b9440687522a1347e0e7cd@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jun 2024 08:49:55 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Mon, 3 Jun 2024 15:50:55 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > On 2024-06-01 04:22, Masami Hiramatsu (Google) wrote:  
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > Support raw tracepoint event on module by fprobe events.
> > > Since it only uses for_each_kernel_tracepoint() to find a tracepoint,
> > > the tracepoints on modules are not handled. Thus if user specified a
> > > tracepoint on a module, it shows an error.
> > > This adds new for_each_module_tracepoint() API to tracepoint subsystem,
> > > and uses it to find tracepoints on modules.  
> > 
> > Hi Masami,
> > 
> > Why prevent module unload when a fprobe tracepoint is attached to a
> > module ? This changes the kernel's behavior significantly just for the
> > sake of instrumentation.  
> 
> I don't prevent module unloading all the time, just before registering
> tracepoint handler (something like booking a ticket :-) ).
> See the last hunk of this patch, it puts the module before exiting
> __trace_fprobe_create().
> 
> > 
> > As an alternative, LTTng-modules attach/detach to/from modules with the
> > coming/going notifiers, so the instrumentation gets removed when a
> > module is unloaded rather than preventing its unload by holding a module
> > reference count. I would recommend a similar approach for fprobe.  
> 
> Yes, since tracepoint subsystem provides a notifier API to notify the
> tracepoint is gone, fprobe already uses it to find unloading and
> unregister the target function. (see __tracepoint_probe_module_cb)
> 

Ah, it only prevents module unloading in __trace_fprobe_create()

> +static void __find_tracepoint_module_cb(struct tracepoint *tp, void *priv)
> +{
> +	struct __find_tracepoint_cb_data *data = priv;
> +
> +	if (!data->tpoint && !strcmp(data->tp_name, tp->name)) {
> +		data->tpoint = tp;
> +		data->mod = __module_text_address((unsigned long)tp->probestub);
> +		if (!try_module_get(data->mod)) {

Here it gets the module. Should only happen once, as it sets data->tpoint.

> +			data->tpoint = NULL;
> +			data->mod = NULL;
> +		}
> +	}
> +}
> +
>  static void __find_tracepoint_cb(struct tracepoint *tp, void *priv)
>  {
>  	struct __find_tracepoint_cb_data *data = priv;
> @@ -905,14 +922,28 @@ static void __find_tracepoint_cb(struct tracepoint *tp, void *priv)
>  		data->tpoint = tp;
>  }
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
>  {
>  	struct __find_tracepoint_cb_data data = {
>  		.tp_name = tp_name,
> +		.mod = NULL,
>  	};
>  
>  	for_each_kernel_tracepoint(__find_tracepoint_cb, &data);
>  
> +	if (!data.tpoint && IS_ENABLED(CONFIG_MODULES)) {
> +		for_each_module_tracepoint(__find_tracepoint_module_cb, &data);
> +		*tp_mod = data.mod;
> +	}
> +
>  	return data.tpoint;
>  }
>  
> @@ -996,6 +1027,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>  	char abuf[MAX_BTF_ARGS_LEN];
>  	char *dbuf = NULL;
>  	bool is_tracepoint = false;
> +	struct module *tp_mod = NULL;
>  	struct tracepoint *tpoint = NULL;
>  	struct traceprobe_parse_context ctx = {
>  		.flags = TPARG_FL_KERNEL | TPARG_FL_FPROBE,
> @@ -1080,7 +1112,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>  
>  	if (is_tracepoint) {
>  		ctx.flags |= TPARG_FL_TPOINT;
> -		tpoint = find_tracepoint(symbol);
> +		tpoint = find_tracepoint(symbol, &tp_mod);
>  		if (!tpoint) {
>  			trace_probe_log_set_index(1);
>  			trace_probe_log_err(0, NO_TRACEPOINT);
> @@ -1110,8 +1142,8 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>  		goto out;
>  
>  	/* setup a probe */
> -	tf = alloc_trace_fprobe(group, event, symbol, tpoint, maxactive,
> -				argc, is_return);
> +	tf = alloc_trace_fprobe(group, event, symbol, tpoint, tp_mod,
> +				maxactive, argc, is_return);
>  	if (IS_ERR(tf)) {
>  		ret = PTR_ERR(tf);
>  		/* This must return -ENOMEM, else there is a bug */
> @@ -1119,10 +1151,6 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>  		goto out;	/* We know tf is not allocated */
>  	}
>  
> -	if (is_tracepoint)
> -		tf->mod = __module_text_address(
> -				(unsigned long)tf->tpoint->probestub);
> -
>  	/* parse arguments */
>  	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
>  		trace_probe_log_set_index(i + 2);
> @@ -1155,6 +1183,8 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>  	}
>  
>  out:
> +	if (tp_mod)
> +		module_put(tp_mod);

And on the way out, it puts it.

-- Steve

>  	traceprobe_finish_parse(&ctx);
>  	trace_probe_log_clear();
>  	kfree(new_argv);
