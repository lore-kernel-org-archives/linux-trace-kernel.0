Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477E6242D94;
	Tue, 29 Apr 2025 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947266; cv=none; b=DvBy2xIOgzp/BtGy9+CcHja0rKQ99+T3Hgs1Dt+/xH5tprmDCrYrz0HCxUazCx3xv/5uIJkRAqYat96obq1ZvZ9QDEEZVxvwBAsX+o9M1CVgWeFL6kdZZ12RYKadyHU2B5K/VfN8KWe4KlxLVZGVjaTEs+Mh1H6RfdiWXwKrJTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947266; c=relaxed/simple;
	bh=5KfUoxuj2Ypz6ZoAyfBGDzaZ0Pi1H2k4Cuu/w10QqF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aU6NuigMWRM8KxtXzcR217S9TNOtQLz4RTgd1JlOyDoRFAsC3Rg08NUAhMItTt//fYAU/W+UIZ+a2lzzHfFH0SXuTd5qCbqc8PwoOIRFIk1LSxuKxyg4zt6/UtJpJt3J5P8x5SD3QWqAPqTiQpw3lyXuPv3ieZqKbA1c5+CsO1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YmjFN5B5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TPmdesmg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YmjFN5B5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TPmdesmg"
Date: Tue, 29 Apr 2025 19:20:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745947260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=77pFmmYX/3Jq91aWz+oVkLom07ek+rcUaCtouMmiqYM=;
	b=YmjFN5B5BOgZRH2SzUnqhk8r6v9eLz1h2wcY4WxXmUiYaKaQR7I9JRyJeyR1AQA1/4HN0e
	OgSt/LW/c/ntDMO/aeDtlgDhHmhvk5pwL0YuX7hQyZb8E4qvWqxZq7TTxh3PJ/AEIWszM2
	CJg0OJaaQPQTveXCqDaC1u01Tt7uYIiGzGolSUCt2C7+rGkBqaMCwk5AW4E1r8Tl5aVUyx
	beExDdKqJB5GdF9I1GxdzqCbFD8qUs6IQF6D9vQftF0fD/hqYBSROgsheDBV9X19QylKqJ
	tegoILegcuwIRvlQcarY044611bZbSCQJxZPB+1LGl4S6i8fwjrR7F+4AfGNVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745947260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=77pFmmYX/3Jq91aWz+oVkLom07ek+rcUaCtouMmiqYM=;
	b=TPmdesmgBaHdgmnWyzG3AtOEr+hVGALk+s2q1mhS02/Aqy7n7Pt7D0Sw+2VlFmCJVHey84
	DPE/AfIkLXBbchDA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 21/23] rv: Add rtapp_sleep monitor
Message-ID: <20250429172055.QICnVQ2s@linutronix.de>
References: <cover.1745926331.git.namcao@linutronix.de>
 <57ea14992e148121fc010a200986e4db60ac2de0.1745926331.git.namcao@linutronix.de>
 <bfe8322cf5817037af57f10ffbffcd9b30f43b42.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bfe8322cf5817037af57f10ffbffcd9b30f43b42.camel@redhat.com>

