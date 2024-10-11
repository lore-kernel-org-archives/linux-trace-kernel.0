Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E889A1C6F5F;
	Fri, 11 Oct 2024 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666554; cv=none; b=TVN5tOBNS0uyMK63gacDRoHkqz070OdvPa5Q9H+4k93kOQE/xwfgK2cGDI12VBvx4tRHyZ6U+K/qcILnq9IOFKDERZ+U9P4pVH4Pvncq/gxOKLvqe6GqbMkYn2WzI9rKzcbPR98n9cXX0ktvnQZ3IsyuJcrcZQ6IEM4BjK4xRo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666554; c=relaxed/simple;
	bh=1a4+zVpRoW+qaIWefQEswXEmC2zFkUW2fpRSJ6FJpxM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IA9Qpm7v1vs1CXOeuuUFapi4hmV13ijy4/zZqeB5yxysh1dQ+ZbOOBMe/lLzv6XvLf94sjSE/faDSRNpf4WVPucx5ivh6mIAzisjXUNoxRBGnYsEmgvyb5XIgLKdgPG8WyUmudKaT5kcxbzTqtlDowU9X/fHb1K3ZJ40Zywcxwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49BAC4CED4;
	Fri, 11 Oct 2024 17:09:12 +0000 (UTC)
Date: Fri, 11 Oct 2024 13:09:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Petr Pavlu <petr.pavlu@suse.com>
Subject: Re: [PATCH] ring-buffer: Synchronize ring_buffer_subbuf_order_set()
 with rb_check_pages()
Message-ID: <20241011130922.60cf66cf@gandalf.local.home>
In-Reply-To: <20241011112850.17212b25@gandalf.local.home>
References: <20241011112850.17212b25@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 11:28:50 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The rb_check_pages() scans the ring buffer sub buffers to make sure they
> are valid after an update. But locks are released during the update to not
> hold preemption for too long.
> 
> The ring_buffer_subbuf_order_set() updates the counter used by
> rb_check_pages() without any locks. But it also updates the pages. Even
> though it is likely that the buffer->mutex is enough to protect this, but
> since rb_check_pages() uses the cpu_buffer->reader_lock for
> synchronization, take that lock as well when updating the pages and
> counter in ring_buffer_subbuf_order_set().
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

I rejected this patch as I believe the version Petr has is required.

-- Steve

> ---
> Note, this is based on top of:
> 
>   https://lore.kernel.org/linux-trace-kernel/20240715145141.5528-1-petr.pavlu@suse.com/
> 
>  kernel/trace/ring_buffer.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 696d422d5b35..0672df07b599 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -6774,6 +6774,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  	}
>  
>  	for_each_buffer_cpu(buffer, cpu) {
> +		unsigned long flags;
>  
>  		if (!cpumask_test_cpu(cpu, buffer->cpumask))
>  			continue;
> @@ -6800,11 +6801,15 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  						     struct buffer_page, list);
>  		list_del_init(&cpu_buffer->reader_page->list);
>  
> +		/* Synchronize with rb_check_pages() */
> +		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> +
>  		/* The cpu_buffer pages are a link list with no head */
>  		cpu_buffer->pages = cpu_buffer->new_pages.next;
>  		cpu_buffer->new_pages.next->prev = cpu_buffer->new_pages.prev;
>  		cpu_buffer->new_pages.prev->next = cpu_buffer->new_pages.next;
>  		cpu_buffer->cnt++;
> +		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>  
>  		/* Clear the new_pages list */
>  		INIT_LIST_HEAD(&cpu_buffer->new_pages);

