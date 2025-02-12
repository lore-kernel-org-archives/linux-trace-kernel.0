Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB69211466;
	Wed, 12 Feb 2025 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373545; cv=none; b=EHOxpCnrYFyNe5eblpwhBBXypgX4Ty+4bWcBmMl2URDyp1431U73KvdqypG8VJxEnXbo7qY41suurNkNQcThY6+t+zygAXyv+Blzw/97IwPeyAERjevaXXfgo4AAH/tVYaRNF6xkAfbzcmbgts3FFFAYxTYTaCWycIF4eht2SkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373545; c=relaxed/simple;
	bh=k51+ZVllBDY/dRfPWFVSYm6Ns4H29EQxh3+1Mn9w3Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L56YXVnCxuFrztUgDci6MkmUQkp/zBLy6ieZUxofUZccVbNKhaufGZ3THXH6pdw9xDqBVncm+VrjZDteFYR8pVvM15ydAlXcbWgyomLi0jNkWgnCMWQ/FJaGvsVHlC4T9ZyczgViwFTXidMnnI5MKQ28KHAuIgp6alB+vkpgzec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mLs/pvF0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Iy2yhe6t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mLs/pvF0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Iy2yhe6t"
Date: Wed, 12 Feb 2025 16:18:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739373541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MyC8nPx9XyKsxgGOclxuEanrBYS66ka1otwb7a83Bn8=;
	b=mLs/pvF0wNkcQ6mi8W2U0gSCYzyBuhNTofSL6cX7+ABTzDIzYitGXy9Rh0XAWVe4Qq6UbS
	GI9hs0wB2s/yVqADWEhIZGZSALez4w/3EEkFglzecIGaTWL9hjAmdNq4jhz5gfqect8IDo
	NSsedK1jWvsefTMx/jKkbpRUK1hqz/asg6yF+Yh68Zud9O6+0CJztw0xzBmsoRXtIy2GsF
	R8arANlH1NWCswyNOcwTjk8aGU9iGdE81Fea8l+8lfucvwzGLdRxJKbfJcGVOSRrre5Kgg
	WNAZyitl568HhKIAbT8BPENSKjsfMgj+utrm1rGfGWAPKC0pTDNZLbZerLxUtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739373541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MyC8nPx9XyKsxgGOclxuEanrBYS66ka1otwb7a83Bn8=;
	b=Iy2yhe6toMtrWIbp8JHYMexS9Nz6+POwywhYXhaDhFrQOQkaKTigj51UDF5FQnxNjSbPfk
	WQY/dLcjl9Ep2+Aw==
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
Message-ID: <20250212151859.pHAFF1Xj@linutronix.de>
References: <CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
 <20250205081635.397eacb0@gandalf.local.home>
 <CAEXW_YQY2zuU+XZjrYWLS860+PJno0nf9WAe1iPU=EyDkA7H4Q@mail.gmail.com>
 <20250206083039.0916ad24@gandalf.local.home>
 <20250206134408.lD_POjuG@linutronix.de>
 <20250210144321.1f5974a6@gandalf.local.home>
 <20250211082138.iqvedSfG@linutronix.de>
 <20250211102801.5b32d610@gandalf.local.home>
 <20250212121113.3nJ-kf-6@linutronix.de>
 <20250212100001.2e129b62@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250212100001.2e129b62@gandalf.local.home>

On 2025-02-12 10:00:01 [-0500], Steven Rostedt wrote:
> On Wed, 12 Feb 2025 13:11:13 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > > IIUC, today, LAZY causes all SCHED_OTHER tasks to act more like
> > > PREEMPT_NONE. Is that correct?  
> > 
> > Well. First sched-tick will set the LAZY bit, the second sched-tick
> > forces a resched.
> > On PREEMPT_NONE the sched-tick would be set NEED_RESCHED while nothing
> > will force a resched until the task decides to do schedule() on its own.
> > So it is slightly different for kernel threads.
> 
> Except that it should schedule on a cond_resched() and the point of adding
> LAZY was to get rid of all the cond_resched() which in turn gets rid of the
> need for PREEMPT_NONE. Which was what I was getting at. That PREEMPT_LAZY
> is really just NONE without the need to sprinkle cond_resched() all over
> the kernel. Instead of having cond_resched(), we just wait for the next
> tick.

I would argue that we want to get out of the kernel asap and not
schedule() if we stumble upon cond_resched().

> > Unless we talk about userland, here we would have a resched on the
> > return to userland after the sched-tick LAZY or NONE does not matter.
> > 
> > > Now that the PREEMPT_RT is not one of the preemption selections, when you
> > > select PREEMPT_RT, you can pick between CONFIG_PREEMPT and
> > > CONFIG_PREEMPT_LAZY. Where CONFIG_PREEMPT will preempt the kernel at the
> > > scheduler tick if preemption is enabled and CONFIG_PREEMPT_LAZY will
> > > not preempt the kernel on a scheduler tick and wait for exit to user space.  
> > 
> > This is not specific to RT but FULL vs LAZY. But yes. However the second
> 
> Not true. PREEMPT_RT use to enable PREEMPT_FULL as well (it would preempt
> everywhere). The issue we found was that spin_locks which would not have
> been preempted by just FULL alone were being preempted when RT was enabled.
> That caused a lot more contention with spin locks in the kernel.
> 
> That is PREEMPT_RT with PREEMPT_FULL will have a noticeable performance
> degradation compared to just PREEMPT_FULL alone.

okay.

> > sched-tick will force preemption point even without the
> > exit-to-userland.
> > 
> 
> My question still stands. Have you compared PREEMPT_FULL with and without
> PREEMPT_RT?

No I have not.

> -- Steve

Sebastian
