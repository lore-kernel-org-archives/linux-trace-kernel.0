Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2530C23BD05;
	Thu, 18 Jun 2026 01:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781747552; cv=none; b=heg4us6+CP8AEJsjyZnJUMKDa1sUhok8/mM441CHFM/5XKDmh8e4PI2H/OPrOAMb7lYyi1fqKbx/PoNjaJ/DrZp8yTkgqq1o/N1PvgkcmdA9XLT3HD5ZGwchexedg5IdOK0NuNlsUHnTya3Fw3gYpl/Y47UJxnjVyvSE78I8ljI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781747552; c=relaxed/simple;
	bh=2vs48G/wyGMLkEOduADAZvuxl8T/x6YT+C/hJPNOqkU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=N9V5syr9+JqknS8HwXpZGEm5vBBSgkjKYebfFn/RNq/Sl/dN/h9nzpkOzkJwG0QJfoSOpQVo5dXQuGi2f5H4Yib1MwhaSFJhtfLvehUllWR5gNG/TJ8C2wA+5LKUjsu24JKgPb6dl6drj69g9CEOR24lalWKaRrDR1sxX3SE9ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ2SnECG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ2SnECG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F5C1F000E9;
	Thu, 18 Jun 2026 01:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781747550;
	bh=1QY7Y1ZunN8lZl8iwHgNyGGrr+lVU+OaaTzPx65gGVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IZ2SnECGKfy9juNIkM6F+T0jgZWBoLrzcwWHdofsIa9nJADhq+VdgXvCq2wjOL4NR
	 ZfuuThZC2J2YAGfUwbgnfcPJhwCXB1HUN1JfS+KDDtAjzcWoMSPmihSSSCDTvDD+3p
	 TPsTpxe82Hw5EiIXP63vTwDIz+NF8xVRmd5HQXzdMoSMo+u6A0wkWV3oqVYX+gA159
	 M/HmIH3a4Cb0iVcpmHTaUrvjfwBBhh7w2h5qy8OldXhI0vyGe9vO11SSTAWkZKW+rP
	 PnNSQYtTbEsf5sc85iDiDVXVRA7W1j5xuZ5RVDUEZyrHG238kBubKbwWVhekqaFgWq
	 iH24b/J9BUELg==
Date: Thu, 18 Jun 2026 10:52:27 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: eprobe: read the complete FILTER_PTR_STRING
 pointer
Message-Id: <20260618105227.c58c85e9cb19bce673d9a79b@kernel.org>
In-Reply-To: <ajJbkeK0zXb8MtcS@akranes.kaiser.cx>
References: <20260615145500.2662456-1-martin@kaiser.cx>
	<20260616110910.e6420488b6a798d49951cde9@kernel.org>
	<ajJbkeK0zXb8MtcS@akranes.kaiser.cx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jun 2026 10:32:17 +0200
Martin Kaiser <martin@kaiser.cx> wrote:

> Hiramatsu-san,
> 
> thank you for reviewing my patch.
> 
> Thus wrote Masami Hiramatsu (mhiramat@kernel.org):
> 
> > Ah, this is a bit complicated. It seems to work with sched_switch event
> > as commit f04dec93466a ("tracing/eprobes: Fix reading of string fields"):
> 
> > echo 'e:sw sched/sched_switch comm=$next_comm:string' > dynamic_events
> 
> > #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > #              | |         |   |||||     |         |
> >               sh-162     [002] d..3.    54.027213: sw: (sched.sched_switch) comm="swapper/2"
> >           <idle>-0       [007] d..3.    54.034573: sw: (sched.sched_switch) comm="rcu_preempt"
> >      rcu_preempt-15      [007] d..3.    54.034589: sw: (sched.sched_switch) comm="swapper/7"
> 
> > Maybe comm is stored as a fixed string information in the event record?
> 
> Yes, this example does not execute my change.
> 
> > /sys/kernel/tracing # cat events/sched/sched_switch/format 
> > name: sched_switch
> > ID: 254
> > format:
> > 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> > 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> > 	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> > 	field:int common_pid;	offset:4;	size:4;	signed:1;
> 
> > 	field:char prev_comm[16];	offset:8;	size:16;	signed:0;
> > 	field:pid_t prev_pid;	offset:24;	size:4;	signed:1;
> > 	field:int prev_prio;	offset:28;	size:4;	signed:1;
> > 	field:long prev_state;	offset:32;	size:8;	signed:1;
> > 	field:char next_comm[16];	offset:40;	size:16;	signed:0;
> > 	field:pid_t next_pid;	offset:56;	size:4;	signed:1;
> > 	field:int next_prio;	offset:60;	size:4;	signed:1;
> 
> > But the filename is a pointer.
> 
> > /sys/kernel/tracing # cat events/syscalls/sys_enter_openat/format 
> > name: sys_enter_openat
> > ID: 705
> > format:
> > 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> > 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> > 	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> > 	field:int common_pid;	offset:4;	size:4;	signed:1;
> 
> > 	field:int __syscall_nr;	offset:8;	size:4;	signed:1;
> > 	field:int dfd;	offset:16;	size:8;	signed:0;
> > 	field:const char * filename;	offset:24;	size:8;	signed:0;
> > 	field:int flags;	offset:32;	size:8;	signed:0;
> > 	field:umode_t mode;	offset:40;	size:8;	signed:0;
> > 	field:__data_loc char[] __filename_val;	offset:48;	size:4;	signed:0;
> 
> > In this case, the filename field should use __data_loc directly instead of
> > pointing data on the ring buffer.
> 
> > Can you try 
> 
> > echo 'e syscalls.sys_enter_openat $__filename_val:string' > \
> >  		/sys/kernel/tracing/dynamic_events
> 
> > Instead?
> 
> This field is working as expected.
> 
> I still believe that the handling of FILTER_PTR_STRING is not correct. The
> pointer is stored in the ringbuffer as unsigned long and read as a char. This
> gives us a truncated pointer that cannot be dereferenced.

Ah, OK. I understand the problem.

 - ring buffer and its records should be self-contained.
 - In most cases, events use __data_loc/__rel_loc or fixed array to store
   strings.
 - only syscall events exposes the char *, which is not recommended but
   important to debug user space. (not for dereference)

The example usage of FILTER_PTR_STRING is actually using FILTER_STATIC_STRING
now, so FILTER_PTR_STRING is left broken. (hmm, but there are many
 "const char *" are used especially under rcu events...)

OK, can you update your patch description to use rcu events?

BTW, I think those also should be decoded from enum value in the events,
or use __rel_loc. Since it is not self-contained. (it's a TODO item)

> > I think better solution is fixing sycall tracer.
> 
> I would say that syscall trace is doing the right thing. The ringbuffer entry
> is a struct syscall_trace_enter, the syscall arguments are unsigned longs.
> They are written in ftrace_syscall_enter, this looks correct to me.

OK, I thought the filename points the ringbuffer, but it actually points
the user space. (saving a raw parameter values) So it is OK.

For eprobe users, it should not access to the user space data directly
because it can cause page fault in the kernel without fixup. It may work
on x86, but it doesn't work on other architecture which has separated
address space for user space. To avoid such mistake, it saves actual
string in the ringbuffer as __filename_val.

Hmm, this must be documented in eprobe example code...

> 
> A const char * syscall argument is using FILTER_PTR_STRING, the unsigned long
> argument from the ringbuffer is read as a char and then converted to a
> truncated pointer.


Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
