Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CBD12F59C;
	Mon,  6 Jan 2025 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736158193; cv=none; b=SdtVPvR9TRPrde83h9SsoAQ6bZu7nIQSlxSuZFPkp7CCXxkznzXIHZZGdgyMbo+gHmwFrhYqh3+pTK35g4I5J9qlSuxC2gFgBNBT5shcmWxLY48iJJnsABycpA0DNCTdJ+Rk/2YINQq+SfTCjNOiDtYXmKth89XLjpotqNkGIQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736158193; c=relaxed/simple;
	bh=qagxCc9O31VtXEeDlJp0Hl8WPJ/PL35/Y8aUapgUUls=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bVB/hI8g7/k748J2GwnkehCrA/eTbg3TDAC9QG2q+CFprBzZpubNy7HVe+8p19loum+Z/yIrHSC1ofkKohvUkOt3F9Uk+0qVb6cHlqdrnnbvy/ZEDK8ovfovzsxH9LQRHs+42X4Eq8Fb0Q3HcUluRkvTmUCCnYDFCFzuVyREHuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNUzP7Vs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNUzP7Vs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D8CC4CED2;
	Mon,  6 Jan 2025 10:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736158192;
	bh=qagxCc9O31VtXEeDlJp0Hl8WPJ/PL35/Y8aUapgUUls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dNUzP7Vsc80QEYSQJvAncfotUnUgWMb8S6VPkveAAefsgm1nSXioMBS+xr+1eo8zp
	 HI6Ume5akwQyfkR1vnDwO/8Neb0D8ywRs9X/9ynzFw1REnN2pdrm2MOYpMAOG7stGk
	 zjfi88ueChi85MiGVl3rQOPraftKJnPpfIB0SY4zGULpIOZ8mgegGA+ucJs9xSRtSH
	 k8zX+Iz1HKvhVNBkOZOIPDvDJ5yC+6I2r9RfHcBUSvU7HuPZyyTOrJvEYgYMTe26+4
	 RyFKzvammaCDgo/afSH11MBfBdQ5wWJnkZaPstsLGIlNsmR4/6tTq1Z5x2tajkNoYQ
	 QrltLZmySo7gQ==
Date: Mon, 6 Jan 2025 19:09:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra
 <peterz@infradead.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] tracing: Use __free() for kprobe events to
 cleanup
Message-Id: <20250106190947.12f64f10d32290aad7ab0cea@kernel.org>
In-Reply-To: <173608130975.1253657.5725356281406948364.stgit@devnote2>
References: <173608125422.1253657.3732758016133408588.stgit@devnote2>
	<173608130975.1253657.5725356281406948364.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  5 Jan 2025 21:48:29 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Use __free() in trace_kprobe.c to cleanup code.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v2:
>   - Instead of using no_free_ptr(), just assign NULL to the registered pointer.
> ---
>  kernel/trace/trace_kprobe.c |   57 ++++++++++++++++++++-----------------------
>  1 file changed, 26 insertions(+), 31 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 4c3e316454a0..e1ae65f57bf9 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -8,6 +8,7 @@
>  #define pr_fmt(fmt)	"trace_kprobe: " fmt
>  
>  #include <linux/bpf-cgroup.h>
> +#include <linux/cleanup.h>
>  #include <linux/security.h>
>  #include <linux/module.h>
>  #include <linux/uaccess.h>
> @@ -257,6 +258,8 @@ static void free_trace_kprobe(struct trace_kprobe *tk)
>  	}
>  }
>  
> +DEFINE_FREE(trace_kprobe, struct trace_kprobe *, free_trace_kprobe(_T))

Oops, this also need to check !IS_ERR_OR_NULL(_T) since free_trace_kprobe()
only checks the pointer != NULL.

Thanks,

