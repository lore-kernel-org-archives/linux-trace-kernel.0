Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86353783B4;
	Wed,  4 Mar 2026 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643408; cv=none; b=AKZzrAYgg/Wm2G1ml5H976SoecNU9pGnk32HpvOuo2cODHxxuWLbVUu6DgC+foGA7iI+D88MB9J9eJ42pxfd8C9lFOjVCKkMdd0hi8hxHGPsqLil0U36oM5ieWuNyAHVjGKDTxzSJaxdJDETATwR6cXAnGKd6g74bB63UxhrMEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643408; c=relaxed/simple;
	bh=P4X6/9hjfleWCTKn93+jDY3PJ/53nQhNhSG838GRlXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ftqFemLeueFSA7K4Hdq0vTO3kfhkxsvQb215LJ/WaSySCbVY6+UJAciP6nfWYHvxmS4hqw+PKn8tasgpJHvlOxsSja1eXpPoX8KlrJXhG2NWkBkB059nQUKiG+qy/MsfkyKc4sb8raSlNT6TsIopOS9Dmxj1Lbgpy52XTg9pMRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=wSekldyQ; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="wSekldyQ"
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 4C3AAB31B4;
	Wed, 04 Mar 2026 16:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1772643403;
	bh=T1+Xe0hpuwDVSwIdHcyHYuf9owiRaYKeAnBVPR2fvR0=;
	h=From:To:Cc:Subject:Date;
	b=wSekldyQBH/s5dnSI1CySpkLeIMgNgJZZhm/HGt4WUtqiZiYCQplr5K++GlCTWk1d
	 tgllfFIVZvMT1xHwR2g+EY7Vartths7ovlQQlcPwhRGITwrd7W6DfS4NbI0fjinznA
	 v3YSN/G2sZC/1Z2qlNy0OsUF6pEGlS4Tu5H6n3pc=
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
Subject: [PATCH RFC 0/3] locking: contended_release tracepoint instrumentation
Date: Wed,  4 Mar 2026 16:56:14 +0000
Message-ID: <cover.1772642407.git.d@ilvokhin.com>
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

Dmitry Ilvokhin (3):
  locking: Add contended_release tracepoint
  locking/percpu-rwsem: Extract __percpu_up_read_slowpath()
  locking: Wire up contended_release tracepoint

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
2.47.3

