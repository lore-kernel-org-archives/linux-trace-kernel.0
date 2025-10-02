Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E744223185E;
	Thu,  2 Oct 2025 05:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759382719; cv=none; b=PUFp4TQGwumfBpkskCszRMcp0RzmOoBrwyxCqRaECX1d4n7IS+Ri0gPIh3dvvv8oJE7Mo3/1ccYo4zxwHqpBpZG0FKXz64xJw9UOFS6G5yjNXpcaC21TkncI0N9ukQTI1JeJDmyHRZCQCJgp0KhlXmLwlz6FcuaMCL919KwF2bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759382719; c=relaxed/simple;
	bh=x8HvEcs+oLC7jU4coBWjaCsP4o/Bq4sMyUBpi/kgQSw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AFqcjMpGFRp8lmAA+2D2Tg3kDdlFbvRqyEHFS569TlQcQqHCCbjQ6iOjcVH4O6oM7ifmGEu5kkRWCHF69kRHw4HCg+luN7irdtAjqXPASheFzN/QtNsLQ3PI0vfknmA0GXsEVZ+3Y/NC3gjdc0pMirTulkQiF2puOxvuJifZPoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ottd6Ske; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ottd6Ske"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4253CC4CEF4;
	Thu,  2 Oct 2025 05:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759382718;
	bh=x8HvEcs+oLC7jU4coBWjaCsP4o/Bq4sMyUBpi/kgQSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ottd6Ske24FWzCHbYkKgWMGeQr52Ok8f7wDqWY6uffQNP7SrqaLBRV2B+2b8BawTq
	 gu2z85KGmAwhW5otYwboitGjP0h59Yz8g+dHPLrT0oLNuVnYKkjeu9JLJoMo9M6JX4
	 wfJi6tHh++SfJaaXofU8dAVUnXKI0aj28i+jDgL6wz26aeAXgbyd3RLTVTkpLWgXD/
	 ezZJULpncgXEb0Kr3Fal8hQ1QfTyLJvL9b6urRI/EnP3/dmw8N7vm/1r2e9Qg5+Oz2
	 xqW8jtadPzZc921gvqqYMz+hHJ3w5Hum2dclR5brzc0X7HwS3mlmAypJ6wAUur30g5
	 Bt2/P+l+U+qYQ==
Date: Thu, 2 Oct 2025 14:25:15 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, <oe-lkp@lists.linux.dev>,
 <lkp@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, Menglong Dong
 <dongml2@chinatelecom.cn>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [linux-next:master] [tracing]  e5a4cc28a0:
 BUG:spinlock_bad_magic_on_CPU
Message-Id: <20251002142515.ebfcc03ba5490d0d63bec05e@kernel.org>
In-Reply-To: <202509301440.be4b3631-lkp@intel.com>
References: <202509301440.be4b3631-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Sep 2025 14:48:27 +0800
kernel test robot <oliver.sang@intel.com> wrote:

> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:spinlock_bad_magic_on_CPU" on:
> 
> commit: e5a4cc28a052369b6e56b0a9ac05d9b9d5607b06 ("tracing: fprobe: use rhltable for fprobe_ip_table")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: boot
> 
> config: x86_64-randconfig-072-20250929
> compiler: gcc-14
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202509301440.be4b3631-lkp@intel.com
> 
> 
> [   30.894986][   T66] BUG: spinlock bad magic on CPU#0, modprobe/66
> [ 30.896030][ T66] lock: fprobe_ip_table+0x110/0x180, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0 
> [   30.898263][   T66] CPU: 0 UID: 0 PID: 66 Comm: modprobe Not tainted 6.17.0-rc6-00004-ge5a4cc28a052 #1 NONE  5e106928d64815a8c70ffa200d16301537e1528f
> [   30.898799][   T66] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   30.898799][   T66] Call Trace:
> [   30.898799][   T66]  <TASK>
> [ 30.898799][ T66] show_stack (arch/x86/kernel/dumpstack.c:319) 
> [ 30.898799][ T66] dump_stack_lvl (lib/dump_stack.c:122) 
> [ 30.898799][ T66] dump_stack (lib/dump_stack.c:130) 
> [ 30.898799][ T66] spin_dump (kernel/locking/spinlock_debug.c:71) 
> [ 30.898799][ T66] do_raw_spin_lock.cold (kernel/locking/spinlock_debug.c:78 kernel/locking/spinlock_debug.c:86 kernel/locking/spinlock_debug.c:115) 
> [ 30.898799][ T66] _raw_spin_lock (kernel/locking/spinlock.c:155) 
> [ 30.898799][ T66] ? rhashtable_walk_enter (lib/rhashtable.c:687) 
> [ 30.898799][ T66] rhashtable_walk_enter (lib/rhashtable.c:687) 
> [ 30.898799][ T66] fprobe_module_callback (kernel/trace/fprobe.c:478) 

