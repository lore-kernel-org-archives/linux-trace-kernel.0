Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFEEEC5;
	Tue, 11 Feb 2025 00:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739232828; cv=none; b=dd57JpASqTvuZD+Vi8aryw+CQIV7sy5fuR12DjSzzeOq3rfFqNYW91WeqklVacvklrWSNcNkwObdvEgbDygP+Fv4a2ElDkfT+MjkgMYnyAj9LjU/1Z7lIqcYLUnpbYKHbnUeA64Yav8f3of9dl/SjR7+NAcEsgrMTWTZ7VtXTrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739232828; c=relaxed/simple;
	bh=9N2X9agV+TOafFIntwyTURPwUVdB+NYg7pHwb7Rwwfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Itva/pq5XvEED0m1zbD2RVnjVd/ggv2oGJdJBiE1eEvBFqaJn4ob9aQivvs5Het3wd+VQnyYUDCz+QbBUEQeDwoND+NvtXSzKAIwb/EsjS59QTfIDlo2xLVHGo3Y2ASZ1AXWBvJ4WPgbB921zmSH43Ajx6bSAYAR0gxA9IZcw7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3707FC4CED1;
	Tue, 11 Feb 2025 00:13:47 +0000 (UTC)
Date: Mon, 10 Feb 2025 19:13:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Subject: Re: [RFC PATCH v2 3/3] tracing: Freeable reserved ring buffer
Message-ID: <20250210191350.79dfa2a2@gandalf.local.home>
In-Reply-To: <173920225773.826592.6428338529686044470.stgit@devnote2>
References: <173920222697.826592.3726270716809214055.stgit@devnote2>
	<173920225773.826592.6428338529686044470.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 00:44:17 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> @@ -9857,8 +9861,10 @@ static int __remove_instance(struct trace_array *tr)
>  	int i;
>  
>  	/* Reference counter for a newly created trace array = 1. */
> -	if (tr->ref > 1 || (tr->current_trace && tr->trace_ref))
> +	if (tr->ref > 1 || (tr->current_trace && tr->trace_ref)) {
> +		pr_info("Instance is busy: ref %d trace_ref %d\n", tr->ref, tr->trace_ref);

I don't think we need the print. The function will error with -EBUSY
letting the user know that it is busy. This is a very common error, where I
found that I had a program that didn't completely die, and still had a file
descriptor open on an instance, and when I go to remove it, I get:

  # cd /sys/kernel/tracing/
  # mkdir instances/foo
  # bash 5< instances/foo/events/enable
  # rmdir instances/foo
  rmdir: failed to remove 'instances/foo': Device or resource busy
  # exit
  # rmdir instances/foo
  #

If you only have it for debugging that is fine, but we should remove it
before we accept it.

-- Steve

>  		return -EBUSY;
> +	}
>  
>  	list_del(&tr->list);
>  
> @@ -9881,6 +9887,11 @@ static int __remove_instance(struct trace_array *tr)
>  	free_trace_buffers(tr);
>  	clear_tracing_err_log(tr);
>  
> +	if (tr->range_name) {
> +		reserved_mem_release_by_name(tr->range_name);
> +		kfree(tr->range_name);
> +	}
> +
>  	for (i = 0; i < tr->nr_topts; i++) {
>  		kfree(tr->topts[i].topts);
>  	}
> @@ -10740,6 +10751,7 @@ __init static void enable_instances(void)
>  		bool traceoff = false;
>  		char *flag_delim;
>  		char *addr_delim;
> +		char *rname __free(kfree) = NULL;
>  
>  		tok = strsep(&curr_str, ",");
>  
> @@ -10796,6 +10808,7 @@ __init static void enable_instances(void)
>  				pr_warn("Failed to map boot instance %s to %s\n", name, tok);
>  				continue;
>  			}
> +			rname = kstrdup(tok, GFP_KERNEL);
>  		}
>  
>  		if (start) {
> @@ -10832,7 +10845,7 @@ __init static void enable_instances(void)
>  		 */
>  		if (start) {
>  			tr->flags |= TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT;
> -			tr->ref++;
> +			tr->range_name = no_free_ptr(rname);
>  		}
>  
>  		while ((tok = strsep(&curr_str, ","))) {
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 47c0742fe9ec..ae8f7fac6592 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -348,6 +348,7 @@ struct trace_array {
>  	unsigned int		mapped;
>  	unsigned long		range_addr_start;
>  	unsigned long		range_addr_size;
> +	char			*range_name;
>  	long			text_delta;
>  	int			nr_modules;
>  	long			*module_delta;

