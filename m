Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EEF48125B;
	Wed, 14 Oct 2026 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983704; cv=none; b=oqRnfwRYyWLeQP4MBMs12iWMR+paKoiwiBYsU5qi7e4cHf8lW2zWkyO/fIZ1OY42v57+wGoADMcT+RsDSb+zc8DNH2WigebxEfcggYyE5kfIt8jDtH79SOOkJwo+HTTvQiNO8niUKweWDZL9aTbTa6IfqFUHryS1l82OZKT5nHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983704; c=relaxed/simple;
	bh=7+qRjABvX1ikWd+n/UmQjI+EgJi+GeqWlg/uSj/hncM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCnfuaP0Eokhb7B+v0VzvYpSdTcgHxl26x5Kp62ZTyPFSvvLA22JjP/DgAS+eDqpbUpds+zC3NM3PFXJIDpwsXdHTJGYHpvbDYeZ4ucilbDddt0KnWgmn0GkiLDSOV1Juqq7jFRuuQJt8RorEvCW6aSov1mA2wSYO9g9GuT6fnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=W79jpx/7; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="W79jpx/7"
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 986021C3D2D;
	Wed, 14 Oct 2026 13:14:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id D21A420033;
	Wed, 14 Oct 2026 13:14:52 +0000 (UTC)
Date: Wed, 14 Oct 2026 09:14:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: probes: error if BTF is required but
 unavailable
Message-ID: <20261014091453.0bcce777@gandalf.local.home>
In-Reply-To: <20261014083838.31020-1-martin@kaiser.cx>
References: <20261014083838.31020-1-martin@kaiser.cx>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: D21A420033
X-Stat-Signature: 1cknt6qo4ki58ttyfnfjsc3ntpsxyekj
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18yIrGhlopvCh/r5bfsChwOy1/xFa6kmE8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=37O2Dw99Ey7mNxOaUhBGMFmIn4+W07oMsw3GGsWWYUg=; b=W79jpx/7uIutoMgj9Or2Q8L4+zYuOkrXeJyBYdOtKRWS4wAWKi5akkr8CcW4LpxCn0QCfgpIJDEooaQ0o9eDTTCHKc17lTq+ND6JnzTUVib8jK98qMUpPBTDBsyqIMtwqPXjf2PWFldxkYAEpB6S16NhKhLgjTX5Wz/4FtfZ9sk=
X-HE-Tag: 1791983692-596439
X-HE-Meta: U2FsdGVkX19SUguHcJexiCwy447Xcvho1g4WsOGIc7sokUOvCeNVKj4qScVEjDBt4Y666dHP0MN7SHMaqKXpDZ0t1dO52xscvliVGgiv9pb05JzfYLHy8shv0n1uMYcJQD4AfASw+VYvtoBYmyFNs9M37dLRBT5GMSDcHPy5NKHMgRunFEgVe+gBsqfOS6t0gnxA1e8eIiwfdAieD8YF58n9Gy+UV4Yv8XvtkrS/+Eek9uDc0WIv0XAudPr5D62PT8RA+WTbL1h0yy+nsm7DgWYHjO3AhdcYG3mvLTqnMdkYfvz1ZvPhx3wZv5sjWqR3LaSmSC9jUEIhSINRWYHk4UG8+Uak7tP0zVpsqSF8Nh4WOGfKIRbDJwZUgfVrziCB

On Wed, 14 Oct 2026 10:37:40 +0200
Martin Kaiser <martin@kaiser.cx> wrote:

> traceprobe_expand_meta_args expands probe arguments based on BTF info.
> 
> Return an error if we have arguments that need expanding but BTF is not
> supported.
> 
> The params variable is now unused, it can be removed.
> 
> Fixes: d157d7694460 ("tracing/probes: Support BTF field access from $retval")

I agree with the change but I don't think it needs a fixes tag. It
currently errors out with -EINVAL if BTF is not supported. Your change
updates it to -ENOTSUPP. But this is a cleanup and not a fix.

~# cat error_log
trace_fprobe: error: BTF is not available or not supported
  Command: f vfs_read $arg*
                      ^
But other than that.

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve


> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  kernel/trace/trace_probe.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index cfb710095f65..516c439932a0 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -2287,7 +2287,6 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
>  					 int *new_argc, char *buf, int bufsize,
>  					 struct traceprobe_parse_context *ctx)
>  {
> -	const struct btf_param *params = NULL;
>  	int i, j, n, used, ret, args_idx = -1;
>  	const char **new_argv __free(kfree) = NULL;
>  
> @@ -2305,7 +2304,7 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
>  		if (args_idx != -1) {
>  			/* $arg* requires BTF info */
>  			trace_probe_log_err(0, NOSUP_BTFARG);
> -			return (const char **)params;
> +			return ERR_PTR(-EOPNOTSUPP);
>  		}
>  		*new_argc = argc;
>  		return NULL;

