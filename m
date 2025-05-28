Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D9E1805E;
	Wed, 28 May 2025 00:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748391732; cv=none; b=L8AbjnWMQqmXlyTlxW5ce5E9u7u3lWmmdNr3ycUWdEIvBo8VoT2UeltDsJPGmPay82hbA3p2UzTCKXoGjCNEwStHKkQ7E2rxeTjZ7+dgYXWJmQ+Ay0vyJgFEcE4nc39BtmnnUI7PVz3LXuL+qn0MTsOu4KQ2FJlUePLf4qHQy48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748391732; c=relaxed/simple;
	bh=6esPAlwDjRxvsHLe2vM+P3NusaJJVF93cTddiCo4aV8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=C5I1y2GR+Sn08wVvBzaynWq5gBmMkb/kaBaZF7QYG1PicZJSXH2UbZnMxqweydR1Mfdxvd7Snp67HN7F0f2ZD9V9IOXntQN9B0YDgfeN+/bGkIFh1NWJRojuh8Rg4DKk8z7RDph7gHpoKhkRl/vmubN0vdS+m12Ebu/t8WqX/PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFUGp/wT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFUGp/wT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EB7C4CEE9;
	Wed, 28 May 2025 00:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748391731;
	bh=6esPAlwDjRxvsHLe2vM+P3NusaJJVF93cTddiCo4aV8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TFUGp/wTMMg6Di1mfGyt/JIdGrErm5Ae/6wh9ARXzE6OBTshTNelC608//6lyuI0X
	 VJjXnO1qnCNwtZGRARmjyx3U3aZb1dm/5Ev9Nvwr8hhZqbR3tMtQyH8TZ6a6Dr4zOp
	 4tRwVghmUdo1gr5WhV28GDh5vrekIE6V93QyhMWxikr8MMxRz0IfTmh/IaeSW6K2AI
	 KNXTshw4SUj0WvMV6jnCGkbBGq1W/629dJ+HIOR0TD5Rz4BV5AQRZlfu3NZp9TbR5V
	 4BM9lFTxe6QcKBrWzydVWMT0lkyTSHaS/RmkRoP9FKs/9DAlGZVY0Lowl199IjUgSk
	 SPb7KM/wqBw/A==
Date: Wed, 28 May 2025 09:22:09 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tracing: ring_buffer: Rewind persistent ring
 buffer when reboot
Message-Id: <20250528092209.01fb26deee82e404d52a90c5@kernel.org>
In-Reply-To: <20250527094757.791e8f10@gandalf.local.home>
References: <174792927500.496143.10668210464102033012.stgit@mhiramat.tok.corp.google.com>
	<174792928413.496143.17979267710069360561.stgit@mhiramat.tok.corp.google.com>
	<20250523165425.0275c9a1@gandalf.local.home>
	<20250523172857.02ab4a75@gandalf.local.home>
	<20250526120342.cdcfca9ac3c2161d48c03af5@kernel.org>
	<20250527091743.d036018195b7668aea0753c0@kernel.org>
	<20250527121549.2d40608e9463199d85bf9ba4@kernel.org>
	<20250527125444.80e59e659a7f087fed3c6fc9@kernel.org>
	<20250527094757.791e8f10@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 May 2025 09:47:57 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 27 May 2025 12:54:44 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Here is what I meant. As far as I ran my test, it looks good (it prevents
> > over-read by `cat per_cpu/cpu0/trace_pipe_raw`)
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 5034bae02f08..de1831eb3446 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -5405,6 +5405,7 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
> >         unsigned long flags;
> >         int nr_loops = 0;
> >         bool ret;
> > +       u64 ts;
> >  
> >         local_irq_save(flags);
> >         arch_spin_lock(&cpu_buffer->lock);
> > @@ -5423,6 +5424,18 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
> >  
> >         reader = cpu_buffer->reader_page;
> >  
> > +       /*
> > +        * Now the page->commit is not cleared when it read.
> > +        * Check whether timestamp is newer instead. We also don't
> > +        * care the head_page is overwritten. In that case, timestamp
> > +        * should be newer than reader timestamp too.
> > +        */
> > +       ts = cpu_buffer->head_page->page->time_stamp;
> > +       if (ts < reader->page->time_stamp) {
> 
> Hmm, I think this test may be too fragile. The head_page can be moved
> by the writer, and this would need to handle races.

Good point! Can we pick the page out from ring buffer as same
as reader_page? If its timestamp is newer, we push the reader
page (swap reader and head), or push back the header page.

> 
> I found an issue with commit overflow and have a couple of bugs to fix that
> touches some of this code. Let's revisit after I get those fixed.

OK, let's review it.

BTW, we need a ring buffer test tool not depending on perf tool.

Thank you,

> 
> Thanks,
> 
> -- Steve
> 
> 
> 
> > +               reader = NULL;
> > +               goto out;
> > +       }
> > +
> >         /* If there's more to read, return this page */
> >         if (cpu_buffer->reader_page->read < rb_page_size(reader))
> >                 goto out;
> > 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
