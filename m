Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E4C27713;
	Tue,  6 Jan 2026 22:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737033; cv=none; b=ofy7KOapsZ8XN3opKOdLrXb9XRwEchwhVRifReezds1MGR2Q5y4T4Yaz077UqsvlYwx1Cwlfxk9imSyYRYfyOLeWOij8GVQkY3PXwaJ/+swryYXXuDO83CqjAWhIRycEjpeiN/blHMxzA+2wfgJgWaCHuwsPGJkruRuA3MYFpkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737033; c=relaxed/simple;
	bh=NmxawiGYeZGNT2STbWv1u4GHkTgRaYlzUSmCMM56NvI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IBo6lB+vl+m+/ZWXXlf6fiRQk7dySAE/sOKM57oYMNNc0bgrjk8ALBo69vUDPJglwOUqjYqwnFuji3a4KfClB+OVX2RNBbQWV3d/hPFReOYxZ2Gq5icXBoiVLdADx8mng+Cya/l0/CtZMOPXbl9IbDBR3upkdBkeQKaxJ7c6Z8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 0AD745D5EA;
	Tue,  6 Jan 2026 22:03:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id D690F6000C;
	Tue,  6 Jan 2026 22:03:40 +0000 (UTC)
Date: Tue, 6 Jan 2026 17:04:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Tesarik <ptesarik@suse.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] ring-buffer: Use a housekeeping CPU to wake up waiters
Message-ID: <20260106170405.425f469e@gandalf.local.home>
In-Reply-To: <20260106091039.2012108-1-ptesarik@suse.com>
References: <20260106091039.2012108-1-ptesarik@suse.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D690F6000C
X-Stat-Signature: af1aa643cd8wxtjher1afkxuj3kbipku
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX180NfdP+h0JYjA+07/dQpmGCvBLbOVqfFQ=
X-HE-Tag: 1767737020-329942
X-HE-Meta: U2FsdGVkX180tmf7oAjpQsVuUGx/iTnUh2cVGgU2zBiA9g6cWQkJyCK0R4DC+2k+/2wvO2nqr8WygD+9Ty8xXT3v2fOaKG/R8n28KmQkzssI3cHqikzgx2XwiFJnqr4NnL/WiGDRSd08xzq9PP8PGcUd7OMEyXHtMFl1e7zQ57zVqnknGNWPjZkHhPWGknntA5l6wELeW58VUcnHdvNdfAHifFlm8W/e0MPJwEbUIhouaoDxJgQVJh5wbslUY5YT7++pgLMOWlPiRPR3FPINTx1uKEScXt77ocTEEu59PQYl42Qo0EBgXvyzxKFNSWMgzjEolmFn/Oo8DS73S+PE5xFdO2y8jHa8LaRpIhYTO8+c3qd9xH4SIaD1n/NyBkuw

On Tue,  6 Jan 2026 10:10:39 +0100
Petr Tesarik <ptesarik@suse.com> wrote:

> Avoid running the wakeup irq_work on an isolated CPU. Since the wakeup can
> run on any CPU, let's pick a housekeeping CPU to do the job.
> 
> This change reduces additional noise when tracing isolated CPUs. For
> example, the following ipi_send_cpu stack trace was captured with
> nohz_full=2 on the isolated CPU:
> 
>           <idle>-0       [002] d.h4.  1255.379293: ipi_send_cpu: cpu=2 callsite=irq_work_queue+0x2d/0x50 callback=rb_wake_up_waiters+0x0/0x80
>           <idle>-0       [002] d.h4.  1255.379329: <stack trace>
>  => trace_event_raw_event_ipi_send_cpu
>  => __irq_work_queue_local
>  => irq_work_queue
>  => ring_buffer_unlock_commit
>  => trace_buffer_unlock_commit_regs
>  => trace_event_buffer_commit
>  => trace_event_raw_event_x86_irq_vector
>  => __sysvec_apic_timer_interrupt
>  => sysvec_apic_timer_interrupt
>  => asm_sysvec_apic_timer_interrupt
>  => pv_native_safe_halt
>  => default_idle
>  => default_idle_call
>  => do_idle
>  => cpu_startup_entry
>  => start_secondary
>  => common_startup_64  

I take it that even with this patch you would still get the above events.
The only difference would be the "cpu=" in the event info will not be the
same as the CPU it executed on, right?

> 
> The IRQ work interrupt alone adds considerable noise, but the impact can
> get even worse with PREEMPT_RT, because the IRQ work interrupt is then
> handled by a separate kernel thread. This requires a task switch and makes
> tracing useless for analyzing latency on an isolated CPU.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>

LGTM,

I'll queue it up for the next merge window.

-- Steve
