Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9751D958E;
	Tue,  7 Jan 2025 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257062; cv=none; b=XxQ8vmgN6fia736uWVyS+JwBZTVdo2nAU/9SymyrGOTOyV9kp38HAdBOS2ELcDj/v7kmVzAXvBnN5+1Iz6KJJv9Htub5/jZ3PM1SwYSdsUSZKSonSKcpxosgXbHzeMPA2lV4TzdT9dWkGWZvkUugFVNUahwgBUl6rUhgf7d6JEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257062; c=relaxed/simple;
	bh=DijeawhERSQe3C29YMpvH8ybbyMFEiQOnz5FocWR/Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0rZwOUFyV3L1qDEnXBRElmAQ6f3VwCNIJw5vJWW5ceJPxqvayRDziVhFtlX0ZtLVJgweV6K8SKp5Zsc9Tyitv+33/mObSXJ+NWe58eflsnP9tPWd9JvbVoY0bRK2FBD5bssOxZkfsLlVbbnppjqmrS6RRo4u2NGdWkjFuZ1qbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5DEC4CED6;
	Tue,  7 Jan 2025 13:37:41 +0000 (UTC)
Date: Tue, 7 Jan 2025 08:39:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH kernel-next] tracing: Fix uninitialized variable in
 tracing_set_tracer()
Message-ID: <20250107083909.5469f667@gandalf.local.home>
In-Reply-To: <20250107125920.45855-1-dheeraj.linuxdev@gmail.com>
References: <20250107125920.45855-1-dheeraj.linuxdev@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Jan 2025 18:29:20 +0530
Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com> wrote:

> Fix an issue in the tracing_set_tracer() where the variable ret could
> be used uninitialized under certain conditions. Specifically, when
> t->use_max_tr is true but tr->cond_snapshot is false, the code would
> check the value of ret without first initializing it.
> 
> Fixes: a35873a0993b ("tracing: Add conditional snapshot")
> Closes: https://scan7.scan.coverity.com/#/project-view/52337/11354?selectedIssue=1602786
> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> ---
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index a04348ab7ccc..28f111c5b3a5 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6079,7 +6079,7 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
>  #ifdef CONFIG_TRACER_MAX_TRACE
>  	bool had_max_tr;
>  #endif
> -	int ret;
> +	int ret = 0;
>  
>  	guard(mutex)(&trace_types_lock);
>  

Incorrect fix. The actual fix is pending:

  https://lore.kernel.org/all/20250106111143.2f90ff65@gandalf.local.home/

-- Steve
