Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB94242D67;
	Thu, 26 Feb 2026 00:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772065651; cv=none; b=mSxJZ2K6yGBp2O+H+7Yv65tpqqz2rC7o074PzWrkwSOu3nAmA1/5qxvrXZAqVJ/+G2v9pN5Liiqqf3YT7NNU2g2iu0yV5S+fQPCcyNNvGwLCpwStAGvDFjFEeOgc46DxECsJGJTcXugLCwau5fz3oplS1aMFjxSwk4j8sp5R2CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772065651; c=relaxed/simple;
	bh=jq32sMb9gwp0msh5L6M41YEmWuZy0C+oRSy9ysqc6iM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2AuJx7GgN4poNK3PRfd1IVAY/h1FeW939ZGANJPV+IyzKE/rsY+A8IyIiqtFVzC+0P0nH4ficQFp2UCxThV7HEM87q/7j43CJFnW2mq/MVrxei23C4d281aPxI2cjFx/vmMKPrSXz9Wj74jM2CIXoD88Tg8gcfh7FiW+6XkTLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id BCCC813A6B3;
	Thu, 26 Feb 2026 00:27:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 8569E35;
	Thu, 26 Feb 2026 00:27:25 +0000 (UTC)
Date: Wed, 25 Feb 2026 19:27:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: chensong_2000@189.cn
Cc: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
 samitolvanen@google.com, atomlin@atomlin.com, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/trace/ftrace: introduce ftrace module notifier
Message-ID: <20260225192724.48ed165e@fedora>
In-Reply-To: <20260225054639.21637-1-chensong_2000@189.cn>
References: <20260225054639.21637-1-chensong_2000@189.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8569E35
X-Stat-Signature: r5wbtka4cbzdk3wt1z3cxyoed7cu86p7
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19SQoDZvBQPRI5Yp0dko/ETRkl/Hb3WaR8=
X-HE-Tag: 1772065645-907232
X-HE-Meta: U2FsdGVkX1+/gR4zQu3s5eDkMePACjR5re5clkhLIP46c062LMfk+mcX2QGDMAkO70Wd65te/oTYlMWDN3h0b1aV0Fvv4YAnmyggAcTXw0GI4HK+gwdAL2cAQQvuqWqwdmU0Y/uwlEw5LvUxImuuEXnytnDjxwXDyPl/RJJZtbeJooVYpPzNPVEI5KO0/IxAdxhmgyaR0pfehBoEct+E1Aky6Tgim8NxI0hJ82Ugq1AEKrhmUgRSumfgUk8ObtfCg+KBpwcJa2jBtQ4Dfl0t3jsiLUVLHxS+obMuj3WPpf6/l48XqZtMI3IdeQSqpqOB

On Wed, 25 Feb 2026 13:46:39 +0800
chensong_2000@189.cn wrote:

> From: Song Chen <chensong_2000@189.cn>
> 
> Like kprobe, fprobe and btf, this patch attempts to introduce
> a notifier_block for ftrace to decouple its initialization from
> load_module.
> 
> Below is the table of ftrace fucntions calls in different
> module state:
> 
> 	MODULE_STATE_UNFORMED	ftrace_module_init
> 	MODULE_STATE_COMING	ftrace_module_enable
> 	MODULE_STATE_LIVE	ftrace_free_mem
> 	MODULE_STATE_GOING	ftrace_release_mod
> 
> Unlike others, ftrace module notifier must take care of state
> MODULE_STATE_UNFORMED to ensure calling ftrace_module_init
> before complete_formation which changes module's text property.
> 
> That pretty much remains same logic with its original design,
> the only thing that changes is blocking_notifier_call_chain
> (MODULE_STATE_GOING) has to be moved from coming_cleanup to
> ddebug_cleanup in function load_module to ensure
> ftrace_release_mod is invoked in case complete_formation fails.
> 
> Signed-off-by: Song Chen <chensong_2000@189.cn>
> ---
>  kernel/module/main.c  | 14 ++++----------
>  kernel/trace/ftrace.c | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 710ee30b3bea..5dc0a980e9bd 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -45,7 +45,6 @@
>  #include <linux/license.h>
>  #include <asm/sections.h>
>  #include <linux/tracepoint.h>
> -#include <linux/ftrace.h>
>  #include <linux/livepatch.h>
>  #include <linux/async.h>
>  #include <linux/percpu.h>
> @@ -836,7 +835,6 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
>  	blocking_notifier_call_chain(&module_notify_list,
>  				     MODULE_STATE_GOING, mod);
>  	klp_module_going(mod);
> -	ftrace_release_mod(mod);

