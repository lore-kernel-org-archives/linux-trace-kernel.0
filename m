Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0716F3DE441
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389693; cv=none; b=X9aEDtuy+kFGRzuPXAyjRkUy2lHtQK4Vdu25Zr53OLNC6kY6wrQCSyPvD4fCxeXkLuFaqwwGXSm7DzZDzzqAgegSvZHmnmlpYRsSNRtEbrPnoXfdVXdLp/WmiWrIcAhB/SwlHxiTx+P/n1mncFSUgcOr56/BCpCL1ueCO9DDr8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389693; c=relaxed/simple;
	bh=mqbdciv9n7De+8wHWb5WVTXkmE6ETBVU7q2FhX5x8FA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=O9n/JsTvy9rg2WgQWQ2CESBCnbpdOtuIqT9Xm322O3kutYm16lfWCyrtGT23rz24Z1KEadUkLbqsavt2nSvr+JjcZkutDo96V2eMtLLfNIvuBUiCCWtDd4zJJf1yFoq2Xuyqq0ovkzStd8IBy8xhIrK67NmCLi/RwDuo9FJ7/Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iivE34ti; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iivE34ti"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782389690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g3GNkY4dqNkRgwTE07qiGU5HGxauSvmvqNMw9omfVT4=;
	b=iivE34tiiHiS8QG6BgM3BkdvSZ+yUwk1VFeEs7jHOt4sF4i68x2/zGOvcN0wDRmzXYIM8W
	haajmUmCmGgdu9lG+npJo/sIAmDstzJrYeS0Zv0spEWJql+N2oM/IOoxz173NjB+lPoNcE
	T6kEvkqjvsfHe9jwttDGFde3/9ECa74=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-ESAH5HTnMr-0ICw0YhD1Ig-1; Thu,
 25 Jun 2026 08:14:46 -0400
X-MC-Unique: ESAH5HTnMr-0ICw0YhD1Ig-1
X-Mimecast-MFC-AGG-ID: ESAH5HTnMr-0ICw0YhD1Ig_1782389685
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 495C41955BCC;
	Thu, 25 Jun 2026 12:14:45 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D40030002E0;
	Thu, 25 Jun 2026 12:14:42 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 00/17] rv: Add selftests to tools and KUnit tests
Date: Thu, 25 Jun 2026 14:14:22 +0200
Message-ID: <20260625121440.116317-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: k8hR87kxe85eMsbRqz-TKQQ4SgRTi_KQ83aHy-BSsZ0_1782389685
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

Difference since V2 [1]:
* Use general rv_this also in LTL monitors
* Refactor KUnit tests to allow build as module
* Add deadline and stall kselftests
* Fix errexit assumption on kselftests
* Adapt rvgen selftests after rebase

Differences since RFC [2]:
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

