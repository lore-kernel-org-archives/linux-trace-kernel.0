Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DF51A9B3D;
	Wed, 28 May 2025 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748444625; cv=none; b=E1fyt2GK2fSSxcKXzrtOHW08AD5qVlvl/NDraP1kVaa/fUqrLKQT7VHMhGEI+MUEVs7xd/e7GurtVlhAwOfYkbJiLmmvmnt8l6pG8clU30A4mDsUJJTAsS7A0Lpb2/tk4TQim5VoZA1tiuUWmEtkS5wqeWHsX8HwnBoQAJWAfSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748444625; c=relaxed/simple;
	bh=JKfKTF15DiZJaG9JqtsMV97jZAYF8+DiAH7XxkjNRBo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=B5GD5jLcrIeMj92JsfYhL5c9A4/ECgSNcuGIM+ve20Sj31fcq4FbHLMZgyTSUkmGVP8cUVIP8fOiArFvzjVV/qODSj2j38/hlosPE1WXs78p7iGHSfT+X9y4VO39P2q3E/cxsJb5mEA7nQhUXaxmewe0c+QPzNpf9TTAcDtE8O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2xKvA4+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2xKvA4+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B27C4CEE3;
	Wed, 28 May 2025 15:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748444625;
	bh=JKfKTF15DiZJaG9JqtsMV97jZAYF8+DiAH7XxkjNRBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I2xKvA4+ZXDYTNOLD2BakxlQShpTHOEEjD3hxU+fum4FTWqFjae7+GB4O9jsL0qNF
	 Mn6vbrEwTjy0VCtl8xOdyXRPKCdsrR7yzCFzT7nCZI68ojWVaRb/sYt40l+ntxBYHY
	 zNk98BANAZFBJXiLv+FR11ZfK49Yb6VEy7ClWmeyMljs8M4YjAB7PjOzUPm1NFovtU
	 vWzFyT+snOE19xPqQRdI+YXKeLguFs8khSpB16arfJxJkRB9FCtVKyCAqbhSeGA+jr
	 97D6eIy8BlsgwsOJQIcUQXFq8l780Okf3mAQwHOyU+gxJqOU2fjfY85P/lL0T/1uEn
	 36Kpnq0N2gYeA==
Date: Thu, 29 May 2025 00:03:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH] ring-buffer: Do not trigger WARN_ON() due to a
 commit_overrun
Message-Id: <20250529000342.5218ac7b90c99f3636edd5ab@kernel.org>
In-Reply-To: <20250527221735.04c62a3c@batman.local.home>
References: <20250527121140.0e7f0565@gandalf.local.home>
	<20250528104203.d6f509c5d9c30dec1e024587@kernel.org>
	<20250527221735.04c62a3c@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 May 2025 22:17:35 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 28 May 2025 10:42:03 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > The way to differentiate this case from the normal case of there
> > > only being one page written to where the swap of the reader page
> > > received that one page (which is the commit page), check if the
> > > tail page is on the reader page. The difference between the commit
> > > page and the tail page is that the tail page is where new writes go
> > > to, and the commit page holds the first write that hasn't been
> > > committed yet. In the case of an interrupt preempting the write of
> > > an event and filling the buffer, it would move the tail page but
> > > not the commit page.  
> > 
> > (BTW, what happen if the interrupted process commits the event? That
> >  event will be lost, or commit and just move commit_page?)
> 
> No, the first event to be created is the "commit" event. If it gets
> interrupted and the interrupt adds a bunch of events that wraps the
> ring buffer, it can't touch the commit event, it will just start
> dropping events. Then when the commit event finishes, it can either be
> read by the reader, or overwritten by the next events coming in.

Hmm, rb_end_commit() seems to try commit all nested events (committing > 1)
if committing == 1, and the rb_set_commit_to_write() pushes commit pointer
to the latest write pointer. So when it "start dropping events"? (is that
write side?)

