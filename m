Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD22E226161;
	Wed, 14 May 2025 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747227654; cv=none; b=Duboz/Zv6qbr2nlX2manPHAHFkKwv7Jyy9vRQ0yUUKlAWDSeM0xjzyYkGVKbYpV0aaPD4ihcbLTu6dm1Ra44kEP0Gcf4QbTCsT8uU2KqaF66GOVLPCws+fBW+B3ZrHKCWZP74LDUaqmCfF5AiIaT3BTMyzgv7ihN0qZrEoqQ58A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747227654; c=relaxed/simple;
	bh=CEiFtx7FE/2HC35P4zMuC7HYmQigEV5gQ/191dTVZpM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDlA42hhp6RYoBKhP1cXqJ0XBdAW1NkYXT7Cw/mUdM8nTcsLFuaN+aM0xy/K0Je7O6nSdcRoswxYYSHU6pEgip4zAGl2hsjw4JSbmYkjyWewx7kFE5yrgemBaj5Jli8bgmrfMF0Dex3dwVOivYLtS8DbRoGcPo7EldEJEL5aHjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF36C4CEE9;
	Wed, 14 May 2025 13:00:53 +0000 (UTC)
Date: Wed, 14 May 2025 09:00:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tracing: ring_buffer: Rewind persistent ring buffer
 when reboot
Message-ID: <20250514090050.52db97ed@batman.local.home>
In-Reply-To: <20250514150059.6edf09bd72862ca175b64c98@kernel.org>
References: <174709742769.1964496.18203163435305117893.stgit@mhiramat.tok.corp.google.com>
	<20250513203237.0e7ff662@gandalf.local.home>
	<20250514150059.6edf09bd72862ca175b64c98@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 May 2025 15:00:59 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > 
> > Is that a problem? I'm thinking that the data in the buffer should not be
> > used.  
> 
> Yes, even if we read (dump) the previous boot data, the data is
> in the buffer. Thus the kernel rebooted before reusing the buffer
> the dumped pages are recovered again. Unless comparing with the
> previous dump data, we can not know this data is older boot or not.
> Anyway, user can avoid this issue by clearing the trace buffer
> explicitly.

What we could do, and I don't think this would be too hard, is once the
buffer is empty and it's still LAST_BOOT buffer, we simply clear it in
the kernel.

That way after a reboot, a read of trace_pipe that reads the entire
buffer will end up resetting the buffer, and I think that will solve
this problem.



> > +
> > +		/* Stop rewind if the page is invalid. */
> > +		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu);
> > +		if (ret < 0)
> > +			break;
> > +
> > +		/* Recover the number of entries. */
> > +		local_set(&head_page->entries, ret);
> > +		if (ret)
> > +			local_inc(&cpu_buffer->pages_touched);
> > +		entries += ret;
> > +		entry_bytes += rb_page_commit(head_page);  
> 
> If we validate the pages again later (because fixing head_page),
> we can skip this part.

The validator takes a bit of time. I would rather not do another loop
if we don't have to. If this is duplicate code, lets just make a static
inline helper function that does it and use that in both places.

> 
> > +	}
> > +
> > +	/* The last rewind page must be skipped. */
> > +	if (head_page != orig_head)
> > +		rb_inc_page(&head_page);
> > +
> > +	if (head_page != orig_head) {  
> 
> Ah, I forgot this part (setup new reader_page)
> 
> > +		struct buffer_page *bpage = orig_head;
> > +
> > +		rb_dec_page(&bpage);
> > +		/*
> > +		 * Move the reader page between the orig_head and the page
> > +		 * before it.
> > +		 */  
> -----
> > +		cpu_buffer->reader_page->list.next = &orig_head->list;
> > +		cpu_buffer->reader_page->list.prev = orig_head->list.prev;
> > +		orig_head->list.prev = &cpu_buffer->reader_page->list;
> > +
> > +		bpage->list.next = &cpu_buffer->reader_page->list;  
> -----
> These seems the same as (because head_page->list.prev->next encodes
> flags, but we don't read that pointer.);
> 
> 		list_insert(&orig_head->list, &cpu_buffer->reader_page->list);

I thought about this, but because the pointers are used to encode
flags, I try to avoid using the list_*() functions all together on
these. Just to remind everyone that these are "special" lists.

I prefer it open coded because that way I can see exactly what it is
doing. Note, this is not just assigning pointers, it is also clearing
flags in the process.

We could add a comment that states something like:

	/*
	 * This is the same as:
	 *   list_insert(&orig_head->list, &cpu_buffer->read_page->list);
	 * but as it is also clearing flags, its open coded so that
	 * there's no chance that list_insert() gets optimized where
	 * it doesn't do the extra work that this is doing.
	 */

?

-- Steve


> 
> > +
> > +		/* Make the head_page the new reader page */
> > +		cpu_buffer->reader_page = head_page;
> > +		bpage = head_page;
> > +		rb_inc_page(&head_page);
> > +		head_page->list.prev = bpage->list.prev;
> > +		rb_dec_page(&bpage);
> > +		bpage->list.next = &head_page->list;
> > +		rb_set_list_to_head(&bpage->list);
> > +
> > +		cpu_buffer->head_page = head_page;
> > +		meta->head_buffer = (unsigned long)head_page->page;
> > +
> > +		/* Reset all the indexes */
> > +		bpage = cpu_buffer->reader_page;
> > +		meta->buffers[0] = rb_meta_subbuf_idx(meta, bpage->page);
> > +		bpage->id = 0;
> > +
> > +		for (i = 0, bpage = head_page; i < meta->nr_subbufs;
> > +		     i++, rb_inc_page(&bpage)) {
> > +			meta->buffers[i + 1] = rb_meta_subbuf_idx(meta, bpage->page);
> > +			bpage->id = i + 1;
> > +		}
> > +		head_page = orig_head;
> > +	}
> > +
> >  	/* Iterate until finding the commit page */
> >  	for (i = 0; i < meta->nr_subbufs + 1; i++, rb_inc_page(&head_page)) {
> >  
> > @@ -5348,7 +5439,6 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
> >  	 */
> >  	local_set(&cpu_buffer->reader_page->write, 0);
> >  	local_set(&cpu_buffer->reader_page->entries, 0);
> > -	local_set(&cpu_buffer->reader_page->page->commit, 0);
> >  	cpu_buffer->reader_page->real_end = 0;
> >  
> >   spin:
> > @@ -6642,7 +6732,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
> >  		cpu_buffer->read_bytes += rb_page_size(reader);
> >  
> >  		/* swap the pages */
> > -		rb_init_page(bpage);
> > +//		rb_init_page(bpage);
> >  		bpage = reader->page;
> >  		reader->page = data_page->data;
> >  		local_set(&reader->write, 0);  
> 
> Thank you,
> 
> 
> 

