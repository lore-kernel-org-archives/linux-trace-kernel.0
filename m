Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C7A7483;
	Wed, 14 May 2025 06:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747202462; cv=none; b=JZHFzjKt27gF3UsxcbFsP4Vw6jTHDtm//7BOt4Mo76jimFmyRa8uravwIwzoR61m+vFNNnhTVsEUFpRRgikqut9iN/GGzREHYR+FhlUZzECMxR/YhNqgsh5sgAKIR+PdEEblfPYFXcFYzjDXtSB2xD+DDBJYtDS0sJlat6Vhj6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747202462; c=relaxed/simple;
	bh=yHv6rS6gL2MYW4viSWoozaWiw4C45EcPGXefNcUyB3Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Hs6EMPw8zgz1uemyQTKndbbhJtr5cgRG2Hdi7iPjLxYzKlSWdui38IYz6wHEs09P/YgTR7jZhe2zQGgZRa5K/vAdP+qaGIKsh1zC21O1Kh5vkoXzEoqTfKbw1/9quNt4+7oMK7gklYqFqBVQH0o4rSkrw/ZfyBf4Uplh/D2aTDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENEM804n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENEM804n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D30C4CEE9;
	Wed, 14 May 2025 06:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747202461;
	bh=yHv6rS6gL2MYW4viSWoozaWiw4C45EcPGXefNcUyB3Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ENEM804nXPIFDAlpSbciAAbRpAHV3+7bZgfb0vkvqvX1L8Jsc1SoO3mFwzPAQpuFT
	 v7/ejTqX0Ua/tOAD71JXOlMRaw/Cs24VUZkWQ6qiFL5UEEchXDSxErdynXsW8WOu5S
	 FfxMXRXaqo3LkXYOVNARtWRfKBkpgkw/dWgud+ENX8OWTNkTyyez4qbVolOxhCwHH6
	 QHcvdM80Fn0S6Ca30g3DI3f+946HRXltfabxMNfmNGedcm6z5tyjzsde/AdTTWccvJ
	 ak2+wLgkEf5uZ98cEFxkg9RYZruAjkHRlQf3XttVWxXAGJjT1BiMqPKSEVQ97Fw5+c
	 EScYe8JtNOfKA==
Date: Wed, 14 May 2025 15:00:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tracing: ring_buffer: Rewind persistent ring buffer
 when reboot
Message-Id: <20250514150059.6edf09bd72862ca175b64c98@kernel.org>
In-Reply-To: <20250513203237.0e7ff662@gandalf.local.home>
References: <174709742769.1964496.18203163435305117893.stgit@mhiramat.tok.corp.google.com>
	<20250513203237.0e7ff662@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 20:32:37 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 13 May 2025 09:50:27 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Rewind persistent ring buffer pages which have been read in the
> > previous boot. Those pages are highly possible to be lost before
> > writing it to the disk if the previous kernel crashed. In this
> > case, the trace data is kept on the persistent ring buffer, but
> > it can not be read because its commit size has been reset after
> > read.
> > This skips clearing the commit size of each sub-buffer and
> > recover it after reboot.
> > 
> > Note: If you read the previous boot data via trace_pipe, that
> > is not accessible in that time. But reboot without clearing (or
> > reusing) the read data, the read data is recovered again in the
> > next boot.
> > Thus, when you read the previous boot data, clear it by
> > `echo > trace`.
> 
> Is that a problem? I'm thinking that the data in the buffer should not be
> used.

Yes, even if we read (dump) the previous boot data, the data is
in the buffer. Thus the kernel rebooted before reusing the buffer
the dumped pages are recovered again. Unless comparing with the
previous dump data, we can not know this data is older boot or not.
Anyway, user can avoid this issue by clearing the trace buffer
explicitly.


> Anyway, I had to fix a bug with trace_pipe:
> 
>   https://lore.kernel.org/linux-trace-kernel/20250513115032.3e0b97f7@gandalf.local.home/
> 
> And with that applied, it doesn't rewind all the way, but still gives you
> what's left on the reader page. I think that is the case without this patch
> too.

OK.

> 
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/ring_buffer.c |   55
> > ++++++++++++++++++++++++++++++++++++++++++-- 1 file changed, 52
> > insertions(+), 3 deletions(-)
> 
> Anyway, I found that this is a lot more complex than what you have here. As
> the commit size is set to zero when added back into the ring buffer, I
> needed to remove that. But things get much more trickier than that!
> 
> First, we need to make the new head page found (the one that was read
> already) the new "reader page". And we need to insert the old reader page
> back into the ring buffer. And reset everything to handle all of this.

Yeah, I noticed the timestamps were messed up with my patch. That will
be sorted if we use external tools like perfetto, but still not good
for tracefs users.

> 
> I played a little with it, and came up with this. It's still a bit buggy,
> but it does give you an idea of what needs to be done.

Thanks! I will work on this version.

