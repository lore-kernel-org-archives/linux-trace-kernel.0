Received: from mta0.migadu.com (out-16.mta0.migadu.com [91.218.175.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A1A499F37
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854992; cv=none; b=O3j3dfokK2X/hpeNOklu08n7XlAt7nA583mBWO2/0EGGcc517JUK7DmgbuKTbhFY9x4vr/Buig6Fy3+XR6HYwwd6Q28thQj4sJ7WAf1+j7M8w4SCebTuDs9e2CKCP7hpUtNZx4LRJWxeUyLlNHuYj3gplK15a7ouwUzuzGBaBf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854992; c=relaxed/simple;
	bh=SxVi2z3QRiX/F39vYQtWp67pmU/KY1qRecCfZ8V16kw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CAToQnXlkSFw3CN2SoNJLhbmqcSTPIwY70ZJa/pzGARQG67H1VRwXhAUpzGLrRgM/VIdbuDfghzc8sIt1dS6e6XxxnyTOlsjP85pNYcmkMTd6MOuq4GIEoh1Twisl3S4obmquY/hON7Aarx8WqxEYHcZcx0oYyQwhH6kBh0qYXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UzpZevLw; arc=none smtp.client-ip=91.218.175.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UzpZevLw"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SxVi2z3QRiX/F39vYQtWp67pmU/KY1qRecCfZ8V16kw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787854987; v=1; x=1788459787;
 b=UzpZevLw0kHvBvFWM2GrM5X1nJ7pyOcFN3P6CQHHXgU9h7oIPLkGN5T27hwsDNUIVQRsDuat
 HycSxt/D6KYpCxTyrBcu0v3FhvkmGQISyn21LvnRsFgeaRwyiXz+fepqNGiWJLjJKKmCRaZ2Tcq
 uLxfS/2p9EAuPcJUn71Z1gZ0=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id ac256f1d91d16a89;
	Thu, 27 Aug 2026 18:22:57 +0000
X-Mizu-Trace-ID: ac256f1d91d16a89
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v4 0/4] rv/reactors: fix lockdep warning and add KUnit tests
Date: Fri, 28 Aug 2026 02:22:42 +0800
Message-Id: <cover.1787854397.git.wen.yang@linux.dev>
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

This series switches to a single LD_WAIT_SPIN override, hardens reactor
registration error handling, exports the registration helpers for
modules, and adds KUnit coverage.

Changes in v4:
  - Patch 1: replace the context-sensitive two-map wait type with a
    single LD_WAIT_SPIN override, and document the constraint.
  - Patch 4: use a plain int instead of atomic_t for the test counter,
    trim redundant comments.

v3: https://lore.kernel.org/lkml/cover.1786294920.git.wen.yang@linux.dev/
v2: https://lore.kernel.org/lkml/cover.1785695669.git.wen.yang@linux.dev/
v1: https://lore.kernel.org/lkml/cover.1781541556.git.wen.yang@linux.dev/

Wen Yang (4):
  rv/reactors: use LD_WAIT_SPIN as the reactor lockdep wait type
  rv/reactors: propagate rv_register_reactor() error from reactor init
  rv/reactors: export rv_register_reactor() and rv_unregister_reactor()
  rv/reactors: add KUnit tests for reactor registration and dispatch

 Documentation/trace/rv/monitor_synthesis.rst |  20 ++++
 kernel/trace/rv/Kconfig                      |  12 +++
 kernel/trace/rv/Makefile                     |   1 +
 kernel/trace/rv/reactor_panic.c              |   3 +-
 kernel/trace/rv/reactor_printk.c             |   3 +-
 kernel/trace/rv/rv_reactors.c                |   8 +-
 kernel/trace/rv/rv_reactors_kunit.c          | 105 +++++++++++++++++++
 7 files changed, 147 insertions(+), 5 deletions(-)
 create mode 100644 kernel/trace/rv/rv_reactors_kunit.c

base-commit: 785095112f4198de49760552374f364043c8dbdf
-- 
2.25.1

