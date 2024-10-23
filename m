Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C9D145323;
	Wed, 23 Oct 2024 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675644; cv=none; b=ln8V5xk1f5KNuyhtrg7ud0ijrlthCY8cdxJXHGegrsp0NAz/LsVoQvDEXhzzacd7iPO3Jpt2fCHdXdyCe1FynisSzorMeiGIn9v29xSrI2AUu1GXWntyFugCHCa39ag88rVZXGGS76ZfJ2xbtJ2CZB9uIY/oYbU7uRU9G7PRiIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675644; c=relaxed/simple;
	bh=NRKFTqcKkOyFgqi22cM2rjhSz13skaSGpnm2/JRTwAM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EA2hHlqE3gPy1g0jOCqql/86cSEa5TEVwS4PkfP5dTMI5xYS7n8LBbpsBOcke2Mun02A1mVjZBy6Yd+em9XucGobwiZTfUCV6hSJxOWlPyQzc50RgBBQiCcQ9KtO4nL3jcwPMbTBBtu3PMyuvb5jNkF+UNOVd/HUqDTVWEE+ZgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080BDC4CECD;
	Wed, 23 Oct 2024 09:27:22 +0000 (UTC)
Date: Wed, 23 Oct 2024 05:27:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] m68k: Add tracirqs
Message-ID: <20241023052719.4c43b7af@rorschach.local.home>
In-Reply-To: <57719b35-5e7a-4c9e-b9a3-5017dec73803@yoseli.org>
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
	<20241021-add-m68k-tracing-support-v1-1-0883d704525b@yoseli.org>
	<4ab85330-5a50-bde1-f014-99a8e7cb28cc@gmail.com>
	<86eea4de-2696-4485-9c16-cd3fbbd1aae6@yoseli.org>
	<4e93964e-bafb-0474-743f-8280c46898f4@gmail.com>
	<57719b35-5e7a-4c9e-b9a3-5017dec73803@yoseli.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Oct 2024 10:59:42 +0200
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:

>=20
> Sadly, not that straightforward.
> I have this patch right now:
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index b2a3093af677..fc4a2d124514 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -41,6 +41,7 @@ config M68K
>          select ZONE_DMA
>          select ARCH_SUPPORTS_RT
>          select IRQ_FORCED_THREADING
> +       select TRACE_IRQFLAGS_SUPPORT
>=20
>   config CPU_BIG_ENDIAN
>          def_bool y
> diff --git a/arch/m68k/coldfire/entry.S b/arch/m68k/coldfire/entry.S
> index 4ea08336e2fb..fbdc4404f29e 100644
> --- a/arch/m68k/coldfire/entry.S
> +++ b/arch/m68k/coldfire/entry.S
> @@ -57,6 +57,9 @@ enosys:
>   ENTRY(system_call)
>          SAVE_ALL_SYS
>          move    #0x2000,%sr             /* enable intrs again */
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +       jbsr    trace_hardirqs_on
> +#endif

Note, the trace_hardirqs_on/off() needs to be done when interrupts are
disabled. That is:

	__local_irq_disable();
	trace_hardirqs_off();

	[..]

	trace_hardirqs_on();
	__local_irq_enable();

I don't know the m68k assembly, but from the comments it looks like you
are calling these with interrupts enabled.

-- Steve


