Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F2F30F801
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593621; cv=none; b=l4jyWunksoG42VhRibbFXSTYBpSmNByIkBC/z0tLmI4r6kSNl/2hfzRtQtPSP8sqTe1Cgr/s5XqCpzv5Rfmy0YOIwlXpiKSJF/6Tm4pazooeOct/IkVUkHYfdYWkFa6TW8Rz1JRA7xDT+Ns36eCtrPC+9gxKtnG/N/I2ZUvkXv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593621; c=relaxed/simple;
	bh=opdgtPUwwDdJpj9sWKIdlaSMiVOYQJVwVjeeyQ9oIkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DqA6koQl6ovC0sEaZn/oKQUUpupdIWJnE0KyXbNT0eVmwaQGm+xaWLu5FJdEnuZAtCwZFy2QucitZMVU+Rya2LmThIRcyrajnd4OHUal5QhO3YkorES5nPbH0wsXC55ma9gC+w4Ll8M08jPsp97Yzp8PF3WnTM1q8qmJrS8iNfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VKYCMt4j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKYCMt4j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755593617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JO1DKPCq6yJklGTx7dbbpbTkv22J36W2mYtn3fpAG84=;
	b=VKYCMt4jr83LD+01i1KWSFqaLBnN+pGBBLId/MaLWz9yH6DdV0l3Zxmk8dspPqZ7xXviGt
	hIDxBEbcX17grsyK1PFhEevTL0wBoOpcb/cw7RcDdq8ZPNns0k86Jt8yD62r/Z5PdJSMAs
	Zsia5tRmVuYT9CwRMQcujuo/3uZRvEQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677--dZ4Mu-lMwKlePL3Z_gXkQ-1; Tue, 19 Aug 2025 04:53:37 -0400
X-MC-Unique: -dZ4Mu-lMwKlePL3Z_gXkQ-1
X-Mimecast-MFC-AGG-ID: -dZ4Mu-lMwKlePL3Z_gXkQ_1755593616
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e88f379fafso1261512085a.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755593616; x=1756198416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JO1DKPCq6yJklGTx7dbbpbTkv22J36W2mYtn3fpAG84=;
        b=c8SwjtQfmFZ5Huy8LVO/V3F5t9n90ej61/im5y/7PsgRiZThyuyeM3sqM3n910KaGf
         5T2n1K40O4Zk1EQ9nwKPWqaR9uN3AFso8Q8vk/dgS9zLiB7OGBvEifhEMjzuZ66gX3nB
         pVYY9d+rkUjxQEFPD+/kuOinKj6uOB/36VEFYNRVmKNk7Z4SaaO6AhlAwDxrIIErMwr7
         gXWdlB2qzAne5W1BwsElVdvQcpXolRqj0Q0t/qk3TWw/tFJElI+bpiGbB+B4HWK4yo+6
         bXa4rUkriGFLmF2r2osPfUxZPpEOwIMJYFCO+251VMbxawkOz396WYqJm32n02bbh8NE
         wm8w==
X-Forwarded-Encrypted: i=1; AJvYcCX/mDxG9ygA25hxvC923yvspG1hnSJwKP/IT4lN7xHz9VLWh/S5OBcoYz1lmo/OC3izrg2GDHNlHkcmPWgv9riSeTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz804tMP67QKklVnBMoXUj9lgUGvhWtR9jES6rGRTYkcF8faXzu
	qPg+mO1N/6UjseXzc4+3yONdNNgZgmwkUAs9h4gaDiUwbEMRNkAVfdp9i4duSt6d72HMbAH5i/N
	RagG0WaLan1AgTeBrqAcPja7e3/Hy/B0ercRh3OaBKjWZZp78A2oLsftfQdwYmE3Rcf8ZHWcyHj
	TTAjM1OeVO
X-Gm-Gg: ASbGncsGgTHtgdVsCpulojgXACTBtvzxeOtKoo+23eyZRVCSpe2rF6gCn0zJvoMthYh
	Da9WF2Np0b7ZeMNb1YpymYQUtKfxGqNBd5K6pt6UhDKfV064f42IbFwd45L+Tv1IxaiMXsS2yfc
	zPPQ/WKXvovKfvCSnE5n7su0lal5nugkkhwzBAptFKLOVyILp0i/8MavPtPK0JEETdo65dDwgPy
	y4sezCufofjIYuvZTm1cl8jA2WqN1fKONjfi50lM6XQ74xll0wBi125em3Iy5zmrKjf0SWBCZcp
	Bd8CTMG1Y9l5GJnWYXMkKM7reIL2bZv/cdqc1GeFtEO2V0FdXkHT2ZAVbc4/wKvfIRkO