> > 
> > Thus the reader_page == commit_page && reader_page == tail_page,
> > missed_events should be 0?
> > 
> > Possible cases if missed_events != 0:
> > 
> >  - reader_page != commit_page
> > 	(writer's commit overtook the reader)
> 
> The reader is never in the write buffer. Just the head page will move.
> When a new reader page is taken it will swap out the old reader page
> with the head page. If the head page is the commit page, then the
> commit page becomes the reader page too.

Hmm, so this is the case that the writer is too fast and it moves
head page to the next page. Thus some events on old head page are
lost.

> 
> > 
> >  - reader_page == commit_page but reader_page != tail_page 
> > 	(writer overtook the reader, but commit is not completed yet.)
> 
> No, "writer overtook the reader" doesn't make sense as the reader is
> not on the write buffer, so the writer can not catch up to it. What the
> write buffer has is the "head" page which is where the next reader will
> come to.
> 
> The only way reader_page == commit_page and reader_page != tail_page is
> if the commit was interrupted and the interrupt added events and moved
> forward off the commit_page. The only way there would be missed events
> in that case is if the interrupt added so many events it wrapped the
> buffer and then started dropping events.

OK, so "wrapped the buffer" means "tail (write) page caught up the commit"?

> 
> > 
> > if 
> >  - reader_page == commit_page == tail_page
> > in this case, missed_events should be 0.
> > 
> > Since the reader_page is out of the ring buffer, writer should not
> > use reader_page while reading the same reader_page, is that right?
> 
> Correct. But the writer could end up on the reader page after the swap,
> if the head page happened to be the commit page.

OK.

> 
> > 
> 
> 
> > > cpu_buffer->tail_page,
> > > +				       "Reader on commit with %ld
> > > missed events",
> > > +				       missed_events)) {
> > > +				/*
> > > +				 * If the tail page is not on the
> > > reader page but
> > > +				 * the commit_page is, that would
> > > mean that there's
> > > +				 * a commit_overrun (an interrupt
> > > preempted an
> > > +				 * addition of an event and then
> > > filled the buffer
> > > +				 * with new events). In this case
> > > it's not an
> > > +				 * error, but it should still be
> > > reported.
> > > +				 */
> > > +				pr_info("Ring buffer commit
> > > overrun lost %ld events at timestamp:%lld\n",
> > > +					missed_events,
> > > cpu_buffer->reader_page->page->time_stamp);  
> > 
> > Do we need this pr_info() for each commit overrun?
> 
> Yes. When doing this stress test, it printed at most 4 times. It
> happens once per time the interrupt fills the buffer while interrupting
> the buffer.

Ah, I meant we should report it in printk buffer, since the event
lost will happen in some case and reader can notice that.

> 
> I seldom ever get commit overruns. It's one of the fields in the status
> file located in: /sys/kernel/tracing/per_cpu/cpu*/stats
> 
> > 
> > > +			}
> > > +		}
> > >  	}  
> > 
> > Just for cleanup the code idea, with above change, this code is
> > something like;
> > 
> > ----------------
> > 
> > missed_events = cpu_buffer->lost_events;
> > 
> > if (cpu_buffer->reader_page != cpu_buffer->commit_page) {
> > 	if (missed_event) {
> > 
> > 	}
> > } else {
> > 	if (missed_event) {
> > 		if (!WARN_ONCE(cpu_buffer->reader_page ==
> > cpu_buffer->tail_page,"...")) { pr_info("...")
> > 		}
> > 	}
> > }
> > 
> > ----------------
> > 
> > Can we make it as below?
> > 
> > ----------------
> > missed_events = cpu_buffer->lost_events;
> > 
> > if (missed_event) {
> > 	if (cpu_buffer->reader_page != cpu_buffer->commit_page) {
> > 
> > 	} else if (!WARN_ONCE(cpu_buffer->reader_page ==
> > cpu_buffer->tail_page, "...") { /**/
> > 		pr_info("..."); 
> > 	}
> > }
> 
> Hmm, OK, I'll look at that.


Thanks! Anyway, the logic looks good to me.


> 
> Thanks,
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
