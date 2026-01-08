Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDED2DB781;
	Thu,  8 Jan 2026 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891464; cv=none; b=ouCMFN/khF3I0fCUgx7Er/tXsI6GLV4ymyyQWxx29lcf+nC7mwL2jjqvgwkdiGQU6W2Vd1CxyS6cUM2LzikvWadVRwJ8S47oxaSpYKmTl2OtKOgVHK322BWCg4Ajb3KHYdQ1uxhOJQZ3Dw7A+Yyia2o0KjlwhV9ieryLaClzbmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891464; c=relaxed/simple;
	bh=UAceDZbYRNkfpisY6eAs0QIMEBlYEfpWlQGxjpRJ42g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UewIWVUasZHLMRWhyfakVtwRzgxIUXSzlbQjku0ml8ZKI674PFiO352HtJqP1J3xJyLupnzs+QcU03AZYKss2ZGM48SQIK8JdwxEKEHYrfkPvDn4OH6D0CP1iowZeEqexGIsDD19n0kISvGQQINLPVmI8mcQ3CTpqZtIG5P10XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id B7B5B88E48;
	Thu,  8 Jan 2026 16:57:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id B19DA2000D;
	Thu,  8 Jan 2026 16:57:31 +0000 (UTC)
Date: Thu, 8 Jan 2026 11:58:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Tesarik <ptesarik@suse.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] ring-buffer: Use a housekeeping CPU to wake up waiters
Message-ID: <20260108115800.7a7fc8a7@gandalf.local.home>
In-Reply-To: <20260108093932.252f6bc7@mordecai>
References: <20260106091039.2012108-1-ptesarik@suse.com>
	<20260106170405.425f469e@gandalf.local.home>
	<20260107085009.58fcffd4@mordecai>
	<20260107105137.4cf9a67e@mordecai>
	<20260107111709.0d115cd8@gandalf.local.home>
	<20260107111935.3befc296@gandalf.local.home>
	<20260108093932.252f6bc7@mordecai>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 63ugwo84xqjrch88aahuntsngh5dw5bb
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: B19DA2000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18NxNBArmXgF7QTPXJ5Rx0qWwuxNuUbN64=
X-HE-Tag: 1767891451-247880
X-HE-Meta: U2FsdGVkX19oHAgwvPNM/nkkKUBwSkMpLSpmlFGlnPiOigI0xtOz1kalxNYz0blyC21FQ7czDr+KiDLHK299ckm1HTxv6gLhGJ1MyVVHx5xUTDc7BdV3D1z0yunfpCCclS36oqkx8Em0miyCrgQtAXyA2aLJ8UEnPcb411jMx4GWMm7NJ9deqOP3nqVVIe2A+BvMRPOHhS9sEaHHrriC1KJCLiDYzkOp/QfPu60dESyqU65BAnkcXJaI2XBdI/R6PdtyKIQhl/REsbnPjpeHImOJ1HHCHJneG9o81SEEX+S35M111S5FKEAvzzjfriOpS/KyDe8QSer1FbjLGpG256uNR5yp/k1fe8HdK9FqS+C7S3d4V1H77BWN2yOk6MmN

On Thu, 8 Jan 2026 09:39:32 +0100
Petr Tesarik <ptesarik@suse.com> wrote:

> > > Or we simply change it to:
> > > 
> > > static inline void    
> > 
> > Actually, the above should be noinline, as it's in a slower path, and
> > should not be adding logic into the cache of the fast path.  
> 
> However, to be honest, I'm surprized this is considered slow path. My
> use case is to record a few selected trace events with "trace-cmd
> record", which spends most time polling trace_pipe_raw. Consequently,
> there is almost always a pending waiter that requires a wakeup.
> 
> In short, irq_work_queue() is the hot path for me.
> 
> OTOH I don't mind making it noinline, because on recent Intel and AMD
> systems, a function call (noinline) is often cheaper than an increase
> in L1 cache footprint (caused by inlining). But I'm confused. I have
> always thought most people use tracing same way as I do.

The call to rb_wakeups() is a fast path, but the wakeup itself is a slow
path. This is the case even when you have user space in a loop that is just
waiting on data.

User space tool:

  ring_buffer_wait() {
    wake_event_interruptible(.., rb_wait_cond(..));
  }

Writer:

  rb_wakeups() {
    if (!full_hit())
      return;
  }

The full_hit() is the watermark check. If you look at the tracefs
directory, you'll see a "buffer_percent" file, which is default set to 50.
That means that full_hit() will not return true until the ring buffer is
around 50 percent full. This function is called thousands of times before
the first wakeup happens.

Let's look at even a waiter that isn't using the buffer percent. This means
it will be woken up on any event in the buffer.

  rb_wakeups() {
	if (buffer->irq_work.waiters_pending) {
		buffer->irq_work.waiters_pending = false;
		/* irq_work_queue() supplies it's own memory barriers */
		irq_work_queue(&buffer->irq_work.work);


So it clears the waiters_pending flag and wakes up the waiter. Now the
waiter wakes up and starts reading the ring buffer. While the ring buffer
has content, it will continue to read and doesn't block again until the
ring buffer is empty. This means that thousands of events are being
recorded with no waiters to wake up.

See why this is a slow path?

-- Steve
