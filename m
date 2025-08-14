Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C88321444
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184111; cv=none; b=nuGElGeVU8npot2UBLtEViJCyTRVujanY4PC5ceMLEGMQOddYYi9kJ4mlxw8uitvEamDwXUGnNdbPlXOXFnubUT+YKDONs/RbyQ4z2oVPJDbbda7PLIB7v5147XKkoXLZh0ZFyDlcyrKlhrh3AlYesFG9hDSw45vqXKG6N1bTdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184111; c=relaxed/simple;
	bh=GfF0s6f197bMuptd5be2Fs0Wo4zopdv8qTtVyo+8tQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GIpvm1HSSzEBsQw6PeS+KkAG4B0rZunO8kUI/SmC+t6ESarOYWHTThn0Kj1RAxUuwzVWRIxHdwPF9oCwV44ABfBYe8ByUjhtpZzSvSGUsDqC3eDi4Tq3wukZm+pJs7hfRpkbSX0SATYPOAWcqix0lICn8RiGv5luHK22XskFMAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OuL3e9J/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OuL3e9J/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755184108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PE8N2uaD/Pg6MGT7NhXTCEVNuDeyLJrl41o9DY15Q54=;
	b=OuL3e9J/4hY0fxWzT+nMNnXZBtOv2ew3bdBxtKZJX6N5rNmTQr0jJFnSAK2C86enybbiZx
	xfDnBSBnqIp2wPSPpGzbFAICbXyPkZYsRtwZj1WWLYp90y8OGAZuxTZcnFZ51fmzNR9T/L
	5b3ln1AYxZq3iog8FU7E/j89U0cK64w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-p1eJVUCzOUieIRePiEzflA-1; Thu,
 14 Aug 2025 11:08:25 -0400
X-MC-Unique: p1eJVUCzOUieIRePiEzflA-1
X-Mimecast-MFC-AGG-ID: p1eJVUCzOUieIRePiEzflA_1755184104
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62EBE1955D48;
	Thu, 14 Aug 2025 15:08:24 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 023EA180047F;
	Thu, 14 Aug 2025 15:08:19 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH 00/17] rv: Add Hybrid Automata monitor type, per-object and deadline monitors
Date: Thu, 14 Aug 2025 17:07:52 +0200
Message-ID: <20250814150809.140739-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This RFC contains several related changes, I'm sending them together to
give the full picture and get early feedback but I'm probably going to
submit some of them separately.
The main areas are:

* DA monitor cleanup to remove macros

* Hybrid automata

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

To: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Tomas Glozar <tglozar@redhat.com>
Cc: Juri Lelli <jlelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org

