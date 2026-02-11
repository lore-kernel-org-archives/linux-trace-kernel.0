Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99BD310635;
	Wed, 11 Feb 2026 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770824593; cv=none; b=BMdc0lKGQIQXK1SqQotAB3tlc14g2cg0s3GpCpM3ru6VoJpUaO/s+wqt1GsWDXbHNJYZvgxbYxYW8aUAAkampqSO1Byzhoxht9eq45TuYN9AcBPDp3vQkqC8Vmr3Va9nJwuoKp/iaYlJ+FQw7QbXxCrwalWVkddYCaPdQnhrzuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770824593; c=relaxed/simple;
	bh=hjoUfjg2kZj9zcc/yk0LK/Beyw8CiklGI8cf8jEXipo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYJ0uykFliju9bGPbR2qtP1ipP4jDJWvovTPAlzffCyso/CIciWJfhCZBoWTaabifO5FXhw3ejbzBtLWuDyMwM32UBd0HnHx7BOd/FOQe6hMbCIfD7VP4MaWfiO2G6OP82WuzcRvwbYgL7MntR6I2q/I8aS/ivJVi6il0zRMhMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 46EDCC1C70;
	Wed, 11 Feb 2026 15:43:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id D745B20028;
	Wed, 11 Feb 2026 15:42:58 +0000 (UTC)
Date: Wed, 11 Feb 2026 10:42:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] tracing: Make the backup instance non-reusable
Message-ID: <20260211104244.193953be@fedora>
In-Reply-To: <20260210141415.01a6907dcb558866e1abb994@kernel.org>
References: <176991653525.4025429.12655335935351822711.stgit@mhiramat.tok.corp.google.com>
	<176991655479.4025429.105619035638065215.stgit@mhiramat.tok.corp.google.com>
	<20260204211721.74e501f0@robin>
	<20260209180844.c582bdbb6a4a5b737db7a0a7@kernel.org>
	<20260209184247.4c6daccd@fedora>
	<20260210141415.01a6907dcb558866e1abb994@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: nd7nnjxrjtp31xc3dg8kbumg4qkdwtkh
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: D745B20028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19AJcOeGgPUl1wsGwSKhDoRC4g8+vzURqg=
X-HE-Tag: 1770824578-29122
X-HE-Meta: U2FsdGVkX1970ZbLz8Y8rU7gDSddcDYvrVE08VCEYZzXEBQwKp6ptkvhWoGwMpXWpN0ExOSeOywspmk9/3EH+N9oSJWgBZWDmjkvPCZ3GFpqvb+DE5Ge7sHN2Am1n72qbfArzsiDkh4JhmohwbMVWrZcFSCQB4kzwj5ZcDPIoqs3gw5425uJC3YNVKioT6fyw/EHt15j8OLWBgcd51OGr4+I/aCJxeyJGLiDA9MGBpi9VRrYSBA9KFlno/bAWvsBXWEtRqVQD8RRb/D1g1jaJyrEaCgAmTpQ7yeaP7VvgmQ9KlASl8lwODPrb2GmSD/wv4Djp9VQ66omHZXQCFIDqw3XsqQAqjlo

On Tue, 10 Feb 2026 14:14:15 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hmm, OK. Now I found how sysfs handles it.
> 
> 	/*
> 	 * For regular files, if the opener has CAP_DAC_OVERRIDE, open(2)
> 	 * succeeds regardless of the RW permissions.  sysfs had an extra
> 	 * layer of enforcement where open(2) fails with -EACCES regardless
> 	 * of CAP_DAC_OVERRIDE if the permission doesn't have the
> 	 * respective read or write access at all (none of S_IRUGO or
> 	 * S_IWUGO) or the respective operation isn't implemented.  The
> 	 * following flag enables that behavior.
> 	 */
> 	KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK	= 0x0002,
> 
> So for the similar reason, I will make tracefs to check the permission
> even if CAP_DAC_OVERRIDE is set. (But this check should be done in general,
> instead of each open() operation)
> 

I don't believe this is the same. This is about an instance being truly
read only. The instance is special, not the files. Note, permissions can
be changed by root too. After applying your patches, I did the following:

~# cd /sys/kernel/tracing/instances/backup/
~# ls -l current_tracer
-r--r----- 1 root root 0 Feb 11 10:29 current_tracer

~# cat current_tracer 
nop

~# cat trace
# tracer: nop
#
# entries-in-buffer/entries-written: 0/0   #P:8
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |

~# chmod 664 current_tracer
~# ls -l current_tracer
-rw-rw-r-- 1 root root 0 Feb 11 10:29 current_tracer

~# echo function > current_tracer
~# cat current_tracer 
function

~# cat trace
# tracer: function
#
# entries-in-buffer/entries-written: 1750306/2076556   #P:8
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
            bash-1056    [001] .....   231.448852: mutex_unlock <-tracing_set_tracer
          <idle>-0       [002] ...1.   231.448853: arch_cpu_idle_exit <-do_idle
##### CPU 7 buffer started ####
          <idle>-0       [007] ...1.   231.448853: arch_cpu_idle_exit <-do_idle
            bash-1056    [001] .....   231.448854: __mutex_unlock_slowpath <-tracing_set_tracer
          <idle>-0       [002] d..1.   231.448855: arch_cpu_idle_enter <-do_idle
          <idle>-0       [007] d..1.   231.448855: arch_cpu_idle_enter <-do_idle
          <idle>-0       [007] d..1.   231.448855: tsc_verify_tsc_adjust <-arch_cpu_idle_enter
          <idle>-0       [002] d..1.   231.448855: tsc_verify_tsc_adjust <-arch_cpu_idle_enter
            bash-1056    [001] d....   231.448856: fpregs_assert_state_consistent <-arch_exit_to_user_mode_prepare
          <idle>-0       [007] d..1.   231.448856: local_touch_nmi <-do_idle
          <idle>-0       [002] d..1.   231.448856: local_touch_nmi <-do_idle
            bash-1056    [001] d....   231.448856: switch_fpu_return <-arch_exit_to_user_mode_prepare
          <idle>-0       [007] d..1.   231.448856: rcu_nocb_flush_deferred_wakeup <-do_idle
          <idle>-0       [002] d..1.   231.448856: rcu_nocb_flush_deferred_wakeup <-do_idle
          <idle>-0       [007] d..1.   231.448857: cpuidle_get_cpu_driver <-do_idle
          <idle>-0       [002] d..1.   231.448857: cpuidle_get_cpu_driver <-do_idle
          <idle>-0       [007] d..1.   231.448857: cpuidle_not_available <-do_idle
[..]

Not too read only!

I change permissions all the time for tracefs files, so I don't want
that changed.

This is not the same as sysfs. Let's keep it simple. Have all the open
callers that can do writes return error -EACCES if a file allows writes
and is open for write, but is part of the read only instance.

-- Steve
 
