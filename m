Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8355338D;
	Mon,  7 Oct 2024 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310964; cv=none; b=jsUiUHWS4eOVd9ajW+JBIVNnfTm/qg8DYo44ji+GMbsrSgU7kuFVyCAIX1q+4AfEeMWFvkmUrFgibAUl9TQyTlj2Cu+BdyZ+xwAWfXCJFMb2QXG4EqRUYmK74WJpSSTvzK2CcNOCv7AZLww3pj5HCsRFvqaY9ISPT8NKsqyZWF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310964; c=relaxed/simple;
	bh=8+q+UdEhtowo/cYRIkBbmMZjdoDF7YOauFhtK2XM9DE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=agGbh9qJMVpssNX2HUVPDpY9pMpuBFBurrNA84/FrcRm1at8ztjlKbH9d0DTkjrOhlwoIRDne3k/raYL7yfEPBGw2WzM6mlSRPww1T+HwrFcDWA+XCY/3Mg3r6hgXU4B3qbvHMt+IK0tVb0yyfHTH5A7or1ERyrVgsF2qEkNxBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7B5C4CEC6;
	Mon,  7 Oct 2024 14:22:42 +0000 (UTC)
Date: Mon, 7 Oct 2024 10:22:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Dave.Martin@arm.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Consider the NULL character when validating
 the event length
Message-ID: <20241007102242.18d2636e@gandalf.local.home>
In-Reply-To: <20241007135126.873234-1-leo.yan@arm.com>
References: <20241007135126.873234-1-leo.yan@arm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Oct 2024 14:51:26 +0100
Leo Yan <leo.yan@arm.com> wrote:

> strlen() returns a string length excluding the null byte. This commit
> adds 1 to account for the NULL terminating character when checking if an
> event string is within the maximum length.
> 
> Fixes: dec65d79fd26 ("tracing/probe: Check event name length correctly")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  kernel/trace/trace_probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 39877c80d6cb..376ba56c3680 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -276,7 +276,7 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
>  		}
>  		trace_probe_log_err(offset, NO_EVENT_NAME);
>  		return -EINVAL;
> -	} else if (len > MAX_EVENT_NAME_LEN) {
> +	} else if (len + 1 > MAX_EVENT_NAME_LEN) {

Usually, the check is:

	} else if (len >= MAX_EVENT_NAME_LEN) {

Which is a better way to check max length.

-- Steve


>  		trace_probe_log_err(offset, EVENT_TOO_LONG);
>  		return -EINVAL;
>  	}

