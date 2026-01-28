Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9754132C31B;
	Wed, 28 Jan 2026 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769588430; cv=none; b=jZ6A/+jsk1zNBxnq+uVhohsYkcWytr43KGitl9PnzYTW5XyPtVHEWigwDybqdxDLg00NH2wMmCnWnwNbGJ09HLd4d4svtPrVSut7tlHw/3yYE7iSpykjS7xeo148Isq80ly7tEQbQECQGilawf5Za8ypHeQo/6i0iLMgsGf7KNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769588430; c=relaxed/simple;
	bh=MBayRkE85SAbpVFB1EuS8EgofcZvP6cEmVao2tnio4I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dv0XV1v9R8xlYimUdixiYbS2fuCWFEj4KWsjQMhcUsCjiNLtN111xrVGG9WWl+e4SWcWNhREXOe+IcAoKXx6VYUB7qCX80oiyi1zQycizQPKQZWnlEbwvLdxWUbKfhTp/9qVBR+J07tIT3eqHtlDDuyvtmEkaSHgqlBLBN8JAP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWqD4VP8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWqD4VP8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F58C4CEF1;
	Wed, 28 Jan 2026 08:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769588429;
	bh=MBayRkE85SAbpVFB1EuS8EgofcZvP6cEmVao2tnio4I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HWqD4VP8WuPZ/3WZr2YZu7RpDxTKg3DZrAXkPCbiCSwKzxci+pqpwPVAIl8kYV1XU
	 cVE6t/xISPNodbKzWuL+czO6/Trri4Wh2Jvg0fyLamHAPEjUIxCz0NAbxbRP1ID3c/
	 4U9MGIqHc/N9DreSubOYTc4lQXdydhTCGRTCF5m6/Tt95u9WJQTuQdUIUYpDmZ9mEE
	 VMIskLnLyh6ZToSuQmMcfxBVJix+rLhPTNo92xAwbjLG+UZ1CEjS3t031Z2XQcDbf0
	 AX0qIHK0RB9H1Ejz1e9oMUTL1s67xLkDbW2pfJELrNUkltEENM6FOrWHKAiYrF8UBQ
	 BjzJKfFE4bAqg==
Date: Wed, 28 Jan 2026 17:20:27 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Have hist_debug show what function a field
 uses
Message-Id: <20260128172027.0299a917e2a1e1c01b541b9b@kernel.org>
In-Reply-To: <20260122203822.58df4d80@gandalf.local.home>
References: <20260122203822.58df4d80@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 20:38:22 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When CONFIG_HIST_TRIGGERS_DEBUG is enabled, each trace event has a
> "hist_debug" file that explains the histogram internal data. This is very
> useful for debugging histograms.
> 
> One bit of data that was missing from this file was what function a
> histogram field uses to process its data. The hist_field structure now has
> a fn_num that is used by a switch statement in hist_fn_call() to call a
> function directly (to avoid spectre mitigations).
> 
> Instead of displaying that number, create a string array that maps to the
> histogram function enums so that the function for a field may be
> displayed:
> 
>  ~# cat /sys/kernel/tracing/events/sched/sched_switch/hist_debug
> [..]
> hist_data: 0000000043d62762
> 
>   n_vals: 2
>   n_keys: 1
>   n_fields: 3
> 
>   val fields:
> 
>     hist_data->fields[0]:
>       flags:
>         VAL: HIST_FIELD_FL_HITCOUNT
>       type: u64
>       size: 8
>       is_signed: 0
>       function: hist_field_counter()
> 
>     hist_data->fields[1]:
>       flags:
>         HIST_FIELD_FL_VAR
>       var.name: __arg_3921_2
>       var.idx (into tracing_map_elt.vars[]): 0
>       type: unsigned long[]
>       size: 128
>       is_signed: 0
>       function: hist_field_nop()
> 
>   key fields:
> 
>     hist_data->fields[2]:
>       flags:
>         HIST_FIELD_FL_KEY
>       ftrace_event_field name: prev_pid
>       type: pid_t
>       size: 8
>       is_signed: 1
>       function: hist_field_s32()
> 
> The "function:" field above is added.

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,


> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_hist.c | 75 +++++++++++++++++++-------------
>  1 file changed, 44 insertions(+), 31 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 4a7f945e368d..24441b30a1a4 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -105,38 +105,44 @@ enum field_op_id {
>  	FIELD_OP_MULT,
>  };
>  
> +#define FIELD_FUNCS					\
> +	C(NOP,			"nop"),			\
> +	C(VAR_REF,		"var_ref"),		\
> +	C(COUNTER,		"counter"),		\
> +	C(CONST,		"const"),		\
> +	C(LOG2,			"log2"),		\
> +	C(BUCKET,		"bucket"),		\
> +	C(TIMESTAMP,		"timestamp"),		\
> +	C(CPU,			"cpu"),			\
> +	C(COMM,			"comm"),		\
> +	C(STRING,		"string"),		\
> +	C(DYNSTRING,		"dynstring"),		\
> +	C(RELDYNSTRING,		"reldynstring"),	\
> +	C(PSTRING,		"pstring"),		\
> +	C(S64,			"s64"),			\
> +	C(U64,			"u64"),			\
> +	C(S32,			"s32"),			\
> +	C(U32,			"u32"),			\
> +	C(S16,			"s16"),			\
> +	C(U16,			"u16"),			\
> +	C(S8,			"s8"),			\
> +	C(U8,			"u8"),			\
> +	C(UMINUS,		"uminus"),		\
> +	C(MINUS,		"minus"),		\
> +	C(PLUS,			"plus"),		\
> +	C(DIV,			"div"),			\
> +	C(MULT,			"mult"),		\
> +	C(DIV_POWER2,		"div_power2"),		\
> +	C(DIV_NOT_POWER2,	"div_not_power2"),	\
> +	C(DIV_MULT_SHIFT,	"div_mult_shift"),	\
> +	C(EXECNAME,		"execname"),		\
> +	C(STACK,		"stack"),
> +
> +#undef C
> +#define C(a, b)		HIST_FIELD_FN_##a
> +
>  enum hist_field_fn {
> -	HIST_FIELD_FN_NOP,
> -	HIST_FIELD_FN_VAR_REF,
> -	HIST_FIELD_FN_COUNTER,
> -	HIST_FIELD_FN_CONST,
> -	HIST_FIELD_FN_LOG2,
> -	HIST_FIELD_FN_BUCKET,
> -	HIST_FIELD_FN_TIMESTAMP,
> -	HIST_FIELD_FN_CPU,
> -	HIST_FIELD_FN_COMM,
> -	HIST_FIELD_FN_STRING,
> -	HIST_FIELD_FN_DYNSTRING,
> -	HIST_FIELD_FN_RELDYNSTRING,
> -	HIST_FIELD_FN_PSTRING,
> -	HIST_FIELD_FN_S64,
> -	HIST_FIELD_FN_U64,
> -	HIST_FIELD_FN_S32,
> -	HIST_FIELD_FN_U32,
> -	HIST_FIELD_FN_S16,
> -	HIST_FIELD_FN_U16,
> -	HIST_FIELD_FN_S8,
> -	HIST_FIELD_FN_U8,
> -	HIST_FIELD_FN_UMINUS,
> -	HIST_FIELD_FN_MINUS,
> -	HIST_FIELD_FN_PLUS,
> -	HIST_FIELD_FN_DIV,
> -	HIST_FIELD_FN_MULT,
> -	HIST_FIELD_FN_DIV_POWER2,
> -	HIST_FIELD_FN_DIV_NOT_POWER2,
> -	HIST_FIELD_FN_DIV_MULT_SHIFT,
> -	HIST_FIELD_FN_EXECNAME,
> -	HIST_FIELD_FN_STACK,
> +	FIELD_FUNCS
>  };
>  
>  /*
> @@ -5845,6 +5851,12 @@ const struct file_operations event_hist_fops = {
>  };
>  
>  #ifdef CONFIG_HIST_TRIGGERS_DEBUG
> +
> +#undef C
> +#define C(a, b)		b
> +
> +static const char * const field_funcs[] = { FIELD_FUNCS };
> +
>  static void hist_field_debug_show_flags(struct seq_file *m,
>  					unsigned long flags)
>  {
> @@ -5909,6 +5921,7 @@ static int hist_field_debug_show(struct seq_file *m,
>  	seq_printf(m, "      type: %s\n", field->type);
>  	seq_printf(m, "      size: %u\n", field->size);
>  	seq_printf(m, "      is_signed: %u\n", field->is_signed);
> +	seq_printf(m, "      function: hist_field_%s()\n", field_funcs[field->fn_num]);
>  
>  	return 0;
>  }
> -- 
> 2.51.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
