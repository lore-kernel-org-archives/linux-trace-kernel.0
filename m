Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F1939EF38;
	Mon, 16 Mar 2026 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675139; cv=none; b=B5Gfof0xXWQoU+fd38JgbEqrKZPqDeh+0Sv4JTNyxVcaPFp+B0ioyn0wEWVyXLLYeutKUljpQtDsimx67h20H/8ui9ClQggbgezarcDT5gi+6JVAYEy3lEtkkAYUZNLzrZsfF4DdXGIW9Ex/J9jayc8eI1UTbkBlUDsiASsPqYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675139; c=relaxed/simple;
	bh=bpK8XFgs6ySeQ78nY04cVX/1aacuG1mCw2HDIMSBLhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGtqDE7n5AzWBG57J78uzxStryBpSqSaeRATkvio+CJqj6+sk+T9HY8HxSpf0+JmVMPgQQ9/MvMdYw+q1Opxp9aJrFOQF6s2TDl0ez2+0giuRyu4BpCT5hu8KjmPPs/b4mflt03ESAQMFBOVqGo1LuBCr0+iA5020wNqHaU0LIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=EDifI+bq; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="EDifI+bq"
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 96513B3C3A;
	Mon, 16 Mar 2026 15:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1773675130;
	bh=Z7lLkAHeLGSHr1ZiNnNC5vKEy7HRABxlzZYRGN1R9Ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EDifI+bqJWjIpRUPhvq5Kq4913/23Qez627nTi2AuX1yqmD1y0HHxvbDQ5k+/Qloj
	 DgZlV+vg+osCbj4k/Qg+UMc9RNVHWi4408Qw0NIafP7VLI9p4xK7i7j/QN7dX/V6On
	 sS1ijjJGrNsqj8L1QiY4a3OWhsKxqzLeRcX96Ea8=
Date: Mon, 16 Mar 2026 15:32:07 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Usama Arif <usama.arif@linux.dev>
Cc: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] locking: Add contended_release tracepoint
Message-ID: <abgid9TwAaPJVw1b@shell.ilvokhin.com>
References: <cb89caf58885858433711f0ed6238484f5f1a67f.1773164180.git.d@ilvokhin.com>
 <20260312113815.2107882-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312113815.2107882-1-usama.arif@linux.dev>

On Thu, Mar 12, 2026 at 04:38:14AM -0700, Usama Arif wrote:
> On Tue, 10 Mar 2026 17:49:39 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:
> 
> > Add the contended_release trace event. This tracepoint fires on the
> > holder side when a contended lock is released, complementing the
> > existing contention_begin/contention_end tracepoints which fire on the
> > waiter side.
> > 
> > This enables correlating lock hold time under contention with waiter
> > events by lock address.
> > 
> > Add trace_contended_release() calls to the slowpath unlock paths of
> > sleepable locks: mutex, rtmutex, semaphore, rwsem, percpu-rwsem, and
> > RT-specific rwbase locks. Each call site fires only when there are
> > blocked waiters being woken, except percpu_up_write() which always wakes
> > via __wake_up().
> > 
> > Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> > ---
> >  include/trace/events/lock.h   | 17 +++++++++++++++++
> >  kernel/locking/mutex.c        |  1 +
> >  kernel/locking/percpu-rwsem.c |  3 +++
> >  kernel/locking/rtmutex.c      |  1 +
> >  kernel/locking/rwbase_rt.c    |  8 +++++++-
> >  kernel/locking/rwsem.c        |  9 +++++++--
> >  kernel/locking/semaphore.c    |  4 +++-
> >  7 files changed, 39 insertions(+), 4 deletions(-)
> > 

[...]

> > diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
> > index f3ee7a0d6047..1eee51766aaf 100644
> > --- a/kernel/locking/percpu-rwsem.c
> > +++ b/kernel/locking/percpu-rwsem.c
> > @@ -263,6 +263,8 @@ void percpu_up_write(struct percpu_rw_semaphore *sem)
> >  {
> >  	rwsem_release(&sem->dep_map, _RET_IP_);
> >  
> > +	trace_contended_release(sem);
> > +
> 
> Hello!
> 
> I saw that you mentioned in the commmit message that you do this for only
> blocked waiters except for percpu_up_write(). We can use
> waitqueue_active(&sem->waiters) to check for this over here so that
> its consistent with every other call?

Thanks for the feedback, Usama.

I thought about it and even mentioned in the comment, but I forgot what
was the reason. Now, I think you are correct. I added wq_has_sleeper()
locally instead of waitqueue_active() locally, since we are not holding
the lock here and waitqueue_active() requires a barrier based on the
comment. It might be not very important here, but I'd rather make it
correct even for tracepoint.

Note that __percpu_up_read() doesn't need this guard. Maybe I was
thinking at __percpu_up_read() part before and just made it symmetric.

Anyway, thanks for suggestion.

> 
> 
> >  	/*
> >  	 * Signal the writer is done, no fast path yet.
> >  	 *
> > @@ -297,6 +299,7 @@ void __percpu_up_read(struct percpu_rw_semaphore *sem)
> >  	 * writer.
> >  	 */
> >  	smp_mb(); /* B matches C */
> > +	trace_contended_release(sem);
> 
> Should we do this after this_cpu_dec(*sem->read_count)?

Good point. I moved it after this_cpu_dec() so the tracepoint fires
after the lock is released but before rcuwait_wake_up(). I also went
through all other call sites and made the placement consistent where
possible: after release, before wake. It should be fixed in v3.
