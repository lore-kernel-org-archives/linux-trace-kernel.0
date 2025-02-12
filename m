Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1982101BE;
	Wed, 12 Feb 2025 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739372398; cv=none; b=gIqvm16ly1hQ2ceDYtmD5/BEm2OVKjVIJurLfrCAk4878K5LumKLcyh1jUBLMhHEIERDDRQr5Sgo4yW5SdG/Lnazc+A6tpZzvEhbslU3RJAN0UI1N3UgD1EURvy+jtGsGn+gWoEspF250cejab6L/oC6cGDaAaXdn50eSwoDdnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739372398; c=relaxed/simple;
	bh=JPZO5PznLFdhUuUvdW0D6DAedUoHfJO7jNY831mmzMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFDEiEjgoWJtMpqXDmXFpxRUqNqh0jCcWRPyg/0dme1GMeF6ACtQ422s5L4R/wVn3OuLsAfiNgIGd7bte9P8VhC85O2qUXnwrStJFnqAaJpHMNuSgDj//OD1LbOjKBLJ64P9fA85JfHENjEs+qM9zQiidAHSQRQM4YIrqyTQSW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F070BC4CEDF;
	Wed, 12 Feb 2025 14:59:53 +0000 (UTC)
Date: Wed, 12 Feb 2025 10:00:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Joel Fernandes <joel@joelfernandes.org>, Prakash Sangappa
 <prakash.sangappa@oracle.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Ankur Arora <ankur.a.arora@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, luto@kernel.org,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jon.grimm@amd.com, bharata@amd.com,
 raghavendra.kt@amd.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Konrad Wilk <konrad.wilk@oracle.com>, jgross@suse.com,
 Andrew.Cooper3@citrix.com, Vineeth Pillai <vineethrp@google.com>, Suleiman
 Souhlal <suleiman@google.com>, Ingo Molnar <mingo@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Clark Williams
 <clark.williams@gmail.com>, daniel.wagner@suse.com, Joseph Salisbury
 <joseph.salisbury@oracle.com>, broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250212100001.2e129b62@gandalf.local.home>
In-Reply-To: <20250212121113.3nJ-kf-6@linutronix.de>
References: <9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org>
	<20250204220418.35949317@gandalf.local.home>
	<CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
	<20250205081635.397eacb0@gandalf.local.home>
	<CAEXW_YQY2zuU+XZjrYWLS860+PJno0nf9WAe1iPU=EyDkA7H4Q@mail.gmail.com>
	<20250206083039.0916ad24@gandalf.local.home>
	<20250206134408.lD_POjuG@linutronix.de>
	<20250210144321.1f5974a6@gandalf.local.home>
	<20250211082138.iqvedSfG@linutronix.de>
	<20250211102801.5b32d610@gandalf.local.home>
	<20250212121113.3nJ-kf-6@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 13:11:13 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > IIUC, today, LAZY causes all SCHED_OTHER tasks to act more like
> > PREEMPT_NONE. Is that correct?  
> 
> Well. First sched-tick will set the LAZY bit, the second sched-tick
> forces a resched.
> On PREEMPT_NONE the sched-tick would be set NEED_RESCHED while nothing
> will force a resched until the task decides to do schedule() on its own.
> So it is slightly different for kernel threads.

Except that it should schedule on a cond_resched() and the point of adding
LAZY was to get rid of all the cond_resched() which in turn gets rid of the
need for PREEMPT_NONE. Which was what I was getting at. That PREEMPT_LAZY
is really just NONE without the need to sprinkle cond_resched() all over
the kernel. Instead of having cond_resched(), we just wait for the next
tick.

> 
> Unless we talk about userland, here we would have a resched on the
> return to userland after the sched-tick LAZY or NONE does not matter.
> 
> > Now that the PREEMPT_RT is not one of the preemption selections, when you
> > select PREEMPT_RT, you can pick between CONFIG_PREEMPT and
> > CONFIG_PREEMPT_LAZY. Where CONFIG_PREEMPT will preempt the kernel at the
> > scheduler tick if preemption is enabled and CONFIG_PREEMPT_LAZY will
> > not preempt the kernel on a scheduler tick and wait for exit to user space.  
> 
> This is not specific to RT but FULL vs LAZY. But yes. However the second

Not true. PREEMPT_RT use to enable PREEMPT_FULL as well (it would preempt
everywhere). The issue we found was that spin_locks which would not have
been preempted by just FULL alone were being preempted when RT was enabled.
That caused a lot more contention with spin locks in the kernel.

That is PREEMPT_RT with PREEMPT_FULL will have a noticeable performance
degradation compared to just PREEMPT_FULL alone.

> sched-tick will force preemption point even without the
> exit-to-userland.
> 

My question still stands. Have you compared PREEMPT_FULL with and without
PREEMPT_RT?

-- Steve
