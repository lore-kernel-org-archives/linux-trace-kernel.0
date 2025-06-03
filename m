Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D06227EB9;
	Tue,  3 Jun 2025 21:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748987899; cv=none; b=hFYGgJ2M2sVGCa0QqC4ocpZ404+FCuFEi83Vi2oj02Z13s57/VCcEQn93aOrQwlfUpPToB3A2ZYD9ryc0/90Eco8qEwZPxJPdwX4/sOjo62BAb0uGfS7rkTzsP8aepuQ1soHYYGKqBPmh+6kzH6mFTTeERgikFG2b+aXcrp/MLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748987899; c=relaxed/simple;
	bh=0bypknFRjoL9Ib1Hfa6MS00x/TRJzsKSt3pRBLF3B5Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bcSbkVembv5kuQHEckAsnThZcy/su2Li43fKXoEDttfxtyEDnqqLebIz6BSwtIHH3ZvYWoXcrzzheqdjUij7DzIhEhmtc7dS5Jgkbi2X5zmMyg9odFN1k24w+mX3LO0/a8UhoXOF4M+9W1Jf4qHCsHfUKMQtT+5qq4Zv4mBDZV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTU3lelr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTU3lelr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF0FC4CEED;
	Tue,  3 Jun 2025 21:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748987897;
	bh=0bypknFRjoL9Ib1Hfa6MS00x/TRJzsKSt3pRBLF3B5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RTU3lelrbqZDnw64X6eKGYqyqQZawG8uyAvhOlLbz1DiZn4g/qV/MIULXMo6EyOQp
	 JubQ/HxNCHLKqm8dX4rIxdK1saVxr1yX3TDrwV3r5ZLsq/FlfITR+zK4PAw/GUrPT/
	 1taeLAeuLdUHj4evznLp8Jsj5M9ce7x2U6v0V1+kBZ77WF1J1BFL9FNBPcOPl++NDM
	 dQT4QwDpD995JsA1MWrihlC5RI11Afv7/QFqPZC+9Hk2XR0EgY1GeT2cpBfe0vUOpW
	 +3Y1sy/xHd/djLVb3apcuec1M6fbmjDMOaLZmsxxkeUa6PjVasP81WA13twnLQabdE
	 vjldFjqBXoVPA==
Date: Wed, 4 Jun 2025 06:58:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tracing: ring_buffer: Rewind persistent ring
 buffer when reboot
Message-Id: <20250604065814.a9df1d1944390d4c262852bd@kernel.org>
In-Reply-To: <20250603120049.692d48b4@gandalf.local.home>
References: <174792927500.496143.10668210464102033012.stgit@mhiramat.tok.corp.google.com>
	<174792928413.496143.17979267710069360561.stgit@mhiramat.tok.corp.google.com>
	<20250603120049.692d48b4@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Jun 2025 12:00:49 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 23 May 2025 00:54:44 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > @@ -6642,7 +6739,6 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
> >  		cpu_buffer->read_bytes += rb_page_size(reader);
> >  
> >  		/* swap the pages */
> > -		rb_init_page(bpage);
> >  		bpage = reader->page;
> >  		reader->page = data_page->data;
> >  		local_set(&reader->write, 0);
> 
> Here's the bug we were looking for. We definitely need to keep the
> rb_init_page() here!

Ah, thanks for finding the bug!

> 
> That's because this is the } else { part of the if condition that on true
> will do a copy and not a swap of the reader page.
> 
> ring_buffer_read_page() has:
> 
> 	if (read || (len < (commit - read)) ||
> 	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
> 	    cpu_buffer->mapped) {
> 
> 		// Copy the buffer to the passed in data_page
> 
> 	} else {
> 
> 		// swap the data_page with the reader page
> 
> 	}
> 
> The else part is here, and it's swapping the passed in data_page with the
> current reader_page. We have to initialize the data_page here.

Oops, I confused the "swap" meant reader <-> head, but that should be
done in rb_get_reader_page(), not here.

> 
> What we see happening is:
> 
> 	info->spare = ring_buffer_alloc_read_page(); <-- this is the data_page
> 
> 	[..]
> 
> 	ret = ring_buffer_read_page(..., info->spare, ...);
> 
> Since this is a normal buffer, we swap the reader_page with info->spare,
> where info->spare now has the reader_page.
> 
> It consumes the data via:
> 
> 	trace_data = ring_buffer_read_data(info->spare);
> 
> Then reads the buffer again:
> 
> 	ret = ring_buffer_read_page(..., info->spare, ...);
> 
> Now it hits the if statement again:
> 
> 	if (read || (len < (commit - read)) ||
> 	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
> 	    cpu_buffer->mapped) {
> 
> 		// Copy the buffer to the passed in data_page

So all mapped buffers (including persistent ring buffer) pass
this block.

> 
> 	} else {
> 
> 		// swap the data_page with the reader page
> 
> ---->> here it just swaps the last data_page with the current one.

So the data_page should not have any data. its commit should be 0.

> 
> 	}
> 
> 
> As we never clear the "commit" part of the page, it still thinks it has
> content on the page as the "read" was set to zero, and it reads the old
> content again.

Got it.

> 
> There's no reason not to clear the "commit" of the data_page passed in. It
> is not old data that is about to be lost. We most definitely need to call
> rb_init_page() on it.

Yeah, that data should be considered as cleared.

> 
> After adding that back, trace-cmd record works properly again.
> 
> Care to send a v4 without removing this rb_init_page(bpage); ?

OK, let me remove that (also remove timestamp check).

Thank you!

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
