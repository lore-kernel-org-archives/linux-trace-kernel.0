Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F4623957D;
	Tue, 13 Jan 2026 00:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768264264; cv=none; b=fp5KN8JvoMAOO1uxx+dbxghFhfZr3NVfABy46CwcQoyuM1EaLsNHOlAil5FwHjFxeDeyVdO231jpoDVYTX2YFQ7/7TNS8Va0yGabbX2EAxOqmg2FNyXIAAVYAIwx1CeRnVWecIgBGALOISOuISt9EvEvTVALrp4Zl5lw1T3NSZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768264264; c=relaxed/simple;
	bh=Xevtm1WOm9kyWXgohDFOUCvL20aHqTvicjIWscU/byo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qxqzkioaf78RQrld77XGVoCHuVLupIDDA/v8sogHDdfMZuNhi+Vgse/CuDmjwPpeQOQiaOpgNzA32Vq0kLZyFnvhbko9EJ/AlFwVyugaACJOWSm6yKT8nR8PpgxJhHLolxHGV0o3ffjaXYB126R9/0PGoV2vdZ8a4DVm/OIYWJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rl1uzUoZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rl1uzUoZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10FAC116D0;
	Tue, 13 Jan 2026 00:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768264264;
	bh=Xevtm1WOm9kyWXgohDFOUCvL20aHqTvicjIWscU/byo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rl1uzUoZpyM2H95cXB/Hg7BpKEE9QBFrws+zWKs4tOVXebju0HPeUme1Pv6D4LiXz
	 YpSzAiBHGyHzlqoZ3DRAp2RkKgKSyjFPzmBwDMuSDGyLF1646gJS4n/JbEiwpKj9CQ
	 YlH9PkqO82U7IyhrgEaaAkMTKnzn4vl+beMjOFhfhYFwP3xpQ5dOXRgX0T9j2AyHOY
	 dP0dyEOgl33uEKVf4IpMApJNybEJsahTeoIqu7Y1+2XWO/Wj5lU+2gHgjxiH1tB5H+
	 kwyE1dZWo1JjTEgZwwZREVRCOdkzy8jjbof3JC/3g4/gKlDmOaiW+ouZKHsGNUyOmC
	 nhiWjNHkqIUuw==
Date: Tue, 13 Jan 2026 09:31:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing: Make the backup instance readonly
Message-Id: <20260113093100.e91c5be8b8fa5f1e64899ba4@kernel.org>
In-Reply-To: <176788218294.1398317.13118277798168167277.stgit@mhiramat.tok.corp.google.com>
References: <176788217131.1398317.11144318616426272901.stgit@mhiramat.tok.corp.google.com>
	<176788218294.1398317.13118277798168167277.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Jan 2026 23:23:03 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 9b07ad9eb284..741b16b54d90 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -1379,6 +1379,9 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
>  {
>  	int ret;
>  
> +	if (trace_array_is_readonly(tr))
> +		return -EPERM;
> +
>  	mutex_lock(&event_mutex);
>  	ret = __ftrace_set_clr_event_nolock(tr, match, sub, event, set, mod);
>  	mutex_unlock(&event_mutex);
> @@ -2817,8 +2820,8 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
>  	} else
>  		__get_system(system);
>  
> -	/* ftrace only has directories no files */
> -	if (strcmp(name, "ftrace") == 0)
> +	/* ftrace only has directories no files, readonly instance too. */
> +	if (strcmp(name, "ftrace") == 0 || trace_array_is_readonly(tr))
>  		nr_entries = 0;
>  	else
>  		nr_entries = ARRAY_SIZE(system_entries);
> @@ -2979,7 +2982,6 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
>  	struct eventfs_inode *e_events;
>  	struct eventfs_inode *ei;
>  	const char *name;
> -	int nr_entries;
>  	int ret;
>  	static struct eventfs_entry event_entries[] = {
>  		{
> @@ -3024,6 +3026,18 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
>  		},
>  #endif
>  	};
> +	static struct eventfs_entry event_ro_entries[] = {
> +		{
> +			.name		= "format",
> +			.callback	= event_callback,
> +		},
> +#ifdef CONFIG_PERF_EVENTS
> +		{
> +			.name		= "id",
> +			.callback	= event_callback,
> +		},
> +#endif
> +	};

Thinking about this hack again, it would be easier to maintain if I add
a readonly flag to each eventfs_entry and specify readonly when creating
the eventfs top directory.

Let me update it.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
