Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8645826BDA8;
	Tue, 11 Feb 2025 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739262104; cv=none; b=meosbq3Zki6P58fAhjoRgn4r6p9210TYAAK7ZrPHCe4r2AjROq+4CwOwqF+NAJKkMaOJrXofOwSni3nlY5RqHsUvKNuaS3OaSCCYTZidVAPd3UIICV7XtvJPRsMEGHC+Udew7MaZjNUpn+sX3WpBkxwDD6B00K7ypbh+T+1Im2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739262104; c=relaxed/simple;
	bh=F/wyFTGIS4w4RjHEHqyY2nYD2HSLonYYUIcDxUOuYe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4hairrs8IyuZ7bqUQiBFAY3DWwbUTjtGQH9K8aMcgq/28rHt2H+tmeX5WyVuf/fMsEe1EJ1xclqZqVuvUCq1n2W0nmrSakITb3gO1NpGc0iMMID0vfFWsahEyJlyiourRyfNPLqZLlNHSscfLPQlQzPd1aRlTsOp7Sm3huHqdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hmM2KBL7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iP3Ax1Kp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hmM2KBL7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iP3Ax1Kp"
Date: Tue, 11 Feb 2025 09:21:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739262100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9BlClQg/igJMGUDxsPh2k6TNuhBuRDg74jGMgRLHdWM=;
	b=hmM2KBL7vW7mDZ2m2kbRTvbCD1THEqo2LjN8tx/vGwvctzhHHXlVAEKUGpfESAL9YPhBuv
	y/HN+6gdC4qlUDrFdwiEBbsBrDEnipn3X82MeQUJcSiYJSsiWU6g/Olxzg5PyhNtdzy5dw
	r/rM9M3gk0pFfH0vlgy2kdbsgCOYUeqI8YtU55mv8gsAm75duubgX1U0D/2qRthLx+x4UL
	DfPlPP3TlAi4/1nvJV5qZUKm5vifF1I91EMjwFWYLwjUeiLfyDZankUhBfu4ktYQkgEaKf
	ubojmPUwwhuHGpigHEGo0tXB0t9qW8QCmwHJpVsmeDx6egZpC9p2C1qOALhEkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739262100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9BlClQg/igJMGUDxsPh2k6TNuhBuRDg74jGMgRLHdWM=;
	b=iP3Ax1Kp6OqZ6pKpSWuFyA+erFCUcCmN36r5C/3Jpzbml2Ws6g3A+h3Boal+r6tX6LYeNk
	SR/VoVg2YhdwQaCQ==
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
Message-ID: <20250211082138.iqvedSfG@linutronix.de>
References: <EC77D83D-DD17-4CCD-9EF6-C4C39FCE16E7@oracle.com>
 <9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org>
 <20250204220418.35949317@gandalf.local.home>
 <CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
 <20250205081635.397eacb0@gandalf.local.home>
 <CAEXW_YQY2zuU+XZjrYWLS860+PJno0nf9WAe1iPU=EyDkA7H4Q@mail.gmail.com>
 <20250206083039.0916ad24@gandalf.local.home>
 <20250206134408.lD_POjuG@linutronix.de>
 <20250210144321.1f5974a6@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250210144321.1f5974a6@gandalf.local.home>

On 2025-02-10 14:43:21 [-0500], Steven Rostedt wrote:
> On Thu, 6 Feb 2025 14:44:08 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > I did add a scheduling point in rt_spin_unlock() if LAZY was set and
> > based on few tests it was something between noise and worse. It seems
> > that "run to completion" is better than interrupt the kernel in the
> > middle whatever it is doing. "Don't preempt the lock owner" is already
> > handled by LAZY with the scheduling point on return to userland.
> 
> Does that mean that PREEMPT_RT requires a non preempt method for
> SCHED_OTHER for SCHED_OTHER to not hit the issues that we were originally
> hitting? That is, with being able to preempt spin_locks in PREEMPT_RT,
> running a system with PREEMPT_RT in full preemption mode will still suffer
> performance issues against a non PREEMPT_RT running in full preemption mode?

So with LAZY_PREEMPT (not that one that was merged upstream, its
predecessor) we had a counter similar to the preemption counter. On each
rt_spin_lock() the counter was incremented, on each rt_spin_unlock() the
counter was decremented. Once the counter hit zero and the lazy preempt
flag was set (which was only set on schedule requests by SCHED_OTHER
tasks), we scheduled.
This improved the performance as we didn't schedule() while holding a
spinlock_t and then bump into the same lock in the next task.

We don't follow this behaviour exactly today.

Adding this behaviour back vs the behaviour we have now, doesn't seem to
improve anything at visible levels. We don't have a counter but we can
look at the RCU nesting counter which should be zero once locks have
been dropped. So this can be used for testing.

But as I said: using "run to completion" and preempt on the return
userland rather than once the lazy flag is seen and all locks have been
released appears to be better.

It is (now) possible that you run for a long time and get preempted
while holding a spinlock_t. It is however more likely that you release
all locks and get preempted while returning to userland.

> -- Steve

Sebastian
