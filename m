Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7DC321F37;
	Fri, 29 Aug 2025 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480062; cv=none; b=lIs67Nolg3trh1i2a3RCELXqlTMvzjXumQZWTw3jxV5L56htm+NUl39C7CTf8BcOM0WWgbPsAzsPcJBeMVsH1gFGTUTV91GEOZVUoFfIYOES0wC3aiRyna/F80SNCsFjA0VQqRpJubBmFl1rD3d31BFiuEkQ71NbYgFNvBZqCq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480062; c=relaxed/simple;
	bh=97CGla5pB7DKcJ8OJXm4108wxl3hH8kDUjnW5dSe6yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1uAC9AIjSuaGIYxciV7EwRVRYCF/EPfJNqWLz15BjuUrOJJXoclkxJ64Lz8g0GKD82f9Vm2I8VyhXRs+HTlDSnpP/mR8uT2nBMyCv3pbsr6AlwaaH1no7hZTFS157qLOuNCqDOOdecc2Uf63TDbTHvQZU1fKqzYEMKtqKRwvuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdXaaKgd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdXaaKgd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063FEC4CEF0;
	Fri, 29 Aug 2025 15:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756480062;
	bh=97CGla5pB7DKcJ8OJXm4108wxl3hH8kDUjnW5dSe6yE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=IdXaaKgdAjB9Krugil/NAPNZh7tGr7cArL8+TTYtzq2g9HeEmfGHXWnEcg3SZnU30
	 Z460TU0rXaU+z/5Ze8C/gP1y6sxVmEkOJRoMVfEBNjHX85YVrpz3MDWg91q21DW3ax
	 eQ3ssz7L4tf8dBt2xfXtC/ruzMKbL5niNHD+ezGeVJBNlUGx9jWYBq1qXCQwHp21QZ
	 ugU1/wWRErYWFqtiWK7xT1mMXI3k9L1DBYauly6DjMO3sUsLVzVg3e63WsrONMh+Xv
	 RahNjyAPsBlDzbuRGa27IUalf3ViGgaWKyquHDr7Fg1c9gtmXG/hKafAlc0uzLp/QA
	 RbjP1OXB9tadA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A4CF5CE0BB0; Fri, 29 Aug 2025 08:07:41 -0700 (PDT)
Date: Fri, 29 Aug 2025 08:07:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2025.08.13a] [tracing]  364ac25d46:
 WARNING:at_arch/x86/mm/fault.c:#do_user_addr_fault
Message-ID: <68044ea3-32c1-4d72-9bd3-fe2031669d79@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202508211038.c93e8603-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508211038.c93e8603-lkp@intel.com>

On Thu, Aug 21, 2025 at 01:26:45PM +0800, kernel test robot wrote:
> 
> hi, Paul,
> 
> we also noticed there is similar commit in newer branch
>   dev.2025.08.14a
>   dev.2025.08.19a
> but we didn't finish any bisect for them so far.
> 
> if the issue is already known and fixed in newer version, please just ignore
> this report. sorry if any inconvenience.
> 
> below full report FYI.
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:at_arch/x86/mm/fault.c:#do_user_addr_fault" on:
> 
> commit: 364ac25d46eea504eb90229d2a1f92e18c1a1eae ("tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast")
> https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2025.08.13a
> 
> in testcase: boot
> 
> config: i386-randconfig-004-20250819
> compiler: clang-20
> test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)

Thank you for your testing efforts, and apologies for being slow!

Could you please try the diagnostic patch at the end of this email?

							Thanx, Paul