On Tue, Apr 29, 2025 at 06:01:01PM +0200, Gabriele Monaco wrote:
> On Tue, 2025-04-29 at 14:01 +0200, Nam Cao wrote:
> > Add a monitor for checking that real-time tasks do not go to sleep in
> > a
> > manner that may cause undesirable latency.
> > 
> > Also change
> > 	RV depends on TRACING
> > to
> > 	RV select TRACING
> > to avoid the following recursive dependency:
> > 
> >  error: recursive dependency detected!
> > 	symbol TRACING is selected by PREEMPTIRQ_TRACEPOINTS
> > 	symbol PREEMPTIRQ_TRACEPOINTS depends on TRACE_IRQFLAGS
> > 	symbol TRACE_IRQFLAGS is selected by RV_MON_SLEEP
> > 	symbol RV_MON_SLEEP depends on RV
> > 	symbol RV depends on TRACING
> > 
> > Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > ---
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Waiman Long <longman@redhat.com>
> > ---
> > 
> > [...]
> > 
> > +RULE = always ((RT and SLEEP) imply (RT_FRIENDLY_SLEEP or
> > ALLOWLIST))
> > +
> > +RT_FRIENDLY_SLEEP = (RT_VALID_SLEEP_REASON or KERNEL_THREAD)
> > +                and ((not WAKE) until RT_FRIENDLY_WAKE)
> > +
> > +RT_VALID_SLEEP_REASON = PI_FUTEX
> > +                     or RT_FRIENDLY_NANOSLEEP
> > +
> > +RT_FRIENDLY_NANOSLEEP = CLOCK_NANOSLEEP
> > +                    and NANOSLEEP_TIMER_ABSTIME
> > +                    and NANOSLEEP_CLOCK_MONOTONIC
> > +
> > +RT_FRIENDLY_WAKE = WOKEN_BY_EQUAL_OR_HIGHER_PRIO
> > +                or WOKEN_BY_HARDIRQ
> > +                or WOKEN_BY_NMI
> > +                or KTHREAD_SHOULD_STOP
> > +
> > +ALLOWLIST = BLOCK_ON_RT_MUTEX
> > +         or TASK_IS_RCU
> > +         or TASK_IS_MIGRATION
> 
> So, just thinking out loud, PI_FUTEX is a valid sleep reason,
> technically also BLOCK_ON_RT_MUTEX is something you are allowing.
> 
> In my understanding, the contention tracepoints already in the kernel
> can track all contention by kernel code and are leaving aside the PI
> futexes, which use the untracked rt_mutex_wait_proxy_lock.
> 
> In your case, you are tracking PI_FUTEX via the system call, which
> should cover the above scenario.
>
> Do you really need extra tracepoints to track this too? Or is there any
> other use of start_proxy_lock/wait_proxy_lock I'm missing here?
> 
> I see the only case in which rt_mutex_start_proxy_lock is called with a
> task different than current is via FUTEX_CMP_REQUEUE_PI, wouldn't
> considering this one too make the new tracepoints superfluous (assuming
> this one is even needed to be tracked before FUTEX_WAIT_REQUEUE_PI).

The monitor allows PI_FUTEX and allows BLOCK_ON_RT_MUTEX in different
manners.

PI_FUTEX is only a valid sleep reason. If a task sleeps with PI_FUTEX=true,
it still has to obey ((not WAKE) until RT_FRIENDLY_WAKE)

On the other hand, BLOCK_ON_RT_MUTEX alone is good enough. Waker is not
checked due to how rt_mutex is implemented: when a task unlocks an rt_mutex
and wakes waiter, the task is priority-deboosted first before doing the
wakeup, and we would see a false positive warning. See
rt_mutex_slowunlock().

In the case of futex_lock_pi(), both PI_FUTEX and BLOCK_ON_RT_MUTEX is
true. Therefore we don't check the waker.

However, in the case of futex_wait_requeue_pi(), PI_FUTEX is true but
BLOCK_ON_RT_MUTEX is false. In this case, we check the waker.

So, what happens if we don't have the tracepoint in *_proxy_lock()? The
futex_lock_pi() may generate a false positive warning, because we check the
waker and the waker may have lower priority.

But now that you mention it, perhaps instead of PI_FUTEX, we could define
FUTEX_LOCK_PI and FUTEX_WAIT_REQUEUE_PI separately. And we don't check the
waker if FUTEX_LOCK_PI=true. Something like the diff below.

Then we wouldn't need the block_on_rt_mutex tracepoints anymore. And the
specification is a bit more obvious.

Having a second pair of eyes is great, thanks!

Nam

diff --git a/tools/verification/models/rtapp/sleep.ltl b/tools/verification/models/rtapp/sleep.ltl
index 6e2f1ff31163..1f26e58e72f8 100644
--- a/tools/verification/models/rtapp/sleep.ltl
+++ b/tools/verification/models/rtapp/sleep.ltl
@@ -3,7 +3,7 @@ RULE = always ((RT and SLEEP) imply (RT_FRIENDLY_SLEEP or ALLOWLIST))
 RT_FRIENDLY_SLEEP = (RT_VALID_SLEEP_REASON or KERNEL_THREAD)
                 and ((not WAKE) until RT_FRIENDLY_WAKE)
 
-RT_VALID_SLEEP_REASON = PI_FUTEX
+RT_VALID_SLEEP_REASON = FUTEX_WAIT_REQUEUE_PI
                      or RT_FRIENDLY_NANOSLEEP
 
 RT_FRIENDLY_NANOSLEEP = CLOCK_NANOSLEEP
@@ -16,5 +16,6 @@ RT_FRIENDLY_WAKE = WOKEN_BY_EQUAL_OR_HIGHER_PRIO
                 or KTHREAD_SHOULD_STOP
 
 ALLOWLIST = BLOCK_ON_RT_MUTEX
+         or FUTEX_LOCK_PI
          or TASK_IS_RCU
          or TASK_IS_MIGRATION
