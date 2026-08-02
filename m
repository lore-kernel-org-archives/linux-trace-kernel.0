Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DD0321457
	for <linux-trace-kernel@vger.kernel.org>; Sun,  2 Aug 2026 18:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785696212; cv=none; b=ojHGzgOV2JSo8jUr5bIKcn2LYfkzjl8Tr/xtr1wuTC3f609DMSFGHk73j7Z5BlFLN70QDTOkJy/QMK/v9TXtWBaxPZ2A912AklGaCnQtrs6wwB27HTs+XD1SgY69iIfyTkM4eiUiaU6/7Sb8c1Kjv+S9/kKUbD30D/xw0gD2s18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785696212; c=relaxed/simple;
	bh=YEyzjMeS8js33AEl9GjtVkwpQHSkGLvkcMotlrnmauM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XlJm9/gauGzicOPdGpHsvki+Pp8HcQ6cLDk1xTChGnZtNMrafGft0LXftlWx+ptVtVUo2xBwiDPiYpaCMdLYL7KD7N9D8wVSCnIXWQlBAl3B/s22UyBGLmHOy1o+bMD5gd+7lHv7EaSs1FAhXzlOUgbhIInQ+ZUjpHLBheomKV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RX3smoIP; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RX3smoIP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785696206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4p2L5iN6WpUtpBEvtUH8ZiYDXcD2XCF9Z9RPFykDAFg=;
	b=RX3smoIPKucsT2OzTuNM1Zcv2miup9DMPODirtl8N2ha7OxADpVHYIjA6bNeeb5/8H4ync
	c8TQjHx20WWujSSDAX/zOu3YoOHYlgAsCTlg3moJQfPrnFE8MI+V+UvXpOTfkaShnmb26r
	EqMAvwEtTv7HGLtVy72yg0O6KqgDKh4=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v2 0/4] rv/reactors: fix lockdep warning and add KUnit tests
Date: Mon,  3 Aug 2026 02:43:01 +0800
Message-Id: <cover.1785695669.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

We occasionally hit a lockdep "Invalid wait context" warning in
production when a reactor callback is preempted by a timer interrupt.
On interrupt exit the scheduler takes rq->__lock (LD_WAIT_SPIN) while
rv_react() still holds its wait-type-override map, which declared
LD_WAIT_FREE.  On a preemptible kernel (e.g. CONFIG_PREEMPT_RT) this
triggers a spurious lockdep report:

    [ BUG: Invalid wait context ]
    1 lock held by kunit_try_catch/209:
     #0: (rv_react_map-wait-type-override){+.+.}-{1:1}
    kunit_try_catch/209 is trying to lock:
    ffff8a743ed3e8a0 (&rq->__lock){-...}-{2:2}

Changes in v2:
- Use a context-sensitive override map: LD_WAIT_SPIN in preemptible
  contexts, LD_WAIT_FREE in NMI/hardirq where the scheduler cannot run
  (patch 1).
- Merge the v1 printk/panic test files into one generic rv_reactors_kunit
  covering registration and dispatch, as the v1 tests were mostly not
  reactor-specific (patches 2-4).
- Export rv_register_reactor()/rv_unregister_reactor() so the tristate
  KUnit module can link against them (patch 3).
- Propagate rv_register_reactor() errors from the built-in reactor init
  functions instead of silently ignoring them (patch 2).
- KUnit tests are tristate (usable with CONFIG_KUNIT=m) and verify the
  callback is actually invoked (atomic counter), the exact -EINVAL on
  duplicate registration, and use mdelay(5) to exercise the lockdep
  context under load.  A teardown action unregisters the test reactor
  even if a test aborts.

Patch 1 fixes the lockdep warning.  Patches 2-3 make the registration
API usable by the test module and propagate its errors.  Patch 4 adds
the KUnit tests.

Tested with CONFIG_PROVE_LOCKING=y and CONFIG_KUNIT=y.



Wen Yang (4):
  rv/reactors: use context-sensitive lockdep wait type in rv_react()
  rv/reactors: propagate rv_register_reactor() error from reactor init
  rv/reactors: export rv_register_reactor() and rv_unregister_reactor()
  rv/reactors: add KUnit tests for reactor registration and dispatch

 kernel/trace/rv/Kconfig             |  12 +++
 kernel/trace/rv/Makefile            |   1 +
 kernel/trace/rv/reactor_panic.c     |   3 +-
 kernel/trace/rv/reactor_printk.c    |   3 +-
 kernel/trace/rv/rv_reactors.c       |  19 +++-
 kernel/trace/rv/rv_reactors_kunit.c | 143 ++++++++++++++++++++++++++++
 6 files changed, 172 insertions(+), 9 deletions(-)
 create mode 100644 kernel/trace/rv/rv_reactors_kunit.c

base-commit: 984b5a36fd12d1849511a45fda32036fe2b0d004
-- 
2.25.1

