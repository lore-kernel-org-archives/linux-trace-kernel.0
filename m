Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8052C6BB;
	Thu, 10 Oct 2024 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573328; cv=none; b=KpF7q0z04CixQqobG/KPQ0YPaa/vgRIpgiVyQ3HNPVmRcwRG552yeNGvewSruskbUlN2xPxzDJwHFIDKTDZ3fr6dleNlatz4Spf5LfqDjghCaZbQfsQb6gJdU0dPKk7nIn/4LhODKqsagOpVLd0JypNzPgZ6Ok0MHlpQWk9WKn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573328; c=relaxed/simple;
	bh=pwem6AnXkFSasb99NiY3aDxV6jRbi25P+ChdAp6soTA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GVRwI/pC2K4rx+OMIg0HNzpRmzNl8yWQyF6PqvPgdbeI043GE/VZO6IuIZxjzgLp3CVcx4c+2qpkt1rVbfsaEQVe4UfXVNrkBYgMTaCg0moOtKStAnM0ppfAAt2bof47LZVpB5k+Y1fvT6iBas4TnjphVv4jinhL6qfWDWh7Z2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uz+AIHdU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uz+AIHdU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88668C4CEC5;
	Thu, 10 Oct 2024 15:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728573327;
	bh=pwem6AnXkFSasb99NiY3aDxV6jRbi25P+ChdAp6soTA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uz+AIHdUgV3L574qp7sQLE/hPCnqi8Ci3oKcL9EcSYI4g+1t5IQNOI5jOX/U/0E53
	 c12ofCBG05EotGdwLEgxPhUo748NnL6wiXFFYNgTL1Gk+S8mXcIdAes/lVk/y0nHPN
	 x7+doXnxD7ilQU0rKqUCDBFt5Unv/68/aOSugYSrT2cVAwghU08Ei+KHAuGAoJUKS4
	 DB51TaepWuRp9Tm0QQFwxlWblylW6xgR5A22I+QX7dCthfm5PldE44CXqz6aBEkk+v
	 IreTfc+17PWHnHqlA7p6dhvi99rfngJ0/gFLU9nv+PqXuC+6SzPrGFqhQexCVI+rxQ
	 3WGGtd5XW1k1Q==
Date: Fri, 11 Oct 2024 00:15:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Dave.Martin@arm.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Consider the NULL character when validating
 the event length
Message-Id: <20241011001524.773836a84af82edede5349b2@kernel.org>
In-Reply-To: <20241007144724.920954-1-leo.yan@arm.com>
References: <20241007144724.920954-1-leo.yan@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
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

Ah, good catch! The traceprobe_parse_event_name() requires
MAX_EVENT_NAME_LEN buffer.

----
/* @buf must has MAX_EVENT_NAME_LEN size */
int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
----

But the macro name is a bit confusing. We may need below and use it around.

#define EVENT_NAME_BUFSIZE (MAX_EVENT_NAME_LEN + 1)

Anyway, I think this fix is correct.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Fixes: dec65d79fd26 ("tracing/probe: Check event name length correctly")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
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
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
