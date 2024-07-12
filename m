Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAF31BC20;
	Fri, 12 Jul 2024 23:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720827189; cv=none; b=RUquNfdjpxv59r//pyRuG35ye04+TFtHc6blxY0/xLtCH64YO4T2oP3ciShIbQkufYr/o/R43hQ4rcJN3/SeBymeu+tJBO6wQg0+1F4Qm5Eo18MxuoPzIXa25QKW6cbJj35SazeDI+ekNsD3AF4aGssGm87hH593ByHg526gMIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720827189; c=relaxed/simple;
	bh=wf9SUj8vXNTkTRRQtPM01POqFTV0CMIZQ+/FPslmrqg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KtmyG12Iz2ZxG1+lcC7qYT8TLsz3jql5v1YEEjLIBRfDE4XExst5LJbsE4fsnZnLB1R8KsKZF/l2HD144h/czH32VZwkof5WbgNAMD5Mc8PS9TBgjXDSnh/6hEEgsoJiGNwVHDgTxKt2GL4gJVcWVh4rchdj9TGLFQMRGlfflig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0BFC32782;
	Fri, 12 Jul 2024 23:33:07 +0000 (UTC)
Date: Fri, 12 Jul 2024 19:33:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] tracing: remove unreachable trace_array_put
Message-ID: <20240712193306.3174c85e@gandalf.local.home>
In-Reply-To: <20240712201258.99070-1-kiryushin@ancud.ru>
References: <20240712201258.99070-1-kiryushin@ancud.ru>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 23:12:58 +0300
Nikita Kiryushin <kiryushin@ancud.ru> wrote:

> There is a trace_array_put() in check result for
> nonseekable_open() in tracing_buffers_open(). However,
> it would be never executed as nonseekable_open never fails
> (by design).
> 
> Remove the check and associated unreachable code.

Then why does it return a value?

If someday it can return a failure, this would then cause a leak. It
doesn't hurt to leave it in.

So NACK.

-- Steve


> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 7b85af630348 ("tracing: Get trace_array ref counts when accessing trace files")
> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
> ---
>  kernel/trace/trace.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 578a49ff5c32..7e480501b509 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -7883,11 +7883,7 @@ static int tracing_buffers_open(struct inode *inode, struct file *filp)
>  
>  	mutex_unlock(&trace_types_lock);
>  
> -	ret = nonseekable_open(inode, filp);
> -	if (ret < 0)
> -		trace_array_put(tr);
> -
> -	return ret;
> +	return nonseekable_open(inode, filp);
>  }
>  
>  static __poll_t

