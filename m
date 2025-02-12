Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BC4205AAF;
	Wed, 12 Feb 2025 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739362283; cv=none; b=NCJvq+00y24ttUastksLh/TCmCEyRWKoS9djNlb3+wQwZSOu4AdTV2OXaQ2jKkMl+ms0qqIx6Q+s05EVToDTCezeqSiwrg2ySzUHDGWbQYdNBTVh3odq4onhx7UOYhKw65+2pMERmoxhMvDBI3QiRrnChqouxYQ+5s2ytUSMdRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739362283; c=relaxed/simple;
	bh=hfRnQRhXFDPkdEJgmQjQac1uhk3WIaBMF/BbN2Omgr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boM0tGAbmWEhb4v541R3PWL/YocOerff4R4ezMRQaRFMHXlS8zc+jetOI6YmjgKiCLn5pIh/8yllRoYqn8YyGSMwhUeE3iFp30/7OSMs98e74RK/ydJ2kLK9m0JdwMVA8YkqSrOdRwrF0bnVCwaw0oT6kvskQC9JJ+xKwAhcxr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uT5v+mE7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HM5DkrZ9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uT5v+mE7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HM5DkrZ9"
Date: Wed, 12 Feb 2025 13:11:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739362278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7TNBT0J/OEy8YxJkvBLL8wlR8TSxY9KLsjAwzg3RD5Y=;
	b=uT5v+mE7N7yeiBRcXKtyRYO25ZC9j8Al4cOBRuno5OOctcw+aDUpqUPq92BdBifezgbN4F
	9u+a5LXCadMGf6UplzQwmBaCwNvZ5Z2wdP5hJCIkSFhkv0JGifwTvkclQTGEn72aqmgOPP
	GysGRoHIRsVAufNid/6utAkCZPUlQcsr1BljCaF65CDGDOhTIW0i1iKUw6n2mJ9lVBw61J
	DOnEtcQmoUCJd1TfszpTIgI/Re+kop87GPKG+ky1DKH14ZPhTwceihO1vQfpZa8pwxb+kV
	q/CWy/BLAU5VYT9/uUUfIrB/vSHzRklLEfvz0dUbuGM4vK2Cotxm256RPucmNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739362278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7TNBT0J/OEy8YxJkvBLL8wlR8TSxY9KLsjAwzg3RD5Y=;
	b=HM5DkrZ9tyvbTSgICy7zFN4UfAQH4az1YxHKFMneOnIGHrh2cP4SqEkoDBPucxmk1g+KTF
	o8BHvK+H7Orm/QAg==
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
Message-ID: <20250212121113.3nJ-kf-6@linutronix.de>
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
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250211102801.5b32d610@gandalf.local.home>

On 2025-02-11 10:28:01 [-0500], Steven Rostedt wrote:
> On Tue, 11 Feb 2025 09:21:38 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > We don't follow this behaviour exactly today.
> > 
> > Adding this behaviour back vs the behaviour we have now, doesn't seem to
> > improve anything at visible levels. We don't have a counter but we can
> > look at the RCU nesting counter which should be zero once locks have
> > been dropped. So this can be used for testing.
> > 
> > But as I said: using "run to completion" and preempt on the return
> > userland rather than once the lazy flag is seen and all locks have been
> > released appears to be better.
> > 
> > It is (now) possible that you run for a long time and get preempted
> > while holding a spinlock_t. It is however more likely that you release
> > all locks and get preempted while returning to userland.
> 
> IIUC, today, LAZY causes all SCHED_OTHER tasks to act more like
> PREEMPT_NONE. Is that correct?

Well. First sched-tick will set the LAZY bit, the second sched-tick
forces a resched.
On PREEMPT_NONE the sched-tick would be set NEED_RESCHED while nothing
will force a resched until the task decides to do schedule() on its own.
So it is slightly different for kernel threads.

Unless we talk about userland, here we would have a resched on the
return to userland after the sched-tick LAZY or NONE does not matter.

> Now that the PREEMPT_RT is not one of the preemption selections, when you
> select PREEMPT_RT, you can pick between CONFIG_PREEMPT and
> CONFIG_PREEMPT_LAZY. Where CONFIG_PREEMPT will preempt the kernel at the
> scheduler tick if preemption is enabled and CONFIG_PREEMPT_LAZY will
> not preempt the kernel on a scheduler tick and wait for exit to user space.

This is not specific to RT but FULL vs LAZY. But yes. However the second
sched-tick will force preemption point even without the
exit-to-userland.

> Sebastian,
> 
> It appears you only tested the CONFIG_PREEMPT_LAZY selection. Have you
> tested the difference of how CONFIG_PREEMPT behaves between PREEMPT_RT and
> no PREEMPT_RT? I think that will show a difference like we had in the past.

Not that I remember testing PREEMPT vs PREEMPT_RT. I remember people
complained about high networking load on RT which become visible due to
threaded interrupts (as in top) while for non-RT it was more or less
hidden and not clearly visible due to selected accounting. The network
performance was mostly the same as far as I remember (that is gbit).

> I can see people picking both PREEMPT_RT and CONFIG_PREEMPT (Full), but
> then wondering why their non RT tasks are suffering from a performance
> penalty from that.

We might want to opt in for lazy by default on RT. That was the case in
the RT queue until it was replaced with PREEMPT_AUTO.
But then why not use LAZY in favour of PREEMPT. Mike had numbers
   https://lore.kernel.org/all/9df22ebbc2e6d426099bf380477a0ed885068896.camel@gmx.de/

where LAZY had mostly the voluntary performance with less context
switches than preempt. Which means also without the need for
cond_resched() and friends.

> -- Steve

Sebastian