Is the above safe? klp uses ftrace. That means klp_module_going() may
need to be called before ftrace_release_mod(). That said, I wonder if
klp_module_going() could be moved into ftrace_release_mod()?

>  
>  	async_synchronize_full();
>  
> @@ -3067,8 +3065,6 @@ static noinline int do_init_module(struct module *mod)
>  	if (!mod->async_probe_requested)
>  		async_synchronize_full();
>  
> -	ftrace_free_mem(mod, mod->mem[MOD_INIT_TEXT].base,
> -			mod->mem[MOD_INIT_TEXT].base + mod->mem[MOD_INIT_TEXT].size);

Have you tested the case for why this is called? It has to be called
before the module frees the kallsyms. It's for tracing the module's
init functions.

  cd /sys/kernel/tracing
  echo :mod:<module> > set_ftrace_filter
  echo function > current_tracer
  modprobe <module>
  cat trace

You should see the init functions of the module loaded. If
ftrace_free_mem() is called after the module frees the kallsyms of the
module init functions, you'll just get garbage for the init function
names.



>  	mutex_lock(&module_mutex);
>  	/* Drop initial reference. */
>  	module_put(mod);
> @@ -3131,7 +3127,6 @@ static noinline int do_init_module(struct module *mod)
>  	blocking_notifier_call_chain(&module_notify_list,
>  				     MODULE_STATE_GOING, mod);
>  	klp_module_going(mod);
> -	ftrace_release_mod(mod);
>  	free_module(mod);
>  	wake_up_all(&module_wq);
>  
> @@ -3278,7 +3273,6 @@ static int prepare_coming_module(struct module *mod)
>  {
>  	int err;
>  
> -	ftrace_module_enable(mod);
>  	err = klp_module_coming(mod);

Same issue with ftrace and klp here.

>  	if (err)
>  		return err;
> @@ -3461,7 +3455,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  	init_build_id(mod, info);
>  
>  	/* Ftrace init must be called in the MODULE_STATE_UNFORMED state */
> -	ftrace_module_init(mod);
> +	blocking_notifier_call_chain(&module_notify_list,
> +				MODULE_STATE_UNFORMED, mod);
>  
>  	/* Finally it's fully formed, ready to start executing. */
>  	err = complete_formation(mod, info);
> @@ -3513,8 +3508,6 @@ static int load_module(struct load_info *info, const char __user *uargs,
>   coming_cleanup:
>  	mod->state = MODULE_STATE_GOING;
>  	destroy_params(mod->kp, mod->num_kp);
> -	blocking_notifier_call_chain(&module_notify_list,
> -				     MODULE_STATE_GOING, mod);
>  	klp_module_going(mod);

Now klp_module_going() may need to be called *after* the
MODULE_STATE_GOING callbacks and *before* ftrace_release_mod(). But
again, if that's moved into ftrace_release_mod() it may be fine.

>   bug_cleanup:
>  	mod->state = MODULE_STATE_GOING;
> @@ -3524,7 +3517,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  	mutex_unlock(&module_mutex);
>  
>   ddebug_cleanup:
> -	ftrace_release_mod(mod);
> +	blocking_notifier_call_chain(&module_notify_list,
> +				     MODULE_STATE_GOING, mod);
>  	synchronize_rcu();
>  	kfree(mod->args);
>   free_arch_cleanup:
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c

-- Steve
