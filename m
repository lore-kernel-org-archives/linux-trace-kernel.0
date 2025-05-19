Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAD51B4248;
	Mon, 19 May 2025 09:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747645590; cv=none; b=Bxo9OOdMfgzlm6MZMGCAnEZxNeJIlZH77oglpiZGs1yBJiJHwwCjdsygh+zF5fAYnkBjmSH3gzpAEWRtDZ16acKsI8nHDb4JMcxeWwqiI6a1g5EHNTNL72ybZFSnRch4s0TbBJ3IySUuFHF8Rxo1xS1+g1kRcnmIq+rEYfASAp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747645590; c=relaxed/simple;
	bh=9cF2yw1+beWx5noinRADvsH7sW/E6B2OE/164Oqn3jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFaYH3gm9GX7D2slrY3E1Kxv4xSporePRhIhQfAJ/kHeFNw1y9YRzWNM1MQT+3UCHvkakkeIyyHwZht0D9wHV//SZmt4+sPnCZquoGT2w4oRsOe2u2zNP6/umK4lKHvvmmZp4kLpOJzirP1JiMYHrqdWGH6IJM6w2HTY5ng6BFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ssDPL5Pc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aHq/oLQa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ssDPL5Pc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aHq/oLQa"
Date: Mon, 19 May 2025 11:06:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747645587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fRhtlACFEuO5BN2NE25bytv9HCzJDqtEa6EwhxIrQZc=;
	b=ssDPL5Pce5O/gzWTZNr3Gv/e5YHTnKWULPQvz2wRh10zdjuqGjN4AS4cixG2stZW3OyLM+
	t7PA/xdDZmYkP7mY6tDlT4UtcTx66dkgF2szjpcd6CGH7t5VKDdEMnCG27VsI7HW0HlQae
	cA/86bPscLjDv3Ewp05u3n1fMXFDjGKiUzckltpdDfCnifX8/0PiTrBG2zUkBRCpFqSgz9
	o1jjnQgXEixC12dUBSAC4LWf1po/BsCT85syg2kX6KdCxDQjJHrg1x1F6515JWpr25wlVk
	i4RStu+lISvHw1ly8/oX7MUalMtPJ6AJTwbK07VdMVJxraMMxHyRp0leGgAdeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747645587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fRhtlACFEuO5BN2NE25bytv9HCzJDqtEa6EwhxIrQZc=;
	b=aHq/oLQaoNbvDkF4+ZBE04rWlwqVUZnMI9saea3VLrGmqnAzhDY0ExtYMHeF/oykOe7r1e
	sw9zbJ99wPq6lHAQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>
Subject: Re: [RFC PATCH v2 10/12] rv: Retry when da monitor detects race
 conditions
Message-ID: <20250519090626.zjiYgUGW@linutronix.de>
References: <20250514084314.57976-1-gmonaco@redhat.com>
 <20250514084314.57976-11-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514084314.57976-11-gmonaco@redhat.com>

On Wed, May 14, 2025 at 10:43:12AM +0200, Gabriele Monaco wrote:
> -static inline void										\
> -da_monitor_set_state_##name(struct da_monitor *da_mon, enum states_##name state)		\
> +static inline bool										\
> +da_monitor_set_state_##name(struct da_monitor *da_mon, enum states_##name prev_state,		\
> +			    enum states_##name state)						\
>  {												\
> -	da_mon->curr_state = state;								\
> +	return try_cmpxchg(&da_mon->curr_state, &prev_state, state);				\
>  }												\

This is a very thin wrapper. Should we just call try_cmpxchg() directly?

>  static inline bool										\
>  da_event_##name(struct da_monitor *da_mon, enum events_##name event)				\
>  {												\
> -	type curr_state = da_monitor_curr_state_##name(da_mon);					\
> -	type next_state = model_get_next_state_##name(curr_state, event);			\
> +	bool changed;										\
> +	type curr_state, next_state;								\
>  												\
> -	if (next_state != INVALID_STATE) {							\
> -		da_monitor_set_state_##name(da_mon, next_state);				\
> +	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {					\
> +		curr_state = da_monitor_curr_state_##name(da_mon);				\

For the follow-up iterations (i > 0), it is not necessary to read
curr_state again here, we already have its value from try_cmpxchg() below.

Also, thinking about memory barrier hurts my main, but I'm not entirely
sure if reading curr_state without memory barrier here is okay.

How about something like below?

curr_state = da_monitor_curr_state_##name(da_mon);
for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {
	next_state = model_get_next_state_##name(curr_state, event);
	if (next_state == INVALID_STATE)
		break;
	if (try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))
		break;
}

Furthermore, it is possible to replace for(...) with while (1)? I don't
think we can have a live lock, because if we fail to do try_cmpxchg(),
the "other guy" surely succeed.

Best regards,
Nam
