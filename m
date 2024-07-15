Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CB11CAB8;
	Mon, 15 Jul 2024 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067068; cv=none; b=OBZfLM4LRoWcsYWsMlbY2PJyKu54KSsgto2HY0LzO1apai0DzP2EWG692ZZk4IZfl9VinW0MT/KoupNaGVgX+6qnUIgu7Wkj+5QcM/Cq+fCpU+CxcIHGbYvblAYXt8dn1sITW8Jbe0cuwRvBwWKK3YlUyYLpVLXFOj66VrxDBkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067068; c=relaxed/simple;
	bh=eljeU3fZJUWSM+09oBz2u/5QnTCF3Mr/N/o7Gbciukg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XxavLiAA1XRboYD/MXXy+WogRAIM4yBkhsYFJyHz8ISxauWJ4FUcgzum8Iy523MpyoALq8ZmxwFz0SaBu+qRX3xXnygPnM0y9ToJS3F13RgV9ynCzOgbW23KdiqtlINue6Cl7kRoevBh6k4d42DWL0FGI/BPtLU1qifF/hV3F6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmO8ORWb; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmO8ORWb"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70b03ffbb3aso3670744b3a.0;
        Mon, 15 Jul 2024 11:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721067066; x=1721671866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzY1Vpi5uF4ekKIWAU0SyvXr8qfRfWh5GC9bl8BiCL8=;
        b=VmO8ORWbde9WPU45TasVENuoYXcOntx5nPpQ4Dz4Q1SVA4kRVHexgvuiW58/oR+peX
         Y7/8r4L5K390SxR5zq/S+JFBQ3n7Ly8O+7rH9XPa39Blgv046EM0XLgAuJRTq6TfWi1A
         xs0WtLm2uB42mruMcY5HFX+AqdjQeKx/0xCTRJmm46MiR21Dig6iTUTNBkbJQm4xdDee
         wKEO6ohjLcEgGDa26VFj6MDAdy/3M5RrD9zZe9RKC2Guk2syY5sv8CNEZW0l94bD6v03
         wlJkzZd+0kn/gW+efjJNvpd06bB4/fpiMhvZmZWjSGoa9s/JORtRJwnOCTPjH75UwBS/
         ACRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721067066; x=1721671866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzY1Vpi5uF4ekKIWAU0SyvXr8qfRfWh5GC9bl8BiCL8=;
        b=BjxYXyMKTkBf8F53nAKS+G6U9I3Zn5oKiPYqSTRIl8XSRLM1IftmdcJKIKc4miFv+N
         f8nzFB/8kedvWDF6ahMxAKak81LmjHu3IpaCNLty2zTqMFbLB9CKGoWAGukxfjHNYSjW
         mqWmT8taTneQ0ZpJpWszrkzBqXrjn11oL9HlMGpIb0b9aiuo3y/A9KyoNAJEQ7kgelDz
         ZVtn9wMX+Zau+znMdcxDjLMgxR9R9aMupy1R+0u8bVstVV/Nh+V1GcH/aJm/HWP2FZoS
         Y2WZzi4KLzPXv+12m4wDaepfnmaRTWiHJklLRF6pXWlemP3zHaSrQKXQbi0ycCjja9UP
         T6iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ7lAWeiBcZ6pj4mfYtkCmv570dLfOT5j3Cy6/a5pIZ2Pp+rsgjbKcNutafJGu/1CX347kdNOBubWfUMhWibo61Ypne44Ra4BJDLOKebwRWF7gA8RxM8TenuFplFBiFozspYPDqw2Ohm9qQkYO7xxm
X-Gm-Message-State: AOJu0Yw169OD9WWmp2f5MReS2VgzMa5FEKjpBdQxQ3rCXDjnxIOJxdTm
	BVSGUe48lgLWMe39VWBoAHSHzly10txIuHt6gvLopyfq6B6qi7FDwmEN9GYjsI9gr4ju8YwArgj
	w8/P32doJhPrmldBsq3wjoFrFvYY=
X-Google-Smtp-Source: AGHT+IFZ5liIboaD4HA36nEgVRFFP/sMkXD24strkFeep1mTu2CiPinFvCRxUWFJ9P8UVeYzBSOOhoyodSRgUjhaVJI=
X-Received: by 2002:a05:6a20:430f:b0:1c3:ea21:dc31 with SMTP id
 adf61e73a8af0-1c3ee5a7861mr942248637.42.1721067065812; Mon, 15 Jul 2024
 11:11:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711110235.098009979@infradead.org> <CAEf4BzZ+ygwfk8FKn5AS_Ny=igvGcFzdDLE2FjcvwjCKazEWMA@mail.gmail.com>
 <20240715144536.GI14400@noisy.programming.kicks-ass.net> <CAEf4BzZuR883FEuKAXp3DY1iJcL+ST8eNq5ioq8oRpDyg0w8Kw@mail.gmail.com>
