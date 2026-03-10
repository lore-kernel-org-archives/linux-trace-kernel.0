Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BB73BE632;
	Tue, 10 Mar 2026 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165002; cv=none; b=btDDkGm4aeUCa32xzyGG2OMxlqFiWtO66bFvGe7KsWk6EPV12udYi6Fm1xxNwcIJQaJsCEilISoITkL6HqPZZu68erEVKRyw+1JfLIAxGvrJ9w2nTCeuuEvCDCW4FwdY/oI0uvalmuB/kSCzojiYaSAkxC8vxxFyMlHvZ+iYahY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165002; c=relaxed/simple;
	bh=Q4OixtmQSn7r048KVN32+hiaDorVck8Az1z4n0Qk2bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojAZ0nDKd0Hk7aIdgaKLMoUbRES5NXT1JiRu20UxwyEPwng4sUnxK32KRXOdpEoPjHVaPPXI6DIbp1+0v6lK6Fr8vct5XjtIPjEYomTjWY+qlSBnfy6T592VgpyBR6K3A9d3wh9Qvb7aj7KLlCLjdM4HbPI+bBNP1GYCSi+N604=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=GIVr/5DW; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="GIVr/5DW"
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id EE16EB382C;
	Tue, 10 Mar 2026 17:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1773164999;
	bh=9MN/vj8HfI8aMqCrRTurhnitKN8uIAxpU0TiUVovwqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GIVr/5DWzY/aI05+illM0LXMLuWwX9FDyHG64qseRzdJfUMgizJHPNVV0MJ4Sqkxk
	 W4kAaiW+bHnNMROoycbuhLq2ebHtL289aUzHWJJ582bpoSjI2ZxvCPX9dcBuGs0a7I
	 4oJ4HkzcQJXOkQiFKy5/ZbfzED01SksbuWj5nFWc=
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
Subject: [PATCH v2 2/2] locking: Add contended_release tracepoint
Date: Tue, 10 Mar 2026 17:49:39 +0000
Message-ID: <cb89caf58885858433711f0ed6238484f5f1a67f.1773164180.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773164180.git.d@ilvokhin.com>
References: <cover.1773164180.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the contended_release trace event. This tracepoint fires on the
holder side when a contended lock is released, complementing the
existing contention_begin/contention_end tracepoints which fire on the
waiter side.

This enables correlating lock hold time under contention with waiter
events by lock address.

Add trace_contended_release() calls to the slowpath unlock paths of
sleepable locks: mutex, rtmutex, semaphore, rwsem, percpu-rwsem, and
RT-specific rwbase locks. Each call site fires only when there are
blocked waiters being woken, except percpu_up_write() which always wakes
via __wake_up().

Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 include/trace/events/lock.h   | 17 +++++++++++++++++
 kernel/locking/mutex.c        |  1 +
 kernel/locking/percpu-rwsem.c |  3 +++
 kernel/locking/rtmutex.c      |  1 +
 kernel/locking/rwbase_rt.c    |  8 +++++++-
 kernel/locking/rwsem.c        |  9 +++++++--
 kernel/locking/semaphore.c    |  4 +++-
 7 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
index 8e89baa3775f..4f28e41977ec 100644
--- a/include/trace/events/lock.h
+++ b/include/trace/events/lock.h
@@ -138,6 +138,23 @@ TRACE_EVENT(contention_end,
 	TP_printk("%p (ret=%d)", __entry->lock_addr, __entry->ret)
 );
 
+TRACE_EVENT(contended_release,
+
+	TP_PROTO(void *lock),
+
+	TP_ARGS(lock),
+
+	TP_STRUCT__entry(
+		__field(void *, lock_addr)
+	),
+
+	TP_fast_assign(
+		__entry->lock_addr = lock;
+	),
+
+	TP_printk("%p", __entry->lock_addr)
+);
+
 #endif /* _TRACE_LOCK_H */
 
 /* This part must be outside protection */
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 427187ff02db..ff9d07f3e900 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -992,6 +992,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	if (waiter) {
 		next = waiter->task;
 
+		trace_contended_release(lock);
 		debug_mutex_wake_waiter(lock, waiter);
 		__clear_task_blocked_on(next, lock);
 		wake_q_add(&wake_q, next);
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index f3ee7a0d6047..1eee51766aaf 100644
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
@@ -297,6 +299,7 @@ void __percpu_up_read(struct percpu_rw_semaphore *sem)
 	 * writer.
 	 */
 	smp_mb(); /* B matches C */
+	trace_contended_release(sem);
 	/*
 	 * In other words, if they see our decrement (presumably to
 	 * aggregate zero, as that is the only time it matters) they
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index ccaba6148b61..3db8a840b4e8 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1466,6 +1466,7 @@ static void __sched rt_mutex_slowunlock(struct rt_mutex_base *lock)
 		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	}
 
+	trace_contended_release(lock);
 	/*
 	 * The wakeup next waiter path does not suffer from the above
 	 * race. See the comments there.
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 82e078c0665a..081778934b13 100644
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
@@ -205,6 +207,8 @@ static inline void rwbase_write_unlock(struct rwbase_rt *rwb)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
+	if (trace_contended_release_enabled() && rt_mutex_has_waiters(rtm))
+		trace_contended_release(rwb);
 	__rwbase_write_unlock(rwb, WRITER_BIAS, flags);
 }
 
@@ -214,6 +218,8 @@ static inline void rwbase_write_downgrade(struct rwbase_rt *rwb)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
+	if (trace_contended_release_enabled() && rt_mutex_has_waiters(rtm))
+		trace_contended_release(rwb);
 	/* Release it and account current as reader */
 	__rwbase_write_unlock(rwb, WRITER_BIAS - 1, flags);
 }
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index ba4cb74de064..cf7d8e75ad7b 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1390,6 +1390,7 @@ static inline void __up_read(struct rw_semaphore *sem)
 	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
 		      RWSEM_FLAG_WAITERS)) {
 		clear_nonspinnable(sem);
+		trace_contended_release(sem);
 		rwsem_wake(sem);
 	}
 	preempt_enable();
@@ -1413,8 +1414,10 @@ static inline void __up_write(struct rw_semaphore *sem)
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
 
@@ -1437,8 +1440,10 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
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
index 74d41433ba13..d46415095dd6 100644
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
2.52.0

