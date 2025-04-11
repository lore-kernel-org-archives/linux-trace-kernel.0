Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4945A2110;
	Fri, 11 Apr 2025 04:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744347157; cv=none; b=KUsKT4Hqm9euUDd9tZj+topnGIprSijna9RRRtmoo4BRst/5eOwCkPUDjOtEDpdwEpt8Ezz0l7qZGBy8b//UUbSIRkYYm5M0qPx5jlHUGNKeXOGOUkmlTBfVB3/umTnJtJm7vGXFTspG6ZbpdlnxBUnheofT2GlBX+J1WUFxID8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744347157; c=relaxed/simple;
	bh=r6QJvqZH2UUlBohvanSD7QFmV76LlxcdaI2RhDQdF80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4MfWmKHDQNuh06jfm5tpih3DxLaujxefKWYTYb2r4mqyIwpzCu4w+8JYbUH2bxNzkrHv2C0AMrxaBME7RAI6rMSPt+R/HWW2ondtlPr6AvoX4Q/W4r6W65XHbiQ04z4ABWcO434dqIYTRk64185mRjeW4x1+HY7QwWtWKiUTmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vpLyYCyP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QHQ8qXO9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vpLyYCyP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QHQ8qXO9"
Date: Fri, 11 Apr 2025 06:52:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744347152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pUO/YijjhRnU4ovRKHI2PdTyiD7oxN+ZSjz64G77NNQ=;
	b=vpLyYCyPiErn7dzbZVV2g3J9WyHQoHDJi/GKrAIwBjvLylLEN/rp8p2RyoVUGAhBCste0Z
	VxLflFvEa3Z3UphnZOuAo6yh1RVMcp+eWqs9y28KShZ+Zmbg+ZqrydIMX5QQ86F/RyiHY+
	NHVWe4tppbFiv8iA1og85M4NpJdblmphv/vJvJ+QMGq2C5LdzCSISZVqUb4JwM01rJvtzJ
	E2kWTehjYcKyn8/xjwr2S5WjNrFUvF35Vn+DCitMt/xjCUflunVF0FrTeJvhHx4BfnDCet
	hz+H3D/nCym6+Ta3LRV3GtJPIrLSm6QG2XyExAVPh9YfZ3VkRlFBtztIBd0EGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744347152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pUO/YijjhRnU4ovRKHI2PdTyiD7oxN+ZSjz64G77NNQ=;
	b=QHQ8qXO91T2Cowz79CNIEImUMcuXt00DPmhoDaYOpwgJZNDkuUkNg/sJF7YPpc5uMG4BA6
	i+x26i9D047XNoBA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>
Subject: Re: [RFC PATCH 7/9] rv: Retry when da monitor detects race conditions
Message-ID: <20250411045225.gP4DqmFt@linutronix.de>
References: <20250404084512.98552-11-gmonaco@redhat.com>
 <20250404084512.98552-18-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404084512.98552-18-gmonaco@redhat.com>

On Fri, Apr 04, 2025 at 10:45:20AM +0200, Gabriele Monaco wrote:
> DA monitor can be accessed from multiple cores simultaneously, this is
> likely, for instance when dealing with per-task monitors reacting on
> events that do not always occur on the CPU where the task is running.
> This can cause race conditions where two events change the next state
> and we see inconsistent values. E.g.:
> 
>   [62] event_srs: 27: sleepable x sched_wakeup -> running (final)
>   [63] event_srs: 27: sleepable x sched_set_state_sleepable -> sleepable
>   [63] error_srs: 27: event sched_switch_suspend not expected in the state running
> 
> In this case the monitor fails because the event on CPU 62 wins against
> the one on CPU 63, although the correct state should have been
> sleepable, since the task get suspended.
> 
> Detect if the current state was modified by using try_cmpxchg while
> storing the next value. If it was, try again reading the current state.
> After a maximum number of failed retries, react as if it was an error
> with invalid current state (we cannot determine it).
> 
> Monitors where this type of condition can occur must be able to account
> for racing events in any possible order, as we cannot know the winner.

Is locking not simpler? I understand raw_spin_lock() doesn't work because
it steps on some tracepoints. But how about adding something like
raw_spin_lock_notrace()?

static inline bool raw_spin_lock_notrace(raw_spinlock_t *lock)
{
	preempt_disable_notrace(); //probably not required, tracepoint handlers do this already

	if (!do_raw_spin_trylock(lock))
		do_raw_spin_lock(lock);
}

My LTL series theoretically also has this problem, but I have never got it
during testing yet. We should use the same solution for both DA and LTL.

Also, can you please Cc me in your RV patches?

Best regards,
Nam
