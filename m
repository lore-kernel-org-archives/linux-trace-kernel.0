Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DF336897E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Mar 2026 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140237; cv=none; b=M99lXgDDr90sKFEXiAn0KqL0DYvJ6BSQlyuYIi1KWKPjIRXK5BIwOeHfX5P7TSAWYQjJfu0SscLFG1ptBEWPs4OGnwW9xSmyvpcuj539WiKlGqOzH6/nHOrOTeYQc8zYJcRVy8l7F5HiiZcdzsMYAwAE9Mymz+Hhl/uD2ztgWQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140237; c=relaxed/simple;
	bh=icxWkNHRHor0L3whxOHsjIJZVQxn7+PRqm+ZAabJFu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=nex6eKbfUOT24j79aDY5vuGLxwyLmMIx9UjJUoLNNYS+edO1ooHlff0Grph/zVSiRC64ns+KkAWaMMVy0u6TneJZHpDcw9POcZE5ZqnG5B2fCtJkyiGNrF6HKV8R48KU1bh68KRd+ZuorMkQToHjDIogfbFsHWzfS6as8WFzRnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aplSUDxm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aplSUDxm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773140234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WoShelTVriSKKsWTVQvAdaOOpG3T0grC6jKC657ngmg=;
	b=aplSUDxmOeZKyxXvD3unX3ltpuF99b/u8g4I044mrwV7FFMa0/DIvPMC/HpO6TOwn0lijI
	BLn9S0f97gJs2S2mRsgT0b6bn/omfDMBDFNF+WqafaOg4/T2ytY19ly+CGU2IwX1gTcpm7
	0/vifRqc+lF/xs6x29U49W4ScB9bCZM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-x63sqL3KOmSjSmK_b-vjhw-1; Tue,
 10 Mar 2026 06:57:13 -0400
X-MC-Unique: x63sqL3KOmSjSmK_b-vjhw-1
X-Mimecast-MFC-AGG-ID: x63sqL3KOmSjSmK_b-vjhw_1773140232
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 464C818005B6;
	Tue, 10 Mar 2026 10:57:12 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.35.53])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EBA1C18001FE;
	Tue, 10 Mar 2026 10:57:07 +0000 (UTC)
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
Subject: [PATCH v7 00/15] rv: Add Hybrid Automata monitor type, per-object and deadline monitors
Date: Tue, 10 Mar 2026 11:56:12 +0100
Message-ID: <20260310105627.332044-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: ckoFEinEmLzX2P9fTDeerlsO9RsAQaRPWpz_3b8IYPQ_1773140232
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

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

The entire series can also be found on:

  git.kernel.org/pub/scm/linux/kernel/git/gmonaco/linux.git rv_hybrid_automata

Changes since V6 [1]:
* Drop general task_is_scx_enabled() to use the kallsyms-based version
* Search for task and lock RCU in extract_params() callers
* Use offsetofend when copying sched_attr for better clarity
* Export sched_dl_update to modules and fix style
* Use consistent events in examples in docs
* Use cpu_of(rq) helper in tracepoint calls

Changes since V5 [2]:
* Export task_is_scx_enabled() for monitors code to determine if tasks are ext
* tracepoints:
    - Add dl_se type to differentiate between fair and ext servers
    - Add event to track dl_update_curr not firing other events
* monitors:
    - Add support for ext server
    - Remove mostly unused dl_server_start from nomiss
    - Allow to skip runtime constraint on throttle monitor
    - Consider also BATCH and IDLE as fair policies
    - Handle events only for supported deadline entities (future proof)
    - Add missing transition running -> zero_laxity_wait
    - Handle dl_update event in laxity to cover missing update without
      enqueue nor replenish when multiple server types are active
    - Cleanup and sort constraints as generated
* rvgen:
    - Use f-strings in newly added code and cleanup
    - Sort constraints for predictable generated code

Changes since V4 [3]:
* Do not fire enqueue tracepoint for delayed enqueues
* Do not use boosted dl_se in monitors
* Add enqueue/dequeue validation on snroc model
* Do not export pi_of to deadline.h
* Remove useless variable reset when resetting Hybrid Automata