>          GET_CURRENT(%d2)
>=20
>          cmpl    #NR_syscalls,%d0
> @@ -99,6 +102,9 @@ ENTRY(system_call)
>          addql   #4,%sp
>=20
>   ret_from_exception:
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +       jbsr    trace_hardirqs_off
> +#endif
>          move    #0x2700,%sr             /* disable intrs */
>          btst    #5,%sp@(PT_OFF_SR)      /* check if returning to kernel =
*/
>          jeq     Luser_return            /* if so, skip resched, signals =
*/
> @@ -140,6 +146,9 @@ Lreturn:
>   Lwork_to_do:
>          movel   %a0@(TINFO_FLAGS),%d1   /* get thread_info->flags */
>          move    #0x2000,%sr             /* enable intrs again */
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +       jbsr    trace_hardirqs_on
> +#endif
>          btst    #TIF_NEED_RESCHED,%d1
>          jne     reschedule
>=20
> But it fails when init is called:
> [    5.313000] Run /bin/bash as init process
> [    5.314000]   with arguments:
> [    5.315000]     /bin/bash
> [    5.316000]   with environment:
> [    5.317000]     HOME=3D/
> [    5.318000]     TERM=3Dlinux
> [    5.684000] Kernel panic - not syncing: Attempted to kill init!=20
> exitcode=3D0x0000000b
> [    5.684000] CPU: 0 UID: 0 PID: 1 Comm: bash Not tainted=20
> 6.12.0-rc4-00049-g4393ca34ead3 #364
> [    5.684000] Stack from 41a03e18:
> [    5.684000]         41a03e18 41540187 41540187 0000000a ffffffff=20
> 415a8fb4 4140dd90 41416588
> [    5.684000]         41540187 4140d5de 4102ba84 4100b19c 4100b1a8=20
> 00000000 41a38000 4102ba3a
> [    5.684000]         41a03ea0 4100c34a 4150e87e 0000000b 0000000b=20
> 41a03f80 0000000a 41a3c0d4
> [    5.684000]         41a02000 400004d8 41a08000 4102ba3a 4102ba84=20
> 00000000 00000000 000000ff
> [    5.684000]         00000000 00000000 41a03ef4 4100cb82 0000000b=20
> 0000000b 41a03f80 41a03f6c
> [    5.684000]         41016cd2 0000000b 41a03f6c 0000001d 00000026=20
> 0000048c ffffffff 00000006
> [    5.684000] Call Trace: [<4140dd90>] _printk+0x0/0x18
> [    5.684000]  [<41416588>] dump_stack+0xc/0x10
> [    5.684000]  [<4140d5de>] panic+0xf2/0x2d4
> [    5.684000]  [<4102ba84>] preempt_count_sub+0x0/0x2e
> [    5.684000]  [<4100b19c>] arch_local_irq_enable+0x0/0xc
> [    5.684000]  [<4100b1a8>] arch_irqs_disabled+0x0/0x10
> [    5.684000]  [<4102ba3a>] preempt_count_add+0x0/0x1e
> [    5.684000]  [<4100c34a>] do_exit+0x266/0x930
> [    5.684000]  [<4102ba3a>] preempt_count_add+0x0/0x1e
> [    5.684000]  [<4102ba84>] preempt_count_sub+0x0/0x2e
> [    5.684000]  [<4100cb82>] do_group_exit+0x26/0xba
> [    5.684000]  [<41016cd2>] get_signal+0x60e/0x76c
> [    5.684000]  [<410044e8>] test_ti_thread_flag+0x0/0x14
> [    5.684000]  [<4102ba94>] preempt_count_sub+0x10/0x2e
> [    5.684000]  [<41004b68>] do_notify_resume+0x3a/0x4c6
> [    5.684000]  [<41015d52>] force_sig_fault_to_task+0x32/0x3e
> [    5.684000]  [<41015d72>] force_sig_fault+0x14/0x1a
> [    5.684000]  [<41005606>] buserr_c+0x9a/0x188
> [    5.684000]  [<410065fc>] Lsignal_return+0x14/0x24
> [    5.684000]  [<410065de>] Lwork_to_do+0xe/0x18
> [    5.684000]
> [    5.684000] ---[ end Kernel panic - not syncing: Attempted to kill=20
> init! exitcode=3D0x0000000b ]---
>=20
>=20
> JM
>=20
> >> =20
> >>>
> >>> Registers %d0-%d5 and %a0-%a2 are saved on the stack at this point and
> >>> can be clobbered if need be. =20
> >>
> >> I don't know if they need to be clobbered... =20
> >=20
> > I meant to say that if you need registers to prepare function arguments=
=20
> > for trace_irqs_on/off() on the stack, these can be used. But that may=20
> > not be necessary in this case.
> >=20
> > Cheers,
> >=20
> >  =C2=A0=C2=A0=C2=A0=C2=A0Michael
> >=20
> >  =20
> >>
> >> Thanks,
> >> JM
> >> =20
> >>>
> >>> Cheers,
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 Michael
> >>>
> >>> =20
> >>>>
> >>>> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> >>>> ---
> >>>> =C2=A0arch/m68k/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> >>>> =C2=A0arch/m68k/kernel/irq.c | 2 ++
> >>>> =C2=A02 files changed, 3 insertions(+)
> >>>>
> >>>> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> >>>> index
> >>>> cc26df907bfe3c8143a931d259eceabb16af7411..ab3375475721fa63418c40d4ba=
6ac76679ebc77d
> >>>> 100644
> >>>> --- a/arch/m68k/Kconfig
> >>>> +++ b/arch/m68k/Kconfig
> >>>> @@ -39,6 +39,7 @@ config M68K
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0 select OLD_SIGSUSPEND3
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0 select UACCESS_MEMCPY if !MMU
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0 select ZONE_DMA
> >>>> +=C2=A0=C2=A0=C2=A0 select TRACE_IRQFLAGS_SUPPORT
> >>>>
> >>>> =C2=A0config CPU_BIG_ENDIAN
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0 def_bool y
> >>>> diff --git a/arch/m68k/kernel/irq.c b/arch/m68k/kernel/irq.c
> >>>> index
> >>>> 9ab4f550342e5de11c528f55781432675ffd66bf..74cf60ebbc4bca51f3caa4046d=
bd2bdb02355711
> >>>> 100644
> >>>> --- a/arch/m68k/kernel/irq.c
> >>>> +++ b/arch/m68k/kernel/irq.c
> >>>> @@ -21,9 +21,11 @@ asmlinkage void do_IRQ(int irq, struct pt_regs=20
> >>>> *regs)
> >>>> =C2=A0{
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0 struct pt_regs *oldregs =3D set_irq_regs(re=
gs);
> >>>>
> >>>> +=C2=A0=C2=A0=C2=A0 trace_hardirqs_off();
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0 irq_enter();
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0 generic_handle_irq(irq);
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0 irq_exit();
> >>>> +=C2=A0=C2=A0=C2=A0 trace_hardirqs_on();
> >>>>
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0 set_irq_regs(oldregs);
> >>>> =C2=A0}
> >>>> =20
> >> =20

