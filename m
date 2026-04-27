Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C7C329C6B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Apr 2026 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302717; cv=none; b=NjJUtSr3xdecvf1069RqP29+j8OBPijQxGzejIfn75nrplX45mbn2kJLxi2AnJOTNHHZplNvH54Cud+Qlf8sUenYJb7DlZt6dIa3N/HV43EE8QfNl9bt4Pcsog8LTkL+u6BxZsSAuFw5Qn0ZsXiRywbJ6wwh4LnqWqq7ScwWZQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302717; c=relaxed/simple;
	bh=aVAqdCXdV6eJozKW7db/vaawPWlfqGLQK+rT7vDrqv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=Vt5E4U2r5HhFvj0PZufx9Yi96pKu2ruVSo6Ur8JFgWSnOBT+G5UeGDnQapxE0Rp8bTdNWtFgNnoWaXNBudIRKH1yG0yTDKFNzZOj2n2qkXaukPl277qIHMMS1+4SuFuqvnzvpNde+W4kj3AoZfi3j52p+shtMNicIMyEf68xYWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZXTcaXK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZXTcaXK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777302715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+Tly+ExAMxdGd6yARGJk0tySw/vRfTsEdgmbQxE8NRY=;
	b=IZXTcaXK8WL2k8r14tCjOSdG18lfjeHR8S1SMGyKBAQnEqdQiwyWog39hKSWA1wH0XnPi5
	lGIQTo4bZAjBLa1hOtcLK2ifeC55F9DjnY8pHcGMFiQyifkV+mBPJk6kNQuqySn5tvoFwO
	5JgBFAkhw6OISeJ3ysih+hqNZfYbQdQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-W3cm3LJrOvaBRAtl0w4kug-1; Mon,
 27 Apr 2026 11:11:51 -0400
X-MC-Unique: W3cm3LJrOvaBRAtl0w4kug-1
X-Mimecast-MFC-AGG-ID: W3cm3LJrOvaBRAtl0w4kug_1777302710
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3AC31956088;
	Mon, 27 Apr 2026 15:11:49 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E24A7195608E;
	Mon, 27 Apr 2026 15:11:46 +0000 (UTC)
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
Subject: [RFC PATCH 00/12] rv: Add selftests to tools and KUnit tests
Date: Mon, 27 Apr 2026 17:11:22 +0200
Message-ID: <20260427151134.192971-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: co5ZslB-uVM3qjvp93kizYqKQqoOrxMNUIhHUXpD0uM_1777302710
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

To: linux-trace-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>
Cc: Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Wen Yang <wen.yang@linux.dev>

