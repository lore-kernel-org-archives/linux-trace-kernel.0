Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794761F0E4E;
	Tue, 11 Feb 2025 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287680; cv=none; b=G4/ChQyQoxYri+uG43ta2tYeT47f73ltFK1I20Rr6ZDZ32Rkch74B0cm59Rhf7/j0XrRu35eOIodUW7tskBITKAFBbBtqNNSyoYDzfQiI6bgobhZtrn/J+4v1l5+8NeiOkVNO7oZt7xiPyZovG0bsQ6Xg+EDLXivBT9A7JAgESc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287680; c=relaxed/simple;
	bh=ZOFCgQqHmE5mPF2tRhaxFQ1i76aEb/IlE1b/4Rfz6EI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AXanHUXNnU3TVDqhHHOtgmScs9C2bHfywozN/nZ3NLB+fsEcnbfpUrH0/cvcSL2zaofH8SPw/l8dQ+VV03gEKSIcyrWi+F0LbGXDZ4hqcaLQIsEX5jKwyKPMH33JofcKKm6ETceBGmSB0P9ZuIFK3TtT7UP7dbpqbeZHVXdHukQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650FAC4CEDD;
	Tue, 11 Feb 2025 15:27:56 +0000 (UTC)
Date: Tue, 11 Feb 2025 10:28:01 -0500
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
Message-ID: <20250211102801.5b32d610@gandalf.local.home>
In-Reply-To: <20250211082138.iqvedSfG@linutronix.de>
References: <EC77D83D-DD17-4CCD-9EF6-C4C39FCE16E7@oracle.com>
	<9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org>
	<20250204220418.35949317@gandalf.local.home>
	<CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
	<20250205081635.397eacb0@gandalf.local.home>
	<CAEXW_YQY2zuU+XZjrYWLS860+PJno0nf9WAe1iPU=EyDkA7H4Q@mail.gmail.com>
	<20250206083039.0916ad24@gandalf.local.home>
	<20250206134408.lD_POjuG@linutronix.de>
	<20250210144321.1f5974a6@gandalf.local.home>
	<20250211082138.iqvedSfG@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 09:21:38 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> We don't follow this behaviour exactly today.
> 
> Adding this behaviour back vs the behaviour we have now, doesn't seem to
> improve anything at visible levels. We don't have a counter but we can
> look at the RCU nesting counter which should be zero once locks have
> been dropped. So this can be used for testing.
> 
> But as I said: using "run to completion" and preempt on the return
> userland rather than once the lazy flag is seen and all locks have been
> released appears to be better.
> 
> It is (now) possible that you run for a long time and get preempted
> while holding a spinlock_t. It is however more likely that you release
> all locks and get preempted while returning to userland.

IIUC, today, LAZY causes all SCHED_OTHER tasks to act more like
PREEMPT_NONE. Is that correct?

Now that the PREEMPT_RT is not one of the preemption selections, when you
select PREEMPT_RT, you can pick between CONFIG_PREEMPT and
CONFIG_PREEMPT_LAZY. Where CONFIG_PREEMPT will preempt the kernel at the
scheduler tick if preemption is enabled and CONFIG_PREEMPT_LAZY will
not preempt the kernel on a scheduler tick and wait for exit to user space.

Sebastian,

It appears you only tested the CONFIG_PREEMPT_LAZY selection. Have you
tested the difference of how CONFIG_PREEMPT behaves between PREEMPT_RT and
no PREEMPT_RT? I think that will show a difference like we had in the past.

I can see people picking both PREEMPT_RT and CONFIG_PREEMPT (Full), but
then wondering why their non RT tasks are suffering from a performance
penalty from that.

-- Steve
