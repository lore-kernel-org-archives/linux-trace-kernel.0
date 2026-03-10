Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904923BADB7;
	Tue, 10 Mar 2026 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165003; cv=none; b=j7l40+/rVA5cWo7KlF6tGSAdkITu2boPUFbN3OSre1kfexFOb20xleBHLphWYkGYuKvb7RfG/RhnH9kfKnnLt6ReE9FyWkv6F7HJLkPwAjc6m6dL32doo7pRJRBBV2i//JrJ9pT3lofYyg/DDPCfbhuBgeDBfRVLcqrdkh/iFjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165003; c=relaxed/simple;
	bh=AsIM87EtURC0C5jogDdZMO5052tF8teRdszxyFlU+rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rH9Ntz4az3GEVCVo0myRPQ2XpkFmllYIAdKSyJ8Ev2+g9kAQTVLPCefKZdzSo8ocUUOW/jDvEtxrn7Tc4OmDqZarprWpw7M485pU/h+8Q4J0cCCnxNCuCZOSgV6FvUXsFCLOF6Y63tdGpEC/jdWP4wqnDRUX32Xjiv85nuq45b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=qEddDznM; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="qEddDznM"
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 70785B3827;
	Tue, 10 Mar 2026 17:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1773164998;
	bh=GipfqqlCII/Hem6pBQgM4xJOjMevRQ0ClZajmMmWO00=;
	h=From:To:Cc:Subject:Date;
	b=qEddDznMfx2OlOzDi8Qf5nLRp4E88iy5IfYfzYbDLYqQcehpWTY1A89JDuPKVZZjO
	 YUKDR7edSb1qsiGWyHSGZF7PDZstf4Gdt7VS2EojefP2u/XofwNRHm2abz9/b27cMn
	 Djob0d8DX05vQlflLLjbgMJWnWnC5IbGpmEZbB3Y=
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: [PATCH v2 0/2] locking: contended_release tracepoint instrumentation
Date: Tue, 10 Mar 2026 17:49:37 +0000
Message-ID: <cover.1773164180.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing contention_begin/contention_end tracepoints fire on the
waiter side. The lock holder's identity and stack can be captured at
contention_begin time (e.g. perf lock contention --lock-owner), but
this reflects the holder's state when a waiter arrives, not when the
lock is actually released.

This series adds a contended_release tracepoint that fires on the
holder side when a lock with waiters is released. This provides:

- Hold time estimation: when the holder's own acquisition was
  contended, its contention_end (acquisition) and contended_release
  can be correlated to measure how long the lock was held under
  contention.

- The holder's stack at release time, which may differ from what perf lock
  contention --lock-owner captures if the holder does significant work between
  the waiter's arrival and the unlock.

The tracepoint is placed exclusively in slowpath unlock paths, so
there is no performance impact on the uncontended fast path and
expected minimal impact on binary size.

Based on the feedback on the RFC, here is v2 with the suggested fixes.
Since there were no objections to the approach, I am dropping the RFC
tag.

RFC -> v2:

- Add trace_contended_release_enabled() guard before waiter checks that
  exist only for the tracepoint (Steven Rostedt).
- Rename __percpu_up_read_slowpath() to __percpu_up_read() (Peter
  Zijlstra).
- Add extern for __percpu_up_read() (Peter Zijlstra).
- Squashed tracepoint introduction and usage commits (Masami Hiramatsu).

RFC: https://lore.kernel.org/all/cover.1772642407.git.d@ilvokhin.com/

Dmitry Ilvokhin (2):
  locking/percpu-rwsem: Extract __percpu_up_read()
  locking: Add contended_release tracepoint

 include/linux/percpu-rwsem.h  | 15 +++------------
 include/trace/events/lock.h   | 17 +++++++++++++++++
 kernel/locking/mutex.c        |  1 +
 kernel/locking/percpu-rwsem.c | 21 +++++++++++++++++++++
 kernel/locking/rtmutex.c      |  1 +
 kernel/locking/rwbase_rt.c    |  8 +++++++-
 kernel/locking/rwsem.c        |  9 +++++++--
 kernel/locking/semaphore.c    |  4 +++-
 8 files changed, 60 insertions(+), 16 deletions(-)

-- 
2.52.0