Gabriele Monaco (12):
  tools/rv: Fix substring match bug in monitor name search
  tools/rv: Fix substring match when listing container monitors
  tools/rv: Fix exit status when monitor execution fails
  tools/rv: Fix cleanup after failed trace setup
  tools/rv: Add selftests
  verification/rvgen: Fix options shared among commands
  verification/rvgen: Add golden and spec folders for tests
  verification/rvgen: Add selftests
  rv: Add KUnit stub to rv_react() and rv_*_task_monitor_slot()
  rv: Add KUnit tests for some DA/HA monitors
  rv: Add KUnit stubs for current and smp_processor_id()
  rv: Add KUnit tests for some LTL monitors

 include/rv/da_monitor.h                       |  32 +++
 include/rv/kunit_stubs.h                      |  17 ++
 include/rv/ltl_monitor.h                      |  32 +++
 kernel/trace/rv/Kconfig                       |  14 +
 kernel/trace/rv/Makefile                      |   3 +
 kernel/trace/rv/monitors/nomiss/nomiss.c      |  30 +++
 kernel/trace/rv/monitors/opid/opid.c          |  27 ++
 .../trace/rv/monitors/pagefault/pagefault.c   |  26 +-
 kernel/trace/rv/monitors/sco/sco.c            |  23 ++
 kernel/trace/rv/monitors/sleep/sleep.c        |  64 ++++-
 kernel/trace/rv/monitors/sssw/sssw.c          |  27 ++
 kernel/trace/rv/monitors/sts/sts.c            |  35 +++
 kernel/trace/rv/rv.c                          |   5 +
 kernel/trace/rv/rv_monitors_test.c            |  99 +++++++
 kernel/trace/rv/rv_monitors_test.h            |  90 +++++++
 kernel/trace/rv/rv_reactors.c                 |   3 +
 tools/verification/rv/Makefile                |   5 +-
 tools/verification/rv/src/in_kernel.c         |  58 ++--
 tools/verification/rv/src/rv.c                |   2 +-
 tools/verification/rv/tests/rv_list.t         |  48 ++++
 tools/verification/rv/tests/rv_mon.t          |  95 +++++++
 tools/verification/rvgen/Makefile             |   4 +
 tools/verification/rvgen/__main__.py          |  10 +-
 .../rvgen/tests/golden/da_global/Kconfig      |   9 +
 .../rvgen/tests/golden/da_global/da_global.c  |  95 +++++++
 .../rvgen/tests/golden/da_global/da_global.h  |  47 ++++
 .../tests/golden/da_global/da_global_trace.h  |  15 ++
 .../tests/golden/da_perobj_parent/Kconfig     |  11 +
 .../da_perobj_parent/da_perobj_parent.c       | 110 ++++++++
 .../da_perobj_parent/da_perobj_parent.h       |  64 +++++
 .../da_perobj_parent/da_perobj_parent_trace.h |  15 ++
 .../tests/golden/da_pertask_desc/Kconfig      |   9 +
 .../golden/da_pertask_desc/da_pertask_desc.c  | 105 ++++++++
 .../golden/da_pertask_desc/da_pertask_desc.h  |  64 +++++
 .../da_pertask_desc/da_pertask_desc_trace.h   |  15 ++
 .../rvgen/tests/golden/ha_percpu/Kconfig      |   9 +
 .../rvgen/tests/golden/ha_percpu/ha_percpu.c  | 244 +++++++++++++++++
 .../rvgen/tests/golden/ha_percpu/ha_percpu.h  |  72 +++++
 .../tests/golden/ha_percpu/ha_percpu_trace.h  |  19 ++
 .../rvgen/tests/golden/ltl_pertask/Kconfig    |   9 +
 .../tests/golden/ltl_pertask/ltl_pertask.c    | 107 ++++++++
 .../tests/golden/ltl_pertask/ltl_pertask.h    | 108 ++++++++
 .../golden/ltl_pertask/ltl_pertask_trace.h    |  14 +
 .../rvgen/tests/golden/test_container/Kconfig |   5 +
 .../golden/test_container/test_container.c    |  35 +++
 .../golden/test_container/test_container.h    |   3 +
 .../rvgen/tests/golden/test_da/Kconfig        |   9 +
 .../rvgen/tests/golden/test_da/test_da.c      |  95 +++++++
 .../rvgen/tests/golden/test_da/test_da.h      |  47 ++++
 .../tests/golden/test_da/test_da_trace.h      |  15 ++
 .../rvgen/tests/golden/test_ha/Kconfig        |   9 +
 .../rvgen/tests/golden/test_ha/test_ha.c      | 247 ++++++++++++++++++
 .../rvgen/tests/golden/test_ha/test_ha.h      |  72 +++++
 .../tests/golden/test_ha/test_ha_trace.h      |  19 ++
 .../rvgen/tests/golden/test_ltl/Kconfig       |  11 +
 .../rvgen/tests/golden/test_ltl/test_ltl.c    | 108 ++++++++
 .../rvgen/tests/golden/test_ltl/test_ltl.h    | 108 ++++++++
 .../tests/golden/test_ltl/test_ltl_trace.h    |  14 +
 .../rvgen/tests/rvgen_container.t             |  20 ++
 .../verification/rvgen/tests/rvgen_monitor.t  |  87 ++++++
 .../rvgen/tests/specs/test_da.dot             |  16 ++
 .../rvgen/tests/specs/test_da2.dot            |  18 ++
 .../rvgen/tests/specs/test_ha.dot             |  27 ++
 .../rvgen/tests/specs/test_invalid.dot        |   8 +
 .../rvgen/tests/specs/test_invalid.ltl        |   1 +
 .../rvgen/tests/specs/test_invalid_ha.dot     |  16 ++
 .../rvgen/tests/specs/test_ltl.ltl            |   1 +
 tools/verification/tests/engine.sh            | 156 +++++++++++
 68 files changed, 2993 insertions(+), 44 deletions(-)
 create mode 100644 include/rv/kunit_stubs.h
 create mode 100644 kernel/trace/rv/rv_monitors_test.c
 create mode 100644 kernel/trace/rv/rv_monitors_test.h
 create mode 100644 tools/verification/rv/tests/rv_list.t
 create mode 100644 tools/verification/rv/tests/rv_mon.t
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
 create mode 100644 tools/verification/rvgen/tests/golden/test_ha/Kconfig
 create mode 100644 tools/verification/rvgen/tests/golden/test_ha/test_ha.c
 create mode 100644 tools/verification/rvgen/tests/golden/test_ha/test_ha.h
 create mode 100644 tools/verification/rvgen/tests/golden/test_ha/test_ha_trace.h
 create mode 100644 tools/verification/rvgen/tests/golden/test_ltl/Kconfig
 create mode 100644 tools/verification/rvgen/tests/golden/test_ltl/test_ltl.c
 create mode 100644 tools/verification/rvgen/tests/golden/test_ltl/test_ltl.h
 create mode 100644 tools/verification/rvgen/tests/golden/test_ltl/test_ltl_trace.h
 create mode 100644 tools/verification/rvgen/tests/rvgen_container.t
 create mode 100644 tools/verification/rvgen/tests/rvgen_monitor.t
 create mode 100644 tools/verification/rvgen/tests/specs/test_da.dot
 create mode 100644 tools/verification/rvgen/tests/specs/test_da2.dot
 create mode 100644 tools/verification/rvgen/tests/specs/test_ha.dot
 create mode 100644 tools/verification/rvgen/tests/specs/test_invalid.dot
 create mode 100644 tools/verification/rvgen/tests/specs/test_invalid.ltl
 create mode 100644 tools/verification/rvgen/tests/specs/test_invalid_ha.dot
 create mode 100644 tools/verification/rvgen/tests/specs/test_ltl.ltl
 create mode 100644 tools/verification/tests/engine.sh


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.53.0

