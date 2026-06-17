Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E2F3D0BE5;
	Wed, 17 Jun 2026 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781685149; cv=none; b=iafqMdIcBtfozcbkJvHrL+p9nYvrV93UCQF3BjYxUY7FPoOZX2c44LDBxv71GjDmsdqmorccydrLKHsfl4ZFb1CBKX4F4LUF8QdTZxnK6pEJ7hd1CEjuFnJwdveHGr7d83lrNT4KNwPqISYxFTDH4+fI6/KHTNcEK+MKF8Ll23c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781685149; c=relaxed/simple;
	bh=qNT1/5SdXLOcFK9k7ZzeuNAhN0q97L8o3T8BZ5bdioc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEELhg9bkubPfzswuS44Ez3yUsJfKeT62OHkt3o11TcXi0yh9wx7Qvo82AOAxgfxXFMojlEGNIYR32eW+4e4sMSoF8M1EoEZo6mn3FO9Zyc72/+ZXIwZ3y0UAn0EOzZvYd5kkucQA+OOLE0ketOJV5GOqjbY9pii4RXWpTrSznk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from martin by akranes.kaiser.cx with local (Exim 4.98.2)
	(envelope-from <martin@akranes.kaiser.cx>)
	id 1wZlh3-00000000vex-2Mse;
	Wed, 17 Jun 2026 10:32:17 +0200
Date: Wed, 17 Jun 2026 10:32:17 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: eprobe: read the complete FILTER_PTR_STRING
 pointer
Message-ID: <ajJbkeK0zXb8MtcS@akranes.kaiser.cx>
References: <20260615145500.2662456-1-martin@kaiser.cx>
 <20260616110910.e6420488b6a798d49951cde9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616110910.e6420488b6a798d49951cde9@kernel.org>
Sender: "Martin Kaiser,,," <martin@akranes.kaiser.cx>

Hiramatsu-san,

thank you for reviewing my patch.

Thus wrote Masami Hiramatsu (mhiramat@kernel.org):

> Ah, this is a bit complicated. It seems to work with sched_switch event
> as commit f04dec93466a ("tracing/eprobes: Fix reading of string fields"):

> echo 'e:sw sched/sched_switch comm=$next_comm:string' > dynamic_events

> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>               sh-162     [002] d..3.    54.027213: sw: (sched.sched_switch) comm="swapper/2"
>           <idle>-0       [007] d..3.    54.034573: sw: (sched.sched_switch) comm="rcu_preempt"
>      rcu_preempt-15      [007] d..3.    54.034589: sw: (sched.sched_switch) comm="swapper/7"

> Maybe comm is stored as a fixed string information in the event record?

Yes, this example does not execute my change.

> /sys/kernel/tracing # cat events/sched/sched_switch/format 
> name: sched_switch
> ID: 254
> format:
> 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> 	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> 	field:int common_pid;	offset:4;	size:4;	signed:1;

> 	field:char prev_comm[16];	offset:8;	size:16;	signed:0;
> 	field:pid_t prev_pid;	offset:24;	size:4;	signed:1;
> 	field:int prev_prio;	offset:28;	size:4;	signed:1;
> 	field:long prev_state;	offset:32;	size:8;	signed:1;
> 	field:char next_comm[16];	offset:40;	size:16;	signed:0;
> 	field:pid_t next_pid;	offset:56;	size:4;	signed:1;
> 	field:int next_prio;	offset:60;	size:4;	signed:1;

> But the filename is a pointer.

> /sys/kernel/tracing # cat events/syscalls/sys_enter_openat/format 
> name: sys_enter_openat
> ID: 705
> format:
> 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> 	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> 	field:int common_pid;	offset:4;	size:4;	signed:1;

> 	field:int __syscall_nr;	offset:8;	size:4;	signed:1;
> 	field:int dfd;	offset:16;	size:8;	signed:0;
> 	field:const char * filename;	offset:24;	size:8;	signed:0;
> 	field:int flags;	offset:32;	size:8;	signed:0;
> 	field:umode_t mode;	offset:40;	size:8;	signed:0;
> 	field:__data_loc char[] __filename_val;	offset:48;	size:4;	signed:0;

> In this case, the filename field should use __data_loc directly instead of
> pointing data on the ring buffer.

> Can you try 

> echo 'e syscalls.sys_enter_openat $__filename_val:string' > \
>  		/sys/kernel/tracing/dynamic_events

> Instead?

This field is working as expected.

I still believe that the handling of FILTER_PTR_STRING is not correct. The
pointer is stored in the ringbuffer as unsigned long and read as a char. This
gives us a truncated pointer that cannot be dereferenced.

> I think better solution is fixing sycall tracer.

I would say that syscall trace is doing the right thing. The ringbuffer entry
is a struct syscall_trace_enter, the syscall arguments are unsigned longs.
They are written in ftrace_syscall_enter, this looks correct to me.

A const char * syscall argument is using FILTER_PTR_STRING, the unsigned long
argument from the ringbuffer is read as a char and then converted to a
truncated pointer.

Thanks,
Martin
