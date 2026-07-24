Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03115235C01;
	Fri, 24 Jul 2026 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784935576; cv=none; b=vGGWEMmPdeosgWdmncwFLjc0sC//wdZSma3ADDREkpGJ3eFid71VdFXIN0A1fabbmamo6VTV/S2i3HJqDTH5uKB25UXt0pH376XAcLVj8QDBBAZbBH2NfISjRuwvATfBk6A+i5Uc+q6K+zhqlW0yfOSbrrSZM/Nwh/9mFZflvTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784935576; c=relaxed/simple;
	bh=JY9uPGLOt+rVrc7nBVrGizLgjjMOhR3feJzd8wSRfco=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRGe+2xcARVnoWsQkj/9lBSl3OtQFc6jjsh1wm48MvLdg1dTpNd/OxRZk6Ipi71C+Z06zNGcD1M3G5GhD6SPFxn4TN88IBdAKvg0ifIt8X2QnbweUA9Al+G0160CVbyzzjQVJGZ3lAxRFp3aS4SuHLWJw3r8uf2v/46HgyGhceU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 160CD1601B5;
	Fri, 24 Jul 2026 23:26:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 1075E20025;
	Fri, 24 Jul 2026 23:26:05 +0000 (UTC)
Date: Fri, 24 Jul 2026 19:26:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>
Subject: Re: [PATCH] tracing: perf: Fix stale head for perf syscall tracing
Message-ID: <20260724192631.3b602dde@gandalf.local.home>
In-Reply-To: <20260724184250.357e91f1@gandalf.local.home>
References: <20260724184250.357e91f1@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 1075E20025
X-Stat-Signature: xmxdijkqg3k11d9sc7fg7fhdjp65nqy9
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/5NwGRMncP3Mz2y5364wqcwQASc4dfrRY=
X-HE-Tag: 1784935565-454654
X-HE-Meta: U2FsdGVkX19qNg5j1B9nxmID3kli8oJFqbvm7ikWwwop5nQgJvlCYjHHLFAT+1wL2ScT7tLGNKR2dasXFqSq5jXyR3Mcfd2Hcppxy59VMdmiPvrGPz08hbAlc9JI/iVQA90d/MvWXMmev+o6JDxGoumyuwI3xT3g3cpMn6pDMDkBYDF8913jsjtbcWdojVMLYT5OBZ82o9+yAgy5UvXx9/RpobbXRTjctrnvVQ3jEhII9vmvJKDFbNTHWNCjRUKw78ygGf1Fu6Ex8ico/s3ZKKP0t/1KiJH98SQttXNQd7laQR6ctFNMDY6sj4SfWjOK3r/qeo86dFDhyetBZ4YBFusdj797d4tfS8ydoHE9+b0tVZ16lU3MffzF695Z1zz9ZgzzjXhQ4sxsV6BuaJHRgknluN09LLjQkdziL5Rz+GNmmu6M3DTB9K3R336l5QGP

=46rom Sashiko: https://sashiko.dev/#/patchset/20260724184250.357e91f1%40gand=
alf.local.home

> --- Patch [1]: [PATCH] tracing: perf: Fix stale head for perf syscall tra=
cing ---
> commit c99950733eb63d5661f5e4d25f82dff506833b49
> Author: Steven Rostedt <rostedt@goodmis.org>
>=20
> tracing: perf: Fix stale head for perf syscall tracing
>=20
> This commit delays capturing the head of the per CPU perf events list unt=
il
> after the faulting code completes. This prevents the head pointer from po=
inting
> to the wrong CPU event if the syscall data read enables preemption and mi=
grates.
>=20
> Link: https://sashiko.dev/#/patchset/20260717173252.3431565-1-usama.arif%=
40linux.dev
>=20
> > diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscall=
s.c
> > index e98ee7e1e66f4..e541e964d1930 100644
> > --- a/kernel/trace/trace_syscalls.c
> > +++ b/kernel/trace/trace_syscalls.c
> > @@ -1440,19 +1440,20 @@ static void perf_syscall_enter(void *ignore, st=
ruct pt_regs *regs, long id)
>=20
> [ ... ]
>=20
> >  	guard(preempt_notrace)();
> > =20
> > -	head =3D this_cpu_ptr(sys_data->enter_event->perf_events);
> > -	if (hlist_empty(head))
> > -		return;
> > -
> >  	/* Check if this syscall event faults in user space memory */
> >  	mayfault =3D sys_data->user_mask !=3D 0;
> > =20
> >  	if (mayfault) {
> > +		/* Enables preemption and may migrate */
> >  		if (syscall_get_data(sys_data, args, &user_ptr,
> >  				     &size, user_sizes, &uargs, buf_size) < 0)
> >  			return;
> >  	}
> > =20
> > +	head =3D this_cpu_ptr(sys_data->enter_event->perf_events);
> > +	if (hlist_empty(head))
> > +		return;
>=20
> Will moving this early check below syscall_get_data() cause a severe
> performance regression for untraced CPUs?

I was thinking this might be the case. I originally thought it wouldn't be
too much of an issue, but I can see that the reading of user space when you
don't need to would be a regression in performance.

I'll change the above to be:

	guard(preempt_notrace)();

	head =3D this_cpu_ptr(sys_data->enter_event->perf_events);
	if (hlist_empty(head))
		return;

	/* Check if this syscall event faults in user space memory */
	mayfault =3D sys_data->user_mask !=3D 0;

	if (mayfault) {
		if (syscall_get_data(sys_data, args, &user_ptr,
				     &size, user_sizes, &uargs, buf_size) < 0)
			return;

		/* The above may have caused a migration */
		head =3D this_cpu_ptr(sys_data->enter_event->perf_events);
		if (hlist_empty(head))
			return;
	}

-- Steve



>=20
> Because the enabled_perf_enter_syscalls bitmap is global, enabling a perf
> syscall trace on one CPU causes perf_syscall_enter() to be invoked on all
> CPUs executing that syscall.
>=20
> Previously, the early hlist_empty() check allowed CPUs not actively traci=
ng
> the event to return immediately.
>=20
> By moving this check until after syscall_get_data(), doesn't this force a=
ll
> untraced CPUs to unconditionally execute expensive user-space memory copi=
es
> and preemption toggling before discarding the data?
