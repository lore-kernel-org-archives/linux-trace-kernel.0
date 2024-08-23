Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B72741C69;
	Fri, 23 Aug 2024 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432034; cv=none; b=N3XIM2g9RMq4lMdP9153Jrn9TGfYBW2tXTJOZuoTJS/Cg61VVYjUhb9o+8Yx/QZ3sZ2XnkaZPP53zD4p2ygYGeaADy3tl6gXArGrPlGTnlW+614KoN+uSdzYzAt4Gs5wJEEW8pejGh2p/dGK3ER0v2y1gDAiylnRy1ekkbnJPvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432034; c=relaxed/simple;
	bh=yMArncYlB7nM88PEv2EqVNYAWznkEZrzbiNh8nkDNqE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qWCZJgQ359E23UhnCko5s0HLJqQqUHHQITj7yJng9BnXmOMtzmRQLu0Re+pjkuaOdIqO1PUbOkq+VhKbz/3oOAS6luHuylJNC3fl5qX3oGfa1APE0211t4iGxSwP5XcuELgiPqytLN/hQzIzYoH6thbl5jvs5tJ3XkJS0FZZmZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD404C32786;
	Fri, 23 Aug 2024 16:53:52 +0000 (UTC)
Date: Fri, 23 Aug 2024 12:54:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: tglozar@redhat.com
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 jkacur@redhat.com, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH] tracing/timerlat: Check tlat_var for NULL in
 timerlat_fd_release
Message-ID: <20240823125426.404f2705@gandalf.local.home>
In-Reply-To: <20240820130001.124768-1-tglozar@redhat.com>
References: <20240820130001.124768-1-tglozar@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Aug 2024 15:00:01 +0200
tglozar@redhat.com wrote:

> From: Tomas Glozar <tglozar@redhat.com>
>=20
> When running timerlat with a userspace workload (NO_OSNOISE_WORKLOAD),
> NULL pointer dereference can be triggered by sending consequent SIGINT
> and SIGTERM signals to the workload process. That then causes
> timerlat_fd_release to be called twice in a row, and the second time,
> hrtimer_cancel is called on a zeroed hrtimer struct, causing the NULL
> dereference.
>=20
> This can be reproduced using rtla:
> ```
> $ while true; do rtla timerlat top -u -q & PID=3D$!; sleep 5; \
>  kill -INT $PID; sleep 0.001; kill -TERM $PID; wait $PID; done
> [1] 1675
> [1]+  Aborted (SIGTERM)      rtla timerlat top -u -q
> [1] 1688
> client_loop: send disconnect: Broken pipe
> ```
> triggering the bug:
> ```
> BUG: kernel NULL pointer dereference, address: 0000000000000010
> Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 6 PID: 1679 Comm: timerlatu/6 Kdump: loaded Not tainted
> 6.10.0-rc2+ #1
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-1.fc39
> 04/01/2014
> RIP: 0010:hrtimer_active+0xd/0x50
> RSP: 0018:ffffa86641567cc0 EFLAGS: 00010286
> RAX: 000000000002e2c0 RBX: ffff994c6bf2e2c8 RCX: ffff994b0911ac18
> RDX: 0000000000000000 RSI: ffff994b02f10700 RDI: ffff994c6bf2e2c8
> RBP: ffff994c6bf2e340 R08: ffff994b158f7400 R09: ffff994b0911ac18
> R10: 0000000000000010 R11: ffff994b00d40f00 R12: ffff994c6bf2e2c8
> R13: ffff994b02049b20 R14: ffff994b011806c0 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff994c6bf00000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000010 CR3: 0000000139020006 CR4: 0000000000770ef0
> PKRU: 55555554
> Call Trace:
>   <TASK>
>   ? __die+0x24/0x70
>   ? page_fault_oops+0x75/0x170
>   ? mt_destroy_walk.isra.0+0x2b3/0x320
>   ? exc_page_fault+0x70/0x160
>   ? asm_exc_page_fault+0x26/0x30
>   ? hrtimer_active+0xd/0x50
>   hrtimer_cancel+0x15/0x40
>   timerlat_fd_release+0x48/0xe0
>   __fput+0xed/0x2c0
>   task_work_run+0x59/0x90
>   do_exit+0x275/0x4b0
>   do_group_exit+0x30/0x80
>   get_signal+0x917/0x960
>   ? vfs_read+0xb7/0x340
>   arch_do_signal_or_restart+0x29/0xf0
>   ? syscall_exit_to_user_mode+0x70/0x1f0
>   ? syscall_exit_work+0xf3/0x120
>   syscall_exit_to_user_mode+0x1a0/0x1f0
>   do_syscall_64+0x89/0x160
>   ? clear_bhb_loop+0x25/0x80
>   ? clear_bhb_loop+0x25/0x80
>   ? clear_bhb_loop+0x25/0x80
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   RIP: 0033:0x7f75790fd9ec
> ...
>   </TASK>
> ```
>=20
> Fix the NULL pointer dereference by checking tlat_var->kthread for zero
> first in timerlat_fd_release, before calling hrtimer_cancel.
> tlat_var->kthread is always non-zero unless the entire tlat_var is zero,
> since it is set to the TID of the userspace workload in timerlat_fd_open
> under a mutex.
>=20