Gabriele Monaco (17):
  rv: Refactor da_monitor to minimise macros
  rv: Cleanup da_monitor after refactor
  Documentation/rv: Adapt documentation after da_monitor refactoring
  verification/rvgen: Adapt dot2k and templates after refactoring
    da_monitor.h
  verification/rvgen: Annotate DA functions with types
  verification/dot2c: Remove __buff_to_string() and cleanup
  verification/rvgen: Remove unused variable declaration from containers
  rv: Add Hybrid Automata monitor type
  verification/rvgen: Allow spaces in and events strings
  verification/rvgen: Add support for Hybrid Automata
  Documentation/rv: Add documentation about hybrid automata
  rv: Add sample hybrid monitors stall
  rv: Convert the opid monitor to a hybrid automaton
  sched: Add deadline tracepoints
  rv: Add support for per-object monitors in DA/HA
  verification/rvgen: Add support for per-obj monitors
  rv: Add deadline monitors

 Documentation/tools/rv/rv-mon-stall.rst       |   44 +
 .../trace/rv/deterministic_automata.rst       |    2 +-
 Documentation/trace/rv/hybrid_automata.rst    |  307 ++++
 Documentation/trace/rv/index.rst              |    1 +
 Documentation/trace/rv/monitor_deadline.rst   |  111 ++
 Documentation/trace/rv/monitor_sched.rst      |   62 +-
 Documentation/trace/rv/monitor_stall.rst      |   43 +
 Documentation/trace/rv/monitor_synthesis.rst  |  130 +-
 include/linux/rv.h                            |   30 +
 include/rv/automata.h                         |  132 +-
 include/rv/da_common.h                        |   21 +
 include/rv/da_monitor.h                       | 1265 ++++++++++-------
 include/rv/ha_monitor.h                       |  398 ++++++
 include/trace/events/sched.h                  |   55 +
 kernel/sched/deadline.c                       |    8 +
 kernel/trace/rv/Kconfig                       |   19 +
 kernel/trace/rv/Makefile                      |    4 +
 kernel/trace/rv/monitors/deadline/Kconfig     |    5 +
 kernel/trace/rv/monitors/deadline/deadline.c  |   35 +
 kernel/trace/rv/monitors/deadline/deadline.h  |   82 ++
 kernel/trace/rv/monitors/nomiss/Kconfig       |   15 +
 kernel/trace/rv/monitors/nomiss/nomiss.c      |  234 +++
 kernel/trace/rv/monitors/nomiss/nomiss.h      |   81 ++
 .../trace/rv/monitors/nomiss/nomiss_trace.h   |   19 +
 kernel/trace/rv/monitors/nrp/nrp.c            |   22 +-
 kernel/trace/rv/monitors/nrp/nrp.h            |    2 +
 kernel/trace/rv/monitors/opid/Kconfig         |   11 +-
 kernel/trace/rv/monitors/opid/opid.c          |  119 +-
 kernel/trace/rv/monitors/opid/opid.h          |   90 +-
 kernel/trace/rv/monitors/opid/opid_trace.h    |    4 +
 kernel/trace/rv/monitors/rtapp/rtapp.c        |    2 -
 kernel/trace/rv/monitors/sched/sched.c        |    2 -
 kernel/trace/rv/monitors/sco/sco.c            |   18 +-
 kernel/trace/rv/monitors/sco/sco.h            |    2 +
 kernel/trace/rv/monitors/scpd/scpd.c          |   20 +-
 kernel/trace/rv/monitors/scpd/scpd.h          |    2 +
 kernel/trace/rv/monitors/snep/snep.c          |   20 +-
 kernel/trace/rv/monitors/snep/snep.h          |    2 +
 kernel/trace/rv/monitors/snroc/snroc.c        |   18 +-
 kernel/trace/rv/monitors/snroc/snroc.h        |    2 +
 kernel/trace/rv/monitors/sssw/sssw.c          |   30 +-
 kernel/trace/rv/monitors/sssw/sssw.h          |    2 +
 kernel/trace/rv/monitors/stall/Kconfig        |    9 +
 kernel/trace/rv/monitors/stall/stall.c        |  116 ++
 kernel/trace/rv/monitors/stall/stall.h        |   64 +
 kernel/trace/rv/monitors/stall/stall_trace.h  |   19 +
 kernel/trace/rv/monitors/sts/sts.c            |   26 +-
 kernel/trace/rv/monitors/sts/sts.h            |    2 +
 kernel/trace/rv/monitors/throttle/Kconfig     |   15 +
 kernel/trace/rv/monitors/throttle/throttle.c  |  259 ++++
 kernel/trace/rv/monitors/throttle/throttle.h  |  115 ++
 .../rv/monitors/throttle/throttle_trace.h     |   19 +
 kernel/trace/rv/monitors/wip/wip.c            |   18 +-
 kernel/trace/rv/monitors/wip/wip.h            |    2 +
 kernel/trace/rv/monitors/wwnr/wwnr.c          |   20 +-
 kernel/trace/rv/monitors/wwnr/wwnr.h          |    2 +
 kernel/trace/rv/rv_trace.h                    |   68 +-
 tools/verification/models/deadline/nomiss.dot |   23 +
 .../verification/models/deadline/throttle.dot |   43 +
 tools/verification/models/sched/opid.dot      |   36 +-
 tools/verification/models/stall.dot           |   20 +
 tools/verification/rvgen/__main__.py          |    8 +-
 tools/verification/rvgen/rvgen/automata.py    |  155 +-
 tools/verification/rvgen/rvgen/dot2c.py       |  129 +-
 tools/verification/rvgen/rvgen/dot2k.py       |  317 ++++-
 tools/verification/rvgen/rvgen/generator.py   |    4 +-
 .../rvgen/rvgen/templates/container/main.c    |    2 -
 .../rvgen/rvgen/templates/dot2k/main.c        |   17 +-
 .../rvgen/templates/dot2k/trace_hybrid.h      |   16 +
 69 files changed, 3969 insertions(+), 1026 deletions(-)
 create mode 100644 Documentation/tools/rv/rv-mon-stall.rst
 create mode 100644 Documentation/trace/rv/hybrid_automata.rst
 create mode 100644 Documentation/trace/rv/monitor_deadline.rst
 create mode 100644 Documentation/trace/rv/monitor_stall.rst
 create mode 100644 include/rv/da_common.h
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
 create mode 100644 kernel/trace/rv/monitors/throttle/Kconfig
 create mode 100644 kernel/trace/rv/monitors/throttle/throttle.c
 create mode 100644 kernel/trace/rv/monitors/throttle/throttle.h
 create mode 100644 kernel/trace/rv/monitors/throttle/throttle_trace.h
 create mode 100644 tools/verification/models/deadline/nomiss.dot
 create mode 100644 tools/verification/models/deadline/throttle.dot
 create mode 100644 tools/verification/models/stall.dot
 create mode 100644 tools/verification/rvgen/rvgen/templates/dot2k/trace_hybrid.h


base-commit: 0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9
-- 
2.50.1

