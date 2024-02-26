Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F46912CD9F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967539; cv=none; b=aEJqmbK6SlLgGR4Pj60y3DN3yfQuZukZSoJ+zelc/4Oex/7/jHH3piaTDbXBsX1RwBhotG1eT/65U4628EKuCryLJYxioKkcWQoLm3cRB3466EAs10gjQR9C2dXgEuGigirS/d+p8v834aRKWGXywqI7lmN6/M0WQrvDsv3L34Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967539; c=relaxed/simple;
	bh=OBEFZ/2JlXY9/LwXCtNPvNpQA2a3g4BKlYs/lUXAtDk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3xcCa62B7agbEG7wmLvkjVexWwEJpYZzi/Zd+z98dkaJz0STHAnNdMjHKsmNHQ1amr56xbKwaWmFKy/iieB30FIZrgbo7lbjs36S5NSWDGBxyfT+ClFcU/s1uR47tPN6D0LA36cZUiAuo5ptTOR2AvLkqQ8CrFWrhku2dmJWxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7974FC43390;
	Mon, 26 Feb 2024 17:12:18 +0000 (UTC)
Date: Mon, 26 Feb 2024 12:14:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: =?UTF-8?B?0JzQsNC60YHQuNC8INCc0L7RgNGB0LrQvtCy?= <xxxa0c@mail.ru>, Linux
 Trace Kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: tprobe event tracing error
Message-ID: <20240226121418.5143c6d9@gandalf.local.home>
In-Reply-To: <20240226234156.c6c647f5c005977327fde62c@kernel.org>
References: <1708954589.808811792@f182.i.mail.ru>
	<20240226234156.c6c647f5c005977327fde62c@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Feb 2024 23:41:56 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi,
> (Cc: linux-kernel-trace ML for sharing this knowledge)
>=20
> On Mon, 26 Feb 2024 16:36:29 +0300
> =D0=9C=D0=B0=D0=BA=D1=81=D0=B8=D0=BC =D0=9C=D0=BE=D1=80=D1=81=D0=BA=D0=BE=
=D0=B2 <xxxa0c@mail.ru> wrote:
>=20
> >=20
> > Hello, dear Masami.
> > I am researching Linux event tracing subsystem in part of tprobes,
> > and found interesting behavior in kernel version 6.6:
> > =C2=A0
> > echo  't:my_fchmodat sys_enter_fchmodat' |=20
sudo tee =E2=80=98/sys/kernel/tracing/dynamic_events=E2=80=99
> > bash: line 1: echo: write error: Invalid argument =20
>=20
> Yeah, I understand that you are confused by this behavior, but it is
> actually expected behavior. syscalls:* events looks like trace events
> based on tracepoint, but those are software generated trace event.
>=20
> You can find raw_syscalls:* trace events, that is based on the tracepoint,
> and other syscalls:* are based on that raw_syscalls:* trace points.
> (IOW, those are a kind of pre-compiled dynamic events)
>=20
> e.g.
>=20
> /sys/kernel/tracing # echo "t sys_enter \$arg*" >> dynamic_events=20
> /sys/kernel/tracing # cat dynamic_events=20
> t:tracepoints/sys_enter sys_enter regs=3Dregs id=3Did
>=20
> /sys/kernel/tracing # echo "t sys_enter_open \$arg*" >> dynamic_events=20
> sh: write error: Invalid argument
> /sys/kernel/tracing # cat error_log=20
> [  227.981347] trace_fprobe: error: Tracepoint is not found
>   Command: t sys_enter_open $arg*
>              ^
>=20
> So, tprobe can not find the hard-coded tracepoints for those dynamically
> generated syscall trace events. But raw_syscall sys_enter/sys_exit are OK.

Ah, that's because "tprobes" are attached to tracepoints and not
trace events. If you want to attach to trace events, you need to use eprobes
(which I need to add documentation for!).

 # echo 'e:my_fchmodat syscalls/sys_enter_fchmodat' > dynamic_events

Works.

-- Steve