> +----------------------------------------------------+------------+------------+
> |                                                    | c0e2a3f449 | 364ac25d46 |
> +----------------------------------------------------+------------+------------+
> | WARNING:at_arch/x86/mm/fault.c:#do_user_addr_fault | 0          | 12         |
> | EIP:do_user_addr_fault                             | 0          | 12         |
> | BUG:kernel_NULL_pointer_dereference,address        | 0          | 12         |
> | Oops                                               | 0          | 12         |
> | EIP:do_int80_syscall_32                            | 0          | 12         |
> | Kernel_panic-not_syncing:Fatal_exception           | 0          | 12         |
> +----------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202508211038.c93e8603-lkp@intel.com
> 
> 
> [    5.974959][  T117] ------------[ cut here ]------------
> [ 5.975530][ T117] WARNING: CPU: 1 PID: 117 at arch/x86/mm/fault.c:1276 do_user_addr_fault (ld-temp.o:?) 
> [    5.976496][  T117] Modules linked in:
> [    5.976924][  T117] CPU: 1 UID: 0 PID: 117 Comm: sh Not tainted 6.17.0-rc1-00010-g364ac25d46ee #1 NONE  7aaffa6b74f3c55be0a24cdbe6593fcd4ccf301d
> [    5.978263][  T117] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 5.979306][ T117] EIP: do_user_addr_fault (ld-temp.o:?) 
> [ 5.979859][ T117] Code: 15 fe ff ff 89 f9 ff 75 f0 e8 96 04 00 00 83 c4 04 e9 03 fe ff ff 89 f9 89 da ff 75 f0 e8 72 01 00 00 83 c4 04 e9 ef fd ff ff <0f> 0b 89 f9 89 da ff 75 f0 e8 fc 03 00 00 83 c4 04 e9 d9 fd ff ff
> All code
> ========
>    0:	15 fe ff ff 89       	adc    $0x89fffffe,%eax
>    5:	f9                   	stc
>    6:	ff 75 f0             	push   -0x10(%rbp)
>    9:	e8 96 04 00 00       	call   0x4a4
>    e:	83 c4 04             	add    $0x4,%esp
>   11:	e9 03 fe ff ff       	jmp    0xfffffffffffffe19
>   16:	89 f9                	mov    %edi,%ecx
>   18:	89 da                	mov    %ebx,%edx
>   1a:	ff 75 f0             	push   -0x10(%rbp)
>   1d:	e8 72 01 00 00       	call   0x194
>   22:	83 c4 04             	add    $0x4,%esp
>   25:	e9 ef fd ff ff       	jmp    0xfffffffffffffe19
>   2a:*	0f 0b                	ud2		<-- trapping instruction
>   2c:	89 f9                	mov    %edi,%ecx
>   2e:	89 da                	mov    %ebx,%edx
>   30:	ff 75 f0             	push   -0x10(%rbp)
>   33:	e8 fc 03 00 00       	call   0x434
>   38:	83 c4 04             	add    $0x4,%esp
>   3b:	e9 d9 fd ff ff       	jmp    0xfffffffffffffe19
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2
>    2:	89 f9                	mov    %edi,%ecx
>    4:	89 da                	mov    %ebx,%edx
>    6:	ff 75 f0             	push   -0x10(%rbp)
>    9:	e8 fc 03 00 00       	call   0x40a
>    e:	83 c4 04             	add    $0x4,%esp
>   11:	e9 d9 fd ff ff       	jmp    0xfffffffffffffdef
> [    5.981783][  T117] EAX: 80000000 EBX: 00000000 ECX: 00000000 EDX: 4875de00
> [    5.982461][  T117] ESI: 46bf1f14 EDI: 46bf1f14 EBP: 46bf1ef0 ESP: 46bf1ec4
> [    5.983152][  T117] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010046
> [    5.983885][  T117] CR0: 80050033 CR2: 00000004 CR3: 06fc8000 CR4: 00040690
> [    5.984575][  T117] Call Trace:
> [ 5.984911][ T117] ? exc_page_fault (ld-temp.o:?) 
> [ 5.985376][ T117] ? pvclock_clocksource_read_nowd (ld-temp.o:?) 
> [ 5.985971][ T117] ? handle_exception (arch/x86/entry/entry_32.S:1048) 
> [ 5.986454][ T117] ? do_int80_syscall_32 (ld-temp.o:?) 
> [ 5.986948][ T117] ? entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
> [ 5.987410][ T117] ? insn_get_code_seg_params (ld-temp.o:?) 
> [ 5.987948][ T117] ? pvclock_clocksource_read_nowd (ld-temp.o:?) 
> [ 5.988547][ T117] ? do_int80_syscall_32 (ld-temp.o:?) 
> [ 5.989050][ T117] ? pvclock_clocksource_read_nowd (ld-temp.o:?) 
> [ 5.989645][ T117] ? do_int80_syscall_32 (ld-temp.o:?) 
> [ 5.990146][ T117] ? entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
> [ 5.990611][ T117] ? irqentry_exit (ld-temp.o:?) 
> [ 5.991053][ T117] ? exc_page_fault (ld-temp.o:?) 
> [ 5.991512][ T117] ? entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
> [    5.991915][  T117] irq event stamp: 5810
> [ 5.992173][ T117] hardirqs last enabled at (5809): do_wait (ld-temp.o:?) 
> [ 5.992686][ T117] hardirqs last disabled at (5810): do_int80_syscall_32 (ld-temp.o:?) 
> [ 5.993245][ T117] softirqs last enabled at (5692): local_bh_enable (ld-temp.o:?) 
> [ 5.993776][ T117] softirqs last disabled at (5690): local_bh_disable (ld-temp.o:?) 
> [    5.994304][  T117] ---[ end trace 0000000000000000 ]---
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250821/202508211038.c93e8603-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


commit 2d6142ce44dca77fb173bb96850634b169277214
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Aug 28 12:56:42 2025 -0700

    EXP tracing: Diagnostic for __DECLARE_TRACE() use of SRCU-fast
    
    This patch is intended to test the theory that preemption needs to be
    disabled in some portion of the tracing infrastructure extending from
    the __DECLARE_TRACE() macro to the target BPF program.
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index a22c1ab88560b8..c422e4c5ed51ed 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -273,7 +273,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	static inline void __do_trace_##name(proto)			\
 	{								\
 		if (cond) {						\
-			guard(srcu_fast_notrace)(&tracepoint_srcu);	\
+			guard(preempt_notrace)();			\
 			__DO_TRACE_CALL(name, TP_ARGS(args));		\
 		}							\
 	}								\
