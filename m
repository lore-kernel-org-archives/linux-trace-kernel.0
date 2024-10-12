Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0F8B67A;
	Sat, 12 Oct 2024 05:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728710459; cv=none; b=D463EtuqNn144pyONWy+7bILj0/oyVD+y77FAa9i1NOYv84CMnUfZa8x5GC+ZGb9zOBlVa0ahGOfcKETcmd22xLf2bm979ofE+lvkuK7DaoNAjTD090lT5O7W1H5sQAhWGxsMenVeLYfDxEbEuDAe3L0Omi62lMESaLVFM46ORY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728710459; c=relaxed/simple;
	bh=BzwsNGwWPFbLQrywGqQnb8DA672Q23+r40wwcBCKWv0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CIFrUn+mnh8eCHqlOdJZ42gf0ZeBnejL4B4qgLJWJ5dKUj/2vcqC+2ZTLcf3F7kC4cp+yAjkaoObrUJyG1/Lk82Z2tafBR+c0JEgdVqyRnYrqeqb9MQ78ALX3QPJMIv/ygW/jqgNcgXizI5sFnBUVMEYZa/gzLqYVEqzbec+/RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXZncEE0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXZncEE0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2906DC4CEC6;
	Sat, 12 Oct 2024 05:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728710458;
	bh=BzwsNGwWPFbLQrywGqQnb8DA672Q23+r40wwcBCKWv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GXZncEE06NownrToKmaAR9eeFS8yLicRU0Wg8sHHa7yPfhVK09vpkxeGShSLAIha3
	 46beUDZvv7QCbiqJwOjhVbJ28DtL3o5y1ZkIGKl9wlmXeOHVhqnTw6zdKZaVtagX6C
	 KJi/1clzW5f/rERNDpCuSfFfuI5GTlAvBY2M2JwVn4IR3u/7OA7sakyMNYzSen9lfP
	 vkepmNPFiBDgQ9/+IcJRn0M+L5GhfuGUe6iPm8vTeWHaVU9PK/2mJMY04I8X2RPC3N
	 sugaNx8qW4FPWgKPQqR5D6U9pe9Ksicoz3EVYIYY9DqPjhcHwWzXnT4C0ZhDuN82NT
	 gJKLkMzGVHz2A==
Date: Sat, 12 Oct 2024 14:20:54 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Fix refcount setting of boot mapped
 buffers
Message-Id: <20241012142054.bc1fffb7b4829ff2e496e566@kernel.org>
In-Reply-To: <20241011165224.33dd2624@gandalf.local.home>
References: <20241011165224.33dd2624@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 16:52:24 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> A ring buffer which has its buffered mapped at boot up to fixed memory
> should not be freed. Other buffers can be. The ref counting setup was
> wrong for both. It made the not mapped buffers ref count have zero, and the
> boot mapped buffer a ref count of 1. But an normally allocated buffer
> should be 1, where it can be removed.
> 
> Keep the ref count of a normal boot buffer with its setup ref count (do
> not decrement it), and increment the fixed memory boot mapped buffer's ref
> count.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Fixes: e645535a954ad ("tracing: Add option to use memmapped memory for trace boot instance")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index c01375adc471..5ba40f39c8b5 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -10610,10 +10610,10 @@ __init static void enable_instances(void)
>  		 * cannot be deleted by user space, so keep the reference
>  		 * to it.
>  		 */
> -		if (start)
> +		if (start) {
>  			tr->flags |= TRACE_ARRAY_FL_BOOT;
> -		else
> -			trace_array_put(tr);
> +			tr->ref++;
> +		}
>  
>  		while ((tok = strsep(&curr_str, ","))) {
>  			early_enable_events(tr, tok, true);
> -- 
> 2.45.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
