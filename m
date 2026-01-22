Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ABE35B65C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Jan 2026 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097328; cv=none; b=QW/sgq0wfPgGXfnhH0Dpj1uKgimcqB8fwbWRQiisl26K1aeM40gUl0xsYOjn5KNz3IqAhyXoA5AIqQe6jljU7LqKR5fspnhquYrAPzRZIpu5f5DnUm8T8RpmcijhPHXyv0eUGM/Bs5MB4hANA5Th6LsWx4Me2aKY8xQxWF5c8do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097328; c=relaxed/simple;
	bh=elv067gzZPYrJo+xfZ7AVJUoJ7snMuof8d6ZLwst0VE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5xp5a2yVRWFTGj57+quX5VSvfkyRUTbuzpR7BPK0ZFxk36l6w7CoKzaeMPi3/WynIB1W2IKyYqAiInP4H93AgctOAWKCdZ4ylNoG5BsgW5EtAGqMuiPb3lIYiAQQb3Sjnbdw0akXhAMk5Iv+RzHEiChFhIeUffaQ2oeO5KEY9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VX0morOc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VX0morOc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769097315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LbBrl4xLqKKET29i+NviaUgwfD4u8WFwZwQJw+Q9Cfo=;
	b=VX0morOctQpNAdvKIe4s78+1+htUmVybR3hhHThrdIJq2xYnEAPqzeTs+UngIye3HBsgXA
	RXce657pl9LAmI24l1B1ctJD9kpOPfh/sc57A2mMaNrwmjgaEJIfm1nDuw3fTr3sT29GyK
	91oIeROH7W6BekcqchXG80W6znWZJL8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-vyUmyPSEO6OWYPrYKRtd-Q-1; Thu,
 22 Jan 2026 10:55:12 -0500
X-MC-Unique: vyUmyPSEO6OWYPrYKRtd-Q-1
X-Mimecast-MFC-AGG-ID: vyUmyPSEO6OWYPrYKRtd-Q_1769097311
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3ECDE19775A4;
	Thu, 22 Jan 2026 15:55:11 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.47])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8C8D61800577;
	Thu, 22 Jan 2026 15:55:07 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 00/15] rv: Add Hybrid Automata monitor type, per-object and deadline monitors
Date: Thu, 22 Jan 2026 16:54:45 +0100
Message-ID: <20260122155500.362683-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This series contains several related changes, the main areas are:

* hybrid automata

    Hybrid automata are an extension of deterministic automata where each
    state transition is validating a constraint on a finite number of
    environment variables.

    Hybrid automata can be used to implement timed automata, where the
    environment variables are clocks.

* per-object monitors

    Define the generic per-object monitor allow RV monitors on any kind
    of object where the user can specify how to get an id (e.g. pid for
    tasks) and the data type for the monitor_target (e.g. struct
    task_struct * for tasks).

    The monitor storage (e.g. the rv monitor, pointer to the target, etc.)
    is stored in a hash table indexed by id.

* deadline monitors collection

    Add the throttle and nomiss monitors to validate timing aspects of
    the deadline scheduler, as they work for tasks and servers, their
    inclusion requires also per-object monitors (for dl entities).
    Also add the boost and laxity monitors specific to servers.

This series is based on the previously sent [1] that includes
preliminary patches present in V2 [2] and already reviewed. As such this
series is simplified and includes only relevant new changes.

These models were found stable during testing if 63be0c9e5489
("sched/deadline: Fix server stopping with runnable tasks") is applied.

The entire series can also be found on:

  git.kernel.org/pub/scm/linux/kernel/git/gmonaco/linux.git rv_hybrid_automata

Changes since V4:
* Do not fire enqueue tracepoint for delayed enqueues
* Do not use boosted dl_se in monitors
* Add enqueue/dequeue validation on snroc model
* Do not export pi_of to deadline.h
* Remove useless variable reset when resetting Hybrid Automata

Changes since V3:
* Improve ns to jiffy rounding in HA timers
* Use da_handle_start_run_event not to lose the first event in opid
* Sort self_loop_reset_events in rvgen to avoid unpredictable order
* Add enqueue/dequeue tracepoints (Nam Cao)
* Rename handle_syscall as it collides with some UM function
* Simplify idle handling on nomiss and throttle from sleeping
* Improve switch_out for servers in throttle
* Rely on enqueue/dequeue tracepoints instead of syscalls
* Improve timing conditions in laxity and handle resume action
* Remove fragile Stopping state from boost

