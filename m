Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C31D3DE423
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 11:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773229998; cv=none; b=uNIOHyWTjNAsYguIfMEFaGJxJaYZVCb3lP6BlZhwiVNI2Xfa+4V3tIdej0stecBP/H30hVI9CPPTr93JHByFDuYrv9DG//jNE7sMrqb0DLgCCLjEAmrzUVijjqgfzGPhE+jrVAZdWMYAXxP1i5xkUFZrSetQmod2kxxaps8j9MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773229998; c=relaxed/simple;
	bh=0Ifq6XmVDs1fpC0j/ZIbpmcmAOkRHB7zh4IlFJ+hrPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwICWk17La6iqBRAXMjV7QMv79smIHC6drAH3D/+fzyYLazwUWHfsQ8jDRZK/0L4DS1FV2ZELJ8SOum7mhnR4O/A6MJgXhcu3hLsFKAeMQXskVXrCvEIOmmgl6baQoF+a74q9pCsPC+WQzOllqQpPV54jwPw6+45MFpT727Ol/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYer6CG2; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYer6CG2"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-829abaaa92bso2586955b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 04:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773229996; x=1773834796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8J94ffxrGM62oAfDCHAJ0pM0R8c1cTRpTTHeUMpVEkI=;
        b=UYer6CG2Qk+1RQ0sFdcJogoULr9wpNO4LFRhlyocSUTeRH0zC/WN5npgdGZpWteCn8
         qWCaVSElzNrOP4fX1WLf4O3SH412LNz7cpCb9/G1btS4jckBqrFBZwv1hleXw6CshboL
         MjMV1gVUfgVcsbCKKDvGldNt4WiVPag7YRHMAi9VRS/x3SMDHcfWSbk4v9smy2emHBYu
         VitmMMj/JkdP9cxhOBdE2RR1ZQnotXJqgJdWf1SkNxO1Qs7oLmOz0KBNoiEGQsoXEt4X
         gw/U720tNcH4HoypLTCI4VcjgTNE3eknMYHTU1uwy/k0Tc3d3qJWApVZhFz7DtxBYFVX
         BmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773229996; x=1773834796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8J94ffxrGM62oAfDCHAJ0pM0R8c1cTRpTTHeUMpVEkI=;
        b=i0ylDSbtYO+PWWIBBwtqTu1b8HDwb7At8HdBYK0eR+0lkAt/kb8LCgyMJBTXFl/gPR
         awTB/5Z3R7Ij7lvTpnOzCdAUPXLKjS6MNUy75Aym9cuuG0aa7vAGOUC6o8SN94msXGav
         rVCPqFSmjsrvcN57QJU7boL3vO0pMvYJwl/drW9W0HD8yy6ujncpVNux1qqljRUsOtkk
         4W+IAgPdr6FFSg7yIF47ZqXptuJ6fmnR0U5aYarSioZcpTSHo9IT8R2zaNXzSLkH8efa
         HcDePiSq9j9I5Q0N7W4tXmGAIT3gyiu7XSO0jBs1FRXPVHMRu6Kt9cGVuWUuxZrszmzg
         RZ8A==
X-Forwarded-Encrypted: i=1; AJvYcCW/BgfB3uDA0bFDZoyzbxzwRiiywkypGIO/YRL3lwWmWTjqD6D76jyUlNY20O7wyscF7BilPs2fY4lJmFPs5uKVfNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyHFlLZi/DJnvn9RMBb6A5NSl6yzpP1j1rNGpUKf/mgQdVpnyF
	ze7nL4SLSqHVjteYW4lgfpWH12rrecXtnLkHPBCRcbstNLC1Fwkdtfo6
X-Gm-Gg: ATEYQzz/l1k0DBmc0OxBp+Cn49a6BtXFiQFvK+1G4E66GuXvO2DrCl++puMM1i3/8kB
	Pox2m4tPpQGfdHzry177sHbVThlUv7Wug+q+12wSHC0PjWUoxfmD+8SCGgXB73clTKlR9f0SAdv
	k7HOK9Xg0cy71W42JaXRpFDcGLn78Ev5XOhcQi9diuPLLrAAR8esGedfqusdx8DgbqAWgTrd5r9
	GpLaakHZI6yA7lfd5EZaS0c9eKlYmjbsL0Qm3t5xWBKuLRyovPo7LpN6wCG1cwtf7wFCL3zbNBc
	KVz77k9/eu4V9/1QlBS4ThJMursI2I6N8fO0My4cfE4GKplc9b+vQPZ1eM3zyzUwKO32SonU9D5
	uGWKFL1CgyPObx96aDcYDCfoDYYmMP95QHev+HDc6GJr9eWC1VHXB+mturg4VIgJyiDDLEDcOuP
	zNulZncadPZvDLq9CYMvqkfTWNNNRlq49mZfL1r1xkEkUVm7TpNJra25lkchTPChI=
