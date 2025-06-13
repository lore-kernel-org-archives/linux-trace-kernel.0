Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34072DA758;
	Fri, 13 Jun 2025 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749803278; cv=none; b=fqoWMGri0bUp1FEtSd18kjKohzyAPvcUw6JzEMLB9lpDWBjg9gv4ePKn+cUO+Mox8arIvBji8q5LLgldk6mpZ6dol+5KuJvpFj9Ajv8aIMMTjTxzPTjqPDZoY/ri/HmtnzVdd3+oqx7n2MJB8UrFqrPeSQM1M0EGAHKMyWdx7Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749803278; c=relaxed/simple;
	bh=+3SYkMZ3+I364JwoZrzSZAbWjdZ6CahFJPiNqNl92Mw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uztrsA8SJVV9+UxgtCKrB22NWMQ9xUvENZkRTNsCUKW6IidANKNcJsBG07mkCXbOV3dAjo/65XDaRDrTraeFv3LqeCSQU+cwHi+CmigbOUMIoMfS0b4vARJ+RyxikZskZTk62gHLX96huyTf2QR261C4YTQRHgERqDQJmAmkb7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgCSGDYD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgCSGDYD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CE6C4CEE3;
	Fri, 13 Jun 2025 08:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749803278;
	bh=+3SYkMZ3+I364JwoZrzSZAbWjdZ6CahFJPiNqNl92Mw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dgCSGDYDzPc+wRMUKPIsiLMvcuDv/2k5xWM+/qT2nt3eciQDxVy0tugJpBOxpQ66v
	 MlloznTm4rpa2IVM/E03IQbMnjnFIJcOTXhB3OZ1wN5ECqQVu5ZWLDNkrk0C49mD/N
	 nOLroCQgT7+9EHn172vZ19yNM5i9PJZsA66DaVcaj3MTKn8gOkx9BSX9eddTMYw0Nw
	 wTRnUNyPNzWZdD7amdRLPPsGzcKNQNd9XHDURe9vXElbZWdJd8NVe/TOkmpJOjG6A+
	 Y5YjD+CgSAiTQPdkRcekXRQJHi2MOCc2h0CzI3/vVb7Fz25t2HeDUnMsRNVPL9ZvD7
	 JNxyo6x8BWcaA==
Date: Fri, 13 Jun 2025 17:27:53 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, open list <linux-kernel@vger.kernel.org>, Linux
 trace kernel <linux-trace-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd
 Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, Anders
 Roxell <anders.roxell@linaro.org>
Subject: Re: next-20250605: Test regression: qemu-x86_64-compat mode ltp
 tracing Oops int3 kernel panic
Message-Id: <20250613172753.3479f786d40c29ec7b51df0a@kernel.org>
In-Reply-To: <CA+G9fYv+1FPMD8e1ZadA3nLcfSRDAWvPRW-A3bGrV0y1VP2zLQ@mail.gmail.com>
References: <CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com>
	<20250609220934.2c3ed98ba8c624fc7cb45172@kernel.org>
	<CA+G9fYsoCc3DnNGoavFiBdymVpdJiEfUSEq967GgThVQW7bTPA@mail.gmail.com>
	<20250610105337.68df01f4@gandalf.local.home>
	<CA+G9fYv+1FPMD8e1ZadA3nLcfSRDAWvPRW-A3bGrV0y1VP2zLQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 18:39:41 +0530
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> On Tue, 10 Jun 2025 at 20:22, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Tue, 10 Jun 2025 18:50:05 +0530
> > Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > > > Is this bug reproducible easier recently?
> > >
> > > Yes. It is easy to reproduce.
> >
> > Can you test before and after this commit:
> >
> >   4334336e769b ("x86/alternatives: Improve code-patching scalability by
> >   removing false sharing in poke_int3_handler()")
> >
> > I think that may be the culprit.
> >
> > Even if Masami's patches work, I want to know what exactly caused it.
> 
> Steven,
> 
> Since the reported regressions are intermittent, It is not easy to bisect.
> However, The commit merged into Linux next-20250414 tag and then
> started noticing from next-20250415 onwards this regression on both
> x86_64 devices and qemu-x86_64 intermittently with and without
> compat mode.
> 
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250606/testrun/28685600/suite/log-parser-test/test/oops-oops-int3-smp-pti/history/
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250606/testrun/28685600/suite/log-parser-test/test/oops-oops-int3-smp-pti/history/?page=2
> 
> And above commit landed into Linus master branch on 2025-05-13 and
> then started noticing this regression intermittently on x86 with and without
> compat mode.
> 
>   - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.16-rc1/testrun/28711641/suite/log-parser-test/test/oops-oops-oops-smp-pti/history/?page=1
> 
> Masami San,
> 
> case 1) compat mode x86_64 (64-bit kernel + 32-bit rootfs)
> I have tested your patch on top of linux next-20250606 tag and tested
> on real x86_64 (64-bit kernel + 32-bit rootfs) hardware for 7 test runs.
> 
> ftrace_regression01 - pass
> ftrace_regression02 - pass
> ftrace-stress-test - pass
> dynamic_debug01 - Hangs (No crash log on serial console)

