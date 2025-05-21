Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106D723AE95;
	Wed, 21 May 2025 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747869545; cv=none; b=AuY/zUXnSuHOjS6yjFnsuZQ+gYP/XV3QWyf5PrOUdCeRIIkV0Y2KL3f18ZJ4/h0lo2Ldvw9v/4gbvv9t1pAo4vapQisMSixFZ00p4ki7LDeupt53KXeMoRpK0tuw/esvUzk87z5Ji4Q8AR5rtm3j+mxZtFM42vcZOwliFlVwW10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747869545; c=relaxed/simple;
	bh=5KYpDNUpr65gculRdpQd+tomtSj8rRT5qn006JuM4Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/Zl7+V8FrhgyLpK79SwkcigAl13u+p5SHhm2Lrg10lasSWPrqlF29k8/gNegKGdpyPgzIUryzZEZD4yzAsV7zO+mvlwtnlhp0oHl5qv5RrDbtai4s/tuml7y7YvPKoM3hsnvjajHW8k2e7I/3GrbOpTDR/RyLKjcFPhkPsTXJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFEBC4CEE4;
	Wed, 21 May 2025 23:19:03 +0000 (UTC)
Date: Wed, 21 May 2025 19:19:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: ring_buffer: Rewind persistent ring buffer
 when reboot
Message-ID: <20250521191947.3f800c34@gandalf.local.home>
In-Reply-To: <20250521145128.3a776466@gandalf.local.home>
References: <174730775661.3893490.10420015749079085314.stgit@mhiramat.tok.corp.google.com>
	<20250521145128.3a776466@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 May 2025 14:51:28 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 15 May 2025 20:15:56 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 6859008ca34d..48f5f248eb4c 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -1358,6 +1358,13 @@ static inline void rb_inc_page(struct buffer_page **bpage)