> +
>  /*
>   * Allocate new trace_probe and initialize it (including kprobes).
>   */
> @@ -268,7 +271,7 @@ static struct trace_kprobe *alloc_trace_kprobe(const char *group,
>  					     int maxactive,
>  					     int nargs, bool is_return)
>  {
> -	struct trace_kprobe *tk;
> +	struct trace_kprobe *tk __free(trace_kprobe) = NULL;
>  	int ret = -ENOMEM;
>  
>  	tk = kzalloc(struct_size(tk, tp.args, nargs), GFP_KERNEL);
> @@ -277,12 +280,12 @@ static struct trace_kprobe *alloc_trace_kprobe(const char *group,
>  
>  	tk->nhit = alloc_percpu(unsigned long);
>  	if (!tk->nhit)
> -		goto error;
> +		return ERR_PTR(ret);
>  
>  	if (symbol) {
>  		tk->symbol = kstrdup(symbol, GFP_KERNEL);
>  		if (!tk->symbol)
> -			goto error;
> +			return ERR_PTR(ret);
>  		tk->rp.kp.symbol_name = tk->symbol;
>  		tk->rp.kp.offset = offs;
>  	} else
> @@ -299,13 +302,10 @@ static struct trace_kprobe *alloc_trace_kprobe(const char *group,
>  
>  	ret = trace_probe_init(&tk->tp, event, group, false, nargs);
>  	if (ret < 0)
> -		goto error;
> +		return ERR_PTR(ret);
>  
>  	dyn_event_init(&tk->devent, &trace_kprobe_ops);
> -	return tk;
> -error:
> -	free_trace_kprobe(tk);
> -	return ERR_PTR(ret);
> +	return_ptr(tk);
>  }
>  
>  static struct trace_kprobe *find_trace_kprobe(const char *event,
> @@ -861,11 +861,12 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>  	 * Type of args:
>  	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
>  	 */
> -	struct trace_kprobe *tk = NULL;
> +	struct trace_kprobe *tk __free(trace_kprobe) = NULL;
>  	int i, len, new_argc = 0, ret = 0;
>  	bool is_return = false;
> -	char *symbol = NULL, *tmp = NULL;
> -	const char **new_argv = NULL;
> +	char *symbol __free(kfree) = NULL;
> +	char *tmp = NULL;
> +	const char **new_argv __free(kfree) = NULL;
>  	const char *event = NULL, *group = KPROBE_EVENT_SYSTEM;
>  	enum probe_print_type ptype;
>  	int maxactive = 0;
> @@ -874,7 +875,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>  	char buf[MAX_EVENT_NAME_LEN];
>  	char gbuf[MAX_EVENT_NAME_LEN];
>  	char abuf[MAX_BTF_ARGS_LEN];
> -	char *dbuf = NULL;
> +	char *dbuf __free(kfree) = NULL;
>  	struct traceprobe_parse_context ctx = { .flags = TPARG_FL_KERNEL };
>  
>  	switch (argv[0][0]) {
> @@ -931,7 +932,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>  		/* Check whether uprobe event specified */
>  		if (strchr(argv[1], '/') && strchr(argv[1], ':')) {
>  			ret = -ECANCELED;
> -			goto error;
> +			goto out;
>  		}
>  		/* a symbol specified */
>  		symbol = kstrdup(argv[1], GFP_KERNEL);
> @@ -1035,7 +1036,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>  		ctx.offset = 0;
>  		ret = traceprobe_parse_probe_arg(&tk->tp, i, argv[i], &ctx);
>  		if (ret)
> -			goto error;	/* This can be -ENOMEM */
> +			goto out;	/* This can be -ENOMEM */
>  	}
>  	/* entry handler for kretprobe */
>  	if (is_return && tk->tp.entry_arg) {
> @@ -1046,7 +1047,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>  	ptype = is_return ? PROBE_PRINT_RETURN : PROBE_PRINT_NORMAL;
>  	ret = traceprobe_set_print_fmt(&tk->tp, ptype);
>  	if (ret < 0)
> -		goto error;
> +		goto out;
>  
>  	ret = register_trace_kprobe(tk);
>  	if (ret) {
> @@ -1057,21 +1058,20 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>  			trace_probe_log_err(0, BAD_PROBE_ADDR);
>  		else if (ret != -ENOMEM && ret != -EEXIST)
>  			trace_probe_log_err(0, FAIL_REG_PROBE);
> -		goto error;
> -	}
> +	} else
> +		/*
> +		 * Here, 'tk' has been registered to the list successfully,
> +		 * so we don't need to free it.
> +		 */
> +		tk = NULL;
>  
>  out:
>  	traceprobe_finish_parse(&ctx);
>  	trace_probe_log_clear();
> -	kfree(new_argv);
> -	kfree(symbol);
> -	kfree(dbuf);
>  	return ret;
>  
>  parse_error:
>  	ret = -EINVAL;
> -error:
> -	free_trace_kprobe(tk);
>  	goto out;
>  }
>  
> @@ -1893,7 +1893,7 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
>  			  bool is_return)
>  {
>  	enum probe_print_type ptype;
> -	struct trace_kprobe *tk;
> +	struct trace_kprobe *tk __free(trace_kprobe) = NULL;
>  	int ret;
>  	char *event;
>  
> @@ -1924,19 +1924,14 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
>  
>  	ptype = trace_kprobe_is_return(tk) ?
>  		PROBE_PRINT_RETURN : PROBE_PRINT_NORMAL;
> -	if (traceprobe_set_print_fmt(&tk->tp, ptype) < 0) {
> -		ret = -ENOMEM;
> -		goto error;
> -	}
> +	if (traceprobe_set_print_fmt(&tk->tp, ptype) < 0)
> +		return ERR_PTR(-ENOMEM);
>  
>  	ret = __register_trace_kprobe(tk);
>  	if (ret < 0)
> -		goto error;
> +		return ERR_PTR(ret);
>  
>  	return trace_probe_event_call(&tk->tp);
> -error:
> -	free_trace_kprobe(tk);
> -	return ERR_PTR(ret);
>  }
>  
>  void destroy_local_trace_kprobe(struct trace_event_call *event_call)
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
