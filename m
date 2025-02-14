Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5D315D1;
	Fri, 14 Feb 2025 00:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739492856; cv=none; b=FZm5PDBE/GWgkX/7JhwdIOfmU0pbV5pXnhnp/j2LjjVJFE9p46QKRqnveLEQulh6KituZbhJEs9/MQ2wUzg93Ra5Z39s7w3zPxuQypI+akwkM+17r8CVOkdNAL8LC0o6/yeHPTOQmhN3540WOoa3Rkd/nzocTT+9ItmMbaafmT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739492856; c=relaxed/simple;
	bh=lzasSBqCZsMzMvKJCwaSsF4RMTN7fMcWPM3EndeXCHQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=l5LBOIBFcLDJ/cueXjluBxJzgi1Y/OR9dnkoxkbD2s7iO82zY+0zsmH2VjxOV1nMQRw/tBByofgQ+PE8Cpsa09IwB4jiIOOkS/DZ+cZxSEqy/D80EHPUVvs//e+JRhqDRmRjM/Gv7um8Jlwjj40ZgEQk5DukyPHtbxNW+NMgLOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qH1XZ621; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qH1XZ621"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D8AC4CED1;
	Fri, 14 Feb 2025 00:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739492856;
	bh=lzasSBqCZsMzMvKJCwaSsF4RMTN7fMcWPM3EndeXCHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qH1XZ621nEUET6F0YY9IRFEI3iH78nnMtXZQUpQCGsVkIsc/O6Q1FTIhOnSL3PkGK
	 Zqi/DWQamtRrio1rqxOmOkXsj3hldbZHHq7ZIukZRuxBErqp3Ffii9bSsBZ84uZwh2
	 YJT/LLeDvDLH5aK3zsDWAf5ferPja3MY52/hyS2e5K7g/QeQU+FZCQHDly2mJ8XIff
	 fUUfaCuPsVel45udJ0l0yC8Jfl1jNg652tBhTXNGBPdbQ7R2OKJ4Tae8q2jhkI8Oco
	 wFdPmtTtivZ1UymPFgC/i4K1Ft/jRZO2XFSB4yrMu/DtN8D5XAgNmDEOWFXSxHOnla
	 XNDih8tUaYMSQ==
Date: Fri, 14 Feb 2025 09:27:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH] tracing: Have the error of
 __tracing_resize_ring_buffer() passed to user
Message-Id: <20250214092732.32e4a05358f2e9a96fecf5d7@kernel.org>
In-Reply-To: <20250213134132.7e4505d7@gandalf.local.home>
References: <20250213134132.7e4505d7@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 13:41:32 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Currently if __tracing_resize_ring_buffer() returns an error, the
> tracing_resize_ringbuffer() returns -ENOMEM. But it may not be a memory
> issue that caused the function to fail. If the ring buffer is memory
> mapped, then the resizing of the ring buffer will be disabled. But if the
> user tries to resize the buffer, it will get an -ENOMEM returned, which is
> confusing because there is plenty of memory. The actual error returned was
> -EBUSY, which would make much more sense to the user.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Cc: stable@vger.kernel.org
> Fixes: 117c39200d9d7 ("ring-buffer: Introducing ring-buffer mapping functions")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 1496a5ac33ae..25ff37aab00f 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5977,8 +5977,6 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
>  ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
>  				  unsigned long size, int cpu_id)
>  {
> -	int ret;
> -
>  	guard(mutex)(&trace_types_lock);
>  
>  	if (cpu_id != RING_BUFFER_ALL_CPUS) {
> @@ -5987,11 +5985,7 @@ ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
>  			return -EINVAL;
>  	}
>  
> -	ret = __tracing_resize_ring_buffer(tr, size, cpu_id);
> -	if (ret < 0)
> -		ret = -ENOMEM;
> -
> -	return ret;
> +	return __tracing_resize_ring_buffer(tr, size, cpu_id);
>  }
>  
>  static void update_last_data(struct trace_array *tr)
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
