Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC9E304BD4
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Oct 2025 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759398885; cv=none; b=eC2CICF8UrGklIMIwUVGx2tXS+x48qngUhRiR6kT6Gx8xNOKRp0xm6JK0lIXKMYV4D7Fy1tduMsI6u1JQDZ/GkbEZ7B5AoXHI7LXGDrmVGHD3ZHwjsg19vUH7rcTBHI2nGovMdvt94jw9oJylF7wHeDo0KljNuEMjOLP+0+ZOZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759398885; c=relaxed/simple;
	bh=ZiGd17BD0jk48QLs8gOUdH7sbUs8jC5f8SddZMaW5tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=izOeNurGdwrkL6WxnwzIUiZF5sAesF9vqt++d9PTWNpLbaUxrQvmcHS4dKoJL2JGbcvMfxmJNiU/sJcXXUKtHgmwu3d/nuJcH+ZMR7HM7VM6+l87IECP0IMWH7l+EixtfIW0vT3mDrt9Mk7osL5qdF/h4bobfXAxnr/VYTt2liM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktvY1Ef/; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktvY1Ef/"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-73f20120601so11301367b3.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759398883; x=1760003683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5+3tj28FwU3R5WxCj5Lw0eQ4h17MiwRJxY9Z1MV/KE=;
        b=ktvY1Ef/u+3QZoCoXL6/n2Mud39lXtL1zt95VSHzPhacjLpP3bSq1OhAh6wPg+4I5R
         beFoklTQLMUId3swu6Sp4fPqjZyacSytJCkxRIhArjQN2YI9pxUlXCGfM87bpBPeOPKh
         LNq/YTu7/evkCSUauUk9PfT9OFgJEPmjMGHqmrmsG2lRNGmZJlW1Rs6WJoP4+IlQAz8/
         gtqR42AvQtvW8JNt5MtQc3gQXbQKrwYN6Ztt0w8OQs3PQE+dTQypwidjfhl9VuDLdMkq
         VBOACdvREUPMdjZuQ0nL5qwuQgtEwbRgxbD3zN2Xtwbkrh7EBPGR3RoGtYtNBr6sXiPr
         G+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759398883; x=1760003683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5+3tj28FwU3R5WxCj5Lw0eQ4h17MiwRJxY9Z1MV/KE=;
        b=dgXDg1saAkbZrVFlk7bw4V0nBvdbHBXziLcJ7qxgBkyLkGl53D96zDTRnROjwTGZAj
         jUk0CQ73mVteYGdJFGDYc73XY1yAYXcdycXfJ7gGGAyDp/cH1NOvqd4nH08OEK2/AfqB
         WoJUVHGIDogm67/y0+fYsqhzm6cjSz41PH92u5c1Iq8vMEoAfYCJ6IFDyruztBMLCZqa
         xWvSjgki/T8ryy6tlMgDC7WfczwJvBqV8QazwI1Ra8zksPs1uC5tK6DvbLyKQfrbM4OO
         djFUN06UqlQfe59tkizloaHi0SPX4A9per37RQQbJer2NCZ4GTSZghCXxH/dyTnuPqvr
         KRZg==
X-Forwarded-Encrypted: i=1; AJvYcCVEfg94Cm/HecMuIPa1ZS3EYjUupTXip5Dr/qxn3O+Ok3FlbBputtzH4GBpKODl7ve7/7tr8DVqvw5OoKjKrnL8GQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB0ltzr7goE8p2UCc+oTHQIpROMSsKARNs2Rb0YLuG0l7uUt47
	sgZLgAOjeoSw7K41bAuTA07TNtoQtnE3VSqjXDej1HYl+1UBerMWgtjg8WRfNrtVtHQulbbrz46
	smZMqgTnfLB+TryLIjdxnY88062Y8G3Q=
X-Gm-Gg: ASbGncvOgC1ntwyF0r/F7txQfpFJKtJ0R8x5WGSFR20/lHOAfv0UERkPWCeDQhzj37e
	7E1J9NZA9Fda057O6YyCDep7uWMR4R6dR4kRTx6Z/o5Gx9SN2+32dRuM+SNgPyxLbyl7m3iN0OO
	AYSRejaA9MVfjwsRlB6zrTFAZMYH0eW8k08ch3Fzm5MvFyUVbh1skLUcE/xNfWVMFhQF62CBgVm
	X0N8KzrNKQn59x5MGCYRfsrlrMAHdI=
