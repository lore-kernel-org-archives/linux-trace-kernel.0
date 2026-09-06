Received: from mta0.migadu.com (out-81.mta0.migadu.com [91.218.175.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAC913777E
	for <linux-trace-kernel@vger.kernel.org>; Sun,  6 Sep 2026 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714653; cv=none; b=Q2d3Qt1+ygv096TqnBpnpWgLGrpaGGrA44j/H3vMaxeE9T3oqHC46Ghkpp6RC15GU9B57QVbhpmxMFBlgL0bKI2rRfJ1MI6G1QumJu+vIZLpevvAqyHEgHHLrDHs0gT8ePk4u65DsYwDw9U4rvk1sl0uCQX5kl+Jfpb4N4JZsd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714653; c=relaxed/simple;
	bh=uhIsSL8uAPCL9XFxrlzbBIUvS1+f1cED469hgoP/HY4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=u0R/X0OOqQ6UreGx6DLRKRxZMFpM9neOAJsOQx0XKz1z2FZNSJAN2DyNzvVHE4ArVnVrQt/Wb1rs+iasugZhFRbPky8s+FeRjmIAztZRtv6TNCx81b0NieXSXgzZ0bhlPOdMAY7guNcInsvLDq0v1PVpVsIhMcFen/6EWyqu2Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aDOejnep; arc=none smtp.client-ip=91.218.175.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aDOejnep"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uhIsSL8uAPCL9XFxrlzbBIUvS1+f1cED469hgoP/HY4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788714649; v=1; x=1789319449;
 b=aDOejnep06KU67Dx9YIzkSmox/de6aphd+eZKUExPOyEzK6n4i/M7IFPtgvk+TRBF42HAuIe
 RVG+EhJ2oyMMrw7grRRi0kPqxBmiW05PApbNNfX1k7yGXJTiVnfC2q9vbozlMmPH+0Rc0rVVP99
 KOs+KB/kmCA9yY+6hecKNFQE=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id ae97c8c60dec1d97;
	Sun, 06 Sep 2026 17:10:49 +0000
X-Mizu-Trace-ID: ae97c8c60dec1d97
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v5 0/5] rv/reactors: fix lockdep warning and add tests
Date: Mon,  7 Sep 2026 01:10:36 +0800
Message-Id: <cover.1788705281.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

We occasionally hit a lockdep "Invalid wait context" warning in
production when a reactor callback is preempted by a timer interrupt.
On interrupt exit the scheduler takes rq->__lock (LD_WAIT_SPIN) while
rv_react() still holds its wait-type-override map, which declared
LD_WAIT_FREE.  On any kernel where the task context has preemption
enabled (not just CONFIG_PREEMPT_RT) this triggers a spurious lockdep
report:

    [ BUG: Invalid wait context ]
    1 lock held by kunit_try_catch/209:
     #0: (rv_react_map-wait-type-override){+.+.}-{1:1}
    kunit_try_catch/209 is trying to lock:
    ffff8a743ed3e8a0 (&rq->__lock){-...}-{2:2}

This series fixes the wait type (patch 1), makes reactor registration
failures propagate (patch 2), adds support for module-based
reactors (patch 3), and adds KUnit/kselftest coverage (patch 4-5).

Changes in v5:
- Patch 1: the locking rules no longer go to
  Documentation/trace/rv/monitor_synthesis.rst, which is not about
  reactors (Gabriele); they are documented in code comments.
  Functional code unchanged.
- Patch 2: unchanged
- Patch 3: redesigned. v4 only exported the registration helpers,
  which is harmless while all in-tree reactors are built-in, but
  would let a loudable reactor module be unloaded while a monitor
  still refereances its react() callback. Per the suggestion in
  commit 3d3800b4f7 ("rv: Remove rv_reactor's reference counter").
  A new selftest (patch 5) exercises it.
- Patch 4: The test callback is kept busy for two timer ticks so
  the test also passes with HZ < 200.
- Patch 5: a selftest module that registers a reactor exercises
  the module pinni g end to end: rmmod must fail while a monitor
  is attached. 

v4: https://lore.kernel.org/lkml/cover.1787854397.git.wen.yang@linux.dev/
v3: https://lore.kernel.org/lkml/cover.1786294920.git.wen.yang@linux.dev/
v2: https://lore.kernel.org/lkml/cover.1785695669.git.wen.yang@linux.dev/
v1: https://lore.kernel.org/lkml/cover.1781541556.git.wen.yang@linux.dev/

Wen Yang (5):
  rv/reactors: use LD_WAIT_SPIN as the reactor lockdep wait type
  rv/reactors: propagate rv_register_reactor() error from reactor init
  rv/reactors: export rv_register_reactor() and rv_unregister_reactor()
  rv/reactors: add KUnit tests for reactor registration and dispatch
  selftests/verification: Test loadable module-based reactor

 include/linux/rv.h                            |   3 +
 kernel/trace/rv/Kconfig                       |  12 ++
 kernel/trace/rv/Makefile                      |   1 +
 kernel/trace/rv/reactor_panic.c               |   3 +-
 kernel/trace/rv/reactor_printk.c              |   3 +-
 kernel/trace/rv/rv.c                          |   5 +
 kernel/trace/rv/rv_reactors.c                 |  48 ++++++--
 kernel/trace/rv/rv_reactors_kunit.c           | 110 ++++++++++++++++++
 tools/testing/selftests/verification/Makefile |   1 +
 tools/testing/selftests/verification/config   |   2 +
 .../test.d/rv_reactor_loadable.tc             |  46 ++++++++
 .../verification/test_modules/Makefile        |  16 +++
 .../test_modules/rv_test_reactor.c            |  37 ++++++
 13 files changed, 276 insertions(+), 11 deletions(-)
 create mode 100644 kernel/trace/rv/rv_reactors_kunit.c
 create mode 100644 tools/testing/selftests/verification/test.d/rv_reactor_loadable.tc
 create mode 100644 tools/testing/selftests/verification/test_modules/Makefile
 create mode 100644 tools/testing/selftests/verification/test_modules/rv_test_reactor.c

base-commit: 785095112f4198de49760552374f364043c8dbdf
-- 
2.25.1

