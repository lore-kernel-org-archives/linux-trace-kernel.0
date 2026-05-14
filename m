Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4750027442;
	Thu, 14 May 2026 04:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778733834; cv=none; b=CGzME+VqAa7YTde61LgVaIymgq522Ni8iA+QDAK1sPit659VvUjHW1PGWSWKKXVUAbrA080ddqqzmCiDTUsVLqXMJzQ/o0MRA09BfMJ9Ci3E+0hM1KLojmkNrHVTiU2HWPl32WVL0XuigdFxsv5SVXQIOvzN8G+PaGdRMJ8qOlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778733834; c=relaxed/simple;
	bh=nBC50JKu83hNUVEpT8Mr6OZ/OEdZnxqRf8nRk8h/SRk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qxfRlKW60DBuoAtQ5/xS5kGOWbjB+PhL53kmnEHwqLOtVISGrZgV3sYbpxdZFpnR8WsiUjmbF1ET2/Gb/2yB2QPZsJrFktiWO+mNXOKArIY6YKAIkuC5948ZjbWS8xOHNhct9L46dymsiVlYAHVQCRubs6qZcRqNKjsefd6gnk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iw3t6jru; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iw3t6jru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7611C2BCB7;
	Thu, 14 May 2026 04:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778733833;
	bh=nBC50JKu83hNUVEpT8Mr6OZ/OEdZnxqRf8nRk8h/SRk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iw3t6jruYnJWlZHrC0i6P/2Tr7JuzseBuk08uJXCgiVZ3CCDyXplHGyPiBuZ4b+bL
	 FnKoRyUApgQl2KyYL57hH+Df3eST1GihyQfyhGjeKMTvNciU0Ip7JB0uZE+cap3+JR
	 e8lV66Ti7H2NCFEN127Tb6g36fzXOiC0WKQfBs1hFieTNTHwk1K429vOtnNDViuM2X
	 pgFWqKvrHzBaI82NjbEBp1hDSaXhqt5gAo3TxrFkjE5iuHI8zJYPi3PNrRCaXzncSg
	 AKThDboWPRHGzQb+2rNIoS0/KcBALgaSv1CYuyUMzjaYHcQR9EvyeY2vu2PkRFz7Nk
	 5ibLyryHfT8Yw==
Date: Thu, 14 May 2026 13:43:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH v2] perf/ftrace: Fix WARNING in
 __unregister_ftrace_function
Message-Id: <20260514134351.ec3e22055d50816200e872ab@kernel.org>
In-Reply-To: <20260513161916.04151502@fangorn>
References: <20260513161916.04151502@fangorn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 16:19:16 -0400
Rik van Riel <riel@surriel.com> wrote:

> perf_ftrace_function_unregister() unconditionally calls
> unregister_ftrace_function() without checking whether the ftrace_ops
> was ever successfully registered. This triggers a WARN_ON in
> __unregister_ftrace_function() when the ops doesn't have
> FTRACE_OPS_FL_ENABLED set.
> 
> This can happen during perf_event_alloc() error cleanup when
> perf_trace_destroy() is called via __free_event() on an event whose
> ftrace_ops registration failed or was already torn down by
> perf_try_init_event()'s err_destroy path.
> 
> The call path is:
>   perf_event_alloc() error cleanup
>     -> __free_event()
>       -> event->destroy() [tp_perf_event_destroy]
>         -> perf_trace_destroy()
>           -> perf_trace_event_close()
>             -> TRACE_REG_PERF_CLOSE
>               -> perf_ftrace_function_unregister()
>                 -> unregister_ftrace_function()
>                   -> __unregister_ftrace_function()
>                     -> WARN_ON(!(ops->flags & FTRACE_OPS_FL_ENABLED))
> 
> Fix this by checking FTRACE_OPS_FL_ENABLED before attempting to
> unregister. If the ops is not enabled, just free the filter and
> return success.
> 
> Assisted-by: Claude:claude-opus-4.7 syzkaller
> Signed-off-by: Rik van Riel <riel@surriel.com>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Fixes: ced39002f5ea ("ftrace, perf: Add support to use function tracepoint in perf")

Thanks,

> ---
>  kernel/trace/trace_event_perf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> index a6bb7577e8c5..58e1b427b576 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -497,7 +497,11 @@ static int perf_ftrace_function_register(struct perf_event *event)
>  static int perf_ftrace_function_unregister(struct perf_event *event)
>  {
>  	struct ftrace_ops *ops = &event->ftrace_ops;
> -	int ret = unregister_ftrace_function(ops);
> +	int ret = 0;
> +
> +	if (ops->flags & FTRACE_OPS_FL_ENABLED)
> +		ret = unregister_ftrace_function(ops);
> +
>  	ftrace_free_filter(ops);
>  	return ret;
>  }
> -- 
> 2.52.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
