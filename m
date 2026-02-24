Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C6C36605D;
	Tue, 24 Feb 2026 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922007; cv=none; b=tQ9Khj+w0F2XMQD+t9Ro0hcyaWqQJWZb3hz7HcH8LGFrU2lgD/tHgj9qf/AsAD9nthNrQFsgSdmaqNEl73ml5uHSi68fuEZrPL6RvkVyKkt8tysujs7iybzruqVjKKSHJumDgo/uHRFMSEH5ETx/YnwLE7Sa1UrfXBBmhfU8vVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922007; c=relaxed/simple;
	bh=714/VEHB+aHM96UbWGHRo19d4d8Vpx5ZHuAp8X+3MzE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=njYF171Ow+EsLJRVO2xTbBTu6XzIfi7cl8uMvkJQk9qJTZXxE8jnu6c2PV0WUfPO62wGGFj5siDyHVMvZgt76+twcN/Ilft8A0r4eYC0zlC3aoyeUVDrsNN0sV3MRODRmx/dyYgYkZzSoZ1lrDuEYiLOLHcgy/CpGh/9e3oqrYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHgywnqN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHgywnqN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD22EC116D0;
	Tue, 24 Feb 2026 08:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771922007;
	bh=714/VEHB+aHM96UbWGHRo19d4d8Vpx5ZHuAp8X+3MzE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sHgywnqNZG2y8hRdHK0WCgFIMxrcnO6tyOEL+V4AqmYkGm2OXK+eusrrXK6qNjFht
	 1GWRZpfVkCV4XpKO/jb2ToHam50hrP+5muZ6VxkoRA72Ue9MWHoVa0FavWPBDVOyvm
	 CkLed9k9nCdID3Bf9Ww23Ptmn1Fzs7MPKPFZCrko6zJYvYYLsi4eQG6Z+FQYvgSD+p
	 OSPCPsqUYHXWKXAToezW8tmqYkbjixa2KCti6MFh80OIuxK8ELZENNTjXUm95LGRhP
	 oiNKOeurfbNPMii2kaNZ0HGRc9bYj8leEMrqF9UiRixFccm3ZA8UqcL2AnDbHbHxFc
	 e9vr1Hp3Igk9g==
Date: Tue, 24 Feb 2026 17:33:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: <hu.shengming@zte.com.cn>
Cc: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
 <mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <zhang.run@zte.com.cn>,
 <yang.tao172@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: Re: [PATCH 1/2] fgraph: fix thresh_return clear per-task notrace
Message-Id: <20260224173324.3db58282e7afc817aaa13138@kernel.org>
In-Reply-To: <20260221113007819YgrZsMGABff4Rc-O_fZxL@zte.com.cn>
References: <202602211116123227p4Je6QELxr2byqvy9kTE@zte.com.cn>
	<20260221113007819YgrZsMGABff4Rc-O_fZxL@zte.com.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Feb 2026 11:30:07 +0800 (CST)
<hu.shengming@zte.com.cn> wrote:

> From: Shengming Hu <hu.shengming@zte.com.cn>
> 
> When tracing_thresh is enabled, function graph tracing uses
> trace_graph_thresh_return() as the return handler. Unlike
> trace_graph_return(), it did not clear the per-task
> TRACE_GRAPH_NOTRACE flag set by the entry handler for
> set_graph_notrace addresses. This could leave the task
> permanently in "notrace" state and effectively disable
> function graph tracing for that task.
> 
> Mirror trace_graph_return()'s per-task notrace handling by
> clearing TRACE_GRAPH_NOTRACE and returning early when set.
> 

Good catch!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!


> Fixes: b84214890a9bc ("function_graph: Move graph notrace bit to
> shadow stack global var")
> Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
> ---
>  kernel/trace/trace_functions_graph.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> index 1de6f1573..cbe43680c 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -400,14 +400,15 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
>  				      struct fgraph_ops *gops,
>  				      struct ftrace_regs *fregs)
>  {
> +	unsigned long *task_var = fgraph_get_task_var(gops);
>  	struct fgraph_times *ftimes;
>  	struct trace_array *tr;
>  	int size;
> 
>  	ftrace_graph_addr_finish(gops, trace);
> 
> -	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT)) {
> -		trace_recursion_clear(TRACE_GRAPH_NOTRACE_BIT);
> +	if (*task_var & TRACE_GRAPH_NOTRACE) {
> +		*task_var &= ~TRACE_GRAPH_NOTRACE;
>  		return;
>  	}
> 
> -- 
> 2.25.1


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
