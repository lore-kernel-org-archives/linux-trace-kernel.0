Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1068DC8CE;
	Fri, 13 Feb 2026 03:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770954484; cv=none; b=WuLXy87wQnAf7QyVIODxjKbmSIR/3Ngd84SAFIjoqiQ6Zb19BueXbnL5zp01zLpAfzHh3JGPPJMfamg84I1XOaUjB5UqByOU2PIV2r2OO+K2mkl8vS91ZiG2jwUzJIsmktnsluy+FOYIbSQ+8pGdtYtaoU9jnAJouCvrUREauFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770954484; c=relaxed/simple;
	bh=WHWxj//L5p3gpQ0AbIU3rkAsV7uuvfbM7UrT+2sqpJU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iurepv6Sn5MW7eCFJGKRdE/Jl6mYOpTZhvsQNHI/rk1WBcT7cQb4z/C6NJ60TfQxRR7/05ZlwECxId4gBDzAJxK9o4WTV2l1k2bRjSECGbW3Zu/PfgqazQTcpuvNC4WBWDfCbwmAz9eK5GM+yZ9f9jcMz3gCZiOlfUhdiH9gWZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 9F1961C2DD;
	Fri, 13 Feb 2026 03:47:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 7361C1B;
	Fri, 13 Feb 2026 03:47:53 +0000 (UTC)
Date: Thu, 12 Feb 2026 22:47:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: <hu.shengming@zte.com.cn>
Cc: <mhiramat@kernel.org>, <mark.rutland@arm.com>,
 <mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <zhang.run@zte.com.cn>,
 <yang.tao172@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] function_graph: restore direct mode when callbacks drop
 to one
Message-ID: <20260212224752.4311a58d@fedora>
In-Reply-To: <202602131034245558BcmEI95X7Sr39QGM8YLl@zte.com.cn>
References: <202602131034245558BcmEI95X7Sr39QGM8YLl@zte.com.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1cik83txb8kzrhz61dn3xrqhxx7xt5bk
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 7361C1B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/H0XycFxaxJQNv2U1GRDLZcGzFvT4kW2c=
X-HE-Tag: 1770954473-375750
X-HE-Meta: U2FsdGVkX1+o/1s6tj7+Uz0XMCm9mQjPcsDPDTEgPENAZoH5e5Uo1WLVO8L4BC+qbKHcy8ybFfpQdlba4/H0k72J/BUXjM/S3423d/7Nl45IqHuovRXQYQqsYu74zxOqzIoW4Z48yuYX8BV3QPz4j+UVeNT7HiAtDkfsk1IeiGkSvS976uz0Mx34fDr4oPRr73CsYE4VFrioiSF/Xh/yH14r1gKToO4hn4fmvMuh1vrfSdsWY+KjfD3h/tvYgDUJYJC2vOlThxRBrR6ZN8326Ir4cVeUeCFnzYi6P0XPcT4AktcElR+rLxycO9TVhBxcClSZf2dfvJp/4TjGnW1z2bNEwYEenlgTXeOBaS/+Gi7ZyGOyZxHo+0aTIq4TkL5I

On Fri, 13 Feb 2026 10:34:24 +0800 (CST)
<hu.shengming@zte.com.cn> wrote:

> From: Shengming Hu <hu.shengming@zte.com.cn>
> 
> When registering a second fgraph callback, direct path is disabled
> and array loop is used instead.
> When ftrace_graph_active falls back to one, we try to re-enable direct
> mode via ftrace_graph_enable_direct(true, ...).
> But ftrace_graph_enable_direct() incorrectly disables the static key
> rather than enabling it.
> This leaves fgraph_do_direct permanently off after first multi-callback
> transition, so direct fast mode is never restored.

Good catch!

> 
> Fixes: cc60ee813b503 ("function_graph: Use static_call and branch to optimize entry function")
> Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
> ---
> kernel/trace/fgraph.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index cc48d16be43e..4df766c690f9 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -1303,7 +1303,7 @@ static void ftrace_graph_enable_direct(bool enable_branch, struct fgraph_ops *go
> static_call_update(fgraph_func, func);
> static_call_update(fgraph_retfunc, retfunc);
> if (enable_branch)
> -       static_branch_disable(&fgraph_do_direct);
> +       static_branch_enable(&fgraph_do_direct);
> }

Your email client killed your patch. it has huge white-space damage.
But because it's such a trivial change, I'll fix it up for you. But
next time please make sure your email client doesn't corrupt your
patches.

Thanks,

-- Steve


> 
> static void ftrace_graph_disable_direct(bool disable_branch)
> --
> 2.25.1