Changes since V2 [2]:
* Adapt models to new dl server behaviour
* Rearrange start/handle helpers to share more code
* Improve documentation clarity after review
* Extend stall model to handle preemption
* Improve functions naming for HA helpers
* Use kmalloc_nolock for per-obj storage allocation
* Add boost and laxity monitors for deadline servers
* Add _is_id_monitor() in dot2k to handle per-obj together with per-task
* Rename dl argument to dl_se in tracepoints
* Use __COUNTER__ in dl monitor syscall helpers
* Fix conflicts after rebase (cond_react -> rv_react)
* General cleanup

Changes since V1 [3]:
* Cleanup unused trace events definitions
* Improve hybrid automata description about use of timers
* Unify event handler internals across DA monitor types
* Implement timer wheel alternative for invariants
* Extend models to consider timing of task switches (in before deadline,
  out after throttle)
* Refactor tracepoints and per-object monitors to allow server events
  from remote CPUs
* Changed clock representation in case of invariants (time to expire vs
  time since reset) and allow conversion without reset
* Extend dot2k to understand the graph relations and suggest where
  invariant conversions are needed
* General cleanup of rvgen scripts

[1] - https://lore.kernel.org/lkml/20251126104241.291258-1-gmonaco@redhat.com
[2] - https://lore.kernel.org/lkml/20250919140954.104920-1-gmonaco@redhat.com
[3] - https://lore.kernel.org/lkml/20250814150809.140739-1-gmonaco@redhat.com

To: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
To: Juri Lelli <jlelli@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org

Gabriele Monaco (14):
  rv: Unify DA event handling functions across monitor types
  rv: Add Hybrid Automata monitor type
  verification/rvgen: Allow spaces in and events strings
  verification/rvgen: Add support for Hybrid Automata
  Documentation/rv: Add documentation about hybrid automata
  rv: Add sample hybrid monitors stall
  rv: Convert the opid monitor to a hybrid automaton
  sched: Add deadline tracepoints
  rv: Add enqueue/dequeue to snroc monitor
  rv: Add support for per-object monitors in DA/HA
  verification/rvgen: Add support for per-obj monitors
  sched/deadline: Move some utility functions to deadline.h
  rv: Add deadline monitors
  rv: Add dl_server specific monitors

