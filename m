Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA7C1FDE02;
	Fri, 23 May 2025 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748033618; cv=none; b=nGOtW5RfYb43Sneh4kdLAXFUt7xJbPiBq6IL4rpEGGzOsCEFiKRMneWT4aejUXqRMA65TeLo7VrM6ho55egWgtMj3Efpj+zFeFV0TvFpQ26svdzvT+uVx/ls3xCPx3+k5dmshHIKW0h3Uske8gOTmokbEvM76cIVcGQkhhWhCsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748033618; c=relaxed/simple;
	bh=HGEqOD9FVm1STBHPO1ILxeB7G6nXZZGaJNKmpL2nfhc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dAyiVc2csMqXJgWpIN7t03M1EzuQn3xPMYr/toX/uGEbXXiPb+Onqv6ZBLbgunrTuwsgH+fZx4XuOEu5shC2NZkQ1Tpj3K1oOcHRoiKEsuwp0YLc2qAqaJu9hpjSOFZeDv8U8eM4pVmLxL9g/3XOiwjifk2Kku8AJgypcLXV+qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3F2C4CEF1;
	Fri, 23 May 2025 20:53:36 +0000 (UTC)
Date: Fri, 23 May 2025 16:54:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tracing: ring_buffer: Rewind persistent ring
 buffer when reboot
Message-ID: <20250523165425.0275c9a1@gandalf.local.home>
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

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Unfortunately, I don't think this is going to make the merge window.

This failed one of my tests and it took me a while to figure it out. And I
think there may be some more subtle issues that we need further testing on.

> 
> Rewind persistent ring buffer pages which have been read in the
> previous boot. Those pages are highly possible to be lost before
> writing it to the disk if the previous kernel crashed. In this
> case, the trace data is kept on the persistent ring buffer, but
> it can not be read because its commit size has been reset after
> read.
> This skips clearing the commit size of each sub-buffer and
> recover it after reboot.
> 
> Note: If you read the previous boot data via trace_pipe, that
> is not accessible in that time. But reboot without clearing (or
> reusing) the read data, the read data is recovered again in the
> next boot.
> Thus, when you read the previous boot data, clear it by
> `echo > trace`.
> 
> @@ -5348,7 +5446,6 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
>  	 */
>  	local_set(&cpu_buffer->reader_page->write, 0);
>  	local_set(&cpu_buffer->reader_page->entries, 0);
> -	local_set(&cpu_buffer->reader_page->page->commit, 0);

We need to make sure the above doesn't cause any issues. It wasn't the
reason for my test failure, but it's something we need to look more closely
at.


>  	cpu_buffer->reader_page->real_end = 0;
>  
>   spin:
> @@ -6642,7 +6739,6 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  		cpu_buffer->read_bytes += rb_page_size(reader);
>  
>  		/* swap the pages */
> -		rb_init_page(bpage);

This isn't needed, because the persistent ring buffer is never swapped. And
this is what caused my test to fail. For some reason (and I'm still trying
to figure out exactly why), it causes my stress test that runs:

  perf record -o perf-test.dat -a -- trace-cmd record -e all -p function /work/c/hackbench 10 || exit -1

To never end after tracing is stopped, and it fills up all the disk space.

But again, this part isn't needed because the persistent ring buffer
doesn't do the swapping. This replaces what the user passed in with the
current page.

>  		bpage = reader->page;
>  		reader->page = data_page->data;
>  		local_set(&reader->write, 0);

I think we also need this:

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7d837963dd1e..456efebc396a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3638,6 +3638,9 @@ rb_move_tail(struct ring_buffer_per_cpu *cpu_buffer,
 
 	rb_reset_tail(cpu_buffer, tail, info);
 
+	/* The new page should have zero committed */
+	rb_init_page(next_page->page);
+
 	/* Commit what we have for now. */
 	rb_end_commit(cpu_buffer);
 	/* rb_end_commit() decs committing */

-- Steve
