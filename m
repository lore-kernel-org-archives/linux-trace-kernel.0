Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5B03EDE72;
	Tue, 12 May 2026 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614920; cv=none; b=XW1qx9XOZV1mkdgm3W24sHPI2hD+VYdpvUYmTcFXAf5wod18CJ8Pud8BxFO3PPdAg3np6TfauMFjnhZer+XABj6VJegchzKnTHaB4RDSvk44E9/Cfs/oBtSHT5sYcmX32ecxIFaaCmNKF0lLgCx5S55YN6O4buSuJyz4ChQVDGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614920; c=relaxed/simple;
	bh=F1DPUJmm//uklJmKu5jPl7hBQKySeKz+lX+QKCZ24Do=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YiAKS0UI3qnns8cdftfzl7ACDWYvZxFAb575V3iqkZIg7O2FBC2uXXu6+/QUAZ6CB7CfbHE3lkBxm+stbGVhDn6he2r37rE+cPhJLG/rd7IFNfLO99u/l7+vDLbFa6FDZqXTUq+jptKkI3Xo99rwjQ4sjvbmw8DZSI4qpYl3hYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id BF2E6C2140;
	Tue, 12 May 2026 19:41:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id F27A81B;
	Tue, 12 May 2026 19:41:55 +0000 (UTC)
Date: Tue, 12 May 2026 15:41:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Chen Jun <chenjun102@huawei.com>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] trace: Introduce a new filter_pred "caller"
Message-ID: <20260512154155.5221d029@gandalf.local.home>
In-Reply-To: <20260508122623.74290-1-chenjun102@huawei.com>
References: <20260508122623.74290-1-chenjun102@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F27A81B
X-Rspamd-Server: rspamout06
X-Stat-Signature: smsofx4j6eijeeqjdqhat713miuhjpsq
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+0rj7aDsoQXUwD3wDijc6YOFgHLBtFQug=
X-HE-Tag: 1778614915-419686
X-HE-Meta: U2FsdGVkX19dW6JPDgvhjsWGHog4Ep5ifcdb14e5mPcvKYBUufZMBQo39TY1JrBk0fqdAQRQsqDJ8XBgtsuXN5EpTi0Iw9bLfHRQCVB95qfcLIsfCz/WbKCRdMo8rRMi11ejCm9pucP7uostSZS7q5Jniraa9n89hvYt3CkF7+JjY0stxlpafCCOHLDcl6qzOLwdwg/3EszkvNt1JbTQpiYUTjRwZpQ8M3VXeEEe6KaVuI4ySdMjzkaZeOmveml+Bhj2fakRjs9M2G0sxpscY0yF5fRCSuNVZm7GPWzlFxIe2kkPhifNAdpfmT271I2HwMlKmNKzblQO+ojw7GYdt45geLKPuphWWvOfwt9RpdSAgWTr5TgemA==

On Fri, 8 May 2026 20:26:23 +0800
Chen Jun <chenjun102@huawei.com> wrote:

> Low-level functions have many call paths, and sometimes
> we only care about the calls on a specific call path.
> Add a new filter to filter based on the call stack.
> 
> Usage:
> 1. echo 'caller=="$function_name"' > events/../filter
> 
> Only support OP_EQ and OP_NE

Cute.

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

Let's make that only 16 in size. Having 256 bytes added to the stack in
random places may cause an overflow. 128 bytes isn't as bad. Either that,
or we need to preallocate per-cpu memory and use that. But that makes the
patch much more complex. I rather just use 16 entries instead for now. If
we need more, then we can add the extra complexity.

Also, you need to update Documentation/trace/events.rst.

Thanks,

-- Steve


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

