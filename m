Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE523C0A03
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 09:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167170; cv=none; b=hkWZrvS0yat8W2uzK+m6P0cqfk0Qf/T7bRvTAiMzP7fu0zO33REemEZGxa1FSHIrVVgi+bjM1R2BX1o4gp1UtsOEzY7U9IEU4mJDOjYqi7RasDxZu1XyFz+iGDSEmuDxeGb1pW7fRpdHmnRMKoDoWu2JvlVfqmSFaXH1l6kIeko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167170; c=relaxed/simple;
	bh=TSjQv2kv33mQ7oT7q5/VS3eIH77VGTQ7EdvXU/w9ZL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=ArVzgcjvXgScRDHJ1jBlITNg4HBGIxq1d36OX2/oLdo4EIWiX9YAn3BtVwNYhEWu14+ZR1rY/TJ+17B2i4mjBftGo6l1SMLdseJaVQWoOR3pyD0QWW73ExXwHEFz6P2PvbYTXvQNG8FMG/f8HLtQrgW+lGZBI8trrAAAMTWZQsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SXn900Em; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXn900Em"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788167168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1pOcDoAHlIQ/T7N5WMkupgAQ1iNS60H7SPvWRp7UHsI=;
	b=SXn900EmpeXUIGv5qrLU++xDOmQ3myi8xJY7KlwcNahYh+M0rBJy+V78d1I4o91lO00abr
	AgNrV6O6zBKexj9oSTkE/fcnmrv6F6oiC+7qrlZXEEqZQwvA0/1lYCTQBCOeyNfuFl9kOT
	5HX0lK1jkGtxFg9SFQO8VuPx0WKHfbU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-U00ojmBnNUqIPfA02WZ_3A-1; Mon,
 31 Aug 2026 05:06:04 -0400
X-MC-Unique: U00ojmBnNUqIPfA02WZ_3A-1
X-Mimecast-MFC-AGG-ID: U00ojmBnNUqIPfA02WZ_3A_1788167163
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1073185CE87;
	Mon, 31 Aug 2026 09:06:02 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 761E018005BD;
	Mon, 31 Aug 2026 09:05:59 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [RFC PATCH 00/20] rv: Add support for BPF monitors
Date: Mon, 31 Aug 2026 11:05:04 +0200
Message-ID: <20260831090524.106845-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: Cc3RSp-mpGnwPjLwQmmsryR9IkwgLeYweILhqvHwkbo_1788167163
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Extend the rv userspace tool to load BPF monitors, those can be found in
specific locations (e.g. /usr/share/rv/bpf_monitors/) and are plain
object files including BTF data.

This type of BPF monitors can be generated from rvgen using the -b flag
just like in-kernel monitors and, after manual adaptation, can be built
and run transparently by the rv userspace tool.

Only DA monitors are supported (as they are the only class the rv tool
currenly supports) and the tool aims to work in the same way for both
in-kernel and BPF monitors.

The da_monitor header is adapted to be included directly in BPF programs
and share as much logic as possible.

BPF monitors are implemented using the struct_ops framework to integrate
as much as possible with in-kernel monitor. After registering, they
look like standard monitors in the tracefs, although to properly enable
them we need to load handlers from userspace and this is done by the rv
tool. BPF monitors cannot generate tracepoints so the rv -t for those
monitors is reading events from a ringbuffer.

Selftests (make -C tools/verification/rv check) are present to validate
and demonstrate the usage, which boils down to:

  rv bpf register          # load struct_ops and maps for all monitors
  rv list                  # unmodified, list BPF monitors transparently
  rv mon -t <mon>          # run the monitor with tracing (ringbuffer)
  rv mon -r printk <mon>   # run the monitor with a reactor
  rv bpf unregister        # remove all BPF monitors

Patch 1 adds tracepoints required in a later monitor example.
Patch 2 improves the rv tool selftest reporting.
Patches 3-9 prepare and add support for BPF monitors in the kernel.
Patch 10 adds a feature check for tools/build
Patch 11-14 prepare and add support for BPF monitors in the rv tool.
Patch 15-17 prepare and include BPF monitors examples
Patch 18 adds support for generating BPF monitors in rvgen
Patch 19-20 adds BPF selftests (make check) for the rv and rvgen tools

To: linux-trace-kernel@vger.kernel.org
To: bpf@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Wen Yang <wen.yang@linux.dev>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: Viktor Malik <vmalik@redhat.com>

Gabriele Monaco (19):
  tools/rv: Skip empty pid error in selftest if command failed
  rv: Refactor da_trace() functions to get strings internally
  rv: Use static arrays for rv_monitor name and description
  rv: Add in-kernel support for BPF monitors
  rv: Add rv_get_monitor_by_name()
  rv: Add reactors support to BPF monitors
  rv: Cast result of model_get_*_name()
  rv: Handle unregistered monitors safely in tracefs
  tools/build: Add a feature test for bpftool-btf
  tools/rv: Move argument parsing from in_kernel to utils
  tools/rv: Export functionality for in_kernel monitors
  tools/rv: Implement BPF monitor loading and tracing
  tools/rv: Implement BPF monitor registration logic
  tools/rv: Copy stripped bpf_atomic.h from libarena
  tools/rv: Add BPF monitors
  tools/rv: Define CONFIG_X86_64 statically for BPF monitors
  verification/rvgen: Add support for BPF monitors
  tools/rv: Add selftest for rv bpf
  verification/rvgen: Add selftest for rvgen -b

