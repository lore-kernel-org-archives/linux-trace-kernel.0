Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CA34C9548
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785349072; cv=none; b=WuG60UKMTeO3iLy83fRuIOQTBGJbxp5VPiunTFuAd/3WnlQ240WCVpixyS4urdCzk/87gblVL5fi3kOYv/+o0ivH5EGHDXh15VnQE27s+EcPmFwwNSLzAdoIUFlnLeel16IrQrySISelugFAbB6ZX4sn1C4VbgiuCvxNj2k/4T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785349072; c=relaxed/simple;
	bh=uM1HH4CkLAGhPXDIpH3Hkb1WN/ps3aU91vN7xZRaIrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alFDiBgy1OrZn7x/p1F2JCIlrhqeRSxEXCyG/ialU+lBogue1ROn9+iKOAaLFe6O7FFyyJVBRbDaTL12gTzGtm94DJuawhKgH4u3VFvKUQnrOxLWFdxLpYKtxPhH3GGuuwaQv+KDVd66IA5KZ76S4r3VNyg6amz0vGrWF+qZWjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iQyCv/KX; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iQyCv/KX"
Message-ID: <38a2480b-b420-4b14-9793-5ab3d7cfb2b9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785349065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJE21NqM8yINCSaOi/YK/DClFge3Ccqxt7AZcDu/6O8=;
	b=iQyCv/KXrySpd0J0BceA3X2EZZEpxU/rmFdxAHGGwslF9vp6B0+2A4k0/+JcLZLBrabHNd
	/XWW/QwuZBDh1HAcfdI7eCF39SKNGXDwd+7fUpOKzyAkAEnjg612Dlk3ypJZkf5sUVy4pR
	EkMMSazSWEpcTkrC14ucaKqTouzsQkM=
Date: Thu, 30 Jul 2026 02:17:31 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 13/17] rv: Add KUnit mock for current
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>,
 Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
 Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>
References: <20260723074534.43521-1-gmonaco@redhat.com>
 <20260723074534.43521-14-gmonaco@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20260723074534.43521-14-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/23/26 15:45, Gabriele Monaco wrote:
