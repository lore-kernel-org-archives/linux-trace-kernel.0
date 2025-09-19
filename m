Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15A530EF92
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291009; cv=none; b=oAcwwPxFLY46Amaa7i1fAUf2PynDbT1KGxgVDBSnODohcUixddkoWdEc+IZe0PtWrZIi+ifKrf+lFg1AtL8+zB30Dzk6GUA5ssdLEYc/2/nV2dlewVR68MoygrCD64TXjIxJTMlsP9ibiCUqck8dxe+dStoS/+HI6klIid7r5Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291009; c=relaxed/simple;
	bh=0EltuoPqNzvMo1NY5Azo+dpOx1Q0s2NSciyz5YNMU7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UwOyu+xjGVkHmOKDv0NsIYjNLWbyBpFtZRVyf33jZe2JdbAsMJuv7FSftFBmv8E4Vkt4lgKskZZaheJiZvmzQAkTldTLB4Jc/FSGSVSBW+SEYtNHAEqnXRx/DWxZn6P33ILfEhl7uxqQyN1vwDtr/iPK4VpixXqSDK4xnWnBBBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YRp1Nwjr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YRp1Nwjr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758291006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OaWr6E25CJRA33FRKDAgh6OBxD6XCC6gfVIgKz+gTQc=;
	b=YRp1Nwjr3pq76fflmSnHZH0L/0Z25BYq2WBHK9tJF9AA9xFfIcvtfEjYfg2wM52eMy0zef
	3iX1WV2fdbZQl2u1BXb7znSrWO0uHrQSbTl0cXiwRxvbDxDmaolnx2ESpXsByMOQU/836u
	LPuHRZB0aSYK6CsfgO/AX+LH5xOSeDc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-A1E3TNs9Nee7NpgTS98NNg-1; Fri,
 19 Sep 2025 10:10:03 -0400
X-MC-Unique: A1E3TNs9Nee7NpgTS98NNg-1
X-Mimecast-MFC-AGG-ID: A1E3TNs9Nee7NpgTS98NNg_1758291002
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EF1F19560AE;
	Fri, 19 Sep 2025 14:10:02 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 16C5C19560BB;
	Fri, 19 Sep 2025 14:09:57 +0000 (UTC)
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
Subject: [PATCH v2 00/20] rv: Add Hybrid Automata monitor type, per-object and deadline monitors
Date: Fri, 19 Sep 2025 16:09:34 +0200
Message-ID: <20250919140954.104920-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

Note: this series is NOT based on the changes in [1], the next version
will integrate that and likely adapt models.

Changes since V1 [2]:
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

[1] - https://lore.kernel.org/lkml/175817861437.709179.10913499403372809816.tip-bot2@tip-bot2
[2] - https://lore.kernel.org/lkml/20250814150809.140739-1-gmonaco@redhat.com

To: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Tomas Glozar <tglozar@redhat.com>
Cc: Juri Lelli <jlelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org