X-Received: by 2002:a05:6a00:44c5:b0:829:800b:9fe with SMTP id d2e1a72fcca58-829f706890cmr2213115b3a.39.1773229996428;
        Wed, 11 Mar 2026 04:53:16 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1b46:28af:1445:b4e2:b8bf:2d47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6df3aedsm2500588b3a.18.2026.03.11.04.53.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Mar 2026 04:53:16 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun@kernel.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	david.laight.linux@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 2/3] locking/rtmutex: Add slow path variants for lock/unlock
Date: Wed, 11 Mar 2026 19:52:49 +0800
Message-ID: <20260311115250.78488-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260311115250.78488-1-laoar.shao@gmail.com>
References: <20260311115250.78488-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add slow mutex APIs for rtmutex:

 slow_rt_mutex_lock: lock a rtmutex without optimistic spinning
 slow_rt_mutex_unlock: unlock the slow rtmutex

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/rtmutex.h      |  3 +++
 kernel/locking/rtmutex.c     | 37 +++++++++++++++++-----------
 kernel/locking/rtmutex_api.c | 47 ++++++++++++++++++++++++++++++------
 3 files changed, 66 insertions(+), 21 deletions(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index ede4c6bf6f22..22294a916ddc 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -109,6 +109,7 @@ extern void __rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 extern void rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass);
+extern void slow_rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass);
 extern void _rt_mutex_lock_nest_lock(struct rt_mutex *lock, struct lockdep_map *nest_lock);
 #define rt_mutex_lock(lock) rt_mutex_lock_nested(lock, 0)
 #define rt_mutex_lock_nest_lock(lock, nest_lock)			\
@@ -116,9 +117,11 @@ extern void _rt_mutex_lock_nest_lock(struct rt_mutex *lock, struct lockdep_map *
 		typecheck(struct lockdep_map *, &(nest_lock)->dep_map);	\
 		_rt_mutex_lock_nest_lock(lock, &(nest_lock)->dep_map);	\
 	} while (0)
+#define slow_rt_mutex_lock(lock) slow_rt_mutex_lock_nested(lock, 0)
 
 #else
 extern void rt_mutex_lock(struct rt_mutex *lock);
+extern void slow_rt_mutex_lock(struct rt_mutex *lock);
 #define rt_mutex_lock_nested(lock, subclass) rt_mutex_lock(lock)
 #define rt_mutex_lock_nest_lock(lock, nest_lock) rt_mutex_lock(lock)
 #endif
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index c80902eacd79..663ff96cb1be 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1480,10 +1480,13 @@ static __always_inline void __rt_mutex_unlock(struct rt_mutex_base *lock)
 #ifdef CONFIG_SMP
 static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
 				  struct rt_mutex_waiter *waiter,
-				  struct task_struct *owner)
+				  struct task_struct *owner,
+				  const bool slow)
 {
 	bool res = true;
 
+	if (slow)
+		return false;
 	rcu_read_lock();
 	for (;;) {
 		/* If owner changed, trylock again. */
@@ -1517,7 +1520,8 @@ static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
 #else
 static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
 				  struct rt_mutex_waiter *waiter,
-				  struct task_struct *owner)
+				  struct task_struct *owner,
+				  const bool slow)
 {
 	return false;
 }
@@ -1606,7 +1610,8 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 					   unsigned int state,
 					   struct hrtimer_sleeper *timeout,
 					   struct rt_mutex_waiter *waiter,
-					   struct wake_q_head *wake_q)
+					   struct wake_q_head *wake_q,
+					   const bool slow)
 	__releases(&lock->wait_lock) __acquires(&lock->wait_lock)
 {
 	struct rt_mutex *rtm = container_of(lock, struct rt_mutex, rtmutex);
@@ -1642,7 +1647,7 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 			owner = NULL;
 		raw_spin_unlock_irq_wake(&lock->wait_lock, wake_q);
 
-		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner)) {
+		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner, slow)) {
 			lockevent_inc(rtmutex_slow_sleep);
 			rt_mutex_schedule();
 		}
