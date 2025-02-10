Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FBC25C6F8;
	Mon, 10 Feb 2025 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216910; cv=none; b=JnLaGt26QJLcbo651vZz7RMhlB5GJGfT6Ej8oJCJjPkSp2bRBy6z4CccibItesgpXbeo85/IQshWMOFGrB7lFdnM7zn4PxrHDCz6EzBaYjCf7U/YTNUifHO11KP4vTrp6WCAYo1lxZQYr3wgpmbqJMP09mrpbv8raK7D0tSHybs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216910; c=relaxed/simple;
	bh=IJBdki5d5FLw9/J5QGo9ojNubzXvoVDKoTSlLUz0EIE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tk57lEt7pDOH2ot4/RaN6UkS48qn45r1WODFKjp9xQkvZkphLzZ6l6O+yOVvG0fmegxhUY/MpCxvd0dtjLlTz5DmsFrogv+T03SqH7Ud7rp/8ioVEMDf0yuPIKlmLU7JhT+Cj4AsBMAoCM3gUOf/aWLWzO69xNTG/RxCOTcd78k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEAFC4CEE4;
	Mon, 10 Feb 2025 19:48:26 +0000 (UTC)
Date: Mon, 10 Feb 2025 14:48:29 -0500
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
Message-ID: <20250210144829.02e66f44@gandalf.local.home>
In-Reply-To: <CAEXW_YThrUgbbmje_1hRtWzNC5SozirDwhpccZiV=Trhe7HiHw@mail.gmail.com>
References: <EC77D83D-DD17-4CCD-9EF6-C4C39FCE16E7@oracle.com>
	<9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org>
	<20250204220418.35949317@gandalf.local.home>
	<CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
	<20250205081635.397eacb0@gandalf.local.home>
	<CAEXW_YQY2zuU+XZjrYWLS860+PJno0nf9WAe1iPU=EyDkA7H4Q@mail.gmail.com>
	<20250206083039.0916ad24@gandalf.local.home>
	<CAEXW_YThrUgbbmje_1hRtWzNC5SozirDwhpccZiV=Trhe7HiHw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Feb 2025 09:07:27 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Thu, Feb 6, 2025 at 8:30=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
> >
> > On Wed, 5 Feb 2025 22:07:12 -0500
> > Joel Fernandes <joel@joelfernandes.org> wrote: =20
> > > >
> > > > RT tasks don't have a time slice. They are affected by events. An e=
xternal
> > > > interrupt coming in, or a timer going off that states something is
> > > > happening. Perhaps we could use this for SCHED_RR or maybe even
> > > > SCHED_DEADLINE, as those do have time slices.
> > > >
> > > > But if it does get used, it should only be used when the task being
> > > > scheduled is the same SCHED_RR priority, or if SCHED_DEADLINE will =
not fail
> > > > its guarantees.
> > > > =20
> > >
> > > Right, it would apply still to RR/DL though... =20
> >
> > But it would have to guarantee that the RR it is delaying is of the same
> > priority, and that delaying the DL is not going to cause something to m=
iss
> > its deadline. =20
>=20
> See Peter comment: "Then pick another number; RT too has a max
> scheduling latency number (on some random hardware). If you stay below
> that, all is fine.".

See mine and Sebastion's reply. Just adding another interrupt turn around,
and you already lost.


> > You see, LAZY was *created* for this purpose. Of letting the scheduler =
know
> > that the running task is in a critical section and the timer tick should
> > not preempt a SCHED_OTHER task.
> > I just wanted to extend this to SCHED_OTHER in user space too. =20
>=20
> Currently it does not "let anyone know" it is running in a critical
> section though. Various paths (update_curr(), wake up) just do a
> 'lazy' resched until the timer tick has elapsed, or the task returns
> to usermode/idle at which point schedule() is called. And it does this
> only for FAIR tasks. That can well happen even if the currently
> running task is not in a critical section in the kernel at all. Sure,
> it may benefit critical sections in the upstream kernel but where is
> that explicit?  I still feel we should not overload this in-kernel
> mechanism for userspace locking and complicate things.

That's nice that you don't feel it. But I do. ;-)

>=20
> > > Yes, I have worked on RT projects before --  you would know better
> > > than anyone. :-D. But admittedly, I haven't got to work much with
> > > PREEMPT_RT systems. =20
> >
> > Just using RT policy to improve performance is not an RT project. I'm
> > talking about projects that if you miss a deadline things crash. Where =
the
> > project works very hard to make sure everything works as intended. =20
>=20
> No no no, I have done way more than applying just the RT policy. So
> that means you do not know me that well;-).. I have worked on audio
> driver latency, low latency audio, latency issues in vmalloc code,
> preempt tracers, irq tracepoints , wake up latency tracers and various
> scheduler overhead debug =E2=80=94 many of those issues dealt with sub
> millisecond latency.. I also dealt with cpu idle issues in the
> hardware causing real time latency problems (see my past talks if
> interested).  I was partly a hardware engineer when I started my
> career and have built circuits. I have Electronics and Computer
> engineering degrees.

None of that sounds to me like an RT project. I'm talking about robotics,
industrial machines, autonomous driving, power plants, etc. Where
everything is measured in WCET.

-- Steve
