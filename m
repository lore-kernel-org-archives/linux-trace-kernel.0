Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793760568;
	b=RWAFKR22ECHHsPavJCb/Wrzw4/xuPQ9CkVAlnclP0cpSTSP0h01rxGmwUVz//4A1/aeg
	 wGsnhIq97Mz4PMKgdOkZOAg+iWw+1o9PBGod78ylGc6Ce38qRnPrqg9Iq1X9/gxnDPmNj
	 EhLMrZfAmsPcNrp4slgqyzXOPkgWf58087H7DMKNL1Q6xVv+WtKdPRwiNtVl3T9SENjFx
	 C9R9j4cZPAZ5LjeqTrBZ+qtp53Dek+xd8VrNwQfl7VjgSHubY+BVCCvHCtqwxdth8CFdP
	 Azvwbof/WTINaTuQpGWyKnT/tOgmL2+neMoMLe/PpfNmws48Dq+DyrHRDnJMmrr7Nkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760568;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gCnK9nPza4/U9D5181xx3aS1Ic2EmU8/Mpw9QU8kxuw=;
	b=p1DbniFAXHs9EHwv83dx+2jk58WO06ys2Uw9vZ/hhwtiKb3qxkmLHxEMkyl8tTn4pYUk
	 QESYqfxB47tAC4OZiRmAvXOwJITFbC58/62ClDdAAD4T509Fzx6vipzF8W9Qzf4wz74r1
	 v69LzTYNISq1HGpX6O7yr1SkchjFXVywIoOQLGg4kHL1uak3wKDNgZJ80di8ehDxW9ANW
	 GMvBpK9tMrraNWLuKyaBuDXrkpjQ2fmpfcIZHFBOLKb6VummNtR5ZxLf8y6D+j5HKFz/f
	 hAs8Fs20JHQ5vcW5JFBxbEfQgNn4fDM4titV00n1O3J82U9BzJrukwqeNLSL3Dy5d8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBZMDRxa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCA9606A31B;
	Wed,  4 Nov 2026 02:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBZMDRxa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C8B1F00A16;
	Wed,  4 Nov 2026 02:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760568;
	bh=gCnK9nPza4/U9D5181xx3aS1Ic2EmU8/Mpw9QU8kxuw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hBZMDRxawxfwtuUu0zvh5nNEiW+wegAHtHfUY1dwxHZ5FHfQ3sN8S8Sd9D90J16sx
	 CBObomvaMLSzpvaKKvg7JNHgsOWiPD5fjKQKYK3Yf0ynAHKWAvulVJH6JAkqfVEOZm
	 nwWnVy3oxHyKKijx8wPc4rBxmD3uoqFsHj3RtnWEyBWFuDSZC7rdgWivmTIbqQGzJ0
	 Ppg3LIzjWjpR7t1t6ZlMRhmCeoapXToNEvmu+e1tAZiWGJpYB5pNwYSCDW3Ot7IotA
	 sdagfYANU6XEJVbOlxi5jwqmkAAaKtIv+L4V8ejbiiZBkoH+fDGGUqDDAs9j0SPn9M
	 21w3ChMe9Mb9w==
Message-ID: <sashiko-outbox-196528@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 5/5] panic, crash_core, sys_info: Introduce
 crash_kexec_in_memory_sys_info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>, pmladek@suse.com, john.ogness@linutronix.de, rostedt@goodmis.org, senozhatsky@chromium.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, surenb@google.com, mhocko@suse.com, kees@kernel.org, anna-maria@linutronix.de, frederic@kernel.org, tglx@kernel.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, brendan.jackman@linux.dev, hannes@cmpxchg.org, ziy@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261103024453.922373-6-atomlin@atomlin.com>
References: <20261103024453.922373-1-atomlin@atomlin.com>
 <20261103024453.922373-6-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:49:25 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] crash_core: unconditional printk state reset in __crash_kexec() =
on failure
- [Medium] panic: permanent printk_panic_seq pin when die() or oops_end() r=
eturns
- [Medium] panic: race in printk_clear_panic_start() unpins active Oops or =
warning
--

commit be914e098a723f2f6a11c63bee2fe8d772bb6b45
Author: Aaron Tomlin <atomlin@atomlin.com>

