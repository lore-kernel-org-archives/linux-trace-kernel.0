Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A5025B088;
	Thu,  2 Jul 2026 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782978535; cv=none; b=IEkTJVRGOCvsfTaieLBNz+7N1aMMH1Od9KrWDZ502BiYIFpbElGDxTvz7BXgBxJhAE8K3QbwTjshyhSMZzqIwDY76BIffJHPu0VvRTL3c+wTYpDUnHpMAv8AAr4Fq47j7cR4DB4zuAAqAarnWR45Bl11uvnIuMm/WiCric+C5s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782978535; c=relaxed/simple;
	bh=FOhHDrhAGtqGi6SiFFULoi0RHohTZfRQlCes+7Hgnoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7WPAVgCdSbtnmguv7ldFpTsTgndJmHvokTacoNKV00Hpd5Hbagvoe1wgsNGeET2QBLeGntd9XPF+9pUOoAv4k+3bQYtotMESMW15baCR3RgiBkZjbw4dgGYx7jKdqg66VbkbXvtJ7Qrc+dPYn/vWb3fJ5z8yRH8FTSTY+F8Xt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-209-184-216.092.209.pools.vodafone-ip.de ([92.209.184.216] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wfCA8-00000000Vzh-1J0G;
	Thu, 02 Jul 2026 09:48:44 +0200
Date: Thu, 2 Jul 2026 09:48:43 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] tracing: Warn when an event dereferences a pointer in
 TP_printk()
Message-ID: <akYX24lCKpXcnAyn@nb282.user.codasip.com>
References: <20260630184836.74d477b6@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630184836.74d477b6@gandalf.local.home>

Thus wrote Steven Rostedt (rostedt@goodmis.org):

> From: Steven Rostedt <rostedt@goodmis.org>

> Currently on boot up and when modules are loaded, the trace event
> infrastructure will examine the TP_printk's of every event looking to see
> if it dereferences pointers on the ring buffer via printk formats like
> "%pB" and such. What it doesn't do is check if the arguments themselves
> do a dereference from a pointer.

> This was brought with a fix[1] to the fsl_edma event that had in the
> arguments of the TP_printk(): "__entry->edma->membase"

> The __entry->edma is a pointer saved in the ring buffer. The dereference
> from TP_printk() happens when the user reads the "trace" file which can be
> seconds, minutes, hours, days, weeks, or even months later! There is no
> guarantee that the __entry->edma pointer will still be pointing to what it
> was when it was recorded, and could crash the kernel when a user reads the
> event.

> Add logic to the test_event_printk() that also checks for this case and
> warn if the event dereferences a pointer from the ring buffer.

> [1] https://lore.kernel.org/all/20260630200022.1826420-1-martin@kaiser.cx/

> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events.c | 35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)

> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index c46e623e7e0d..3b52bfd8b300 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -400,6 +400,31 @@ static bool process_string(const char *fmt, int len, struct trace_event_call *ca
>  	return true;
>  }

> +static void test_double_dereference(const char *str, int len,
> +				    struct trace_event_call *call)
> +{
> +	const char *ptr;
> +	const char *end = str + len;
> +
> +	ptr = strstr(str, "REC->");
> +
> +	while (ptr && ptr < end) {
> +
> +		ptr += 5;
> +		for (; ptr < end; ptr++) {
> +			if (ptr[0] == '-' && ptr[1] == '>') {
> +				WARN_ONCE(1, "Event %s has double dereference in TP_printk: %.*s\n",
> +					  trace_event_name(call), len, str);
> +				return;
> +			}
> +			if (!isalnum(*ptr) && *ptr != '_')
> +				break;
> +		}
> +
> +		ptr = strstr(ptr, "REC->");
> +	}
> +}
> +
>  static void handle_dereference_arg(const char *arg_str, u64 string_flags, int len,
>  				   u64 *dereference_flags, int arg,
>  				   struct trace_event_call *call)
> @@ -459,12 +484,6 @@ static void test_event_printk(struct trace_event_call *call)
>  				if (in_quote) {
>  					arg = 0;
>  					first = false;
> -					/*
> -					 * If there was no %p* uses
> -					 * the fmt is OK.
> -					 */
> -					if (!dereference_flags)
> -						return;
>  				}
>  			}
>  			if (in_quote) {
> @@ -576,6 +595,8 @@ static void test_event_printk(struct trace_event_call *call)
>  				continue;
>  			}

> +			test_double_dereference(fmt + start_arg, e - start_arg, call);
> +
>  			if (dereference_flags & (1ULL << arg)) {
>  				handle_dereference_arg(fmt + start_arg, string_flags,
>  						       e - start_arg,
> @@ -589,6 +610,8 @@ static void test_event_printk(struct trace_event_call *call)
>  		}
>  	}

> +	test_double_dereference(fmt + start_arg, i - start_arg, call);
> +
>  	if (dereference_flags & (1ULL << arg)) {
>  		handle_dereference_arg(fmt + start_arg, string_flags,
>  				       i - start_arg,
> -- 
> 2.53.0

Looks good to me.

Reviewed-by: Martin Kaiser <martin@kaiser.cx>
