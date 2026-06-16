Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8E237B3E4;
	Tue, 16 Jun 2026 02:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781575756; cv=none; b=gOo3ZI2mVevVBJEc98N9712O0mKNROzmAnt45oJgS37Dv8JuZHLSLLQpOEuEcCJzBbzfu0rAgPZp7yTMCAQn2ArUk07dnBgvv48L3cIikCfg9deJHs9Cp0bI4m90NCzwrzOVuQRLR3EQ1xcrfDZRdnoxCVFtPpO0OVGF//5RJjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781575756; c=relaxed/simple;
	bh=AsfpKTTXUpM0t+Nm2CvbfW73pJ4NnJK4CTD3NEvcoiE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oYwT0ANuHhV0Bm/YEvbHw3kGaiVFwLdzyc9Isy6bvcbdBW5CDi5wrDHIjYoxuR2DBYibgfMmAljk4N304P88M7xw48VFmAaPbFKSnnbKP+pGkFCqEgc+YRtyTplpzZ+Yyu6j41SPbrlwCP+R/8jrmZKKlHD8jeeRHcfFymOyvoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbbRrqaH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbbRrqaH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800531F000E9;
	Tue, 16 Jun 2026 02:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781575754;
	bh=gGWlwydiJVr/eP4nmgo4UmJQ57fnuEq7oh6mDkjJyLE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bbbRrqaHea+zATaov/nHmu3m3mNQAHo+5jYb0JTlCuv3clkPMvmW5BjTZ25FK9VKl
	 zpcGVyFAwlwNDHI6Iym9aKSQV4oMFqvGNkp+ESqxXlJlTqa2uGjSj2ipr6BKIqiiBz
	 +N1Y4jheVKkeUhxm78DGCRroWYcT2eecQT7DfUXTHZGOYZknvZekSXZK96GRhQutK2
	 lI+stblR4K9w1pdOOvEbvJiSeNPgcxEsXJPRTrLImYYTh7E31HxHP549R+YO7hMRgw
	 ASjyRYYQwofpBqKLEpeAZrFCX/zL8IUd59B9YdAUgI9gDH/fvfm5CKlcmDWTyMYSC0
	 VNftkEVe/RhBQ==
Date: Tue, 16 Jun 2026 11:09:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: eprobe: read the complete FILTER_PTR_STRING
 pointer
Message-Id: <20260616110910.e6420488b6a798d49951cde9@kernel.org>
In-Reply-To: <20260615145500.2662456-1-martin@kaiser.cx>
References: <20260615145500.2662456-1-martin@kaiser.cx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 16:54:12 +0200
Martin Kaiser <martin@kaiser.cx> wrote:

> For a char * element in an event, the FILTER_PTR_STRING filter type is
> used. When the event occurs, a pointer is stored in the ringbuffer.
> 
> If an eprobe references such a char * element of a "base event" and
> decodes the pointer as string, the pointer cannot be dereferenced.
> 
> $ echo 'e syscalls.sys_enter_openat $filename:string' > \
> 		/sys/kernel/tracing/dynamic_events
> $ trace-cmd start -e eprobes
> $ trace-cmd show
>     ... : sys_enter_openat: (syscalls.sys_enter_openat) arg1=(fault)
> 
> The problem is in get_event_field
> 
> 	val = (unsigned long)(*(char *)addr);
> 
> addr points to the position in the ringbuffer where the pointer was
> stored. We must read the complete pointer, not just the lowest byte.
> 
> Fix the assignment, make the example above work.
> 

Ah, this is a bit complicated. It seems to work with sched_switch event
as commit f04dec93466a ("tracing/eprobes: Fix reading of string fields"):

echo 'e:sw sched/sched_switch comm=$next_comm:string' > dynamic_events

#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
              sh-162     [002] d..3.    54.027213: sw: (sched.sched_switch) comm="swapper/2"
          <idle>-0       [007] d..3.    54.034573: sw: (sched.sched_switch) comm="rcu_preempt"
     rcu_preempt-15      [007] d..3.    54.034589: sw: (sched.sched_switch) comm="swapper/7"

Maybe comm is stored as a fixed string information in the event record?

/sys/kernel/tracing # cat events/sched/sched_switch/format 
name: sched_switch
ID: 254
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:char prev_comm[16];	offset:8;	size:16;	signed:0;
	field:pid_t prev_pid;	offset:24;	size:4;	signed:1;
	field:int prev_prio;	offset:28;	size:4;	signed:1;
	field:long prev_state;	offset:32;	size:8;	signed:1;
	field:char next_comm[16];	offset:40;	size:16;	signed:0;
	field:pid_t next_pid;	offset:56;	size:4;	signed:1;
	field:int next_prio;	offset:60;	size:4;	signed:1;

But the filename is a pointer.

/sys/kernel/tracing # cat events/syscalls/sys_enter_openat/format 
name: sys_enter_openat
ID: 705
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:int __syscall_nr;	offset:8;	size:4;	signed:1;
	field:int dfd;	offset:16;	size:8;	signed:0;
	field:const char * filename;	offset:24;	size:8;	signed:0;
	field:int flags;	offset:32;	size:8;	signed:0;
	field:umode_t mode;	offset:40;	size:8;	signed:0;
	field:__data_loc char[] __filename_val;	offset:48;	size:4;	signed:0;

In this case, the filename field should use __data_loc directly instead of
pointing data on the ring buffer.

Can you try 

echo 'e syscalls.sys_enter_openat $__filename_val:string' > \
 		/sys/kernel/tracing/dynamic_events

Instead?

I think better solution is fixing sycall tracer.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