@@ -1693,7 +1698,8 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 				       unsigned int state,
 				       enum rtmutex_chainwalk chwalk,
 				       struct rt_mutex_waiter *waiter,
-				       struct wake_q_head *wake_q)
+				       struct wake_q_head *wake_q,
+				       const bool slow)
 {
 	struct rt_mutex *rtm = container_of(lock, struct rt_mutex, rtmutex);
 	struct ww_mutex *ww = ww_container_of(rtm);
@@ -1718,7 +1724,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 
 	ret = task_blocks_on_rt_mutex(lock, waiter, current, ww_ctx, chwalk, wake_q);
 	if (likely(!ret))
-		ret = rt_mutex_slowlock_block(lock, ww_ctx, state, NULL, waiter, wake_q);
+		ret = rt_mutex_slowlock_block(lock, ww_ctx, state, NULL, waiter, wake_q, slow);
 
 	if (likely(!ret)) {
 		/* acquired the lock */
@@ -1749,7 +1755,8 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 static inline int __rt_mutex_slowlock_locked(struct rt_mutex_base *lock,
 					     struct ww_acquire_ctx *ww_ctx,
 					     unsigned int state,
-					     struct wake_q_head *wake_q)
+					     struct wake_q_head *wake_q,
+					     const bool slow)
 {
 	struct rt_mutex_waiter waiter;
 	int ret;
@@ -1758,7 +1765,7 @@ static inline int __rt_mutex_slowlock_locked(struct rt_mutex_base *lock,
 	waiter.ww_ctx = ww_ctx;
 
 	ret = __rt_mutex_slowlock(lock, ww_ctx, state, RT_MUTEX_MIN_CHAINWALK,
-				  &waiter, wake_q);
+				  &waiter, wake_q, slow);
 
 	debug_rt_mutex_free_waiter(&waiter);
 	lockevent_cond_inc(rtmutex_slow_wake, !wake_q_empty(wake_q));
@@ -1773,7 +1780,8 @@ static inline int __rt_mutex_slowlock_locked(struct rt_mutex_base *lock,
  */
 static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
 				     struct ww_acquire_ctx *ww_ctx,
-				     unsigned int state)
+				     unsigned int state,
+				     const bool slow)
 {
 	DEFINE_WAKE_Q(wake_q);
 	unsigned long flags;
@@ -1797,7 +1805,7 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
 	 * irqsave/restore variants.
 	 */
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
-	ret = __rt_mutex_slowlock_locked(lock, ww_ctx, state, &wake_q);
+	ret = __rt_mutex_slowlock_locked(lock, ww_ctx, state, &wake_q, slow);
 	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 	rt_mutex_post_schedule();
 
@@ -1805,14 +1813,14 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
 }
 
 static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
-					   unsigned int state)
+					   unsigned int state, const bool slow)
 {
 	lockdep_assert(!current->pi_blocked_on);
 
 	if (likely(rt_mutex_try_acquire(lock)))
 		return 0;
 
-	return rt_mutex_slowlock(lock, NULL, state);
+	return rt_mutex_slowlock(lock, NULL, state, slow);
 }
 #endif /* RT_MUTEX_BUILD_MUTEX */
 
@@ -1827,7 +1835,8 @@ static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
  * @wake_q:	The wake_q to wake tasks after we release the wait_lock
  */
 static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock,
