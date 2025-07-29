Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E198F54;
	Tue, 29 Jul 2025 01:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753750963; cv=none; b=B6Z1JqO6HfMV5287mft8Tyv7FsEZoGP6tHghW7lBpf8VXbirx0gjcIPWnQAIXzBGYqJXOwRmKH50W/s+Aajt2/vQHjwHuc6VEWhzLfHcZVK9w3AaxfR9gOVG+doNZxGybRwD61Onidt91VbDFpKUVX/SvRzWH/oT49KOya465KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753750963; c=relaxed/simple;
	bh=TgEGiwf6rruNP3HGR3nvXfXCvQIv4ayNFx92So0hmC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4yTrg6f01PaHZUaKhhimyj8yS3qOfi/op23exsaRAV/zG//FU3o0appE630gQuLIdIoGfQn9Vo3XubqrJR9ykFLt67bd3Q8GXXRe/oqn7U+rZv0nbaXWKij/VRKGEMqtBHmCUj/NqbLkO/+fzXMH3EBNBHu6EnCuS/ufWWEjpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J1JK/Edz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J1JK/Edz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ghgay6/aPEBbQ06oHoX3n84kOJW4qgBGJMDtfOt2W8s=; b=J1JK/EdzifBtyPBQnXG54zO1SI
	U3ekq9nhz3f3FG3zCPhULMtuIaFK6IMItw8d+H8T7BvfJ6X9+y1tL3F+rqSwpjIxIcqlMVf/zO6kO
	/awhnY+TiFZLreHAIhgEIDtOzjPOKddq9D5YqY6ClA+DJk970Bdc4SCii8Abf+bPseV2zCUlenpjN
	ylJBNGm7qRpSJp/ZP22Dj+v1d34jYPNkV9yVBxxMtoOnH+V2VWboX5tS8XtB/FZyF6xTWHLACGLyI
	LZ9Yt3G+KbfX5TvYgmAIT2cgAlZmIwVThXuiwLKZi3QSgVXoBI4UoUU84B8wYv3c3H78nolx8yoMy
	fOZ36R0g==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugYjm-0000000FfnB-3UqD;
	Tue, 29 Jul 2025 01:02:38 +0000
Message-ID: <f6cd51e6-c025-4182-8df8-a621379af6bf@infradead.org>
Date: Mon, 28 Jul 2025 18:02:37 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: tracing: Add documentation about eprobes
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 linux-doc@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Namhyung Kim
 <namhyung@kernel.org>, Jonathan Corbet <corbet@lwn.net>
References: <20250728171522.7d54e116@batman.local.home>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250728171522.7d54e116@batman.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/28/25 2:15 PM, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Eprobes was added back in 5.15, but was never documented. It became a
> "secret" interface even though it has been a topic of several
> presentations. For some reason, when eprobes was added, documenting it
> never became a priority, until now.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  Documentation/trace/eprobes.rst | 268 ++++++++++++++++++++++++++++++++
>  Documentation/trace/index.rst   |   1 +
>  2 files changed, 269 insertions(+)
>  create mode 100644 Documentation/trace/eprobes.rst
> 
> diff --git a/Documentation/trace/eprobes.rst b/Documentation/trace/eprobes.rst
> new file mode 100644
> index 000000000000..c7aa7c867e9e
> --- /dev/null
> +++ b/Documentation/trace/eprobes.rst
> @@ -0,0 +1,268 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================
> +Eprobe - Event probes
> +=====================
> +
> +:Author: Steven Rostedt <rostedt@goodmis.org>
> +
> +- Written for v6.17
> +
> +Overview
> +========
> +
> +Eprobes are dynamic events that are placed on existing events to eiter

                                                                    either

> +dereference a field that is a pointer, or simply to limit what fields get

                                                       (preference:)     are

> +recorded in the trace event.
> +
> +Eprobes depend on kprobe events so to enable this feature, build your kernel

                                                         s/,/;/