panic, crash_core, sys_info: Introduce crash_kexec_in_memory_sys_info

This commit introduces the crash_kexec_in_memory_sys_info boot parameter to
collect sys_info() telemetry into the in-memory printk ring buffer before
jumping to the kdump kernel, while suppressing console flushing and pinning
the ring buffer tail at the start of the initial crash message.

> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 2b36aa9fade06..27b73b2da3e5a 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -140,9 +140,15 @@ void __noclone __crash_kexec(struct pt_regs *regs)
> =20
>  			crash_setup_regs(&fixed_regs, regs);
>  			crash_save_vmcoreinfo();
> +			if (!crash_kexec_post_notifiers)
> +				panic_in_memory_sys_info();
>  			machine_crash_shutdown(&fixed_regs);
>  			crash_cma_clear_pending_dma();
>  			machine_kexec(kexec_crash_image);
> +			if (!crash_kexec_post_notifiers) {
> +				printk_freeze_tail(false);
> +				printk_suppress_console_flush(false);
> +			}

[Severity: Medium]
In __crash_kexec(), panic_in_memory_sys_info() only calls
printk_suppress_console_flush(true) and printk_freeze_tail(true) when
crash_kexec_in_memory_sys_info is enabled:

kernel/panic.c:panic_in_memory_sys_info()
    if (!crash_kexec_in_memory_sys_info || panic_sys_info_dumped)
        return;
    ...
    printk_suppress_console_flush(true);
    printk_freeze_tail(true);

However, if machine_kexec(kexec_crash_image) fails and returns while
crash_kexec_in_memory_sys_info is disabled (the default), __crash_kexec()
still unconditionally runs printk_freeze_tail(false) and
printk_suppress_console_flush(false).

Calling printk_freeze_tail(false) resets printk_panic_seq to U64_MAX,
discarding the initial Oops start sequence recorded by oops_enter() or
bust_spinlocks(1), and calling printk_suppress_console_flush(false) invokes
printk_trigger_flush() and wake_up_klogd() (queuing irq_work after
machine_crash_shutdown() has already disabled interrupts and APICs) even
though console flushing was never suppressed.

Should the cleanup after machine_kexec() only run when
panic_in_memory_sys_info() actually enabled tail freezing and console flush
suppression?

> diff --git a/kernel/exit.c b/kernel/exit.c
> index 282328d2b4cf8..25facaf6c6f2c 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
[ ... ]
> @@ -1075,6 +1077,14 @@ void __noreturn make_task_dead(int signr)
>  	if (atomic_inc_return(&oops_count) >=3D limit && limit)
>  		panic("Oopsed too often (kernel.oops_limit is %d)", limit);
> =20
> +	while (tsk->in_oops)
> +		bust_spinlocks(0);
> +
> +	if (!READ_ONCE(oops_in_progress) && !panic_in_progress() &&
> +	    ((tsk->flags & PF_EXITING) || !is_global_init(tsk) ||
> +	     atomic_read(&tsk->signal->live) > 1))
> +		printk_clear_panic_start();

[Severity: Medium]
On entry to an Oops, oops_enter() in kernel/panic.c and bust_spinlocks(1) in
lib/bust_spinlocks.c invoke printk_mark_panic_start(), which pins
printk_panic_seq. Neither bust_spinlocks(0) nor oops_exit() clears
printk_panic_seq; for Oops paths, printk_clear_panic_start() is only called
here in make_task_dead().

Across several architectures, when notify_die(DIE_OOPS, ...) returns
NOTIFY_STOP (for example via a registered die notifier such as KGDB/KDB or
kprobes), the trap handler finishes bust_spinlocks(0) and oops_exit() and
returns without calling make_task_dead() or panic():

arch/x86/kernel/dumpstack.c:oops_end()
    bust_spinlocks(0);
    ...
    oops_exit();
    ...
    if (!signr)
        return;

arch/arm64/kernel/traps.c:die()
    bust_spinlocks(0);
    oops_exit();
    ...
    if (ret !=3D NOTIFY_STOP)
        make_task_dead(SIGSEGV);

