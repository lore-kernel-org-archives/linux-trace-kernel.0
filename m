Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21C015CD76
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135449; cv=none; b=U8mCaezxxc45hfhyuOpoC7K8+PI6Vw8t0pENtQVEEbTYUazUBiJL+MiD5j2JSLzB0DOhqnTtBmeq2NIj/cFPSA+SNdT+6ft90WWWx2e+ghre0cqu15KmmwWdVyyRF77VljKSsoMy3DXDL2xgPHLWD53h2wSH9zyjPmXxVUOeUAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135449; c=relaxed/simple;
	bh=EXWhywFrMXBmIjAVnH078Ktx9v8rrCB88GJbbv3pOac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmzAgYau0MljSr+7vDNta+jBH/QX3tvfn8jqe1tWNQQ1e2BMRNNb+yQ0/ofohpW6o9zpYSN8TCECQMvRPMFA49iSwGkoKE7sqE/K1bCnat2fDHdxI63oiu/jpdN8BALPQMo7vG8FJBAeCebP8SkAjPsILSrMeZMFx6Kfr3EIKdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31CCC43399;
	Wed, 28 Feb 2024 15:50:48 +0000 (UTC)
Date: Wed, 28 Feb 2024 10:52:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: =?UTF-8?B?0JzQsNC60YHQuNC8INCc0L7RgNGB0LrQvtCy?= <xxxa0c@mail.ru>
Cc: Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, "Masami
 Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: tprobe event tracing error
Message-ID: <20240228105252.5fb19b13@gandalf.local.home>
In-Reply-To: <1709130340.286978721@f107.i.mail.ru>
References: <1708954589.808811792@f182.i.mail.ru>
	<20240226234156.c6c647f5c005977327fde62c@kernel.org>
	<20240226121418.5143c6d9@gandalf.local.home>
	<1709130340.286978721@f107.i.mail.ru>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Feb 2024 17:25:40 +0300
=D0=9C=D0=B0=D0=BA=D1=81=D0=B8=D0=BC =D0=9C=D0=BE=D1=80=D1=81=D0=BA=D0=BE=
=D0=B2 <xxxa0c@mail.ru> wrote:

> Dear colleagues,
> One last question =E2=80=94 is it bug or feature that trobe event tracing=
 can not correctly dereference string pointers from pt_regs?
> For example:
> echo 't:tmy_chmod sys_enter id=3D$arg2 filename=3D+8($arg1):string mode=
=3D+16($arg1)'  | sudo tee =E2=80=98/sys/kernel/tracing/dynamic_events=E2=
=80=99

So the tprobe attaches to the tracepoint, which is this:

 trace_sys_enter(regs, syscall);

Where arg1 is pt_regs, which on x86_64 (I'm assuming that's what you are
using) has:

struct pt_regs {
/*
 * C ABI says these regs are callee-preserved. They aren't saved on kernel =
entry
 * unless syscall needs a complete, fully filled "struct pt_regs".
 */
	unsigned long r15;
	unsigned long r14;
	unsigned long r13;
	unsigned long r12;
	unsigned long rbp;
	unsigned long rbx;
/* These regs are callee-clobbered. Always saved on kernel entry. */
	unsigned long r11;
	unsigned long r10;
	unsigned long r9;
	unsigned long r8;
	unsigned long rax;
	unsigned long rcx;
	unsigned long rdx;
	unsigned long rsi;
	unsigned long rdi;
/*
 * On syscall entry, this is syscall#. On CPU exception, this is error code.
 * On hw interrupt, it's IRQ number:
 */
	unsigned long orig_rax;
/* Return frame for iretq */
	unsigned long rip;
	unsigned long cs;
	unsigned long eflags;
	unsigned long rsp;
	unsigned long ss;
/* top of stack page */
};

Where regs+8 is register r14.  and regs+16 is r13. Is that what you really =
want?

No, it's not.

Also, I noticed that you are not tracing chmod, but you are tracing id =3D =
268
which is fchownat() (I noticed via strace, that this is what "chmod" uses).

The prototype of fchownat() is:

  int fchmodat(int dirfd, const char *pathname, mode_t mode, int flags);

Where pathname is the third parameter, not the first, and mode is the third.

The calling convention for x86_64 is:  rdi rsi rdx rcx r8-9=20

That is, arg1 is in register rdi, arg2 is rsi, arg3 is rdx.

We want arguments 2 and 3. Which is:

  regs:		$arg1
  regs->rsi:	+104($arg1)
  regs->rdx:	+96($arg1)

And since the file name is a string, we need to do one more dereference to
get to it:

  pathname:	+0(+104($arg1)):ustring

(notice I used "ustring" as we now differentiate between kernel and user sp=
ace)

With the above information I can do:

 # cd /sys/kernel/tracing
 # echo 't:tmy_chmod sys_enter id=3D$arg2 filename=3D+0(+104($arg1)):ustrin=
g mode=3D+96($arg1):x16' > dynamic_events
 # echo 'id =3D=3D 268' > events/tracepoints/tmy_chmod/filter
 # echo 1 > events/tracepoints/tmy_chmod/enable
 # mkdir /tmp/x
 # chmod 100 /tmp/x
 # cat trace

# tracer: nop
#
# entries-in-buffer/entries-written: 2/2   #P:8
#
#                                _-----=3D> irqs-off/BH-disabled
#                               / _----=3D> need-resched
#                              | / _---=3D> hardirq/softirq
#                              || / _--=3D> preempt-depth
#                              ||| / _-=3D> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
           chmod-1035    [004] ...1.  1744.492490: tmy_chmod: (__probestub_=
sys_enter+0x4/0x10) id=3D0x10c filename=3D"/tmp/x" mode=3D0x40

  TADA!!!

-- Steve


> echo 'id =3D=3D 268' | sudo tee =E2=80=98/sys/kernel/tracing/events/trace=
points/tmy_chmod/filter=E2=80=99
> echo '1' | sudo tee =E2=80=98/sys/kernel/tracing/events/tracepoints/tmy_c=
hmod/enable=E2=80=99
> echo =E2=80=981=E2=80=99 | sudo tee =E2=80=98/sys/kernel/tracing/tracing_=
on=E2=80=99
>=20
> cat =E2=80=98/sys/kernel/tracing/trace=E2=80=99
> # =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TASK-PID =
=C2=A0=C2=A0=C2=A0=C2=A0CPU# =C2=A0||||| =C2=A0TIMESTAMP =C2=A0FUNCTION=20
> # =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0| | =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| =C2=A0=C2=A0=
||||| =C2=A0=C2=A0=C2=A0=C2=A0| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chmod-10522 =
=C2=A0=C2=A0[010] ...1. =C2=A08533.321703: tmy_chmod: (__probestub_sys_ente=
r+0x0/0x10) id=3D0x10c fd=3D0x81ed filename=3D"" mode=3D0x1ed
> =C2=A0
> The pointer is correct (it corresponds to kprobe event args), but derefer=
ence never happens
> =C2=A0=20
