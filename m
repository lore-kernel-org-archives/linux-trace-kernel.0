Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8508E3101A7;
	Wed,  1 Apr 2026 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074700; cv=none; b=oUhz3x/Pp4U+PpuU1faXzKRTDgO19PVOi1zNdZny+RXf5Oy6vx6LFXPc2lez/ZAjq88iecP0hEKJj2O5wCBMXXvigIrL6g7iUUKx6j8qHo0o2eL5xrrL59TxF3lrxnVUcYY/jYvQvPUpwybpRo75mF0PByem2NzhAKzIPGS/QRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074700; c=relaxed/simple;
	bh=d6luXh51qVtC5cVvZCBgR6vSRGuz4yVhS9wCbiE9RIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VEAud3IsB0SXtrOyRZaGNKueDCpwpvaqr8pDQ8VZH2gKS2LCv0C3Wzim55R7J2K1LEBStGnTPaNDUk+V7aB1JSbWKuVsR33mv3FtGAzh2hyf2bwP/mgkGx2IBoVnBvgHpQNnx5X8pGNdB9loQhwIxIdFXk1rswHXHVzY5sKqTrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6FOMx8W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6FOMx8W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2601C4CEF7;
	Wed,  1 Apr 2026 20:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775074700;
	bh=d6luXh51qVtC5cVvZCBgR6vSRGuz4yVhS9wCbiE9RIU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r6FOMx8W7J8aEEqXAbq08RPKJqYljvLxSraB7H2/jr6V7upDK8uq18SYJdVO3Oc8T
	 rikiVlbriIq0E5XpE/uAoZPlS5hr2gxOPHPEDWcQhMntk5qZLYuhuCckcjwGhNoJhF
	 8D1k2qndWs79Ja0ixJAJUblRSKwJhna3FTiv9ujSpgOBsxwm2md/vW0W3RJ8yaWpku
	 uLvVdWB9tdg+z/bezyiBSzbcE4x9vYBebD+4PCnljmtLi8OxaN1kufIIITIEP6tj2G
	 GCPQ/ufvHElLqGrthPpawI2nR+1GxFDXia2g4sfmKF47nw/nw8lgUdRQ91fqWh3mq1
	 aXM6h2d1UYSsA==
Date: Wed, 1 Apr 2026 16:19:19 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Brian
 Geffon <bgeffon@google.com>, John Stultz <jstultz@google.com>, Ian Rogers
 <irogers@google.com>, Suleiman Souhlal <suleiman@google.com>
Subject: Re: [PATCH v3 0/3] tracing: Read user data from futex system call
 trace event
Message-ID: <20260401161919.147355bf@gandalf.local.home>
In-Reply-To: <87zf3m7a0o.ffs@tglx>
References: <20260331181349.062575155@kernel.org>
	<87zf3m7a0o.ffs@tglx>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 01 Apr 2026 21:31:19 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, Mar 31 2026 at 14:13, Steven Rostedt wrote:
> > We are looking at the performance of futexes and require a bit more
> > information when tracing them.
> >
> > The two patches here extend the system call reading of user space to  
> 
> s/two/three/ :)

Ah v1 had only two patches and this was cut and pasted from there.

> 
> I understand what you are trying to achieve, but do we really need all
> the complexity of decoding and pretty printing in the kernel?

You could say the same for most tracepoints. ;-)

> 
> Isn't it sufficient to store and expose the raw data and use post
> processing to make it readable?

Yes this is possible, and will also work too, as libtraceevent will be
updated to parse the raw data.

> 
> I've been doing complex futex analysis for two decades with a small set
> of python scripts which translate raw text or binary trace data into
> human readable information.
> 
> I agree that it's useful to have the actual timeout value and other data
> which is missing today, but that still does not require all this
> customized printing.
> 
> The initial idea of having at least some information about the data
> entry (type, meaning etc.) in $event/format and use that for kernel text
> output and for user space tools to analyze a binary trace has been
> definitely the right way to go.
> 
> But that now deviates because $event/format cannot carry that
> information you translate to in the kernel. It will still describe raw
> event data, no?

It still shows a bit:

