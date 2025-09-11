Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50648156F45;
	Thu, 11 Sep 2025 23:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757632796; cv=none; b=X6xS+zJxcaWv/+Q8nC6V1Qpk1wIJO7/R5MLWl5zlFzIgaJQrjgdA9skaa2wI+LeFvHC+qvdh57LHoigb+Hom9fvNnOnRbqp7App+TfkfphTta6H41cO4peyJtmnp3tNj4rLZ6C9TXmsip36dWP85BNE3V0M+xu2diHR13+dSHGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757632796; c=relaxed/simple;
	bh=uod826s70yyCvC1XsHR+nFj3UJnMt9c9pTrRfcjC6sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L09sjATE9PAtHQSYdJ0xPgL+9GuiWMG1r7KYCsyOCySOsjQ2DGSLt8woQ7YPo5PgwV5HZP7Gzv6CRquoeUS1KJDAw4GDHJAuLKN7dgSy63Zr35X4GRtNfywc8m1VALk6ioXoLVQV9GsN4QOHVAdBIc9iN+7MUD8ZRiwaLZj2Izk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 33F75BA470;
	Thu, 11 Sep 2025 23:19:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id EFAD42000D;
	Thu, 11 Sep 2025 23:19:47 +0000 (UTC)
Date: Thu, 11 Sep 2025 19:20:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, Takaya Saeki <takayas@google.com>, Tom
 Zanussi <zanussi@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ian
 Rogers <irogers@google.com>, aahringo@redhat.com, Douglas Raillard
 <douglas.raillard@arm.com>
Subject: Re: [PATCH 1/7] tracing: Replace syscall RCU pointer assignment
 with READ/WRITE_ONCE()
Message-ID: <20250911192040.6c5ccb51@gandalf.local.home>
In-Reply-To: <e7d9ecb7-8bdb-4c91-b727-375a2c5a190e@paulmck-laptop>
References: <20250805192646.328291790@kernel.org>
	<20250805193234.745705874@kernel.org>
	<e7d9ecb7-8bdb-4c91-b727-375a2c5a190e@paulmck-laptop>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: j69ngrk3k3cwoteu3qpdqyxwn9994qpc
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: EFAD42000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Jc5T7+knTA84TUSWHIrdOpuy4N+vyd1U=
X-HE-Tag: 1757632787-331222
X-HE-Meta: U2FsdGVkX18sRJI2pFkyN/C99yBs64fIGEOlwhwlaWmUGEXdRsRmOotiVjq6Gnx1kyy2p030rRxkBf8QZKa6+KQkfR6fFVCPwA/C5OALou8NULq5pO0luSfPzVq/42cCbsdjBga3maMjILaMrz0GFLySC9i1s+2Nl20NLamnda+kKkCT7U/TneLOdAFtgEmyEqAf9z3C6KPbpseRx5vNZziyvW5xwaND2N9/39gw9kM06VqGyDHitONHwLxtuGdTvWKM5Q0DVPWhb1Y1AH5QGvIJ01mFNq9lqc4aJwTPE5V3Wn6EYerSH+lm+c4jgHCqBML5/5cQf6JrYCIjRHBaKAxJ+tK+G01m4yv2GUf3vh0U6IoG52rp5Gruxgz0AtRqDOH5KcZFAuaBWQJ0XAxFEw==


Finally have time to get back to these patches.

On Wed, 6 Aug 2025 11:39:57 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Tue, Aug 05, 2025 at 03:26:47PM -0400, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > The syscall events are pseudo events that hook to the raw syscalls. The
> > ftrace_syscall_enter/exit() callback is called by the raw_syscall
> > enter/exit tracepoints respectively whenever any of the syscall events are
> > enabled.
> > 
> > The trace_array has an array of syscall "files" that correspond to the
> > system calls based on their __NR_SYSCALL number. The array is read and if
> > there's a pointer to a trace_event_file then it is considered enabled and
> > if it is NULL that syscall event is considered disabled.
> > 
> > Currently it uses an rcu_dereference_sched() to get this pointer and a
> > rcu_assign_ptr() or RCU_INIT_POINTER() to write to it. This is unnecessary
> > as the file pointer will not go away outside the synchronization of the
> > tracepoint logic itself. And this code adds no extra RCU synchronization
> > that uses this.
> > 
> > Replace these functions with a simple READ_ONCE() and WRITE_ONCE() which
> > is all they need. This will also allow this code to not depend on
> > preemption being disabled as system call tracepoints are now allowed to
> > fault.
> > 
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> 
> >From an RCU-removal viewpoint:  
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Thanks for the review. I'm also removing the __rcu that triggered the bot.

> 
> But is it possible to give some sort of warning just in case some creative
> future developer figures out how to make the file pointer go away outside
> of the synchronization of the tracepoint logic itself?

That would be quite a big change, and since this is the core code to it,
that future change should fix up this code as well. All the modification
happens in this file so nothing should be hidden.

If they do get it wrong, it should crash pretty amazingly if there's any
testing ;-)

-- Steve
