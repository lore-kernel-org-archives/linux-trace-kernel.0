Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180D42C325E;
	Tue,  3 Jun 2025 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748966377; cv=none; b=aWfXVvByiIVGqCz2Omj4KYpjXt2lIHxR7SaCiD+HtbFdEbzRt31zc/wKE9kd1NTH64kPC/K4weBwBqqxmMkYSB6F3N3yS8r/pyDRVDXaaL2qP7gAJCVsGFUNCvLe8/YdGhwezz8iQDqAUu/pn5/YhlzdjEZdDDcK+hhrZF/hr1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748966377; c=relaxed/simple;
	bh=PFt4muIDtjgvJ9gBRPHD8m7zl6J3r9eDdQIumTFQCcU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/O0xi/sJyFOKDPF3qQnoYm+0UdTvOEhDNFamMHZZwqFEDLptyDqYaXSvzRXoE658y5g1v6ixLptj9npbFFJuHVH0+zuJfUptsnElf+JhsiGzccYl1M73aAu4fdl+kcpr54fwS+XNg8kW4crhBexGcf0GGRW2u0wYBIKCi9ykvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8273C4CEEF;
	Tue,  3 Jun 2025 15:59:35 +0000 (UTC)
Date: Tue, 3 Jun 2025 12:00:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tracing: ring_buffer: Rewind persistent ring
 buffer when reboot
Message-ID: <20250603120049.692d48b4@gandalf.local.home>
In-Reply-To: <174792928413.496143.17979267710069360561.stgit@mhiramat.tok.corp.google.com>
References: <174792927500.496143.10668210464102033012.stgit@mhiramat.tok.corp.google.com>
	<174792928413.496143.17979267710069360561.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 00:54:44 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> @@ -6642,7 +6739,6 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  		cpu_buffer->read_bytes += rb_page_size(reader);
>  
>  		/* swap the pages */
> -		rb_init_page(bpage);
>  		bpage = reader->page;
>  		reader->page = data_page->data;
>  		local_set(&reader->write, 0);

Here's the bug we were looking for. We definitely need to keep the
rb_init_page() here!

That's because this is the } else { part of the if condition that on true
will do a copy and not a swap of the reader page.

ring_buffer_read_page() has:

	if (read || (len < (commit - read)) ||
	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
	    cpu_buffer->mapped) {

		// Copy the buffer to the passed in data_page

	} else {

		// swap the data_page with the reader page

	}

The else part is here, and it's swapping the passed in data_page with the
current reader_page. We have to initialize the data_page here.

What we see happening is:

	info->spare = ring_buffer_alloc_read_page(); <-- this is the data_page

	[..]

	ret = ring_buffer_read_page(..., info->spare, ...);

Since this is a normal buffer, we swap the reader_page with info->spare,
where info->spare now has the reader_page.

It consumes the data via:

	trace_data = ring_buffer_read_data(info->spare);

Then reads the buffer again:

	ret = ring_buffer_read_page(..., info->spare, ...);

Now it hits the if statement again:

	if (read || (len < (commit - read)) ||
	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
	    cpu_buffer->mapped) {

		// Copy the buffer to the passed in data_page

	} else {

		// swap the data_page with the reader page

---->> here it just swaps the last data_page with the current one.

	}


As we never clear the "commit" part of the page, it still thinks it has
content on the page as the "read" was set to zero, and it reads the old
content again.

There's no reason not to clear the "commit" of the data_page passed in. It
is not old data that is about to be lost. We most definitely need to call
rb_init_page() on it.

After adding that back, trace-cmd record works properly again.

Care to send a v4 without removing this rb_init_page(bpage); ?

-- Steve
