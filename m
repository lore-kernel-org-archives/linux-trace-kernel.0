Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E91B1862;
	Fri,  4 Oct 2024 00:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728001175; cv=none; b=kDIyOue8V9PZ+8zcVCU7Dzy4eXU5J/cLIVMBriKtOg/7/ceC/2FTnrcc6AZf3FhZpVvGFC+k6JEhQEpiMpWr4lazhd/04rmuqnpSKXxBTxv0ludcoYiekE82fdSy4Prz/BuTmqFjV2FedBazQBXEl40hIjgJb+sVnnj+f52Ch5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728001175; c=relaxed/simple;
	bh=XaJUPZCks302pVBWtkcyiWqjkfs70i0GiODJ/tT25Do=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jXl9v8W58saZ/IZ0ROw6aPZxAOVgVs/aG0uNoh9hcMM4g2O5ZAW/gllw/B200lZ0KR84tPBT5cuUKV3B0rLWFUjE0DJ3An2B+AXBhzExK4Wen2g0FvTk9ObjJpst1BB3OTqN3l0+Q6WcjIMLxoI8EqfHwv8LjXIOAndZvB7WKt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34846C4CEC5;
	Fri,  4 Oct 2024 00:19:34 +0000 (UTC)
Date: Thu, 3 Oct 2024 20:20:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ring-buffer: Limit time with disabled interrupts in
 rb_check_pages()
Message-ID: <20241003202028.75007987@gandalf.local.home>
In-Reply-To: <20240715145141.5528-1-petr.pavlu@suse.com>
References: <20240715145141.5528-1-petr.pavlu@suse.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jul 2024 16:51:41 +0200
Petr Pavlu <petr.pavlu@suse.com> wrote:


I finally got around to looking at this. Sorry for the delay.

