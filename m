Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FBF29BDB1;
	Sun,  8 Feb 2026 04:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770523613; cv=none; b=PHVgNQMVku4mPyIwjrOm3+13rZoJdVOkIS3BBBdja2rHbAVDXCI3vmMrXeEDsJRTAqct9ED2hwBMMRa68ffrvJHjuUfQADAUPrWlP5Ir80VIx54jTiefawDcivN5+QaVSAL6wQbxfpv8COhG7BsxD3NRPY5DMgpFVZIo44qHK5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770523613; c=relaxed/simple;
	bh=odEFp6GXFd8PcnwfIT3lfuGNLtu1TPQoTdTum/sVtto=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ubekp0yhv84BlKxvnrc6cGHWgEsjcqdPQq61BAvEEzhYC3FLoe0WpljtZNyYvQ3dIpWjZRBULSeMLqz7RvBuDW6t7XPyBtzGZU+ET/P351Gh0uJEscAxXKZ2s4t/2E1ovXs7zBBCFGvp8HYmCIN3EqMdevMo71mLTB4RizU4/0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mxr1567k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mxr1567k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DD0C4CEF7;
	Sun,  8 Feb 2026 04:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770523613;
	bh=odEFp6GXFd8PcnwfIT3lfuGNLtu1TPQoTdTum/sVtto=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mxr1567kZNDaZZIytanfElpxZpjpRIMx8tWw6fMhBr1+bwOQsM20G/dqiYPbSna61
	 NBUJCqDOUHrW2JAKhochhVp5VZHDhY0QpD8sioosJgy+rgG4UDMJ0dX3CUV/9NcvPf
	 TCyB4mEWjz68Tkyw8ZTFkfuuH3pnahKtFPPzOG8qLLshkMqam+Xrd3k+/OJBKsndin
	 gKLyqp21Sdx5q7Paa+9+lzghF2ZboOgK3hYa+4Wjcq6vPrHb10VmTUtSIDCiOdxMzH
	 cfR6An1jIfuHSu15buT6slri//NmWKkXyBLQFlxIqVxWGAjaS3OgleWXAoPEoOk69h
	 QP/RiQjVP5V+Q==
Date: Sun, 8 Feb 2026 13:06:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2] tracing: Clean up use of trace_create_maxlat_file()
Message-Id: <20260208130648.79d3d2ea89a46a8625736fbc@kernel.org>
In-Reply-To: <20260206230410.4ed96e9f@robin>
References: <20260206230410.4ed96e9f@robin>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Feb 2026 23:04:10 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> In trace.c, the function trace_create_maxlat_file() is defined behind the
>  #ifdef CONFIG_TRACER_MAX_TRACE block. The #else part defines it as:
> 
>  #define trace_create_maxlat_file(tr, d_tracer)				\
> 	trace_create_file("tracing_max_latency", TRACE_MODE_WRITE,	\
> 			  d_tracer, tr, &tracing_max_lat_fops)
> 
> But the one place that it it used has:
> 
>  #ifdef CONFIG_TRACER_MAX_TRACE
> 	trace_create_maxlat_file(tr, d_tracer);
>  #endif
> 
> Which is pointless.
> 
> Define trace_create_maxlat_file() when CONFIG_TRACER_MAX_TRACE is not
> defined as:
> 
>  static inline void trace_create_maxlat_file(struct trace_array *tr,
> 				     struct dentry *d_tracer) { }
> 
> And remove the #ifdef's from the code.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,


> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://patch.msgid.link/20260206121242.6cb1934d@gandalf.local.home
> 
> - Fix stub function missing from !CONFIG_TRACER_MAX_TRACE
> 
>  kernel/trace/trace.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 6815df23e5a3..b59c237f463c 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1969,11 +1969,8 @@ void latency_fsnotify(struct trace_array *tr)
>  }
>  
>  #else /* !LATENCY_FS_NOTIFY */
> -
> -#define trace_create_maxlat_file(tr, d_tracer)				\
> -	trace_create_file("tracing_max_latency", TRACE_MODE_WRITE,	\
> -			  d_tracer, tr, &tracing_max_lat_fops)
> -
> +static inline void trace_create_maxlat_file(struct trace_array *tr,
> +					    struct dentry *d_tracer) { }
>  #endif
>  
>  /*
> @@ -2109,7 +2106,9 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
>  	__update_max_tr(tr, tsk, cpu);
>  	arch_spin_unlock(&tr->max_lock);
>  }
> -
> +#else
> +static inline void trace_create_maxlat_file(struct trace_array *tr,
> +					    struct dentry *d_tracer) { }
>  #endif /* CONFIG_TRACER_MAX_TRACE */
>  
>  struct pipe_wait {
> @@ -10684,9 +10683,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
>  
>  	create_trace_options_dir(tr);
>  
> -#ifdef CONFIG_TRACER_MAX_TRACE
>  	trace_create_maxlat_file(tr, d_tracer);
> -#endif
>  
>  	if (ftrace_create_function_files(tr, d_tracer))
>  		MEM_FAIL(1, "Could not allocate function filter files");
> -- 
> 2.51.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