In-Reply-To: <CAEf4BzZuR883FEuKAXp3DY1iJcL+ST8eNq5ioq8oRpDyg0w8Kw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 15 Jul 2024 11:10:53 -0700
Message-ID: <CAEf4BzY-r2EcQEVxA=kDUvx-wX3t0hsG+66=iKTS5ZaAJF4zjw@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] perf/uprobe: Optimize uprobes
To: Peter Zijlstra <peterz@infradead.org>
Cc: oleg@redhat.com, mingo@kernel.org, andrii@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org, clm@meta.com, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 10:10=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jul 15, 2024 at 7:45=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Thu, Jul 11, 2024 at 09:57:44PM -0700, Andrii Nakryiko wrote:
> >
> > > But then I also ran it on Linux built from perf/uprobes branch (these
> > > patches), and after a few seconds I see that there is no more
> > > attachment/detachment happening. Eventually I got splats, which you
> > > can see in [1]. I used `sudo ./uprobe-stress -a10 -t5 -m5 -f3` comman=
d
> > > to run it inside my QEMU image.
> >
> > So them git voodoo incantations did work and I got it built. I'm runnin=
g
> > that exact same line above (minus the sudo, because test box only has a
> > root account I think) on real hardware.
> >
> > I'm now ~100 periods in and wondering what 'eventually' means...
>
> So I was running in a qemu set up with 16 cores on top of bare metal's
> 80 core CPU (Intel(R) Xeon(R) Gold 6138 CPU @ 2.00GHz). I just tried
> it again, and I can reproduce it within first few periods:
>
> WORKING HARD!..
>
> PERIOD #1 STATS:
> FUNC CALLS               919632
> UPROBE HITS              706351
> URETPROBE HITS           641679
> ATTACHED LINKS              951
> ATTACHED UPROBES           2421
> ATTACHED URETPROBES        2343
> MMAP CALLS                33533
> FORKS CALLS                 241
>
> PERIOD #2 STATS:
> FUNC CALLS                11444
> UPROBE HITS               14320
> URETPROBE HITS             9896
> ATTACHED LINKS               26
> ATTACHED UPROBES             75
> ATTACHED URETPROBES          61
> MMAP CALLS                39093
> FORKS CALLS                  14
>
> PERIOD #3 STATS:
> FUNC CALLS                  230
> UPROBE HITS                 152
> URETPROBE HITS              145
> ATTACHED LINKS                2
> ATTACHED UPROBES              2
> ATTACHED URETPROBES           2
> MMAP CALLS                39121
> FORKS CALLS                   0
>
> PERIOD #4 STATS:
> FUNC CALLS                    0
> UPROBE HITS                   0
> URETPROBE HITS                0
> ATTACHED LINKS                0
> ATTACHED UPROBES              0
> ATTACHED URETPROBES           0
> MMAP CALLS                39010
> FORKS CALLS                   0
>
> You can see in the second period all the numbers drop and by period #4
> (which is about 20 seconds in) anything but mmap()ing stops. When I
> said "eventually" I meant about a minute tops, however long it takes
> to do soft lockup detection, 23 seconds this time.
>
> So it should be very fast.
>
> Note that I'm running with debug kernel configuration (see [0] for
> full kernel config), here are debug-related settings, in case that
> makes a difference:
>
> $ cat ~/linux-build/default/.config | rg -i debug | rg -v '^#'
> CONFIG_X86_DEBUGCTLMSR=3Dy
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
> CONFIG_BLK_DEBUG_FS=3Dy
> CONFIG_PNP_DEBUG_MESSAGES=3Dy
> CONFIG_AIC7XXX_DEBUG_MASK=3D0
> CONFIG_AIC79XX_DEBUG_MASK=3D0
> CONFIG_SCSI_MVSAS_DEBUG=3Dy
> CONFIG_DM_DEBUG=3Dy
> CONFIG_MLX4_DEBUG=3Dy
> CONFIG_USB_SERIAL_DEBUG=3Dm
> CONFIG_INFINIBAND_MTHCA_DEBUG=3Dy
> CONFIG_INFINIBAND_IPOIB_DEBUG=3Dy
> CONFIG_INFINIBAND_IPOIB_DEBUG_DATA=3Dy
> CONFIG_CIFS_DEBUG=3Dy
> CONFIG_DLM_DEBUG=3Dy
> CONFIG_DEBUG_BUGVERBOSE=3Dy
> CONFIG_DEBUG_KERNEL=3Dy
> CONFIG_DEBUG_INFO=3Dy
> CONFIG_DEBUG_INFO_DWARF4=3Dy
> CONFIG_DEBUG_INFO_COMPRESSED_NONE=3Dy
> CONFIG_DEBUG_INFO_BTF=3Dy
> CONFIG_DEBUG_INFO_BTF_MODULES=3Dy
> CONFIG_DEBUG_FS=3Dy
> CONFIG_DEBUG_FS_ALLOW_ALL=3Dy
> CONFIG_ARCH_HAS_DEBUG_WX=3Dy
> CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
> CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=3Dy
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=3Dy
> CONFIG_SCHED_DEBUG=3Dy
> CONFIG_DEBUG_PREEMPT=3Dy
> CONFIG_LOCK_DEBUGGING_SUPPORT=3Dy
> CONFIG_DEBUG_RT_MUTEXES=3Dy
> CONFIG_DEBUG_SPINLOCK=3Dy
> CONFIG_DEBUG_MUTEXES=3Dy
> CONFIG_DEBUG_WW_MUTEX_SLOWPATH=3Dy
> CONFIG_DEBUG_RWSEMS=3Dy
> CONFIG_DEBUG_LOCK_ALLOC=3Dy
> CONFIG_DEBUG_LOCKDEP=3Dy
> CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
> CONFIG_DEBUG_IRQFLAGS=3Dy
> CONFIG_X86_DEBUG_FPU=3Dy
> CONFIG_FAULT_INJECTION_DEBUG_FS=3Dy
>
>   [0] https://gist.github.com/anakryiko/97a023a95b30fb0fe607ff743433e64b
>
> >
> > Also, this is a 2 socket, 10 core per socket, 2 threads per core
> > ivybridge thing, are those parameters sufficient?
>
> Should be, I guess? It might be VM vs bare metal differences, though.
> I'll try to run this on bare metal with more production-like kernel
> configuration to see if I can still trigger this. Will let you know
> the results when I get them.