[1] - https://lore.kernel.org/lkml/20260514152055.229162-1-gmonaco@redhat.com
[2] - https://lore.kernel.org/lkml/20260427151134.192971-1-gmonaco@redhat.com

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
  tools/rv: Add selftests
  verification/rvgen: Add golden and spec folders for tests
  verification/rvgen: Add selftests
  rv: Add KUnit stub to rv_react() and rv_*_task_monitor_slot()
  rv: Export task monitor slot and react symbols
  rv: Add KUnit tests for some DA/HA monitors
  rv: Add KUnit stub for current
  rv: Prevent unintentional tracepoints during KUnit tests
  rv: Add KUnit tests for some LTL monitors
  verification/rvgen: Add the rvgen kunit subcommand
  verification/rvgen: Add selftests for rvgen kunit
  selftests/verification: Fix wrong errexit assumption
  selftests/verification: Rearrange the wwnr_printk test
  selftests/verification: Add selftests for deadline and stall monitors

 include/rv/da_monitor.h                       |   1 +
 include/rv/instrumentation.h                  |   5 +
 include/rv/kunit.h                            |  66 +++++
 include/rv/ltl_monitor.h                      |   6 +-
 kernel/trace/rv/Kconfig                       |  14 +
 kernel/trace/rv/Makefile                      |   1 +
 kernel/trace/rv/monitors/nomiss/nomiss.c      |  21 ++
 .../trace/rv/monitors/nomiss/nomiss_kunit.c   |  52 ++++
 .../trace/rv/monitors/nomiss/nomiss_kunit.h   |  34 +++
 kernel/trace/rv/monitors/opid/opid.c          |  16 ++
 kernel/trace/rv/monitors/opid/opid_kunit.c    |  33 +++
 kernel/trace/rv/monitors/opid/opid_kunit.h    |  23 ++
 .../trace/rv/monitors/pagefault/pagefault.c   |  24 +-
 .../rv/monitors/pagefault/pagefault_kunit.c   |  36 +++
 .../rv/monitors/pagefault/pagefault_kunit.h   |  24 ++
 kernel/trace/rv/monitors/sco/sco.c            |  17 ++
 kernel/trace/rv/monitors/sco/sco_kunit.c      |  31 ++
 kernel/trace/rv/monitors/sco/sco_kunit.h      |  24 ++
 kernel/trace/rv/monitors/sleep/sleep.c        |  53 +++-
 kernel/trace/rv/monitors/sleep/sleep_kunit.c  |  61 ++++
 kernel/trace/rv/monitors/sleep/sleep_kunit.h  |  30 ++
 kernel/trace/rv/monitors/sssw/sssw.c          |  18 ++
 kernel/trace/rv/monitors/sssw/sssw_kunit.c    |  36 +++
 kernel/trace/rv/monitors/sssw/sssw_kunit.h    |  30 ++
 kernel/trace/rv/monitors/sts/sts.c            |  23 ++
 kernel/trace/rv/monitors/sts/sts_kunit.c      |  42 +++
 kernel/trace/rv/monitors/sts/sts_kunit.h      |  33 +++
 kernel/trace/rv/rv.c                          |  65 +++++
 kernel/trace/rv/rv_monitors_test.c            | 135 +++++++++
 kernel/trace/rv/rv_reactors.c                 |   8 +
 .../verification/test.d/rv_deadline.tc        |  21 ++
 .../test.d/rv_monitor_enable_disable.tc       |  10 +-
 .../verification/test.d/rv_monitor_reactor.tc |   4 +-
 .../selftests/verification/test.d/rv_stall.tc |  33 +++
 .../verification/test.d/rv_wwnr_printk.tc     |  21 +-
 tools/verification/rv/Makefile                |   5 +-
 tools/verification/rv/src/rv.c                |  16 +-
 tools/verification/rv/tests/rv_list.t         |  48 ++++
 tools/verification/rv/tests/rv_mon.t          |  95 +++++++
 tools/verification/rvgen/Makefile             |   5 +
 tools/verification/rvgen/__main__.py          |  15 +-
 tools/verification/rvgen/rvgen/generator.py   |  15 +-
 tools/verification/rvgen/rvgen/kunit.py       | 200 +++++++++++++
 .../rvgen/rvgen/templates/kunit.c             |  29 ++
 .../rvgen/rvgen/templates/ltl2k/main.c        |   6 +-
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
 .../tests/golden/ltl_pertask/ltl_pertask.h    | 108 +++++++
 .../golden/ltl_pertask/ltl_pertask_trace.h    |  14 +
 .../rvgen/tests/golden/test_container/Kconfig |   5 +
 .../golden/test_container/test_container.c    |  35 +++
 .../golden/test_container/test_container.h    |   3 +
 .../rvgen/tests/golden/test_da/Kconfig        |   9 +
 .../rvgen/tests/golden/test_da/test_da.c      |  95 +++++++
 .../rvgen/tests/golden/test_da/test_da.h      |  47 ++++
 .../tests/golden/test_da/test_da_trace.h      |  15 +
 .../rvgen/tests/golden/test_da_kunit/Kconfig  |   9 +
 .../golden/test_da_kunit/test_da_kunit.c      | 111 ++++++++
 .../golden/test_da_kunit/test_da_kunit.h      |  47 ++++
 .../test_da_kunit/test_da_kunit_kunit.c       |  29 ++
 .../test_da_kunit/test_da_kunit_kunit.h       |  23 ++
 .../test_da_kunit/test_da_kunit_trace.h       |  15 +
 .../rvgen/tests/golden/test_ha/Kconfig        |   9 +
 .../rvgen/tests/golden/test_ha/test_ha.c      | 247 ++++++++++++++++
 .../rvgen/tests/golden/test_ha/test_ha.h      |  72 +++++
 .../tests/golden/test_ha/test_ha_trace.h      |  19 ++
 .../rvgen/tests/golden/test_ha_kunit/Kconfig  |   9 +
 .../golden/test_ha_kunit/test_ha_kunit.c      | 264 ++++++++++++++++++
 .../golden/test_ha_kunit/test_ha_kunit.h      |  88 ++++++
 .../test_ha_kunit/test_ha_kunit_kunit.c       |  29 ++
 .../test_ha_kunit/test_ha_kunit_kunit.h       |  24 ++
 .../test_ha_kunit/test_ha_kunit_trace.h       |  19 ++
 .../rvgen/tests/golden/test_ltl/Kconfig       |  11 +
 .../rvgen/tests/golden/test_ltl/test_ltl.c    | 108 +++++++
 .../rvgen/tests/golden/test_ltl/test_ltl.h    | 108 +++++++
 .../tests/golden/test_ltl/test_ltl_trace.h    |  14 +
 .../rvgen/tests/golden/test_ltl_kunit/Kconfig |   9 +
 .../golden/test_ltl_kunit/test_ltl_kunit.c    | 107 +++++++
 .../golden/test_ltl_kunit/test_ltl_kunit.h    | 108 +++++++
 .../test_ltl_kunit/test_ltl_kunit_kunit.c     |  29 ++
 .../test_ltl_kunit/test_ltl_kunit_kunit.h     |  22 ++
 .../test_ltl_kunit/test_ltl_kunit_trace.h     |  14 +
 .../rvgen/tests/rvgen_container.t             |  20 ++
 tools/verification/rvgen/tests/rvgen_kunit.t  |  32 +++
 .../verification/rvgen/tests/rvgen_monitor.t  |  87 ++++++
 .../rvgen/tests/specs/test_da.dot             |  16 ++
 .../rvgen/tests/specs/test_da2.dot            |  19 ++
 .../rvgen/tests/specs/test_ha.dot             |  27 ++
 .../rvgen/tests/specs/test_invalid.dot        |   8 +
 .../rvgen/tests/specs/test_invalid.ltl        |   1 +
 .../rvgen/tests/specs/test_invalid_ha.dot     |  16 ++
 .../rvgen/tests/specs/test_ltl.ltl            |   1 +
 tools/verification/tests/engine.sh            | 166 +++++++++++
 109 files changed, 4712 insertions(+), 60 deletions(-)
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


base-commit: 840ef6c78e6a2f694b578ecb9063241c992aaa9e
-- 
2.54.0

