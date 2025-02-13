Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729A320DD64
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437723; cv=none; b=nW54s124HZg1PNQe1VfwiMKvcjBPts8zO5BgM2AuVxSsJ/fUO6Cv11+CqaB7owfr1KFU1RiLKc1O5x/e69cq+2dUUJxL4V2hL22awVM7CZGVCG8Q40ypC66froaQbzGVp+GCkHYAfxp4kWMPhwyq9gqOTfLrQK9DT2ZJuAPp6cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437723; c=relaxed/simple;
	bh=+21jG0SoLqjF4O0Q3XEjlGr23v4342skTokARZ9UmqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eu/C8GMpq+hSI3Fs+tWJzewbQ1QbZ8WnbsUy/Yt5tA1lUHq32Ys25L6XY4/m6j1aZa3byQygbDwb9jD/8Fsku4bbXaExEbKtS7dy/zB/HnpDw8cR7OXZ2wHwT3VdWryKIRAI0f8CHxCuLBgioS2GK5R4MK2rf/RmWNjYmr2mrp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMCBbqLw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMCBbqLw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739437719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RnG+dU3FuNR3QQKixT0ph3PVUAxRSx13aFnhkjUdmrA=;
	b=BMCBbqLwZ8VG/+uI7G39sVivInQCQfJHbwSBR7FMqgamDHimmxjjzbD1qMwshsH1SU/r5K
	kD8dfpdXdwPHxYeVIkIC/qt+3s+iHfU8eS15ZiW1fGjTFBp+sXtk9e/JUtjozofVlklAf6
	et+AQrRZSl7unmqtefPkwx6f4LaF4fY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-uIFROcN4MF2dVU2wE2pM2g-1; Thu,
 13 Feb 2025 04:08:36 -0500
X-MC-Unique: uIFROcN4MF2dVU2wE2pM2g-1
X-Mimecast-MFC-AGG-ID: uIFROcN4MF2dVU2wE2pM2g
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3815D196E078;
	Thu, 13 Feb 2025 09:08:35 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.81])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 066821800365;
	Thu, 13 Feb 2025 09:08:29 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 00/11] rv: Add scheduler specification monitors
Date: Thu, 13 Feb 2025 10:07:58 +0100
Message-ID: <20250213090819.419470-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This patchset starts including adapted scheduler specifications from
Daniel's task model [1].
As the model is fairly complicated, it is split in several generators
and specifications. The tool used to create the model can output a
unified model, but that would be hardly readable (9k states).

RV allows monitors to run and react concurrently. Running the cumulative
model is equivalent to running single components using the same
reactors, with the advantage that it's easier to point out which
specification failed in case of error.

We allow this by introducing nested monitors, in short, the sysfs
monitor folder will contain a monitor named sched, which is nothing but
an empty container for other monitors. Controlling the sched monitor
(enable, disable, set reactors) controls all nested monitors.

The task model proposed by Daniel includes 12 generators and 33
specifications. The generators are good for documentation but are
usually implied in some specifications.
Not all monitors work out of the box, mainly because of those reasons:
* need to distinguish if preempt disable leads to schedule
* need to distinguish if irq disable comes from an actual irq
* assumptions not always true on SMP

The original task model was designed for PREEMPT_RT and this patchset is
only tested on an upstream kernel with full preemption enabled.

In patch 4-6 are included only some specifications that work without
further modifications. Ideally, we would adapt all specifications and
add them gradually to the sched monitor.

Patch 1 fixes a macro required for some tracepoints
This patch was already sent and reviewed in [2]

Patch 2 adds some additional tracepoints in the scheduler's code to
complete the model, the tracepoints were already defined in Daniel's
patches but, as far as I understand, were never submitted

Patch 3 adds the empty sched monitor container and the infrastructure
for nested monitors

Patch 4 adds 2 per-cpu monitors using the tracepoints defined in 2

Patch 5 adds a per-task monitor using the tracepoints defined in 2

Patch 6 adds 3 more per-cpu monitors using the tracepoints defined in 2
and preemptirq tracepoints

Patch 7 adjusts the rv tool to support nested monitors

Patch 8 adjusts the dot2k tool to support nested monitors

Patch 9 adds some documentation for the sched monitors, including
a description of the included specifications

Patch 10 adapts the rv tool to list also filtering by container