-					   struct wake_q_head *wake_q)
+					   struct wake_q_head *wake_q,
+					   const bool slow)
 	__releases(&lock->wait_lock) __acquires(&lock->wait_lock)
 {
 	struct rt_mutex_waiter waiter;
@@ -1863,7 +1872,7 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock,
 			owner = NULL;
 		raw_spin_unlock_irq_wake(&lock->wait_lock, wake_q);
 
-		if (!owner || !rtmutex_spin_on_owner(lock, &waiter, owner)) {
+		if (!owner || !rtmutex_spin_on_owner(lock, &waiter, owner, slow)) {
 			lockevent_inc(rtlock_slow_sleep);
 			schedule_rtlock();
 		}
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 59dbd29cb219..b196cdd35ff1 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -37,21 +37,29 @@ subsys_initcall(init_rtmutex_sysctl);
  * The atomic acquire/release ops are compiled away, when either the
  * architecture does not support cmpxchg or when debugging is enabled.
  */
-static __always_inline int __rt_mutex_lock_common(struct rt_mutex *lock,
+static __always_inline int ___rt_mutex_lock_common(struct rt_mutex *lock,
 						  unsigned int state,
 						  struct lockdep_map *nest_lock,
-						  unsigned int subclass)
+						  unsigned int subclass,
+						  const bool slow)
 {
 	int ret;
 
 	might_sleep();
 	mutex_acquire_nest(&lock->dep_map, subclass, 0, nest_lock, _RET_IP_);
-	ret = __rt_mutex_lock(&lock->rtmutex, state);
+	ret = __rt_mutex_lock(&lock->rtmutex, state, slow);
 	if (ret)
 		mutex_release(&lock->dep_map, _RET_IP_);
 	return ret;
 }
 
+static __always_inline int __rt_mutex_lock_common(struct rt_mutex *lock,
+						  unsigned int state,
+						  struct lockdep_map *nest_lock,
+						  unsigned int subclass)
+{
+	return ___rt_mutex_lock_common(lock, state, nest_lock, subclass, false);
+}
 void rt_mutex_base_init(struct rt_mutex_base *rtb)
 {
 	__rt_mutex_base_init(rtb);
@@ -77,6 +85,11 @@ void __sched _rt_mutex_lock_nest_lock(struct rt_mutex *lock, struct lockdep_map
 }
 EXPORT_SYMBOL_GPL(_rt_mutex_lock_nest_lock);
 
+void __sched slow_rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass)
+{
+	___rt_mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, NULL, subclass, true);
+}
+
 #else /* !CONFIG_DEBUG_LOCK_ALLOC */
 
 /**
@@ -89,6 +102,11 @@ void __sched rt_mutex_lock(struct rt_mutex *lock)
 	__rt_mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, NULL, 0);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock);
+
+void __sched slow_rt_mutex_lock(struct rt_mutex *lock)
+{
+	___rt_mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, NULL, 0, true);
+}
 #endif
 
 /**
@@ -401,7 +419,7 @@ int __sched rt_mutex_wait_proxy_lock(struct rt_mutex_base *lock,
 	raw_spin_lock_irq(&lock->wait_lock);
 	/* sleep on the mutex */
 	set_current_state(TASK_INTERRUPTIBLE);
-	ret = rt_mutex_slowlock_block(lock, NULL, TASK_INTERRUPTIBLE, to, waiter, NULL);
+	ret = rt_mutex_slowlock_block(lock, NULL, TASK_INTERRUPTIBLE, to, waiter, NULL, false);
 	/*
 	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
 	 * have to fix that up.
@@ -521,17 +539,18 @@ static void __mutex_rt_init_generic(struct mutex *mutex)
 	debug_check_no_locks_freed((void *)mutex, sizeof(*mutex));
 }
 
-static __always_inline int __mutex_lock_common(struct mutex *lock,
+static __always_inline int ___mutex_lock_common(struct mutex *lock,
 					       unsigned int state,
 					       unsigned int subclass,
 					       struct lockdep_map *nest_lock,
-					       unsigned long ip)
+					       unsigned long ip,
+					       const bool slow)
 {
 	int ret;
 
 	might_sleep();
 	mutex_acquire_nest(&lock->dep_map, subclass, 0, nest_lock, ip);
-	ret = __rt_mutex_lock(&lock->rtmutex, state);
+	ret = __rt_mutex_lock(&lock->rtmutex, state, slow);
 	if (ret)
 		mutex_release(&lock->dep_map, ip);
 	else
@@ -539,6 +558,15 @@ static __always_inline int __mutex_lock_common(struct mutex *lock,
 	return ret;
 }
 
+static __always_inline int __mutex_lock_common(struct mutex *lock,
+					       unsigned int state,
+					       unsigned int subclass,
+					       struct lockdep_map *nest_lock,
+					       unsigned long ip)
+{
+	___mutex_lock_common(lock, state, subclass, nest_lock, ip, false);
+}
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 void mutex_rt_init_lockdep(struct mutex *mutex, const char *name, struct lock_class_key *key)
 {
@@ -644,6 +672,11 @@ int __sched mutex_trylock(struct mutex *lock)
 	return __rt_mutex_trylock(&lock->rtmutex);
 }
 EXPORT_SYMBOL(mutex_trylock);
+
+void __sched slow_mutex_lock(struct mutex *lock)
+{
+	___mutex_lock_common(lock, state, subclass, nest_lock, ip, true);
+}
 #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
 
 void __sched mutex_unlock(struct mutex *lock)
-- 
2.47.3

