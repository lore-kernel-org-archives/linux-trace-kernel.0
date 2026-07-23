Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507D2470E86
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792767; cv=none; b=KTCmxICm2qBynDya7UPFMRVRgU70A27v2CzovuWA3MPeiL8cBNGpI1ICejIiIek1EZ6cpYI/69B3zOcb4w3Apl3DqT+Gh/xtB6Oxfiqs8OdWFVqHjqrTXJDAxRjxcLPAeTaAVEJ0QfI0Sws3RA02keKLW9eQ+XxlRyPwp2u+4lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792767; c=relaxed/simple;
	bh=YPHvOKFlc8DKKwf7YqLmsYeunqE+IdvQ71a079pfoNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=AjzLlp+N8fdjcmTvddD+srUZ1TI2rETJkP8t81dBwNo2KuzKYCVNHs8lVCgmnfRDgjmTT+GEMPXFmwyitJHTZsdJO4C9jbY2o/32yl4s2H8AGtbGFiZ6maxq8zrnrzsmXtZi/aI8pE+yKZ6vkXScXwRDLtr+LJ2GkH4p5vIXEyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IeM9JkHa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IeM9JkHa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784792764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FruoccHm8YgSCLXsAo6AR9o858c9aCyMX1WchR5ZVhw=;
	b=IeM9JkHaZfzirdC+2yoSKU5Ji7GGekmaQ0TWxOVVooBBMtUN0mqab92UUBKzD3DdTtxnyy
	r0m3dy1F+a42HNHYY9VI/c6reTc+wvjMXyJatk8JzYprT3nzQN0ekz+dAWDb27dJ9apFbq
	YbtYQ4eDwU5uhtPSIMYctTIEp1bPnhU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-LH12MVJrM7aKFRWcGwXYmg-1; Thu,
 23 Jul 2026 03:45:59 -0400
X-MC-Unique: LH12MVJrM7aKFRWcGwXYmg-1
X-Mimecast-MFC-AGG-ID: LH12MVJrM7aKFRWcGwXYmg_1784792758
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FCB9195D023;
	Thu, 23 Jul 2026 07:45:58 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.local (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4EA91180029D;
	Thu, 23 Jul 2026 07:45:54 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v5 00/17] rv: Add selftests to tools and KUnit tests
Date: Thu, 23 Jul 2026 09:45:17 +0200
Message-ID: <20260723074534.43521-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: Fufl3hHclce5f_c0EPpzGqepwYt3asVeiORU_gWIolw_1784792758
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This series adds support to the make check target in the rv userspace
tool and the rvgen script, this allows to quickly validate its
functionality. The selftest framework is inspired by the one used in
RTLA.

A few bugs in both tools were also discovered and are fixed as part of
this series.

Additionally it adds unit tests for models. This is achieved by running
the handlers functions directly within KUnit, emulating all modules
paths as if real kernel events fired.

Unit tests emulate a series of events that are expected to trigger
violations and checks that a reaction occurred, stub structs and
functions are used so the kernel is not affected by the test.

Finally it adds a few kselftests for new monitors and improves existing
ones.

Difference since V4 [1]:
* Drop static stub from current to avoid issues with unrelated KUnit tests
* Increase delay in nomiss KUnit test to avoid false positives
* Move wait for flush to avoid wwnr/printk selftest to hang
* Split some long lines

Difference since V3 [2]:
* Retry multiple times when getting the pid to avoid races in selftests
* Use pathlib instead of os.path in rvgen
* Rename files to backup instead of writing to backup in rvgen kunit
* Use deadline_thresh in nomiss KUnit test
* Special init/destroy for per-task monitors to avoid touching real
  tasks and starting tracepoints in KUnit test
* Use actual reactor instead of KUnit stub to support timer reactions
* Wait for dmesg to flush all messages after reactions in wwnr selftest
* Restore original stall threshold after selftest

Difference since V2 [3]:
* Use general rv_this also in LTL monitors
* Refactor KUnit tests to allow build as module
* Add deadline and stall kselftests
* Fix errexit assumption on kselftests
* Adapt rvgen selftests after rebase

Differences since RFC [4]:
* Fix issue with LTL generator printing literals as uppercase
* Add missing state label in selftest dot spec
* Fail selftest if pid was required but not found (harness error)
* Remove useless static keywords in KUnit tests
* Assert after kunit_kzalloc()
* Use RV_KUNIT_EXPECT_REACTION_HERE to avoid false positives
* Prevent running RV monitors and events together with KUnit
* Rearrange KUnit testing headers
* Expect no reaction at the end of KUnit test cases
* Fix broken nomiss test and allocation

