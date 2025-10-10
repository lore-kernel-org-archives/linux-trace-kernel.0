Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6C8748F;
	Fri, 10 Oct 2025 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760103981; cv=none; b=O864qx4gy/uYah1n1goCJimHkEmdQz8lmZcdgygZDM8rvYSChWVwkcUKmedDn4C66BTwxKQ3Ut4ZvauJW6aVjTjrhfrte/scW5ahLdHe75ry4XuuBlRfygoz08HolmA127cV4PDsYMifKsckh4lgWsql0BDqIAwwl7OASC4McYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760103981; c=relaxed/simple;
	bh=kPNz+wVO35rfTqGmyu2J4j0ZFT6HKfYTFOrvglMjJiE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IB9N/iE9zgY82CEfSZSt/kg1Dri5gQh0/BHSQbED3Ef2dtgLPVA/4vWwpGR7US/Isw0DH/jx3JO+qa+O1krdWxU2lpiNkHNAjKEr6FDoX+plisZA3AnJWWtZKSS3vMVWZMONF/2e4ix6oraGVNpl3qCe3AFYe85oaJE7ELBKv5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aJcHDJr1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FtT9nFNK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aJcHDJr1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FtT9nFNK"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760103976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oqNUuPWLIGP8jGR5s0wYFlz1UpDW74k2GWO4cRG27qE=;
	b=aJcHDJr1qbTFxAaf8TbH4do2Mw2HjqwtRZYZUQnbgtzfJYqjoFADUIiyNF0Ip439/rSblP
	l9RhOJnvJdEdpDklXoz9w9H5/E3U/GMxMM09O8A1KK4gufQm1CyF4d7BUZ8hTxuo07d/14
	OVT2FnMKzAS87RGaBvOsD4zaCSEeZ4oBcu91qlz+dNoYd31oZBkcCEMftaOY67WlVgCy+/
	tYffV1sGHfpU/t5BTeRZ0mHLV9AwBpP/LLTKXGublFPVXz14voQkHF4DJ+eeJtc7qpYl+R
	0uMa1nrJ8tQIAXBTqpUmpFniYq2lpWgcMNeW91iCCtVLCZ21c1s0aUA1FRwBtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760103976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oqNUuPWLIGP8jGR5s0wYFlz1UpDW74k2GWO4cRG27qE=;
	b=FtT9nFNKqbySE5mR/YFeaPYq34jh1KI2bn61tKgZ69yZJCdlg8lQGPukXCyOlK8zLdGExB
	hwKYMCe/iOVtHvAg==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
 Juri Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John
 Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2 13/20] Documentation/rv: Add documentation about
 hybrid automata
In-Reply-To: <20250919140954.104920-14-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
 <20250919140954.104920-14-gmonaco@redhat.com>
Date: Fri, 10 Oct 2025 15:46:15 +0200
Message-ID: <87jz12yimw.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Describe theory and implementation of hybrid automata in the dedicated
> page hybrid_automata.rst
> Include a section on how to integrate a hybrid automaton in
> monitor_synthesis.rst
> Also remove a hanging $ in deterministic_automata.rst
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>  .../trace/rv/deterministic_automata.rst       |   2 +-
>  Documentation/trace/rv/hybrid_automata.rst    | 340 ++++++++++++++++++
>  Documentation/trace/rv/index.rst              |   1 +
>  Documentation/trace/rv/monitor_synthesis.rst  | 107 ++++++
>  4 files changed, 449 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/trace/rv/hybrid_automata.rst
>
> diff --git a/Documentation/trace/rv/deterministic_automata.rst b/Documentation/trace/rv/deterministic_automata.rst
> index d0638f95a455..7a1c2b20ec72 100644
> --- a/Documentation/trace/rv/deterministic_automata.rst
> +++ b/Documentation/trace/rv/deterministic_automata.rst
> @@ -11,7 +11,7 @@ where:
>  - *E* is the finite set of events;
>  - x\ :subscript:`0` is the initial state;
>  - X\ :subscript:`m` (subset of *X*) is the set of marked (or final) states.
> -- *f* : *X* x *E* -> *X* $ is the transition function. It defines the state
> +- *f* : *X* x *E* -> *X* is the transition function. It defines the state
>    transition in the occurrence of an event from *E* in the state *X*. In the
>    special case of deterministic automata, the occurrence of the event in *E*
>    in a state in *X* has a deterministic next state from *X*.
> diff --git a/Documentation/trace/rv/hybrid_automata.rst b/Documentation/trace/rv/hybrid_automata.rst
> new file mode 100644
> index 000000000000..ea701114c54d
> --- /dev/null
> +++ b/Documentation/trace/rv/hybrid_automata.rst
> @@ -0,0 +1,340 @@
> +Hybrid Automata
> +===============
> +
> +Hybrid automata are an extension of deterministic automata, there are several
> +definitions of hybrid automata in the literature. The adaptation implemented
> +here is formally denoted by G and defined as a 7-tuple:
> +
> +        *G* = { *X*, *E*, *V*, *f*, x\ :subscript:`0`, X\ :subscript:`m`, *i* }
> +
> +- *X* is the set of states;
> +- *E* is the finite set of events;
> +- *V* is the finite set of environment variables;
> +- x\ :subscript:`0` is the initial state;
> +- X\ :subscript:`m` (subset of *X*) is the set of marked (or final) states.
> +- *f* : *X* x *E* x *C(V)* -> *X* is the transition function.
> +  It defines the state transition in the occurrence of an event from *E* in the
> +  state *X*. Unlike deterministic automata, the transition function also
> +  includes guards from the set of all possible constraints (defined as *C(V)*).
> +  Guards can be true or false with the valuation of *V* when the event occurs,
> +  and the transition is possible only when constraints are true. Similarly to
> +  deterministic automata, the occurrence of the event in *E* in a state in *X*
> +  has a deterministic next state from *X*, if the guard is true.
> +- *i* : *X* -> *C'(V)* is the invariant assignment function, this is a
> +  constraint assigned to each state in *X*, every state in *X* must be left
> +  before the invariant turns to false. We can omit the representation of
> +  invariants whose value is true regardless of the valuation of *V*.