Ok, so I ran it on bare metal host with production config. I didn't
really bother to specify parameters (so just one thread for
everything, the default):

# ./uprobe-stress
WORKING HARD!..

PERIOD #1 STATS:
FUNC CALLS              2959843
UPROBE HITS             1001312
URETPROBE HITS                0
ATTACHED LINKS                6
ATTACHED UPROBES             28
ATTACHED URETPROBES           0
MMAP CALLS                 8143
FORKS CALLS                 301

PERIOD #2 STATS:
FUNC CALLS                    0
UPROBE HITS              822826
URETPROBE HITS                0
ATTACHED LINKS                0
ATTACHED UPROBES              0
ATTACHED URETPROBES           0
MMAP CALLS                 8006
FORKS CALLS                 270

PERIOD #3 STATS:
FUNC CALLS                    0
UPROBE HITS              889534
URETPROBE HITS                0
ATTACHED LINKS                0
ATTACHED UPROBES              0
ATTACHED URETPROBES           0
MMAP CALLS                 8004
FORKS CALLS                 288

PERIOD #4 STATS:
FUNC CALLS                    0
UPROBE HITS              886506
URETPROBE HITS                0
ATTACHED LINKS                0
ATTACHED UPROBES              0
ATTACHED URETPROBES           0
MMAP CALLS                 8120
FORKS CALLS                 285

PERIOD #5 STATS:
FUNC CALLS                    0
UPROBE HITS              804556
URETPROBE HITS                0
ATTACHED LINKS                0
ATTACHED UPROBES              0
ATTACHED URETPROBES           0
MMAP CALLS                 7131
FORKS CALLS                 263
^C
EXITING...

Message from syslogd@kerneltest003.10.atn6.facebook.com at Jul 15 11:06:33 =
...
 kernel:[ 2194.334618] watchdog: BUG: soft lockup - CPU#71 stuck for
48s! [uprobe-stress:69900]

It was weird on the very first period (no uretprobes, small amount of
attachments). And sure enough (gmail will reformat below in the
garbage, so [0] has the splat with the original formatting).

  [0] https://gist.github.com/anakryiko/3e3ddcccc5ea3ca70ce90b5491485fdc

I also keep getting:

Message from syslogd@kerneltest003.10.atn6.facebook.com at Jul 15 11:09:41 =
...
 kernel:[ 2382.334088] watchdog: BUG: soft lockup - CPU#71 stuck for
223s! [uprobe-stress:69900]

so it's not just a temporary slowdown


[ 2166.893057] rcu: INFO: rcu_sched self-detected stall on CPU
[ 2166.904199] rcu:     71-....: (20999 ticks this GP)
idle=3D2c84/1/0x4000000000000000 softirq=3D30158/30158 fqs=3D8110
[ 2166.923810] rcu:              hardirqs   softirqs   csw/system
[ 2166.934939] rcu:      number:        0        183            0
[ 2166.946064] rcu:     cputime:       60          0        10438
=3D=3D> 10549(ms)
[ 2166.959969] rcu:     (t=3D21065 jiffies g=3D369217 q=3D207850 ncpus=3D80=
)
[ 2166.971619] CPU: 71 PID: 69900 Comm: uprobe-stress Tainted: G S
     E      6.10.0-rc7-00071-g9423ae8ef6ff #62
