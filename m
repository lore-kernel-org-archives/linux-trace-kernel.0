Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0778B175A5;
	Fri, 22 Nov 2024 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732305481; cv=none; b=DqHZB6VPCb/u8kxw80b3ixvSjUM0uiyQYsrJg5wgTm/1u/+bAi11ASUjozHjYcybnvH9JdF9j2g0G/ZtXJ7qZ8v0q7WOmuE3cL3BtVzuw0SLwCVWTYBRbzGEkGqYwSgmxUxHzkgy5NQO05Ez5vDDbqEiGYOBnQ5+t4OgzjWDky4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732305481; c=relaxed/simple;
	bh=HgsLnUZvvqHmRZhVW255PRivsV04tH9vwrjuGpcheJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+BobCPZJX8Gwp21vGgyicFVz47gPMXgKM+JNMyF+8nkHFJytm1o7rVKCu5E3J9pPulvhC8tgTTwqFlcjgH4FvR6YoO9LsK8H0Nr1XEIZfhA+HEEzDzgfogry2hxS+yFv4pKDOCjrDcRRQnsfZTfbP6Z3Tm5w+Evhru+kWSnQxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2311C4CECE;
	Fri, 22 Nov 2024 19:57:58 +0000 (UTC)
Date: Fri, 22 Nov 2024 14:58:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Peter
 Zijlstra <peterz@infradead.org>, tglx@linutronix.de, mingo@kernel.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, ankur.a.arora@oracle.com, efault@gmx.de, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3] tracing: Record task flag NEED_RESCHED_LAZY.
Message-ID: <20241122145839.15fc318d@gandalf.local.home>
In-Reply-To: <20241122143742.038c77fa@gandalf.local.home>
References: <20241122173201.tsqK0eeD@linutronix.de>
	<20241122143742.038c77fa@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Nov 2024 14:37:42 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 22 Nov 2024 18:32:01 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>=20
> > From: Thomas Gleixner <tglx@linutronix.de>
> >=20
> > The scheduler added NEED_RESCHED_LAZY scheduling. Record this state as
> > part of trace flags and expose it in the need_resched field.
> >=20
> > Record and expose NEED_RESCHED_LAZY.
> >=20
> > [bigeasy: Commit description, documentation bits.]
> >=20
> > Reviewed-by: Ankur Arora <ankur.a.arora@oracle.com>
> > Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> > v2=E2=80=A6v3:
> >   - Use 0x02 for TRACE_FLAG_NEED_RESCHED_LAZY which is the freshly
> >     created gap.
> >=20
> >  Documentation/trace/ftrace.rst |  4 ++++
> >  include/linux/trace_events.h   |  1 +
> >  kernel/trace/trace.c           |  2 ++
> >  kernel/trace/trace_output.c    | 14 +++++++++++++-
> >  4 files changed, 20 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrac=
e.rst
> > index 74d5bd801b1a8..16892b844108c 100644
> > --- a/Documentation/trace/ftrace.rst
> > +++ b/Documentation/trace/ftrace.rst
> > @@ -1033,9 +1033,13 @@ explains which is which.
> >    irqs-off: 'd' interrupts are disabled. '.' otherwise.
> > =20
> >    need-resched:
> > +	- 'B' all, TIF_NEED_RESCHED, PREEMPT_NEED_RESCHED and TIF_RESCHED_LAZ=
Y is set,
> >  	- 'N' both TIF_NEED_RESCHED and PREEMPT_NEED_RESCHED is set,
> >  	- 'n' only TIF_NEED_RESCHED is set,
> >  	- 'p' only PREEMPT_NEED_RESCHED is set, =20
>=20
> > +	- 'L' borg PREEMPT_NEED_RESCHED and TIF_RESCHED_LAZY is set,
> > +	- 'b' borg TIF_NEED_RESCHED and TIF_RESCHED_LAZY is set, =20
>=20
>    Is resistance futile?
>=20
> I can switch it over to "both" if that's what you meant.

Actually, on Monday, can you send me a v4 with this fix?

I just realized that this patch depends on both my branch (which I'm still
waiting for Linus to pull) and the code that is already in Linus's tree.
Once Linus pulls my branch, I'll apply this on that merge commit. But that
will not be until next week.

Thanks,

-- Steve