Nam Cao (1):
  sched: Add task enqueue/dequeue trace points

 Documentation/tools/rv/index.rst              |   1 +
 Documentation/tools/rv/rv-mon-stall.rst       |  44 ++
 .../trace/rv/deterministic_automata.rst       |   2 +-
 Documentation/trace/rv/hybrid_automata.rst    | 341 +++++++++
 Documentation/trace/rv/index.rst              |   3 +
 Documentation/trace/rv/monitor_deadline.rst   | 270 ++++++++
 Documentation/trace/rv/monitor_sched.rst      | 101 ++-
 Documentation/trace/rv/monitor_stall.rst      |  43 ++
 Documentation/trace/rv/monitor_synthesis.rst  | 117 +++-
 include/linux/rv.h                            |  39 ++
 include/linux/sched/deadline.h                |  29 +
 include/rv/da_monitor.h                       | 654 +++++++++++++-----
 include/rv/ha_monitor.h                       | 478 +++++++++++++
 include/trace/events/sched.h                  |  29 +
 kernel/sched/core.c                           |  14 +-
 kernel/sched/deadline.c                       |  35 +-
 kernel/sched/sched.h                          |   2 +
 kernel/trace/rv/Kconfig                       |  21 +
 kernel/trace/rv/Makefile                      |   6 +
 kernel/trace/rv/monitors/boost/Kconfig        |  15 +
 kernel/trace/rv/monitors/boost/boost.c        | 232 +++++++
 kernel/trace/rv/monitors/boost/boost.h        | 146 ++++
 kernel/trace/rv/monitors/boost/boost_trace.h  |  19 +
 kernel/trace/rv/monitors/deadline/Kconfig     |  10 +
 kernel/trace/rv/monitors/deadline/deadline.c  |  35 +
 kernel/trace/rv/monitors/deadline/deadline.h  | 168 +++++
 kernel/trace/rv/monitors/laxity/Kconfig       |  14 +
 kernel/trace/rv/monitors/laxity/laxity.c      | 248 +++++++
 kernel/trace/rv/monitors/laxity/laxity.h      | 133 ++++
 .../trace/rv/monitors/laxity/laxity_trace.h   |  19 +
 kernel/trace/rv/monitors/nomiss/Kconfig       |  15 +
 kernel/trace/rv/monitors/nomiss/nomiss.c      | 279 ++++++++
 kernel/trace/rv/monitors/nomiss/nomiss.h      | 130 ++++
 .../trace/rv/monitors/nomiss/nomiss_trace.h   |  19 +
 kernel/trace/rv/monitors/opid/Kconfig         |  11 +-
 kernel/trace/rv/monitors/opid/opid.c          | 111 +--
 kernel/trace/rv/monitors/opid/opid.h          |  86 +--
 kernel/trace/rv/monitors/opid/opid_trace.h    |   4 +
 kernel/trace/rv/monitors/snroc/snroc.c        |  18 +-
 kernel/trace/rv/monitors/snroc/snroc.h        |  46 +-
 kernel/trace/rv/monitors/stall/Kconfig        |  13 +
 kernel/trace/rv/monitors/stall/stall.c        | 150 ++++
 kernel/trace/rv/monitors/stall/stall.h        |  81 +++
 kernel/trace/rv/monitors/stall/stall_trace.h  |  19 +
 kernel/trace/rv/monitors/throttle/Kconfig     |  15 +
 kernel/trace/rv/monitors/throttle/throttle.c  | 250 +++++++
 kernel/trace/rv/monitors/throttle/throttle.h  | 116 ++++
 .../rv/monitors/throttle/throttle_trace.h     |  19 +
 kernel/trace/rv/rv_trace.h                    |  70 +-
 tools/verification/models/deadline/boost.dot  |  48 ++
 tools/verification/models/deadline/laxity.dot |  37 +
 tools/verification/models/deadline/nomiss.dot |  41 ++
 .../verification/models/deadline/throttle.dot |  44 ++
 tools/verification/models/sched/opid.dot      |  36 +-
 tools/verification/models/sched/snroc.dot     |  30 +-
 tools/verification/models/stall.dot           |  22 +
 tools/verification/rvgen/__main__.py          |   8 +-
 tools/verification/rvgen/rvgen/automata.py    | 151 +++-
 tools/verification/rvgen/rvgen/dot2c.py       |  49 ++
 tools/verification/rvgen/rvgen/dot2k.py       | 488 ++++++++++++-
 tools/verification/rvgen/rvgen/generator.py   |   4 +-
 .../rvgen/rvgen/templates/dot2k/main.c        |   2 +-
 .../rvgen/templates/dot2k/trace_hybrid.h      |  16 +
 63 files changed, 5211 insertions(+), 485 deletions(-)
 create mode 100644 Documentation/tools/rv/rv-mon-stall.rst
 create mode 100644 Documentation/trace/rv/hybrid_automata.rst
 create mode 100644 Documentation/trace/rv/monitor_deadline.rst
 create mode 100644 Documentation/trace/rv/monitor_stall.rst
 create mode 100644 include/rv/ha_monitor.h
 create mode 100644 kernel/trace/rv/monitors/boost/Kconfig
 create mode 100644 kernel/trace/rv/monitors/boost/boost.c
 create mode 100644 kernel/trace/rv/monitors/boost/boost.h
 create mode 100644 kernel/trace/rv/monitors/boost/boost_trace.h
 create mode 100644 kernel/trace/rv/monitors/deadline/Kconfig
 create mode 100644 kernel/trace/rv/monitors/deadline/deadline.c
 create mode 100644 kernel/trace/rv/monitors/deadline/deadline.h
 create mode 100644 kernel/trace/rv/monitors/laxity/Kconfig
 create mode 100644 kernel/trace/rv/monitors/laxity/laxity.c
 create mode 100644 kernel/trace/rv/monitors/laxity/laxity.h
 create mode 100644 kernel/trace/rv/monitors/laxity/laxity_trace.h
 create mode 100644 kernel/trace/rv/monitors/nomiss/Kconfig
 create mode 100644 kernel/trace/rv/monitors/nomiss/nomiss.c
 create mode 100644 kernel/trace/rv/monitors/nomiss/nomiss.h
 create mode 100644 kernel/trace/rv/monitors/nomiss/nomiss_trace.h
 create mode 100644 kernel/trace/rv/monitors/stall/Kconfig
 create mode 100644 kernel/trace/rv/monitors/stall/stall.c
 create mode 100644 kernel/trace/rv/monitors/stall/stall.h
 create mode 100644 kernel/trace/rv/monitors/stall/stall_trace.h
 create mode 100644 kernel/trace/rv/monitors/throttle/Kconfig
 create mode 100644 kernel/trace/rv/monitors/throttle/throttle.c
 create mode 100644 kernel/trace/rv/monitors/throttle/throttle.h
 create mode 100644 kernel/trace/rv/monitors/throttle/throttle_trace.h
 create mode 100644 tools/verification/models/deadline/boost.dot
 create mode 100644 tools/verification/models/deadline/laxity.dot
 create mode 100644 tools/verification/models/deadline/nomiss.dot
 create mode 100644 tools/verification/models/deadline/throttle.dot
 create mode 100644 tools/verification/models/stall.dot
 create mode 100644 tools/verification/rvgen/rvgen/templates/dot2k/trace_hybrid.h


base-commit: 924400c1c29006d835408ea0962446d4a481e774
-- 
2.52.0