Changes since V3 [4]:
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

[1] - https://lore.kernel.org/lkml/20260225095122.80683-1-gmonaco@redhat.com
[2] - https://lore.kernel.org/lkml/20260122155500.362683-1-gmonaco@redhat.com
[3] - https://lore.kernel.org/lkml/20260116123911.130300-1-gmonaco@redhat.com
[4] - https://lore.kernel.org/lkml/20251205131621.135513-1-gmonaco@redhat.com

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
  rv: Add enqueue/dequeue to snroc monitor
  rv: Add support for per-object monitors in DA/HA
  verification/rvgen: Add support for per-obj monitors
  sched: Add deadline tracepoints
  sched/deadline: Move some utility functions to deadline.h
  rv: Add deadline monitors
  rv: Add dl_server specific monitors

Nam Cao (1):
  sched: Add task enqueue/dequeue trace points

 Documentation/tools/rv/index.rst              |   1 +
 Documentation/tools/rv/rv-mon-stall.rst       |  44 ++
 .../trace/rv/deterministic_automata.rst       |   2 +-
 Documentation/trace/rv/hybrid_automata.rst    | 341 ++++++++++
 Documentation/trace/rv/index.rst              |   3 +
 Documentation/trace/rv/monitor_deadline.rst   | 278 ++++++++
 Documentation/trace/rv/monitor_sched.rst      | 101 ++-
 Documentation/trace/rv/monitor_stall.rst      |  43 ++
 Documentation/trace/rv/monitor_synthesis.rst  | 117 +++-
 include/linux/rv.h                            |  39 ++
 include/linux/sched/deadline.h                |  27 +
 include/rv/da_monitor.h                       | 644 +++++++++++++-----
 include/rv/ha_monitor.h                       | 478 +++++++++++++
 include/trace/events/sched.h                  |  34 +
 kernel/sched/core.c                           |  17 +-
 kernel/sched/deadline.c                       |  52 +-
 kernel/sched/sched.h                          |   2 +
 kernel/trace/rv/Kconfig                       |  21 +
 kernel/trace/rv/Makefile                      |   6 +
 kernel/trace/rv/monitors/boost/Kconfig        |  15 +
 kernel/trace/rv/monitors/boost/boost.c        | 258 +++++++
 kernel/trace/rv/monitors/boost/boost.h        | 146 ++++
 kernel/trace/rv/monitors/boost/boost_trace.h  |  19 +
 kernel/trace/rv/monitors/deadline/Kconfig     |  10 +
 kernel/trace/rv/monitors/deadline/deadline.c  |  41 ++
 kernel/trace/rv/monitors/deadline/deadline.h  | 202 ++++++
 kernel/trace/rv/monitors/laxity/Kconfig       |  14 +
 kernel/trace/rv/monitors/laxity/laxity.c      | 279 ++++++++
 kernel/trace/rv/monitors/laxity/laxity.h      | 140 ++++
 .../trace/rv/monitors/laxity/laxity_trace.h   |  19 +
 kernel/trace/rv/monitors/nomiss/Kconfig       |  15 +
 kernel/trace/rv/monitors/nomiss/nomiss.c      | 293 ++++++++
 kernel/trace/rv/monitors/nomiss/nomiss.h      | 123 ++++
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
 kernel/trace/rv/monitors/throttle/throttle.c  | 285 ++++++++
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
 tools/verification/rvgen/rvgen/dot2c.py       |  47 ++
 tools/verification/rvgen/rvgen/dot2k.py       | 489 ++++++++++++-
 tools/verification/rvgen/rvgen/generator.py   |   4 +-
 .../rvgen/rvgen/templates/dot2k/main.c        |   2 +-
 .../rvgen/templates/dot2k/trace_hybrid.h      |  16 +
 63 files changed, 5382 insertions(+), 480 deletions(-)
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


base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
-- 
2.53.0

