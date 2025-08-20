Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C33D13A3F7;
	Wed, 20 Aug 2025 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755652810; cv=none; b=VyJ5oCNXAU7LWKdZ/BOaeRUCg+YyMXSPadZnaOShdkj03TdLIbIDyIjrJu+jAlJQJeZ82lk4SQPgtGHt+1fIbmZSIEZ1UPROhVyg1J+EDBxNc5qeBDE3N1jzQMN/Uh09qWuIx9Olb07ooutNL715cBMh1K3PtbDH+N4WCYTi/rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755652810; c=relaxed/simple;
	bh=63sILRJcItw4yl8FfiixuWKpnQxVxwP7O5fDtUt+k6I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=U0BfnwrGq88fxNJcQW4s6pAZxqvafspq2saO2rYNa/xxoNlFyTYvYPgMVsNze+G25znJEAdULLE8cb1O4vItIPEtwSta8EnV+mfTOp9YwTWkGghJiEyUh+i4pIl5Ns5PMlpzCEj/5anROsM6y4NdgHrqpA5uDYhjqYR2ysndREE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cURs7ZyT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cURs7ZyT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B352C4CEF1;
	Wed, 20 Aug 2025 01:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755652809;
	bh=63sILRJcItw4yl8FfiixuWKpnQxVxwP7O5fDtUt+k6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cURs7ZyTaPZ+ZyF2B216Au8BxU/TXYzL+uKyyuUHGBwJKIYgnmX+8rQWg7GKNHmRu
	 i28Use60RBsvN5hUI1y2lIEcv5VODmYecHblrYZGaary2oMDvTAW78ZBXr057oaCoZ
	 pyQkhMwwfEYUsxEy/I1tBwVq2BhIFvIom05KWrdTaJRDEONy4OI2dGtwwjloyEFDTt
	 EPzk9itvNchQM5GWl/qiGumDoIEnNftrOpsefSp3YHlfbYlJqP8q4XU1gxCO84DE+X
	 XpbhM3d1Q2afe60uEOncr2vF4lwf5SzzLaLAJv4g8RQxlovWdYdJ+JfMOQfH4QmmY8
	 sX5nu363SX3og==
Date: Wed, 20 Aug 2025 10:20:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ye Weihua <yeweihua4@huawei.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] trace/fgraph: Fix the warning caused by missing
 unregister notifier
Message-Id: <20250820102005.a6bcf7787d5c6e9d10beb0db@kernel.org>
In-Reply-To: <20250818073332.3890629-1-yeweihua4@huawei.com>
References: <20250818073332.3890629-1-yeweihua4@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 07:33:32 +0000
Ye Weihua <yeweihua4@huawei.com> wrote:

> This warning was triggered during testing on v6.16:
> 
> notifier callback ftrace_suspend_notifier_call already registered
> WARNING: CPU: 2 PID: 86 at kernel/notifier.c:23 notifier_chain_register+0x44/0xb0
> ...
> Call Trace:
>  <TASK>
>  blocking_notifier_chain_register+0x34/0x60
>  register_ftrace_graph+0x330/0x410
>  ftrace_profile_write+0x1e9/0x340
>  vfs_write+0xf8/0x420
>  ? filp_flush+0x8a/0xa0
>  ? filp_close+0x1f/0x30
>  ? do_dup2+0xaf/0x160
>  ksys_write+0x65/0xe0
>  do_syscall_64+0xa4/0x260
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> When writing to the function_profile_enabled interface, the notifier was
> not unregistered after start_graph_tracing failed, causing a warning the
> next time function_profile_enabled was written.
> 
> Fixed by adding unregister_pm_notifier in the exception path.
> 

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Fixes: 4a2b8dda3f870 ("tracing/function-graph-tracer: fix a regression while suspend to disk")
> Signed-off-by: Ye Weihua <yeweihua4@huawei.com>
> ---
>  kernel/trace/fgraph.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index c5b207992fb4..dac2d58f3949 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -1391,10 +1391,11 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  error:
>  	if (ret) {
>  		ftrace_graph_active--;
>  		gops->saved_func = NULL;
>  		fgraph_lru_release_index(i);
> +		unregister_pm_notifier(&ftrace_suspend_notifier);
>  	}
>  	return ret;
>  }
>  
>  void unregister_ftrace_graph(struct fgraph_ops *gops)
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
