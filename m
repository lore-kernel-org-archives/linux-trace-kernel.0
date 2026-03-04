Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51669372677;
	Wed,  4 Mar 2026 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643409; cv=none; b=f/9BGiqm77HoVMgvmYUsa/XnKHyJIP+MvDKxcg0Hh0/YukCSkl2QdBcSTKve1aZww8+dw/m9fAi0r6SavwmiIG4m6ihOCiN6htX9C/ZuLxBwV9tF8WrN/YieX/W6jvYkBlPMJbBARVMD/nXr0pgkNpaz9eKoS4WqLlYY7oBOnkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643409; c=relaxed/simple;
	bh=1fUtrlDpgbrUR+yYwNlMerzKfaVcMK0zTwfJJXGEJVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgEB114YJB4ungZ19s67VGLAt0ZrmuWD2nv6mttSUEivBHM7lr6ktt7NKqDskPNtWwLSmH1W7Shh8dToMTqekfqdOtIdH2nLoHpZ7cxNs+pEClHD+Ixbk6u6QuF1Nn2G6RRGSwuBepG+SQ2Qa1VA6R6uQglC+N9ApfnmT+7e388=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=X3TlCjHO; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="X3TlCjHO"
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 45993B31BE;
	Wed, 04 Mar 2026 16:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1772643404;
	bh=O3yRfNXX1+f1+LW15V0yGBwftW08pQA9GRuFVJ3tzvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X3TlCjHOsSseO+2N7d1/0TOOCk2wyunsg9PR1h+de8WTIZv1RH7Mkc1VJx5uZDoFS
	 d4oQJ0cSWvIlmN53vvg4LkZCrvbRvupa6DyK7X/cd3VKR3xSrMQQfVmw4eC6Z33CBg
	 dx4CGpln3mqj8r/39TWNRRcRvU0sGT49U+bQHCL8=
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
Subject: [PATCH RFC 3/3] locking: Wire up contended_release tracepoint
Date: Wed,  4 Mar 2026 16:56:17 +0000
Message-ID: <8298e098d3418cb446ef396f119edac58a3414e9.1772642407.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772642407.git.d@ilvokhin.com>
References: <cover.1772642407.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add trace_contended_release() calls to the slowpath unlock paths of
sleepable locks: mutex, rtmutex, semaphore, rwsem, percpu-rwsem, and
RT-specific rwbase locks. Each call site fires only when there are
blocked waiters being woken, except percpu_up_write() which always wakes
via __wake_up().

Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 kernel/locking/mutex.c        | 1 +
 kernel/locking/percpu-rwsem.c | 3 +++
 kernel/locking/rtmutex.c      | 1 +
 kernel/locking/rwbase_rt.c    | 8 +++++++-
 kernel/locking/rwsem.c        | 9 +++++++--
 kernel/locking/semaphore.c    | 4 +++-
 6 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index c867f6c15530..54ca045987a2 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -970,6 +970,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 
 		next = waiter->task;
 
+		trace_contended_release(lock);
 		debug_mutex_wake_waiter(lock, waiter);
 		__clear_task_blocked_on(next, lock);
 		wake_q_add(&wake_q, next);
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 4190635458da..0f2e8e63d252 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -263,6 +263,8 @@ void percpu_up_write(struct percpu_rw_semaphore *sem)
 {
 	rwsem_release(&sem->dep_map, _RET_IP_);
 
+	trace_contended_release(sem);
+
 	/*
 	 * Signal the writer is done, no fast path yet.
 	 *
@@ -297,6 +299,7 @@ void __percpu_up_read_slowpath(struct percpu_rw_semaphore *sem)
 	 * writer.
 	 */
 	smp_mb(); /* B matches C */
+	trace_contended_release(sem);
 	/*
 	 * In other words, if they see our decrement (presumably to
 	 * aggregate zero, as that is the only time it matters) they
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index c80902eacd79..e0873f0ed982 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1457,6 +1457,7 @@ static void __sched rt_mutex_slowunlock(struct rt_mutex_base *lock)
 		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	}
 
+	trace_contended_release(lock);
 	/*
 	 * The wakeup next waiter path does not suffer from the above
 	 * race. See the comments there.
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 9f4322c07486..42f3658c0059 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -162,8 +162,10 @@ static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
 	 * worst case which can happen is a spurious wakeup.
 	 */
 	owner = rt_mutex_owner(rtm);
-	if (owner)
+	if (owner) {
+		trace_contended_release(rwb);
 		rt_mutex_wake_q_add_task(&wqh, owner, state);
+	}
 
 	/* Pairs with the preempt_enable in rt_mutex_wake_up_q() */
 	preempt_disable();
@@ -204,6 +206,8 @@ static inline void rwbase_write_unlock(struct rwbase_rt *rwb)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
+	if (rt_mutex_has_waiters(rtm))
+		trace_contended_release(rwb);
 	__rwbase_write_unlock(rwb, WRITER_BIAS, flags);
 }
 
@@ -213,6 +217,8 @@ static inline void rwbase_write_downgrade(struct rwbase_rt *rwb)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
+	if (rt_mutex_has_waiters(rtm))
+		trace_contended_release(rwb);
 	/* Release it and account current as reader */
 	__rwbase_write_unlock(rwb, WRITER_BIAS - 1, flags);
 }
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 24df4d98f7d2..4e61dc0bb045 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1360,6 +1360,7 @@ static inline void __up_read(struct rw_semaphore *sem)
 	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
 		      RWSEM_FLAG_WAITERS)) {
 		clear_nonspinnable(sem);
+		trace_contended_release(sem);
 		rwsem_wake(sem);
 	}
 	preempt_enable();
@@ -1383,8 +1384,10 @@ static inline void __up_write(struct rw_semaphore *sem)
 	preempt_disable();
 	rwsem_clear_owner(sem);
 	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
-	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
+	if (unlikely(tmp & RWSEM_FLAG_WAITERS)) {
+		trace_contended_release(sem);
 		rwsem_wake(sem);
+	}
 	preempt_enable();
 }
 
@@ -1407,8 +1410,10 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 	tmp = atomic_long_fetch_add_release(
 		-RWSEM_WRITER_LOCKED+RWSEM_READER_BIAS, &sem->count);
 	rwsem_set_reader_owned(sem);
-	if (tmp & RWSEM_FLAG_WAITERS)
+	if (tmp & RWSEM_FLAG_WAITERS) {
+		trace_contended_release(sem);
 		rwsem_downgrade_wake(sem);
+	}
 	preempt_enable();
 }
 
diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index 3ef032e22f7e..3cef5ba88f7e 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -231,8 +231,10 @@ void __sched up(struct semaphore *sem)
 	else
 		__up(sem, &wake_q);
 	raw_spin_unlock_irqrestore(&sem->lock, flags);
-	if (!wake_q_empty(&wake_q))
+	if (!wake_q_empty(&wake_q)) {
+		trace_contended_release(sem);
 		wake_up_q(&wake_q);
+	}
 }
 EXPORT_SYMBOL(up);
 
-- 
2.47.3

