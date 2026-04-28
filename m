Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF7A199FAC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Apr 2026 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388992; cv=none; b=GdBw929SgMQHd+FCbx1guJfX+svyIwyjhOYZpVGFgUSCoBnUAtBNKWeDh/pVnmUNJQlSgB6/B5g5qb9TxtvkXQJhVgqNk04lbhhuFFsAJ0kLLFqxpgz+eC/JReIQFXieVqDtbGSYgKhXX1swUra+SVK6IrQ9mbC1pqW1IjAtkzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388992; c=relaxed/simple;
	bh=OAT0hm/a/JMX4tI2LveGi2OkPav3C/inCWkWxw4uJRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmUz6aXb2JyRHZ2DTmckclplb8TgcVNJM8gacaDNVWcRbi3msLB6po4hOmIghNjSvdZhZFFbmHjYeRiWGQ9EsQ5ff8pylL4D3vUVCoW8j3Jhas/lrwaWVmOsn8aAcnuwqfjzK8GuEC4pUW1hDn3s+SXvBxdNl8nbDmT1KbgFXPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=omDfdTre; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="omDfdTre"
Message-ID: <d0c1fe9d-8d51-4c4f-897b-45444de1286d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777388987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hIB7EHw0XVe8J9biJw0DmGVo/3UVd+n37GjnX2Eg4U0=;
	b=omDfdTreNEfntfEEPgMyY8fh7p72t7lj/0Bq1mm3QJ1VqdPdhm8erv8tkvMpV7qYxeNmsq
	Q/qIvxYjZAQTg67XfHtaJ+AyGchZNYTRPNrrjo9v7eu3G6GjC0iBJzL4uGUAVjXkxZkpcV
	slb1gKN8ZPakg3kMktEIeyefOuau9ZE=
Date: Tue, 28 Apr 2026 23:09:33 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 00/12] rv: Add selftests to tools and KUnit tests
To: Gabriele Monaco <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>,
 Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
 Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>
References: <20260427151134.192971-1-gmonaco@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20260427151134.192971-1-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/27/26 23:11, Gabriele Monaco wrote:
> This series adds support to the make check target in the rv userspace
> tool and the rvgen script, this allows to quickly validate its
> functionality. The selftest framework is inspired by the one used in
> RTLA.
> 
> A few bugs in both tools were also discovered and are fixed as part of
> this series.
> 
> Additionally it adds unit tests for models. This is achieved by running
> the handlers functions directly within KUnit, emulating all modules
> paths as if real kernel events fired.
> 
> Unit tests emulate a series of events that are expected to trigger
> violations and checks that a reaction occurred, stub structs and
> functions are used so the kernel is not affected by the test.
> 

Hi Gabriele,

Good direction overall. The approach of calling event handlers directly
inside KUnit is clean and avoids the complexity of setting up real
tracepoints. Patches 1-4 (bug fixes) look correct.

We are planning to build the KUnit and selftest coverage for the tlob
monitor on top of this infrastructure, so getting this merged would be
useful for us as well.

- One issue found in the KUnit patches:

   patch 10: nomiss test
   kernel/trace/rv/monitors/nomiss/nomiss.c:
     udelay(10 / 1000);

   The compiler folds it silently as udelay(0).
   Presumably intended as udelay(10)?

- minor: copyright year range
   rv_monitors_test.c: Copyright (C) 2025-2028
   kunit_stubs.h:      Copyright (C) 2026-2029

   Kernel copyright entries conventionally use only the year(s) the work
was actually created，eg:
https://lkml.indiana.edu/2510.0/01897.html


Reviewed-by: Wen Yang <wen.yang@linux.dev>

--
Best wishes,
Wen


