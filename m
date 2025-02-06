Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1421C701B;
	Thu,  6 Feb 2025 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851604; cv=none; b=K0anJOdB3P/0SUk0ra5CG3tJmEYCMSFHaHvxpEMWGV04gH1GYbxe7FtBm/pK7tTmySUQyt2LssLamx/vqaPJFQrHZlVrN0DVx/Mp82f4gtilBf1/LW71bpI38DH51Lw6vZE7iJPnkRIpsSGB/zmZXDkzz6Rxz1oqMsAJzDe8VZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851604; c=relaxed/simple;
	bh=8zhiOVMWM2UTqpclKsMYw9zAEMLFGiqSBOPssYpwBi8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vwp3c6mzvyeKxULOLFJKKMYH/1zskysoTiSGZ1fPmICQAYdWl2hZToGyPAyLuJndzCSR87WgPIJ4g7EH7/FhUyaSRhLJoiWyqbK3otNN5+3nagJhJEi/Fd7Lg5GPJV3NwWGnLdzKqKEBxwhB3yyd1rtv9xn/Uydxx2fUK1eQ89g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90427C4CEE2;
	Thu,  6 Feb 2025 14:20:00 +0000 (UTC)
Date: Thu, 6 Feb 2025 09:20:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Joel Fernandes
 <joel@joelfernandes.org>, Prakash Sangappa <prakash.sangappa@oracle.com>,
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
Message-ID: <20250206092041.3fe52ff5@gandalf.local.home>
In-Reply-To: <20250206135744.GQ7145@noisy.programming.kicks-ass.net>
References: <EC77D83D-DD17-4CCD-9EF6-C4C39FCE16E7@oracle.com>
	<9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org>
	<20250204220418.35949317@gandalf.local.home>
	<CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
	<20250205081635.397eacb0@gandalf.local.home>
	<CAEXW_YQY2zuU+XZjrYWLS860+PJno0nf9WAe1iPU=EyDkA7H4Q@mail.gmail.com>
	<20250206083039.0916ad24@gandalf.local.home>
	<20250206134408.lD_POjuG@linutronix.de>
	<20250206134859.GP7145@noisy.programming.kicks-ass.net>
	<20250206135353.i1tp4vDv@linutronix.de>
	<20250206135744.GQ7145@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 14:57:44 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Right, but so what? Same delay will happen if interrupt fires in the
> middle of a preempt_disable() region.
> 
> Or if interrupt gets pending while interrupts are disabled, except your
> trace will not show that.
> 
> Your worst case response time isn't affected. That's all that matters.

So now if a task has this set, and an interrupt goes off and wakes an RT
task, not only is the time of the interrupt the latency of the RT task, but
also this extension of the SCHED_OTHER task.

That is, where it use to be:

             event   RT task scheduled
               |      |
               v      v
 time: |-------+-+----+--
                 ^
                 |
             interrupt

If the interrupt triggered just as the task set this bit, we then have:

             event   set Xus    RT task scheduled
               |      |          |
               v      v          v
 time: |-------+-+----+-------+--+
                 ^            ^
                 |            |
             interrupt    Xus timer triggered


This adds on *top* of the current latency, and is not just by itself.

Yes, this may not happen often, but in RT we very much do care about the
worst case scenarios. (That's the difference between an RT project and a
project that just uses RT).

-- Steve