[ 2166.992275] Hardware name: Quanta Tioga Pass Single Side
01-0032211004/Tioga Pass Single Side, BIOS F08_3A24 05/13/2020
[ 2167.013804] RIP: 0010:uprobe_notify_resume+0x622/0xe20
[ 2167.024064] Code: 8d 9d c0 00 00 00 48 89 df 4c 89 e6 e8 d7 f9 ff
ff 84 c0 0f 85 c6 06 00 00 48 89 5c 24 20 41 8b 6d 58 40 f6 c5 01 74
23 f3 90 <eb> f2 83 7c 24 18 00 48 8b 44 24 10 0f 8e 71 01 00 00 bf 05
00 00
[ 2167.061543] RSP: 0000:ffffc9004a49fe78 EFLAGS: 00000202
[ 2167.071973] RAX: 0000000000000000 RBX: ffff88a11d307fc0 RCX: ffff88a1207=
52c40
[ 2167.086223] RDX: 00000000000042ec RSI: ffffc9004a49ff58 RDI: ffff88a11d3=
07fc0
[ 2167.100472] RBP: 0000000000000003 R08: ffff88a12516e500 R09: ffff88a1251=
6f208
[ 2167.114717] R10: 00000000004042ec R11: 000000000000000f R12: ffffc9004a4=
9ff58
[ 2167.128967] R13: ffff88a11d307f00 R14: 00000000004042ec R15: ffff88a0904=
2e000
[ 2167.143213] FS:  00007fd252000640(0000) GS:ffff88bfffbc0000(0000)
knlGS:0000000000000000
[ 2167.159368] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2167.170843] CR2: 00007fd244000b60 CR3: 000000209090b001 CR4: 00000000007=
706f0
[ 2167.185091] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 2167.199340] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 2167.213586] PKRU: 55555554
[ 2167.218994] Call Trace:
[ 2167.223883]  <IRQ>
[ 2167.227905]  ? rcu_dump_cpu_stacks+0x77/0xd0
[ 2167.236433]  ? print_cpu_stall+0x150/0x2a0
[ 2167.244615]  ? rcu_sched_clock_irq+0x319/0x490
[ 2167.253487]  ? update_process_times+0x71/0xa0
[ 2167.262191]  ? tick_nohz_handler+0xc0/0x100
[ 2167.270544]  ? tick_setup_sched_timer+0x170/0x170
[ 2167.279937]  ? __hrtimer_run_queues+0xe3/0x250
[ 2167.288815]  ? hrtimer_interrupt+0xf0/0x390
[ 2167.297168]  ? __sysvec_apic_timer_interrupt+0x47/0x110
[ 2167.307602]  ? sysvec_apic_timer_interrupt+0x68/0x80
[ 2167.317519]  </IRQ>
[ 2167.321710]  <TASK>
[ 2167.325905]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
[ 2167.336517]  ? uprobe_notify_resume+0x622/0xe20
[ 2167.345565]  ? uprobe_notify_resume+0x609/0xe20
[ 2167.354612]  ? __se_sys_futex+0xf3/0x180
[ 2167.362445]  ? arch_uprobe_exception_notify+0x29/0x40
[ 2167.372533]  ? notify_die+0x51/0xb0
[ 2167.379503]  irqentry_exit_to_user_mode+0x7f/0xd0
[ 2167.388896]  asm_exc_int3+0x35/0x40
[ 2167.395862] RIP: 0033:0x4042ec
[ 2167.401966] Code: fc 8b 45 fc 89 c7 e8 6f 07 00 00 83 c0 01 c9 c3
cc 48 89 e5 48 83 ec 10 89 7d fc 8b 45 fc 89 c7 e8 55 07 00 00 83 c0
01 c9 c3 <cc> 48 89 e5 48 83 ec 10 89 7d fc 8b 45 fc 89 c7 e8 3b 07 00
00 83
[ 2167.439439] RSP: 002b:00007fd251fff8a8 EFLAGS: 00000206
[ 2167.449874] RAX: 00000000004042ec RBX: 00007fd252000640 RCX: 00000000000=
0001c
[ 2167.464122] RDX: 0000000000000033 RSI: 0000000000000064 RDI: 00000000000=
00033
[ 2167.478368] RBP: 00007fd251fff8d0 R08: 00007fd2523fa234 R09: 00007fd2523=
fa280
[ 2167.492617] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd2520=
00640
[ 2167.506866] R13: 0000000000000016 R14: 00007fd252289930 R15: 00000000000=
00000
[ 2167.521117]  </TASK>
