Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EFF1EC00B;
	Thu, 20 Feb 2025 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043432; cv=none; b=gEgDtFGuhPvTnwjp6EJo9zutZF3Ap7wZGtxt2Q39ZB9TVI0ZBOiIx1ptiUDSo/oC7CzYEShpbuZ/2BorEmz/rVpFZ1tGk1SM9mdw0f5TXe1c1O0gbgZG+I6Wp2icjNixjaFYGmOxV8o6azJVFV14w7AleUU4s3B5hEJDxrEbtm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043432; c=relaxed/simple;
	bh=1dLNFLATCv57IMG9r/aYeXEpDq3tzD31++DiOtlbVkU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EhQVPKSi42ChRj54SZ69qJUeFuhNgmHZrMtEGJR4BvZymwxN0OnNJBuXj7O8g2bQjjDg6CnLvh86weW6XlFGJIDYta/DcpZQsHRHlcbJW/sF/wXV5suauxfcfovcvrfOVoSJx+MhJB9h/hb9Yn0uIOQurdwZkSQWgOznG/lHiiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHw6ZDGr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHw6ZDGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD4DC4CED1;
	Thu, 20 Feb 2025 09:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740043432;
	bh=1dLNFLATCv57IMG9r/aYeXEpDq3tzD31++DiOtlbVkU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DHw6ZDGrXpuJKTDgPeHUj1mx/ySwiWlXbs1cryzRVI/yoX1j+zHqpvP+bf1+7befv
	 DJ0uDteojFueiDLvyYb6I32T5fnCQmm0hMG7LSlycnsCc+/lzcLlLtSXHZWvL0CGUD
	 ab5U9OunQWO/MDS8RcBiMPxX9ud7hcg00a9JSny1wND0VHHYKbk1AivjgfqAVb7tXw
	 pmlmKr7TUQSnv0UQT+sMYB0n3Gs/39e3Z+f9/WrEcDUS/s6iRqCPkXIwDA9kwr7QrH
	 HrYdAe4PtUT2zTN1B+1SEABu8W0dAc45lWTW5jocN9NbLIFHEtZduT2Ibzm2r0L983
	 E3oXsaH4J+dCA==
Date: Thu, 20 Feb 2025 18:23:49 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ftrace: Have ftrace_free_filter() WARN and exit if ops
 is active
Message-Id: <20250220182349.bc7b6f9a6917b04f9a7e109e@kernel.org>
In-Reply-To: <20250219135040.3a9fbe00@gandalf.local.home>
References: <20250219135040.3a9fbe00@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 13:50:40 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The ftrace_free_filter() is used to reset the ops filters. But it must be
> done if the ops is not currently active (tracing). If it is, it will mess
> up the ftrace accounting of what functions are attached and what is not.
> 
> WARN and exit the ftrace_free_filter() if the ops is active when it is
> called.
> 
> Currently, it doesn't seem if anything does this, but it may in the
> future.
> 
> Link: https://lore.kernel.org/all/20250219095330.2e9f171c@gandalf.local.home/
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
>  kernel/trace/ftrace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 189eb0a12f4b..4f6cad3b05b2 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1296,6 +1296,8 @@ static void free_ftrace_hash_rcu(struct ftrace_hash *hash)
>  void ftrace_free_filter(struct ftrace_ops *ops)
>  {
>  	ftrace_ops_init(ops);
> +	if (WARN_ON(ops->flags & FTRACE_OPS_FL_ENABLED))
> +		return;
>  	free_ftrace_hash(ops->func_hash->filter_hash);
>  	free_ftrace_hash(ops->func_hash->notrace_hash);
>  }
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
