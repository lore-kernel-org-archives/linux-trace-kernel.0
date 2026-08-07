Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA4F4B04BE;
	Fri,  7 Aug 2026 02:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786069094; cv=none; b=i1wYzTCqY8w8grWmIBsTlZMROhXso5/d6lxwuHkdwfwSDL8OOICnVhfN7YAXl1+S3j+aVEa096IbC33rywi7lsp6/b6bamfNg1JdWoN0BekC5mIHdzuqMRsYiRM3EJf39pvII+BGxqzq8p1+AJcVZzDKStzexaVESo9SXNgBlLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786069094; c=relaxed/simple;
	bh=o8xa0d4zP3W4d/qmgbw462IiVKZQW/RAb/fnn4glbMY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uvKmyfu9iEGGqyDAPSAQgMQsss5oIC3XNAc4FcvnyyraL60zsm/c9uzZgZ7jvT7FCLub/Fhv6aO6kDnubjDUA4hH+T4IOHt0aPzOtIENGB4UHNvmpIHBVNrbsOv8kvRr13trQxQHraem47nWoB66O1rnRFwNKoqpP3q+7aElVio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdznoxIw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdznoxIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06EA61F00A3A;
	Fri,  7 Aug 2026 02:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786069092;
	bh=S0MmS1X/o3qhSqO2FtU6A5NP/rsVHTbyLARehzpVOGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RdznoxIwmaSL6ojxwnx57vJjDEre2Cqs2guPmaxxszl+zLo98b7Hf+rtEOfDaWUAU
	 RfEXml4dWFOA4WUtkjrYJBucZI2JqpSNSZO1FUEQuPaYb2bsDtYrRO0lH29KsI9sI9
	 D7Y5KrEdpVMtxJBbgc8VSfdC34XHrrIYZn8kvkutaahGA1jZ3ftT2PnU+KTD7nczTz
	 fteDIVcVX3FsZM+ymbMZdvdr1+wERIqZigqfnTkIT3ENiF0nx+nkDenI9+CPTYEEAG
	 H+flOXe0BjGdlCwgnwM4ajzaeVVVjwXsUYmBF8J6PIpg1tjQgxrPkfjTy+0mmXLuLl
	 MD/vF2g5yyrdA==
Date: Fri, 7 Aug 2026 11:18:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] ring-buffer: Prevent resizing of persistent ring
 buffer
Message-Id: <20260807111808.d5dc1a48b080d241100f4a57@kernel.org>
In-Reply-To: <20260806211306.3704194-2-vdonnefort@google.com>
References: <20260806211306.3704194-1-vdonnefort@google.com>
	<20260806211306.3704194-2-vdonnefort@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Aug 2026 22:13:01 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> Dynamically resizing a persistent ring buffer is not possible. Disable
> the feature.

Is it true? Of course there is meaningless to resize the persistent
ring buffer (because it makes the buffer none-persistent), we are currently
allows user to resize it (like for resizing unused persistent ring buffer)

Thank you,

> 
> Fixes: be68d63a139b ("ring-buffer: Add ring_buffer_alloc_range()")
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 8e2485bb3aa8..afe75ad2bbf2 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2528,6 +2528,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
>  		if (cpu_buffer->ring_meta->head_buffer)
>  			rb_meta_buffer_update(cpu_buffer, bpage);
>  		bpage->range = 1;
> +
> +		atomic_inc(&cpu_buffer->resize_disabled);
>  	} else if (buffer->remote) {
>  		struct ring_buffer_desc *desc = ring_buffer_desc(buffer->remote->desc, cpu);
>  
> -- 
> 2.55.0.654.g21b8a5bc05-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
