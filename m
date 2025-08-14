Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCA421930B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184178; cv=none; b=qP3glGAgBMuJWkGAZgW1Ev14ltfUBAZt0r67wvl+wxaibo9Q8GmHHovYTayyekDr/mXkqR3XHg145j21t3XBaCVwuR2UUrULq24vGVFkJ/vALID7yZkdRDqYkEDphaLB3t4H1VDuCO3bIbPingvClMfdUVuv00q+3UKDd9vq8tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184178; c=relaxed/simple;
	bh=Ytt+GwLOQF6lNbGpxKq6MbUNEhgVYH/43PlqhE/y+4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnuEDcbE6nQN2sRzgjOzb5clxJTvcIz7Co07s1yOMh2MxUUCpHwaEDK3K8VwX2aghUOxlsds04tF1Y2bWSDMABmemuqkwTHurIuiVtMUX2FUP14L4KDFfrsca2XWZVU3QA2YGGrQhfE/NhV8lIEFfJP/PEkESTihRH+f5aIjk/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fR85xbJG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fR85xbJG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755184175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1mohDuCl0ZZagmBOAuDUIch+Z9jd935gCNczHyneeaQ=;
	b=fR85xbJGT1DshIMKP37y0QAARjeAfRHC7c2L31KtNhTqcKyMnxftbMgIK347sAMhg06vSy
	Zy3BPXWlw0Ph23xRYY2A+0PaUunPwaDw/jNjcM5mL0CR/GifU73uzKSklJRnBx68Tgg3ii
	l6zuzhh5a4ESaidwAtqAsHrczmdaVT8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-BwlvoRA1PQ6zYf1TEnSfnQ-1; Thu,
 14 Aug 2025 11:09:31 -0400
X-MC-Unique: BwlvoRA1PQ6zYf1TEnSfnQ-1
X-Mimecast-MFC-AGG-ID: BwlvoRA1PQ6zYf1TEnSfnQ_1755184170
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A12FD1800292;
	Thu, 14 Aug 2025 15:09:30 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 024D1180047F;
	Thu, 14 Aug 2025 15:09:24 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [RFC PATCH 11/17] Documentation/rv: Add documentation about hybrid automata
Date: Thu, 14 Aug 2025 17:08:03 +0200
Message-ID: <20250814150809.140739-12-gmonaco@redhat.com>
In-Reply-To: <20250814150809.140739-1-gmonaco@redhat.com>
References: <20250814150809.140739-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Describe theory and implementation of hybrid automata in the dedicated
page hybrid_automata.rst
Include a section on how to integrate a hybrid automaton in
monitor_synthesis.rst
Also remove a hanging $ in deterministic_automata.rst

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 .../trace/rv/deterministic_automata.rst       |   2 +-
 Documentation/trace/rv/hybrid_automata.rst    | 307 ++++++++++++++++++
 Documentation/trace/rv/index.rst              |   1 +
 Documentation/trace/rv/monitor_synthesis.rst  |  86 +++++
 4 files changed, 395 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/trace/rv/hybrid_automata.rst

diff --git a/Documentation/trace/rv/deterministic_automata.rst b/Documentation/trace/rv/deterministic_automata.rst
index d0638f95a455..7a1c2b20ec72 100644
--- a/Documentation/trace/rv/deterministic_automata.rst
+++ b/Documentation/trace/rv/deterministic_automata.rst
@@ -11,7 +11,7 @@ where:
 - *E* is the finite set of events;
 - x\ :subscript:`0` is the initial state;
 - X\ :subscript:`m` (subset of *X*) is the set of marked (or final) states.
-- *f* : *X* x *E* -> *X* $ is the transition function. It defines the state
+- *f* : *X* x *E* -> *X* is the transition function. It defines the state
   transition in the occurrence of an event from *E* in the state *X*. In the
   special case of deterministic automata, the occurrence of the event in *E*
   in a state in *X* has a deterministic next state from *X*.
