Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C521043802C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 31 Jul 2026 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511727; cv=none; b=kGnrpKmnohGsA2C1UkFQ8YUyMVHYnmeKgnieCgyJUqBwtpxPfd+SORGTksM37/zxUkc3kPgCdKksZO9JNSxFAbO24n4E19Pv2ryJowazNNZ/F/+JZaKD4DwwBOWZ9hq32G2HJalhler1qB8Fa0Gi+D3NNUmsLDRYt28l9vRp3jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511727; c=relaxed/simple;
	bh=KZFiwwdI+XadJC1AW3zZcwddWxLcIQQdsUNRstxMdA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=KPUSTxT1F+gLniBivkYEPWZLMlvJay6UaCc5EkT6G4WooykpBaTfforPxU4U6iKg8nomwxtMM2iFjxSmg6jsBgu8YtIVuK0lOZZnG/Rs9gsHduC3cnnAPDk59Bw+oypzBb+ndAxTKeNJp4xJ6n8kXUTsGgbU7KT17Kz07ihvTnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LUzjhcba; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUzjhcba"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785511724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LTtUelLA4uak6gV+bFTsQTsfuURZ7PJU2Tb7c5BCYus=;
	b=LUzjhcbakX9OuC+M5EyUAWHFqFN5xnpGxDpqzYDGKHzTYVyx2S2IT5xI5uIZ3G72wJJqdj
	SARw+i6757GQijk49RpY8ALP0WBDaezPTTsxoXc3I1amBTk5iJs22rZ2cm+KC/AByUBMS1
	WuhE1uyZ1YiTEX3tkLpUlCcdUoLD1RI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-bVsq5ou2NM-0KHv8Yl7vVA-1; Fri,
 31 Jul 2026 11:28:40 -0400
X-MC-Unique: bVsq5ou2NM-0KHv8Yl7vVA-1
X-Mimecast-MFC-AGG-ID: bVsq5ou2NM-0KHv8Yl7vVA_1785511718
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F2861800599;
	Fri, 31 Jul 2026 15:28:38 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A67B730002E9;
	Fri, 31 Jul 2026 15:28:35 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>,
	Li Qiang <liqiang01@kylinos.cn>,
	Nam Cao <namcao@linutronix.de>,
	Yu Chuanyu <lucayu.alight@gmail.com>
Subject: [GIT PULL] rv changes for v7.3 (for-next)
Date: Fri, 31 Jul 2026 17:27:16 +0200
Message-ID: <20260731152715.238409-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: NEWZ_wINGit_w30yDdrrByxliiPqSzAVeuDk4oGdT-4_1785511718
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Steve,