X-Google-Smtp-Source: AGHT+IGxPk7Kjn3zT1jeK6l7hZl3tkjORlMwec0yDuqOyrWI6C75psHQQcgtmE4rtAq+Hg1ktr8W03ZRk1QG7nfAigw=
X-Received: by 2002:a53:b5c8:0:b0:635:4ed0:5712 with SMTP id
 956f58d0204a3-63b6ff64655mr7099003d50.44.1759398882441; Thu, 02 Oct 2025
 02:54:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202509301440.be4b3631-lkp@intel.com> <20251002142515.ebfcc03ba5490d0d63bec05e@kernel.org>
In-Reply-To: <20251002142515.ebfcc03ba5490d0d63bec05e@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 2 Oct 2025 17:54:31 +0800
X-Gm-Features: AS18NWCuTeAyEUstA_xt0kSn6CtQapPcvVZKf5tPow7Cnd0U2AWgXWZWfv_e8V0
Message-ID: <CADxym3by66hU1eQFsk75aAxNghimCc-NP0iZNJJ1b_FUtLu5Dg@mail.gmail.com>
Subject: Re: [linux-next:master] [tracing] e5a4cc28a0: BUG:spinlock_bad_magic_on_CPU
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Menglong Dong <dongml2@chinatelecom.cn>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 1:25=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Tue, 30 Sep 2025 14:48:27 +0800
> kernel test robot <oliver.sang@intel.com> wrote:
>
> >
> >
> > Hello,
> >
> > kernel test robot noticed "BUG:spinlock_bad_magic_on_CPU" on:
> >
> > commit: e5a4cc28a052369b6e56b0a9ac05d9b9d5607b06 ("tracing: fprobe: use=
 rhltable for fprobe_ip_table")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >
> > in testcase: boot
> >
> > config: x86_64-randconfig-072-20250929
> > compiler: gcc-14
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m=
 16G
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202509301440.be4b3631-lkp@inte=
l.com
> >
> >
> > [   30.894986][   T66] BUG: spinlock bad magic on CPU#0, modprobe/66
> > [ 30.896030][ T66] lock: fprobe_ip_table+0x110/0x180, .magic: 00000000,=
 .owner: <none>/-1, .owner_cpu: 0
> > [   30.898263][   T66] CPU: 0 UID: 0 PID: 66 Comm: modprobe Not tainted=
 6.17.0-rc6-00004-ge5a4cc28a052 #1 NONE  5e106928d64815a8c70ffa200d16301537=
e1528f
> > [   30.898799][   T66] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > [   30.898799][   T66] Call Trace:
> > [   30.898799][   T66]  <TASK>
> > [ 30.898799][ T66] show_stack (arch/x86/kernel/dumpstack.c:319)
> > [ 30.898799][ T66] dump_stack_lvl (lib/dump_stack.c:122)
> > [ 30.898799][ T66] dump_stack (lib/dump_stack.c:130)
> > [ 30.898799][ T66] spin_dump (kernel/locking/spinlock_debug.c:71)
> > [ 30.898799][ T66] do_raw_spin_lock.cold (kernel/locking/spinlock_debug=
.c:78 kernel/locking/spinlock_debug.c:86 kernel/locking/spinlock_debug.c:11=
5)
> > [ 30.898799][ T66] _raw_spin_lock (kernel/locking/spinlock.c:155)
> > [ 30.898799][ T66] ? rhashtable_walk_enter (lib/rhashtable.c:687)
> > [ 30.898799][ T66] rhashtable_walk_enter (lib/rhashtable.c:687)
> > [ 30.898799][ T66] fprobe_module_callback (kernel/trace/fprobe.c:478)
>
> It seems that fprobe_module_callback() is called before
> initializing spinlock (in rhltable?). It should be
> initialized earlier.
>
> Maybe this free_module() is called before late_initcall()?
>
> static int __init fprobe_initcall(void)
> {
>         rhltable_init(&fprobe_ip_table, &fprobe_rht_params);
>         return 0;
> }
> late_initcall(fprobe_initcall);

Nice shot! I think this should be the reason.

Thanks!
Menglong Dong

>
>
> Thank you,
>
> > [ 30.898799][ T66] ? _mutex_trylock_nest_lock (kernel/locking/mutex.c:9=
16)
> > [ 30.898799][ T66] ? fprobe_addr_list_add+0x4a0/0x4a0
> > [ 30.898799][ T66] ? mutex_unlock (kernel/locking/mutex.c:537)
> > [ 30.898799][ T66] notifier_call_chain (kernel/notifier.c:85)
> > [ 30.898799][ T66] blocking_notifier_call_chain (kernel/notifier.c:381 =
kernel/notifier.c:368)
> > [ 30.898799][ T66] do_init_module (kernel/module/main.c:3134)
> > [ 30.898799][ T66] ? free_module (kernel/module/main.c:3011)
> > [ 30.898799][ T66] load_module (kernel/module/main.c:3509)
> > [ 30.898799][ T66] init_module_from_file (kernel/module/main.c:3701)
> > [ 30.898799][ T66] ? __ia32_sys_init_module (kernel/module/main.c:3677)
> > [ 30.898799][ T66] ? ftrace_likely_update (arch/x86/include/asm/smap.h:=
53 kernel/trace/trace_branch.c:223)
> > [ 30.898799][ T66] ? do_raw_spin_unlock (kernel/locking/spinlock_debug.=
c:103 (discriminator 4) kernel/locking/spinlock_debug.c:141 (discriminator =
4))
> > [ 30.898799][ T66] idempotent_init_module (kernel/module/main.c:3636 ke=
rnel/module/main.c:3714)
> > [ 30.898799][ T66] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:6=
43)
> > [ 30.898799][ T66] ? init_module_from_file (kernel/module/main.c:3705)
> > [ 30.898799][ T66] ? ftrace_likely_update (arch/x86/include/asm/smap.h:=
53 kernel/trace/trace_branch.c:223)
> > [ 30.898799][ T66] __x64_sys_finit_module (include/linux/file.h:62 (dis=
criminator 3) include/linux/file.h:83 (discriminator 3) kernel/module/main.=
c:3736 (discriminator 3) kernel/module/main.c:3723 (discriminator 3) kernel=
/module/main.c:3723 (discriminator 3))
> > [ 30.898799][ T66] x64_sys_call (arch/x86/entry/syscall_64.c:41)
> > [ 30.898799][ T66] do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discr=
iminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
> > [ 30.898799][ T66] ? ksys_read (fs/read_write.c:705)
> > [ 30.898799][ T66] ? vfs_write (fs/read_write.c:705)
> > [ 30.898799][ T66] ? build_open_flags (fs/open.c:1420)
> > [ 30.898799][ T66] ? ftrace_likely_update (arch/x86/include/asm/smap.h:=
53 kernel/trace/trace_branch.c:223)
> > [ 30.898799][ T66] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:6=
43)
> > [ 30.898799][ T66] ? lockdep_hardirqs_on_prepare (kernel/locking/lockde=
p.c:4678)
> > [ 30.898799][ T66] ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
> > [ 30.898799][ T66] ? __x64_sys_openat (fs/open.c:1461)
> > [ 30.898799][ T66] ? __x64_sys_open (fs/open.c:1461)
> > [ 30.898799][ T66] ? ftrace_likely_update (arch/x86/include/asm/smap.h:=
53 kernel/trace/trace_branch.c:223)
> > [ 30.898799][ T66] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:6=
43)
> > [ 30.898799][ T66] ? lockdep_hardirqs_on_prepare (kernel/locking/lockde=
p.c:4678)
> > [ 30.898799][ T66] ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
> > [ 30.898799][ T66] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:6=
43)
> > [ 30.898799][ T66] ? lockdep_hardirqs_on_prepare (kernel/locking/lockde=
p.c:4678)
> > [ 30.898799][ T66] ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
> > [ 30.898799][ T66] ? irqentry_exit (kernel/entry/common.c:210)
> > [ 30.898799][ T66] ? exc_page_fault (arch/x86/mm/fault.c:1536)
> > [ 30.898799][ T66] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry=
_64.S:130)
> > [   30.898799][   T66] RIP: 0033:0x7f46bce10719
> > [ 30.898799][ T66] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 0=
0 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0=
f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 08 89 e8 5b 5d c3       or     %cl,-0x3ca2a418(%rcx)
> >    6: 66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
> >    d: 00 00 00
> >   10: 90                      nop
> >   11: 48 89 f8                mov    %rdi,%rax
> >   14: 48 89 f7                mov    %rsi,%rdi
> >   17: 48 89 d6                mov    %rdx,%rsi
> >   1a: 48 89 ca                mov    %rcx,%rdx
> >   1d: 4d 89 c2                mov    %r8,%r10
> >   20: 4d 89 c8                mov    %r9,%r8
> >   23: 4c 8b 4c 24 08          mov    0x8(%rsp),%r9
> >   28: 0f 05                   syscall
> >   2a:*        48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax  =
       <-- trapping instruction