(And similarly in arch/arm/kernel/traps.c:oops_end(),
arch/riscv/kernel/traps.c:die(), and arch/powerpc/kernel/traps.c:oops_end(),
while arch/loongarch/kernel/traps.c:die() and
arch/hexagon/kernel/traps.c:die() return early on NOTIFY_STOP after
bust_spinlocks(1) without calling bust_spinlocks(0), leaving current->in_oo=
ps
and oops_in_progress incremented as well.)

When die() or oops_end() returns without reaching make_task_dead(), won't
printk_panic_seq remain permanently pinned? Once normal printk activity wra=
ps
the ring buffer past that stale sequence number ((u64)panic_seq < first_seq=
),
a subsequent panic will clamp printk_panic_seq to first_seq at the current
ring buffer tail in printk_mark_panic_start(), leaving zero recyclable space
and causing panic_in_memory_sys_info() to drop all sys_info() output.

> diff --git a/kernel/panic.c b/kernel/panic.c
> index cda5d954b61f3..01175badaba10 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
[ ... ]
> @@ -1067,6 +1096,8 @@ void oops_enter(void)
>  	/* can't trust the integrity of the kernel anymore: */
>  	debug_locks_off();
>  	do_oops_enter_exit();
> +	if (!panic_in_progress())
> +		printk_mark_panic_start();
> =20
>  	if (sysctl_oops_all_cpu_backtrace)
>  		trigger_all_cpu_backtrace();
> @@ -1097,10 +1128,16 @@ struct warn_args {
>  void __warn(const char *file, int line, void *caller, unsigned taint,
>  	    struct pt_regs *regs, struct warn_args *args)
>  {
> +	bool clear_panic_start =3D false;
> +
>  	nbcon_cpu_emergency_enter();
> =20
>  	disable_trace_on_warning();
> =20
> +	if (!READ_ONCE(oops_in_progress) && !panic_in_progress() &&
> +	    printk_mark_panic_start())
> +		clear_panic_start =3D true;
[ ... ]
> @@ -1137,6 +1174,9 @@ void __warn(const char *file, int line, void *calle=
r, unsigned taint,
>  	/* Just a warning, don't kill lockdep. */
>  	add_taint(taint, LOCKDEP_STILL_OK);
> =20
> +	if (clear_panic_start && !READ_ONCE(oops_in_progress) && !panic_in_prog=
ress())
> +		printk_clear_panic_start();

[Severity: Medium]
Can a finishing non-fatal warning in __warn(), warn_slowpath_fmt(), or
__report_bug() (or a task exiting in make_task_dead()) on one CPU race with=
 a
fatal Oops or fatal warning on another CPU and unpin printk_panic_seq?

Specifically, oops_in_progress is 0 and panic_in_progress() is false on CPU=
 B
during three windows before vpanic() sets panic_cpu:

1. In oops_begin() / die(), oops_enter() calls printk_mark_panic_start()
   before bust_spinlocks(1) increments oops_in_progress.

2. In oops_end() / die(), bust_spinlocks(0) decrements oops_in_progress back
   to 0 before oops_exit() and before panic() is called for in_interrupt() =
or
   panic_on_oops:

   arch/x86/kernel/dumpstack.c:oops_end()
       bust_spinlocks(0);
       ...
       oops_exit();
       __show_regs(&exec_summary_regs, SHOW_REGS_ALL, KERN_DEFAULT);
       if (!signr)
           return;
       if (in_interrupt())
           panic("Fatal exception in interrupt");
       if (panic_on_oops)
           panic("Fatal exception");

3. During a fatal warning (when panic_on_warn, warn_limit, or panic_on_taint
   is set), printk_mark_panic_start() is called while oops_in_progress is 0
   and before check_panic_on_warn() or add_taint() enters panic().

If CPU A finishes a non-fatal warning (having set clear_panic_start =3D true
just before CPU B started, or while CPU B is in a fatal warning) or runs
make_task_dead() (which does not check whether current pinned
printk_panic_seq) during any of those windows on CPU B, CPU A sees
!READ_ONCE(oops_in_progress) && !panic_in_progress() and calls
printk_clear_panic_start(). When CPU B then enters vpanic(),
printk_mark_panic_start() re-pins printk_panic_seq at the panic banner after
CPU B's Oops or warning output has already been emitted, allowing
panic_in_memory_sys_info() to overwrite the primary crash context.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103024453.9223=
73-1-atomlin@atomlin.com?part=3D5
