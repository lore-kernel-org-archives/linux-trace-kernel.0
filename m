Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67339FC0E;
	Mon, 26 May 2025 03:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748231046; cv=none; b=h+kcZINMPvnJBpJXtYZOpeS6HNusq8Nq6POhU8ecNd6UIh9+3idtU8bFjqxvibYnX9FKvvVqJr91vXfMWuFX7ucAgLqqDVOXBnqZztqTlkPUElcZ4DrxbFaDRSkSAt99Ngoqr8qe+giI5xy1WXEaKulKz9Cr+bRRZTNF3BrQ4Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748231046; c=relaxed/simple;
	bh=2pPImFlewxGzk5QWdrC4f2XBLGZkKF1SdzJVsmk2aXI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cFAhIuPjEF5+W081ISqNGOMhS453kNNjrg4eVCCLt9qCMBSnojFDgQn6VZ7w/duyn2vxJYxcTsaFo8qZpZicYrJGPuCokzFo8zB8YU5l3gHCCbpfjchmeV4YrrKi0ujUeLUZYdhW5RPqMVv6Hu7S8AtS1wRTA1EbTSbx4a6YI0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQ7YDSn5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQ7YDSn5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B60C4CEE7;
	Mon, 26 May 2025 03:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748231045;
	bh=2pPImFlewxGzk5QWdrC4f2XBLGZkKF1SdzJVsmk2aXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AQ7YDSn5QSyW4Gk6hpbtTYaxDx9OrMWEAbvxX0A/ygNkwGYQqELsijB4+teUqddWF
	 uPuzdQZxcSf3L8ns251secLN3+RDtFaaiuYRw2N579RJhR9KDYwUhbntvvYH6eh9Kg
	 IyosiH5CJxrSJR/QrJS89DQpWCvZgOGqMQXMT33IdHNnYtGshptiw3Eh7gAhajKrxB
	 fB3ijSEAYvhpOv6Yh8x0LK0JzCIgfrxSagHzWlLrFkGN665hYSysWyO1LsZxFwhgES
	 ES47kYbwFjeFR+5RrYbLA2akTCNJAmK3B1zNd3EhmbO1H5cDiYaTgFrbERPh380Xt/
	 hjqcRT4lDogcA==
Date: Mon, 26 May 2025 12:44:03 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tracing: ring_buffer: Rewind persistent ring
 buffer when reboot
Message-Id: <20250526124403.3bf41a0634733b640620ad8a@kernel.org>
In-Reply-To: <20250523192053.47054e6e@gandalf.local.home>
References: <174792927500.496143.10668210464102033012.stgit@mhiramat.tok.corp.google.com>
	<174792928413.496143.17979267710069360561.stgit@mhiramat.tok.corp.google.com>
	<20250523165425.0275c9a1@gandalf.local.home>
	<20250523192053.47054e6e@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 19:20:53 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 23 May 2025 16:54:25 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > >   spin:
> > > @@ -6642,7 +6739,6 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
> > >  		cpu_buffer->read_bytes += rb_page_size(reader);
> > >  
> > >  		/* swap the pages */
> > > -		rb_init_page(bpage);  
> > 
> > This isn't needed, because the persistent ring buffer is never swapped. And
> > this is what caused my test to fail. For some reason (and I'm still trying
> > to figure out exactly why), it causes my stress test that runs:
> > 
> >   perf record -o perf-test.dat -a -- trace-cmd record -e all -p function /work/c/hackbench 10 || exit -1
> > 
> > To never end after tracing is stopped, and it fills up all the disk space.

Thanks for sharing the test code. So it means perf reads the ring buffer
endlessly?

[reader commit=X1, ts=1]

[head commit=X2, ts=2]...[tail commit=Xn, ts=n]
  |                           |
  |---------------------------|

I thought that the read will end when it hits tail or ts < ts_current.


> > 
> > But again, this part isn't needed because the persistent ring buffer
> > doesn't do the swapping. This replaces what the user passed in with the
> > current page.
> > 
> > >  		bpage = reader->page;
> > >  		reader->page = data_page->data;
> > >  		local_set(&reader->write, 0);  
> 
> So I analyzed why this fails and we need to reset the commit here.
> 
> Adding a bunch of trace_printk() (and using the new trace_printk_dest
> option where I can have trace_printk go into an instance) I was able to see
> why this was an issue.
> 
> This part of the code swaps the reader page with what was passed in by the
> caller. The page doesn't go back into the write part of the ring buffer.
> The "commit" field is used to know if there's more data or not.
> 
> By not resetting the "commit" field, we have:
> 
> 	reader = rb_get_reader_page(cpu_buffer)
> 		if (cpu_buffer->reader_page->read < rb_page_size(reader))
> 			return reader;
> 	// swap passed in page with reader
> 
> Without resetting "commit", the caller consumes the page and then uses that
> same page to pass back to this function. Since the "commit" field is never
> zero'd, it the above if statement always returns true! And this function
> just keeps swapping the reader each time and goes into an infinite loop
> (this loop requires user space to do a read or splice on this page so it's
> not a kernel infinite loop).


Ah, in rb_get_reader_page(cpu_buffer),

	/* If there's more to read, return this page */
	if (cpu_buffer->reader_page->read < rb_page_size(reader))
		goto out;

	/* Never should we have an index greater than the size */
	if (RB_WARN_ON(cpu_buffer,
		       cpu_buffer->reader_page->read > rb_page_size(reader)))
		goto out;

	/* check if we caught up to the tail */
	reader = NULL;
	if (cpu_buffer->commit_page == cpu_buffer->reader_page)
		goto out;

It checks remaining (unread) data first, and move to the next.

> 
> Now the question is, can this affect the persistent ring buffer too? I'll
> memory map the buffer and see if it causes the same issue.

Yeah, it can happen, but I didn't hit that.
Let me test it too.

Hmm, BTW, is there any possible solution? records the consumed
bytes in meta data?


> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