Hm, this last one seems different reason.

> 
> Case 1.1)
> Above case noticed on qemu-x86_64 with compat mode ^ with
> 12 test runs.
> 
> - https://lkft.validation.linaro.org/scheduler/job/8312811#L1687
> 
> case 2) x86_64 (64-bit kernel + 64-bit rootfs)
> I have tested your patch on top of linux next-20250606 tag and tested
> on real x86_64 (64-bit kernel + 64-bit rootfs) hardware for 4 runs and out of
> these 3 runs failed and found these kernel warnings, kernel BUG and
> invalid opcode while running LTP tracing test cases.
> 
> Here I am sharing the crash log snippet and boot and test log links  and
> build link.
> 
> Test logs:
> [  112.596591] Ring buffer clock went backwards: 113864910133 -> 112596588266
> [  115.829620] cat (5762) used greatest stack depth: 10936 bytes left
> [  120.922517] ------------[ cut here ]------------
> [  120.927198] WARNING: CPU: 2 PID: 6639 at
> kernel/trace/trace_functions_graph.c:985 print_graph_entry+0x579/0x590
> [  120.937364] Modules linked in: x86_pkg_temp_thermal
> [  120.942405] CPU: 2 UID: 0 PID: 6639 Comm: cat Tainted: G S
>         6.15.0-next-20250606 #1 PREEMPT(voluntary)
> [  120.953380] Tainted: [S]=CPU_OUT_OF_SPEC
> [  120.957477] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.7 12/07/2021
> [  120.965036] RIP: 0010:print_graph_entry+0x579/0x590
> 
> Run 1:
> - https://lkft.validation.linaro.org/scheduler/job/8311136#L1700

The warning came from;
----
		/* Save this function pointer to see if the exit matches */
		if (call->depth < FTRACE_RETFUNC_DEPTH &&
		    !WARN_ON_ONCE(call->depth < 0))
			cpu_data->enter_funcs[call->depth] = call->func;
	}
----

Hit the "call->depth < 0". Thus this is function graph tracer's
problem.