> To: linux-trace-kernel@vger.kernel.org
> To: linux-kernel@vger.kernel.org
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Nam Cao <namcao@linutronix.de>
> Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>
> Cc: Tomas Glozar <tglozar@redhat.com>
> Cc: John Kacur <jkacur@redhat.com>
> Cc: Wen Yang <wen.yang@linux.dev>
> 
> Gabriele Monaco (12):
>    tools/rv: Fix substring match bug in monitor name search
>    tools/rv: Fix substring match when listing container monitors
>    tools/rv: Fix exit status when monitor execution fails
>    tools/rv: Fix cleanup after failed trace setup
>    tools/rv: Add selftests
>    verification/rvgen: Fix options shared among commands
>    verification/rvgen: Add golden and spec folders for tests
>    verification/rvgen: Add selftests
>    rv: Add KUnit stub to rv_react() and rv_*_task_monitor_slot()
>    rv: Add KUnit tests for some DA/HA monitors
>    rv: Add KUnit stubs for current and smp_processor_id()
>    rv: Add KUnit tests for some LTL monitors
> 
>   include/rv/da_monitor.h                       |  32 +++
>   include/rv/kunit_stubs.h                      |  17 ++
>   include/rv/ltl_monitor.h                      |  32 +++
>   kernel/trace/rv/Kconfig                       |  14 +
>   kernel/trace/rv/Makefile                      |   3 +
>   kernel/trace/rv/monitors/nomiss/nomiss.c      |  30 +++
>   kernel/trace/rv/monitors/opid/opid.c          |  27 ++
>   .../trace/rv/monitors/pagefault/pagefault.c   |  26 +-
>   kernel/trace/rv/monitors/sco/sco.c            |  23 ++
>   kernel/trace/rv/monitors/sleep/sleep.c        |  64 ++++-
>   kernel/trace/rv/monitors/sssw/sssw.c          |  27 ++
>   kernel/trace/rv/monitors/sts/sts.c            |  35 +++
>   kernel/trace/rv/rv.c                          |   5 +
>   kernel/trace/rv/rv_monitors_test.c            |  99 +++++++
>   kernel/trace/rv/rv_monitors_test.h            |  90 +++++++
>   kernel/trace/rv/rv_reactors.c                 |   3 +
>   tools/verification/rv/Makefile                |   5 +-
>   tools/verification/rv/src/in_kernel.c         |  58 ++--
>   tools/verification/rv/src/rv.c                |   2 +-
>   tools/verification/rv/tests/rv_list.t         |  48 ++++
>   tools/verification/rv/tests/rv_mon.t          |  95 +++++++
>   tools/verification/rvgen/Makefile             |   4 +
>   tools/verification/rvgen/__main__.py          |  10 +-
>   .../rvgen/tests/golden/da_global/Kconfig      |   9 +
>   .../rvgen/tests/golden/da_global/da_global.c  |  95 +++++++
>   .../rvgen/tests/golden/da_global/da_global.h  |  47 ++++
>   .../tests/golden/da_global/da_global_trace.h  |  15 ++
>   .../tests/golden/da_perobj_parent/Kconfig     |  11 +
>   .../da_perobj_parent/da_perobj_parent.c       | 110 ++++++++
>   .../da_perobj_parent/da_perobj_parent.h       |  64 +++++
>   .../da_perobj_parent/da_perobj_parent_trace.h |  15 ++
>   .../tests/golden/da_pertask_desc/Kconfig      |   9 +
>   .../golden/da_pertask_desc/da_pertask_desc.c  | 105 ++++++++
>   .../golden/da_pertask_desc/da_pertask_desc.h  |  64 +++++
>   .../da_pertask_desc/da_pertask_desc_trace.h   |  15 ++
>   .../rvgen/tests/golden/ha_percpu/Kconfig      |   9 +
>   .../rvgen/tests/golden/ha_percpu/ha_percpu.c  | 244 +++++++++++++++++
>   .../rvgen/tests/golden/ha_percpu/ha_percpu.h  |  72 +++++
>   .../tests/golden/ha_percpu/ha_percpu_trace.h  |  19 ++
>   .../rvgen/tests/golden/ltl_pertask/Kconfig    |   9 +
>   .../tests/golden/ltl_pertask/ltl_pertask.c    | 107 ++++++++
>   .../tests/golden/ltl_pertask/ltl_pertask.h    | 108 ++++++++
>   .../golden/ltl_pertask/ltl_pertask_trace.h    |  14 +
>   .../rvgen/tests/golden/test_container/Kconfig |   5 +
>   .../golden/test_container/test_container.c    |  35 +++
>   .../golden/test_container/test_container.h    |   3 +
>   .../rvgen/tests/golden/test_da/Kconfig        |   9 +
>   .../rvgen/tests/golden/test_da/test_da.c      |  95 +++++++
>   .../rvgen/tests/golden/test_da/test_da.h      |  47 ++++
>   .../tests/golden/test_da/test_da_trace.h      |  15 ++
>   .../rvgen/tests/golden/test_ha/Kconfig        |   9 +
>   .../rvgen/tests/golden/test_ha/test_ha.c      | 247 ++++++++++++++++++
>   .../rvgen/tests/golden/test_ha/test_ha.h      |  72 +++++
>   .../tests/golden/test_ha/test_ha_trace.h      |  19 ++
>   .../rvgen/tests/golden/test_ltl/Kconfig       |  11 +
>   .../rvgen/tests/golden/test_ltl/test_ltl.c    | 108 ++++++++
>   .../rvgen/tests/golden/test_ltl/test_ltl.h    | 108 ++++++++
>   .../tests/golden/test_ltl/test_ltl_trace.h    |  14 +
>   .../rvgen/tests/rvgen_container.t             |  20 ++
>   .../verification/rvgen/tests/rvgen_monitor.t  |  87 ++++++
>   .../rvgen/tests/specs/test_da.dot             |  16 ++
>   .../rvgen/tests/specs/test_da2.dot            |  18 ++
>   .../rvgen/tests/specs/test_ha.dot             |  27 ++
>   .../rvgen/tests/specs/test_invalid.dot        |   8 +
>   .../rvgen/tests/specs/test_invalid.ltl        |   1 +
>   .../rvgen/tests/specs/test_invalid_ha.dot     |  16 ++
>   .../rvgen/tests/specs/test_ltl.ltl            |   1 +
>   tools/verification/tests/engine.sh            | 156 +++++++++++
>   68 files changed, 2993 insertions(+), 44 deletions(-)
>   create mode 100644 include/rv/kunit_stubs.h
>   create mode 100644 kernel/trace/rv/rv_monitors_test.c
>   create mode 100644 kernel/trace/rv/rv_monitors_test.h
>   create mode 100644 tools/verification/rv/tests/rv_list.t
>   create mode 100644 tools/verification/rv/tests/rv_mon.t
>   create mode 100644 tools/verification/rvgen/tests/golden/da_global/Kconfig
>   create mode 100644 tools/verification/rvgen/tests/golden/da_global/da_global.c
>   create mode 100644 tools/verification/rvgen/tests/golden/da_global/da_global.h
>   create mode 100644 tools/verification/rvgen/tests/golden/da_global/da_global_trace.h
>   create mode 100644 tools/verification/rvgen/tests/golden/da_perobj_parent/Kconfig
>   create mode 100644 tools/verification/rvgen/tests/golden/da_perobj_parent/da_perobj_parent.c
>   create mode 100644 tools/verification/rvgen/tests/golden/da_perobj_parent/da_perobj_parent.h
>   create mode 100644 tools/verification/rvgen/tests/golden/da_perobj_parent/da_perobj_parent_trace.h
>   create mode 100644 tools/verification/rvgen/tests/golden/da_pertask_desc/Kconfig
>   create mode 100644 tools/verification/rvgen/tests/golden/da_pertask_desc/da_pertask_desc.c
>   create mode 100644 tools/verification/rvgen/tests/golden/da_pertask_desc/da_pertask_desc.h
>   create mode 100644 tools/verification/rvgen/tests/golden/da_pertask_desc/da_pertask_desc_trace.h
>   create mode 100644 tools/verification/rvgen/tests/golden/ha_percpu/Kconfig
>   create mode 100644 tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu.c
>   create mode 100644 tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu.h
>   create mode 100644 tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu_trace.h
>   create mode 100644 tools/verification/rvgen/tests/golden/ltl_pertask/Kconfig
>   create mode 100644 tools/verification/rvgen/tests/golden/ltl_pertask/ltl_pertask.c
>   create mode 100644 tools/verification/rvgen/tests/golden/ltl_pertask/ltl_pertask.h
>   create mode 100644 tools/verification/rvgen/tests/golden/ltl_pertask/ltl_pertask_trace.h
>   create mode 100644 tools/verification/rvgen/tests/golden/test_container/Kconfig
>   create mode 100644 tools/verification/rvgen/tests/golden/test_container/test_container.c
>   create mode 100644 tools/verification/rvgen/tests/golden/test_container/test_container.h
>   create mode 100644 tools/verification/rvgen/tests/golden/test_da/Kconfig
>   create mode 100644 tools/verification/rvgen/tests/golden/test_da/test_da.c
>   create mode 100644 tools/verification/rvgen/tests/golden/test_da/test_da.h
>   create mode 100644 tools/verification/rvgen/tests/golden/test_da/test_da_trace.h
>   create mode 100644 tools/verification/rvgen/tests/golden/test_ha/Kconfig
>   create mode 100644 tools/verification/rvgen/tests/golden/test_ha/test_ha.c
>   create mode 100644 tools/verification/rvgen/tests/golden/test_ha/test_ha.h
>   create mode 100644 tools/verification/rvgen/tests/golden/test_ha/test_ha_trace.h
>   create mode 100644 tools/verification/rvgen/tests/golden/test_ltl/Kconfig
>   create mode 100644 tools/verification/rvgen/tests/golden/test_ltl/test_ltl.c
>   create mode 100644 tools/verification/rvgen/tests/golden/test_ltl/test_ltl.h
>   create mode 100644 tools/verification/rvgen/tests/golden/test_ltl/test_ltl_trace.h
>   create mode 100644 tools/verification/rvgen/tests/rvgen_container.t
>   create mode 100644 tools/verification/rvgen/tests/rvgen_monitor.t
>   create mode 100644 tools/verification/rvgen/tests/specs/test_da.dot
>   create mode 100644 tools/verification/rvgen/tests/specs/test_da2.dot
>   create mode 100644 tools/verification/rvgen/tests/specs/test_ha.dot
>   create mode 100644 tools/verification/rvgen/tests/specs/test_invalid.dot
>   create mode 100644 tools/verification/rvgen/tests/specs/test_invalid.ltl
>   create mode 100644 tools/verification/rvgen/tests/specs/test_invalid_ha.dot
>   create mode 100644 tools/verification/rvgen/tests/specs/test_ltl.ltl
>   create mode 100644 tools/verification/tests/engine.sh
> 
> 
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
