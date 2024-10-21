Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE8E440C;
	Mon, 21 Oct 2024 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729496620; cv=none; b=pq8S34td29ZUou6YiDJ11JwNo9f+8EtdyONx9FhibrGMb81ZaVeYmarZgUDiAFcl/pKjF5SXXked1mCepFuyc0EggqyauIHs6hgU2nBEnSB5oMrFFgD6eCK7hL0qldLQ36oPPHJZs27IncdzqWzwQJeHbHziFF09mjSgHdNdmEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729496620; c=relaxed/simple;
	bh=jVUvL+nwzIhExDvhRX8qXKXjV5D8t+xunCafnMybz/A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fN0wKXnDXX7D1vXVOp2T/FAnnRLlNUfIu3phKvt6W+lDf1elBM59SeIMTvhraRFfSLNC9ypeaU0OjNddIUjv3PisLomMUUsqX2Pi86B1fZbleouUYSylE9fhvxQJdJvImDaU8THv5TlY21e6XwEkI+yfRXz9mrsCcxSWTG3FwGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiNqqyiv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiNqqyiv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A332C4CECD;
	Mon, 21 Oct 2024 07:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729496620;
	bh=jVUvL+nwzIhExDvhRX8qXKXjV5D8t+xunCafnMybz/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MiNqqyivYG2b+sSOANKdt73+QK7Tru8NNJg4rTayYdGd2a3SHPqpwxp2eLlZBMf9s
	 7cFZn00Cu1+hWjNO0yNXzGdj5BKIbjJiZK7WzXEWzcUo+TESD/uxfV3rOcNBsF+kX+
	 15FrDGxpIOeKNwHsIg8VvzE+72gG7kddsK+nOFIEJpWQYMlThRnyIAJXgm5z8NXt1K
	 nPPSvggesWtOKTgOmMskGJqdJaK48Mdny/ah58v/6IJXrEnlKW+cja3jo12tLbUKqB
	 dtlJ7S9EBpF24Rxp9jr1Fkxud3ixoyFYJeu0LkhZ4oMYDzm9laF7FOFt47UhtVFkYc
	 Qer8Y/g+vcFRw==
Date: Mon, 21 Oct 2024 16:43:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] fgraph: Allocate ret_stack_list with proper size
Message-Id: <20241021164336.79a90af16419aa6e3f065bf3@kernel.org>
In-Reply-To: <20241018215212.23f13f40@rorschach>
References: <20241018215212.23f13f40@rorschach>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Oct 2024 21:52:12 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The ret_stack_list is an array of ret_stack shadow stacks for the function
> graph usage. When the first function graph is enabled, all tasks in the
> system get a shadow stack. The ret_stack_list is a 32 element array of
> pointers to these shadow stacks. It allocates the shadow stack in batches
> (32 stacks at a time), assigns them to running tasks, and continues until
> all tasks are covered.
> 
> When the function graph shadow stack changed from an array of
> ftrace_ret_stack structures to an array of longs, the allocation of
> ret_stack_list went from allocating an array of 32 elements to just a
> block defined by SHADOW_STACK_SIZE. Luckily, that's defined as PAGE_SIZE
> and is much more than enough to hold 32 pointers. But it is way overkill
> for the amount needed to allocate.
> 
> Change the allocation of ret_stack_list back to a kcalloc() of
> FTRACE_RETSTACK_ALLOC_SIZE pointers.

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> Fixes: 42675b723b484 ("function_graph: Convert ret_stack to a series of longs")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/fgraph.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 43f4e3f57438..41e7a15dcb50 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -1162,7 +1162,8 @@ static int start_graph_tracing(void)
>  	unsigned long **ret_stack_list;
>  	int ret;
>  
> -	ret_stack_list = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
> +	ret_stack_list = kcalloc(FTRACE_RETSTACK_ALLOC_SIZE,
> +				 sizeof(*ret_stack_list), GFP_KERNEL);
>  
>  	if (!ret_stack_list)
>  		return -ENOMEM;
> -- 
> 2.45.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
