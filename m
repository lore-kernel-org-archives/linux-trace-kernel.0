Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64E229A5;
	Tue, 15 Jul 2025 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593008; cv=none; b=QmT1kGGz0Msn4lsxIX4+NkQHMTqCj2WxN8rNOAv6ElxDnymUMSPCNodjY84L6Fz8unx81kaZeBKR9JSE5aUtgCfU1I0qTTm6r92CiGQuRuYacfOVg5flnj8yYK4flbA50ugFrt0MP0xaw4S0fAqeJJTEY+myKf6l+BMnux0hqWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593008; c=relaxed/simple;
	bh=+yL4ogP4Wz0Yje7FHM6qD6QqNRwtP+1HxDsWdBMXUE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CV2QB87WUT0S/zlaoWddjxKukxvjDFtyQttbjbLAsuHJW1i1o3hIkiOy1s8VCUVakW2c5AJfXe1Y95j4fRqcArKV8rVs8R+9Ecy1zD56Z8ziDh0eRJc/k3drTZckfWwpmESoj2W5LW86vSw71DwskQ2mPe5v/k2YVHFtPkGz64c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kvMgQdn1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qH91vFjX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kvMgQdn1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qH91vFjX"
Date: Tue, 15 Jul 2025 17:23:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752593004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FnM7eSwbv+3Rg1wGrB5sgJ9RF8txXyxgxRZUjbAWnEE=;
	b=kvMgQdn1Q1E2EGPsndz0rRF/MjmkhA9or9SpOr8b+ThpEAcw6+kfie9EVmAcQXentasC9d
	TG1xoIaej3V18mk8pNVcEdGecWk/o1leTMTPpq2eGxV4KoNooQJSU9j2WkMXKC0EkVk887
	Exvjq8i+xEGmrCc5PPFjtzHddSLakezaRr5j7cfE78gWAogM4cJESBCm4SR1Ch0g++c6eS
	23KcxLW5KHep0jUMbJYt/bdYp9clahb8TuKDyuwmX0eyZVCVcrdydcI+juzrh9rX7S9DlR
	tDUc3COiMB+K1CX/R3cmwg97T/oB1qNPtke2ucKRRYuQzmi33ocbLTWiMywRUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752593004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FnM7eSwbv+3Rg1wGrB5sgJ9RF8txXyxgxRZUjbAWnEE=;
	b=qH91vFjX+eLZnKDEItJIWcAtN1a+1NoHkf09ubX4GSaJR6OU6fX0bMilGKdTcBgHkJEhmx
	dtQo6JKqy1n35XAA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 11/17] rv: Retry when da monitor detects race
 conditions
Message-ID: <20250715152322.Os4lDq_B@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
 <20250715071434.22508-12-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715071434.22508-12-gmonaco@redhat.com>

On Tue, Jul 15, 2025 at 09:14:28AM +0200, Gabriele Monaco wrote:
>  static inline bool										\
>  da_event_##name(struct da_monitor *da_mon, enum events_##name event)				\
>  {												\
> -	type curr_state = da_monitor_curr_state_##name(da_mon);					\
> -	type next_state = model_get_next_state_##name(curr_state, event);			\
> -												\
> -	if (next_state != INVALID_STATE) {							\
> -		da_monitor_set_state_##name(da_mon, next_state);				\
> -												\
> -		trace_event_##name(model_get_state_name_##name(curr_state),			\
> -				   model_get_event_name_##name(event),				\
> -				   model_get_state_name_##name(next_state),			\
> -				   model_is_final_state_##name(next_state));			\
> -												\
> -		return true;									\
> +	enum states_##name curr_state, next_state;						\
> +												\
> +	curr_state = READ_ONCE(da_mon->curr_state);						\
> +	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {					\
> +		next_state = model_get_next_state_##name(curr_state, event);			\
> +		if (next_state == INVALID_STATE)						\
> +			goto out_react;								\
> +		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state)))		\
> +			goto out_success;							\
>  	}											\
> +	/* Special invalid transition if we run out of retries. */				\
> +	curr_state = INVALID_STATE;								\
>  												\
> +out_react:											\
>  	cond_react_##name(curr_state, event);							\
>  												\
>  	trace_error_##name(model_get_state_name_##name(curr_state),				\
>  			   model_get_event_name_##name(event));					\

If I understand correctly, if after 3 tries and we still fail to change the
state, we will invoke the reactor and trace_error? Doesn't that cause a
false positive? Because it is not a violation of the model, it is just a
race making us fail to change the state.

Same below.

Also, I wouldn't use goto unless necessary. Perhaps it is better to put the
code at "out_react:" and "out_success:" into the loop. But that's just my
personal preference, up to you.

Nam