> The function rb_check_pages() validates the integrity of a specified
> per-CPU tracing ring buffer. It does so by traversing the underlying
> linked list and checking its next and prev links.
> 
> To guarantee that the list isn't modified during the check, a caller
> typically needs to take cpu_buffer->reader_lock. This prevents the check
> from running concurrently, for example, with a potential reader which
> can make the list temporarily inconsistent when swapping its old reader
> page into the buffer.
> 
> A problem with this approach is that the time when interrupts are
> disabled is non-deterministic, dependent on the ring buffer size. This
> particularly affects PREEMPT_RT because the reader_lock is a raw
> spinlock which doesn't become sleepable on PREEMPT_RT kernels.
> 
> Modify the check so it still attempts to traverse the entire list, but
> gives up the reader_lock between checking individual pages. Introduce
> for this purpose a new variable ring_buffer_per_cpu.cnt which is bumped
> any time the list is modified. The value is used by rb_check_pages() to
> detect such a change and restart the check.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
> 
> This is a follow-up to the discussion about improving this check [1].
> 
> Changes since v2 [2]:
> * Call the new generation variable as ring_buffer_per_cpu.cnt.
> 
> Changes since v1 [3]:
> * Correct the case when rb_check_pages() is invoked concurrently with
>   the resize code which modifies the list. Introduce
>   ring_buffer_per_cpu.pages_era for this purpose.
> 
> [1] https://lore.kernel.org/linux-trace-kernel/20240517134008.24529-1-petr.pavlu@suse.com/
> [2] https://lore.kernel.org/linux-trace-kernel/20240703075314.23511-1-petr.pavlu@suse.com/
> [2] https://lore.kernel.org/linux-trace-kernel/20240621150956.24814-1-petr.pavlu@suse.com/
> 
>  kernel/trace/ring_buffer.c | 98 ++++++++++++++++++++++++++++----------
>  1 file changed, 72 insertions(+), 26 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 28853966aa9a..0279b4ee0b03 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -462,6 +462,8 @@ struct ring_buffer_per_cpu {
>  	unsigned long			nr_pages;
>  	unsigned int			current_context;
>  	struct list_head		*pages;
> +	/* pages generation counter, incremented when the list changes */
> +	unsigned long			cnt;
>  	struct buffer_page		*head_page;	/* read from head */
>  	struct buffer_page		*tail_page;	/* write to tail */
>  	struct buffer_page		*commit_page;	/* committed pages */
> @@ -1454,40 +1456,87 @@ static void rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
>  	RB_WARN_ON(cpu_buffer, val & RB_FLAG_MASK);
>  }
>  
> +static bool rb_check_links(struct ring_buffer_per_cpu *cpu_buffer,
> +			   struct list_head *list)
> +{
> +	if (RB_WARN_ON(cpu_buffer,
> +		       rb_list_head(rb_list_head(list->next)->prev) != list))
> +		return false;
> +
> +	if (RB_WARN_ON(cpu_buffer,
> +		       rb_list_head(rb_list_head(list->prev)->next) != list))
> +		return false;
> +
> +	return true;
> +}
> +
>  /**
>   * rb_check_pages - integrity check of buffer pages
>   * @cpu_buffer: CPU buffer with pages to test
>   *
>   * As a safety measure we check to make sure the data pages have not
>   * been corrupted.
> - *
> - * Callers of this function need to guarantee that the list of pages doesn't get
> - * modified during the check. In particular, if it's possible that the function
> - * is invoked with concurrent readers which can swap in a new reader page then
> - * the caller should take cpu_buffer->reader_lock.
>   */
>  static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
>  {
> -	struct list_head *head = rb_list_head(cpu_buffer->pages);
> -	struct list_head *tmp;
> +	struct list_head *head, *tmp;
> +	unsigned long buffer_cnt;
> +	unsigned long flags;
> +	int nr_loops = 0;
>  
> -	if (RB_WARN_ON(cpu_buffer,
> -			rb_list_head(rb_list_head(head->next)->prev) != head))
> +	/*
> +	 * Walk the linked list underpinning the ring buffer and validate all
> +	 * its next and prev links.
> +	 *
> +	 * The check acquires the reader_lock to avoid concurrent processing
> +	 * with code that could be modifying the list. However, the lock cannot
> +	 * be held for the entire duration of the walk, as this would make the
> +	 * time when interrupts are disabled non-deterministic, dependent on the
> +	 * ring buffer size. Therefore, the code releases and re-acquires the
> +	 * lock after checking each page. The ring_buffer_per_cpu.cnt variable
> +	 * is then used to detect if the list was modified while the lock was
> +	 * not held, in which case the check needs to be restarted.
> +	 *
> +	 * The code attempts to perform the check at most three times before
> +	 * giving up. This is acceptable because this is only a self-validation
> +	 * to detect problems early on. In practice, the list modification
> +	 * operations are fairly spaced, and so this check typically succeeds at
> +	 * most on the second try.
> +	 */
> +again:
> +	if (++nr_loops > 3)
>  		return;
>  
> -	if (RB_WARN_ON(cpu_buffer,
> -			rb_list_head(rb_list_head(head->prev)->next) != head))
> -		return;
> +	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> +	head = rb_list_head(cpu_buffer->pages);
> +	if (!rb_check_links(cpu_buffer, head))
> +		goto out_locked;
> +	buffer_cnt = cpu_buffer->cnt;
> +	tmp = head;
> +	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>  
> -	for (tmp = rb_list_head(head->next); tmp != head; tmp = rb_list_head(tmp->next)) {
> -		if (RB_WARN_ON(cpu_buffer,
> -				rb_list_head(rb_list_head(tmp->next)->prev) != tmp))
> -			return;
> +	while (true) {
> +		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
>  
> -		if (RB_WARN_ON(cpu_buffer,
> -				rb_list_head(rb_list_head(tmp->prev)->next) != tmp))
> -			return;
> +		if (buffer_cnt != cpu_buffer->cnt) {
> +			/* The list was updated, try again. */
> +			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> +			goto again;
> +		}
> +
> +		tmp = rb_list_head(tmp->next);
> +		if (tmp == head)
> +			/* The iteration circled back, all is done. */
> +			goto out_locked;
> +
> +		if (!rb_check_links(cpu_buffer, tmp))
> +			goto out_locked;
> +
> +		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>  	}
> +
> +out_locked:
> +	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>  }
>  
>  static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
> @@ -1874,6 +1923,7 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
>  
>  	/* make sure pages points to a valid page in the ring buffer */
>  	cpu_buffer->pages = next_page;
> +	cpu_buffer->cnt++;
>  
>  	/* update head page */
>  	if (head_bit)
> @@ -1980,6 +2030,7 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
>  			 * pointer to point to end of list
>  			 */
>  			head_page->prev = last_page;
> +			cpu_buffer->cnt++;
>  			success = true;
>  			break;
>  		}
> @@ -2215,12 +2266,8 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
>  		 */
>  		synchronize_rcu();
>  		for_each_buffer_cpu(buffer, cpu) {
> -			unsigned long flags;
> -
>  			cpu_buffer = buffer->buffers[cpu];
> -			raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
>  			rb_check_pages(cpu_buffer);
> -			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>  		}
>  		atomic_dec(&buffer->record_disabled);
>  	}
> @@ -4611,6 +4658,7 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
>  	rb_list_head(reader->list.next)->prev = &cpu_buffer->reader_page->list;
>  	rb_inc_page(&cpu_buffer->head_page);
>  
> +	cpu_buffer->cnt++;
>  	local_inc(&cpu_buffer->pages_read);
>  
>  	/* Finally update the reader page to the new head */
> @@ -5150,12 +5198,9 @@ void
>  ring_buffer_read_finish(struct ring_buffer_iter *iter)
>  {
>  	struct ring_buffer_per_cpu *cpu_buffer = iter->cpu_buffer;
> -	unsigned long flags;
>  
>  	/* Use this opportunity to check the integrity of the ring buffer. */
> -	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
>  	rb_check_pages(cpu_buffer);
> -	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>  
>  	atomic_dec(&cpu_buffer->resize_disabled);
>  	kfree(iter->event);
> @@ -6050,6 +6095,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  		cpu_buffer->pages = cpu_buffer->new_pages.next;
>  		cpu_buffer->new_pages.next->prev = cpu_buffer->new_pages.prev;
>  		cpu_buffer->new_pages.prev->next = cpu_buffer->new_pages.next;
> +		cpu_buffer->cnt++;

Everything looks good but this cnt update isn't protected. Probably doesn't
matter but it feels like it should be. Perhaps we can just convert it to an
atomic?

-- Steve


>  
>  		/* Clear the new_pages list */
>  		INIT_LIST_HEAD(&cpu_buffer->new_pages);
> 
> base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd

