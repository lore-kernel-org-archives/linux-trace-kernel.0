Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EAB2EF653;
	Thu, 21 May 2026 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373047; cv=none; b=qhLJETWs3M1e/x4TWpNAY6f6MAimSudEXUZbV349/z8NhbQ9voX9qGLVHmZaYF8HU8LutSAFZjgUIRnQnoNtK6yHKbJZhuwkqmVhIGTp8vM7TlNtYCQLZBeOZJDuf94Tu5quvpI2N+WVS3AqpfUTBWw56cFRahJyaPVqR7Ql//I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373047; c=relaxed/simple;
	bh=7HdOynnfZ41Glz7tPCn9q1ES2n5mZ4rCGHb6hX2+lzI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQ5VcGamBaZDm65uXDn5SbNwh3slilqAyv00KqyISbPLN6XzutlOlPl4VxZnoCIMbrOpkEV1TLxVcnY9swLHdoUbk2OzWPWFlY/RZsGNEGlDyUkinaZ/IdYvi0oOqkHS1O+/PFnwRuHeS5Q8Xv3pW3888K+CAWJf+NUvqigruBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 6518F1A05C4;
	Thu, 21 May 2026 14:17:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 5C15B2001E;
	Thu, 21 May 2026 14:17:21 +0000 (UTC)
Date: Thu, 21 May 2026 10:17:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ian Rogers
 <irogers@google.com>, "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>,
 "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
Subject: Re: [PATCH v20 02/10] ring-buffer: Skip invalid sub-buffers when
 rewinding persistent ring buffer
Message-ID: <20260521101742.2dd92bad@gandalf.local.home>
In-Reply-To: <20260520185017.219342323@kernel.org>
References: <20260520184938.749337513@kernel.org>
	<20260520185017.219342323@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 5C15B2001E
X-Stat-Signature: 7o9tunghr1knfbedsgoqsjqs8qwujopk
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/jB70Aj1+aKXxZf7o3qaRT1vzTsQfM0jI=
X-HE-Tag: 1779373041-833705
X-HE-Meta: U2FsdGVkX18T/5bsBGe5xy7whlSHfiILJqOGCo84zOl5rJOCyTV2qSuspBNGiwwO9JkdKw4L12Ky13QNekLkBrQJ+hEX+5IHql7u3J9yVaAV9vVRRJ8due+rgj0bozKctYU0tZB2VeN9RrQYjT8LwIYZVzFtGK1TxtH/5/GsmpCACx+BeiraqJyJCFk7sWIqCFc16OJlaoBhTmk1luxTSAF0pN2fdKwQiQ+scCQvgzza4VX3/XSgZOMu0GZHcR/VxYWCwthbRF80SKN4mQW0W8NNDZgj7PQfqfm3zXGf0Q5Q0aADZPb3761RqYWOLuaKYzuwj3HxE4sd/bw8uDNUy7qm0XrtvDCRZdW18kcwqs/UjwsxjE0EYmjOoB6Y5ncSZY4Q1eAXF9RSV77HJ0+Zyw==


[
  Replying to Sashiko from v19: https://sashiko.dev/?list=org.kernel.vger.linux-trace-kernel#/patchset/177751968499.2136606.17388366710182662849.stgit%40mhiramat.tok.corp.google.com
]

> > @@ -1892,9 +1895,27 @@ static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu,
> >  	 * subbuf_size is considered invalid.
> >  	 */
> >  	tail = local_read(&dpage->commit) & ~RB_MISSED_MASK;
> > -	if (tail > meta->subbuf_size - BUF_PAGE_HDR_SIZE)
> > -		return -1;
> > -	return rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
> > +	if (tail <= meta->subbuf_size - BUF_PAGE_HDR_SIZE)
> > +		ret = rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);

> Since tail is read from untrusted persistent memory, does this call evaluating

The persistent memory is not untrusted.

> event headers verify enough bytes remain in the sub-buffer?
> If tail is set to the maximum allowed value, and preceding events are crafted
> so that the last event starts at tail - 1, the event pointer inside
> rb_read_data_buffer() will point to the very last byte.
> Calling rb_event_length(event) will evaluate event->type_len via a 32-bit
> read which could read past the page boundary and cause a regression if the
> adjacent page is unmapped.
> Should the parsing loop verify tail - e >= sizeof(struct ring_buffer_event)
> before evaluating the event?

> > +	else
> > +		ret = -1;
> > +
> > +	/*
> > +	 * The timestamp must be greater than @prev_ts and smaller than @next_ts.
> > +	 * Since this function works in both forward (verify) and reverse (unwind)
> > +	 * loop, we don't know both @prev_ts and @next_ts at the same time.
> > +	 * So use the known boundary as the boundary.
> > +	 */
> > +	if (ret < 0 || (prev_ts && prev_ts > ts) || (next_ts && ts > next_ts)) {

> Does this timestamp validation properly enforce strictly monotonic page ordering?
> Inside rb_validate_buffer(), ts is updated by rb_read_data_buffer() to
> the timestamp of the last event in the current page. The condition
> (prev_ts && prev_ts > ts) only checks that the previous page's start time
> is not greater than the current page's end time.
> Could a corrupted page with a start timestamp earlier than the previous
> page incorrectly pass validation if its final event timestamp is large enough?
> Would it prevent this regression to enforce that the current page starts after
> the previous page by checking prev_ts > dpage->time_stamp?

This may be an enhancement but shouldn't be critical for what is happening now.

> > +		local_set(&bpage->entries, 0);
> [ ... ]
> > @@ -1915,25 +1936,29 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
> >  	orig_head = head_page = cpu_buffer->head_page;
> >  	orig_reader = cpu_buffer->reader_page;
> >  
> > -	/* Do the reader page first */
> > -	ret = rb_validate_buffer(orig_reader->page, cpu_buffer->cpu, meta);
> > +	/* Do the head page first */
> > +	ret = rb_validate_buffer(head_page, cpu_buffer->cpu, meta, 0, 0);
> > +	if (ret < 0) {
> > +		pr_info("Ring buffer meta [%d] invalid head page detected\n",
> > +			cpu_buffer->cpu);
> > +		goto skip_rewind;
> > +	}
> > +	ts = head_page->page->time_stamp;
> > +
> > +	/* Do the reader page - reader must be previous to head. */
> > +	ret = rb_validate_buffer(orig_reader, cpu_buffer->cpu, meta, 0, ts);

> If rb_validate_buffer() for the head page fails, we take the goto skip_rewind
> path. Since skip_rewind jumps past this orig_reader validation, and the
> iteration loop explicitly skips orig_reader:
>     /* Iterate until finding the commit page */
>     for (i = 0; i < meta->nr_subbufs + 1; i++, rb_inc_page(&head_page)) {
>         /* The original reader page has already been checked/counted. */
>         if (head_page == orig_reader)
>             continue;
> does this mean the reader page escapes validation entirely, introducing a
> regression?

This is a bug and needs to be fixed. If the head page is invalid it
shouldn't skip the rewind but instead jump to the "invalid:" label.

> If an attacker provides a corrupted persistent ring buffer with an invalid
> head page, would the kernel blindly trust the unvalidated commit length
> and event data of the reader page?

Not worried about attackers but I am worried about corrupted memory.

-- Steve