name: sys_enter_futex
ID: 592
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:int __syscall_nr;	offset:8;	size:4;	signed:1;
	field:u32 * uaddr;	offset:16;	size:8;	signed:0;
	field:int op;	offset:24;	size:8;	signed:0;
	field:u32 val;	offset:32;	size:8;	signed:0;
	field:const struct __kernel_timespec * utime;	offset:40;	size:8;	signed:0;
	field:u32 * uaddr2;	offset:48;	size:8;	signed:0;
	field:u32 val3;	offset:56;	size:8;	signed:0;
	field:u32 __value;	offset:64;	size:4;	signed:0;
	field:u32 __value2;	offset:68;	size:4;	signed:0;
	field:unsigned long __ts1;	offset:72;	size:8;	signed:0;
	field:unsigned long __ts2;	offset:80;	size:8;	signed:0;

print fmt: "uaddr: 0x%lx (0x%lx) cmd=%s%s%s  val: 0x%x timeout/val2: 0x%llx (%lu.%lu) uaddr2: 0x%lx (0x%lx) val3: 0x%x",  REC->uaddr, REC->__value,  __print_symbolic(REC->op & 0xfffffe7f, {0, "FUTEX_WAIT"} ,{1, "FUTEX_WAKE"} ,{2, "FUTEX_FD"} ,{3, "FUTEX_REQUEUE"} ,{4, "FUTEX_CMP_REQUEUE"} ,{5, "FUTEX_WAKE_OP"} ,{6, "FUTEX_LOCK_PI"} ,{7, "FUTEX_UNLOCK_PI"} ,{8, "FUTEX_TRYLOCK_PI"} ,{9, "FUTEX_WAIT_BITSET"} ,{10, "FUTEX_WAKE_BITSET"} ,{11, "FUTEX_WAIT_REQUEUE_PI"} ,{12, "FUTEX_CMP_REQUEUE_PI"} ,{13, "FUTEX_LOCK_PI2"} ),  (REC->op & 128) ? "|FUTEX_PRIVATE_FLAG" : "", (REC->op & 256) ? "|FUTEX_CLOCK_REALTIME" : "", REC->val, REC->utime, REC->__ts1, REC->__ts2, REC->uaddr, REC->__value2, REC->val3

> 
> So why not keeping the well known and working solution of identifying
> the data in the format, print it raw and leave the post processing to
> user space tools in case there is a need.
> 
> You actually make it harder to do development. Look at the patch series
> related to robust futexes:
> 
>   https://lore.kernel.org/lkml/20260330114212.927686587@kernel.org/
> 
> So your decoding:
> 
> >  sys_futex(uaddr: 0x56196292e830 (0), FUTEX_WAKE|FUTEX_PRIVATE_FLAG)  
> 
> fails to decode the new flag and the usage of uaddr2 unless I go and add
> it in the first place _before_ working on the code. Right now it is just
> printing op as a hex value and it just works when a new bit is added.
> 
> Stick 100 lines of python into tools/tracing and be done with it. I'm
> happy to contribute to that.

Well, it would be updated for trace-cmd not tools/tracing.

> 
> Aside of that:
> 
>   Putting the decoder (futex_print_syscall) into the futex code itself
>   is admittedly a smart move to offload the work of keeping that up to
>   date to the people who are actually working on futexes.
> 
> TBH, I'm not interested to deal with that at all. If you want this
> ftrace magic pretty printing, then stick it into kernel/trace or if
> there is a real technical reason (hint there is none) into
> kernel/futex/trace.c and take ownership of it. But please do not burden
> others with your fancy toy of the day.

v1 kept it all within the tracing subsystem, but Peter suggested that it be
closer to the syscall:

   https://lore.kernel.org/all/20260304090748.GO606826@noisy.programming.kicks-ass.net/

I'm happy to put it back and maintain it separately.

Or I can just keep the simple bits (the reading of user space), and not do
all the more fancy formatting. Basically dropping patch 2 and 3.

I've been using trace-cmd start / show for testing. But I could also move
the logic to libtraceevent, which would require using trace-cmd record
instead.

How much are you against the full series? Are you OK with it if it stays
within the tracing subsystem? Or would you prefer just keeping with patch 1
and dropping the other patches and doing that work in libtraceevent?

-- Steve
