Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486B03A1DB;
	Wed, 27 May 2026 03:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779853645; cv=none; b=hrPAhn0qzNZeL1DEwMP5iQcQW9g0NMHRDWpHQLOaEm/jr5C7hPB4am5GpzkylEwTf6E+0yL21L9yhl7lueWMTYBHASy/x4yAmk5TkDlXNSbeXWC0IHp6luwgY+GvlAYGgkLjoGJwnh0fG+0+yl1jqly0EU2BYPsN6fRqlwuunAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779853645; c=relaxed/simple;
	bh=cUjfBZ8OY7V7QFtCDQHCRr7BLTfl9uCgHwb1jlK7Bxg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JXhI0k6MS+IBBcWLQen+zxSjZ1rZJ1nq+OBp9KFCS6kGZjMNMNgab6h4sMRoaHy2O6wDezI1+c+P7UkMy7Rnwbvum+CQ3qg2XHhid336A1wcj+knVtisoBW+a0mNpD+k8rgWMRtaxaplVSgn6wOCR/XdBlwE05O6vd11pwbTt7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OndTcJUl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OndTcJUl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AA81F000E9;
	Wed, 27 May 2026 03:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779853643;
	bh=Q31curzpZJR+IaS4+4tPojYKK41Azpfb57PViovHLYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OndTcJUl7lQixLTFESrmDZ+hT4jOIId+1d2AXX7ULuGzYGn6rMewUExcq7hT0Nkis
	 ff+GKLpDrfJ4TOtjVWEvo2mjwLSCmp0N+NxGUx4+of1WWQYrbGjDzspqwotSVPtSs5
	 SEaJfuILt/6XYvcfj3i++TGsBUEspfVcDO/PTzys7LhtaLXiL1SU6OJPzfPSfHrEB+
	 ExZol12EmZrM6yBi7xcyxCmM7ll5efg21s+MrtZSyyJfA0JDYYMdMtK53exGTVJeEj
	 yLv2cTJhP8mU4W5eTWKyTUgY3l8ngTcAPArn6q69N3mRft+Vh/jl6VY6XDks99k/qh
	 RvCMU/74ciUHw==
Date: Wed, 27 May 2026 12:47:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v21 8/9] ring-buffer: Show persistent buffer dropped
 events in trace file
Message-Id: <20260527124721.d05102c2f45e6c5bb5fbe476@kernel.org>
In-Reply-To: <20260526134116.11e1db99@gandalf.local.home>
References: <20260522170857.263969486@kernel.org>
	<20260522171052.006276604@kernel.org>
	<20260526140609.28faf45d9d347e5d748e7cf1@kernel.org>
	<20260526134116.11e1db99@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 13:41:16 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> On Tue, 26 May 2026 14:06:09 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > @@ -7204,10 +7209,12 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
> > >  	 * Set a flag in the commit field if we lost events
> > >  	 */
> > >  	if (missed_events) {
> > > -		/* If there is room at the end of the page to save the
> > > +		/*
> > > +		 * If there is room at the end of the page to save the
> > >  		 * missed events, then record it there.
> > >  		 */
> > > -		if (buffer->subbuf_size - commit >= sizeof(missed_events)) {
> > > +		if (missed_events > 0 &&
> > > +		    buffer->subbuf_size - commit >= sizeof(missed_events)) {
> > >  			memcpy(&dpage->data[commit], &missed_events,
> > >  			       sizeof(missed_events));
> > >  			local_add(RB_MISSED_STORED, &dpage->commit);  
> > 
> > After this line, we "add" RB_MISSED_EVENTS instead of set.
> > In this case, does it clear the RB_MISSED_EVENTS bit because
> > it already sets RB_MISSED_EVENTS.
> > 
> > 			commit += sizeof(missed_events);
> > 		}
> > 		local_add(RB_MISSED_EVENTS, &bpage->commit);
> >                       ^^^ here.
> 
> Perhaps this needs to be commented better.
> 
> The answer to your question is "No". The reason is that this is a *copy* of
> the page we are reading. As persistent pages are always assigned to
> specific memory, it can never leave the buffer even for the splice system
> call. It is always copied to a new page.
> 
> The new page doesn't have these bits set and needs to set them depending on
> what was found when reading the page from the buffer.
> 
> Now if this was a normal ring buffer where it did a zero copy from the
> buffer itself by swapping pages with the passed in page, if the bit was set
> before, then adding would cause a problem. But normal ring buffer pages
> never set these bits while in the buffer. They are only set by this function.

Yeah, for the persistent ring buffer, it does not happen.
But there seems RB_MISSED_EVENTS bit can be cleared in
"else" path (after applying 1-8 patches)?

----------
	if (read || (len < (commit - read)) ||
	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
	    force_memcpy) { // <-- persistent ring buffer sets force_memcpy = true.
[...]
	} else {
		/* update the entry counter */
[...]
		if (!missed_events && rb_data_page_commit(dpage) & RB_MISSED_EVENTS)
			missed_events = -1;	
			//^-- we check RB_MISSED_EVENTS bit on @dpage->commit and set missed_events = -1.

		/*
		 * Use the real_end for the data size,
		 * This gives us a chance to store the lost events
		 * on the page.
		 */
		if (reader->real_end)
			local_set(&dpage->commit, reader->real_end);
                        // ^- only if @reader->real_end, RB_MISSED_EVENTS bit is dropped.
	}

	cpu_buffer->lost_events = 0;

	commit = rb_data_page_commit(dpage);
	/*
	 * Set a flag in the commit field if we lost events
	 */
	if (missed_events) {
		/*
		 * If there is room at the end of the page to save the
		 * missed events, then record it there.
		 */
		if (missed_events > 0 &&
		    buffer->subbuf_size - commit >= sizeof(missed_events)) {
			memcpy(&dpage->data[commit], &missed_events,
			       sizeof(missed_events));
			local_add(RB_MISSED_STORED, &dpage->commit);
			commit += sizeof(missed_events);
		}
		local_add(RB_MISSED_EVENTS, &dpage->commit); // <-- @dpage->commit is updated.
	}
----------

Thanks,


> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
