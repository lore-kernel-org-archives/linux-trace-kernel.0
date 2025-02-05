Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EF882D98;
	Wed,  5 Feb 2025 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761361; cv=none; b=r9UNZt32A1kC/E7RtRzL73fjJbV6Z+PJkLCEKCpVV274BwwhkagDX+L1V5eMgBpgNdiNIVCYOjYkZKB9zHgSvHkLxbw9cq0eNdSKXUiJYYxdWLjbcbDl//00aDJSikPxcqaCdZqRMeM7SLJblFLcZVS4uWX5qCqxUiRx9rV64pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761361; c=relaxed/simple;
	bh=pVdKMTARG7PpXdtrGq5Ko9RnznvSf7QFclunD1yuew8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XclvMBj2RY7oJgo/jg6vv7WzWo93bjPfgkVhm5w5RFPd8MukKuj1qFLpW+PZ8nsX/yEsgVKUfx1DM5t43UfM5WlFg+PhPGkimN62yVzsyNle+AljGYWqI3SPd80m6f34cfqa67dnoo/GuNJTCrKcBAkNQYhxXW8aBnXmdKPO3NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261E1C4CEE2;
	Wed,  5 Feb 2025 13:15:57 +0000 (UTC)
Date: Wed, 5 Feb 2025 08:16:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Prakash Sangappa <prakash.sangappa@oracle.com>, Peter Zijlstra
 <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ankur Arora <ankur.a.arora@oracle.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-mm@kvack.org, x86@kernel.org, Andrew
 Morton <akpm@linux-foundation.org>, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
 jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Konrad Wilk <konrad.wilk@oracle.com>,
 jgross@suse.com, Andrew.Cooper3@citrix.com, Vineeth Pillai
 <vineethrp@google.com>, Suleiman Souhlal <suleiman@google.com>, Ingo Molnar
 <mingo@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Clark Williams <clark.williams@gmail.com>, bigeasy@linutronix.de,
 daniel.wagner@suse.com, Joseph Salisbury <joseph.salisbury@oracle.com>,
 broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250205081635.397eacb0@gandalf.local.home>
In-Reply-To: <CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
References: <EC77D83D-DD17-4CCD-9EF6-C4C39FCE16E7@oracle.com>
	<9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org>
	<20250204220418.35949317@gandalf.local.home>
	<CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Feb 2025 00:09:51 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Tue, Feb 4, 2025 at 10:03=E2=80=AFPM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> >
> > On Tue, 4 Feb 2025 19:56:09 -0500
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> > =20
> > > > Here is the RFC I had sent that Peter is referring =20
> > >
> > > FWIW, I second the idea of a new syscall for this than (ab)using rseq
> > > and also independence from preemption method. I agree that something
> > > generic is better than relying on preemption method. =20
> >
> > So you are for adding another user/kernel memory mapped section? =20
>=20
> I don't personally mind that.

I'm glad you don't personally mind it. Are you going to help maintain
another memory mapped section?

>=20
> > And you are also OK with allowing any task to make an RT task wait long=
er?
> >
> > Putting my RT hat back on, I would definitely disable that on any system
> > that requires RT. =20
>=20
> Just so I understand, you are basically saying that you want this
> feature only for FAIR tasks, and allowing RT tasks to extend time
> slice might actually hurt the latency of (other) RT tasks on the
> system right? This assumes PREEMPT_RT because the latency is 50us
> right?

RT tasks don't have a time slice. They are affected by events. An external
interrupt coming in, or a timer going off that states something is
happening. Perhaps we could use this for SCHED_RR or maybe even
SCHED_DEADLINE, as those do have time slices.

But if it does get used, it should only be used when the task being
scheduled is the same SCHED_RR priority, or if SCHED_DEADLINE will not fail
its guarantees.

>=20
> But in a poorly designed system, if you have RT tasks at higher
> priority that preempt things lower in RT, that would already cause
> latency anyway. Similarly, I would also consider any PREEMPT_RT system

And that would be a poorly designed system, and not the problem of the
kernel.

> that (mis)uses this API in an RT task as also a poorly designed
> system. I think PREEMPT_RT systems generally require careful design
> anyway.  So the fact that a system is poorly designed and thus causes
> latency is not the kernel's problem IMO.

Correct. And why I don't think this should be used for RT. It's SCHED_OTHER
that doesn't have any control of the sched tick, where this hint can help.

>=20
> In any case, if you want this to only work on FAIR tasks and not RT
> tasks, why is that only possible to do with rseq() + LAZY preemption
> and not Prakash's new API + all preemption modes?
>=20
> Also you can just ignore RT tasks (not that I'm saying that's a good
> idea but..) in taskshrd_delay_resched() in that patch if you ever
> wanted to do that.
>=20
> I just feel the RT latency thing is a non-issue AFAICS.

Have you worked on any RT projects before?

-- Steve