It seems that fprobe_module_callback() is called before
initializing spinlock (in rhltable?). It should be
initialized earlier.

Maybe this free_module() is called before late_initcall()?

static int __init fprobe_initcall(void)
{
	rhltable_init(&fprobe_ip_table, &fprobe_rht_params);
	return 0;
}
late_initcall(fprobe_initcall);


Thank you,

> [ 30.898799][ T66] ? _mutex_trylock_nest_lock (kernel/locking/mutex.c:916) 
> [ 30.898799][ T66] ? fprobe_addr_list_add+0x4a0/0x4a0 
> [ 30.898799][ T66] ? mutex_unlock (kernel/locking/mutex.c:537) 
> [ 30.898799][ T66] notifier_call_chain (kernel/notifier.c:85) 
> [ 30.898799][ T66] blocking_notifier_call_chain (kernel/notifier.c:381 kernel/notifier.c:368) 
> [ 30.898799][ T66] do_init_module (kernel/module/main.c:3134) 
> [ 30.898799][ T66] ? free_module (kernel/module/main.c:3011) 
> [ 30.898799][ T66] load_module (kernel/module/main.c:3509) 
> [ 30.898799][ T66] init_module_from_file (kernel/module/main.c:3701) 
> [ 30.898799][ T66] ? __ia32_sys_init_module (kernel/module/main.c:3677) 
> [ 30.898799][ T66] ? ftrace_likely_update (arch/x86/include/asm/smap.h:53 kernel/trace/trace_branch.c:223) 
> [ 30.898799][ T66] ? do_raw_spin_unlock (kernel/locking/spinlock_debug.c:103 (discriminator 4) kernel/locking/spinlock_debug.c:141 (discriminator 4)) 
> [ 30.898799][ T66] idempotent_init_module (kernel/module/main.c:3636 kernel/module/main.c:3714) 
> [ 30.898799][ T66] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:643) 
> [ 30.898799][ T66] ? init_module_from_file (kernel/module/main.c:3705) 
> [ 30.898799][ T66] ? ftrace_likely_update (arch/x86/include/asm/smap.h:53 kernel/trace/trace_branch.c:223) 
> [ 30.898799][ T66] __x64_sys_finit_module (include/linux/file.h:62 (discriminator 3) include/linux/file.h:83 (discriminator 3) kernel/module/main.c:3736 (discriminator 3) kernel/module/main.c:3723 (discriminator 3) kernel/module/main.c:3723 (discriminator 3)) 
> [ 30.898799][ T66] x64_sys_call (arch/x86/entry/syscall_64.c:41) 
> [ 30.898799][ T66] do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1)) 
> [ 30.898799][ T66] ? ksys_read (fs/read_write.c:705) 
> [ 30.898799][ T66] ? vfs_write (fs/read_write.c:705) 
> [ 30.898799][ T66] ? build_open_flags (fs/open.c:1420) 
> [ 30.898799][ T66] ? ftrace_likely_update (arch/x86/include/asm/smap.h:53 kernel/trace/trace_branch.c:223) 
> [ 30.898799][ T66] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:643) 
> [ 30.898799][ T66] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4678) 
> [ 30.898799][ T66] ? do_syscall_64 (arch/x86/entry/syscall_64.c:113) 
> [ 30.898799][ T66] ? __x64_sys_openat (fs/open.c:1461) 
> [ 30.898799][ T66] ? __x64_sys_open (fs/open.c:1461) 
> [ 30.898799][ T66] ? ftrace_likely_update (arch/x86/include/asm/smap.h:53 kernel/trace/trace_branch.c:223) 
> [ 30.898799][ T66] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:643) 
> [ 30.898799][ T66] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4678) 
> [ 30.898799][ T66] ? do_syscall_64 (arch/x86/entry/syscall_64.c:113) 
> [ 30.898799][ T66] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:643) 
> [ 30.898799][ T66] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4678) 
> [ 30.898799][ T66] ? do_syscall_64 (arch/x86/entry/syscall_64.c:113) 
> [ 30.898799][ T66] ? irqentry_exit (kernel/entry/common.c:210) 
> [ 30.898799][ T66] ? exc_page_fault (arch/x86/mm/fault.c:1536) 
> [ 30.898799][ T66] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
> [   30.898799][   T66] RIP: 0033:0x7f46bce10719
> [ 30.898799][ T66] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
> All code
> ========
>    0:	08 89 e8 5b 5d c3    	or     %cl,-0x3ca2a418(%rcx)
>    6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
>    d:	00 00 00 
>   10:	90                   	nop
>   11:	48 89 f8             	mov    %rdi,%rax
>   14:	48 89 f7             	mov    %rsi,%rdi
>   17:	48 89 d6             	mov    %rdx,%rsi
>   1a:	48 89 ca             	mov    %rcx,%rdx
>   1d:	4d 89 c2             	mov    %r8,%r10
>   20:	4d 89 c8             	mov    %r9,%r8
>   23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
>   28:	0f 05                	syscall
>   2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
>   30:	73 01                	jae    0x33
>   32:	c3                   	ret
>   33:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06f1
>   3a:	f7 d8                	neg    %eax
>   3c:	64 89 01             	mov    %eax,%fs:(%rcx)
>   3f:	48                   	rex.W
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
>    6:	73 01                	jae    0x9
>    8:	c3                   	ret
>    9:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06c7
>   10:	f7 d8                	neg    %eax
>   12:	64 89 01             	mov    %eax,%fs:(%rcx)
>   15:	48                   	rex.W
> [   30.898799][   T66] RSP: 002b:00007ffc679745b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [   30.898799][   T66] RAX: ffffffffffffffda RBX: 00005640c34b9160 RCX: 00007f46bce10719
> [   30.898799][   T66] RDX: 0000000000000000 RSI: 00005640aa9b74a0 RDI: 0000000000000004
> [   30.898799][   T66] RBP: 00005640aa9b74a0 R08: 0000000000000000 R09: 00005640c34ba430
> [   30.898799][   T66] R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000040000
> [   30.898799][   T66] R13: 0000000000000000 R14: 00005640c34b83a0 R15: 0000000000000000
> [   30.898799][   T66]  </TASK>
> [   30.963748][   T66] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] KASAN
> [   30.964694][   T66] KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
> [   30.964694][   T66] CPU: 0 UID: 0 PID: 66 Comm: modprobe Not tainted 6.17.0-rc6-00004-ge5a4cc28a052 #1 NONE  5e106928d64815a8c70ffa200d16301537e1528f
> [   30.964694][   T66] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [ 30.964694][ T66] RIP: 0010:rhashtable_walk_enter (include/linux/list.h:169 lib/rhashtable.c:688) 
> [ 30.964694][ T66] Code: c1 ea 03 80 3c 02 00 0f 85 2b 02 00 00 4d 89 77 28 4d 8d 6e 10 48 b8 00 00 00 00 00 fc ff df 4d 8d 67 18 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 f7 01 00 00 49 8b 5e 10 48 8d 43 08 48 89 c2 48
> All code
> ========
>    0:	c1 ea 03             	shr    $0x3,%edx
>    3:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
>    7:	0f 85 2b 02 00 00    	jne    0x238
>    d:	4d 89 77 28          	mov    %r14,0x28(%r15)
>   11:	4d 8d 6e 10          	lea    0x10(%r14),%r13
>   15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>   1c:	fc ff df 
>   1f:	4d 8d 67 18          	lea    0x18(%r15),%r12
>   23:	4c 89 ea             	mov    %r13,%rdx
>   26:	48 c1 ea 03          	shr    $0x3,%rdx
>   2a:*	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)		<-- trapping instruction
>   2e:	0f 85 f7 01 00 00    	jne    0x22b
>   34:	49 8b 5e 10          	mov    0x10(%r14),%rbx
>   38:	48 8d 43 08          	lea    0x8(%rbx),%rax
>   3c:	48 89 c2             	mov    %rax,%rdx
>   3f:	48                   	rex.W
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
>    4:	0f 85 f7 01 00 00    	jne    0x201
>    a:	49 8b 5e 10          	mov    0x10(%r14),%rbx
>    e:	48 8d 43 08          	lea    0x8(%rbx),%rax
>   12:	48 89 c2             	mov    %rax,%rdx
>   15:	48                   	rex.W
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250930/202509301440.be4b3631-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
