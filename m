Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE869337BAC;
	Wed, 27 May 2026 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890863; cv=none; b=Dz3Av4kEhEsOPkbiFr5CTmV88jT1f+7H9yFpK+Sd/fzI8CQ2Q++d3tb2W8cgF2QvvTWvj6a9QN06XkL/Ky02rndw4Yofc2nrhbli7IU6v6MhSUe3w0q8JsBR/wXoLwrDGEFcnmwVcJHOXnKJmnFfkvwQbKB9ofn/MmKxIsWnn2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890863; c=relaxed/simple;
	bh=fFXOWjVPmv+sJhSlLSChsP1mqAyoqeY1jyL5hA2mNe4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lsUDYxk73VCl0zmWlGDjs834eY62cpP+8uZ4O1zEx+CkYytllXEh3gBdMJbqpvYBiaNdF/5VTJQo+FMYXrEyaPMQ5/WN9tUPDHKVLXZ3ROZ5vxYKYYExzZjHr6erQqyrZA3W+6vWPNq7SKQh81d3JVCMk/n1gP0rkyQgp146mzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c28usKx6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c28usKx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F901F000E9;
	Wed, 27 May 2026 14:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779890862;
	bh=0XXN4NQLvhc8Xiwg43alAvbusZG4r8X4j+8NhON7Ihc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=c28usKx6Cbuf9zc+aJNDHTsIjuQXslaSkEhQs1evV02p9ZpsBvmtjJgZdXjv06WUa
	 KdmdtQwRQwuyxXD+f4Ca4lvkC0UL3iVnjkavP1MtoAN/79U2CtBgGyc7qjM0zmx1FM
	 yiSrib1glaqseBmXia/JUJChAVWiCUjm5V/UU6ak8PDH/FkuKU6M1sfvorkGb53scK
	 gON2xclOOZM+UlGe0AIDSMAjnGFNBFlYNit/X/OJdXeqRrWsgznKrhX4J4u3FV1a2m
	 oNX1rYtsZXEBgjE3B2Mv+MgS+RrLRe7rxWC/AuDvP5Jv8fiqBDox1q7AiUb+QZwqoV
	 GUM+cD+HNxL2g==
Date: Wed, 27 May 2026 10:08:15 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, Takaya Saeki <takayas@google.com>,
 Douglas Raillard <douglas.raillard@arm.com>, Tom Zanussi
 <zanussi@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v6] tracing/eprobes: Allow use of BTF names to
 dereference pointers
Message-ID: <20260527100815.53e55c57@gandalf.local.home>
In-Reply-To: <ahayVg7TvNrf1ama@krava>
References: <20260521225033.56458336@fedora>
	<ahayVg7TvNrf1ama@krava>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 10:59:02 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> 
> hi,
> this seems to be supported only for argument (pointer) stored in the trace record,
> not the actual arguments to the tracepoint, is that right?
> 
> so I can deref worker from sched.sched_kthread_work_queue_work, like:
> 
>   echo 'e:myprobe sched.sched_kthread_work_queue_work (kthread_worker)worker->flags (kthread_work)work->canceling' > dynamic_events

Correct, that is because eprobes "e:" works on the output of a trace event.


> 
> but I can't deref sched.sched_process_exec p->pid, like:
> 
>   # echo 'e:myprobe sched.sched_process_exec (task_struct)p->pid' > dynamic_events
>   bash: echo: write error: Invalid argument

For function prototypes of a tracepoint, you would use a tprobe "t:"

 # echo 't:exec sched_process_exec pid=p->pid' > dynamic_events
 # echo 1 > events/tracepoints/exec/enable
 # cat trace
# tracer: nop
#
# entries-in-buffer/entries-written: 7/7   #P:8
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
    rtkit-daemon-1935    [005] .....   105.350235: exec: (__probestub_sched_process_exec+0x4/0x10) pid=1935
    rtkit-daemon-1935    [005] .....   105.376609: exec: (__probestub_sched_process_exec+0x4/0x10) pid=1935
 pkla-check-auth-1939    [000] .....   105.404491: exec: (__probestub_sched_process_exec+0x4/0x10) pid=1939
 at-spi-bus-laun-1953    [000] .....   105.914139: exec: (__probestub_sched_process_exec+0x4/0x10) pid=1953
     dbus-daemon-1959    [002] .....   105.919123: exec: (__probestub_sched_process_exec+0x4/0x10) pid=1959
        Xwayland-1961    [006] .....   106.175491: exec: (__probestub_sched_process_exec+0x4/0x10) pid=1961
           <...>-1962    [005] .....   107.406472: exec: (__probestub_sched_process_exec+0x4/0x10) pid=1962

No need for typecasting either ;-)


> > +	ctx->offset += tmp - arg;
> > +	ret = parse_btf_arg(tmp, pcode, end, ctx);
> > +	ctx->flags &= ~TPARG_FL_TYPECAST;
> > +	ctx->last_struct = NULL;
> > +out_put:
> > +	btf_put(ctx->struct_btf);  
> 
> 
> should we zero ctx->struct_btf in case there's more type casts,
> so query_btf_struct would re-init it?

Yeah, I already mentioned that mistake:

  https://lore.kernel.org/all/20260522072322.18aa72dd@gandalf.local.home/

>> Oops, I forgot to do:
>> 
>> 	ctx->struct_buf = NULL;
>> 
>> here.
>> 
>> Will fix.

Thanks for the review!

-- Steve
