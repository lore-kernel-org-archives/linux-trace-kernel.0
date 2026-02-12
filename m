Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A557056B81;
	Thu, 12 Feb 2026 04:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770870249; cv=none; b=doVxYLiGkBc1DpQMFuiwJi6eNhCUHAW2VsyKkVqCTw+R4xoWFAqMIFs5O3ctcnDsa7vJhLTxO7Q99ztaKIHg5HZ8kzr2WOHiDQJqb+Q5qcZGdnQYCF+i0HPm44v0HuME8jACDoXgVrWydbeUcQuJJlRbYOIpJ3ZntBYyHzH+up8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770870249; c=relaxed/simple;
	bh=cTCViAgUd7jS2aijszGMT8uWrwQGVTK9z8K9M8vqUC0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bjgZM0qlkazQw6+yRZ72xMk78iAF/1Og+nXZitA6v7KFQqu3F+Ta2qyBPjE8bzo2nRnRKb07P+FP5oLmUEc5/lqJq3trKG/1HjbbiA1QgQAZbSUn5Dr70c0HKzeJZo33pymmYKCmtPv5jtx4RWMLNRAvMfXuE2FBbiIWoJnU1FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScOcombt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScOcombt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9756CC4CEF7;
	Thu, 12 Feb 2026 04:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770870249;
	bh=cTCViAgUd7jS2aijszGMT8uWrwQGVTK9z8K9M8vqUC0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ScOcombtB8AU4LWsymUDBDHy8BrttzmDX1yCFdyIujyDEb5Kqdbe2e0Xg4sO0CpJt
	 RPvr61sC0DEl/Hb4M+BfiJAI24aE1k9OPkipAw37hZtSWML7UuSRHNduHNJRxbqGAC
	 u1iRRic7U7cO0onEfXObXcL+t/n5TJNjVqlHLkPaUZx4aDMAi8wmq1lqQOKScFpe5I
	 u4qsByH5Hq90e/YEkoIRHsv4Jw2Orl4z8wB/zAC4/XWm9oCoQqm3iKfkE0NKAQxgOL
	 mhneesM0qDaWAueotwKZtJV4c8eRRheAM0vjbQoArz3g5eKRRGLCJBO915uEkY8a8u
	 yN7UkCn/uIQvg==
Date: Thu, 12 Feb 2026 13:24:06 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] tracing: Make the backup instance non-reusable
Message-Id: <20260212132406.69813d1f0ffaa3fdb19f9c40@kernel.org>
In-Reply-To: <20260211104244.193953be@fedora>
References: <176991653525.4025429.12655335935351822711.stgit@mhiramat.tok.corp.google.com>
	<176991655479.4025429.105619035638065215.stgit@mhiramat.tok.corp.google.com>
	<20260204211721.74e501f0@robin>
	<20260209180844.c582bdbb6a4a5b737db7a0a7@kernel.org>
	<20260209184247.4c6daccd@fedora>
	<20260210141415.01a6907dcb558866e1abb994@kernel.org>
	<20260211104244.193953be@fedora>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Feb 2026 10:42:44 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 10 Feb 2026 14:14:15 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Hmm, OK. Now I found how sysfs handles it.
> > 
> > 	/*
> > 	 * For regular files, if the opener has CAP_DAC_OVERRIDE, open(2)
> > 	 * succeeds regardless of the RW permissions.  sysfs had an extra
> > 	 * layer of enforcement where open(2) fails with -EACCES regardless
> > 	 * of CAP_DAC_OVERRIDE if the permission doesn't have the
> > 	 * respective read or write access at all (none of S_IRUGO or
> > 	 * S_IWUGO) or the respective operation isn't implemented.  The
> > 	 * following flag enables that behavior.
> > 	 */
> > 	KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK	= 0x0002,
> > 
> > So for the similar reason, I will make tracefs to check the permission
> > even if CAP_DAC_OVERRIDE is set. (But this check should be done in general,
> > instead of each open() operation)
> > 
> 
> I don't believe this is the same. This is about an instance being truly
> read only. The instance is special, not the files. Note, permissions can
> be changed by root too.

Ah, OK. Let me add read only checks in all related .open operations.

> After applying your patches, I did the following:
> 
> ~# cd /sys/kernel/tracing/instances/backup/
> ~# ls -l current_tracer
> -r--r----- 1 root root 0 Feb 11 10:29 current_tracer
> 
> ~# cat current_tracer 
> nop
> 
> ~# cat trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 0/0   #P:8
> #
> #                                _-----=> irqs-off/BH-disabled
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
> 
> ~# chmod 664 current_tracer
> ~# ls -l current_tracer
> -rw-rw-r-- 1 root root 0 Feb 11 10:29 current_tracer

Ah, OK...

> 
> ~# echo function > current_tracer
> ~# cat current_tracer 
> function
> 
> ~# cat trace
> # tracer: function
> #
> # entries-in-buffer/entries-written: 1750306/2076556   #P:8
> #
> #                                _-----=> irqs-off/BH-disabled
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>             bash-1056    [001] .....   231.448852: mutex_unlock <-tracing_set_tracer
>           <idle>-0       [002] ...1.   231.448853: arch_cpu_idle_exit <-do_idle
> ##### CPU 7 buffer started ####
>           <idle>-0       [007] ...1.   231.448853: arch_cpu_idle_exit <-do_idle
>             bash-1056    [001] .....   231.448854: __mutex_unlock_slowpath <-tracing_set_tracer
>           <idle>-0       [002] d..1.   231.448855: arch_cpu_idle_enter <-do_idle
>           <idle>-0       [007] d..1.   231.448855: arch_cpu_idle_enter <-do_idle
>           <idle>-0       [007] d..1.   231.448855: tsc_verify_tsc_adjust <-arch_cpu_idle_enter
>           <idle>-0       [002] d..1.   231.448855: tsc_verify_tsc_adjust <-arch_cpu_idle_enter
>             bash-1056    [001] d....   231.448856: fpregs_assert_state_consistent <-arch_exit_to_user_mode_prepare
>           <idle>-0       [007] d..1.   231.448856: local_touch_nmi <-do_idle
>           <idle>-0       [002] d..1.   231.448856: local_touch_nmi <-do_idle
>             bash-1056    [001] d....   231.448856: switch_fpu_return <-arch_exit_to_user_mode_prepare
>           <idle>-0       [007] d..1.   231.448856: rcu_nocb_flush_deferred_wakeup <-do_idle
>           <idle>-0       [002] d..1.   231.448856: rcu_nocb_flush_deferred_wakeup <-do_idle
>           <idle>-0       [007] d..1.   231.448857: cpuidle_get_cpu_driver <-do_idle
>           <idle>-0       [002] d..1.   231.448857: cpuidle_get_cpu_driver <-do_idle
>           <idle>-0       [007] d..1.   231.448857: cpuidle_not_available <-do_idle
> [..]
> 
> Not too read only!
> 
> I change permissions all the time for tracefs files, so I don't want
> that changed.
> 
> This is not the same as sysfs. Let's keep it simple. Have all the open
> callers that can do writes return error -EACCES if a file allows writes
> and is open for write, but is part of the read only instance.

OK.

Thank you,
> 
> -- Steve
>  


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