> Some monitors do not only rely on tracepoint arguments but also on the
> currently executing task.
> This makes it more challenging to mock events in KUnit.
> 
> Define wrapper functions around current, the functionality is mocked
> only during KUnit, an additional function call is avoided using a static
> branch unless any (even unrelated) KUnit test is running.
> 
> Rely on a global mock_current variable that is set only by the RV KUnit
> tests and cleared on teardown. Unrelated KUnit tests that happen to
> trigger RV handlers would see it null and use current.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
> 
> Notes:
>      V5:
>      * Drop static stub from current to avoid issues with unrelated KUnit tests
> 
>   include/rv/da_monitor.h                       |  1 +
>   include/rv/kunit.h                            | 14 +++++++++-
>   include/rv/ltl_monitor.h                      |  1 +
>   kernel/trace/rv/Kconfig                       |  3 +++
>   .../trace/rv/monitors/pagefault/pagefault.c   |  2 +-
>   kernel/trace/rv/monitors/sleep/sleep.c        | 24 ++++++++---------
>   kernel/trace/rv/rv.c                          | 26 +++++++++++++++++++
>   kernel/trace/rv/rv_monitors_test.c            |  1 +
>   8 files changed, 58 insertions(+), 14 deletions(-)
> 
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index 773564720ba1..9f7ba443d777 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -16,6 +16,7 @@
>   
>   #include <rv/automata.h>
>   #include <linux/rv.h>
> +#include <rv/kunit.h>
>   #include <linux/stringify.h>
>   #include <linux/bug.h>
>   #include <linux/sched.h>
> diff --git a/include/rv/kunit.h b/include/rv/kunit.h
> index ff98b5137285..31e0b93c40ea 100644
> --- a/include/rv/kunit.h
> +++ b/include/rv/kunit.h
> @@ -2,7 +2,10 @@
>   /*
>    * Copyright (C) 2026-2029 Red Hat, Inc. Gabriele Monaco <gmonaco@redhat.com>
>    *
> - * Declaration of utilities to run KUnit tests.
> + * Declaration of wrappers to allow mocking core functionality, like current,
> + * and other testing utilities.
> + * Necessary only when mocking may be needed. If the RV KUnit test is
> + * enabled, the wrappers incur an additional function call overhead.
>    */
>   
>   #ifndef _RV_KUNIT_H
> @@ -57,5 +60,14 @@ void prepare_test(struct kunit *test, const struct rv_kunit_mon *mon);
>   void teardown_test(void *arg);
>   struct task_struct *rv_kunit_alloc_mock_task(struct kunit *test);
>   
> +void rv_mock_current(struct task_struct *tsk);
> +struct task_struct *rv_get_mock_current(void);
> +
> +#define rv_get_current() (unlikely(kunit_get_current_test()) ? rv_get_mock_current() : current)
> +
> +#else /* !CONFIG_RV_MONITORS_KUNIT_TEST */
> +
> +#define rv_get_current() current
> +
>   #endif /* CONFIG_RV_MONITORS_KUNIT_TEST */
>   #endif /* _RV_KUNIT_H */
> diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
> index 56e83edcf0c4..d7dc01db4dd9 100644
> --- a/include/rv/ltl_monitor.h
> +++ b/include/rv/ltl_monitor.h
> @@ -9,6 +9,7 @@
>   #include <linux/stringify.h>
>   #include <linux/seq_buf.h>
>   #include <rv/instrumentation.h>
> +#include <rv/kunit.h>
>   #include <trace/events/task.h>
>   #include <trace/events/sched.h>
>   
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index 34c1feb35a9b..da905de6c4e8 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -121,4 +121,7 @@ config RV_MONITORS_KUNIT_TEST
>   	  These tests verify that monitors correctly detect violations by
>   	  triggering fake events and validating the expected reactions.
>   
> +	  Enabling this may slightly increase overhead of some monitors if any
> +	  unrelated KUnit test is running.
> +
>   	  If unsure, say N.
> diff --git a/kernel/trace/rv/monitors/pagefault/pagefault.c b/kernel/trace/rv/monitors/pagefault/pagefault.c
> index 5e1a2a606783..e52500fd2de0 100644
> --- a/kernel/trace/rv/monitors/pagefault/pagefault.c
> +++ b/kernel/trace/rv/monitors/pagefault/pagefault.c
> @@ -38,7 +38,7 @@ static void ltl_atoms_init(struct task_struct *task, struct ltl_monitor *mon, bo
>   static void handle_page_fault(void *data, unsigned long address, struct pt_regs *regs,
>   			      unsigned long error_code)
>   {
> -	ltl_atom_pulse(current, LTL_PAGEFAULT, true);
> +	ltl_atom_pulse(rv_get_current(), LTL_PAGEFAULT, true);
>   }
>   
>   static int enable_pagefault(void)
> diff --git a/kernel/trace/rv/monitors/sleep/sleep.c b/kernel/trace/rv/monitors/sleep/sleep.c
> index 12328ce663f5..71d2005ce520 100644
> --- a/kernel/trace/rv/monitors/sleep/sleep.c
> +++ b/kernel/trace/rv/monitors/sleep/sleep.c
> @@ -102,7 +102,7 @@ static void handle_sched_waking(void *data, struct task_struct *task)
>   	if (this_cpu_read(hardirq_context)) {
>   		ltl_atom_pulse(task, LTL_WOKEN_BY_HARDIRQ, true);
>   	} else if (in_task()) {
> -		if (current->prio <= task->prio)
> +		if (rv_get_current()->prio <= task->prio)
>   			ltl_atom_pulse(task, LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO, true);
>   	} else if (in_nmi()) {
>   		ltl_atom_pulse(task, LTL_WOKEN_BY_NMI, true);
> @@ -112,12 +112,12 @@ static void handle_sched_waking(void *data, struct task_struct *task)
>   static void handle_contention_begin(void *data, void *lock, unsigned int flags)
>   {
>   	if (flags & LCB_F_RT)
> -		ltl_atom_update(current, LTL_BLOCK_ON_RT_MUTEX, true);
> +		ltl_atom_update(rv_get_current(), LTL_BLOCK_ON_RT_MUTEX, true);
>   }
>   
>   static void handle_contention_end(void *data, void *lock, int ret)
>   {
> -	ltl_atom_update(current, LTL_BLOCK_ON_RT_MUTEX, false);
> +	ltl_atom_update(rv_get_current(), LTL_BLOCK_ON_RT_MUTEX, false);
>   }
>   
>   static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
> @@ -126,7 +126,7 @@ static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
>   	unsigned long args[6];
>   	int op, cmd;
>   
> -	mon = ltl_get_monitor(current);
> +	mon = ltl_get_monitor(rv_get_current());
>   
>   	switch (id) {
>   #ifdef __NR_clock_nanosleep
> @@ -135,11 +135,11 @@ static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
>   #ifdef __NR_clock_nanosleep_time64
>   	case __NR_clock_nanosleep_time64:
>   #endif
> -		syscall_get_arguments(current, regs, args);
> +		syscall_get_arguments(rv_get_current(), regs, args);
>   		ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_MONOTONIC, args[0] == CLOCK_MONOTONIC);
>   		ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, args[0] == CLOCK_TAI);
>   		ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, args[1] == TIMER_ABSTIME);
> -		ltl_atom_update(current, LTL_CLOCK_NANOSLEEP, true);
> +		ltl_atom_update(rv_get_current(), LTL_CLOCK_NANOSLEEP, true);
>   		break;
>   
>   #ifdef __NR_futex
> @@ -148,25 +148,25 @@ static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
>   #ifdef __NR_futex_time64
>   	case __NR_futex_time64:
>   #endif
> -		syscall_get_arguments(current, regs, args);
> +		syscall_get_arguments(rv_get_current(), regs, args);
>   		op = args[1];
>   		cmd = op & FUTEX_CMD_MASK;
>   
>   		switch (cmd) {
>   		case FUTEX_LOCK_PI:
>   		case FUTEX_LOCK_PI2:
> -			ltl_atom_update(current, LTL_FUTEX_LOCK_PI, true);
> +			ltl_atom_update(rv_get_current(), LTL_FUTEX_LOCK_PI, true);
>   			break;
>   		case FUTEX_WAIT:
>   		case FUTEX_WAIT_BITSET:
>   		case FUTEX_WAIT_REQUEUE_PI:
> -			ltl_atom_update(current, LTL_FUTEX_WAIT, true);
> +			ltl_atom_update(rv_get_current(), LTL_FUTEX_WAIT, true);
>   			break;
>   		}
>   		break;
>   #ifdef __NR_epoll_wait
>   	case __NR_epoll_wait:
> -		ltl_atom_update(current, LTL_EPOLL_WAIT, true);
> +		ltl_atom_update(rv_get_current(), LTL_EPOLL_WAIT, true);
>   		break;
>   #endif
>   	}
> @@ -174,7 +174,7 @@ static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
>   
>   static void handle_sys_exit(void *data, struct pt_regs *regs, long ret)
>   {
> -	struct ltl_monitor *mon = ltl_get_monitor(current);
> +	struct ltl_monitor *mon = ltl_get_monitor(rv_get_current());
>   
>   	ltl_atom_set(mon, LTL_FUTEX_LOCK_PI, false);
>   	ltl_atom_set(mon, LTL_FUTEX_WAIT, false);
> @@ -182,7 +182,7 @@ static void handle_sys_exit(void *data, struct pt_regs *regs, long ret)
>   	ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, false);
>   	ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
>   	ltl_atom_set(mon, LTL_EPOLL_WAIT, false);
> -	ltl_atom_update(current, LTL_CLOCK_NANOSLEEP, false);
> +	ltl_atom_update(rv_get_current(), LTL_CLOCK_NANOSLEEP, false);
>   }
>   
>   static void handle_kthread_stop(void *data, struct task_struct *task)
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index cfe950fef3b4..4c7143961e6e 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -893,4 +893,30 @@ void rv_clear_testing(struct kunit_suite *suite)
>   	mutex_unlock(&rv_interface_lock);
>   }
>   EXPORT_SYMBOL_IF_KUNIT(rv_clear_testing);
> +
> +/*
> + * rv_get_mock_current() is called only if we are running from a KUnit test.
> + * This can occur from a legitimate RV test or any unrelated test running when
> + * a real RV monitor is active and triggering events.
> + * We assume the former case is the only one where mock_current is not NULL and
> + * can occur only sequentially (KUnit doesn't run tests in parallel).
> + * We cannot rely on the test's context because there is no way to safely
> + * understand from which test we are running and KUnit utilities require
> + * locking, which is unsafe from NMI or scheduling context.
> + * Note that it is not possible for a real RV monitor to run when the RV KUnit
> + * tests are running (see rv_set_testing()).
> + */
> +static struct task_struct *mock_current;
> +
> +void rv_mock_current(struct task_struct *tsk)
> +{
> +	mock_current = tsk;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(rv_mock_current);
> +
> +struct task_struct *rv_get_mock_current(void)
> +{
> +	return mock_current ?: current;
> +}
> +EXPORT_SYMBOL_GPL(rv_get_mock_current);
>   #endif

rv_mock_current() uses EXPORT_SYMBOL_IF_KUNIT, but rv_get_mock_current() 
uses EXPORT_SYMBOL_GPL. Both are defined inside the same 
CONFIG_RV_MONITORS_KUNIT_TEST block, so rv_get_mock_current should use 
EXPORT_SYMBOL_IF_KUNIT as well, otherwise it leaks a test-only symbol 
into production builds.

With that fixed:
Reviewed-by: Wen Yang <wen.yang@linux.dev>


--
Best wishes,
Wen




