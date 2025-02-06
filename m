Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B52320C010;
	Thu,  6 Feb 2025 05:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738818802; cv=none; b=dM+N/gTfDhLBAwlI4x27bnu0y6P1t2JZeKC3hOjY995TcUw6d9p33RTJpPq1A20w2H5Qkd/w128RSiZltVZJAbKNoQMpWtkTSHJmS6icJMSHvJe+3kpTWUHpDiiXzdNz+gOB7vEKCzHPA1tgTro3By7MafWVfTY8m7c15PuorEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738818802; c=relaxed/simple;
	bh=6U6rh7JhUa1YbP+LLlQK5bZm8TU8GDtRTJ5VkIXoCJg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JQEAezuBthRI5i9AOvuOkiL+FtxskGDatysKZZ9WqH18QWnm13uy2xtlOibK1q/PmYprGqjlHsaJj9QESa494s8Vzf8KvwK7CYonx5w61em958sb9VvD73tGSSO6cVpFS3Xk6uYSOcs1qiUYI8tEuAftCyo72//KwkUX6J8zW7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mc22Owh0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mc22Owh0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31618C4CEDD;
	Thu,  6 Feb 2025 05:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738818802;
	bh=6U6rh7JhUa1YbP+LLlQK5bZm8TU8GDtRTJ5VkIXoCJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mc22Owh0bBn6pbCdMD/oCUJOMqaDK9YmXVXL6XSE+JcSywDB6uDI/cT/FDJvCleWp
	 7QuC4ICeWMWScWdoOkO6NsZdA3V+IYGTif6lFYLT5NtZ+CTxghPVL6F8KbhQLMyxAQ
	 z4kBZKxeFjhuq5WuaJThidnayADjr36X/pVUOhAtgVvw6KgTGpT287BjMO/9+zyXLB
	 SLz52un72oJRc76g/8uzfI/PuxYU9rWaPsbD1mvGq2JGe2WDwc2q5iSv0u7aCQ7PdW
	 /WY1QXOWk/4QGXkPzOsitzVigyUt/xEMs5OPeJAbvoo0c+euMjCgL7smQqBRCPYmxG
	 tneYsuJ+IsxaQ==
Date: Thu, 6 Feb 2025 14:13:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/8] ring-buffer: Add ring_buffer_meta_scratch()
Message-Id: <20250206141318.21e9d801e599eda5a3f40bd0@kernel.org>
In-Reply-To: <20250205225103.425325060@goodmis.org>
References: <20250205225031.799739376@goodmis.org>
	<20250205225103.425325060@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Feb 2025 17:50:34 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Now that there's one page at the start of the persistent memory used by
> the ring buffer, make the part of that page that is not used by the ring
> buffer available for the tracer to use. This will allow the tracer to
> store its own persistent data.

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/linux/ring_buffer.h |  1 +
>  kernel/trace/ring_buffer.c  | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> index 8de035f4f0d9..b95f940fd07a 100644
> --- a/include/linux/ring_buffer.h
> +++ b/include/linux/ring_buffer.h
> @@ -95,6 +95,7 @@ struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flag
>  					       struct lock_class_key *key);
>  
>  bool ring_buffer_last_boot_delta(struct trace_buffer *buffer, unsigned long *kaslr_addr);
> +void *ring_buffer_meta_scratch(struct trace_buffer *buffer, unsigned int *size);
>  
>  /*
>   * Because the ring buffer is generic, if other users of the ring buffer get
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 0446d053dbd6..5a81ff785665 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1730,6 +1730,9 @@ static bool rb_meta_init(struct trace_buffer *buffer)
>  	bmeta->total_size = total_size;
>  	bmeta->buffers_offset = (void *)ptr - (void *)bmeta;
>  
> +	/* Zero out the scatch pad */
> +	memset((void *)bmeta + sizeof(*bmeta), 0, PAGE_SIZE - sizeof(*bmeta));
> +
>  	return false;
>  }
>  
> @@ -2532,6 +2535,16 @@ bool ring_buffer_last_boot_delta(struct trace_buffer *buffer, unsigned long *kas
>  	return true;
>  }
>  
> +void *ring_buffer_meta_scratch(struct trace_buffer *buffer, unsigned int *size)
> +{
> +	if (!buffer || !buffer->meta)
> +		return NULL;
> +
> +	*size = PAGE_SIZE - sizeof(*buffer->meta);
> +
> +	return (void *)buffer->meta + sizeof(*buffer->meta);
> +}
> +
>  /**
>   * ring_buffer_free - free a ring buffer.
>   * @buffer: the buffer to free.
> -- 
> 2.45.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