So debugging this a bit more (with my persistent ring buffer!), I realize
this is just fixing a symptom and not the real issue (and I added my other
patch which fixes the kthread issue).

I added trace_printk() for every place the tlat->timer gets initialized,
started, canceled and memset to zero (via the memset() function). Those
looked like this:

	for_each_cpu(cpu, cpu_online_mask) {
		tlat_var =3D per_cpu_ptr(&per_cpu_timerlat_var, cpu);
		trace_printk("memset 0 %px\n", &tlat_var->timer);
		memset(tlat_var, 0, sizeof(*tlat_var));
	}

	trace_printk("start timer %px for %px\n", &tlat->timer, tlat->kthread);
	hrtimer_start(&tlat->timer, next_abs_period, HRTIMER_MODE_ABS_PINNED_HARD);

 etc.


And here's the result I found:

           <...>-909     [005] ....1    69.830509: timerlat_fd_release: can=
cel timer ffff88823c6b5b28 for ffff88810dae6780
           <...>-909     [005] ....1    69.830511: timerlat_fd_release: mem=
set 0 ffff88823c6b5b28
           <...>-902     [001] ....1    69.831296: timerlat_fd_release: can=
cel timer ffff88823c4b5b28 for ffff88810dae5640
           <...>-902     [001] ....1    69.831300: timerlat_fd_release: mem=
set 0 ffff88823c4b5b28
           <...>-901     [000] ....1    69.831319: timerlat_fd_release: can=
cel timer ffff88823c435b28 for ffff888110b8d640
           <...>-901     [000] ....1    69.831323: timerlat_fd_release: mem=
set 0 ffff88823c435b28
           <...>-905     [003] ....1    69.831371: timerlat_fd_release: can=
cel timer ffff88823c5b5b28 for ffff88810dae0000
           <...>-905     [003] ....1    69.831375: timerlat_fd_release: mem=
set 0 ffff88823c5b5b28
           <...>-904     [002] ....1    69.831390: timerlat_fd_release: can=
cel timer ffff88823c535b28 for ffff88810dae2280
           <...>-904     [002] ....1    69.831394: timerlat_fd_release: mem=
set 0 ffff88823c535b28
           <...>-907     [004] ....1    69.831442: timerlat_fd_release: can=
cel timer ffff88823c635b28 for ffff88810dae33c0
           <...>-907     [004] ....1    69.831446: timerlat_fd_release: mem=
set 0 ffff88823c635b28
           <...>-911     [007] ....1    69.832689: timerlat_fd_release: can=
cel timer ffff88823c7b5b28 for ffff88810dae1140
           <...>-911     [007] ....1    69.832693: timerlat_fd_release: mem=
