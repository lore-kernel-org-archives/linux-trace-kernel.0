Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969F03BD255
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Mar 2026 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869034; cv=none; b=KB7u/LMN5qk4JvFASrrKJiedFm/kTXtHeuOnHbeBEI4m3hr0j1FIuSMn5knJnwVZzN3fn8RyC9UgU9OrPhnRrpCiIE7f1DBkHxC/dFYpNfIKtQ6unwKWNqIzlVptaQdFzM2OHLZSlpLjyTx44n5FI43VZPsFMjhd2Z/0/McNJyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869034; c=relaxed/simple;
	bh=Y/bpKzRh4Qy6P4yBCv0qhzfzffuPY7rUj/H9iaNBXbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=PxYblm3G5282dZKL3LXN2IRouZfdIZ50uRvTJh+yJJnX7mDCeTmn1IsLHAazTBIKTA3uy9fdLrqIp+5ArmgfHxEequEh+U97GmmlgLjH8V2N0RMemXBN+pEW8sl5nUe8bfQqp5iEnb5zz688uaIySXXqyt3qYjetyGm9wJzeRNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eTqg5r06; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTqg5r06"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774869028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=boAMR9iuRYjcMSAEKZLROwnbdNicDsA8/VVNM6E/RWg=;
	b=eTqg5r06L/L5FpO6pDdcKGM2kW13ynz7nHDlFVA9U3t3NV4BPNHcCRn1IKNf8KdiREHSCs
	0uj1hC3QBdaC7i/ziRMrQsYpTmugW6gTGmUUva9DbCAwO8BHeSei9aNo9fHlRf4drrVPlz
	ugV6bJPc/U6cu487s5itTkxY26anwXQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-IWygTljTOE-gQ4sC8hr8FQ-1; Mon,
 30 Mar 2026 07:10:23 -0400
X-MC-Unique: IWygTljTOE-gQ4sC8hr8FQ-1
X-Mimecast-MFC-AGG-ID: IWygTljTOE-gQ4sC8hr8FQ_1774869022
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9DB041956056;
	Mon, 30 Mar 2026 11:10:22 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.33.13])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E257E30001A1;
	Mon, 30 Mar 2026 11:10:18 +0000 (UTC)
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
Subject: [PATCH v8 00/12] rv: Add Hybrid Automata monitor type, per-object and deadline monitors
Date: Mon, 30 Mar 2026 13:09:58 +0200
Message-ID: <20260330111010.153663-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: VYKHDPm5N69YaQYvV2GDz2iT-jF-XRnhycKc4iaPGxk_1774869022
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

    Add the nomiss monitor to validate timing aspects of the deadline
    scheduler, as it works for tasks and servers, it's inclusion
    requires also per-object monitors (for dl entities).

Note: this submission removed all patches depending on enqueue/dequeue
tracepoints. The current series is ready for inclusion while the other
patches will be submitted separately.

The entire series can also be found on:

  git.kernel.org/pub/scm/linux/kernel/git/gmonaco/linux.git rv_hybrid_automata

Changes since V7:
* Fix wrong title in monitor_deadline docs
* Warn if kallsyms lookup fails
* Minor improvement in hybrid automata docs
* Use u8 instead of uint8_t in deadline tracepoints and models
* Drop enqueue/dequeue tracepoints and dependent patches from the
  series, will submit separately

[1] - https://lore.kernel.org/lkml/20260310105627.332044-1-gmonaco@redhat.com

To: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
To: Juri Lelli <jlelli@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org