> ftrace-stress-test: [   58.963898] /usr/local/bin/kirk[340]: starting
> test ftrace-stress-test (ftrace_stress_test.sh 90)
> [   60.316588] ------------[ cut here ]------------
> [   60.316588] ------------[ cut here ]------------
> [   60.316590] ------------[ cut here ]------------
> [   60.316593] ------------[ cut here ]------------
> [   60.316593] ------------[ cut here ]------------
> [   60.316594] ------------[ cut here ]------------
> [   60.316594] kernel BUG at kernel/entry/common.c:328!
> [   60.316594] kernel BUG at kernel/entry/common.c:328!
> [   60.316595] kernel BUG at kernel/entry/common.c:328!
> [   60.316600] Oops: invalid opcode: 0000 [#1] SMP PTI
> [   60.316604] CPU: 2 UID: 0 PID: 1556 Comm: sh Tainted: G S
>        6.15.0-next-20250606 #1 PREEMPT(voluntary)
> [   60.316608] Tainted: [S]=CPU_OUT_OF_SPEC
> [   60.316609] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.7 12/07/2021
> [   60.316614] ------------[ cut here ]------------
> [   60.316615] kernel BUG at kernel/entry/common.c:328!
> [   60.316617] Oops: invalid opcode: 0000 [#2] SMP PTI
> [   60.316620] CPU: 2 UID: 0 PID: 1556 Comm: sh Tainted: G S
>        6.15.0-next-20250606 #1 PREEMPT(voluntary)
> [   60.316622] Tainted: [S]=CPU_OUT_OF_SPEC
> [   60.316623] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.7 12/07/2021
> [   60.316625] RIP: 0010:irqentry_nmi_enter+0x6c/0x70
> 
> Run 2:
> - https://lkft.validation.linaro.org/scheduler/job/8311138#L1703

Interesting. This hits the max nestable number of NMI.

/*
 * nmi_enter() can nest up to 15 times; see NMI_BITS.
 */
#define __nmi_enter()						\
	do {							\
		lockdep_off();					\
		arch_nmi_enter();				\
		BUG_ON(in_nmi() == NMI_MASK);			\  <=====
		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
	} while (0)


> 
> ftrace-stress-test: [   78.877495] /usr/local/bin/kirk[343]: starting
> test ftrace-stress-test (ftrace_stress_test.sh 90)
> [   78.977303] Scheduler tracepoints stat_sleep, stat_iowait,
> stat_blocked and stat_runtime require the kernel parameter
> schedstats=enable or kernel.sched_schedstats=1
> [   82.299799] cat (2322) used greatest stack depth: 11520 bytes left
> [   82.327708] cat (2327) used greatest stack depth: 11256 bytes left
> [   82.632183] cat (2375) used greatest stack depth: 10992 bytes left
> [  137.335901] ------------[ cut here ]------------
> [  137.335901] ------------[ cut here ]------------
> [  137.335902] ------------[ cut here ]------------
> [  137.335907] kernel BUG at kernel/entry/common.c:328!
> [  137.335908] ------------[ cut here ]------------
> [  137.335909] ------------[ cut here ]------------
> [  137.335912] kernel BUG at kernel/entry/common.c:328!
> [  137.335912] kernel BUG at kernel/entry/common.c:328!
> [  137.335915] Oops: invalid opcode: 0000 [#1] SMP PTI
> [  137.335921] CPU: 0 UID: 0 PID: 544 Comm: sh Tainted: G S
>       6.15.0-next-20250606 #1 PREEMPT(voluntary)
> [  137.335926] Tainted: [S]=CPU_OUT_OF_SPEC
> [  137.335929] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.7 12/07/2021
> [  137.335937] ------------[ cut here ]------------
> [  137.335939] kernel BUG at kernel/entry/common.c:328!
> [  137.335945] Oops: invalid opcode: 0000 [#2] SMP PTI
> [  137.335949] CPU: 0 UID: 0 PID: 544 Comm: sh Tainted: G S
>       6.15.0-next-20250606 #1 PREEMPT(voluntary)
> [  137.335953] Tainted: [S]=CPU_OUT_OF_SPEC
> [  137.335956] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.7 12/07/2021
> [  137.335959] RIP: 0010:irqentry_nmi_enter+0x6c/0x70
> 
> Run 3:
> - https://lkft.validation.linaro.org/scheduler/job/8311139#L1703

This is the same as Run 2, and clearer.

In do_int3(), if we hit a disappeared int3, it is evacuated after
all. This means kprobe_int3_handler() is hit, and call get_kprobe()
to find the corresponding kprobes. But,

ffffffff8150a040 <get_kprobe>:
ffffffff8150a040:       f3 0f 1e fa             endbr64
ffffffff8150a044:       e8 07 b0 e2 ff          call   ffffffff81335050 <__fentry__>
ffffffff8150a049:       48 b8 eb 83 b5 80 46    movabs $0x61c8864680b583eb,%rax
ffffffff8150a050:       86 c8 61 

It hits the ftrace and hooked by fgraph, and eventually returns
via ftrace_return_to_handler()

[  137.338572] RIP: 0010:ftrace_return_to_handler+0xd5/0x1f0
[  137.338577] Code: 00 89 55 c8 48 85 ff 74 07 4c 89 b7 80 00 00 00 49 8b 94 24 38 0b 00 00 48 98 48 8b 04 c2 48 c1 e8 0c 0f b7 c0 48 89 45 b8 cc <90> 48 8b 05 e3 ac c2 01 48 63 80 f8 00 00 00 48 0f a3 45 b8 72 39

This address is;

$ eu-addr2line -fi -e vmlinux ftrace_return_to_handler+0xd5
arch_static_branch inlined at /builds/linux/kernel/trace/fgraph.c:839:6 in ftrace_return_to_handler
/builds/linux/arch/x86/include/asm/jump_label.h:36:2
__ftrace_return_to_handler
/builds/linux/kernel/trace/fgraph.c:839:6
ftrace_return_to_handler
/builds/linux/kernel/trace/fgraph.c:874:9

It is for static_branch, which also uses a text_poke.

-----
#ifdef CONFIG_HAVE_STATIC_CALL
	if (static_branch_likely(&fgraph_do_direct)) { <======
		if (test_bit(fgraph_direct_gops->idx, &bitmap))
			static_call(fgraph_retfunc)(&trace, fgraph_direct_gops, fregs);
-----

But actually, this static_branch modifies the kernel code with
smp_text_poke_single() (note, this is a wrapper of smp_text_poke_batch).

And this is MISSED by the smp_text_poke_int3_handler() again and
go through the kprobes, and hit ftrace (fgraph) and caused this
loop.

So the fundamental issue is that smp_text_poke_batch missed
handling INT3. 

I guess some text_poke user do not get text_mutex?

Thank you,


> 
> Build log:
>  - https://storage.tuxsuite.com/public/linaro/naresh/builds/2yM9krm5KgE5a57QFvOqw9UrSgQ/
> 
> - Naresh
> 
> >
> > -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
