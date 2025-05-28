Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90062750E8;
	Wed, 28 May 2025 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748446439; cv=none; b=FPNkY1M7dBhMDx2sZ+JKU4WZwKfVOpGvRsH0y9VxsZEPS++D+0IrwJFMR1UseeByMWfiRnTqa9IlmTwa4WLnkRg+fjskjgnddsd5Erya6l81Sd00k7lCqTqEVuP9lU1tZJ3zg47fcENer2xMu82ieVQ3MsbSt2QbItCnWDzwjJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748446439; c=relaxed/simple;
	bh=wWRlt5ac/IDUzhdtP1HOGjZn9n1erecPDNu8yCIMvzI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QgLYwCguXfaPfICpawkrroxCUO4aqCmmawHwi1Rc73XgXMZEWsS1r8UBhpy0gzzd+7Am8Mf5HBYW53dRNq0RWcxlSQvpXt7U0q+Mp6k96NbWM6QLWIkPveTyb8jK/GCH7Oun61l6AbgOPinUfgEDoHR4sLkDGL9QhP3LKG1rlo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E176C4CEEE;
	Wed, 28 May 2025 15:33:58 +0000 (UTC)
Date: Wed, 28 May 2025 11:34:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH] ring-buffer: Do not trigger WARN_ON() due to a
 commit_overrun
Message-ID: <20250528113439.3fa4f245@gandalf.local.home>
In-Reply-To: <20250529000342.5218ac7b90c99f3636edd5ab@kernel.org>
References: <20250527121140.0e7f0565@gandalf.local.home>
	<20250528104203.d6f509c5d9c30dec1e024587@kernel.org>
	<20250527221735.04c62a3c@batman.local.home>
	<20250529000342.5218ac7b90c99f3636edd5ab@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 May 2025 00:03:42 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > > (BTW, what happen if the interrupted process commits the event? That
> > >  event will be lost, or commit and just move commit_page?)  
> > 
> > No, the first event to be created is the "commit" event. If it gets
> > interrupted and the interrupt adds a bunch of events that wraps the
> > ring buffer, it can't touch the commit event, it will just start
> > dropping events. Then when the commit event finishes, it can either be
> > read by the reader, or overwritten by the next events coming in.  
> 
> Hmm, rb_end_commit() seems to try commit all nested events (committing > 1)
> if committing == 1, and the rb_set_commit_to_write() pushes commit pointer
> to the latest write pointer. So when it "start dropping events"? (is that
> write side?)

The "start dropping events" is when committing > 1. The commit overrun
events dropping happens in rb_move_tail(), where a write falls off the end
of the sub buffer and moves the tail to the next sub-buffer. If the next
sub-buffer is the commit page, then it fails and just drops the event. This
will never happen when committing == 1.

> 
> > > 
> > > Thus the reader_page == commit_page && reader_page == tail_page,
> > > missed_events should be 0?
> > > 
> > > Possible cases if missed_events != 0:
> > > 
> > >  - reader_page != commit_page
> > > 	(writer's commit overtook the reader)  
> > 
> > The reader is never in the write buffer. Just the head page will move.
> > When a new reader page is taken it will swap out the old reader page
> > with the head page. If the head page is the commit page, then the
> > commit page becomes the reader page too.  
> 
> Hmm, so this is the case that the writer is too fast and it moves
> head page to the next page. Thus some events on old head page are
> lost.

This has nothing to do with the speed of the reader. When a event is being
written, and it gets interrupted and the interrupt starts writing events,
the interrupted event stays put. The reader could be very fast, but it will
stop when it gets to the commit page. Thus, the reader could be all caught
up, but is now waiting for new events to be committed.

If an event is interrupted, no event is fully committed until that event is
no longer interrupted and then can continue.

  rb_reserve_next_event() {
    rb_start_commit() <<-- here the reader can never go past the commit page

    [ interrupt start ]
	for (i = 0; i < 10000000000; i++)
           rb_reserve_next_event();  <<-- This will eventually fill up the
                                          buffer, but will stop when it
                                          hits the commit page and that
                                          will be when the commit overrun
                                          events start dropping.

[ On another CPU:
  ring_buffer_map_get_reader() <<-- This now gets the commit page as the
				    reader page, and there will be missed
				    events.
]
    [ interrupt end ]

    rb_end_commit() <<-- This will move the commit page forward.
}

This is a very unlikely scenario, but I can trigger it with the
perf/trace-cmd test that enables all events and function tracing with KASAN
and lockdep enabled running hackbench, as that pretty much creates the:
	for (i = 0; i < 10000000000; i++)
           rb_reserve_next_event();
scenario.

And even in that case, it triggers at most a couple of times a second:


> OK, so "wrapped the buffer" means "tail (write) page caught up the commit"?

Yes.

> > > Do we need this pr_info() for each commit overrun?  
> > 
> > Yes. When doing this stress test, it printed at most 4 times. It
> > happens once per time the interrupt fills the buffer while interrupting
> > the buffer.  
> 
> Ah, I meant we should report it in printk buffer, since the event
> lost will happen in some case and reader can notice that.

I think we agree here?

Thanks for the review, I'll have a new patch shortly.

-- Steve


