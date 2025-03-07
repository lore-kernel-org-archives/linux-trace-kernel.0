Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C48918A92D;
	Fri,  7 Mar 2025 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368001; cv=none; b=Qr9h/Mc6WXA3oxKRLSbpLCXAyB8eFtwazibV40RXYUD9H0Gd3XDhn9qOX3C9zKy1QHt+SIEh3VO9lZepb2oOIj9QmKyRSTcFfC0M7QYjBteOPA7ZG0L9cL1x4wTQ3YB2ktj/YuIrWeLFJ0XvcniGsDHsBSnNvmsawVemds6mAGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368001; c=relaxed/simple;
	bh=0ZS30dU8Lsr3gOB4WsKPSYjdXzRXfPzKxW8yxSCorF0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gu79Bfg1TQyMtzGcDIjB/sXtXX1GzGNQYFSxLYZPyYVHJEcPu9xFGx0xNqrUYUyuape1ZDXFgta6oMWY5kdRfiEAiEm4tUkaX6hj+IUOvk/9/ExGmVzACxwxB21rd0tO4DjN2VI6YeGdHO/deLJ+ZUfBQpUeY8O7HqtkUhjvuls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C17C4CEE7;
	Fri,  7 Mar 2025 17:20:00 +0000 (UTC)
Date: Fri, 7 Mar 2025 12:20:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: tprobe-events: Fix to clean up tprobe
 correctly when module unload
Message-ID: <20250307122000.3087782f@gandalf.local.home>
In-Reply-To: <174124210422.3014222.12363751066695445786.stgit@mhiramat.tok.corp.google.com>
References: <174124210422.3014222.12363751066695445786.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Mar 2025 15:21:44 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> When unloading module, the tprobe events are not correctly cleaned
> up. Thus it becomes `fprobe-event` and never be enabled again even
> if loading the same module again.
> 
> For example;
> 
>  # cd /sys/kernel/tracing
>  # modprobe trace_events_sample
>  # echo 't:my_tprobe foo_bar' >> dynamic_events
>  # cat dynamic_events
> t:tracepoints/my_tprobe foo_bar
>  # rmmod trace_events_sample
>  # cat dynamic_events
> f:tracepoints/my_tprobe foo_bar
> 
> As you can see, the second time my_tprobe starts with 'f' instead
> of 't'.
> 
> This cleans up (unregister) the tprobe events when module is
> unloaded.

After applying this, I tried it out:

 # cd /sys/kernel/tracing
 # modprobe trace_events_sample
 # echo 't:my_tprobe foo_bar a=$arg1' > dynamic_events
 # echo 1 > events/tracepoints/enable
[wait]
 # echo 0 > events/tracepoints/enable
 # cat trace
# tracer: nop
#
# entries-in-buffer/entries-written: 13/13   #P:8
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
    event-sample-1041    [005] ...1.  1957.632897: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1958.656935: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1959.680883: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1960.704855: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1961.728977: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1962.751822: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1963.776834: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1964.800748: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1965.824788: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1966.848789: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1967.872902: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1968.896754: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1969.920737: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
 # rmmod trace_events_sample
 # cat trace
# tracer: nop
#
# entries-in-buffer/entries-written: 13/13   #P:8
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
    event-sample-1041    [005] ...1.  1957.632897: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1958.656935: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1959.680883: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1960.704855: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1961.728977: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1962.751822: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1963.776834: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1964.800748: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1965.824788: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1966.848789: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1967.872902: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1968.896754: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1969.920737: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186

 # modprobe trace_events_sample
 # echo 1 > events/tracepoints/enable
 # cat trace
# tracer: nop
#
# entries-in-buffer/entries-written: 13/13   #P:8
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
    event-sample-1041    [005] ...1.  1957.632897: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1958.656935: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1959.680883: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1960.704855: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1961.728977: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1962.751822: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1963.776834: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1964.800748: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1965.824788: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1966.848789: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1967.872902: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1968.896754: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
    event-sample-1041    [005] ...1.  1969.920737: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186

Tracing doesn't restart.

-- Steve

