Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5A943F0B5;
	Wed, 15 Jul 2026 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784142695; cv=none; b=K3kbzyc+RpkIPHJw9ZxiDVs0Gt6G+9ZrWsCWvNwubGDCUR7LM0dwAO6U1CiiHTeS89dWWhPMvmgZAEyIJCpqhoBfVaHk+2MHCdH/OJB3x5zz06tPFUgPHlnmFL/+NwVmfo5gpYcF7UvCA1oWNqxl40NPap7EmeH36d+Ux/qH67I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784142695; c=relaxed/simple;
	bh=cNpSgjkpuyvMyDH66LekXDtYgdfnHCR8St6fvC+3uPI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVj5wiOgfdWk1/tCbC95Sr7tHSd5GFb/T22OnDCFx3O+6PxoPtiqJb/m33ipRNaVq6JkQcHP3NlOgrTrQXlsXbC1kBopAHrQD3IkKbrNCy8M71EcYU5fa2iIBQ5WBOK1++LrQxhswBkqApdQuFdYIn2OUIRo7/FV0weix/sD/Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id CD473A0158;
	Wed, 15 Jul 2026 19:11:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id E7FC530;
	Wed, 15 Jul 2026 19:11:14 +0000 (UTC)
Date: Wed, 15 Jul 2026 15:11:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, leitao@debian.org
Subject: Re: [RFC] tracing: Try user copies with page faults disabled first
Message-ID: <20260715151120.0c7b80cb@gandalf.local.home>
In-Reply-To: <20260715155454.4127988-1-usama.arif@linux.dev>
References: <20260715155454.4127988-1-usama.arif@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: nx6se5171zhxahkfcdsiqnk63m5n6zpz
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: E7FC530
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/vbsQ/v95LPZxg20/6Ks2gOuGBrDe146E=
X-HE-Tag: 1784142674-298897
X-HE-Meta: U2FsdGVkX18qrRDCzVzZD9/nM6pH7KHQl7X7VQcYsuTKUdp7u7VquJwkghPMA115k5RzxUCZNKsRvQtdsm1LkLxXT+pEHU6G6wwR0Yk61oB758/m0Jaqib8ul/40d7Y/yLah9+KLQ0ZfiVCuVo9rte4nd82LsYoiueXYO1WqyAkMWZFAs8keAzXvzaQg4cokjrmoBu42dG60fakjXMJeQriefwsATjXGcBRRt7qzhOPmQ3NVSRswuWPSeL7KrEGSdAYuDkfvpQFEx3a/x2iquY/6sXEhAYs0/se0lrHp6dl9YSypvmk7mSt2ih0g88YgunOBNuUPt5uJgSr0hyOghtiSC+IWgyj3C6JWhwX5/Zzp9VUFTqq41A==

On Wed, 15 Jul 2026 08:54:54 -0700
Usama Arif <usama.arif@linux.dev> wrote:

> trace_user_fault_read() is called with preemption disabled to copy user
> memory into a per-cpu scratch buffer. The existing implementation enables
> preemption around the copy because faulting user memory can sleep. That
> opens a window where another task can run on the same CPU and clobber the
> per-cpu buffer, so the copy is wrapped in a retry loop: sample
> nr_context_switches_cpu(), do the preempt-enabled copy, and retry if the
> counter changed. If this fails to complete 100 times, the function gives up
> with a warning.
> 
> nr_context_switches_cpu() reads rq->nr_switches. That counter increments
> for every context switch on the CPU, not only for switches to tasks that
> use this tracing scratch buffer. On a heavily loaded system, unrelated
> scheduler activity can move the counter during every preempt-enabled copy
> attempt, exhaust the retry guard, and trigger the warning.
> 
> This is showing up across the Meta fleet around 100 times a day since the
> kernel began upgrading to 7.1, mostly on arm servers:
> 
>   Error: Too many tries to read user space
>   WARNING: kernel/trace/trace.c:6244 at trace_user_fault_read+0x284/0x2c8, CPU#28: Collection-18/677527
>   CPU: 28 UID: 0 PID: 677527 Comm: Collection-18 Kdump: loaded Not tainted 7.1.0-.... #1 PREEMPTLAZY
>   Hardware name: Quanta Java Island MP 29F0EMA08CH/Java Island, BIOS F0EJ3A16 03/12/2026
>   Call trace:
>    trace_user_fault_read+0x284/0x2c8 (P)
>    syscall_get_data+0x144/0x2c0
>    perf_syscall_enter+0xc0/0x2d8
>    syscall_trace_enter+0x1a0/0x270
>    do_el0_svc+0x54/0xb8
>    el0_svc+0x44/0x268
>    el0t_64_sync_handler+0x7c/0x120
>    el0t_64_sync+0x17c/0x180
>   ---[ end trace 0000000000000000 ]---
> 
> The retry loop is only needed when preemption must be enabled for the user
> copy. If the user pages are already resident, the copy can complete without
> fault handling that sleeps, and preemption can stay disabled throughout.
> 
> Add a fast path that first tries the copy with page faults disabled. For
> the plain copy_from_user case, use __copy_from_user_inatomic(). If the
> probe faults, the architecture exception-table fixup returns a non-zero
> not-copied count and trace_user_fault_read() falls back to the existing
> preempt-enabled slow path.
> 
> Custom copy callbacks need the same behavior. Update the syscall argument
> copy callbacks to report a non-zero return only when the pagefault-disabled
> probe faults. With page faults enabled, keep their previous behavior:
> record the syscall event and omit only the individual user argument that
> still cannot be copied.
> 
> The slow path remains in place for nonresident pages and permanent copy
> failures. nr_context_switches_cpu() still overcounts, but the retry loop is
> now avoided for the common resident-page case that does not need fault
> handling.

This was reported also under memory load.

I have a patch that will only do a retry if another *user* task schedules
in, and will not be bothered by kernel tasks (which may be scheduled in due
to the copy from user to begin with).

Can you see if that works too?

  https://lore.kernel.org/all/20260710083357.49e05ff6@gandalf.local.home/

I'm also thinking it may be backwards to try with page_fault disabled
first. Because if the text is not present in memory (which is the case for
a lot of syscalls), it will fail there and then go into the "slow path" to
try with enabling preemption. If you bug hits then, it could cause the
warning to show up.

If you first try with preemption disabled, it will likely pull the page
into memory, so if it does schedule, doing it with pagefault_disabled() a
second time is more likely to succeed (the page has been pulled in via the
first attempt). That is, the first attempt pulls in the page but fails due
to being scheduled out, the second attempt with pagefault_disabled() may be
more likely to succeed. Thus, on option is to simply alternate between
re-enabling preemption, and calling with page_fault() disabled.

-- Steve


> 
> Reported-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
> This warning is very likely occuring when the fleetwide profiler runs
> and something else seems to load the server. (As we have perf_syscall_enter()
> in the stack and I see the profiler process active when the warning prints).
> It can occur several days after boot, so its a bit difficult to verify
> if the warning will go away with this patch deployed.
> If the patch looks good, we can deploy it in the fleet and report back.
> ---
