Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF07025A2A5;
	Thu,  7 Aug 2025 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577281; cv=none; b=sBQ2NIowhpo8Do71Zt4vixR5klGhbwcJFIEFCOEyw59+hGApqSDUXs81xn0XQtG1Tc5Ie9ZAktjOUl1Ut3Yb34Ua0vGr9I4BcghdQSJUWONMnZ7Eqx56aivlIAJo2qwFXY1odZhm3tD5hALOYzIBgWB6mqVD2xWGTvXGFYhSi28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577281; c=relaxed/simple;
	bh=OADzQsGA7rTi4IYU+ps4SuknTfXkYmd7pXQor5qY7QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwuIxg/mOt1BCy6BI8ima/V8bqIMwbkGftfjxv1hvsxoSBIaucw2hZ0/pNqDtnsu9uFcv0QQTYzJbhiij204GvtESSl0DnaNSjw8qMBZFMHD0cy+gsgNSNbomM61Wpt9voBkRzg5ByalImc9snj1pyjLUX6VQeeV2K3gRAuJ9Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SW4f6hoV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SW4f6hoV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C278C4CEEB;
	Thu,  7 Aug 2025 14:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754577281;
	bh=OADzQsGA7rTi4IYU+ps4SuknTfXkYmd7pXQor5qY7QI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=SW4f6hoVgupT++oZ8GKPhcoC3ItxKtODcxqdf+sYTrXFC060LkTlfRklBA6N9dS8K
	 srYu/5m7ebPQ2kwZfHYPBCFSi/Al5TrKxmD39JtPuPYPPtnaGk0yGzYgHSvHmQxFPw
	 /dVy3z9LkFftinWk/t/ZuXxDIyhi0U/BllM0WuR1jaaWApwhX0laRf+kn4il+5tK2X
	 v/Oqtnoj3BIVljO+ve9OJILr3dai+Y8vlMSLum8NH/UybTgcQoieg5nF15gZYgGAb1
	 nzTWcuu4dlE12FEe/9WNPdP3TXhSiThOP31di6hJVXgyV51mUlx5RTQCXCHMKGPLJc
	 655BI6zdnn6/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E28B2CE0AD7; Thu,  7 Aug 2025 07:34:40 -0700 (PDT)
Date: Thu, 7 Aug 2025 07:34:40 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [rcu:dev.30.07.2025a] [tracing]  7f4591b8cb:
 BUG:using_smp_processor_id()in_preemptible
Message-ID: <b9c13c67-ac2d-4d71-899a-68eba943c726@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202508071000.47c89ff-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508071000.47c89ff-lkp@intel.com>

On Thu, Aug 07, 2025 at 04:23:56PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:using_smp_processor_id()in_preemptible" on:
> 
> commit: 7f4591b8cb9c4682dd20ce624bb090e2a634cf9b ("tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast")
> https://git.kernel.org/cgit/linux/kernel/git/rcu/linux.git dev.30.07.2025a

This is a real bug, but has since been fixed in 7e7acbb7dceb ("tracing:
Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast").

We expect to get this updated commit into -next shortly after v6.17-rc1
comes out.  As always, thank you for your testing!

							Thanx, Paul

> in testcase: trinity
> version: trinity-i386-abe9de86-1_20230429
> with following parameters:
> 
> 	runtime: 300s
> 	group: group-00
> 	nr_groups: 5
> 
> 
> 
> config: i386-randconfig-002-20250801
> compiler: clang-20
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +--------------------------------------------+------------+------------+
> |                                            | 97b572666e | 7f4591b8cb |
> +--------------------------------------------+------------+------------+
> | BUG:using_smp_processor_id()in_preemptible | 0          | 12         |
> +--------------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202508071000.47c89ff-lkp@intel.com
> 
> 
> [   32.787484][ T3676] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/3676
> [ 32.788206][ T3676] caller is debug_smp_processor_id (lib/smp_processor_id.c:60) 
> [   32.788627][ T3676] CPU: 0 UID: 0 PID: 3676 Comm: meminfo Not tainted 6.16.0-rc3-00057-g7f4591b8cb9c #1 PREEMPT(lazy)
> [   32.788631][ T3676] Call Trace:
> [ 32.788633][ T3676] __dump_stack (lib/dump_stack.c:95) 
> [ 32.788638][ T3676] dump_stack_lvl (lib/dump_stack.c:123) 
> [ 32.788644][ T3676] dump_stack (lib/dump_stack.c:129) 
> [ 32.788647][ T3676] check_preemption_disabled (lib/smp_processor_id.c:?) 
> [ 32.788654][ T3676] debug_smp_processor_id (lib/smp_processor_id.c:60) 
> [ 32.788657][ T3676] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
> [ 32.788672][ T3676] begin_new_exec (include/linux/srcutree.h:300 include/linux/srcu.h:419 include/linux/srcu.h:519 include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
> [ 32.788682][ T3676] load_elf_binary (fs/binfmt_elf.c:?) 
> [ 32.788693][ T3676] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
> [ 32.788698][ T3676] ? bprm_execve (fs/exec.c:1665 fs/exec.c:1697 fs/exec.c:1749) 
> [ 32.788707][ T3676] bprm_execve (fs/exec.c:1665 fs/exec.c:1697 fs/exec.c:1749) 
> [ 32.788719][ T3676] do_execveat_common (fs/exec.c:?) 
> [ 32.788724][ T3676] __ia32_sys_execve (fs/exec.c:1929 fs/exec.c:2005 fs/exec.c:2000 fs/exec.c:2000) 
> [ 32.788731][ T3676] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-002-20250801/./arch/x86/include/generated/asm/syscalls_32.h:?) 
> [ 32.788735][ T3676] __do_fast_syscall_32 (arch/x86/entry/syscall_32.c:?) 
> [ 32.788740][ T3676] ? __lock_acquire (kernel/locking/lockdep.c:4677) 
> [ 32.788745][ T3676] ? __lock_acquire (kernel/locking/lockdep.c:4677) 
> [ 32.788763][ T3676] ? get_page_from_freelist (mm/page_alloc.c:1714 mm/page_alloc.c:3669) 
> [ 32.788766][ T3676] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
> [ 32.788773][ T3676] ? lock_acquire (kernel/locking/lockdep.c:5871) 
> [ 32.788779][ T3676] ? local_lock_release (include/linux/local_lock_internal.h:54) 
> [ 32.788786][ T3676] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
> [ 32.788790][ T3676] ? local_lock_release (include/linux/local_lock_internal.h:54) 
> [ 32.788800][ T3676] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
> [ 32.788805][ T3676] ? rcu_lock_acquire (include/linux/rcupdate.h:340) 
> [ 32.788814][ T3676] ? handle_mm_fault (include/linux/rcupdate.h:? include/linux/pgtable.h:136 mm/memory.c:3670 mm/memory.c:4030 mm/memory.c:6105 mm/memory.c:6232 mm/memory.c:6401) 
> [ 32.788827][ T3676] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
> [ 32.788830][ T3676] ? preempt_count_add (include/linux/ftrace.h:1091 kernel/sched/core.c:5852 kernel/sched/core.c:5877) 
> [ 32.788837][ T3676] ? irqentry_exit (kernel/entry/common.c:320) 
> [ 32.788840][ T3676] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
> [ 32.788843][ T3676] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4475) 
> [ 32.788849][ T3676] ? irqentry_exit_to_user_mode (kernel/entry/common.c:187) 
> [ 32.788856][ T3676] do_fast_syscall_32 (arch/x86/entry/syscall_32.c:331) 
> [ 32.788860][ T3676] do_SYSENTER_32 (arch/x86/entry/syscall_32.c:369) 
> [ 32.788862][ T3676] entry_SYSENTER_32 (arch/x86/entry/entry_32.S:836) 
> [   32.788865][ T3676] EIP: 0xb7f4c539
> [ 32.788868][ T3676] Code: 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> All code
> ========
>    0:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
>    4:	10 07                	adc    %al,(%rdi)
>    6:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
>    a:	10 08                	adc    %cl,(%rax)
>    c:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
> 	...
>   20:*	00 51 52             	add    %dl,0x52(%rcx)		<-- trapping instruction
>   23:	55                   	push   %rbp
>   24:	89 e5                	mov    %esp,%ebp
>   26:	0f 34                	sysenter
>   28:	cd 80                	int    $0x80
>   2a:	5d                   	pop    %rbp
>   2b:	5a                   	pop    %rdx
>   2c:	59                   	pop    %rcx
>   2d:	c3                   	ret
>   2e:	90                   	nop
>   2f:	90                   	nop
>   30:	90                   	nop
>   31:	90                   	nop
>   32:	90                   	nop
>   33:	90                   	nop
>   34:	90                   	nop
>   35:	90                   	nop
>   36:	90                   	nop
>   37:	90                   	nop
>   38:	90                   	nop
>   39:	90                   	nop
>   3a:	90                   	nop
>   3b:	90                   	nop
>   3c:	90                   	nop
>   3d:	90                   	nop
>   3e:	90                   	nop
>   3f:	90                   	nop
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	5d                   	pop    %rbp
>    1:	5a                   	pop    %rdx
>    2:	59                   	pop    %rcx
>    3:	c3                   	ret
>    4:	90                   	nop
>    5:	90                   	nop
>    6:	90                   	nop
>    7:	90                   	nop
>    8:	90                   	nop
>    9:	90                   	nop
>    a:	90                   	nop
>    b:	90                   	nop
>    c:	90                   	nop
>    d:	90                   	nop
>    e:	90                   	nop
>    f:	90                   	nop
>   10:	90                   	nop
>   11:	90                   	nop
>   12:	90                   	nop
>   13:	90                   	nop
>   14:	90                   	nop
>   15:	90                   	nop
> [   32.788871][ T3676] EAX: ffffffda EBX: 01e25d34 ECX: 01e25c00 EDX: 01e25c0c
> [   32.788873][ T3676] ESI: 01e25d34 EDI: 01e25c00 EBP: bffe5404 ESP: bffe52d8
> [   32.788874][ T3676] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250807/202508071000.47c89ff-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
