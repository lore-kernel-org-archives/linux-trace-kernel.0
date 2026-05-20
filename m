Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE95235E1BC;
	Wed, 20 May 2026 19:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779306948; cv=none; b=AjeM8NwuEkzoKG1zG7/Y+Zhd82e8Cfpj0JtyCT85JGItD6ajJ5yl7SatvYR969nFulBh58SIDiKT6wvjst4uocjAJX0E6RSFJc+K2s8F4h7TH7DuKO/iMoYG0Tu9qm5kmPYRZoiqM4p6y2hYNErbzUlkClD2Nijc6r9238XyTsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779306948; c=relaxed/simple;
	bh=1jGlu3swlgsIMp2Uq0RhncQ8qEYI7ZzTgl0X1KmQypE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMM+zlqdIhzbrxv0XRk52mWqu/KijXvIGJxRXYj+ILu6e5cefr907cLCh20+JT0GcjTsBtZ7ziQya74sH3Bl3lnuuUZOM+hJ18MGAFRiJJ7I7MxA2+NPFAe5oc9PIJCa7pmoAxHN8cixQpdsMRO+zHpWHWM/Il7i5XKUCANYwUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 5192E1C0355;
	Wed, 20 May 2026 19:55:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 0D0102002A;
	Wed, 20 May 2026 19:55:31 +0000 (UTC)
Date: Wed, 20 May 2026 15:55:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Carlier <devnexen@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, peterz@infradead.org,
 vineeth@bitbyteword.org, sashiko-bot@kernel.org,
 sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2] tracepoint: add lockdep rcu_is_watching() check to
 trace_##name##_enabled()
Message-ID: <20260520155550.0ef0b0f5@gandalf.local.home>
In-Reply-To: <20260430144159.10985-1-devnexen@gmail.com>
References: <20260430053511.8767-1-devnexen@gmail.com>
	<20260430144159.10985-1-devnexen@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0D0102002A
X-Stat-Signature: bhhoteuhkfmwgpmtb65qi57pzziyqnni
X-Rspamd-Server: rspamout01
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/6vPKcmI83BUi6uAbeZriErnTmbXkDfKo=
X-HE-Tag: 1779306931-517759
X-HE-Meta: U2FsdGVkX1+cog7GiBvw4MxhAzjiQt9RB0VYKpPXrS7xXcTQbBv8PoGAJ3qKuz9yizua2iYpmVBPGP5OlVDKFEqjwcLeNVX2gkqoXaMei4kJQ3uCnDwT82zdgVuQUg+A/kDkhDT9FhqYvItwamIUiEYIgO1V4WrCeVEy2wB9zdmC91dYHTO7e2dmSCX1iJh6JaOLXLbiREW4cypGTWOXMa7MQJQB92f3J96v3ibUNQi9PGYs11293DqXxDkRIjNrXQwf/Ihex7YNJ3RLp3BsbyrCWafcCP/pJvs2wabk0634BiTFrqEZOJlBVS2KT/Ly6uuiGmz29Mmh9DhCyipgv3L8P9IVwU8R


[ Replying to Sashiko ]

> commit 7596bdcd9abf9a26b3964f10b5d5de3249e731e9
> Author: David Carlier <devnexen@gmail.com>
> tracepoint: add lockdep rcu_is_watching() check to trace_##name##_enabled()
> This commit attempts to restore RCU lockdep coverage for trace_call__##name()
> callers by adding a warning directly to the trace_##name##_enabled() static
> branch check.
> > When the tracepoint is enabled, the rcu_dereference inside
> > __DO_TRACE_CALL() already trips under PROVE_RCU, so the warning is
> > only needed on the !enabled path.
> Is this description accurate regarding __DO_TRACE_CALL()?
> Looking at the implementation, it uses rcu_dereference_raw() which
> intentionally bypasses lockdep checking. This means trace_call__##name()
> lacks lockdep coverage on both the enabled and disabled paths.
> > diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> > --- a/include/linux/tracepoint.h
> > +++ b/include/linux/tracepoint.h
> > @@ -293,6 +293,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> >  	static inline bool						\
> >  	trace_##name##_enabled(void)					\
> >  	{								\
> > +		if (IS_ENABLED(CONFIG_LOCKDEP)) {			\
> > +			WARN_ONCE(!rcu_is_watching(),			\
> > +				  "RCU not watching for tracepoint");	\
> > +		}							\
> >  		return static_branch_unlikely(&__tracepoint_##name.key);\
> >  	}

> Does this unconditional check cause spurious lockdep splats?
> Unlike the original trace_##name() macro, trace_##name##_enabled() takes no
> arguments and cannot evaluate the tracepoint's condition, such as
> cpu_online(raw_smp_processor_id()). If a subsystem queries
> trace_##name##_enabled() on an offline CPU where RCU is not watching, won't
> this trigger a false positive warning, even if the tracepoint itself would
> have been safely skipped by its condition?

If the CPU is offline, you shouldn't be using trace_##name##_enabled() to
begin with.


> Furthermore, is it already safe to query a static branch outside of an RCU
> watch window? Subsystems sometimes use this boolean query in RCU-idle
> contexts simply to skip data gathering without ever intending to execute
> the tracepoint.

The entire point of this patch is to make sure lockdep *always* checks that
"RCU is watching" at every trace_##name##_enabled() location regardless if
the tracepoint is active or not. It's not about the static branch, but the
tracepoint that is hidden behind it.


> Would it be more reliable to add the WARN_ONCE check, guarded by its cond
> parameter, directly to trace_call__##name() to appropriately mirror how
> trace_##name() behaves?

Hmm, if this does become an issue, that may be worth doing. But currently,
I do not believe the enabled() code is used by anything with conditional
tracepoints.

-- Steve