[1] - https://lore.kernel.org/lkml/20260717154638.220789-1-gmonaco@redhat.com
[2] - https://lore.kernel.org/lkml/20260625121440.116317-1-gmonaco@redhat.com
[3] - https://lore.kernel.org/lkml/20260514152055.229162-1-gmonaco@redhat.com
[4] - https://lore.kernel.org/lkml/20260427151134.192971-1-gmonaco@redhat.com

To: linux-trace-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>
Cc: Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Wen Yang <wen.yang@linux.dev>

Gabriele Monaco (17):
  rv: Use generic rv_this for the rv_monitor variable in LTL
  tools/rv: Fix exit status when monitor execution fails
  verification/rvgen: Improve rv_dir discovery in RVGenerator
  verification/rvgen: Use pathlib instead of os.path
  verification/rvgen: Improve consistency in template files
  tools/rv: Add selftests
  verification/rvgen: Add golden and spec folders for tests
  verification/rvgen: Add selftests
  verification/rvgen: Add the rvgen kunit subcommand
  verification/rvgen: Add selftests for rvgen kunit
  rv: Export task monitor slot and react symbols
  rv: Add KUnit tests for some DA/HA monitors
  rv: Add KUnit mock for current
  rv: Add KUnit tests for some LTL monitors
  selftests/verification: Fix wrong errexit assumption
  selftests/verification: Rearrange the wwnr_printk test
  selftests/verification: Add selftests for deadline and stall monitors

 include/rv/da_monitor.h                       |  23 ++
 include/rv/ha_monitor.h                       |  21 ++
 include/rv/kunit.h                            |  73 +++++
 include/rv/ltl_monitor.h                      |  14 +-
 kernel/trace/rv/Kconfig                       |  14 +
 kernel/trace/rv/Makefile                      |   1 +
 kernel/trace/rv/monitors/nomiss/nomiss.c      |  18 ++
 .../trace/rv/monitors/nomiss/nomiss_kunit.c   |  38 +++
 .../trace/rv/monitors/nomiss/nomiss_kunit.h   |  35 +++
 kernel/trace/rv/monitors/opid/opid.c          |  12 +
 kernel/trace/rv/monitors/opid/opid_kunit.c    |  33 +++
 kernel/trace/rv/monitors/opid/opid_kunit.h    |  23 ++
 .../trace/rv/monitors/pagefault/pagefault.c   |  20 +-
 .../rv/monitors/pagefault/pagefault_kunit.c   |  34 +++
 .../rv/monitors/pagefault/pagefault_kunit.h   |  24 ++
 kernel/trace/rv/monitors/sco/sco.c            |  13 +
 kernel/trace/rv/monitors/sco/sco_kunit.c      |  29 ++
 kernel/trace/rv/monitors/sco/sco_kunit.h      |  24 ++
 kernel/trace/rv/monitors/sleep/sleep.c        |  49 +++-
 kernel/trace/rv/monitors/sleep/sleep_kunit.c  |  58 ++++
 kernel/trace/rv/monitors/sleep/sleep_kunit.h  |  30 ++
 kernel/trace/rv/monitors/sssw/sssw.c          |  14 +
 kernel/trace/rv/monitors/sssw/sssw_kunit.c    |  33 +++
 kernel/trace/rv/monitors/sssw/sssw_kunit.h    |  30 ++
 kernel/trace/rv/monitors/sts/sts.c            |  19 ++
 kernel/trace/rv/monitors/sts/sts_kunit.c      |  39 +++
 kernel/trace/rv/monitors/sts/sts_kunit.h      |  33 +++
 kernel/trace/rv/rv.c                          |  68 +++++
 kernel/trace/rv/rv_monitors_test.c            | 179 ++++++++++++
 kernel/trace/rv/rv_reactors.c                 |   1 +
 .../verification/test.d/rv_deadline.tc        |  23 ++
 .../test.d/rv_monitor_enable_disable.tc       |  10 +-
 .../verification/test.d/rv_monitor_reactor.tc |   4 +-
 .../selftests/verification/test.d/rv_stall.tc |  33 +++
 .../verification/test.d/rv_wwnr_printk.tc     |  32 ++-
 tools/verification/rv/Makefile                |   5 +-
 tools/verification/rv/src/rv.c                |  24 +-
 tools/verification/rv/tests/rv_list.t         |  48 ++++
 tools/verification/rv/tests/rv_mon.t          |  95 +++++++
 tools/verification/rvgen/Makefile             |   5 +
 tools/verification/rvgen/__main__.py          |  15 +-
 tools/verification/rvgen/rvgen/generator.py   |  51 ++--
 tools/verification/rvgen/rvgen/kunit.py       | 194 +++++++++++++
 tools/verification/rvgen/rvgen/ltl2k.py       |   2 +-
 .../rvgen/rvgen/templates/container/main.c    |   2 +-
 .../rvgen/rvgen/templates/dot2k/main.c        |   2 +-
 .../rvgen/rvgen/templates/kunit.c             |  33 +++
 .../rvgen/rvgen/templates/ltl2k/main.c        |   8 +-
 .../rvgen/tests/golden/da_global/Kconfig      |   9 +
 .../rvgen/tests/golden/da_global/da_global.c  |  95 +++++++
 .../rvgen/tests/golden/da_global/da_global.h  |  47 ++++
 .../tests/golden/da_global/da_global_trace.h  |  15 +
 .../tests/golden/da_perobj_parent/Kconfig     |  11 +
 .../da_perobj_parent/da_perobj_parent.c       | 110 ++++++++
 .../da_perobj_parent/da_perobj_parent.h       |  64 +++++
 .../da_perobj_parent/da_perobj_parent_trace.h |  15 +
 .../tests/golden/da_pertask_desc/Kconfig      |   9 +
 .../golden/da_pertask_desc/da_pertask_desc.c  | 105 +++++++
 .../golden/da_pertask_desc/da_pertask_desc.h  |  64 +++++
 .../da_pertask_desc/da_pertask_desc_trace.h   |  15 +
 .../rvgen/tests/golden/ha_percpu/Kconfig      |   9 +
 .../rvgen/tests/golden/ha_percpu/ha_percpu.c  | 244 ++++++++++++++++
 .../rvgen/tests/golden/ha_percpu/ha_percpu.h  |  72 +++++
 .../tests/golden/ha_percpu/ha_percpu_trace.h  |  19 ++
 .../rvgen/tests/golden/ltl_pertask/Kconfig    |   9 +
 .../tests/golden/ltl_pertask/ltl_pertask.c    | 107 +++++++
 .../tests/golden/ltl_pertask/ltl_pertask.h    | 108 ++++++++
 .../golden/ltl_pertask/ltl_pertask_trace.h    |  14 +
 .../rvgen/tests/golden/test_bak_kunit/Kconfig |   9 +
 .../golden/test_bak_kunit/test_bak_kunit.c    | 107 +++++++
 .../golden/test_bak_kunit/test_bak_kunit.h    | 108 ++++++++
 .../test_bak_kunit/test_bak_kunit_kunit.c     |  33 +++
 .../test_bak_kunit/test_bak_kunit_kunit.c.bak |   1 +
 .../test_bak_kunit/test_bak_kunit_kunit.h     |  22 ++
 .../test_bak_kunit/test_bak_kunit_trace.h     |  14 +
 .../rvgen/tests/golden/test_container/Kconfig |   5 +
 .../golden/test_container/test_container.c    |  35 +++
 .../golden/test_container/test_container.h    |   3 +
 .../rvgen/tests/golden/test_da/Kconfig        |   9 +
 .../rvgen/tests/golden/test_da/test_da.c      |  95 +++++++
 .../rvgen/tests/golden/test_da/test_da.h      |  47 ++++
 .../tests/golden/test_da/test_da_trace.h      |  15 +
 .../rvgen/tests/golden/test_da_kunit/Kconfig  |   9 +
 .../golden/test_da_kunit/test_da_kunit.c      | 107 +++++++
 .../golden/test_da_kunit/test_da_kunit.h      |  47 ++++
 .../test_da_kunit/test_da_kunit_kunit.c       |  33 +++
 .../test_da_kunit/test_da_kunit_kunit.h       |  23 ++
 .../test_da_kunit/test_da_kunit_trace.h       |  15 +
 .../rvgen/tests/golden/test_ha/Kconfig        |   9 +
 .../rvgen/tests/golden/test_ha/test_ha.c      | 247 +++++++++++++++++
 .../rvgen/tests/golden/test_ha/test_ha.h      |  72 +++++
 .../tests/golden/test_ha/test_ha_trace.h      |  19 ++
 .../rvgen/tests/golden/test_ha_kunit/Kconfig  |   9 +
 .../golden/test_ha_kunit/test_ha_kunit.c      | 260 ++++++++++++++++++
 .../golden/test_ha_kunit/test_ha_kunit.h      |  88 ++++++
 .../test_ha_kunit/test_ha_kunit_kunit.c       |  33 +++
 .../test_ha_kunit/test_ha_kunit_kunit.h       |  24 ++
 .../test_ha_kunit/test_ha_kunit_trace.h       |  19 ++
 .../rvgen/tests/golden/test_ltl/Kconfig       |  11 +
 .../rvgen/tests/golden/test_ltl/test_ltl.c    | 108 ++++++++
 .../rvgen/tests/golden/test_ltl/test_ltl.h    | 108 ++++++++
 .../tests/golden/test_ltl/test_ltl_trace.h    |  14 +
 .../rvgen/tests/golden/test_ltl_kunit/Kconfig |   9 +
 .../golden/test_ltl_kunit/test_ltl_kunit.c    | 107 +++++++
 .../golden/test_ltl_kunit/test_ltl_kunit.h    | 108 ++++++++
 .../test_ltl_kunit/test_ltl_kunit_kunit.c     |  33 +++
 .../test_ltl_kunit/test_ltl_kunit_kunit.h     |  22 ++
 .../test_ltl_kunit/test_ltl_kunit_trace.h     |  14 +
 .../rvgen/tests/rvgen_container.t             |  20 ++
 tools/verification/rvgen/tests/rvgen_kunit.t  |  41 +++
 .../verification/rvgen/tests/rvgen_monitor.t  |  87 ++++++
 .../rvgen/tests/specs/test_da.dot             |  16 ++
 .../rvgen/tests/specs/test_da2.dot            |  19 ++
 .../rvgen/tests/specs/test_ha.dot             |  27 ++
 .../rvgen/tests/specs/test_invalid.dot        |   8 +
 .../rvgen/tests/specs/test_invalid.ltl        |   1 +
 .../rvgen/tests/specs/test_invalid_ha.dot     |  16 ++
 .../rvgen/tests/specs/test_ltl.ltl            |   1 +
 tools/verification/tests/engine.sh            | 175 ++++++++++++
 119 files changed, 5110 insertions(+), 81 deletions(-)
 create mode 100644 include/rv/kunit.h
 create mode 100644 kernel/trace/rv/monitors/nomiss/nomiss_kunit.c
 create mode 100644 kernel/trace/rv/monitors/nomiss/nomiss_kunit.h
 create mode 100644 kernel/trace/rv/monitors/opid/opid_kunit.c
 create mode 100644 kernel/trace/rv/monitors/opid/opid_kunit.h
 create mode 100644 kernel/trace/rv/monitors/pagefault/pagefault_kunit.c
 create mode 100644 kernel/trace/rv/monitors/pagefault/pagefault_kunit.h
 create mode 100644 kernel/trace/rv/monitors/sco/sco_kunit.c
 create mode 100644 kernel/trace/rv/monitors/sco/sco_kunit.h
 create mode 100644 kernel/trace/rv/monitors/sleep/sleep_kunit.c
 create mode 100644 kernel/trace/rv/monitors/sleep/sleep_kunit.h
 create mode 100644 kernel/trace/rv/monitors/sssw/sssw_kunit.c
 create mode 100644 kernel/trace/rv/monitors/sssw/sssw_kunit.h
 create mode 100644 kernel/trace/rv/monitors/sts/sts_kunit.c
 create mode 100644 kernel/trace/rv/monitors/sts/sts_kunit.h
 create mode 100644 kernel/trace/rv/rv_monitors_test.c
 create mode 100644 tools/testing/selftests/verification/test.d/rv_deadline.tc
 create mode 100644 tools/testing/selftests/verification/test.d/rv_stall.tc
 create mode 100644 tools/verification/rv/tests/rv_list.t
 create mode 100644 tools/verification/rv/tests/rv_mon.t
 create mode 100644 tools/verification/rvgen/rvgen/kunit.py
 create mode 100644 tools/verification/rvgen/rvgen/templates/kunit.c
 create mode 100644 tools/verification/rvgen/tests/golden/da_global/Kconfig
 create mode 100644 tools/verification/rvgen/tests/golden/da_global/da_global.c
 create mode 100644 tools/verification/rvgen/tests/golden/da_global/da_global.h
 create mode 100644 tools/verification/rvgen/tests/golden/da_global/da_global_trace.h
 create mode 100644 tools/verification/rvgen/tests/golden/da_perobj_parent/Kconfig
 create mode 100644 tools/verification/rvgen/tests/golden/da_perobj_parent/da_perobj_parent.c
 create mode 100644 tools/verification/rvgen/tests/golden/da_perobj_parent/da_perobj_parent.h
 create mode 100644 tools/verification/rvgen/tests/golden/da_perobj_parent/da_perobj_parent_trace.h
 create mode 100644 tools/verification/rvgen/tests/golden/da_pertask_desc/Kconfig
 create mode 100644 tools/verification/rvgen/tests/golden/da_pertask_desc/da_pertask_desc.c
 create mode 100644 tools/verification/rvgen/tests/golden/da_pertask_desc/da_pertask_desc.h
 create mode 100644 tools/verification/rvgen/tests/golden/da_pertask_desc/da_pertask_desc_trace.h
 create mode 100644 tools/verification/rvgen/tests/golden/ha_percpu/Kconfig
 create mode 100644 tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu.c
 create mode 100644 tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu.h
 create mode 100644 tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu_trace.h
 create mode 100644 tools/verification/rvgen/tests/golden/ltl_pertask/Kconfig
 create mode 100644 tools/verification/rvgen/tests/golden/ltl_pertask/ltl_pertask.c
 create mode 100644 tools/verification/rvgen/tests/golden/ltl_pertask/ltl_pertask.h
 create mode 100644 tools/verification/rvgen/tests/golden/ltl_pertask/ltl_pertask_trace.h
 create mode 100644 tools/verification/rvgen/tests/golden/test_bak_kunit/Kconfig
 create mode 100644 tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit.c
 create mode 100644 tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit.h
 create mode 100644 tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_kunit.c
 create mode 100644 tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_kunit.c.bak
 create mode 100644 tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_kunit.h
 create mode 100644 tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_trace.h
 create mode 100644 tools/verification/rvgen/tests/golden/test_container/Kconfig
 create mode 100644 tools/verification/rvgen/tests/golden/test_container/test_container.c
 create mode 100644 tools/verification/rvgen/tests/golden/test_container/test_container.h
 create mode 100644 tools/verification/rvgen/tests/golden/test_da/Kconfig
 create mode 100644 tools/verification/rvgen/tests/golden/test_da/test_da.c
 create mode 100644 tools/verification/rvgen/tests/golden/test_da/test_da.h
 create mode 100644 tools/verification/rvgen/tests/golden/test_da/test_da_trace.h
 create mode 100644 tools/verification/rvgen/tests/golden/test_da_kunit/Kconfig
 create mode 100644 tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit.c
 create mode 100644 tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit.h
 create mode 100644 tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit_kunit.c
 create mode 100644 tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit_kunit.h
 create mode 100644 tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit_trace.h
 create mode 100644 tools/verification/rvgen/tests/golden/test_ha/Kconfig
 create mode 100644 tools/verification/rvgen/tests/golden/test_ha/test_ha.c
 create mode 100644 tools/verification/rvgen/tests/golden/test_ha/test_ha.h
 create mode 100644 tools/verification/rvgen/tests/golden/test_ha/test_ha_trace.h
 create mode 100644 tools/verification/rvgen/tests/golden/test_ha_kunit/Kconfig
 create mode 100644 tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit.c
 create mode 100644 tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit.h
 create mode 100644 tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit_kunit.c
 create mode 100644 tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit_kunit.h
 create mode 100644 tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit_trace.h
 create mode 100644 tools/verification/rvgen/tests/golden/test_ltl/Kconfig
 create mode 100644 tools/verification/rvgen/tests/golden/test_ltl/test_ltl.c
 create mode 100644 tools/verification/rvgen/tests/golden/test_ltl/test_ltl.h
 create mode 100644 tools/verification/rvgen/tests/golden/test_ltl/test_ltl_trace.h
 create mode 100644 tools/verification/rvgen/tests/golden/test_ltl_kunit/Kconfig
 create mode 100644 tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit.c
 create mode 100644 tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit.h
 create mode 100644 tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit_kunit.c
 create mode 100644 tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit_kunit.h
 create mode 100644 tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit_trace.h
 create mode 100644 tools/verification/rvgen/tests/rvgen_container.t
 create mode 100644 tools/verification/rvgen/tests/rvgen_kunit.t
 create mode 100644 tools/verification/rvgen/tests/rvgen_monitor.t
 create mode 100644 tools/verification/rvgen/tests/specs/test_da.dot
 create mode 100644 tools/verification/rvgen/tests/specs/test_da2.dot
 create mode 100644 tools/verification/rvgen/tests/specs/test_ha.dot
 create mode 100644 tools/verification/rvgen/tests/specs/test_invalid.dot
 create mode 100644 tools/verification/rvgen/tests/specs/test_invalid.ltl
 create mode 100644 tools/verification/rvgen/tests/specs/test_invalid_ha.dot
 create mode 100644 tools/verification/rvgen/tests/specs/test_ltl.ltl
 create mode 100644 tools/verification/tests/engine.sh


base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
-- 
2.55.0