set 0 ffff88823c7b5b28
           <...>-916     [005] .....    69.838927: osnoise_workload_start: =
memset 0 ffff88823c435b28
           <...>-916     [005] .....    69.838931: osnoise_workload_start: =
memset 0 ffff88823c4b5b28
           <...>-916     [005] .....    69.838932: osnoise_workload_start: =
memset 0 ffff88823c535b28
           <...>-916     [005] .....    69.838933: osnoise_workload_start: =
memset 0 ffff88823c5b5b28
           <...>-916     [005] .....    69.838934: osnoise_workload_start: =
memset 0 ffff88823c635b28
           <...>-916     [005] .....    69.838935: osnoise_workload_start: =
memset 0 ffff88823c6b5b28
           <...>-916     [005] .....    69.838936: osnoise_workload_start: =
memset 0 ffff88823c735b28
           <...>-916     [005] .....    69.838938: osnoise_workload_start: =
memset 0 ffff88823c7b5b28
           <...>-910     [006] ....1    69.841066: timerlat_fd_release: can=
cel timer ffff88823c735b28 for 0000000000000000
           <...>-910     [006] d...1    69.841134: console: Oops: general p=
rotection fault, probably for non-canonical address 0xdffffc0000000002: 000=
0 [#1] PREEMPT SMP KASAN PTI
           <...>-910     [006] d...1    69.844649: console: KASAN: null-ptr=
-deref in range [0x0000000000000010-0x0000000000000017]
           <...>-910     [006] d...1    69.846887: console: CPU: 6 UID: 0 P=
ID: 910 Comm: timerlatu/6 Not tainted 6.11.0-rc3-test-00027-g014f473a3416-d=
irty #128 70de8528c323e5e87113ad73b5320a6d112a9ae6
           <...>-910     [006] d...1    69.851008: console: Hardware name: =
QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
           <...>-910     [006] d...1    69.853750: console: RIP: 0010:hrtim=
er_active+0x58/0x300
           <...>-910     [006] d...1    69.855118: console: Code: 48 c1 ee =
03 41 54 48 01 d1 48 01 d6 55 53 48 83 ec 20 80 39 00 0f 85 30 02 00 00 49 =
8b 6f 30 4c 8d 75 10 4c 89 f0 48 c1 e8 03 <0f> b6 3c 10 4c 89 f0 83 e0 07 8=
3 c0 03 40 38 f8 7c 09 40 84 ff 0f
           <...>-910     [006] d...1    69.860562: console: RSP: 0018:ffff8=
8810c7a7718 EFLAGS: 00010202
           <...>-910     [006] d...1    69.860569: console:
           <...>-910     [006] d...1    69.862099: console: RAX: 0000000000=
000002 RBX: ffff88823c735b28 RCX: ffffed10478e6b6b
           <...>-910     [006] d...1    69.864181: console: RDX: dffffc0000=
000000 RSI: ffffed10478e6b6c RDI: ffff88823c735b28
           <...>-910     [006] d...1    69.866262: console: RBP: 0000000000=
000000 R08: ffff88823c735b58 R09: ffff88823c735b60
           <...>-910     [006] d...1    69.868359: console: R10: ffff88810d=
ae4fe7 R11: ffffed102027af0a R12: ffff88823c735b28
           <...>-910     [006] d...1    69.870459: console: R13: ffffffffa1=
4f8d8b R14: 0000000000000010 R15: ffff88823c735b28
           <...>-910     [006] d...1    69.872576: console: FS:  0000000000=
000000(0000) GS:ffff88823c700000(0000) knlGS:0000000000000000
           <...>-910     [006] d...1    69.874764: console: CS:  0010 DS: 0=
000 ES: 0000 CR0: 0000000080050033
           <...>-910     [006] d...1    69.876332: console: CR2: 00007fc741=
ad5f90 CR3: 00000001f729e006 CR4: 0000000000170ef0
           <...>-910     [006] d...1    69.878275: console: Call Trace:
           <...>-910     [006] d...1    69.878954: console:  <TASK>

The timer that crashed (and the other timers would eventually too) was
ffff88823c735b28, and just looking at that timer from the above:

           <...>-910     [006] ....1    69.827589: wait_next_period.isra.0:=
 start timer ffff88823c735b28 for ffff88810dae4500
           <...>-910     [006] ....1    69.828557: wait_next_period.isra.0:=
 start timer ffff88823c735b28 for ffff88810dae4500
           <...>-910     [006] ....1    69.829529: wait_next_period.isra.0:=
 start timer ffff88823c735b28 for ffff88810dae4500
           <...>-916     [005] .....    69.838936: osnoise_workload_start: =
memset 0 ffff88823c735b28
           <...>-910     [006] ....1    69.841066: timerlat_fd_release: can=
cel timer ffff88823c735b28 for 0000000000000000

It was the memset that cleared it and then calling hrtimer_cancel() on that
broke it. But notice something else here. The timer is never canceled!
That's a real bug.

This wasn't caused by the file descriptor closing twice and
timerlat_fd_release called again. There's no such thing otherwise there
would be lots of broken code in the kernel.

I added a trace_dump_stack():

	for_each_cpu(cpu, cpu_online_mask) {
		tlat_var =3D per_cpu_ptr(&per_cpu_timerlat_var, cpu);
		trace_printk("memset 0 %px\n", &tlat_var->timer);
		trace_dump_stack(0);
		memset(tlat_var, 0, sizeof(*tlat_var));
	}

And have this:

           <...>-924     [006] .....    42.574419: osnoise_workload_start: =
memset 0 ffff88823c7b5b28
           <...>-924     [006] .....    42.574423: <stack trace>
 =3D> __ftrace_trace_stack
 =3D> osnoise_workload_start
 =3D> timerlat_tracer_start
 =3D> rb_simple_write
 =3D> vfs_write
 =3D> ksys_write
 =3D> do_syscall_64
 =3D> entry_SYSCALL_64_after_hwframe
           <...>-913     [007] ....1    42.580553: timerlat_fd_release: can=
cel timer ffff88823c7b5b28 for 0000000000000000
           <...>-913     [007] d...1    42.580599: console: Oops: general p=
rotection fault, probably for non-canonical address 0xdffffc0000000002: 000=
0 [#1] PREEMPT SMP KASAN PTI


=46rom your test case:

> $ while true; do rtla timerlat top -u -q & PID=3D$!; sleep 5; \
>  kill -INT $PID; sleep 0.001; kill -TERM $PID; wait $PID; done

The "kill -INT $PID" caused the write to osnoise_workload_start(), and the
after 1ms you do the "kill -TERM $PID" that kill the process which closes
the file descriptor right after the reset.

The real fix here looks to be:

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 66a871553d4a..400a72cd6ab5 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -265,6 +265,8 @@ static inline void tlat_var_reset(void)
 	 */
 	for_each_cpu(cpu, cpu_online_mask) {
 		tlat_var =3D per_cpu_ptr(&per_cpu_timerlat_var, cpu);
+		if (tlat_var->kthread)
+			hrtimer_cancel(&tlat_var->timer);
 		memset(tlat_var, 0, sizeof(*tlat_var));
 	}
 }
@@ -2579,7 +2581,8 @@ static int timerlat_fd_release(struct inode *inode, s=
truct file *file)
 	osn_var =3D per_cpu_ptr(&per_cpu_osnoise_var, cpu);
 	tlat_var =3D per_cpu_ptr(&per_cpu_timerlat_var, cpu);
=20
-	hrtimer_cancel(&tlat_var->timer);
+	if (tlat_var->kthread)
+		hrtimer_cancel(&tlat_var->timer);
 	memset(tlat_var, 0, sizeof(*tlat_var));
=20
 	osn_var->sampling =3D 0;

I'll make this into a real patch and send it out.

-- Steve
