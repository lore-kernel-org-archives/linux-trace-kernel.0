Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34F8137E;
	Fri, 23 May 2025 23:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748042405; cv=none; b=WDo5iXuSVGie1YUuPTfDfu9zEuRD4t0xZfpg5OJYJGPwa9FEW3251FjHhSmIappHeDz+jGWRkVUwoa9/K6VyF55+823DB82sWO70NOMof2kP+6Bzm9Aym+PQrx2XhELmp/1CEyi9JBFYfPRXVArvtA5dEGWDDiJrf8WpdYQqTdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748042405; c=relaxed/simple;
	bh=xIgX4iuyQ8hFBF1VrVvI5Le9dEwaDc9IXuMrS7KIC6M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcsOznhbzET2kQTJuCcLty5zSOnFDWLyfaM4v1b6FAX6EvZA3fzReqw4P5sQGM/IEn8aoGsnbZ+fWdoVJHa3qjZxAsshlDpeqO8nJLDIfxyB7lHULoBbXO1ypySVlCjlEptXXAiFgpUWWTQRhl/QNrKHF+fHD91XnDwhApzjgVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B50C4CEE9;
	Fri, 23 May 2025 23:20:04 +0000 (UTC)
Date: Fri, 23 May 2025 19:20:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tracing: ring_buffer: Rewind persistent ring
 buffer when reboot
Message-ID: <20250523192053.47054e6e@gandalf.local.home>
In-Reply-To: <20250523165425.0275c9a1@gandalf.local.home>
References: <174792927500.496143.10668210464102033012.stgit@mhiramat.tok.corp.google.com>
	<174792928413.496143.17979267710069360561.stgit@mhiramat.tok.corp.google.com>
	<20250523165425.0275c9a1@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 16:54:25 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> >   spin:
> > @@ -6642,7 +6739,6 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
> >  		cpu_buffer->read_bytes += rb_page_size(reader);
> >  
> >  		/* swap the pages */
> > -		rb_init_page(bpage);  
> 
> This isn't needed, because the persistent ring buffer is never swapped. And
> this is what caused my test to fail. For some reason (and I'm still trying
> to figure out exactly why), it causes my stress test that runs:
> 
>   perf record -o perf-test.dat -a -- trace-cmd record -e all -p function /work/c/hackbench 10 || exit -1
> 
> To never end after tracing is stopped, and it fills up all the disk space.
> 
> But again, this part isn't needed because the persistent ring buffer
> doesn't do the swapping. This replaces what the user passed in with the
> current page.
> 
> >  		bpage = reader->page;
> >  		reader->page = data_page->data;
> >  		local_set(&reader->write, 0);  

So I analyzed why this fails and we need to reset the commit here.

Adding a bunch of trace_printk() (and using the new trace_printk_dest
option where I can have trace_printk go into an instance) I was able to see
why this was an issue.

This part of the code swaps the reader page with what was passed in by the
caller. The page doesn't go back into the write part of the ring buffer.
The "commit" field is used to know if there's more data or not.

By not resetting the "commit" field, we have:

	reader = rb_get_reader_page(cpu_buffer)
		if (cpu_buffer->reader_page->read < rb_page_size(reader))
			return reader;
	// swap passed in page with reader

Without resetting "commit", the caller consumes the page and then uses that
same page to pass back to this function. Since the "commit" field is never
zero'd, it the above if statement always returns true! And this function
just keeps swapping the reader each time and goes into an infinite loop
(this loop requires user space to do a read or splice on this page so it's
not a kernel infinite loop).

Now the question is, can this affect the persistent ring buffer too? I'll
memory map the buffer and see if it causes the same issue.

-- Steve