> >   30: 73 01                   jae    0x33
> >   32: c3                      ret
> >   33: 48 8b 0d b7 06 0d 00    mov    0xd06b7(%rip),%rcx        # 0xd06f=
1
> >   3a: f7 d8                   neg    %eax
> >   3c: 64 89 01                mov    %eax,%fs:(%rcx)
> >   3f: 48                      rex.W
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax
> >    6: 73 01                   jae    0x9
> >    8: c3                      ret
> >    9: 48 8b 0d b7 06 0d 00    mov    0xd06b7(%rip),%rcx        # 0xd06c=
7
> >   10: f7 d8                   neg    %eax
> >   12: 64 89 01                mov    %eax,%fs:(%rcx)
> >   15: 48                      rex.W
> > [   30.898799][   T66] RSP: 002b:00007ffc679745b8 EFLAGS: 00000246 ORIG=
_RAX: 0000000000000139
> > [   30.898799][   T66] RAX: ffffffffffffffda RBX: 00005640c34b9160 RCX:=
 00007f46bce10719
> > [   30.898799][   T66] RDX: 0000000000000000 RSI: 00005640aa9b74a0 RDI:=
 0000000000000004
> > [   30.898799][   T66] RBP: 00005640aa9b74a0 R08: 0000000000000000 R09:=
 00005640c34ba430
