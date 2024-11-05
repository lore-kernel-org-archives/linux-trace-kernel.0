Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F857DA7F;
	Tue,  5 Nov 2024 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730826168; cv=none; b=Dk6F0fGenOqGWBlwVGaj2BFwpphiLdUFjyLEHps3ftzvii14bi0D8G2NDg5P3V3N/OsU8lLs/thnLa8bWp8w9QBWY1GlyrGPr1UTiHJ8Hs2pG95mHNioce18IeT68MKR5ltdsTbZxTaejskIcnfnLUxvYb16JStf8eoNGuMxbYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730826168; c=relaxed/simple;
	bh=cfKe/JDhKQIlAT2qRSJwrXsokmxwETwrKc+kre7MRcw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iTo64/UTl+7YNgvYiQoJY8hvBqSv5WIFwhZGDgqssOCWsZQskrt52iQa3qRmjcAfSGAUP7sIoHley8hSO5lRdeeyzuh6Jlgrbi3YYmQh6RtveYKiQUHumusy6iX4qpZjWWKP5YJVjZ/s/7l63cWthJ5qeGmB30QWrVBd7jTbF64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB424C4CECF;
	Tue,  5 Nov 2024 17:02:46 +0000 (UTC)
Date: Tue, 5 Nov 2024 12:02:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Marco Elver <elver@google.com>
Cc: Kees Cook <keescook@chromium.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Dmitry
 Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH] tracing: Add task_prctl_unknown tracepoint
Message-ID: <20241105120247.596a0dc9@gandalf.local.home>
In-Reply-To: <CANpmjNMuTdLDMmSeJkHmGjr59OtMEsf4+Emkr8hWD++XjQpSpg@mail.gmail.com>
References: <20241105133610.1937089-1-elver@google.com>
	<20241105113111.76c46806@gandalf.local.home>
	<CANpmjNMuTdLDMmSeJkHmGjr59OtMEsf4+Emkr8hWD++XjQpSpg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Nov 2024 17:53:53 +0100
Marco Elver <elver@google.com> wrote:

> > > +/**
> > > + * task_prctl_unknown - called on unknown prctl() option
> > > + * @task:    pointer to the current task
> > > + * @option:  option passed
> > > + * @arg2:    arg2 passed
> > > + * @arg3:    arg3 passed
> > > + * @arg4:    arg4 passed
> > > + * @arg5:    arg5 passed
> > > + *
> > > + * Called on an unknown prctl() option.
> > > + */
> > > +TRACE_EVENT(task_prctl_unknown,
> > > +
> > > +     TP_PROTO(struct task_struct *task, int option, unsigned long arg2, unsigned long arg3,
> > > +              unsigned long arg4, unsigned long arg5),
> > > +
> > > +     TP_ARGS(task, option, arg2, arg3, arg4, arg5),
> > > +
> > > +     TP_STRUCT__entry(
> > > +             __field(        pid_t,          pid             )  
> >
> > Why record the pid that is already recorded by the event header?  
> 
> To keep in style with the other "task" tracepoints above. I can
> certainly do without - it does seem unnecessary.

Hmm, new_task, pid is different than the creator. But rename is pointless
to record pid. I would get rid of it here, especially since it also creates
a hole in the event (three int fields followed by a long).

> 
> To cleanup, do we want to remove "pid=" from the other tracepoints in
> this file as well (in another patch). Or does this potentially break
> existing users?

We can't from task_newtask as that's the pid of the task that's being
created. In other words, it's very relevant. The task_rename could have its
pid field dropped.

> 
> > > +             __string(       comm,           task->comm      )  
> >
> > I'm also surprised that the comm didn't show in the trace_pipe.  
> 
> Any config options or tweaks needed to get it to show more reliably?
> 
> > I've
> > updated the code so that it should usually find it. But saving it here may
> > not be a big deal.  

How did you start it? Because it appears reliable for me.

-- Steve