Nam Cao (1):
  sched: Add task enqueue/dequeue trace points

 include/linux/rv.h                            |    9 +-
 include/rv/automata.h                         |    4 +-
 include/rv/da_monitor.h                       |   67 +-
 include/trace/events/sched.h                  |    8 +
 kernel/sched/core.c                           |   12 +-
 kernel/sched/sched.h                          |    2 +
 kernel/trace/rv/Kconfig                       |   10 +
 kernel/trace/rv/Makefile                      |    1 +
 kernel/trace/rv/rv.c                          |   68 +-
 kernel/trace/rv/rv.h                          |    5 +-
 kernel/trace/rv/rv_bpf.c                      |  174 +++
 kernel/trace/rv/rv_reactors.c                 |    6 +
 tools/build/Makefile.feature                  |    1 +
 tools/build/feature/Makefile                  |    7 +-
 tools/verification/models/nohz.dot            |   16 +
 tools/verification/models/tqueue.dot          |   15 +
 tools/verification/rv/Makefile                |   51 +-
 tools/verification/rv/Makefile.config         |   49 +
 tools/verification/rv/Makefile.rv             |    5 +
 tools/verification/rv/bpf_monitors/.gitignore |    2 +
 .../verification/rv/bpf_monitors/bpf_atomic.h |  105 ++
 .../rv/bpf_monitors/da_monitor_bpf.h          |  400 +++++++
 tools/verification/rv/bpf_monitors/nohz.c     |   47 +
 tools/verification/rv/bpf_monitors/nohz.h     |   49 +
 tools/verification/rv/bpf_monitors/tqueue.c   |   35 +
 tools/verification/rv/bpf_monitors/tqueue.h   |   47 +
 tools/verification/rv/include/bpf_monitor.h   |   21 +
 tools/verification/rv/include/in_kernel.h     |    5 +
 tools/verification/rv/include/utils.h         |   17 +-
 tools/verification/rv/src/Build               |    5 +
 tools/verification/rv/src/bpf_monitor.c       | 1025 +++++++++++++++++
 tools/verification/rv/src/in_kernel.c         |  205 ++--
 tools/verification/rv/src/rv.c                |   10 +-
 tools/verification/rv/src/utils.c             |   95 +-
 tools/verification/rv/tests/rv_bpf.t          |  104 ++
 tools/verification/rvgen/__main__.py          |   15 +-
 tools/verification/rvgen/rvgen/dot2c.py       |   15 +-
 tools/verification/rvgen/rvgen/dot2k.py       |   22 +-
 tools/verification/rvgen/rvgen/generator.py   |   26 +-
 .../rvgen/rvgen/templates/dot2k/main_bpf.c    |   26 +
 .../tests/golden/da_bpf_cpu/da_bpf_cpu.c      |   40 +
 .../tests/golden/da_bpf_cpu/da_bpf_cpu.h      |   47 +
 .../tests/golden/da_bpf_obj/da_bpf_obj.c      |   54 +
 .../tests/golden/da_bpf_obj/da_bpf_obj.h      |   47 +
 .../verification/rvgen/tests/rvgen_monitor.t  |   11 +
 tools/verification/tests/engine.sh            |    5 +-
 46 files changed, 2770 insertions(+), 220 deletions(-)
 create mode 100644 kernel/trace/rv/rv_bpf.c
 create mode 100644 tools/verification/models/nohz.dot
 create mode 100644 tools/verification/models/tqueue.dot
 create mode 100644 tools/verification/rv/bpf_monitors/.gitignore
 create mode 100644 tools/verification/rv/bpf_monitors/bpf_atomic.h
 create mode 100644 tools/verification/rv/bpf_monitors/da_monitor_bpf.h
 create mode 100644 tools/verification/rv/bpf_monitors/nohz.c
 create mode 100644 tools/verification/rv/bpf_monitors/nohz.h
 create mode 100644 tools/verification/rv/bpf_monitors/tqueue.c
 create mode 100644 tools/verification/rv/bpf_monitors/tqueue.h
 create mode 100644 tools/verification/rv/include/bpf_monitor.h
 create mode 100644 tools/verification/rv/src/bpf_monitor.c
 create mode 100644 tools/verification/rv/tests/rv_bpf.t
 create mode 100644 tools/verification/rvgen/rvgen/templates/dot2k/main_bpf.c
 create mode 100644 tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.c
 create mode 100644 tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.h
 create mode 100644 tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.c
 create mode 100644 tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.h


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.55.0

