Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28C4223707;
	Thu,  4 Jun 2026 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557333; cv=none; b=IJKJO6bpxXLM7QNnPu0JbQt8wqHG6sT6QsmxbDy9gmB19XU98Qn6QzPDlMFPp991+QuHpT+KiPy1GknlgAZeLTtRhV3s135CyXVLIkU3zbzodL3T2PQTgnAC3V8tSo9x+QnBGzIxohAiO+C4ueNT1i8kPOJ9fJJIfa8frdqAIJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557333; c=relaxed/simple;
	bh=tdu6AFVY7PKFlWstLgLStSnczaYgjy6c+BOW2PvNzyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mTakMJgdr+QZMlOH2IOcmua2w3/eOEz8fPTYGPZjutOSB5l0rAreXEUTUAOV86XA23Momjo3hM9hFrLPSVSPquT+Jrx+Kopg2soL6YMAX2LFz2XStj6rEVhuWu2SWvbjXRzjuWVXv/KA7utSzz4EpfZWlLOboOw2W0a25K3YY0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=mxVOn/D4; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="mxVOn/D4"
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 6B4B8D1154;
	Thu, 04 Jun 2026 07:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1780557329;
	bh=Hg79y15YCdHs+Aahi2RclYmfUq76gHwLkFjgTtqnUGk=;
	h=From:To:Cc:Subject:Date;
	b=mxVOn/D46yT/c8oRCWsfgKBKKJdDOYbfbftFtW1NR+CFmqTi8/81mGSrmmM3F2sjW
	 1+KkuhAIt9c4x3RtV5+/g3DJIwGeXX+QE0cq+oBQYJlW6bR+JPk/hnGB4KuAJAAZoJ
	 VS3erzX5NwDRv+n9slnaOvs3lyUa/1lt3ODHjBuU=
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: [PATCH v7 0/3] locking: contended_release tracepoint instrumentation
Date: Thu,  4 Jun 2026 07:15:04 +0000
Message-ID: <cover.1780506267.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing contention_begin/contention_end tracepoints fire on the
waiter side. The lock holder's identity and stack can be captured at
contention_begin time (e.g. perf lock contention --lock-owner), but only
for locks whose owner it reads: mutex and rwsem. Other lock types have
none it can read, so they get no holder-side attribution today.

This series adds a contended_release tracepoint that fires on the
holder side when a lock with waiters is released. This provides:

- Hold time estimation: when the holder's own acquisition was
  contended, its contention_end (acquisition) and contended_release
  can be correlated to measure how long the lock was held under
  contention.

- The holder's stack at release time, which may differ from what perf lock
  contention --lock-owner captures if the holder does significant work between
  the waiter's arrival and the unlock.

Note: for reader/writer locks, the tracepoint fires for every reader
releasing while a writer is waiting, not only for the last reader.

v6 -> v7:

- Dropped spinlocks instrumentation patches, I'll rework them based on Peter's
  static call idea. See [2].

v5 -> v6:

- Use trace_call__contended_release() instead of trace_contended_release(),
  where appropriate to avoid a redundant static branch check when the caller
  already guards with trace_contended_release_enabled().
- Added acked-by from Paul.
- Rebase on top of the fresh locking/core.

v4 -> v5:

- Split the combined spinning locks patch into separate qspinlock and
  qrwlock patches (Paul E. McKenney).
- Factor out __queued_read_unlock()/__queued_write_unlock() as a
  separate preparatory commit, mirroring the queued_spin_release()
  split (Paul E. McKenney).
- Updated binary size numbers for qspinlock-only change.
- Added Acked-by and Reviewed-by tags where appropriate.

v3 -> v4:

- Fix spurious events in __percpu_up_read(): guard with
  rcuwait_active(&sem->writer) to avoid tracing during the RCU grace
  period after a writer releases (Sashiko).
- Fix possible use-after-free in semaphore up(): move
  trace_contended_release() inside the sem->lock critical section
  (Sashiko).
- Fix build failure with CONFIG_PARAVIRT_SPINLOCKS=y: introduce
  queued_spin_release() as the arch-overridable unlock primitive,
  so queued_spin_unlock() can be a generic tracing wrapper. Convert
  x86 (paravirt) and MIPS overrides (Sashiko).
- Add EXPORT_TRACEPOINT_SYMBOL_GPL(contended_release) for module
  support (Sashiko).
- Split spinning locks patch: factor out queued_spin_release() as a
  separate preparatory commit (Sashiko).
- Make read unlock tracepoint behavior consistent across all
  reader/writer lock types: fire for every reader releasing while
  a writer is waiting (rwsem, rwbase_rt were previously last-reader
  only).

v2 -> v3:

- Added new patch: extend contended_release tracepoint to queued spinlocks
  and queued rwlocks (marked as RFC, requesting feedback). This is prompted by
  Matthew Wilcox's suggestion to try to come up with generic instrumentation,
  instead of instrumenting each "special" lock manually. See [1] for the
  discussion.
- Reworked tracepoint placement to fire before the lock is released and
  before the waiter is woken where possible, for consistency with
  spinning locks where there is no explicit wake (inspired by Usama Arif's
  suggestion).
- Remove unnecessary linux/sched.h include from trace/events/lock.h.

RFC -> v2:

- Add trace_contended_release_enabled() guard before waiter checks that
  exist only for the tracepoint (Steven Rostedt).
- Rename __percpu_up_read_slowpath() to __percpu_up_read() (Peter
  Zijlstra).
- Add extern for __percpu_up_read() (Peter Zijlstra).
- Squashed tracepoint introduction and usage commits (Masami Hiramatsu).

v6: https://lore.kernel.org/all/cover.1777999826.git.d@ilvokhin.com/
v5: https://lore.kernel.org/all/cover.1776350944.git.d@ilvokhin.com/
v4: https://lore.kernel.org/all/cover.1774536681.git.d@ilvokhin.com/
v3: https://lore.kernel.org/all/cover.1773858853.git.d@ilvokhin.com/
v2: https://lore.kernel.org/all/cover.1773164180.git.d@ilvokhin.com/
RFC: https://lore.kernel.org/all/cover.1772642407.git.d@ilvokhin.com/

[1]: https://lore.kernel.org/all/aa7G1nD7Rd9F4eBH@casper.infradead.org/
[2]: https://lore.kernel.org/all/20260603120811.GW3493090@noisy.programming.kicks-ass.net/

Dmitry Ilvokhin (3):
  tracing/lock: Remove unnecessary linux/sched.h include
  locking/percpu-rwsem: Extract __percpu_up_read()
  locking: Add contended_release tracepoint to sleepable locks

 include/linux/percpu-rwsem.h  | 15 +++------------
 include/trace/events/lock.h   | 18 +++++++++++++++++-
 kernel/locking/mutex.c        |  4 ++++
 kernel/locking/percpu-rwsem.c | 29 +++++++++++++++++++++++++++++
 kernel/locking/rtmutex.c      |  1 +
 kernel/locking/rwbase_rt.c    |  6 ++++++
 kernel/locking/rwsem.c        | 10 ++++++++--
 kernel/locking/semaphore.c    |  4 ++++
 8 files changed, 72 insertions(+), 15 deletions(-)

-- 
2.53.0-Meta

