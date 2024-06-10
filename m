Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720AD18E2A;
	Mon, 10 Jun 2024 22:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718057855; cv=none; b=TVq53ZjjLs7JtsoL9m7ksbrrLzcGahRj4bCg1HzWI0RKxzBnF3Q0ZOO5ER1yZsJ4Uhm10DAa8QZeMSP7yAWAjTei7v6CWzaOBZ/4i3aH6C/v+uuwu9qYx9RoluHNhDuT71rjBG21nfeAOhuNRu94PLASMgbRGzCQOR3wJjcrJSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718057855; c=relaxed/simple;
	bh=JSCara3hi6qF428O+BVXiaUpm0X/OTitwR/xoTFOfY4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FdvkJok14mTRnBunkMLCjKI0qL+K9kjJkjDhst5GRPrIHWuaFW5SBFPeaUh/+xQx5AUE5CfWuq8iaMreDVvfCm1QqbHgeM4T10m2cKuLuNoFwCRjN5gU+XlC5QVu0/RR5aXREBLvwVtCjleQUxBN2072TYtlMJFVNcBs79hLI8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B167CC2BBFC;
	Mon, 10 Jun 2024 22:17:33 +0000 (UTC)
Date: Mon, 10 Jun 2024 18:17:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next 1/2] function_graph: Add kernel-doc comments for
 ftrace_graph_ret_addr() function
Message-ID: <20240610181746.656e3759@gandalf.local.home>
In-Reply-To: <20240607084957.64715-1-yang.lee@linux.alibaba.com>
References: <20240607084957.64715-1-yang.lee@linux.alibaba.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Jun 2024 16:49:56 +0800
Yang Li <yang.lee@linux.alibaba.com> wrote:

> Added kernel-doc comments for the ftrace_graph_ret_addr() function to
> improve code documentation and readability.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9299
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  kernel/trace/fgraph.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index a13551a023aa..4ad33e4cb8da 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -872,6 +872,12 @@ ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
>  /**
>   * ftrace_graph_ret_addr - convert a potentially modified stack return address
>   *			   to its original value
> + * @task: pointer to the task_struct of the task being examined
> + * @idx: pointer to a state variable, should be initialized to zero
> + *	 before the first call

parameter descriptions should not go across more than one line. At least
not in my code. Also, you don't need to add that it needs to be initialized
here. That belongs in the body.

And it's not a state variable. The description you got that from is wrong.

I'll go update it and give you a reported by, as the entire description
needs a rewrite.

-- Steve


> + * @ret: the current return address found on the stack
> + * @retp: pointer to the return address on the stack, ignored if
> + *	  HAVE_FUNCTION_GRAPH_RET_ADDR_PTR is not defined
>   *
>   * This function can be called by stack unwinding code to convert a found stack
>   * return address ('ret') to its original value, in case the function graph

