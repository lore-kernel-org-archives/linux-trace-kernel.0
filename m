Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887081624DF;
	Thu,  6 Feb 2025 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738849454; cv=none; b=uXN+Cj9KvT9pMktEwbdlV8BeFezdkmn+pNbys5KZ1Fb+rwMK73jfYqhph0WQq1EVuOk1LsRFZuahmj0xC+bg4gzuCypyq9SM+o6NK+/SBxVJG0quE5BVCUzAnAAhu5Ns6q+Ds+cgRyFPlqbaV5TOocznr7VGtQ1sJu8aa4kbJ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738849454; c=relaxed/simple;
	bh=x5jjL82+G2MVwgGbaI0RMtLdI5do1z0XuCzdOIuMe3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnH0Z+JjI7LfXE9riAmegeoZz6epZAg79lVOlqK1+dxmGV6AtmBBOvLDHzfrPL7FKt0iKVhu3Kyota6Hzbl3pVP+hmQLVora05bAFu4zxor7HazWf5GihfwWH8lI1BajWnsXp0oOEJEsPYiWkwUvn/wPsREPVjvWZWwzy+8pIQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1VpsuZg8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IgZKsIgD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1VpsuZg8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IgZKsIgD"
Date: Thu, 6 Feb 2025 14:44:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738849450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JOX9N9Jl0n76pdFc/nqI2BFCfJhd+hMrjbMMQLGqsc8=;
	b=1VpsuZg8LLRVUb90o3yNQvHvKhKq/roRbKG1TNnZiq0NC6CVol9aAGpArXFN69D27PvtfQ
	1zcQlQK13T5NOCPdKjb6xCjS7ELNwbItBTA02ga4035nUJJCAfjZrMgU+rT8/n4y2KSimZ
	cgkhle+PKZaXbG5li4hUzs5eSVhfaMK5dyP5EHxsXO6iYYD7C7c4VA9TnHsaTm5sUQU/E2
	Q8JXdW561XsX4jQN+98waUHVTHxdfXbC4ZNdOtONKLam+INvGgA8EAnIXrBE/6vO5Ks3W1
	RS0+HzixGmRooQjjZAyQ/ZPhD2MwIB6WvR7DtVovPynLrIUvLi8uQLw5yRpF/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738849450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JOX9N9Jl0n76pdFc/nqI2BFCfJhd+hMrjbMMQLGqsc8=;
	b=IgZKsIgDI8iE7RdCPOdW4PbzSFybQ/IoZVFKdF4n3qtsI+NI6KK/OgnpTK4zjKORcwqtTr
	tF49Z1s2GWv1K2CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	Prakash Sangappa <prakash.sangappa@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
	bharata@amd.com, raghavendra.kt@amd.com,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Konrad Wilk <konrad.wilk@oracle.com>, jgross@suse.com,
	Andrew.Cooper3@citrix.com, Vineeth Pillai <vineethrp@google.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Clark Williams <clark.williams@gmail.com>, daniel.wagner@suse.com,
	Joseph Salisbury <joseph.salisbury@oracle.com>, broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250206134408.lD_POjuG@linutronix.de>
References: <EC77D83D-DD17-4CCD-9EF6-C4C39FCE16E7@oracle.com>
 <9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org>
 <20250204220418.35949317@gandalf.local.home>
 <CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
 <20250205081635.397eacb0@gandalf.local.home>
 <CAEXW_YQY2zuU+XZjrYWLS860+PJno0nf9WAe1iPU=EyDkA7H4Q@mail.gmail.com>
 <20250206083039.0916ad24@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250206083039.0916ad24@gandalf.local.home>

On 2025-02-06 08:30:39 [-0500], Steven Rostedt wrote:
>   NEED_RESCHED_LAZY was introduced to remedy this. It would be set for
>   SCHED_OTHER tasks and NEED_RESCHED for RT tasks. If the task was holding
>   a sleeping spin lock, the NEED_RESCHED_LAZY would not preempt the running
>   task, but NEED_RESCHED would. If the SCHED_OTHER task was not holding a
>   sleeping spin_lock it would be preempted regardless.
> 
> This improved the performance of SCHED_OTHER tasks in PREEMPT_RT to be as
> good as what was in vanilla.
> 
> You see, LAZY was *created* for this purpose. Of letting the scheduler know
> that the running task is in a critical section and the timer tick should
> not preempt a SCHED_OTHER task.

This was introduced that way originally. It helped because we did not
preempt lock-owner unless we had to. This isn't the case with LAZY
as of today.
I did add a scheduling point in rt_spin_unlock() if LAZY was set and
based on few tests it was something between noise and worse. It seems
that "run to completion" is better than interrupt the kernel in the
middle whatever it is doing. "Don't preempt the lock owner" is already
handled by LAZY with the scheduling point on return to userland.

> I just wanted to extend this to SCHED_OTHER in user space too.
> 
> > 
> > Yes, I have worked on RT projects before --  you would know better
> > than anyone. :-D. But admittedly, I haven't got to work much with
> > PREEMPT_RT systems.
> 
> Just using RT policy to improve performance is not an RT project. I'm
> talking about projects that if you miss a deadline things crash. Where the
> project works very hard to make sure everything works as intended.
> 
> I'm totally against allowing SCHED_OTHER to use any feature that can delay
> an RT/DL task (unless of course it is to help those, like priority inheritance).
> 
> There's several RT folks on this thread. I wonder if any of
> them are OK with this?

If you roll your own (sched_ext) then do what you want as per you
sched-policy.
If you use this LAZY bit as a hint from userland to kernel as "please
give me up to X usec/ ticks before cutting me off" fine. It is
SCHED_OTHER vs SCHED_OTHER after all. But please don't delay a wakeup of
SCHED_FIFO/ RR/ DL because of this LAZY hint.

> -- Steve

Sebastian
