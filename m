Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EFB356759;
	Mon, 11 May 2026 23:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543274; cv=none; b=u7rHxwQyfTKA3fbSUKVqDZZabxiR8H0BCGtsn1We1vkll5Ar+7fWXU4pJOwD3A0Y63uitD4vVyVRLJNhMhX/7LmeEIlVLeQECjrAQFyWe75qnNerh6pizaKbgA+rt3mKuQhZWUfKpE0QrxDnGs2CLb/VdJSOdtGe1mWwOMNYnzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543274; c=relaxed/simple;
	bh=DNnyPo0mC75/41/eb29/iBSVY9YaJWDI/IpOpQGp0qU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Gv0TK0R5c0X1/08bDdM+zfQtiTDWB6m0way1sThi9PXtwB1TrgEZgi1Elol72KHZSdb5g3PXD6cRbHvGLUSvk72NBtTi/QuAkBySSS0yStMbB9YZODjiGlgkf9Zm2rseiuF+9eaeU/wsdelG0GYqMLNn+7L3a+rBzZlPk5e6J70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e14LTPrw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e14LTPrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2294FC2BCF5;
	Mon, 11 May 2026 23:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778543274;
	bh=DNnyPo0mC75/41/eb29/iBSVY9YaJWDI/IpOpQGp0qU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e14LTPrwJHYSiNk0AWdDKEcHXueB8HjJnwb6VTjWfa4zTEfVygN0DhxiQJdCpofgi
	 sSfYEN2q+ll42EaDpZadPLge2DwrRG8ygptv+LRD2G8HmvWvXyfkVbp/3JEZGZGgom
	 HvKHOjsyRlIKJkdUN5EuAh/gah5eLXfTjIqA80261ocDOCI1g4NmJL33/nlZweKHwM
	 DsJOFf0uRZEqm1DelykbRjO27679Jd/mDMrq7TzRFyQRmJqJrVUSbPaUtyUTLKtAHU
	 MDOJYFqvDwjSX/CXBEDDrZk+49QvrBG8a3IWykUW40xdgignRkZgQrd7qOk1Toq+m/
	 iyE8kPZsg7u7A==
Date: Tue, 12 May 2026 08:47:50 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Chen Jun <chenjun102@huawei.com>
Cc: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] trace: Introduce a new filter_pred "caller"
Message-Id: <20260512084750.c17a93d0ccdacddfd52d3d40@kernel.org>
In-Reply-To: <20260508122623.74290-1-chenjun102@huawei.com>
References: <20260508122623.74290-1-chenjun102@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 May 2026 20:26:23 +0800
Chen Jun <chenjun102@huawei.com> wrote:

> Low-level functions have many call paths, and sometimes
> we only care about the calls on a specific call path.
> Add a new filter to filter based on the call stack.
> 
> Usage:
> 1. echo 'caller=="$function_name"' > events/../filter

Thanks for interesting idea :)

BTW, we already have "stacktrace". Since this actually checks
stacktrace, not caller, so I think we should reuse it.
Also, I think OP_GLOB is more suitable for this case.
(and more useful)

Thank you,

