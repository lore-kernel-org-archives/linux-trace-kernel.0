Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D919A249F9;
	Wed, 19 Feb 2025 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739990508; cv=none; b=jr5jbd/XlCnj1n2D8r1u299GevMBOJmoIs0tUKm1dasen3bD1F7etNaOzOXHfuQ4TYRXC/MXfsYsDfrUyuLJfTQctNWEgL84GK44jZunW3CF/NKhCX/S3ZFbwG0Wu+2PVgUnsuv7t4UKNFteATYrP4pjCKHMPfi03u182RTOZrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739990508; c=relaxed/simple;
	bh=aezWVaWkYkAZqIoprXKcGG4CTord/RI14ESEr2bVgHU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RvdhfrMnFGwCnZRz0ZKgz23SqQAzuApO73kXZXOpwK9UeFFri+64LWHJs4d6lXpbkJfKjv3mpMroxrQfQ8laCu/NDiN6zMsu/tiFQ+kMPe+lyivHPnr0ycSmwvuJ+uXhilbDx2ee2zYcAGtxoXWsXfUxgWyjRahXKelSyYjqQ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB53C4CED1;
	Wed, 19 Feb 2025 18:41:46 +0000 (UTC)
Date: Wed, 19 Feb 2025 13:42:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jemmy Wong <jemmywong512@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] sched: Refine scheduler naming for clarity and
 specificity
Message-ID: <20250219134210.51bdf447@gandalf.local.home>
In-Reply-To: <20250219182020.393006-2-jemmywong512@gmail.com>
References: <20250219182020.393006-1-jemmywong512@gmail.com>
	<20250219182020.393006-2-jemmywong512@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 02:20:19 +0800
Jemmy Wong <jemmywong512@gmail.com> wrote:

> +++ b/Documentation/trace/ftrace.rst
> @@ -986,14 +986,14 @@ why a latency happened. Here is a typical trace::
>    #  => ended at:   _raw_spin_unlock_irqrestore
>    #
>    #
> -  #                  _------=> CPU#
> -  #                 / _-----=> irqs-off
> -  #                | / _----=> need-resched
> -  #                || / _---=> hardirq/softirq
> -  #                ||| / _--=> preempt-depth
> -  #                |||| /     delay
> -  #  cmd     pid   ||||| time  |   caller
> -  #     \   /      |||||  \    |   /
> +  #                  _------=> CPU#
> +  #                 / _-----=> irqs-off
> +  #                | / _----=> need-resched
> +  #                || / _---=> hardirq/softirq
> +  #                ||| / _--=> preempt-depth
> +  #                |||| /     delay
> +  #  cmd     pid   ||||| time  |   caller
> +  #     \   /      |||||  \    |   /

What exactly did you change for all these header updates?

-- Steve