> +with CONFIG_KPROBE_EVENTS=y.
> +
> +Eprobes are created via the /sys/kernel/tracing/dynamic_events file.
> +
> +Synopsis of eprobe_events
> +-------------------------
> +::
> +
> +  e[:[EGRP/][EEVENT]] GRP.EVENT [FETCHARGS]	: Set a probe
> +  -:[EGRP/][EEVENT]				: Clear a probe
> +
> + EGRP		: Group name of the new event. If omitted, use "eprobes" for it.
> + EEVENT		: Event name. If omitted, the event name is generated and will
> +		  be the same event name as the event it attached to.
> + GRP		: Group name of the event to attach to.
> + EVENT		: Event name of the event to attach to.
> +
> + FETCHARGS	: Arguments. Each probe can have up to 128 args.
> +  $FIELD	: Fetch the value of the event field called FIELD.
> +  @ADDR		: Fetch memory at ADDR (ADDR should be in kernel)
> +  @SYM[+|-offs]	: Fetch memory at SYM +|- offs (SYM should be a data symbol)
> +  $comm		: Fetch current task comm.
> +  +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*3)(\*4)
> +  \IMM		: Store an immediate value to the argument.
> +  NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
> +  FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
> +		  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
> +		  (x8/x16/x32/x64), VFS layer common type(%pd/%pD), "char",
> +                  "string", "ustring", "symbol", "symstr" and bitfield are

		Should bitfield be quoted?

> +                  supported.
> +
> +Types
> +-----
> +The FETCHARGS above is very similar to the kprobe events as described in 
> +Documentation/trace/kprobetrace.rst.
> +
> +The difference between eprobes and kprobes FETCHARGS is that eprobes has a
> +$FIELD command that returns the content of the event field of the event
> +that is attached. Eprobes do not have access to registers, stacks and function
> +arguments that kprobes has.
> +
> +If a field argument is a pointer, it may be dereferenced just like a memory
> +address using the FETCHARGS syntax.
> +
> +
> +Attaching to dynamic events
> +---------------------------
> +
> +Note that eprobes may attach to dynamic events as well as to normal events. It

Don't need "Note that".

> +may attach to a kprobe event, a synthetic event or a fprobe event. This is

                                      I would say:    an fprobe event.

