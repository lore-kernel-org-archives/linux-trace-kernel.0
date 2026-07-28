Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEA04279E9;
	Tue, 28 Jul 2026 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243514; cv=none; b=btWxiSZBeGnr4mxqmvk3lVKj45W2+4sslf/jyrM8GgER4u2PD3M2vNMlZjpFsjIcki427fmjUnl3jJLBvMzJMxqZh02M8JdseqPMWaH8mZ2jCJnAMGePmwrZVN3b+PDJm+w6i9EmWwhQs+iUFSSWQ/WsB5XJlWOqVvzkhiPfUds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243514; c=relaxed/simple;
	bh=iM5zPdKoP4R2a4bIeAg9U2JW7uEG0VarSVcZuUfwBD4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=F9KUbV/FOviYjJcgDHG67vBORRoR6OrDKvs5IFdZVsDVedi0g2VxR9R9bdKIhUNi6rqmx8VLGy3aWAMOdTI5skYrFwZfvY8aTFFiDftdOb1dmzMC4KxjvmoRzyXHlJxI6rRcIDfit2HkwsGR7dTaDliGTXCeSq0HpCYSJI5xMB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2mvFaHR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2mvFaHR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5691F00AC4;
	Tue, 28 Jul 2026 12:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785243512;
	bh=Q3+5PLC6tuiR15k7Ir1miK99OsvsI6f+wZcxr7t+LYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=l2mvFaHRJs865B7pMSUiBOmrM2AzV8ln1/PWvJoJwtl0mGNvqcX65rQFKQwI1MnjY
	 ADMked79QJnuVW56zKrfTnZih/lRnJUt1OLs4JW/bugtfOWoNKxQbO25OLYPxZjk5p
	 EKqPs379vuvR6F2ioMTfJ6XzbcM9dl4XOL6o1Ju7hA9vYeEy03Ga1mWhKMUcASrT7E
	 JTzs+fA07xtYwrEFwOncw6iRGXbTZslYDd96/p+iopgWEhe14SPTVH6ue8AqmLRvGX
	 kDSfZtgYZkAz7dUjo7B1XkSMMvJQDbOLni0nZtlMLjipduELfoeJMfRRkxAJTohTIh
	 w3hz1uYOAwNzg==
Date: Tue, 28 Jul 2026 21:58:29 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Raushan Patel <raushan.jhon@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/probes: Reject $arg0 in meta argument expansion
Message-Id: <20260728215829.42b08c74e29665f295f1fdc7@kernel.org>
In-Reply-To: <20260724054435.146279-1-raushan.jhon@gmail.com>
References: <20260724054435.146279-1-raushan.jhon@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 11:14:35 +0530
Raushan Patel <raushan.jhon@gmail.com> wrote:

> traceprobe_expand_meta_args() parses $argN with simple_strtoul() and
> calls sprint_nth_btf_arg(n - 1, ...). For $arg0, n is 0 so the index is
> -1. Because ctx->nr_params is signed, the "idx >= nr_params" guard in
> sprint_nth_btf_arg() does not catch the negative index, and
> ctx->params[-1].name_off is read out of bounds.
> 
> The normal per-argument path (parse_probe_vars()) already rejects
> $arg0 via its argument-number check, but meta-argument expansion runs
> before per-argument parsing and substitutes the value first, bypassing
> that check.
> 
> Reject $arg0 explicitly during expansion.

Good catch! Let me pick this.

Thanks!

> 
> Fixes: 18b1e870a496 ("tracing/probes: Add $arg* meta argument for all function args")
> Signed-off-by: Raushan Patel <raushan.jhon@gmail.com>
> ---
>  kernel/trace/trace_probe.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 506e6037e163..c8fd9b946f44 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -1901,7 +1901,11 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
>  				trace_probe_log_err(0, BAD_VAR);
>  				return ERR_PTR(-ENOENT);
>  			}
> -			/* Note: $argN starts from $arg1 */
> +			/* Note: $argN starts from $arg1, so $arg0 is invalid. */
> +			if (n == 0) {
> +				trace_probe_log_err(0, BAD_ARG_NUM);
> +				return ERR_PTR(-EINVAL);
> +			}
>  			ret = sprint_nth_btf_arg(n - 1, type, buf + used,
>  						 bufsize - used, ctx);
>  			if (ret < 0)
> -- 
> 2.53.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