>          ps-6143    2d...    0us!: trace_hardirqs_off <-__lock_task_sighand
>          ps-6143    2d..1  259us+: trace_hardirqs_on <-_raw_spin_unlock_irqrestore
>          ps-6143    2d..1  263us+: time_hardirqs_on <-_raw_spin_unlock_irqrestore
> @@ -1490,14 +1490,14 @@ an example::
>    #  => ended at:   run_timer_softirq
>    #
>    #
> -  #                  _------=> CPU#
> -  #                 / _-----=> irqs-off
> -  #                | / _----=> need-resched
> -  #                || / _---=> hardirq/softirq
> -  #                ||| / _--=> preempt-depth
> -  #                |||| /     delay
> -  #  cmd     pid   ||||| time  |   caller
> -  #     \   /      |||||  \    |   /
> +  #                  _------=> CPU#
> +  #                 / _-----=> irqs-off
> +  #                | / _----=> need-resched
> +  #                || / _---=> hardirq/softirq
> +  #                ||| / _--=> preempt-depth
> +  #                |||| /     delay
> +  #  cmd     pid   ||||| time  |   caller
> +  #     \   /      |||||  \    |   /
>      <idle>-0       0d.s2    0us+: _raw_spin_lock_irq <-run_timer_softirq
>      <idle>-0       0dNs3   17us : _raw_spin_unlock_irq <-run_timer_softirq
>      <idle>-0       0dNs3   17us+: trace_hardirqs_on <-run_timer_softirq
> @@ -1541,14 +1541,14 @@ function-trace, we get a much larger output::
>    #  => ended at:   ata_scsi_queuecmd
>    #
>    #
> -  #                  _------=> CPU#
> -  #                 / _-----=> irqs-off
> -  #                | / _----=> need-resched
> -  #                || / _---=> hardirq/softirq
> -  #                ||| / _--=> preempt-depth
> -  #                |||| /     delay
> -  #  cmd     pid   ||||| time  |   caller
> -  #     \   /      |||||  \    |   /
> +  #                  _------=> CPU#
> +  #                 / _-----=> irqs-off
> +  #                | / _----=> need-resched
> +  #                || / _---=> hardirq/softirq
> +  #                ||| / _--=> preempt-depth
> +  #                |||| /     delay
> +  #  cmd     pid   ||||| time  |   caller
> +  #     \   /      |||||  \    |   /
>        bash-2042    3d...    0us : _raw_spin_lock_irqsave <-ata_scsi_queuecmd
>        bash-2042    3d...    0us : add_preempt_count <-_raw_spin_lock_irqsave
>        bash-2042    3d..1    1us : ata_scsi_find_dev <-ata_scsi_queuecmd
> @@ -1689,14 +1689,14 @@ is much like the irqsoff tracer.
>    #  => ended at:   do_IRQ
>    #
>    #
> -  #                  _------=> CPU#
> -  #                 / _-----=> irqs-off
> -  #                | / _----=> need-resched
> -  #                || / _---=> hardirq/softirq
> -  #                ||| / _--=> preempt-depth
> -  #                |||| /     delay
> -  #  cmd     pid   ||||| time  |   caller
> -  #     \   /      |||||  \    |   /
> +  #                  _------=> CPU#
> +  #                 / _-----=> irqs-off
> +  #                | / _----=> need-resched
> +  #                || / _---=> hardirq/softirq
> +  #                ||| / _--=> preempt-depth
> +  #                |||| /     delay
> +  #  cmd     pid   ||||| time  |   caller
> +  #     \   /      |||||  \    |   /
>        sshd-1991    1d.h.    0us+: irq_enter <-do_IRQ
>        sshd-1991    1d..1   46us : irq_exit <-do_IRQ
>        sshd-1991    1d..1   47us+: trace_preempt_on <-do_IRQ
> @@ -1727,14 +1727,14 @@ was over.
>    #  => ended at:   task_rq_unlock
>    #
>    #
> -  #                  _------=> CPU#
> -  #                 / _-----=> irqs-off
> -  #                | / _----=> need-resched
> -  #                || / _---=> hardirq/softirq
> -  #                ||| / _--=> preempt-depth
> -  #                |||| /     delay
> -  #  cmd     pid   ||||| time  |   caller
> -  #     \   /      |||||  \    |   /
> +  #                  _------=> CPU#
> +  #                 / _-----=> irqs-off
> +  #                | / _----=> need-resched
> +  #                || / _---=> hardirq/softirq
> +  #                ||| / _--=> preempt-depth
> +  #                |||| /     delay
> +  #  cmd     pid   ||||| time  |   caller
> +  #     \   /      |||||  \    |   /
>        bash-1994    1d..1    0us : _raw_spin_lock_irqsave <-wake_up_new_task
>        bash-1994    1d..1    0us : select_task_rq_fair <-select_task_rq
>        bash-1994    1d..1    1us : __rcu_read_lock <-select_task_rq_fair
> @@ -1841,14 +1841,14 @@ tracers.
>    #  => ended at:   ata_scsi_queuecmd
>    #
>    #
> -  #                  _------=> CPU#
> -  #                 / _-----=> irqs-off
> -  #                | / _----=> need-resched
> -  #                || / _---=> hardirq/softirq
> -  #                ||| / _--=> preempt-depth
> -  #                |||| /     delay
> -  #  cmd     pid   ||||| time  |   caller
> -  #     \   /      |||||  \    |   /
> +  #                  _------=> CPU#
> +  #                 / _-----=> irqs-off
> +  #                | / _----=> need-resched
> +  #                || / _---=> hardirq/softirq
> +  #                ||| / _--=> preempt-depth
> +  #                |||| /     delay
> +  #  cmd     pid   ||||| time  |   caller
> +  #     \   /      |||||  \    |   /
>          ls-2230    3d...    0us+: _raw_spin_lock_irqsave <-ata_scsi_queuecmd
>          ls-2230    3...1  100us : _raw_spin_unlock_irqrestore <-ata_scsi_queuecmd
>          ls-2230    3...1  101us+: trace_preempt_on <-ata_scsi_queuecmd
> @@ -1894,14 +1894,14 @@ Here is a trace with function-trace set::
>    #  => ended at:   mutex_unlock
>    #
>    #
> -  #                  _------=> CPU#
> -  #                 / _-----=> irqs-off
> -  #                | / _----=> need-resched
> -  #                || / _---=> hardirq/softirq
> -  #                ||| / _--=> preempt-depth
> -  #                |||| /     delay
> -  #  cmd     pid   ||||| time  |   caller
> -  #     \   /      |||||  \    |   /
> +  #                  _------=> CPU#
> +  #                 / _-----=> irqs-off
> +  #                | / _----=> need-resched
> +  #                || / _---=> hardirq/softirq
> +  #                ||| / _--=> preempt-depth
> +  #                |||| /     delay
> +  #  cmd     pid   ||||| time  |   caller
> +  #     \   /      |||||  \    |   /
>    kworker/-59      3...1    0us : __schedule <-schedule
>    kworker/-59      3d..1    0us : rcu_preempt_qs <-rcu_note_context_switch
>    kworker/-59      3d..1    1us : add_preempt_count <-_raw_spin_lock_irq
> @@ -1987,7 +1987,7 @@ wakeup
>  One common case that people are interested in tracing is the
>  time it takes for a task that is woken to actually wake up.
>  Now for non Real-Time tasks, this can be arbitrary. But tracing
> -it nonetheless can be interesting.
> +it nonetheless can be interesting.
> 
>  Without function tracing::
> 
> @@ -2007,14 +2007,14 @@ Without function tracing::
>    #    | task: kworker/3:1H-312 (uid:0 nice:-20 policy:0 rt_prio:0)
>    #    -----------------
>    #
> -  #                  _------=> CPU#
> -  #                 / _-----=> irqs-off
> -  #                | / _----=> need-resched
> -  #                || / _---=> hardirq/softirq
> -  #                ||| / _--=> preempt-depth
> -  #                |||| /     delay
> -  #  cmd     pid   ||||| time  |   caller
> -  #     \   /      |||||  \    |   /
> +  #                  _------=> CPU#
> +  #                 / _-----=> irqs-off
> +  #                | / _----=> need-resched
> +  #                || / _---=> hardirq/softirq
> +  #                ||| / _--=> preempt-depth
> +  #                |||| /     delay
> +  #  cmd     pid   ||||| time  |   caller
> +  #     \   /      |||||  \    |   /
>      <idle>-0       3dNs7    0us :      0:120:R   + [003]   312:100:R kworker/3:1H
>      <idle>-0       3dNs7    1us+: ttwu_do_activate.constprop.87 <-try_to_wake_up
>      <idle>-0       3d..3   15us : __schedule <-schedule
> @@ -2076,14 +2076,14 @@ Instead of performing an 'ls', we will run 'sleep 1' under
>    #    | task: sleep-2389 (uid:0 nice:0 policy:1 rt_prio:5)
>    #    -----------------
>    #
> -  #                  _------=> CPU#
> -  #                 / _-----=> irqs-off
> -  #                | / _----=> need-resched
> -  #                || / _---=> hardirq/softirq
> -  #                ||| / _--=> preempt-depth
> -  #                |||| /     delay
> -  #  cmd     pid   ||||| time  |   caller
> -  #     \   /      |||||  \    |   /
> +  #                  _------=> CPU#
> +  #                 / _-----=> irqs-off
> +  #                | / _----=> need-resched
> +  #                || / _---=> hardirq/softirq
> +  #                ||| / _--=> preempt-depth
> +  #                |||| /     delay
> +  #  cmd     pid   ||||| time  |   caller
> +  #     \   /      |||||  \    |   /
>      <idle>-0       3d.h4    0us :      0:120:R   + [003]  2389: 94:R sleep
>      <idle>-0       3d.h4    1us+: ttwu_do_activate.constprop.87 <-try_to_wake_up
>      <idle>-0       3d..3    5us : __schedule <-schedule
> @@ -2125,19 +2125,19 @@ Doing the same with chrt -r 5 and function-trace set.
>    #    | task: sleep-2448 (uid:0 nice:0 policy:1 rt_prio:5)
>    #    -----------------
>    #
> -  #                  _------=> CPU#
> -  #                 / _-----=> irqs-off
> -  #                | / _----=> need-resched
> -  #                || / _---=> hardirq/softirq
> -  #                ||| / _--=> preempt-depth
> -  #                |||| /     delay
> -  #  cmd     pid   ||||| time  |   caller
> -  #     \   /      |||||  \    |   /
> +  #                  _------=> CPU#
> +  #                 / _-----=> irqs-off
> +  #                | / _----=> need-resched
> +  #                || / _---=> hardirq/softirq
> +  #                ||| / _--=> preempt-depth
> +  #                |||| /     delay
> +  #  cmd     pid   ||||| time  |   caller
> +  #     \   /      |||||  \    |   /