> >  	*bpage = list_entry(p, struct buffer_page, list);
> >  }
> >  
> > +static inline void rb_dec_page(struct buffer_page **bpage)
> > +{
> > +	struct list_head *p = rb_list_head((*bpage)->list.prev);
> > +
> > +	*bpage = list_entry(p, struct buffer_page, list);
> > +}
> > +
> >  static struct buffer_page *
> >  rb_set_head_page(struct ring_buffer_per_cpu *cpu_buffer)
> >  {
> > @@ -1866,10 +1873,11 @@ static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu)
> >  static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
> >  {
> >  	struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
> > -	struct buffer_page *head_page;
> > +	struct buffer_page *head_page, *orig_head;
> >  	unsigned long entry_bytes = 0;
> >  	unsigned long entries = 0;
> >  	int ret;
> > +	u64 ts;
> >  	int i;
> >  
> >  	if (!meta || !meta->head_buffer)
> > @@ -1885,8 +1893,93 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
> >  	entry_bytes += local_read(&cpu_buffer->reader_page->page->commit);
> >  	local_set(&cpu_buffer->reader_page->entries, ret);
> >  
> > -	head_page = cpu_buffer->head_page;
> > +	orig_head = head_page = cpu_buffer->head_page;
> > +	ts = head_page->page->time_stamp;
> > +
> > +	/*
> > +	 * Try to rewind the head so that we can read the pages which already
> > +	 * read in the previous boot.
> > +	 */
> > +	if (head_page == cpu_buffer->tail_page)
> > +		goto rewound;  
> 
> Hmm, jumping to a label called "rewound" when you didn't do a rewind seems
> confusing.
> 
> Perhaps call the label "skip_rewind"?
> 
> > +
> > +	rb_dec_page(&head_page);
> > +	for (i = 0; i < meta->nr_subbufs + 1; i++, rb_dec_page(&head_page)) {
> > +
> > +		/* Rewind until tail (writer) page. */
> > +		if (head_page == cpu_buffer->tail_page)
> > +			break;
> > +
> > +		/* Ensure the page has older data than head. */
> > +		if (ts < head_page->page->time_stamp)
> > +			break;
> > +
> > +		ts = head_page->page->time_stamp;
> > +		/* Ensure the page has correct timestamp and some data. */
> > +		if (!ts || rb_page_commit(head_page) == 0)
> > +			break;
> > +
> > +		/* Stop rewind if the page is invalid. */
> > +		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu);
> > +		if (ret < 0)
> > +			break;
> > +
> > +		/* Recover the number of entries and update stats. */
> > +		local_set(&head_page->entries, ret);
> > +		if (ret)
> > +			local_inc(&cpu_buffer->pages_touched);
> > +		entries += ret;
> > +		entry_bytes += rb_page_commit(head_page);
> > +	}
> > +	pr_info("Rewound %d pages on cpu%d\n", i, cpu_buffer->cpu);  
> 
> Should state this is coming from the ring buffer and use "[%d]" for cpu
> number as the other pr_info()'s do. Also only print if it did a rewind:
> 
> 	if (i)
> 		pr_info("Ring buffer [%d] rewound %d pages\n", cpu_buffer->cpu, i);
> 
> 
> > +
> > +	/* The last rewound page must be skipped. */
> > +	if (head_page != orig_head)
> > +		rb_inc_page(&head_page);
> >  
> > +	/* If there are rewound pages, rewind the reader page too. */  
> 
> I would change the comment to:
> 
> 	/*
> 	 * If the ring buffer was rewound, then inject the reader page
> 	 * into the location just before the original head page.
> 	 */
> 
> > +	if (head_page != orig_head) {
> > +		struct buffer_page *bpage = orig_head;
> > +
> > +		rb_dec_page(&bpage);
> > +		/*
> > +		 * Insert the reader_page before the original head page.
> > +		 * Since the list encode RB_PAGE flags, general list
> > +		 * operations should be avoided.
> > +		 */
> > +		cpu_buffer->reader_page->list.next = &orig_head->list;
> > +		cpu_buffer->reader_page->list.prev = orig_head->list.prev;
> > +		orig_head->list.prev = &cpu_buffer->reader_page->list;
> > +		bpage->list.next = &cpu_buffer->reader_page->list;
> > +
> > +		/* Make the head_page tthe new read page */  
> 
> Typo "tthe" and call it "new reader page", not "read page".
> 
> > +		cpu_buffer->reader_page = head_page;
> > +		bpage = head_page;
> > +		rb_inc_page(&head_page);
> > +		head_page->list.prev = bpage->list.prev;
> > +		rb_dec_page(&bpage);
> > +		bpage->list.next = &head_page->list;
> > +		rb_set_list_to_head(&bpage->list);

When testing this patch, it kept crashing. I had to add this here:

		cpu_buffer->pages = &head_page->list;

That's because my test would end up having cpu_buffer->pages pointing to
the reader page, and that will cause issues later. It has to point into the
writing portion of the buffer.

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

Can we convert the above to:

		for (i = 1, bpage = head_page; i < meta->nr_subbufs;
		     i++, rb_inc_page(&bpage)) {
			meta->buffers[i] = rb_meta_subbuf_idx(meta, bpage->page);
			bpage->id = i;
		}

By starting i at one, we can remove the "+ 1" inside the loop. It's a bit
cleaner that way.

-- Steve


> > +
> > +		/* We'll restart verifying from orig_head */
> > +		head_page = orig_head;
> > +	}
> > +
> > + rewound:  
> 
>  skip_rewind:
> 
> Also, I know other's don't like to do this, but I do add a space before
> labels. It makes patch diffs easier to see which functions they are,
> otherwise the patch shows the label and not the function.
> 
> -- Steve
> 
> 
> >  	/* If the commit_buffer is the reader page, update the commit page */
> >  	if (meta->commit_buffer == (unsigned long)cpu_buffer->reader_page->page) {
> >  		cpu_buffer->commit_page = cpu_buffer->reader_page;
> > @@ -5348,7 +5441,6 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
> >  	 */
> >  	local_set(&cpu_buffer->reader_page->write, 0);
> >  	local_set(&cpu_buffer->reader_page->entries, 0);
> > -	local_set(&cpu_buffer->reader_page->page->commit, 0);
> >  	cpu_buffer->reader_page->real_end = 0;
> >  
> >   spin:
> > @@ -6642,7 +6734,6 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
> >  		cpu_buffer->read_bytes += rb_page_size(reader);
> >  
> >  		/* swap the pages */
> > -		rb_init_page(bpage);
> >  		bpage = reader->page;
> >  		reader->page = data_page->data;
> >  		local_set(&reader->write, 0);  
> 