diff --git a/Documentation/trace/rv/hybrid_automata.rst b/Documentation/trace/rv/hybrid_automata.rst
new file mode 100644
index 000000000000..ecfff26d65bd
--- /dev/null
+++ b/Documentation/trace/rv/hybrid_automata.rst
@@ -0,0 +1,307 @@
+Hybrid Automata
+===============
+
+Hybrid automata are an extension of deterministic automata, there are several
+definitions of hybrid automata in the literature. The adaptation implemented
+here is formally denoted by G and defined as a 7-tuple:
+
+        *G* = { *X*, *E*, *V*, *f*, x\ :subscript:`0`, X\ :subscript:`m`, *i* }
+
+- *X* is the set of states;
+- *E* is the finite set of events;
+- *V* is the finite set of environment variables;
+- x\ :subscript:`0` is the initial state;
+- X\ :subscript:`m` (subset of *X*) is the set of marked (or final) states.
+- *f* : *X* x *E* x *C(V)* -> *X* is the transition function.
+  It defines the state transition in the occurrence of an event from *E* in the
+  state *X*. Unlike deterministic automata, the transition function also
+  includes guards from the set of all possible constraints (defined as *C(V)*).
+  Guards can be true or false with the valuation of *V* when the event occurs,
+  and the transition is possible only when constraints are true. Similarly to
+  deterministic automata, the occurrence of the event in *E* in a state in *X*
+  has a deterministic next state from *X*, if the guard is true.
+- *i* : *X* -> *C(V)* is the invariant assignment function, this is a
+  constraint assigned to each state in *X*, every state in *X* must be left
+  before the invariant turns to false. We can omit the representation of
+  invariants whose value is true regardless of the valuation of *V*.
+
+The set of all possible constraints *C(V)* is defined according to the
+following grammar:
+
+        g = v < c | v > c | v <= c | v >= c | v == c | v != c | g && g | true
+
+With v a variable in *V* and c a numerical value.
+
+We define the special case of hybrid automata whose variables grow with uniform
+rates as timed automata. In this case, the variables are called clocks.
+As the name implies, timed automata can be used to describe real time.
+Additionally, clocks support another type of guard which always evaluates to true:
+
+        reset(v)
+
+The reset constraint is used to set the value of a clock to 0.
+
+It is important to note that any valid hybrid automaton is a valid
+deterministic automaton with additional guards and invariants. Those can only
+further constrain what transitions are valid but it is not possible to define
+transition functions starting from the same state in *X* and the same event in
+*E* but ending up in different states in *X* based on the valuation of *V*.
+
+Examples
+--------
+
+The 'wip' (wakeup in preemptive) example introduced as a deterministic automaton
+can also be described as:
+
+- *X* = { ``any_thread_running`` }
+- *E* = { ``sched_waking`` }
+- *V* = { ``preemptive`` }
+- x\ :subscript:`0` = ``any_thread_running``
+- X\ :subscript:`m` = {``any_thread_running``}
+- *f* =
+   - *f*\ (``any_thread_running``, ``sched_waking``, ``preemptive==0``) = ``any_thread_running``
+- *i* =
+   - *i*\ (``any_thread_running``) = ``true``
+
+Which can be represented graphically as::
+
+     |
+     |
+     v
+   #====================#   sched_waking;preemptive==0
+   H                    H ------------------------------+
+   H any_thread_running H                               |
+   H                    H <-----------------------------+
+   #====================#
+
+In this example, by using the preemptive state of the system as an environment
+variable, we can assert this constraint on ``sched_waking`` without requiring
+preemption events (as we would in a deterministic automaton), which can be
+useful in case those events are not available or not reliable on the system.
+
+Since all the invariants in *i* are true, we can omit them from the representation.
+
+As a sample timed automaton we can define 'stall' as:
+
+- *X* = { ``dequeued``, ``enqueued``, ``running``}
+- *E* = { ``enqueue``, ``dequeue``, ``switch_in``}
+- *V* = { ``clk`` }
+- x\ :subscript:`0` = ``dequeue``
+- X\ :subscript:`m` = {``dequeue``}
+- *f* =
+   - *f*\ (``enqueued``, ``switch_in``, ``clk < threshold``) = ``running``
+   - *f*\ (``running``, ``dequeue``) = ``dequeued``
+   - *f*\ (``dequeued``, ``enqueue``, ``reset(clk)``) = ``enqueued``
+- *i* = *omitted as all true*
+
+Graphically represented as::
+
+       |
+       |
+       v
+     #============================#
+     H          dequeued          H <+
+     #============================#  |
+       |                             |
+       | enqueue; reset(clk)         |
+       v                             |
+     +----------------------------+  |
+     |          enqueued          |  | dequeue
+     +----------------------------+  |
+       |                             |
+       | switch_in; clk < threshold  |
+       v                             |
+     +----------------------------+  |
+     |          running           | -+
+     +----------------------------+
+
+This model imposes that the time between when a task is enqueued (it becomes
+runnable) and when the task gets to run must be lower than a certain threshold.
+A failure in this model means that the task is starving.
+One problem in using guards on the edges in this case is that the model will
+not report a failure until the ``switch_in`` event occurs. This means that,
+according to the model, it is valid for the task never to run.
+As this is not exactly what is intended, we can change the model as:
+
+- *X* = { ``dequeued``, ``enqueued``, ``running``}
+- *E* = { ``enqueue``, ``dequeue``, ``switch_in``}
+- *V* = { ``clk`` }
+- x\ :subscript:`0` = ``dequeue``
+- X\ :subscript:`m` = {``dequeue``}
+- *f* =
+   - *f*\ (``enqueued``, ``switch_in``) = ``running``
+   - *f*\ (``running``, ``dequeue``) = ``dequeued``
+   - *f*\ (``dequeued``, ``enqueue``, ``reset(clk)``) = ``enqueued``
+- *i* =
+   - *i*\ (``enqueued``) = ``clk < threshold``
+
+Graphically::
+
+    |
+    |
+    v
+  #=========================#
+  H        dequeued         H <+
+  #=========================#  |
+    |                          |
+    | enqueue; reset(clk)      |
+    v                          |
+  +-------------------------+  |
+  |        enqueued         |  |
+  |    clk < threshold      |  | dequeue
+  +-------------------------+  |
+    |                          |
+    | switch_in                |
+    v                          |
+  +-------------------------+  |
+  |         running         | -+
+  +-------------------------+
+
+In this case, we moved the guard as an invariant to the ``enqueued`` state,
+this means we not only forbid the occurrence of ``switch_in`` when ``clk`` is
+past the threshold but also mark as invalid in case we are *still* in
+``enqueued`` after the threshold. This model is effectively in an invalid state
+as soon as a task is starving, rather than when the starving task finally runs.
+
+Hybrid Automaton in C
+---------------------
+
+The definition of hybrid automata in C is heavily based on the deterministic
+automata one. Specifically, we add the set of environment variables and the
+constraints (both guards on transitions and invariants on states) as follows::
+
+  /* enum representation of X (set of states) to be used as index */
+  enum states {
+	dequeued = 0,
+	enqueued,
+	running,
+	state_max
+  };
+
+  #define INVALID_STATE state_max
+
+  /* enum representation of E (set of events) to be used as index */
+  enum events {
+	dequeue = 0,
+	enqueue,
+	switch_in,
+	event_max
+  };
+
+  /* enum representation of V (set of environment variables) to be used as index */
+  enum envs {
+	clk = 0,
+	env_max,
+	env_max_stored = env_max
+  };
+
+  struct automaton {
+	char *state_names[state_max];                  // X: the set of states
+	char *event_names[event_max];                  // E: the finite set of events
+	char *env_names[env_max];                      // V: the finite set of env vars
+	unsigned char function[state_max][event_max];  // f: transition function
+	unsigned char initial_state;                   // x_0: the initial state
+	bool final_states[state_max];                  // X_m: the set of marked states
+  };
+
+  struct automaton aut = {
+	.state_names = {
+		"dequeued",
+		"enqueued",
+		"running"
+	},
+	.event_names = {
+		"dequeue",
+		"enqueue",
+		"switch_in"
+	},
+	.env_names = {
+		"clk"
+	},
+	.function = {
+		{ INVALID_STATE,      enqueued, INVALID_STATE },
+		{ INVALID_STATE, INVALID_STATE,       running },
+		{      dequeued, INVALID_STATE, INVALID_STATE },
+	},
+	.initial_state = dequeued,
+	.final_states = { 1, 0, 0 },
+  };
+
+  static bool verify_constraint(enum states curr_state, enum events event,
+				 enum states next_state)
+  {
+	bool res = true;
+
+	/* Validate guards as part of f */
+	if (curr_state == enqueued && event == sched_switch_in)
+		res = get_env(clk) < threshold;
+	else if (curr_state == dequeued && event == sched_wakeup)
+		reset_env(clk);
+
+	/* Validate invariants in i */
+	if (next_state == curr_state)
+		return res;
+	if (next_state == enqueued && res)
+		start_timer(clk, threshold);
+	else
+		cancel_timer();
+	return res;
+  }
+
+The function ``verify_constraint``, here reported as simplified, checks guards,
+performs resets and starts timers to validate invariants according to
+specification.
+Due to the complex nature of environment variables, the user needs to provide
+functions to get and reset environment variables, although we provide some
+helpers for common types (e.g. clocks with ns or jiffy granularity).
+Invariants defined in this way only make sense as clock expirations (e.g. *clk
+< threshold*).
+
+Graphviz .dot format
+--------------------
+
+Also the Graphviz representation of hybrid automata is an extension of the
+deterministic automata one. Specifically, guards can be provided in the event
+name separated by ``;``::
+
+    "state_start" -> "state_dest" [ label = "sched_waking;preemptible==0;reset(clk)" ];
+
+Invariant can be specified in the state label (not the node name!) separated by ``\n``::
+
+    "enqueued" [label = "enqueued\nclk < threshold_jiffies"];
+
+Constraints can be specified as valid C comparisons and allow spaces, the first
+element of the comparison must be the clock while the second is a numerical or
+parametrised value. Guards allow comparisons to be combined with boolean
+operations (``&&`` and ``||``), resets must be separated from other constraints.
+
+This is the full example of the last version of the 'stall' model in DOT::
+
+  digraph state_automaton {
+      {node [shape = circle] "enqueued"};
+      {node [shape = plaintext, style=invis, label=""] "__init_dequeued"};
+      {node [shape = doublecircle] "dequeued"};
+      {node [shape = circle] "running"};
+      "__init_dequeued" -> "dequeued";
+      "enqueued" [label = "enqueued\nclk < threshold_jiffies"];
+      "running" [label = "running"];
+      "dequeued" [label = "dequeued"];
+      "enqueued" -> "running" [ label = "switch_in" ];
+      "running" -> "dequeued" [ label = "dequeue" ];
+      "dequeued" -> "enqueued" [ label = "enqueue;reset(clk)" ];
+      { rank = min ;
+          "__init_dequeued";
+          "dequeued";
+      }
+  }
+
+References
+----------
+
+One book covering model checking and timed automata is::
+
+  Christel Baier and Joost-Pieter Katoen: Principles of Model Checking, The MIT Press, 2008.
+
+Hybrid automata are described in detail in::
+
+  Thomas Henzinger: The theory of hybrid automata, Proceedings 11th Annual IEEE Symposium on Logic in Computer Science (1996): 278-292.
diff --git a/Documentation/trace/rv/index.rst b/Documentation/trace/rv/index.rst
index a2812ac5cfeb..ad298784bda2 100644
--- a/Documentation/trace/rv/index.rst
+++ b/Documentation/trace/rv/index.rst
@@ -9,6 +9,7 @@ Runtime Verification
    runtime-verification.rst
    deterministic_automata.rst
    linear_temporal_logic.rst
