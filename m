Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7CD19DF9E;
	Fri, 11 Oct 2024 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728665617; cv=none; b=a9ukqunIgTHN7+HE48mtCReO4v4eKotAvwSUB64OLPpY+7+8i8Q4uv8AZ+qwKenrsXK0HHL4YK+LXto0exmsU6aryskBvsCWM0IN+yx0Wv2xAezyrTmYsdwuKj/Xe1pEhFUPxlTSnUQByvyYOWNXEdWg582jcpIhvcwBg54+NAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728665617; c=relaxed/simple;
	bh=Y4SVNKt9XFjLaD9B8pcqDTkmKM3gcnH+xqX6wTR5iJE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KX3ZsyYb47NJsnOP6KhYFA8SPZPCk04OarBH4/mF3ZwyZH+WFx3Fv5vt5zbc+DHvELMH7amrbsCl3++UB3FNw32EsqwbY8zc5vjdkxy4gOVuKm7LPPMvAFaYoEcUHdUsz5VNjKmkEIm1CUFSP+L52Ho4J8LSPkzQmgtJOJtgjFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5C6C4CEC3;
	Fri, 11 Oct 2024 16:53:36 +0000 (UTC)
Date: Fri, 11 Oct 2024 12:53:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Have the buffer update counter be atomic
Message-ID: <20241011125346.5edffba6@gandalf.local.home>
In-Reply-To: <84179edb-dba1-42fd-88a9-70d05d8915ec@suse.com>
References: <20241010195849.2f77cc3f@gandalf.local.home>
	<1924e096-916a-4311-a3d5-07d3813f50da@suse.com>
	<20241011100132.456f903a@gandalf.local.home>
	<20241011104848.7f5b180b@gandalf.local.home>
	<84179edb-dba1-42fd-88a9-70d05d8915ec@suse.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 17:20:12 +0200
Petr Pavlu <petr.pavlu@suse.com> wrote:

> >From 359f5aa523bc27ca8600b4efae471eefc0514ce0 Mon Sep 17 00:00:00 2001  
> From: Petr Pavlu <petr.pavlu@suse.com>
> Date: Tue, 16 Jul 2024 11:35:00 +0200
> Subject: [PATCH] ring-buffer: Fix reader locking when changing the sub buffer
>  order
> 
> The function ring_buffer_subbuf_order_set() updates each
> ring_buffer_per_cpu and installs new sub buffers that match the requested
> page order. This operation may be invoked concurrently with readers that
> rely on some of the modified data, such as the head bit (RB_PAGE_HEAD), or
> the ring_buffer_per_cpu.pages and reader_page pointers. However, no
> exclusive access is acquired by ring_buffer_subbuf_order_set(). Modyfing
> the mentioned data while a reader also operates on them can then result in
> incorrect memory access and various crashes.
> 
> Fix the problem by taking the reader_lock when updating a specific
> ring_buffer_per_cpu in ring_buffer_subbuf_order_set().
> 
> Fixes: 8e7b58c27b3c ("ring-buffer: Just update the subbuffers when changing their allocation order")
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  kernel/trace/ring_buffer.c | 41 ++++++++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 4c24191fa47d..d324f4f9ab9d 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -6773,36 +6773,38 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  	}
>  
>  	for_each_buffer_cpu(buffer, cpu) {
> +		struct buffer_data_page *old_free_data_page;
> +		struct list_head old_pages;
> +		unsigned long flags;
>  
>  		if (!cpumask_test_cpu(cpu, buffer->cpumask))
>  			continue;
>  
>  		cpu_buffer = buffer->buffers[cpu];
>  
> +		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> +
>  		/* Clear the head bit to make the link list normal to read */
>  		rb_head_page_deactivate(cpu_buffer);
>  
> -		/* Now walk the list and free all the old sub buffers */
> -		list_for_each_entry_safe(bpage, tmp, cpu_buffer->pages, list) {
> -			list_del_init(&bpage->list);
> -			free_buffer_page(bpage);
> -		}
> -		/* The above loop stopped an the last page needing to be freed */
> -		bpage = list_entry(cpu_buffer->pages, struct buffer_page, list);
> -		free_buffer_page(bpage);
> -
> -		/* Free the current reader page */
> -		free_buffer_page(cpu_buffer->reader_page);
> +		/*
> +		 * Collect buffers from the cpu_buffer pages list and the
> +		 * reader_page on old_pages, so they can be freed later when not
> +		 * under a spinlock. The pages list is a linked list with no
> +		 * head, adding old_pages turns it into a regular list with
> +		 * old_pages being the head.
> +		 */
> +		list_add(&old_pages, cpu_buffer->pages);
> +		list_add(&cpu_buffer->reader_page->list, &old_pages);
>  
>  		/* One page was allocated for the reader page */
>  		cpu_buffer->reader_page = list_entry(cpu_buffer->new_pages.next,
>  						     struct buffer_page, list);
>  		list_del_init(&cpu_buffer->reader_page->list);
>  
> -		/* The cpu_buffer pages are a link list with no head */
> +		/* Install the new pages, remove the head from the list */
>  		cpu_buffer->pages = cpu_buffer->new_pages.next;
> -		cpu_buffer->new_pages.next->prev = cpu_buffer->new_pages.prev;
> -		cpu_buffer->new_pages.prev->next = cpu_buffer->new_pages.next;
> +		list_del(&cpu_buffer->new_pages);

Heh, not sure why I didn't just use list_del() on the head itself instead
of open coding it. But anyway, it should be list_del_init(), as I will
likely remove the initialization of new_pages and have it always be
initialized. I rather have it clean than pointing to something unknown.

Care to send this as a real patch?

We can look at any other locking issues here separately, but this should be
fixed now.

-- Steve


>  		cpu_buffer->cnt++;
>  
>  		/* Clear the new_pages list */
> @@ -6815,11 +6817,20 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  		cpu_buffer->nr_pages = cpu_buffer->nr_pages_to_update;
>  		cpu_buffer->nr_pages_to_update = 0;
>  
> -		free_pages((unsigned long)cpu_buffer->free_page, old_order);
> +		old_free_data_page = cpu_buffer->free_page;
>  		cpu_buffer->free_page = NULL;
>  
>  		rb_head_page_activate(cpu_buffer);
>  
> +		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> +
> +		/* Free old sub buffers */
> +		list_for_each_entry_safe(bpage, tmp, &old_pages, list) {
> +			list_del_init(&bpage->list);
> +			free_buffer_page(bpage);
> +		}
> +		free_pages((unsigned long)old_free_data_page, old_order);
> +
>  		rb_check_pages(cpu_buffer);
>  	}
>  
