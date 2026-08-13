Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72223380FEC;
	Thu, 13 Aug 2026 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786637934; cv=none; b=QXcJYN9weCPoaridrZv4xOEZJKvKBA/N0A2WVGOHjYMtftZpnelATPOxmNhqEcrPFSqpvsahXr3gx8tJEENkBqpeecu5x/HsOCgQKeppDofrnyPzrHJLYeL+fT8+q7FgYorIUen6gFiMq7n7X9Hm7IiH7M7HUQ/TiuYwjbMGXN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786637934; c=relaxed/simple;
	bh=DMewnovxthKp7l8w7dRnVgVLPUwaIRb6G56TUl+yzOw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OLRQsdRyheo9qHbpsrSVXDQmBlydhkX6gPp9YjwvbKXJFid4bqEeIq7xARACuy0rP+7nXhteG47ggDD0nxRoSN+EJGPUMCBa0OVCfYHQVQYf2SjlOB/MIj2jOl3HZ7dfp6ZnE37EsPi0IQQ8Weay3T0Itn3v4hw8Zp+1kStJEGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOIlPHwm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOIlPHwm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6C11F000E9;
	Thu, 13 Aug 2026 16:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786637929;
	bh=S8pmJG7RXhwxXc0l78ZDZzHu2uDxsfC0BDvGqhtWoK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SOIlPHwmciIaQeoVX4Uotxh9mYXKlTOt9wLT6G0NapvLkcLjpwlNv0iBTSViWWxKd
	 zBncKPoHN3jqC8GQkAtYHb/Gb6o2B4N1mJhHOyKkmagBzY6JW9l3yj+ux7suvFQdWX
	 E79hBsm3GTimxju9RRycLJfD7JMLtgow8s2dyZTgvAg/xsx9QN57rAMpjkBnq+eYBe
	 66IFTpM2WwNyAGK7l40U33XA2+aIzhMU6cOg5v7b+reDl8VIJ7HGbhmNe+1HfePNEl
	 Cs+Ug5O4G4g+p9HoHN35n+0vHgboLlrCUIJJywNVGxS5qN1jWHAqUP0lVogW/7wXj5
	 SToR5iFlEWXWg==
Date: Fri, 14 Aug 2026 01:18:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v5 01/10] ring-buffer: Free cpu_buffer::free_page with
 subbuf_order
Message-Id: <20260814011845.06da757640bd16bb3dc723a7@kernel.org>
In-Reply-To: <20260813131152.3589632-2-vdonnefort@google.com>
References: <20260813131152.3589632-1-vdonnefort@google.com>
	<20260813131152.3589632-2-vdonnefort@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 14:11:43 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> When sub-buffers use an order greater than 0, cpu_buffer->free_page is
> allocated with subbuf_order. Use the correct order for
> cpu_buffer->free_page.
> 
> Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

This looks good to me. (with fixing racing issue.)

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 2667992f0aa2..a3d28b2e2c94 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2631,7 +2631,7 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
>  		free_buffer_page(bpage);
>  	}
>  
> -	free_page((unsigned long)cpu_buffer->free_page);
> +	free_pages((unsigned long)cpu_buffer->free_page, cpu_buffer->buffer->subbuf_order);
>  
>  	kfree(cpu_buffer);
>  }
> -- 
> 2.55.0.691.gc56d675ccc-goog
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
