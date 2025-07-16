Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51EA2F49F2;
	Wed, 16 Jul 2025 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669521; cv=none; b=KJXlEmdHRU+kh3OBLzqYv7WoGYeLdD0dnyajTXbiP23p/JxpbGCkwWHiaz8BmKAB0eX24ncEBDOnLTAdchgiurfW3+CMxBSTRTHSBTdhm6dq7gOn71YErCh2aPPz9R3fthlfs6PX9+J20FxJfu1PQhKjRVfdJxcwjvnCfe9NsBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669521; c=relaxed/simple;
	bh=pJGLGknho+j+d6pWO0haLRIvL9BBaXCyJHMvVYM3sfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHqwr6r8Etd0tR5V48gjXfHNyNBUeug+7PaddgFiO+CUDjjZji1mLa+fNRaW8RXnH4RgowIBvVIgz3QjFBhOH1P7Atuu1+TcXkjy2a/5YYdcx00iN9cg2caY+zYrxRFgXt0uPHfV+bd0EfjMMGeD35KZbzzRTTWsROevswr8Tck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WhCaRL7G; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WhCaRL7G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YJ31wuGAs8TcqXb+Gxge288ftyQZu98ZA6TQhn6DLtw=; b=WhCaRL7GpAM1Spp5z2W/JtPBhQ
	vzBV6v0C3Jt8uI84bVQMaH93KB62qA+nYfM1akEGORcJW5whoWqT0x+VE/F5HSIF3WeHq1JlRpgpa
	IjthFASYbTN5R2LcX2mcI4mKNY+3n4/r/wUFqR8ly4hsXgIOIuhfcYLRdfOh7o+uXvwhonxWJxhrz
	2lVdU2/YvKo5h9OaBa+TdEl5Lr4MiWPIeuuicu0MWPBFGSS3nzkKEV4MltQ3VBDHPU4hoQkk1G46E
	CXbITtD67km8Z4IJ8F8izWgqCtl69z3s7cUF4gB7iorNr9/45N0+S01+Al3Z6FEnt3/yrXnrMyqYt
	I+9xgPVw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc1P7-0000000GYu5-0Uwa;
	Wed, 16 Jul 2025 12:38:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 124D5300186; Wed, 16 Jul 2025 14:38:32 +0200 (CEST)
Date: Wed, 16 Jul 2025 14:38:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 12/17] sched: Adapt sched tracepoints for RV task model
Message-ID: <20250716123832.GW1613200@noisy.programming.kicks-ass.net>
References: <20250715071434.22508-1-gmonaco@redhat.com>
 <20250715071434.22508-13-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715071434.22508-13-gmonaco@redhat.com>

On Tue, Jul 15, 2025 at 09:14:29AM +0200, Gabriele Monaco wrote:
> Add the following tracepoints:
> * sched_set_need_resched(tsk, cpu, tif)
>     Called when a task is set the need resched [lazy] flag
> * sched_switch_vain(preempt, tsk, tsk_state)
>     Called when a task is selected again during __schedule
>     i.e. prev == next == tsk : no real context switch

> @@ -6592,6 +6598,7 @@ static bool try_to_block_task(struct rq *rq, struct task_struct *p,
>  	int flags = DEQUEUE_NOCLOCK;
>  
>  	if (signal_pending_state(task_state, p)) {
> +		trace_sched_set_state_tp(p, TASK_RUNNING, true);
>  		WRITE_ONCE(p->__state, TASK_RUNNING);
>  		*task_state_p = TASK_RUNNING;
>  		return false;

I'm confused on the purpose of this. How does this relate to say the
wakeup in signal_wake_up_state() ?

> @@ -6786,6 +6793,7 @@ static void __sched notrace __schedule(int sched_mode)
>  		rq = context_switch(rq, prev, next, &rf);
>  	} else {
>  		rq_unpin_lock(rq, &rf);
> +		trace_sched_switch_vain_tp(preempt, prev, prev_state);
>  		__balance_callbacks(rq);
>  		raw_spin_rq_unlock_irq(rq);
>  	}

Hurmph... don't you already have this covered by: trace_sched_exit_tp() ?

Specifically, the only case where is_switch := false, is this case.