Changes since V1:
* skip static_branch_unlikely in function exporting the tracepoint
* rename function and make clear it should not be called directly
* add missing parameter documentation in rv_register_monitor

Changes since RFC:
* use static_branch_unlikely to trace set_state via external function
* allow nested monitors to be disabled via Kconfig
    - they are enabled by default if the container is enabled
* remove need_resched tracepoint as it needs a bit more work
    - will come in a following patch together with a monitor using it

[1] - https://bristot.me/linux-task-model
[2] - https://lore.kernel.org/linux-trace-kernel/20250128111926.303093-1-gmonaco@redhat.com

To: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org

Gabriele Monaco (11):
  tracing: Fix DECLARE_TRACE_CONDITION
  rv: Add license identifiers to monitor files
  sched: Add sched tracepoints for RV task model
  rv: Add option for nested monitors and include sched
  rv: Add sco and tss per-cpu monitors
  rv: Add snroc per-task monitor
  rv: Add scpd, snep and sncid per-cpu monitors
  tools/rv: Add support for nested monitors
  verification/dot2k: Add support for nested monitors
  Documentation/rv: Add docs for the sched monitors
  tools/rv: Allow rv list to filter for container

 Documentation/tools/rv/rv-mon-sched.rst       |  69 +++++
 Documentation/trace/rv/monitor_sched.rst      | 171 ++++++++++++
 include/linux/rv.h                            |   4 +-
 include/linux/sched.h                         |  16 ++
 include/trace/define_trace.h                  |   7 +
 include/trace/events/sched.h                  |  13 +
 kernel/sched/core.c                           |  26 +-
 kernel/trace/rv/Kconfig                       |   7 +
 kernel/trace/rv/Makefile                      |   7 +
 kernel/trace/rv/monitors/sched/Kconfig        |  12 +
 kernel/trace/rv/monitors/sched/sched.c        |  38 +++
 kernel/trace/rv/monitors/sched/sched.h        |   3 +
 kernel/trace/rv/monitors/sco/Kconfig          |  14 +
 kernel/trace/rv/monitors/sco/sco.c            |  88 ++++++
 kernel/trace/rv/monitors/sco/sco.h            |  47 ++++
 kernel/trace/rv/monitors/sco/sco_trace.h      |  15 +
 kernel/trace/rv/monitors/scpd/Kconfig         |  15 +
 kernel/trace/rv/monitors/scpd/scpd.c          |  96 +++++++
 kernel/trace/rv/monitors/scpd/scpd.h          |  49 ++++
 kernel/trace/rv/monitors/scpd/scpd_trace.h    |  15 +
 kernel/trace/rv/monitors/sncid/Kconfig        |  15 +
 kernel/trace/rv/monitors/sncid/sncid.c        |  96 +++++++
 kernel/trace/rv/monitors/sncid/sncid.h        |  49 ++++
 kernel/trace/rv/monitors/sncid/sncid_trace.h  |  15 +
 kernel/trace/rv/monitors/snep/Kconfig         |  15 +
 kernel/trace/rv/monitors/snep/snep.c          |  96 +++++++
 kernel/trace/rv/monitors/snep/snep.h          |  49 ++++
 kernel/trace/rv/monitors/snep/snep_trace.h    |  15 +
 kernel/trace/rv/monitors/snroc/Kconfig        |  14 +
 kernel/trace/rv/monitors/snroc/snroc.c        |  87 ++++++
 kernel/trace/rv/monitors/snroc/snroc.h        |  47 ++++
 kernel/trace/rv/monitors/snroc/snroc_trace.h  |  15 +
 kernel/trace/rv/monitors/tss/Kconfig          |  14 +
 kernel/trace/rv/monitors/tss/tss.c            |  91 +++++++
 kernel/trace/rv/monitors/tss/tss.h            |  47 ++++
 kernel/trace/rv/monitors/tss/tss_trace.h      |  15 +
 kernel/trace/rv/monitors/wip/Kconfig          |   2 +
 kernel/trace/rv/monitors/wip/wip.c            |   2 +-
 kernel/trace/rv/monitors/wip/wip.h            |   1 +
 kernel/trace/rv/monitors/wwnr/Kconfig         |   2 +
 kernel/trace/rv/monitors/wwnr/wwnr.c          |   2 +-
 kernel/trace/rv/monitors/wwnr/wwnr.h          |   1 +
 kernel/trace/rv/rv.c                          | 152 +++++++++--
 kernel/trace/rv/rv.h                          |   4 +
 kernel/trace/rv/rv_reactors.c                 |  28 +-
 kernel/trace/rv/rv_trace.h                    |   6 +
 tools/verification/dot2/dot2k                 |  27 +-
 tools/verification/dot2/dot2k.py              |  80 ++++--
 .../verification/dot2/dot2k_templates/Kconfig |   3 +
 .../verification/dot2/dot2k_templates/main.c  |   4 +-
 .../dot2/dot2k_templates/main_container.c     |  38 +++
 .../dot2/dot2k_templates/main_container.h     |   3 +
 tools/verification/models/sched/sco.dot       |  18 ++
 tools/verification/models/sched/scpd.dot      |  18 ++
 tools/verification/models/sched/sncid.dot     |  18 ++
 tools/verification/models/sched/snep.dot      |  18 ++
 tools/verification/models/sched/snroc.dot     |  18 ++
 tools/verification/models/sched/tss.dot       |  18 ++
 tools/verification/rv/include/in_kernel.h     |   2 +-
 tools/verification/rv/include/rv.h            |   3 +-
 tools/verification/rv/src/in_kernel.c         | 256 ++++++++++++++----
 tools/verification/rv/src/rv.c                |  38 ++-
 62 files changed, 2027 insertions(+), 127 deletions(-)
 create mode 100644 Documentation/tools/rv/rv-mon-sched.rst
 create mode 100644 Documentation/trace/rv/monitor_sched.rst
 create mode 100644 kernel/trace/rv/monitors/sched/Kconfig
 create mode 100644 kernel/trace/rv/monitors/sched/sched.c
 create mode 100644 kernel/trace/rv/monitors/sched/sched.h
 create mode 100644 kernel/trace/rv/monitors/sco/Kconfig
 create mode 100644 kernel/trace/rv/monitors/sco/sco.c
 create mode 100644 kernel/trace/rv/monitors/sco/sco.h
 create mode 100644 kernel/trace/rv/monitors/sco/sco_trace.h
 create mode 100644 kernel/trace/rv/monitors/scpd/Kconfig
 create mode 100644 kernel/trace/rv/monitors/scpd/scpd.c
 create mode 100644 kernel/trace/rv/monitors/scpd/scpd.h
 create mode 100644 kernel/trace/rv/monitors/scpd/scpd_trace.h
 create mode 100644 kernel/trace/rv/monitors/sncid/Kconfig
 create mode 100644 kernel/trace/rv/monitors/sncid/sncid.c
 create mode 100644 kernel/trace/rv/monitors/sncid/sncid.h
 create mode 100644 kernel/trace/rv/monitors/sncid/sncid_trace.h
 create mode 100644 kernel/trace/rv/monitors/snep/Kconfig
 create mode 100644 kernel/trace/rv/monitors/snep/snep.c
 create mode 100644 kernel/trace/rv/monitors/snep/snep.h
 create mode 100644 kernel/trace/rv/monitors/snep/snep_trace.h
 create mode 100644 kernel/trace/rv/monitors/snroc/Kconfig
 create mode 100644 kernel/trace/rv/monitors/snroc/snroc.c
 create mode 100644 kernel/trace/rv/monitors/snroc/snroc.h
 create mode 100644 kernel/trace/rv/monitors/snroc/snroc_trace.h
 create mode 100644 kernel/trace/rv/monitors/tss/Kconfig
 create mode 100644 kernel/trace/rv/monitors/tss/tss.c
 create mode 100644 kernel/trace/rv/monitors/tss/tss.h
 create mode 100644 kernel/trace/rv/monitors/tss/tss_trace.h
 create mode 100644 tools/verification/dot2/dot2k_templates/main_container.c
 create mode 100644 tools/verification/dot2/dot2k_templates/main_container.h
 create mode 100644 tools/verification/models/sched/sco.dot
 create mode 100644 tools/verification/models/sched/scpd.dot
 create mode 100644 tools/verification/models/sched/sncid.dot
 create mode 100644 tools/verification/models/sched/snep.dot
 create mode 100644 tools/verification/models/sched/snroc.dot
 create mode 100644 tools/verification/models/sched/tss.dot


base-commit: 4dc1d1bec89864d8076e5ab314f86f46442bfb02
-- 
2.48.1

