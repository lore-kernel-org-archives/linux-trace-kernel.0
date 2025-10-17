Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0C42DE713;
	Fri, 17 Oct 2025 13:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706348; cv=none; b=l1yob46mKyTmSiCKPrvyNyGQ6noARmebN93mtQA97nBlB3JgBbKxOBdN5bvwZKiLp0F99V+B9XT5YuXAYMbz8fEKyRQ+/XcGhZKb/Ma8RkL8uI+4RHLh2AwjxONS2GkwdaDE4n+YpsW/PRKkJPkiqWqc/tgLpvhk01haGBT2kwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706348; c=relaxed/simple;
	bh=zEz9ga+C3NjrrB+uajYQC/2V9em72t3wQWjrmGwWgyE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dl9Whw7Y8g5Xe8B1Nsz8AXO188MJgsQAE5Azyh+5OLUz4uWVIv0M6YZ6NCBUkp+xo2+awPm4W2spi8tnOUIf03CCI7/OOGfFjBdUkh0CxR850i3xnSiqe4Q69OncMuWFI3xPhiZmawJOnUlRXEmZHJ+Xas6wX5sJsARBL/SE9Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tMDLw6cH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DWuiRtD9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tMDLw6cH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DWuiRtD9"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760706345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hPtEh82id2JnaP5JMh/vbCgClw5ZFVRwFNHrSzBjt1M=;
	b=tMDLw6cHx2JEMIytXTYHequZeGQSavqZnuyx2RiVKGr3QbmobXCb9DfmPyPvlHzahvLEgg
	LtQxqNUYasgpfkE1fkXCyx3FiL7jVJJaBm8Eik+56H4sgfjZPoOfgVgdDjzsmstFdW3rBB
	qZTFix9vLUy+kOmLyTV6d0eQ5ZimXv4epxqYN2rTK2dMkW2dYbBJInyOwAP32D2ci5uKHc
	CpJIXOBsbIaAJ674NPJ/nHzFop9E4HOZgsY21HSTdEkGson6e/0Z5zPF3sZVIEEYzqoT1N
	qKfi2b+CVWJsFOEa8Vb3MVQ2KCAawBchzODnOqjksQQCVj1RbgDLuVqr1g/K5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760706345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hPtEh82id2JnaP5JMh/vbCgClw5ZFVRwFNHrSzBjt1M=;
	b=DWuiRtD97Bun9qnHe9Qehx7Rf5DsXdqkJAcpPEWlhBIs2pUDJ4jWkGMaoWPPth2XW86csp
	4HIBpvjemIyMLQCg==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2 10/20] rv: Add Hybrid Automata monitor type
In-Reply-To: <4d27225b5a38210a40efcdb8eb778ca0ec3808f1.camel@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
 <20250919140954.104920-11-gmonaco@redhat.com> <87ldl9x6h7.fsf@yellow.woof>
 <4d27225b5a38210a40efcdb8eb778ca0ec3808f1.camel@redhat.com>
Date: Fri, 17 Oct 2025 15:05:44 +0200
Message-ID: <87frbhwudz.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Alright, this is the simplest way I could think to represent clocks, still it
> seems confusing.
>
> Let's start from guards (invariants are not special but I'm trying to do
> something to keep precision), the value of a clock is the time that passed since
> the last reset, as that's when the value is set to 0. Storing that timestamp and
> just comparing the difference whenever you need to know the valuation of said
> clock seemed the most straightforward thing to me. The clock representation
> doesn't include the guard constraint, that is validated during the event using
> the current valuation (i.e. now - reset_time).
>
> What is important to note is that, at time of reset, you don't know what guard
> is going to fire, you may as well have a state with event A asking for clk<10
> and event B requiring clk<20, also the guard may be in a later state and may
> depend on the path.
>
> Invariants are bound to the form clk < N, and get "armed" when we reach the
> state, from there we know exactly when the invariant is going to expire, so we
> can save that (very important when using the timer wheel). Note here that the
> expiration isn't exactly N from now, but it's the valuation of the clock (reset
> might have occurred a few states earlier, see the nomiss case) subtracted by N,
> this is what the "passed" means later.
>
> That said, I couldn't think of a simpler implementation but any suggestion is
> welcome, of course.

Ok, now things start to make sense. Thanks for the explanation.

At least to me, using the same variable to store different time values
is a bit confusing.

Is it possible that we always store the timestamp of the last clock reset?

The invariant bound value (N) is fixed for each state, so we can have
the bound value in ha_verify_invariants() instead. For example, the
Python script can generate something like

static inline bool ha_verify_invariants(struct ha_monitor *ha_mon,
                                       enum states curr_state, enum events event,
                                       enum states next_state, u64 time_ns)
{
       if (curr_state == enqueued_stall)
               return ha_check_invariant_jiffy(ha_mon, threshold_jiffies, time_ns);
       return true;
}

Is that possible?

> Kinda, it would solve the problem for this specific subtraction, but racing
> handlers could still lead to problems although the subtraction is "correct".
>
> Since this is the only time the env storage needs to be an atomic_t and it's
> fairly rare (only complicated models require calling this function at all,
> others are happy with READ_ONCE/WRITE_ONCE) I didn't want to change the storage
> implementation for some perceived safety.
>
> I wrote that comment exactly to motivate why we aren't using atomic_t, but I
> should probably reword that. Does this make sense to you?

I think if we always store the timestamp since last reset, we can get
rid of this function. Let's see how that discussion go..

> As mentioned before, this is true for the stall case, where the reset occurred
> when reaching the state with the invariant (passed is close to 0), if you look
> at the nomiss case, reset happens before being ready (its invariant would have
> passed close to 0), but the same invariant is enforced in running, here we will
> see a passed far from 0 and need to take that into account when setting the
> invariant.

Make sense, thanks!

Nam