X-Received: by 2002:a05:620a:a80f:b0:7e9:f820:2b5c with SMTP id af79cd13be357-7e9f8205e29mr36024785a.84.1755593615817;
        Tue, 19 Aug 2025 01:53:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKbsOpC/+7yfXwNIHwimQ+STcRpO6Ca6PTpymw6hxKHAD4WPzMgzr6toI0w9XDZwls76Lq9g==
X-Received: by 2002:a05:620a:a80f:b0:7e9:f820:2b5c with SMTP id af79cd13be357-7e9f8205e29mr36023385a.84.1755593615329;
        Tue, 19 Aug 2025 01:53:35 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.81.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e0228f1sm746750585a.8.2025.08.19.01.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 01:53:34 -0700 (PDT)
Date: Tue, 19 Aug 2025 10:53:29 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 11/17] Documentation/rv: Add documentation about
 hybrid automata
Message-ID: <aKQ7iaSb9GGUtuCZ@jlelli-thinkpadt14gen4.remote.csb>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-12-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250814150809.140739-12-gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2S8YsZadIw7jX8LzHc8TGw7cZv3xTNfDPr9FhWB2F8M_1755593616
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

On 14/08/25 17:08, Gabriele Monaco wrote:
> Describe theory and implementation of hybrid automata in the dedicated
> page hybrid_automata.rst
> Include a section on how to integrate a hybrid automaton in
> monitor_synthesis.rst
> Also remove a hanging $ in deterministic_automata.rst
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>  .../trace/rv/deterministic_automata.rst       |   2 +-
>  Documentation/trace/rv/hybrid_automata.rst    | 307 ++++++++++++++++++
>  Documentation/trace/rv/index.rst              |   1 +
>  Documentation/trace/rv/monitor_synthesis.rst  |  86 +++++
>  4 files changed, 395 insertions(+), 1 deletion(-)
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
> index 000000000000..ecfff26d65bd
> --- /dev/null
> +++ b/Documentation/trace/rv/hybrid_automata.rst
> @@ -0,0 +1,307 @@
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
> +- *i* : *X* -> *C(V)* is the invariant assignment function, this is a
> +  constraint assigned to each state in *X*, every state in *X* must be left
> +  before the invariant turns to false. We can omit the representation of
> +  invariants whose value is true regardless of the valuation of *V*.
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
> +It is important to note that any valid hybrid automaton is a valid
> +deterministic automaton with additional guards and invariants. Those can only
> +further constrain what transitions are valid but it is not possible to define
> +transition functions starting from the same state in *X* and the same event in
> +*E* but ending up in different states in *X* based on the valuation of *V*.
> +
> +Examples
> +--------

Maybe add subsection titles to better mark separation between different
examples?

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
> +As a sample timed automaton we can define 'stall' as:

Maybe indicate this first one is a not properly correct example (correct
version follows)?

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
> +As this is not exactly what is intended, we can change the model as:
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
> +constraints (both guards on transitions and invariants on states) as follows::
> +
> +  /* enum representation of X (set of states) to be used as index */
> +  enum states {
> +	dequeued = 0,
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
> +				 enum states next_state)
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
> +	if (next_state == curr_state)
> +		return res;
> +	if (next_state == enqueued && res)
> +		start_timer(clk, threshold);

So, then the timer callback checks the invariant and possibly reports
failure?

> +	else
> +		cancel_timer();
> +	return res;
> +  }
> +
> +The function ``verify_constraint``, here reported as simplified, checks guards,
> +performs resets and starts timers to validate invariants according to
> +specification.
> +Due to the complex nature of environment variables, the user needs to provide
> +functions to get and reset environment variables, although we provide some
> +helpers for common types (e.g. clocks with ns or jiffy granularity).
> +Invariants defined in this way only make sense as clock expirations (e.g. *clk
> +< threshold*).

Thanks,
Juri