> +useful if the type of a field needs to be changed. See Example 2 below.
> +
> +Usage examples
> +==============
> +
> +Example 1
> +---------
> +
> +The basic usage of eprobes is to limit the data that is being recorded into
> +the tracing buffer. For example, a common event to trace is the sched_switch
> +trace event. That has a format of::
> +
> +	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> +	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> +	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> +	field:int common_pid;	offset:4;	size:4;	signed:1;
> +
> +	field:char prev_comm[16];	offset:8;	size:16;	signed:0;
> +	field:pid_t prev_pid;	offset:24;	size:4;	signed:1;
> +	field:int prev_prio;	offset:28;	size:4;	signed:1;
> +	field:long prev_state;	offset:32;	size:8;	signed:1;
> +	field:char next_comm[16];	offset:40;	size:16;	signed:0;
> +	field:pid_t next_pid;	offset:56;	size:4;	signed:1;
> +	field:int next_prio;	offset:60;	size:4;	signed:1;
> +
> +The first four fields are common to all events and can not be limited. But the
> +rest of the event has 60 bytes of information. It records the names of the
> +previous and next tasks being scheduled out and in, as well as their pids and
> +priorities. It also records the state of the previous task. If only the pids
> +of the tasks are of interest, why waste the ring buffer with all the other
> +fields?
> +
> +An eprobe can limit what gets recorded. Note, it does not help in performance,
> +as all the fields are recorded in a temporary buffer to process the eprobe.
> +::
> +
> + # echo 'e:sched/switch sched.sched_switch prev=$prev_pid:u32 next=$next_pid:u32' >> /sys/kernel/tracing/dynamic_events
> + # echo 1 > /sys/kernel/tracing/events/sched/switch/enable
> + # cat /sys/kernel/tracing/trace
> +
> + # tracer: nop
> + #
> + # entries-in-buffer/entries-written: 2721/2721   #P:8
> + #
> + #                                _-----=> irqs-off/BH-disabled
> + #                               / _----=> need-resched
> + #                              | / _---=> hardirq/softirq
> + #                              || / _--=> preempt-depth
> + #                              ||| / _-=> migrate-disable
> + #                              |||| /     delay
> + #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> + #              | |         |   |||||     |         |
> +     sshd-session-1082    [004] d..4.  5041.239906: switch: (sched.sched_switch) prev=1082 next=0
> +             bash-1085    [001] d..4.  5041.240198: switch: (sched.sched_switch) prev=1085 next=141
> +    kworker/u34:5-141     [001] d..4.  5041.240259: switch: (sched.sched_switch) prev=141 next=1085
> +           <idle>-0       [004] d..4.  5041.240354: switch: (sched.sched_switch) prev=0 next=1082
> +             bash-1085    [001] d..4.  5041.240385: switch: (sched.sched_switch) prev=1085 next=141
> +    kworker/u34:5-141     [001] d..4.  5041.240410: switch: (sched.sched_switch) prev=141 next=1085
> +             bash-1085    [001] d..4.  5041.240478: switch: (sched.sched_switch) prev=1085 next=0
> +     sshd-session-1082    [004] d..4.  5041.240526: switch: (sched.sched_switch) prev=1082 next=0
> +           <idle>-0       [001] d..4.  5041.247524: switch: (sched.sched_switch) prev=0 next=90
> +           <idle>-0       [002] d..4.  5041.247545: switch: (sched.sched_switch) prev=0 next=16
> +      kworker/1:1-90      [001] d..4.  5041.247580: switch: (sched.sched_switch) prev=90 next=0
> +        rcu_sched-16      [002] d..4.  5041.247591: switch: (sched.sched_switch) prev=16 next=0
> +           <idle>-0       [002] d..4.  5041.257536: switch: (sched.sched_switch) prev=0 next=16
> +        rcu_sched-16      [002] d..4.  5041.257573: switch: (sched.sched_switch) prev=16 next=0
> + 
> +Note, without adding the "u32" after the prev_pid and next_pid, the values
> +would default showing in hexadecimal.
> +
> +Example 2
> +---------
> +
> +If syscall events are not enabled but the raw syscall are (systemcall

                                                 syscalls are (system call

> +events are not normal events, but are created from the raw_syscall events
> +within the kernel). In order to trace the openat system call, one can create

                    ^^ not a complete sentence.


> +an event probe on top of the raw_syscall event:
> +::
> +
> + # cd /sys/kernel/tracing
> + # cat events/raw_syscalls/sys_enter/format
> + name: sys_enter
> + ID: 395
> + format:
> +	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> +	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> +	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> +	field:int common_pid;	offset:4;	size:4;	signed:1;
> +
> +	field:long id;	offset:8;	size:8;	signed:1;
> +	field:unsigned long args[6];	offset:16;	size:48;	signed:0;
> +
> + print fmt: "NR %ld (%lx, %lx, %lx, %lx, %lx, %lx)", REC->id, REC->args[0], REC->args[1], REC->args[2], REC->args[3], REC->args[4], REC->args[5]
> +
> +From the source code, the sys_openat() has:
> +::
> +
> + int sys_openat(int dirfd, const char *path, int flags, mode_t mode)
> + {
> +	return my_syscall4(__NR_openat, dirfd, path, flags, mode);
> + }
> +
> +The path is the second parameter, and that is what is wanted.

s/wanted/want/

> +::
> +
> + # echo 'e:openat raw_syscalls.sys_enter nr=$id filename=+8($args):ustring' >> dynamic_events
> +
> +This is being run on x86_64 where the word size is 8 bytes and the openat
> +systemcall __NR_openat is set at 257.

   system call

> +::
> +
> + # echo 'nr == 257' > events/eprobes/openat/filter
> +
> +Now enable the event and look at the trace.
> +::
> +
> + # echo 1 > events/eprobes/openat/enable
> + # cat trace
> +
> + # tracer: nop
> + #
> + # entries-in-buffer/entries-written: 4/4   #P:8
> + #
> + #                                _-----=> irqs-off/BH-disabled
> + #                               / _----=> need-resched
> + #                              | / _---=> hardirq/softirq
> + #                              || / _--=> preempt-depth
> + #                              ||| / _-=> migrate-disable
> + #                              |||| /     delay
> + #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> + #              | |         |   |||||     |         |
> +              cat-1298    [003] ...2.  2060.875970: openat: (raw_syscalls.sys_enter) nr=0x101 filename=(fault)
> +              cat-1298    [003] ...2.  2060.876197: openat: (raw_syscalls.sys_enter) nr=0x101 filename=(fault)
> +              cat-1298    [003] ...2.  2060.879126: openat: (raw_syscalls.sys_enter) nr=0x101 filename=(fault)
> +              cat-1298    [003] ...2.  2060.879639: openat: (raw_syscalls.sys_enter) nr=0x101 filename=(fault)
> +
> +The filename shows "(fault)". This is likely because the filename has not been
> +pulled into memory yet and currently trace events cannot fault in memory that
> +is not present. When a eprobe tries to read memory that has not been faulted

                        an eprobe

> +in yet, it will show the "(fault)" text.
> +
> +To get around this, as the kernel will likely pull in this filename and make
> +it present, attaching it to a synthetic event that can pass the address of the
> +filename from the entry of the event to the end of the event, this can be used
> +to show the filename when the system call returns.
> +
> +Remove the old eprobe::
> +
> + # echo 1 > events/eprobes/openat/enable
> + # echo '-:openat' >> dynamic_events
> +
> +This time make an eprobe where the address of the filename is saved::
> +
> + # echo 'e:openat_start raw_syscalls.sys_enter nr=$id filename=+8($args):x64' >> dynamic_events
> +
> +Create a synthetic event that passes the address of the filename to the
> +end of the event::
> +
> + # echo 's:filename u64 file' >> dynamic_events
> + # echo 'hist:keys=common_pid:f=filename if nr == 257' > events/eprobes/openat_start/trigger
> + # echo 'hist:keys=common_pid:file=$f:onmatch(eprobes.openat_start).trace(filename,$file) if id == 257' > events/raw_syscalls/sys_exit/trigger
> +
> +Now that the address of the filename has been passed to the end of the
> +systemcall, create another eprobe to attach to the exit event to show the

   system call,

> +string::
> +
> + # echo 'e:openat synthetic.filename filename=+0($file):ustring' >> dynamic_events
> + # echo 1 > events/eprobes/openat/enable
> + # cat trace
> +
> + # tracer: nop
> + #
> + # entries-in-buffer/entries-written: 4/4   #P:8
> + #
> + #                                _-----=> irqs-off/BH-disabled
> + #                               / _----=> need-resched
> + #                              | / _---=> hardirq/softirq
> + #                              || / _--=> preempt-depth
> + #                              ||| / _-=> migrate-disable
> + #                              |||| /     delay
> + #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> + #              | |         |   |||||     |         |
> +              cat-1331    [001] ...5.  2944.787977: openat: (synthetic.filename) filename="/etc/ld.so.cache"
> +              cat-1331    [001] ...5.  2944.788480: openat: (synthetic.filename) filename="/lib/x86_64-linux-gnu/libc.so.6"
> +              cat-1331    [001] ...5.  2944.793426: openat: (synthetic.filename) filename="/usr/lib/locale/locale-archive"
> +              cat-1331    [001] ...5.  2944.831362: openat: (synthetic.filename) filename="trace"
> +
> +Example 3
> +---------
> +
> +If syscall trace events are available, the above would not need the first
> +eprobe, but it would still need the last one::
> +
> + # echo 's:filename u64 file' >> dynamic_events
> + # echo 'hist:keys=common_pid:f=filename' > events/syscalls/sys_enter_openat/trigger
> + # echo 'hist:keys=common_pid:file=$f:onmatch(syscalls.sys_enter_openat).trace(filename,$file)' > events/syscalls/sys_exit_openat/trigger
> + # echo 'e:openat synthetic.filename filename=+0($file):ustring' >> dynamic_events
> + # echo 1 > events/eprobes/openat/enable
> +
> +And this would produce the same result as Example 2.

Thanks for the new documentation.

-- 
~Randy

