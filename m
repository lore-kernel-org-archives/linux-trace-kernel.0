Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38271D9346;
	Mon,  7 Oct 2024 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315815; cv=none; b=liekrJS5GYxzva7oakumyXnpTQtLl4BYojixjQIA/7vwtPZk3CyTQxXCBnrnhz6fVJqLtoC+V0nR3OSc+0f+p8MQhDN4UCw+Jmdr94k7XvGrSYz1Yez6Nzstbc88i8HSODYXfXoYc96FCkULVZdc3OAc31iOu60vytVcQkMF35E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315815; c=relaxed/simple;
	bh=KHZXUCJ/dfxjhdpsw5L89Ayz+wGYgssrZ771K4ZzgoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HawtfM7zvAKMKnD8F+JvZv0Dma8KrF2UUHcHMJz+bSIjzFNxC+F/Xk0ntsWI+4i6dOj/dhofaD4XdufFDs9DvEYIcJ/Cu0inJouf+qto3HMjLXb8ZuV+r55R0G4T4zhvPl2HX8KUgWSkdRfcM4HFEIAmuA7e0koh72Zj2kBt+Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DE9C4CEC6;
	Mon,  7 Oct 2024 15:43:33 +0000 (UTC)
Date: Mon, 7 Oct 2024 11:43:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Dave.Martin@arm.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Consider the NULL character when validating
 the event length
Message-ID: <20241007114333.73f008d1@gandalf.local.home>
In-Reply-To: <20241007144724.920954-1-leo.yan@arm.com>
References: <20241007144724.920954-1-leo.yan@arm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Oct 2024 15:47:24 +0100
Leo Yan <leo.yan@arm.com> wrote:

> strlen() returns a string length excluding the null byte. If the string
> length equals to the maximum buffer length, the buffer will have no
> space for the NULL terminating character.
> 
> This commit checks this condition and returns failure for it.
> 
> Fixes: dec65d79fd26 ("tracing/probe: Check event name length correctly")
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Masami, want to take this?

-- Steve

> ---
> 
> Changes from v1:
> Refined for condition checking (Steve).
> 
>  kernel/trace/trace_probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 39877c80d6cb..16a5e368e7b7 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -276,7 +276,7 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
>  		}
>  		trace_probe_log_err(offset, NO_EVENT_NAME);
>  		return -EINVAL;
> -	} else if (len > MAX_EVENT_NAME_LEN) {
> +	} else if (len >= MAX_EVENT_NAME_LEN) {
>  		trace_probe_log_err(offset, EVENT_TOO_LONG);
>  		return -EINVAL;
>  	}