The following changes since commit 1590cf0329716306e948a8fc29f1d3ee87d3989f:

  Linux 7.2-rc4 (2026-07-19 13:54:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gmonaco/linux.git rv-7.3-next

for you to fetch changes up to 984b5a36fd12d1849511a45fda32036fe2b0d004:

  selftests/verification: Add selftests for deadline and stall monitors (2026-07-31 16:27:46 +0200)

----------------------------------------------------------------
rv changes for v7.3 (for-next)

Summary of changes:

- Switch LTL and DOT parsers to Lark in code generation tool

  The rvgen code generation tool originally parsed DOT files and LTL
  specifications using custom string parsing and Ply, which is no longer
  maintained. The DOT parser was fragile and prone to failure on minor
  format variations. Both LTL and DOT parsers have been rewritten to use
  the Lark parsing library.

- Simplify Hybrid Automata clock variables

  The clock variables in hybrid automata monitors now use a single
  representation of the elapsed time since the clock was reset, rather
  than converting between invariant and guard representations.
  This allows simpler code generation for the newly refactored parser.

- Generate cleanup hook for per-obj monitor

  The code generation scripts now adds a cleanup function to per-obj
  monitors for the user to wire to the appropriate event (e.g.
  sched_process_exit for tasks).

- Reduce read_lock scope during per-task cleanup

  Take the tasklist_lock only when necessary, that is when iterating
  over for_each_process_thread().

- Simplify task monitor slot management

  Only rely on the slot array for per-task slot management to avoid
  inconsistency with the unused counter.

- Improve rvgen code robustness and templates

  Use pathlib in rvgen and improve kernel path discovery. Also improve
  consistency across templates when generating code (e.g. author
  placeholder and monitor struct name).

- Update rtapp sleep monitor

  Simplify the sleep monitor by excluding kernel threads and
  updating the nanosleep check to focus only on CLOCK_REALTIME. Also
  switch to use the sched_exit tracepoint to run in the context of the
  offending (wakee) task.

- Add wakeup monitor

  Add the new rtapp/wakeup monitor to detect when lower-priority tasks
  wake up higher-priority ones, complementing the existing sleep monitor
  by running in the waker context and capturing its stack trace.

- Fix tools/rv exit status on failure

  Ensure the rv tool returns a failure exit code when a monitor fails to
  start because it was already running.

- Add automated selftests for tools/rv and rvgen

  Introduced automated bash selftests to validate rv monitor listing and
  execution under different configurations. Added tests for the rvgen code
  generator, validating generated files against expected output (golden).
  Tests are reachable via make check.

- Add KUnit test coverage for verification monitors

  Added comprehensive KUnit tests to validate the functionality of
  deterministic, hybrid, and LTL monitors by emulating event sequences
  and timing in a mock environment without affecting the running kernel
  while expecting mock reactions to fire. Ensure real RV monitors cannot
  run during KUnit tests to avoid state corruption.

- Mock current in rv monitors

  Mock the call to current in rv monitors when the KUnit tests are built
  to allow them to run the test on dummy tasks. No overhead is expected
  when KUnit tests aren't running.

- Introduce rvgen kunit subcommand

  Added a new 'kunit' subcommand to rvgen to automatically patch an already
  generated monitor with KUnit integration templates by parsing its event
  handlers and creating the required mock structures and initializations.

- Refine kernel verification selftests

  Added new selftests for the deadline and stall monitors and rearranged
  the existing wwnr_printk test to resolve flakiness.
  Additionally, fixed an issue in the selftests framework where negative
  assertion failures were not correctly propagated due to shell rules.

----------------------------------------------------------------
Gabriele Monaco (19):
      rv: Fix read_lock scope in per-task DA cleanup
      verification/rvgen: Generate cleanup hook for per-obj monitor
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

Li Qiang (1):
      rv: Simplify task monitor slot management

Nam Cao (17):
      verification/rvgen: Switch LTL parser to Lark
      verification/rvgen: Introduce a parse tree for automata using Lark
      verification/rvgen: Implement state and transition parser based on Lark
      verification/rvgen: Convert __fill_verify_invariants_func() to Lark
      verification/rvgen: Convert __fill_setup_invariants_func() to Lark
      verification/rvgen: Convert __fill_verify_guards_func() to Lark
      rv: Simplify hybrid automata monitors's clock variables
      verification/rvgen: Simplify the generation for clock variables
      verification/rvgen: Delete __parse_constraint()
      verification/rvgen: Switch __get_event_variables() to Lark
      verification/rvgen: Switch __create_matrix() to Lark
      verification/rvgen: Remove the old state variables
      verification/rvgen: Remove dead code
      rv/rtapp/sleep: Make the error more informative for user
      rv/rtapp/sleep: Update nanosleep rule
      rv/rtapp/sleep: Stop monitoring kernel threads
      rv/rtapp: Add wakeup monitor

Yu Chuanyu (1):
      rv: Update rvgen monitor synthesis documentation path

 Documentation/trace/rv/monitor_rtapp.rst           |  61 +-
 include/rv/da_monitor.h                            |  31 +-
 include/rv/ha_monitor.h                            |  85 ++-
 include/rv/kunit.h                                 |  73 +++
 include/rv/ltl_monitor.h                           |  14 +-
 kernel/trace/rv/Kconfig                            |  15 +
 kernel/trace/rv/Makefile                           |   2 +
 kernel/trace/rv/monitors/nomiss/nomiss.c           |  36 +-
 kernel/trace/rv/monitors/nomiss/nomiss_kunit.c     |  38 ++
 kernel/trace/rv/monitors/nomiss/nomiss_kunit.h     |  35 ++
 kernel/trace/rv/monitors/opid/opid.c               |  12 +
 kernel/trace/rv/monitors/opid/opid_kunit.c         |  33 ++
 kernel/trace/rv/monitors/opid/opid_kunit.h         |  23 +
 kernel/trace/rv/monitors/pagefault/pagefault.c     |  20 +-
 .../trace/rv/monitors/pagefault/pagefault_kunit.c  |  34 ++
 .../trace/rv/monitors/pagefault/pagefault_kunit.h  |  24 +
 kernel/trace/rv/monitors/rtapp/Kconfig             |   2 +-
 kernel/trace/rv/monitors/sco/sco.c                 |  13 +
 kernel/trace/rv/monitors/sco/sco_kunit.c           |  29 +
 kernel/trace/rv/monitors/sco/sco_kunit.h           |  24 +
 kernel/trace/rv/monitors/sleep/Kconfig             |   1 -
 kernel/trace/rv/monitors/sleep/sleep.c             | 107 ++--
 kernel/trace/rv/monitors/sleep/sleep.h             | 142 ++---
 kernel/trace/rv/monitors/sleep/sleep_kunit.c       |  59 ++
 kernel/trace/rv/monitors/sleep/sleep_kunit.h       |  29 +
 kernel/trace/rv/monitors/sssw/sssw.c               |  14 +
 kernel/trace/rv/monitors/sssw/sssw_kunit.c         |  33 ++
 kernel/trace/rv/monitors/sssw/sssw_kunit.h         |  30 +
 kernel/trace/rv/monitors/stall/stall.c             |   2 +-
 kernel/trace/rv/monitors/sts/sts.c                 |  19 +
 kernel/trace/rv/monitors/sts/sts_kunit.c           |  39 ++
 kernel/trace/rv/monitors/sts/sts_kunit.h           |  33 ++
 kernel/trace/rv/monitors/wakeup/Kconfig            |  16 +
 kernel/trace/rv/monitors/wakeup/wakeup.c           | 153 +++++
 kernel/trace/rv/monitors/wakeup/wakeup.h           |  92 +++
 kernel/trace/rv/monitors/wakeup/wakeup_trace.h     |  14 +
 kernel/trace/rv/rv.c                               |  86 ++-
 kernel/trace/rv/rv_monitors_test.c                 | 182 ++++++
 kernel/trace/rv/rv_reactors.c                      |   1 +
 kernel/trace/rv/rv_trace.h                         |   1 +
 .../selftests/verification/test.d/rv_deadline.tc   |  23 +
 .../test.d/rv_monitor_enable_disable.tc            |  10 +-
 .../verification/test.d/rv_monitor_reactor.tc      |   4 +-
 .../selftests/verification/test.d/rv_stall.tc      |  33 ++
 .../verification/test.d/rv_wwnr_printk.tc          |  32 +-
 tools/verification/models/rtapp/sleep.ltl          |  11 +-
 tools/verification/models/rtapp/wakeup.ltl         |   5 +
 tools/verification/rv/Makefile                     |   5 +-
 tools/verification/rv/src/rv.c                     |  24 +-
 tools/verification/rv/tests/rv_list.t              |  48 ++
 tools/verification/rv/tests/rv_mon.t               |  95 +++
 tools/verification/rvgen/Makefile                  |   5 +
 tools/verification/rvgen/__main__.py               |  22 +-
 tools/verification/rvgen/rvgen/automata.py         | 643 +++++++++++++--------
 tools/verification/rvgen/rvgen/dot2c.py            |  10 +-
 tools/verification/rvgen/rvgen/dot2k.py            | 311 ++++------
 tools/verification/rvgen/rvgen/generator.py        |  51 +-
 tools/verification/rvgen/rvgen/kunit.py            | 194 +++++++
 tools/verification/rvgen/rvgen/ltl2ba.py           | 202 +++----
 tools/verification/rvgen/rvgen/ltl2k.py            |   2 +-
 .../rvgen/rvgen/templates/container/main.c         |   2 +-
 .../rvgen/rvgen/templates/dot2k/main.c             |   2 +-
 tools/verification/rvgen/rvgen/templates/kunit.c   |  33 ++
 .../rvgen/rvgen/templates/ltl2k/main.c             |   8 +-
 .../rvgen/tests/golden/da_global/Kconfig           |   9 +
 .../rvgen/tests/golden/da_global/da_global.c       |  95 +++
 .../rvgen/tests/golden/da_global/da_global.h       |  47 ++
 .../rvgen/tests/golden/da_global/da_global_trace.h |  15 +
 .../rvgen/tests/golden/da_perobj_parent/Kconfig    |  11 +
 .../golden/da_perobj_parent/da_perobj_parent.c     | 119 ++++
 .../golden/da_perobj_parent/da_perobj_parent.h     |  64 ++
 .../da_perobj_parent/da_perobj_parent_trace.h      |  15 +
 .../rvgen/tests/golden/da_pertask_desc/Kconfig     |   9 +
 .../tests/golden/da_pertask_desc/da_pertask_desc.c | 105 ++++
 .../tests/golden/da_pertask_desc/da_pertask_desc.h |  64 ++
 .../golden/da_pertask_desc/da_pertask_desc_trace.h |  15 +
 .../rvgen/tests/golden/ha_percpu/Kconfig           |   9 +
 .../rvgen/tests/golden/ha_percpu/ha_percpu.c       | 227 ++++++++
 .../rvgen/tests/golden/ha_percpu/ha_percpu.h       |  72 +++
 .../rvgen/tests/golden/ha_percpu/ha_percpu_trace.h |  19 +
 .../rvgen/tests/golden/ltl_pertask/Kconfig         |   9 +
 .../rvgen/tests/golden/ltl_pertask/ltl_pertask.c   | 107 ++++
 .../rvgen/tests/golden/ltl_pertask/ltl_pertask.h   | 108 ++++
 .../tests/golden/ltl_pertask/ltl_pertask_trace.h   |  14 +
 .../rvgen/tests/golden/test_bak_kunit/Kconfig      |   9 +
 .../tests/golden/test_bak_kunit/test_bak_kunit.c   | 107 ++++
 .../tests/golden/test_bak_kunit/test_bak_kunit.h   | 108 ++++
 .../golden/test_bak_kunit/test_bak_kunit_kunit.c   |  33 ++
 .../test_bak_kunit/test_bak_kunit_kunit.c.bak      |   1 +
 .../golden/test_bak_kunit/test_bak_kunit_kunit.h   |  22 +
 .../golden/test_bak_kunit/test_bak_kunit_trace.h   |  14 +
 .../rvgen/tests/golden/test_container/Kconfig      |   5 +
 .../tests/golden/test_container/test_container.c   |  35 ++
 .../tests/golden/test_container/test_container.h   |   3 +
 .../rvgen/tests/golden/test_da/Kconfig             |   9 +
 .../rvgen/tests/golden/test_da/test_da.c           |  95 +++
 .../rvgen/tests/golden/test_da/test_da.h           |  47 ++
 .../rvgen/tests/golden/test_da/test_da_trace.h     |  15 +
 .../rvgen/tests/golden/test_da_kunit/Kconfig       |   9 +
 .../tests/golden/test_da_kunit/test_da_kunit.c     | 107 ++++
 .../tests/golden/test_da_kunit/test_da_kunit.h     |  47 ++
 .../golden/test_da_kunit/test_da_kunit_kunit.c     |  33 ++
 .../golden/test_da_kunit/test_da_kunit_kunit.h     |  23 +
 .../golden/test_da_kunit/test_da_kunit_trace.h     |  15 +
 .../rvgen/tests/golden/test_ha/Kconfig             |   9 +
 .../rvgen/tests/golden/test_ha/test_ha.c           | 230 ++++++++
 .../rvgen/tests/golden/test_ha/test_ha.h           |  72 +++
 .../rvgen/tests/golden/test_ha/test_ha_trace.h     |  19 +
 .../rvgen/tests/golden/test_ha_kunit/Kconfig       |   9 +
 .../tests/golden/test_ha_kunit/test_ha_kunit.c     | 243 ++++++++
 .../tests/golden/test_ha_kunit/test_ha_kunit.h     |  88 +++
 .../golden/test_ha_kunit/test_ha_kunit_kunit.c     |  33 ++
 .../golden/test_ha_kunit/test_ha_kunit_kunit.h     |  24 +
 .../golden/test_ha_kunit/test_ha_kunit_trace.h     |  19 +
 .../rvgen/tests/golden/test_ltl/Kconfig            |  11 +
 .../rvgen/tests/golden/test_ltl/test_ltl.c         | 108 ++++
 .../rvgen/tests/golden/test_ltl/test_ltl.h         | 108 ++++
 .../rvgen/tests/golden/test_ltl/test_ltl_trace.h   |  14 +
 .../rvgen/tests/golden/test_ltl_kunit/Kconfig      |   9 +
 .../tests/golden/test_ltl_kunit/test_ltl_kunit.c   | 107 ++++
 .../tests/golden/test_ltl_kunit/test_ltl_kunit.h   | 108 ++++
 .../golden/test_ltl_kunit/test_ltl_kunit_kunit.c   |  33 ++
 .../golden/test_ltl_kunit/test_ltl_kunit_kunit.h   |  22 +
 .../golden/test_ltl_kunit/test_ltl_kunit_trace.h   |  14 +
 tools/verification/rvgen/tests/rvgen_container.t   |  20 +
 tools/verification/rvgen/tests/rvgen_kunit.t       |  41 ++
 tools/verification/rvgen/tests/rvgen_monitor.t     |  87 +++
 tools/verification/rvgen/tests/specs/test_da.dot   |  16 +
 tools/verification/rvgen/tests/specs/test_da2.dot  |  19 +
 tools/verification/rvgen/tests/specs/test_ha.dot   |  27 +
 .../rvgen/tests/specs/test_invalid.dot             |   8 +
 .../rvgen/tests/specs/test_invalid.ltl             |   1 +
 .../rvgen/tests/specs/test_invalid_ha.dot          |  16 +
 tools/verification/rvgen/tests/specs/test_ltl.ltl  |   1 +
 tools/verification/tests/engine.sh                 | 175 ++++++
 135 files changed, 6100 insertions(+), 893 deletions(-)
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
 create mode 100644 kernel/trace/rv/monitors/wakeup/Kconfig
 create mode 100644 kernel/trace/rv/monitors/wakeup/wakeup.c
 create mode 100644 kernel/trace/rv/monitors/wakeup/wakeup.h
 create mode 100644 kernel/trace/rv/monitors/wakeup/wakeup_trace.h
 create mode 100644 kernel/trace/rv/rv_monitors_test.c
 create mode 100644 tools/testing/selftests/verification/test.d/rv_deadline.tc
 create mode 100644 tools/testing/selftests/verification/test.d/rv_stall.tc
 create mode 100644 tools/verification/models/rtapp/wakeup.ltl
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

To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: Li Qiang <liqiang01@kylinos.cn>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Yu Chuanyu <lucayu.alight@gmail.com>

