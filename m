Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8C5131E2D;
	Wed, 28 May 2025 00:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748392498; cv=none; b=eJSna/NbfMKKak3kemk0v2fX1aeKh9rSByFPq1XKhIVtcL3v8gJ1Up7OBDnkeh47Wk5jOPMMGtEg4PZ5DMSU7m2pqCghrcgsKG1eKe3FYo+FXh4CZawLYGO7ceTYN8l5/zJqdJ/33ALIDnO3PwYuAyftpE2UKfFXkgQaOq6HlUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748392498; c=relaxed/simple;
	bh=7joA61mSXhPK4Gz+V3NOKCiVQxx33DUyoFse0xp5u5o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZmOkDLuys1gGwddYEFMegKsq+T7GxeaDKNgl9qMC6sy7QB2DfolHwXb6c5uMvpGrqehXZjxOUtzgi6U4b457ut98D9rNOin9RAXJU+YedCDq9RKigS5FwkQJZYXy1TuuRDm46Vq//Hgu97OMx+jH7Mg2DvXrIITMtkO/tCxQixg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4oagX55; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4oagX55"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB343C4CEE9;
	Wed, 28 May 2025 00:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748392497;
	bh=7joA61mSXhPK4Gz+V3NOKCiVQxx33DUyoFse0xp5u5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W4oagX55JNI1UKWpte8fkYtkEE/y3X7ph3czIZNvgsn5QcAUowp/TZwfr+Dxnd8T+
	 RFjiut6IYyhiuOzmG7kOgkmh2S1+PLVcb24ofZN31AJcH5tkFV1VWEnOCHqpXGdKS7
	 xLOcdKGpqvP6aeU1PCiAyI2kRgJy4mPHXfRCiS92E6nzFQ51BFd6Efoq657aOHcRne
	 W4PdyqeF6p1rNgDmI6qGwY4NtQdekMn8C+KJvZAOZjE4PclBcImX6JRYEnt3ZlcZLm
	 1iN6GtUPEVsrxDYLhqNCP8k4jd0mSsT4gNltgOuQ9LjEmlLjQQv4F2zdSpAR8Hq4j3
	 cDg9Ug6M+9Rmg==
Date: Wed, 28 May 2025 09:34:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Removed unnecessary if() goto out where
 out is the next line
Message-Id: <20250528093455.e710b3783bbdc93f8be66625@kernel.org>
In-Reply-To: <20250527155116.227f35be@gandalf.local.home>
References: <20250527155116.227f35be@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 May 2025 15:51:16 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> In the function ring_buffer_discard_commit() there's an if statement that
> jumps to the next line:
> 
> 	if (rb_try_to_discard(cpu_buffer, event))
> 		goto out;
>  out:
> 
> This was caused by the change that modified the way timestamps were taken
> in interrupt context, and removed the code between the if statement and
> the goto, but failed to update the conditional logic.
> 

OK, so this is a kind of cleanup.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Fixes: a389d86f7fd0 ("ring-buffer: Have nested events still record running time stamp")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index e2aa90dc8d9e..0a3be3a01d14 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -4681,10 +4681,7 @@ void ring_buffer_discard_commit(struct trace_buffer *buffer,
>  	RB_WARN_ON(buffer, !local_read(&cpu_buffer->committing));
>  
>  	rb_decrement_entry(cpu_buffer, event);
> -	if (rb_try_to_discard(cpu_buffer, event))
> -		goto out;
> -
> - out:
> +	rb_try_to_discard(cpu_buffer, event);
>  	rb_end_commit(cpu_buffer);
>  
>  	trace_recursive_unlock(cpu_buffer);
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