This brings back bad memories from university..

> +
> +The set of all possible constraints *C(V)* is defined according to the
> +following grammar:
> +
> +        g = v < c | v > c | v <= c | v >= c | v == c | v != c | g && g | true
> +
> +With v a variable in *V* and c a numerical value.
> +
> +We define the special case of hybrid automata whose variables grow with uniform
> +rates as timed automata. In this case, the variables are called clocks.
> +As the name implies, timed automata can be used to describe real time.
> +Additionally, clocks support another type of guard which always evaluates to true:
> +
> +        reset(v)
> +
> +The reset constraint is used to set the value of a clock to 0.
> +
> +The set of invariant constraints *C'(V)* is a subset of *C(V)* including only
> +constraint of the form:
> +
> +        g = v < c | true
> +
> +This simplifies the implementation as a clock expiration is a necessary and
> +sufficient condition for the violation of invariants while still allowing more
> +complex constraints to be specified as guards.
> +
> +It is important to note that any valid hybrid automaton is a valid
> +deterministic automaton with additional guards and invariants. Those can only
> +further constrain what transitions are valid but it is not possible to define
> +transition functions starting from the same state in *X* and the same event in
> +*E* but ending up in different states in *X* based on the valuation of *V*.

Perhaps remove the double "valid". Usually people use the phrase "any
valid A is a valid B" to say that B is a superset of A, but it is
opposite here.

