Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A7A2EC579;
	Wed, 19 Nov 2025 04:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763527186; cv=none; b=JoMqx/uL6j+Z98zMINh0G1YC5mdpNuC0Vwc9P2A3iKRsOxsZrnP3Quk1SL2bEf9HJjC8+wrwiLzYhEKqM/SrjdSazQ9Lh8hHKiSV+fiybIqCE1Ypi+uBYWvIIGa4FOLMDlCIA+k1IquwntUbfzvMpoRbAZQb9Q1Ei6udiG75HlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763527186; c=relaxed/simple;
	bh=F7PZ4FylT5YnNNHctX3Myb5uINv5rlM/kT2rCgW+LWQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uBlOPFy5FJb6+iUcAt7RnJSqrSnReepavZQ7n1AmxsclDSEB/i02uBwqMnC8Yd7uIbb7UnHQwRsCs17WEtbjprfCfmAqf77TCGmQIk64lSzHHh73uG8GIBCGayBaBFCRsWk1JVoQyrLgzMAwtyrGm7VpWvZ5V3lfxINJ2RChGDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rW5crypM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rW5crypM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86883C2BCB3;
	Wed, 19 Nov 2025 04:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763527185;
	bh=F7PZ4FylT5YnNNHctX3Myb5uINv5rlM/kT2rCgW+LWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rW5crypMqzNkwnfX+qWJX58J0zPOapbjX82FnRy1Hr5W2i7OvNZd4H3a1y6lzHHx2
	 uYTpG2y/oi0rUDi1+PaWikynvUi6Eqgomcsn6S4p5GLZbgPWdrg1+F8vW8tB6AsZ3X
	 CwtUqPnBy7WUDxwt6jzml0Z/F8XSPxh9GEDCkbup95fil9C5xQT/9VVfUFM5+S3s98
	 pPK0MDeHa1PSWHwv2ToqHyVn9LQi2uiIEnZmhwTbaclab7k81yGrM5SzAEZ1NkvraW
	 1d9+kOJ4ddo9tE7QYuPdYldpZci94ChOkIDqL1UiQN79nms0Y3FQc8MoIHrP2sBBiW
	 U/BPNehXI5VmQ==
Date: Wed, 19 Nov 2025 13:39:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Show the tracer options in boot-time
 created instance
Message-Id: <20251119133942.df3ee2c01ccd40055cf139a4@kernel.org>
In-Reply-To: <176351169375.1795430.7653862896005389480.stgit@mhiramat.tok.corp.google.com>
References: <176351169375.1795430.7653862896005389480.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 09:21:34 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since tracer_init_tracefs_work_func() only updates the tracer options
> for the global_trace, the instances created by the kernel cmdline
> do not have those options.
> 
> Fix to update tracer options for those boot-time created instances
> to show those options.
> 

Wait, this seems not updating the global instance. Let me fix it.
(ftracetest found it.)

Thanks,

> Fixes: 428add559b69 ("tracing: Have tracer option be instance specific")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>   Change in v2:
>    - Fix update_tracer_options() to update all instances.
>    - Update tracer_options_updated after update all instances.
> ---
>  kernel/trace/trace.c |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 8ae95800592d..4a6784057855 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -10231,11 +10231,16 @@ static __init int __update_tracer_options(struct trace_array *tr)
>  	return ret;
>  }
>  
> -static __init void update_tracer_options(struct trace_array *tr)
> +static __init void update_tracer_options(void)
>  {
> +	struct trace_array *tr;
> +
>  	guard(mutex)(&trace_types_lock);
> +
> +	list_for_each_entry(tr, &ftrace_trace_arrays, list)
> +		__update_tracer_options(tr);
> +
>  	tracer_options_updated = true;
> -	__update_tracer_options(tr);
>  }
>  
>  /* Must have trace_types_lock held */
> @@ -10937,7 +10942,7 @@ static __init void tracer_init_tracefs_work_func(struct work_struct *work)
>  
>  	create_trace_instances(NULL);
>  
> -	update_tracer_options(&global_trace);
> +	update_tracer_options();
>  }
>  
>  static __init int tracer_init_tracefs(void)
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
