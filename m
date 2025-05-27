Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1DF323D;
	Tue, 27 May 2025 03:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748318087; cv=none; b=eyh9JV6W+oV30TPvnOkU5p+7jVoePPWgFllER/0AmHkKefQRuseeUpOWyClhffE6BQ13LD/lSZt4Yl4u85/xT/1q9Zz1Zbt1VLXh6YOX6QejtwzmfGzkS3K3s/3svaNoG/EV7qX9duw/DCwKrZbkYWPJjToA4QSsTe0OZ8ruCyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748318087; c=relaxed/simple;
	bh=Ng61/aB84nxCgAq7cyaS69ZYzC+Riw+xgfzDZXLPnlo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pniusO7iE5+OGKlyL/0GbF+sji6mYhSGaWHYoQQa4S32MdRf+tavmnqa9moruIyHyA5lwb1Fw15HUvIzzHAAdqkXTYDxjCD/aUEguQbYOUxXko+dLpAgutfJBOq6ePW9dSFU588iKP94cInmErEehFjdpNtlD3c8pemRzenxHsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKwc+h+S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKwc+h+S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF545C4CEEA;
	Tue, 27 May 2025 03:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748318086;
	bh=Ng61/aB84nxCgAq7cyaS69ZYzC+Riw+xgfzDZXLPnlo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eKwc+h+SFGHxjkq7bmD9++4GGcSQ075Ow5aRDjeYMPN7o+G7Q/OX1d29Wu0+ZtlpT
	 5OZeTYvMdO3oFHEDd4o6dyQSSaSyLzcRfjsBO8LsWannbxvLU32/som5SMI7ejIBKk
	 IgmsOKs1woRkcH89ueNHMsSoNCYb5lP9pqSjveJY1ZXiCbGmQ1+YwRZAguQTbgm6cL
	 CwJMft8wYK2npIG41Y0uYf/5JdQPAi9ff+0s29Ettsd3zVlG9fz17ikF6O/U8XYKwP
	 p2TplWx7Z4oWJisH8ZA1xSIfbOCSwVJB45AajXA5uOWIdgcmXG0LMyPAgHekZ+PqOL
	 cRXAscjm6aV1Q==
Date: Tue, 27 May 2025 12:54:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tracing: ring_buffer: Rewind persistent ring
 buffer when reboot
Message-Id: <20250527125444.80e59e659a7f087fed3c6fc9@kernel.org>
In-Reply-To: <20250527121549.2d40608e9463199d85bf9ba4@kernel.org>
References: <174792927500.496143.10668210464102033012.stgit@mhiramat.tok.corp.google.com>
	<174792928413.496143.17979267710069360561.stgit@mhiramat.tok.corp.google.com>
	<20250523165425.0275c9a1@gandalf.local.home>
	<20250523172857.02ab4a75@gandalf.local.home>
	<20250526120342.cdcfca9ac3c2161d48c03af5@kernel.org>
	<20250527091743.d036018195b7668aea0753c0@kernel.org>
	<20250527121549.2d40608e9463199d85bf9ba4@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 May 2025 12:15:49 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:


> > What about this? It seems if we keep the reader->page->commit, when we
> > catch up the tail page, rb_get_reader_page() returns new reader (== tail)
> > because reader->read(==0) < reader->page->commit. But we should not return
> > new reader.
> > 
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 5034bae02f08..179142db9586 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -5522,6 +5522,12 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
> >                 cpu_buffer->last_overrun = overwrite;
> >         }
> >  
> > +       /* But if we catch up to the tail, do not return reader page. */
> > +       if (cpu_buffer->commit_page == cpu_buffer->reader_page) {
> 
> 
> Hmm, I found this might not work if it is called twice.
> Maybe rb_get_reader_page() can check the reader_page->ts > head_page->ts
> and return NULL (or reader_page if read < commit) at first.

Here is what I meant. As far as I ran my test, it looks good (it prevents
over-read by `cat per_cpu/cpu0/trace_pipe_raw`)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 5034bae02f08..de1831eb3446 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5405,6 +5405,7 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
        unsigned long flags;
        int nr_loops = 0;
        bool ret;
+       u64 ts;
 
        local_irq_save(flags);
        arch_spin_lock(&cpu_buffer->lock);
@@ -5423,6 +5424,18 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 
        reader = cpu_buffer->reader_page;
 
+       /*
+        * Now the page->commit is not cleared when it read.
+        * Check whether timestamp is newer instead. We also don't
+        * care the head_page is overwritten. In that case, timestamp
+        * should be newer than reader timestamp too.
+        */
+       ts = cpu_buffer->head_page->page->time_stamp;
+       if (ts < reader->page->time_stamp) {
+               reader = NULL;
+               goto out;
+       }
+
        /* If there's more to read, return this page */
        if (cpu_buffer->reader_page->read < rb_page_size(reader))
                goto out;



-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