Gabriele Monaco (12):
  rv: Unify DA event handling functions across monitor types
  rv: Add Hybrid Automata monitor type
  verification/rvgen: Allow spaces in and events strings
  verification/rvgen: Add support for Hybrid Automata
  Documentation/rv: Add documentation about hybrid automata
  rv: Add sample hybrid monitor stall
  rv: Convert the opid monitor to a hybrid automaton
  rv: Add support for per-object monitors in DA/HA
  verification/rvgen: Add support for per-obj monitors
  sched: Add deadline tracepoints
  sched/deadline: Move some utility functions to deadline.h
  rv: Add nomiss deadline monitor

 Documentation/tools/rv/index.rst              |   1 +
 Documentation/tools/rv/rv-mon-stall.rst       |  44 ++
 .../trace/rv/deterministic_automata.rst       |   2 +-
 Documentation/trace/rv/hybrid_automata.rst    | 341 ++++++++++
 Documentation/trace/rv/index.rst              |   3 +
 Documentation/trace/rv/monitor_deadline.rst   |  84 +++
 Documentation/trace/rv/monitor_sched.rst      |  62 +-
 Documentation/trace/rv/monitor_stall.rst      |  43 ++
 Documentation/trace/rv/monitor_synthesis.rst  | 117 +++-
 include/linux/rv.h                            |  39 ++
 include/linux/sched/deadline.h                |  27 +
 include/rv/da_monitor.h                       | 644 +++++++++++++-----
 include/rv/ha_monitor.h                       | 478 +++++++++++++
 include/trace/events/sched.h                  |  26 +
 kernel/sched/core.c                           |   5 +
 kernel/sched/deadline.c                       |  51 +-
 kernel/trace/rv/Kconfig                       |  18 +
 kernel/trace/rv/Makefile                      |   3 +
 kernel/trace/rv/monitors/deadline/Kconfig     |  10 +
 kernel/trace/rv/monitors/deadline/deadline.c  |  44 ++
 kernel/trace/rv/monitors/deadline/deadline.h  | 202 ++++++
 kernel/trace/rv/monitors/nomiss/Kconfig       |  15 +
 kernel/trace/rv/monitors/nomiss/nomiss.c      | 293 ++++++++
 kernel/trace/rv/monitors/nomiss/nomiss.h      | 123 ++++
 .../trace/rv/monitors/nomiss/nomiss_trace.h   |  19 +
 kernel/trace/rv/monitors/opid/Kconfig         |  11 +-
 kernel/trace/rv/monitors/opid/opid.c          | 111 +--
 kernel/trace/rv/monitors/opid/opid.h          |  86 +--
 kernel/trace/rv/monitors/opid/opid_trace.h    |   4 +
 kernel/trace/rv/monitors/stall/Kconfig        |  13 +
 kernel/trace/rv/monitors/stall/stall.c        | 150 ++++
 kernel/trace/rv/monitors/stall/stall.h        |  81 +++
 kernel/trace/rv/monitors/stall/stall_trace.h  |  19 +
 kernel/trace/rv/rv_trace.h                    |  67 +-
 tools/verification/models/deadline/nomiss.dot |  41 ++
 tools/verification/models/sched/opid.dot      |  36 +-
 tools/verification/models/stall.dot           |  22 +
 tools/verification/rvgen/__main__.py          |   8 +-
 tools/verification/rvgen/rvgen/automata.py    | 151 +++-
 tools/verification/rvgen/rvgen/dot2c.py       |  47 ++
 tools/verification/rvgen/rvgen/dot2k.py       | 489 ++++++++++++-
 tools/verification/rvgen/rvgen/generator.py   |   4 +-
 .../rvgen/rvgen/templates/dot2k/main.c        |   2 +-
 .../rvgen/templates/dot2k/trace_hybrid.h      |  16 +
 44 files changed, 3605 insertions(+), 447 deletions(-)
 create mode 100644 Documentation/tools/rv/rv-mon-stall.rst
 create mode 100644 Documentation/trace/rv/hybrid_automata.rst
 create mode 100644 Documentation/trace/rv/monitor_deadline.rst
 create mode 100644 Documentation/trace/rv/monitor_stall.rst
 create mode 100644 include/rv/ha_monitor.h
 create mode 100644 kernel/trace/rv/monitors/deadline/Kconfig
 create mode 100644 kernel/trace/rv/monitors/deadline/deadline.c
 create mode 100644 kernel/trace/rv/monitors/deadline/deadline.h
 create mode 100644 kernel/trace/rv/monitors/nomiss/Kconfig
 create mode 100644 kernel/trace/rv/monitors/nomiss/nomiss.c
 create mode 100644 kernel/trace/rv/monitors/nomiss/nomiss.h
 create mode 100644 kernel/trace/rv/monitors/nomiss/nomiss_trace.h
 create mode 100644 kernel/trace/rv/monitors/stall/Kconfig
 create mode 100644 kernel/trace/rv/monitors/stall/stall.c
 create mode 100644 kernel/trace/rv/monitors/stall/stall.h
 create mode 100644 kernel/trace/rv/monitors/stall/stall_trace.h
 create mode 100644 tools/verification/models/deadline/nomiss.dot
 create mode 100644 tools/verification/models/stall.dot
 create mode 100644 tools/verification/rvgen/rvgen/templates/dot2k/trace_hybrid.h


base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
-- 
2.53.0

