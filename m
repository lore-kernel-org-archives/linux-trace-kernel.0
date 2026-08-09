Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD1478F2B
	for <linux-trace-kernel@vger.kernel.org>; Sun,  9 Aug 2026 17:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786295473; cv=none; b=maFM2YrUWTTlTlLdQiklKXwYd5XwLEHDoNW64xXMTpNfNyIPqJq4yW22ALDvEhTIdBcghNoC2MlxU80WJW465bFvbTn6xH+vdxojIV+wr5UlxSTe5ywI2RekKCW3CFWD0uBVfzizDptdvhl/wp/re7+7IRV/mn6j/X5qE0CQFl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786295473; c=relaxed/simple;
	bh=41cfatl71cR5zJ3hrhQdWxiYN42mLzQ/yO0upW5f2NM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QjcsWU78nnUBHui9ee13KNjuFaqFmNlQgbAonqQQ442TBXxuGLaBhMWaYbXtI5wKYpGjtvt3jX8tKXXVgxl36sK5EyyWO5sSxCd4pzSBQWNLbCjRSOmnV/Fyw+AheVUoSTiIeHaQd164kdBc8H1wWPO5nMYa1EvZMpN3abaF4kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w0Z66gnt; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w0Z66gnt"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786295466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PRyewFmNXjglDR9PnGZbqs5K4K3sd/JST9jCUvtJSxs=;
	b=w0Z66gntONlZFswFqy2CSWup/7FwkMY1N92SUYLyYXlwboqAMfM1jTeWlgf7paw2RFy5Yy
	BBoLZepmHo4XnSHaT9edD5/g7kq5AtqfjswWhTSIZWS1P/DwrCTwgrO+gVV4Grm+5/HNV8
	guR4QhGDbg2WIjr8V67SdTfFQ6rN9KI=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 0/4] rv/reactors: fix lockdep warning and add KUnit tests
Date: Mon, 10 Aug 2026 01:10:37 +0800
Message-Id: <cover.1786294920.git.wen.yang@linux.dev>
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
LD_WAIT_FREE.  On any kernel where the task context has preemption
enabled (not just CONFIG_PREEMPT_RT) this triggers a spurious lockdep
report:

    [ BUG: Invalid wait context ]
    1 lock held by kunit_try_catch/209:
     #0: (rv_react_map-wait-type-override){+.+.}-{1:1}
    kunit_try_catch/209 is trying to lock:
    ffff8a743ed3e8a0 (&rq->__lock){-...}-{2:2}

Changes in v3:

Patch 1:
- Rewrite commit message to clarify that the bug is not
  PREEMPT_RT-specific: any preemptible task context can be interrupted
  by a timer, and the scheduler acquires rq->__lock (LD_WAIT_SPIN) on
  interrupt exit while rv_react() still holds its LD_WAIT_FREE override
  map.
- Rewrite the inline comment in rv_react() to make clear.

Patch 3:
- Fix commit message: missing EXPORT_SYMBOL_GPL() is caught by modpost
  at link time, not at load time.

Patch 4:
- Drop test_reactor_registered bool and the unregister_test_reactor()
  wrapper entirely.
- Remove test_register_unregister(); the teardown already covers the
  unregister path, and test_double_register() exercises the full
  register->verify->unregister-via-teardown flow.
- Replace the runtime KUNIT_ASSERT_EQ(strlen(...)) guard in
  test_name_too_long() with a _Static_assert on the name array size.
- In test_react_no_callback(): reuse the existing react_call_count
  atomic to assert that the callback was never invoked.
  This catches a broader class of regressions — e.g. 
  an inverted or missing NULL guard that does not cause a NULL dereference.

No functional change to patches 2-3; the series structure is unchanged.

Tested with CONFIG_PROVE_LOCKING=y and CONFIG_KUNIT=y.

v2: https://lore.kernel.org/lkml/cover.1785695669.git.wen.yang@linux.dev/
v1: https://lore.kernel.org/lkml/cover.1781541556.git.wen.yang@linux.dev/

Wen Yang (4):
  rv/reactors: use context-sensitive lockdep wait type in rv_react()
  rv/reactors: propagate rv_register_reactor() error from reactor init
  rv/reactors: export rv_register_reactor() and rv_unregister_reactor()
  rv/reactors: add KUnit tests for reactor registration and dispatch

 kernel/trace/rv/Kconfig             |  12 +++
 kernel/trace/rv/Makefile            |   1 +
 kernel/trace/rv/reactor_panic.c     |   3 +-
 kernel/trace/rv/reactor_printk.c    |   3 +-
 kernel/trace/rv/rv_reactors.c       |  22 +++--
 kernel/trace/rv/rv_reactors_kunit.c | 119 ++++++++++++++++++++++++++++
 6 files changed, 151 insertions(+), 9 deletions(-)
 create mode 100644 kernel/trace/rv/rv_reactors_kunit.c

base-commit: 785095112f4198de49760552374f364043c8dbdf
-- 
2.25.1