> 
> -- Steve
> 
> This is on top of the trace_pipe fix in the link above.
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 6859008ca34d..f5dd96ca25c9 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1358,6 +1358,13 @@ static inline void rb_inc_page(struct buffer_page **bpage)
>  	*bpage = list_entry(p, struct buffer_page, list);
>  }
>  
> +static inline void rb_dec_page(struct buffer_page **bpage)
> +{
> +	struct list_head *p = rb_list_head((*bpage)->list.prev);
> +
> +	*bpage = list_entry(p, struct buffer_page, list);
> +}
> +
>  static struct buffer_page *
>  rb_set_head_page(struct ring_buffer_per_cpu *cpu_buffer)
>  {
> @@ -1862,13 +1869,17 @@ static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu)
>  	return rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
>  }
>  
> +static void rb_update_meta_reader(struct ring_buffer_per_cpu *cpu_buffer,
> +				  struct buffer_page *reader);
> +
>  /* If the meta data has been validated, now validate the events */
>  static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
>  {
>  	struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
> -	struct buffer_page *head_page;
> +	struct buffer_page *head_page, *orig_head;
>  	unsigned long entry_bytes = 0;
>  	unsigned long entries = 0;
> +	u64 ts;
>  	int ret;
>  	int i;
>  
> @@ -1885,8 +1896,6 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
>  	entry_bytes += local_read(&cpu_buffer->reader_page->page->commit);
>  	local_set(&cpu_buffer->reader_page->entries, ret);
>  
> -	head_page = cpu_buffer->head_page;
> -
>  	/* If the commit_buffer is the reader page, update the commit page */
>  	if (meta->commit_buffer == (unsigned long)cpu_buffer->reader_page->page) {
>  		cpu_buffer->commit_page = cpu_buffer->reader_page;
> @@ -1894,6 +1903,88 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
>  		goto done;
>  	}
>  
> +	orig_head = head_page = cpu_buffer->head_page;
> +	ts = cpu_buffer->reader_page->page->time_stamp;

Nice catch! ts should be better here.

> +
> +	/*
> +	 * Try to rewind the head so that we can read the pages which already
> +	 * read in the previous boot.
> +	 */
> +	if (head_page != cpu_buffer->tail_page)
> +		rb_dec_page(&head_page);
> +
> +	for (i = 0; i < meta->nr_subbufs + 1; i++, rb_dec_page(&head_page)) {
> +
> +		/* Rewind until tail (writer) page. */
> +		if (head_page == cpu_buffer->tail_page)
> +			break;
> +
> +		if (ts < head_page->page->time_stamp)
> +			break;
> +
> +		ts = head_page->page->time_stamp;
> +		if (!ts)
> +			break;
> +
> +		if (rb_page_commit(head_page) == 0)
> +			break;

Ah, OK. the single 0 size page can be the end.

> +
> +		/* Stop rewind if the page is invalid. */
> +		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu);
> +		if (ret < 0)
> +			break;
> +
> +		/* Recover the number of entries. */
> +		local_set(&head_page->entries, ret);
> +		if (ret)
> +			local_inc(&cpu_buffer->pages_touched);
> +		entries += ret;
> +		entry_bytes += rb_page_commit(head_page);

If we validate the pages again later (because fixing head_page),
we can skip this part.

> +	}
> +
> +	/* The last rewind page must be skipped. */
> +	if (head_page != orig_head)
> +		rb_inc_page(&head_page);
> +
> +	if (head_page != orig_head) {

Ah, I forgot this part (setup new reader_page)

> +		struct buffer_page *bpage = orig_head;
> +
> +		rb_dec_page(&bpage);
> +		/*
> +		 * Move the reader page between the orig_head and the page
> +		 * before it.
> +		 */
-----
> +		cpu_buffer->reader_page->list.next = &orig_head->list;
> +		cpu_buffer->reader_page->list.prev = orig_head->list.prev;
> +		orig_head->list.prev = &cpu_buffer->reader_page->list;
> +
> +		bpage->list.next = &cpu_buffer->reader_page->list;
-----
These seems the same as (because head_page->list.prev->next encodes
flags, but we don't read that pointer.);

		list_insert(&orig_head->list, &cpu_buffer->reader_page->list);

> +
> +		/* Make the head_page the new reader page */
> +		cpu_buffer->reader_page = head_page;
> +		bpage = head_page;
> +		rb_inc_page(&head_page);
> +		head_page->list.prev = bpage->list.prev;
> +		rb_dec_page(&bpage);
> +		bpage->list.next = &head_page->list;
> +		rb_set_list_to_head(&bpage->list);
> +
> +		cpu_buffer->head_page = head_page;
> +		meta->head_buffer = (unsigned long)head_page->page;
> +
> +		/* Reset all the indexes */
> +		bpage = cpu_buffer->reader_page;
> +		meta->buffers[0] = rb_meta_subbuf_idx(meta, bpage->page);
> +		bpage->id = 0;
> +
> +		for (i = 0, bpage = head_page; i < meta->nr_subbufs;
> +		     i++, rb_inc_page(&bpage)) {
> +			meta->buffers[i + 1] = rb_meta_subbuf_idx(meta, bpage->page);
> +			bpage->id = i + 1;
> +		}
> +		head_page = orig_head;
> +	}
> +
>  	/* Iterate until finding the commit page */
>  	for (i = 0; i < meta->nr_subbufs + 1; i++, rb_inc_page(&head_page)) {
>  
> @@ -5348,7 +5439,6 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
>  	 */
>  	local_set(&cpu_buffer->reader_page->write, 0);
>  	local_set(&cpu_buffer->reader_page->entries, 0);
> -	local_set(&cpu_buffer->reader_page->page->commit, 0);
>  	cpu_buffer->reader_page->real_end = 0;
>  
>   spin:
> @@ -6642,7 +6732,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  		cpu_buffer->read_bytes += rb_page_size(reader);
>  
>  		/* swap the pages */
> -		rb_init_page(bpage);
> +//		rb_init_page(bpage);
>  		bpage = reader->page;
>  		reader->page = data_page->data;
>  		local_set(&reader->write, 0);

Thank you,



-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