> 
> Only support OP_EQ and OP_NE
> 
> Signed-off-by: Chen Jun <chenjun102@huawei.com>
> ---
>  include/linux/trace_events.h       |  1 +
>  kernel/trace/trace.h               |  3 ++-
>  kernel/trace/trace_events.c        |  1 +
>  kernel/trace/trace_events_filter.c | 40 ++++++++++++++++++++++++++++--
>  4 files changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 40a43a4c7caf..1f109669a391 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -851,6 +851,7 @@ enum {
>  	FILTER_COMM,
>  	FILTER_CPU,
>  	FILTER_STACKTRACE,
> +	FILTER_CALLER,
>  };
>  
>  extern int trace_event_raw_init(struct trace_event_call *call);
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 80fe152af1dd..4e4b92ce264f 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1825,7 +1825,8 @@ static inline bool is_string_field(struct ftrace_event_field *field)
>  	       field->filter_type == FILTER_RDYN_STRING ||
>  	       field->filter_type == FILTER_STATIC_STRING ||
>  	       field->filter_type == FILTER_PTR_STRING ||
> -	       field->filter_type == FILTER_COMM;
> +	       field->filter_type == FILTER_COMM ||
> +	       field->filter_type == FILTER_CALLER;
>  }
>  
>  static inline bool is_function_field(struct ftrace_event_field *field)
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index c46e623e7e0d..6d220d7eec73 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -199,6 +199,7 @@ static int trace_define_generic_fields(void)
>  	__generic_field(char *, comm, FILTER_COMM);
>  	__generic_field(char *, stacktrace, FILTER_STACKTRACE);
>  	__generic_field(char *, STACKTRACE, FILTER_STACKTRACE);
> +	__generic_field(char *, caller, FILTER_CALLER);
>  
>  	return ret;
>  }
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 609325f57942..1cf040065abe 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -72,6 +72,7 @@ enum filter_pred_fn {
>  	FILTER_PRED_FN_CPUMASK,
>  	FILTER_PRED_FN_CPUMASK_CPU,
>  	FILTER_PRED_FN_FUNCTION,
> +	FILTER_PRED_FN_CALLER,
>  	FILTER_PRED_FN_,
>  	FILTER_PRED_TEST_VISITED,
>  };
> @@ -1009,6 +1010,21 @@ static int filter_pred_function(struct filter_pred *pred, void *event)
>  	return pred->op == OP_EQ ? ret : !ret;
>  }
>  
> +/* Filter predicate for caller. */
> +static int filter_pred_caller(struct filter_pred *pred, void *event)
> +{
> +	unsigned long entries[32];
> +	unsigned int nr_entries;
> +	int i;
> +
> +	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
> +	for (i = 0; i < nr_entries ; i++)
> +		if (pred->val <= entries[i] && entries[i] < pred->val2)
> +			return !pred->not;
> +
> +	return pred->not;
> +}
> +
>  /*
>   * regex_match_foo - Basic regex callbacks
>   *
> @@ -1617,6 +1633,8 @@ static int filter_pred_fn_call(struct filter_pred *pred, void *event)
>  		return filter_pred_cpumask_cpu(pred, event);
>  	case FILTER_PRED_FN_FUNCTION:
>  		return filter_pred_function(pred, event);
> +	case FILTER_PRED_FN_CALLER:
> +		return filter_pred_caller(pred, event);
>  	case FILTER_PRED_TEST_VISITED:
>  		return test_pred_visited_fn(pred, event);
>  	default:
> @@ -2002,10 +2020,28 @@ static int parse_pred(const char *str, void *data,
>  
>  		} else if (field->filter_type == FILTER_DYN_STRING) {
>  			pred->fn_num = FILTER_PRED_FN_STRLOC;
> -		} else if (field->filter_type == FILTER_RDYN_STRING)
> +		} else if (field->filter_type == FILTER_RDYN_STRING) {
>  			pred->fn_num = FILTER_PRED_FN_STRRELLOC;
> -		else {
> +		} else if (field->filter_type == FILTER_CALLER) {
> +			unsigned long caller;
> +
> +			if (op == OP_GLOB)
> +				goto err_free;
>  
> +			pred->fn_num = FILTER_PRED_FN_CALLER;
> +			caller = kallsyms_lookup_name(pred->regex->pattern);
> +			if (!caller) {
> +				parse_error(pe, FILT_ERR_NO_FUNCTION, pos + i);
> +				goto err_free;
> +			}
> +			/* Now find the function start and end address */
> +			if (!kallsyms_lookup_size_offset(caller, &size, &offset)) {
> +				parse_error(pe, FILT_ERR_NO_FUNCTION, pos + i);
> +				goto err_free;
> +			}
> +			pred->val = caller - offset;
> +			pred->val2 = pred->val + size;
> +		} else {
>  			if (!ustring_per_cpu) {
>  				/* Once allocated, keep it around for good */
>  				ustring_per_cpu = alloc_percpu(struct ustring_buffer);
> -- 
> 2.22.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