> +
> +Examples
> +--------
> +
> +Wip as hybrid automaton
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The 'wip' (wakeup in preemptive) example introduced as a deterministic automaton
> +can also be described as:
> +
> +- *X* = { ``any_thread_running`` }
> +- *E* = { ``sched_waking`` }
> +- *V* = { ``preemptive`` }
> +- x\ :subscript:`0` = ``any_thread_running``
> +- X\ :subscript:`m` = {``any_thread_running``}
> +- *f* =
> +   - *f*\ (``any_thread_running``, ``sched_waking``, ``preemptive==0``) = ``any_thread_running``
> +- *i* =
> +   - *i*\ (``any_thread_running``) = ``true``
> +
> +Which can be represented graphically as::
> +
> +     |
> +     |
> +     v
> +   #====================#   sched_waking;preemptive==0
> +   H                    H ------------------------------+
> +   H any_thread_running H                               |
> +   H                    H <-----------------------------+
> +   #====================#
> +
> +In this example, by using the preemptive state of the system as an environment
> +variable, we can assert this constraint on ``sched_waking`` without requiring
> +preemption events (as we would in a deterministic automaton), which can be
> +useful in case those events are not available or not reliable on the system.
> +
> +Since all the invariants in *i* are true, we can omit them from the representation.
> +
> +Stall model with guards (iteration 1)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +As a sample timed automaton we can define 'stall' as:
> +
> +- *X* = { ``dequeued``, ``enqueued``, ``running``}
> +- *E* = { ``enqueue``, ``dequeue``, ``switch_in``}
> +- *V* = { ``clk`` }
> +- x\ :subscript:`0` = ``dequeue``
> +- X\ :subscript:`m` = {``dequeue``}
> +- *f* =
> +   - *f*\ (``enqueued``, ``switch_in``, ``clk < threshold``) = ``running``
> +   - *f*\ (``running``, ``dequeue``) = ``dequeued``
> +   - *f*\ (``dequeued``, ``enqueue``, ``reset(clk)``) = ``enqueued``
> +- *i* = *omitted as all true*
> +
> +Graphically represented as::
> +
> +       |
> +       |
> +       v
> +     #============================#
> +     H          dequeued          H <+
> +     #============================#  |
> +       |                             |
> +       | enqueue; reset(clk)         |
> +       v                             |
> +     +----------------------------+  |
> +     |          enqueued          |  | dequeue
> +     +----------------------------+  |
> +       |                             |
> +       | switch_in; clk < threshold  |
> +       v                             |
> +     +----------------------------+  |
> +     |          running           | -+
> +     +----------------------------+
> +
> +This model imposes that the time between when a task is enqueued (it becomes
> +runnable) and when the task gets to run must be lower than a certain threshold.
> +A failure in this model means that the task is starving.
> +One problem in using guards on the edges in this case is that the model will
> +not report a failure until the ``switch_in`` event occurs. This means that,
> +according to the model, it is valid for the task never to run.
> +
> +Stall model with invariants (iteration 2)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The first iteration isn't exactly what was intended, we can change the model as:
> +
> +- *X* = { ``dequeued``, ``enqueued``, ``running``}
> +- *E* = { ``enqueue``, ``dequeue``, ``switch_in``}
> +- *V* = { ``clk`` }
> +- x\ :subscript:`0` = ``dequeue``
> +- X\ :subscript:`m` = {``dequeue``}
> +- *f* =
> +   - *f*\ (``enqueued``, ``switch_in``) = ``running``
> +   - *f*\ (``running``, ``dequeue``) = ``dequeued``
> +   - *f*\ (``dequeued``, ``enqueue``, ``reset(clk)``) = ``enqueued``
> +- *i* =
> +   - *i*\ (``enqueued``) = ``clk < threshold``
> +
> +Graphically::
> +
> +    |
> +    |
> +    v
> +  #=========================#
> +  H        dequeued         H <+
> +  #=========================#  |
> +    |                          |
> +    | enqueue; reset(clk)      |
> +    v                          |
> +  +-------------------------+  |
> +  |        enqueued         |  |
> +  |    clk < threshold      |  | dequeue
> +  +-------------------------+  |
> +    |                          |
> +    | switch_in                |
> +    v                          |
> +  +-------------------------+  |
> +  |         running         | -+
> +  +-------------------------+
> +
> +In this case, we moved the guard as an invariant to the ``enqueued`` state,
> +this means we not only forbid the occurrence of ``switch_in`` when ``clk`` is
> +past the threshold but also mark as invalid in case we are *still* in
> +``enqueued`` after the threshold. This model is effectively in an invalid state
> +as soon as a task is starving, rather than when the starving task finally runs.
> +
> +Hybrid Automaton in C
> +---------------------
> +
> +The definition of hybrid automata in C is heavily based on the deterministic
> +automata one. Specifically, we add the set of environment variables and the
> +constraints (both guards on transitions and invariants on states) as follows.
> +This is a combination of both iterations of the stall example::
> +
> +  /* enum representation of X (set of states) to be used as index */
> +  enum states {
> +	dequeued = 0,

I think you already removed this " = 0" in an earlier patch?

> +	enqueued,
> +	running,
> +	state_max
> +  };
> +
> +  #define INVALID_STATE state_max
> +
> +  /* enum representation of E (set of events) to be used as index */
> +  enum events {
> +	dequeue = 0,
> +	enqueue,
> +	switch_in,
> +	event_max
> +  };
> +
> +  /* enum representation of V (set of environment variables) to be used as index */
> +  enum envs {
> +	clk = 0,
> +	env_max,
> +	env_max_stored = env_max
> +  };
> +
> +  struct automaton {
> +	char *state_names[state_max];                  // X: the set of states
> +	char *event_names[event_max];                  // E: the finite set of events
> +	char *env_names[env_max];                      // V: the finite set of env vars
> +	unsigned char function[state_max][event_max];  // f: transition function
> +	unsigned char initial_state;                   // x_0: the initial state
> +	bool final_states[state_max];                  // X_m: the set of marked states
> +  };
> +
> +  struct automaton aut = {
> +	.state_names = {
> +		"dequeued",
> +		"enqueued",
> +		"running"
> +	},
> +	.event_names = {
> +		"dequeue",
> +		"enqueue",
> +		"switch_in"
> +	},
> +	.env_names = {
> +		"clk"
> +	},
> +	.function = {
> +		{ INVALID_STATE,      enqueued, INVALID_STATE },
> +		{ INVALID_STATE, INVALID_STATE,       running },
> +		{      dequeued, INVALID_STATE, INVALID_STATE },
> +	},
> +	.initial_state = dequeued,
> +	.final_states = { 1, 0, 0 },
> +  };
> +
> +  static bool verify_constraint(enum states curr_state, enum events event,
> +                                enum states next_state)
> +  {
> +	bool res = true;
> +
> +	/* Validate guards as part of f */
> +	if (curr_state == enqueued && event == sched_switch_in)
> +		res = get_env(clk) < threshold;
> +	else if (curr_state == dequeued && event == sched_wakeup)
> +		reset_env(clk);
> +
> +	/* Validate invariants in i */
> +    if (next_state == curr_state || !res)
   ^^^^
   indentation error ;)

