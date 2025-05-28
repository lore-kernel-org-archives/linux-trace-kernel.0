Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5291972626;
	Wed, 28 May 2025 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748392208; cv=none; b=mVpG8Wdt546ieC2pEooJJiHqRe3YJ4/eQEC3MaNZaSajE+8fPxvb2tgZO/kwQETSFVuIm2nUNRBiWSshgqxduy2MOvSg6eztuJWuy8jzztS+a8G6Tlzg32A50WR0LcjqYGgLtYxw1lIKoxTbL7n/1cIvBqXf4WpbYK6X9KJw3Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748392208; c=relaxed/simple;
	bh=tPZMMdKen/ze34Aaff2EmTLJ5SQOS/s4Bb/Jsu8X6YQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WAA35+aIGhuNsJoilMogzvybNNKXwpmLgirZR0lDtt9aCAiS1t2rVBM/q3WBRZuloCfgtBIm5PWwkbbPOA1wq6UUrkSMekUPnPxhAhnIS881e5uH5h1yRpaLNr2x1FKjNQw+TEqmqJW3KbUyhjGusucmUDumAsO26g3uWnY7hy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t091MrYD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t091MrYD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82BDC4CEED;
	Wed, 28 May 2025 00:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748392207;
	bh=tPZMMdKen/ze34Aaff2EmTLJ5SQOS/s4Bb/Jsu8X6YQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t091MrYD7XEmFAgWyjVFHpReKtKQmNisaW8/Ede4KzmApfsf7CstGKWpTaDg48Y9z
	 KUUIxN5BFYGyVwpOAQ8kbYRFs6qy07gkNmWXsT7EG++jKu5UpTPbS3gqLpfjMDQTGk
	 zI8QuRXUqrXdZpDAdpiEw1o/kYOsxDZ9Q9ffZf2qLnPH1TOPknaBz8ymff9vI534Os
	 XjkXqolFvKGQybINnit2qDD7dTm7ESF3c4RvMHveOms6D+NIZqexsiu32rGxNXI4gV
	 OaM2RYCE/vOLDMcP8GePDz1EForQEjTrsh7MY/Wc3p8L1ZDuzLsFKzFFx8539Ge8xS
	 p0WUg7fOxaCsw==
Date: Wed, 28 May 2025 09:30:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Simplify reset_disabled_cpu_buffer() with
 use of guard()
Message-Id: <20250528093005.486a6fdbaae7976430680baf@kernel.org>
In-Reply-To: <20250527144623.77a9cc47@gandalf.local.home>
References: <20250527144623.77a9cc47@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 May 2025 14:46:23 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Use guard(raw_spinlock_irqsave)() in reset_disabled_cpu_buffer() to
> simplify the locking.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 10a4b26929ae..0b21d64e90c8 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -6112,21 +6112,16 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
>  /* Must have disabled the cpu buffer then done a synchronize_rcu */
>  static void reset_disabled_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
>  {
> -	unsigned long flags;
> -
> -	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> +	guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
>  
>  	if (RB_WARN_ON(cpu_buffer, local_read(&cpu_buffer->committing)))
> -		goto out;
> +		return;
>  
>  	arch_spin_lock(&cpu_buffer->lock);
>  
>  	rb_reset_cpu(cpu_buffer);
>  
>  	arch_spin_unlock(&cpu_buffer->lock);
> -
> - out:
> -	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>  }
>  
>  /**
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