Gabriele Monaco (20):
  rv: Refactor da_monitor to minimise macros
  rv: Cleanup da_monitor after refactor
  rv: Unify DA event handling functions across monitor types
  Documentation/rv: Adapt documentation after da_monitor refactoring
  verification/rvgen: Adapt dot2k and templates after refactoring
    da_monitor.h
  verification/rvgen: Annotate DA functions with types
  verification/dot2c: Remove __buff_to_string() and cleanup
  verification/dot2c: Remove superfluous enum assignment and add last
    comma
  verification/rvgen: Remove unused variable declaration from containers
  rv: Add Hybrid Automata monitor type
  verification/rvgen: Allow spaces in and events strings
  verification/rvgen: Add support for Hybrid Automata
  Documentation/rv: Add documentation about hybrid automata
  rv: Add sample hybrid monitors stall
  rv: Convert the opid monitor to a hybrid automaton
  sched: Export hidden tracepoints to modules
  sched: Add deadline tracepoints
  rv: Add support for per-object monitors in DA/HA
  verification/rvgen: Add support for per-obj monitors
  rv: Add deadline monitors

 Documentation/tools/rv/index.rst              |    1 +
 Documentation/tools/rv/rv-mon-stall.rst       |   44 +
 .../trace/rv/deterministic_automata.rst       |    2 +-
 Documentation/trace/rv/hybrid_automata.rst    |  340 +++++
 Documentation/trace/rv/index.rst              |    3 +
 Documentation/trace/rv/monitor_deadline.rst   |  151 ++
 Documentation/trace/rv/monitor_sched.rst      |   62 +-
 Documentation/trace/rv/monitor_stall.rst      |   43 +
 Documentation/trace/rv/monitor_synthesis.rst  |  151 +-
 include/linux/rv.h                            |   43 +
 include/rv/automata.h                         |  132 +-
 include/rv/da_monitor.h                       | 1289 ++++++++++-------
 include/rv/ha_monitor.h                       |  472 ++++++
 include/trace/events/sched.h                  |   16 +
 kernel/sched/core.c                           |    7 +
 kernel/sched/deadline.c                       |    9 +
 kernel/trace/rv/Kconfig                       |   19 +
 kernel/trace/rv/Makefile                      |    4 +
 kernel/trace/rv/monitors/deadline/Kconfig     |   10 +
 kernel/trace/rv/monitors/deadline/deadline.c  |   35 +
 kernel/trace/rv/monitors/deadline/deadline.h  |  200 +++
 kernel/trace/rv/monitors/nomiss/Kconfig       |   15 +
 kernel/trace/rv/monitors/nomiss/nomiss.c      |  283 ++++
 kernel/trace/rv/monitors/nomiss/nomiss.h      |  130 ++
 .../trace/rv/monitors/nomiss/nomiss_trace.h   |   19 +
 kernel/trace/rv/monitors/nrp/nrp.c            |   30 +-
 kernel/trace/rv/monitors/nrp/nrp.h            |   22 +-
 kernel/trace/rv/monitors/opid/Kconfig         |   11 +-
 kernel/trace/rv/monitors/opid/opid.c          |  129 +-
 kernel/trace/rv/monitors/opid/opid.h          |   94 +-
 kernel/trace/rv/monitors/opid/opid_trace.h    |    4 +
 kernel/trace/rv/monitors/rtapp/rtapp.c        |    2 -
 kernel/trace/rv/monitors/sched/sched.c        |    2 -
 kernel/trace/rv/monitors/sco/sco.c            |   26 +-
 kernel/trace/rv/monitors/sco/sco.h            |   14 +-
 kernel/trace/rv/monitors/scpd/scpd.c          |   28 +-
 kernel/trace/rv/monitors/scpd/scpd.h          |   14 +-
 kernel/trace/rv/monitors/snep/snep.c          |   28 +-
 kernel/trace/rv/monitors/snep/snep.h          |   18 +-
 kernel/trace/rv/monitors/snroc/snroc.c        |   26 +-
 kernel/trace/rv/monitors/snroc/snroc.h        |   14 +-
 kernel/trace/rv/monitors/sssw/sssw.c          |   38 +-
 kernel/trace/rv/monitors/sssw/sssw.h          |   22 +-
 kernel/trace/rv/monitors/stall/Kconfig        |   13 +
 kernel/trace/rv/monitors/stall/stall.c        |  146 ++
 kernel/trace/rv/monitors/stall/stall.h        |   64 +
 kernel/trace/rv/monitors/stall/stall_trace.h  |   19 +
 kernel/trace/rv/monitors/sts/sts.c            |   34 +-
 kernel/trace/rv/monitors/sts/sts.h            |   28 +-
 kernel/trace/rv/monitors/throttle/Kconfig     |   15 +
 kernel/trace/rv/monitors/throttle/throttle.c  |  253 ++++
 kernel/trace/rv/monitors/throttle/throttle.h  |  118 ++
 .../rv/monitors/throttle/throttle_trace.h     |   19 +
 kernel/trace/rv/monitors/wip/wip.c            |   26 +-
 kernel/trace/rv/monitors/wip/wip.h            |   14 +-
 kernel/trace/rv/monitors/wwnr/wwnr.c          |   28 +-
 kernel/trace/rv/monitors/wwnr/wwnr.h          |   14 +-
 kernel/trace/rv/rv_trace.h                    |   68 +-
 tools/verification/models/deadline/nomiss.dot |   39 +
 .../verification/models/deadline/throttle.dot |   44 +
 tools/verification/models/sched/opid.dot      |   36 +-
 tools/verification/models/stall.dot           |   20 +
 tools/verification/rvgen/__main__.py          |    8 +-
 tools/verification/rvgen/rvgen/automata.py    |  166 ++-
 tools/verification/rvgen/rvgen/dot2c.py       |  160 +-
 tools/verification/rvgen/rvgen/dot2k.py       |  506 ++++++-
 tools/verification/rvgen/rvgen/generator.py   |    4 +-
 .../rvgen/rvgen/templates/container/main.c    |    2 -
 .../rvgen/rvgen/templates/dot2k/main.c        |   25 +-
 .../rvgen/templates/dot2k/trace_hybrid.h      |   16 +
 70 files changed, 4717 insertions(+), 1170 deletions(-)
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
 create mode 100644 kernel/trace/rv/monitors/throttle/Kconfig
 create mode 100644 kernel/trace/rv/monitors/throttle/throttle.c
 create mode 100644 kernel/trace/rv/monitors/throttle/throttle.h
 create mode 100644 kernel/trace/rv/monitors/throttle/throttle_trace.h
 create mode 100644 tools/verification/models/deadline/nomiss.dot
 create mode 100644 tools/verification/models/deadline/throttle.dot
 create mode 100644 tools/verification/models/stall.dot
 create mode 100644 tools/verification/rvgen/rvgen/templates/dot2k/trace_hybrid.h


base-commit: 8b789f2b7602a818e7c7488c74414fae21392b63
-- 
2.51.0

