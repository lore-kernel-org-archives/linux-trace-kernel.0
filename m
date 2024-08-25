Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DFA17C64
	for <linux-trace-kernel@vger.kernel.org>; Sun, 25 Aug 2024 07:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724571696; cv=none; b=blmr5wDB1koudAnKPUJsDe9Z6i+y9qrtFoj5C8gjh32r8FdoBAEkRxsp2rLqvtlia+5hpi8iacBSbUSlFOUV8EmWKlR2LHaDBUzoo8GNIj4wJDi+dUBgqY5b9Iol/B9/YBCahbdRnS3qvTG6auq5RSJ+Ylv0TxcgZPDJHKSmo9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724571696; c=relaxed/simple;
	bh=Qd8FROBJ+CX3NCyhnriOq97GJhCduOVocYHAoOQ4dgI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MGVjGBG3UsvbELJRpHo+AdGwH6QJh6Aaynuy/zQefZJrUcG3mZSl4kaLioxKLe3imb+ILJi4hmT9t7GdVf5u+UXRN36KH8/smZSmPceYVQ8KhSFS1u0r50cx4bXFIzFEG1qTlAcv+O0BiyjYGkXIgNv01kjUkCZVE0mLFWRinQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5/yOVwe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5/yOVwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895E6C32782;
	Sun, 25 Aug 2024 07:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724571695;
	bh=Qd8FROBJ+CX3NCyhnriOq97GJhCduOVocYHAoOQ4dgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C5/yOVwea4SnuIeQtRfXzViNmI49MKnq6mKiDDG7nIknANuuLQvOGNXUGWEDd8ZTu
	 fVmo7tnSgk6EXWIK8GtXiYpiTUX1TdfnxQuSpRV2EwIQnAYF+RK4uyzNf91+F/7SLl
	 cot4MYLhfJGYFaTHTjvjYgwW6hUy/I9MqEj84WRwSVR+E9bWqBSHy/gJH+0mOP95dD
	 obSDFwFV3svHgq0YGe5zaS7FtEDWAg+PoKk8OM46nb1OmPNjP1EsmwSJqtDwf8G9aY
	 7F8OiM4TZ2xBDqKCJhT5TDh7MMxAYSfGWm+bQuEdH5EtUBs9grxIChdVGAwgQSMbkO
	 hal+K6cFxAYHg==
Date: Sun, 25 Aug 2024 16:41:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/probes: fix traceprobe out-of-bounds argument
 allocation
Message-Id: <20240825164132.024faee7897e0ac126d8c58e@kernel.org>
In-Reply-To: <20240813172546.3151-1-ffmancera@riseup.net>
References: <20240813172546.3151-1-ffmancera@riseup.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Tue, 13 Aug 2024 13:25:40 -0400
Fernando Fernandez Mancera <ffmancera@riseup.net> wrote:

> When initializing trace_probes::nr_args, make sure the maximum number of
> probe arguments is honored. Oherwise, we can hit a NULL pointer
> dereferences in multiple situations like on traceprobe_set_print_fmt().
> 
> Link: https://bugzilla.redhat.com/2303876

Sorry for replying later. I'm not sure why but I did not found this in my mbox...

Anyway, trace_probe_init() should return -E2BIG in this case because
it is actuall wrong value.

Can you update your patch?

Thank you,


> 
> Fixes: 035ba76014c0 ("tracing/probes: cleanup: Set trace_probe::nr_args at trace_probe_init")
> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
> ---
>  kernel/trace/trace_probe.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 39877c80d6cb..f577b5e71026 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -2043,10 +2043,14 @@ int trace_probe_init(struct trace_probe *tp, const char *event,
>  		goto error;
>  	}
>  
> -	tp->nr_args = nargs;
> +	if (nargs > MAX_TRACE_ARGS)
> +		tp->nr_args = MAX_TRACE_ARGS;
> +	else
> +		tp->nr_args = nargs;
> +
>  	/* Make sure pointers in args[] are NULL */
>  	if (nargs)
> -		memset(tp->args, 0, sizeof(tp->args[0]) * nargs);
> +		memset(tp->args, 0, sizeof(tp->args[0]) * tp->nr_args);
>  
>  	return 0;
>  


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
