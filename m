Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F104522A
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Jun 2025 06:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749450303; cv=none; b=crNiTFhQvTpP77ImJxRVIVXuuz8WPac6HLtS5shU6z6vJF802C6DFU9rHab7bHul/d4Po4Wd6NDQzJqULN3QxssJ350FJi1rU3ZAqJz9Kfuj+iZlqfUVckY25b1M76yprNIsPUdgoZFBSpAri/A2ybTVjVRw2DqTNhljBiKLxA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749450303; c=relaxed/simple;
	bh=FDwySwbWdYzZTdWz+Mo5+rUSNr9zCN4gogJojzE3JTA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PjEPY75NyzVz/zhY/kGZ4Vp6sRCwS2jhYjXSIzhxTAWwjkEhrocEKkiOQYW9dkBvGiIjVRMgbFsOGSyapLInHBzf5dPyqa2nKJwp+/Y8NAlVRqpC/jcP6VM5sAPj5k6jWHiDJz6UggLY+Z56IXIHe66vXHpwKcVi5yFKHaGhzrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/vydeiJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/vydeiJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D446AC4CEEB;
	Mon,  9 Jun 2025 06:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749450303;
	bh=FDwySwbWdYzZTdWz+Mo5+rUSNr9zCN4gogJojzE3JTA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R/vydeiJfwZOn3sKUP6bxIGUubeaBm2Q1aP4g/jq8jrH8+FtfJ93hoSZmoB4xyGxP
	 7g7mbT2+7jN8690j2CAM93jPo+wQPtx7T9sUxMLgzrSWeclFfLs//2Jaz0iz0iglha
	 pnrrPebsRx20pHW3qUJz1vbDMTjQBqpQw7+B/5f1NFbIexIgjABHpIe39x1J0aMkaG
	 XARUsw5RqJ+iS3FTphSxQB5BvZdqxUYp8KTG5klxbozN19h3b0s5RDETRvegDB1Y0c
	 ikVJQHFQiJBx6T5c2VLqZvIZrno1WGehU6Tb8mBG/ptGpQH8Txk6nHo3QaEDcXFnQG
	 rXwB4NH/uODtw==
Date: Mon, 9 Jun 2025 15:25:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 linux-trace-kernel@vger.kernel.org,
 syzbot+05d673e83ec640f0ced9@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] ring-buffer: fix buffer locking in
 ring_buffer_subbuf_order_set()
Message-Id: <20250609152500.30f1a34ba10488f568f3a6cc@kernel.org>
In-Reply-To: <20250606112242.1510605-1-dmantipov@yandex.ru>
References: <20250606065124.07857968@gandalf.local.home>
	<20250606112242.1510605-1-dmantipov@yandex.ru>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Jun 2025 14:22:42 +0300
Dmitry Antipov <dmantipov@yandex.ru> wrote:

> In 'ring_buffer_subbuf_order_set()', prefer mutex guard over explicit
> mutex operations to ensure that the buffer remains locked everywhere
> where its innards may be changed, thus preventing per-CPU sub-buffer
> lists corruptions and other concurrency-related issues.
> 
> Reported-by: syzbot+05d673e83ec640f0ced9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=05d673e83ec640f0ced9
> Fixes: f9b94daa542a8 ("ring-buffer: Set new size of the ring buffer sub page")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
> v2: use mutex guard as suggested by Steven
> ---
>  kernel/trace/ring_buffer.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index e24509bd0af5..00fc38d70e86 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -6795,7 +6795,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  	old_size = buffer->subbuf_size;
>  
>  	/* prevent another thread from changing buffer sizes */
> -	mutex_lock(&buffer->mutex);
> +	guard(mutex)(&buffer->mutex);
>  	atomic_inc(&buffer->record_disabled);
>  
>  	/* Make sure all commits have finished */
> @@ -6900,7 +6900,6 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  	}
>  
>  	atomic_dec(&buffer->record_disabled);
> -	mutex_unlock(&buffer->mutex);
>  
>  	return 0;
>  
> @@ -6909,7 +6908,6 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  	buffer->subbuf_size = old_size;
>  
>  	atomic_dec(&buffer->record_disabled);
> -	mutex_unlock(&buffer->mutex);
>  
>  	for_each_buffer_cpu(buffer, cpu) {
>  		cpu_buffer = buffer->buffers[cpu];
> -- 
> 2.49.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