> > [   30.898799][   T66] R10: 0000000000000004 R11: 0000000000000246 R12:=
 0000000000040000
> > [   30.898799][   T66] R13: 0000000000000000 R14: 00005640c34b83a0 R15:=
 0000000000000000
> > [   30.898799][   T66]  </TASK>
> > [   30.963748][   T66] Oops: general protection fault, probably for non=
-canonical address 0xdffffc0000000002: 0000 [#1] KASAN
> > [   30.964694][   T66] KASAN: null-ptr-deref in range [0x00000000000000=
10-0x0000000000000017]
> > [   30.964694][   T66] CPU: 0 UID: 0 PID: 66 Comm: modprobe Not tainted=
 6.17.0-rc6-00004-ge5a4cc28a052 #1 NONE  5e106928d64815a8c70ffa200d16301537=
e1528f
> > [   30.964694][   T66] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > [ 30.964694][ T66] RIP: 0010:rhashtable_walk_enter (include/linux/list.=
h:169 lib/rhashtable.c:688)
> > [ 30.964694][ T66] Code: c1 ea 03 80 3c 02 00 0f 85 2b 02 00 00 4d 89 7=
7 28 4d 8d 6e 10 48 b8 00 00 00 00 00 fc ff df 4d 8d 67 18 4c 89 ea 48 c1 e=
a 03 <80> 3c 02 00 0f 85 f7 01 00 00 49 8b 5e 10 48 8d 43 08 48 89 c2 48
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0: c1 ea 03                shr    $0x3,%edx
> >    3: 80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1)
> >    7: 0f 85 2b 02 00 00       jne    0x238
> >    d: 4d 89 77 28             mov    %r14,0x28(%r15)
> >   11: 4d 8d 6e 10             lea    0x10(%r14),%r13
> >   15: 48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
> >   1c: fc ff df
> >   1f: 4d 8d 67 18             lea    0x18(%r15),%r12
> >   23: 4c 89 ea                mov    %r13,%rdx
> >   26: 48 c1 ea 03             shr    $0x3,%rdx
> >   2a:*        80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1)        =
       <-- trapping instruction
> >   2e: 0f 85 f7 01 00 00       jne    0x22b
> >   34: 49 8b 5e 10             mov    0x10(%r14),%rbx
> >   38: 48 8d 43 08             lea    0x8(%rbx),%rax
> >   3c: 48 89 c2                mov    %rax,%rdx
> >   3f: 48                      rex.W
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1)
> >    4: 0f 85 f7 01 00 00       jne    0x201
> >    a: 49 8b 5e 10             mov    0x10(%r14),%rbx
> >    e: 48 8d 43 08             lea    0x8(%rbx),%rax
> >   12: 48 89 c2                mov    %rax,%rdx
> >   15: 48                      rex.W
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20250930/202509301440.be4b3631-=
lkp@intel.com
> >
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