+   hybrid_automata.rst
    monitor_synthesis.rst
    da_monitor_instrumentation.rst
    monitor_wip.rst
diff --git a/Documentation/trace/rv/monitor_synthesis.rst b/Documentation/trace/rv/monitor_synthesis.rst
index ce0c1a5104d4..fd886d842693 100644
--- a/Documentation/trace/rv/monitor_synthesis.rst
+++ b/Documentation/trace/rv/monitor_synthesis.rst
@@ -45,6 +45,7 @@ creating monitors. The header files are:
 
   * rv/da_monitor.h for deterministic automaton monitor.
   * rv/ltl_monitor.h for linear temporal logic monitor.
+  * rv/ha_monitor.h for hybrid automaton monitor.
 
 rvgen
 -----
@@ -252,6 +253,91 @@ the task, the monitor may need some time to start validating tasks which have
 been running before the monitor is enabled. Therefore, it is recommended to
 start the tasks of interest after enabling the monitor.
 
+rv/ha_monitor.h
++++++++++++++++
+
+The implementation of hybrid automaton monitors derives directly from the
+deterministic automaton one. Despite using a different header
+(``ha_monitor.h``) the functions to handle events are the same (e.g.
+``da_handle_event``).
+
+Additionally, the `rvgen` tool populates skeletons for the
+``ha_verify_constraint``, ``ha_get_env`` and ``ha_reset_env`` based on the
+monitor specification in the monitor source file.
+
+Unless the monitor relies on complex constraints, ``ha_verify_constraint``
+is typically ready as it is generated by `rvgen`:
+
+* standard constraints on edges are turned into the form::
+
+    res = ha_get_env(ha_mon, ENV) < VALUE;
+
+* reset constraints are turned into the form::
+
+    ha_reset_env(ha_mon, ENV);
+
+* constraints on the state are implemented using timers
+
+  - armed before entering the state
+
+  - cancelled while entering any other state
+
+  - untouched if the state does not change as a result of the event
+
+Constraint values can be specified in 3 forms:
+
+* literal value (with optional unit). E.g.::
+
+    preemptive == 0
+    clk < 100ns
+    threshold <= 10j
+
+* constant value (uppercase string). E.g.::
+
+    clk < MAX_NS
+
+* parameter (lowercase string). E.g.::
+
+    clk <= threshold_jiffies
+
+In all cases, `rvgen` will try to understand the type of the environment
+variable from the name or unit. For instance, constants or parameters
+terminating with `_NS` or `_jiffies` are intended as clocks with ns and jiffy
+granularity, respectively. Literals with measure unit `j` are jiffies and if a
+time unit is specified (`ns` to `s`), `rvgen` will convert the value to `ns`.
+
+Constants need to be defined by the user (but unlike the name, they don't
+necessarily need to be defined as constants). Parameters get converted to
+module parameters and the user needs to provide a default value.
+
+If `rvgen` determines that the variable is a clock, it provides the getter and
+resetter based on the unit. Otherwise, the user needs to provide an appropriate
+definition.
+Typically non-clock environment variables are not reset. In such case only the
+getter skeleton will be present in the file generated by `rvgen`.
+For instance, the getter for preemptive can be filled as::
+
+  static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs env)
+  {
+      if (env == preemptible)
+          return preempt_count() == 0;
+      return ENV_INVALID_VALUE;
+  }
+
+The function is supplied the ``ha_mon`` parameter in case some storage is
+required (as it is for clocks), but environment variables without reset do not
+require a storage and can ignore that argument.
+The number of environment variables requiring a storage is limited by
+``MAX_HA_ENV_LEN``, however such limitation doesn't stand for other variables.
+
+Finally, constraints on states are only valid for clocks and only if the
+constraint is of the form `clk < N`. This is because such constraints are
+implemented with the expiration of a timer.
+Typically the clock variables are reset just before arming the timer, but this
+doesn't have to be the case and the available functions take care of it.
+It is a responsibility of per-task monitors to make sure no timer is left
+running when the task exits.
+
 Final remarks
 -------------
 
-- 
2.50.1