> +		return res;
> +	if (next_state == enqueued)
> +		ha_start_timer_jiffy(ha_mon, clk, threshold_jiffies);
> +	else if (curr_state == enqueued)
> +		res = !ha_cancel_timer(ha_mon);
> +	return res;
> +  }
> +
> +The function ``verify_constraint``, here reported as simplified, checks guards,
> +performs resets and starts timers to validate invariants according to
> +specification.
> +Due to the complex nature of environment variables, the user needs to provide
> +functions to get and reset environment variables, although we provide some
> +helpers for common types (e.g. clocks with ns or jiffy granularity).

Is there theoretical reason that functions to get/set variables cannot
be generated? Or you just do not have time for it yet?

> +Since invariants are only defined as clock expirations (e.g. *clk <
> +threshold*), the callback for timers armed when entering the state is in fact a
> +failure in the model and triggers a reaction. Leaving the state stops the timer
> +and checks for its expiration, in case the callback was late.

"callback for timers armed when entering the state is in fact a failure
in the model and triggers a reaction." - I have problem parsing this
sentence. How can "callback for timers" be armed? Or do you mean arming
timers while entering a state is a failure in the model? What is it a failure?

> +It is important to note that timers introduce overhead, if the monitor has
> +several instances (e.g. all tasks) this can become an issue.
> +If the monitor is guaranteed to *eventually* leave the state and the incurred
> +delay to wait for the next event is acceptable, guards can be use to lower the
> +monitor's overhead.

How about having some sort of a "background task" which periodically
verifies the invariants?

> +For instance in the stall example, if we are only interested in reporting
> +stalled tasks, rather than reacting as soon as a task is stalled, and
> +``switch_in`` is eventually going to occur, we can use the first iteration.
> +
> +Graphviz .dot format
> +--------------------
> +
> +Also the Graphviz representation of hybrid automata is an extension of the
> +deterministic automata one. Specifically, guards can be provided in the event
> +name separated by ``;``::
> +
> +    "state_start" -> "state_dest" [ label = "sched_waking;preemptible==0;reset(clk)" ];
> +
> +Invariant can be specified in the state label (not the node name!) separated by ``\n``::
> +
> +    "enqueued" [label = "enqueued\nclk < threshold_jiffies"];
> +
> +Constraints can be specified as valid C comparisons and allow spaces, the first
> +element of the comparison must be the clock while the second is a numerical or
> +parametrised value. Guards allow comparisons to be combined with boolean
> +operations (``&&`` and ``||``), resets must be separated from other constraints.
> +
> +This is the full example of the last version of the 'stall' model in DOT::
> +
> +  digraph state_automaton {
> +      {node [shape = circle] "enqueued"};
> +      {node [shape = plaintext, style=invis, label=""] "__init_dequeued"};
> +      {node [shape = doublecircle] "dequeued"};
> +      {node [shape = circle] "running"};
> +      "__init_dequeued" -> "dequeued";
> +      "enqueued" [label = "enqueued\nclk < threshold_jiffies"];
> +      "running" [label = "running"];
> +      "dequeued" [label = "dequeued"];
> +      "enqueued" -> "running" [ label = "switch_in" ];
> +      "running" -> "dequeued" [ label = "dequeue" ];
> +      "dequeued" -> "enqueued" [ label = "enqueue;reset(clk)" ];
> +      { rank = min ;
> +          "__init_dequeued";
> +          "dequeued";
> +      }

Btw, the last block (rank = min) doesn't seem to serve any purpose. But
the last time I checked months ago, the parser explodes if it is
removed, not sure if it still does now. But this is another reason that
I would like a rewrite.

Nam
