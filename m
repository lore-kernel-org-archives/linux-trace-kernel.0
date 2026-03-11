Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050903D9035
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773229994; cv=none; b=gjev2z4VCk6ko9f7UgvS+j1i4sjZTZiRYONqU8TNJ5ztD3BbMU/jN2XXQG7Htdn3W2XUbDAjVRmZipNUxzwhju9+JbFWKm3FsFZ0WDRGNQb1svjWnaGCmgbQ24egNobsCBH9de2IwX/Icb6KDF5MMdEB3shxIviYiJVbjQ2gyQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773229994; c=relaxed/simple;
	bh=z68fgqc2iOMqfVA3tcxpjxIvdUnGOzEv71RskaThPjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njj8UqUcYMFA/avQod1mUY6OFBveMOVtr7ju/UesBGFq9MovczJE1U+iIcnquo1uhhtwed3dpyDVmUEsGR0saUNzV3OTBq4X6x24DZ7hygovmQu9RotvabjbcgCzIFoyCfO35V1DDwssG5wx5pQVBgFard+yrX+TM2U79HDi0+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+Mg7yZj; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+Mg7yZj"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-829b2018c94so2787024b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 04:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773229992; x=1773834792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbAh84gjMQujNaKw3Rut1VBI8uWVKCNQdZxq2kKwp6Y=;
        b=a+Mg7yZjPaMPDdxMssgTZTNPO/Iy5+wLiY1KF6us9O/cDBKGlXUr2iTa0wIUfP3siX
         3cmjZsDglvDeHtuPculW3jO6vazoQlEjvlWp0RBO+2IIaBjKmvv7M3Ss8kcMgYdYrueX
         jW4LHOzGGQZCMjQ70V7cm8bd4puUMbgS7wl5+hknlsvqJ/P60+08+hV86vikgpIdcxYP
         dc9rBLrIw4XazLb8Lyzgi6ZhyneGkoNktLWVXFkXaB2QhBM5bg4Xtewk5p4OhY/B8ucR
         LQ/RGsrh3D3qVYax1pifb7p4wBFSKHM/3WUL0TN00Kkx1SHJ9u+5BNbytFEDtUsad/hr
         /S/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773229992; x=1773834792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BbAh84gjMQujNaKw3Rut1VBI8uWVKCNQdZxq2kKwp6Y=;
        b=oCH1zdbc/h6gdq+3TJfvZMj5O5aOy4CqUO4ugOMl7CXmkyLflPG4Y+O+wIDd7HLTvu
         y+uQ62YtAoEXeXosFQm/NGxt4NJY+I+vFz1VVSslHGfsE/q0z56x7cZdN6OF0r8ZFjyB
         H0LvFfidTsbFEcmPaSL9qe73+SXa+BaZVTPxzXi+RfEb1k4lrBO4lW3QmUYAuKnyJ6qx
         Zr88DwWlt87DfJ6F/0qI8AVCPihsZsSN8Hh8U4sc0Ps6d5Q/24rqNPaDMkY6JEah0Sh6
         b6Oex4o+ATvXHQHeJRQV6x2w9DFyHbQYB+pv6i4FcVH+s3eHwu9/+tkyB25cdgcNAtHf
         W+uA==
X-Forwarded-Encrypted: i=1; AJvYcCXkJJ7/ARuZbFfXbdwFqmB50x3DfGfEkSa7NT/UIXW3VXIU2Occ1JOCWJRcbDf+/EikjsucTsIyRZ0FzxFtoRdqDJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNLa4iA5JPHNASjjshum4nB8RSjqqsJm/UG4GSlNmJHRlTQNOO
	GyzfW6UcmF5ZXhPKwyEnkqK1BMDcChZ8WOEzo285kKAPATiuEbKSq0M+
X-Gm-Gg: ATEYQzz1ncJFmAUSzmolmVtEwD13J6j19AtpwDqF2zha4J9atsWRk690Jp4xUd2IRY0
	qn89cK3iTwaCjjOAP24b75Dn8Mcs6GfXOTMs8syfuxzshj551997cemJJ/VdycB6Fw7GqFzimV2
	yeM/AOhi1FUIB1V0pNU16IQryMCD/9/80+raSPnzfAQg76aJcy76axxtHbSn8D127jGPgWEWL3N
	3p1Ol+ZDRryGDIuouLZMmvgxvIeKa1CfVW4w2gUVSYedRPGVFNBGiwxW67Gt0eqSkoOC5Ri6qdD
	1HUM4Bib8XGUd8lPX/g6E9+rDg4qKbjyULNld7QWxA/YXNxAZJreLDJEATm7mL9MxFiUK/DdOJS
	lLS7qsbrRAlEyzxmqQptAJycK9UMdy4l/rkNVU1VZk+tmaPDVRO+HteVRNJECHUHi80bWuWtmG1
	vIaxyMbuvmOe79HBWzj0U5UhorADDtfQO0kyKeHdjoFVoF/x/D6/nd5hUTSLUOy/M=
X-Received: by 2002:a05:6a00:1c8f:b0:81f:5127:5d48 with SMTP id d2e1a72fcca58-829f7036d89mr2176235b3a.30.1773229992190;
        Wed, 11 Mar 2026 04:53:12 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1b46:28af:1445:b4e2:b8bf:2d47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6df3aedsm2500588b3a.18.2026.03.11.04.53.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Mar 2026 04:53:11 -0700 (PDT)
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
Subject: [RFC PATCH v2 1/3] locking/mutex: Add slow path variants for lock/unlock
Date: Wed, 11 Mar 2026 19:52:48 +0800
Message-ID: <20260311115250.78488-2-laoar.shao@gmail.com>
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

Background
==========

One of our latency-sensitive services reported random CPU pressure spikes.
After a thorough investigation, we finally identified the root cause of the
CPU pressure spikes. The key kernel stacks are as follows:

- Task A

2026-02-14-16:53:40.938243: [CPU198] 2156302(bpftrace) cgrp:4019437 pod:4019253

        find_kallsyms_symbol+142
        module_address_lookup+104
        kallsyms_lookup_buildid+203
        kallsyms_lookup+20
        print_rec+64
        t_show+67
        seq_read_iter+709
        seq_read+165
        vfs_read+165
        ksys_read+103
        __x64_sys_read+25
        do_syscall_64+56
        entry_SYSCALL_64_after_hwframe+100

This task (2156302, bpftrace) is reading the
/sys/kernel/tracing/available_filter_functions to check if a function
is traceable:

  https://github.com/bpftrace/bpftrace/blob/master/src/tracefs/tracefs.h#L21

Reading the available_filter_functions file is time-consuming, as it
contains tens of thousands of functions:

  $ cat /sys/kernel/tracing/available_filter_functions | wc -l
  59221

  $ time cat /sys/kernel/tracing/available_filter_functions > /dev/null
  real 0m0.458s user 0m0.001s sys 0m0.457s

Consequently, the ftrace_lock is held by this task for an extended period.

- Other Tasks

2026-02-14-16:53:41.437094: [CPU79] 2156308(bpftrace) cgrp:4019437 pod:4019253

        mutex_spin_on_owner+108
        __mutex_lock.constprop.0+1132
        __mutex_lock_slowpath+19
        mutex_lock+56
        t_start+51
        seq_read_iter+250
        seq_read+165
        vfs_read+165
        ksys_read+103
        __x64_sys_read+25
        do_syscall_64+56
        entry_SYSCALL_64_after_hwframe+100

Since ftrace_lock is held by Task-A and Task-A is actively running on a
CPU, all other tasks waiting for the same lock will spin on their
respective CPUs. This leads to increased CPU pressure.

Reproduction
============

This issue can be reproduced simply by running
`cat available_filter_functions`.

- Single process reading available_filter_functions:

  $ time cat /sys/kernel/tracing/available_filter_functions > /dev/null
  real 0m0.458s user 0m0.001s sys 0m0.457s

- Six processes reading available_filter_functions simultaneously:

  for i in `seq 0 5`; do
      time cat /sys/kernel/tracing/available_filter_functions > /dev/null &
  done

  The results are as follows:

  real 0m2.666s user 0m0.001s sys 0m2.557s
  real 0m2.718s user 0m0.000s sys 0m2.655s
  real 0m2.718s user 0m0.001s sys 0m2.600s
  real 0m2.733s user 0m0.001s sys 0m2.554s
  real 0m2.735s user 0m0.000s sys 0m2.573s
  real 0m2.738s user 0m0.000s sys 0m2.664s

  As more processes are added, the system time increases correspondingly.

Solution
========

One approach is to optimize the reading of available_filter_functions to
make it as fast as possible. However, the risk lies in the contention
caused by optimistic spin locking.

Therefore, we need to consider an alternative solution that avoids
optimistic spinning for heavy mutexes that may be held for long durations.
Note that we do not want to disable CONFIG_MUTEX_SPIN_ON_OWNER entirely, as
that could lead to unexpected performance regressions.

In this patch, two new APIs are introduced to allow heavy locks to
selectively disable optimistic spinning.

  slow_mutex_lock() - lock a mutex without optimistic spinning
  slow_mutex_unlock() - unlock the slow mutex

- The result of this optimization

After applying this slow mutex to ftrace_lock and concurrently running six
processes, the results are as follows:

  real 0m2.691s user 0m0.001s sys 0m0.458s
  real 0m2.785s user 0m0.001s sys 0m0.467s
  real 0m2.787s user 0m0.000s sys 0m0.469s
  real 0m2.787s user 0m0.000s sys 0m0.466s
  real 0m2.788s user 0m0.001s sys 0m0.468s
  real 0m2.789s user 0m0.000s sys 0m0.471s

The system time remains similar to that of running a single process.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/mutex.h  |  4 ++++
 kernel/locking/mutex.c | 41 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index ecaa0440f6ec..eed0e87c084c 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -189,11 +189,13 @@ extern int __must_check mutex_lock_interruptible_nested(struct mutex *lock,
 extern int __must_check _mutex_lock_killable(struct mutex *lock,
 		unsigned int subclass, struct lockdep_map *nest_lock) __cond_acquires(0, lock);
 extern void mutex_lock_io_nested(struct mutex *lock, unsigned int subclass) __acquires(lock);
+extern void slow_mutex_lock_nested(struct mutex *lock, unsigned int subclass);
 
 #define mutex_lock(lock) mutex_lock_nested(lock, 0)
 #define mutex_lock_interruptible(lock) mutex_lock_interruptible_nested(lock, 0)
 #define mutex_lock_killable(lock) _mutex_lock_killable(lock, 0, NULL)
 #define mutex_lock_io(lock) mutex_lock_io_nested(lock, 0)
+#define slow_mutex_lock(lock) slow_mutex_lock_nested(lock, 0)
 
 #define mutex_lock_nest_lock(lock, nest_lock)				\
 do {									\
@@ -215,6 +217,7 @@ extern void mutex_lock(struct mutex *lock) __acquires(lock);
 extern int __must_check mutex_lock_interruptible(struct mutex *lock) __cond_acquires(0, lock);
 extern int __must_check mutex_lock_killable(struct mutex *lock) __cond_acquires(0, lock);
 extern void mutex_lock_io(struct mutex *lock) __acquires(lock);
+extern void slow_mutex_lock(struct mutex *lock) __acquires(lock);
 
 # define mutex_lock_nested(lock, subclass) mutex_lock(lock)
 # define mutex_lock_interruptible_nested(lock, subclass) mutex_lock_interruptible(lock)
@@ -247,6 +250,7 @@ extern int mutex_trylock(struct mutex *lock) __cond_acquires(true, lock);
 #endif
 
 extern void mutex_unlock(struct mutex *lock) __releases(lock);
+#define slow_mutex_unlock(lock) mutex_unlock(lock)
 
 extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock) __cond_acquires(true, lock);
 
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 2a1d165b3167..5766d824b3fe 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -443,8 +443,11 @@ static inline int mutex_can_spin_on_owner(struct mutex *lock)
  */
 static __always_inline bool
 mutex_optimistic_spin(struct mutex *lock, struct ww_acquire_ctx *ww_ctx,
-		      struct mutex_waiter *waiter)
+		      struct mutex_waiter *waiter, const bool slow)
 {
+	if (slow)
+		return false;
+
 	if (!waiter) {
 		/*
 		 * The purpose of the mutex_can_spin_on_owner() function is
@@ -577,7 +580,8 @@ EXPORT_SYMBOL(ww_mutex_unlock);
 static __always_inline int __sched
 __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclass,
 		    struct lockdep_map *nest_lock, unsigned long ip,
-		    struct ww_acquire_ctx *ww_ctx, const bool use_ww_ctx)
+		    struct ww_acquire_ctx *ww_ctx, const bool use_ww_ctx,
+		    const bool slow)
 {
 	DEFINE_WAKE_Q(wake_q);
 	struct mutex_waiter waiter;
@@ -615,7 +619,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 	trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
 	if (__mutex_trylock(lock) ||
-	    mutex_optimistic_spin(lock, ww_ctx, NULL)) {
+	    mutex_optimistic_spin(lock, ww_ctx, NULL, slow)) {
 		/* got the lock, yay! */
 		lock_acquired(&lock->dep_map, ip);
 		if (ww_ctx)
@@ -716,7 +720,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			 * to run.
 			 */
 			clear_task_blocked_on(current, lock);
-			if (mutex_optimistic_spin(lock, ww_ctx, &waiter))
+			if (mutex_optimistic_spin(lock, ww_ctx, &waiter, slow))
 				break;
 			set_task_blocked_on(current, lock);
 			trace_contention_begin(lock, LCB_F_MUTEX);
@@ -773,14 +777,21 @@ static int __sched
 __mutex_lock(struct mutex *lock, unsigned int state, unsigned int subclass,
 	     struct lockdep_map *nest_lock, unsigned long ip)
 {
-	return __mutex_lock_common(lock, state, subclass, nest_lock, ip, NULL, false);
+	return __mutex_lock_common(lock, state, subclass, nest_lock, ip, NULL, false, false);
+}
+
+static int __sched
+__slow_mutex_lock(struct mutex *lock, unsigned int state, unsigned int subclass,
+		    struct lockdep_map *nest_lock, unsigned long ip)
+{
+	return __mutex_lock_common(lock, state, subclass, nest_lock, ip, NULL, false, true);
 }
 
 static int __sched
 __ww_mutex_lock(struct mutex *lock, unsigned int state, unsigned int subclass,
 		unsigned long ip, struct ww_acquire_ctx *ww_ctx)
 {
-	return __mutex_lock_common(lock, state, subclass, NULL, ip, ww_ctx, true);
+	return __mutex_lock_common(lock, state, subclass, NULL, ip, ww_ctx, true, false);
 }
 
 /**
@@ -861,11 +872,17 @@ mutex_lock_io_nested(struct mutex *lock, unsigned int subclass)
 
 	token = io_schedule_prepare();
 	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE,
-			    subclass, NULL, _RET_IP_, NULL, 0);
+			    subclass, NULL, _RET_IP_, NULL, 0, false);
 	io_schedule_finish(token);
 }
 EXPORT_SYMBOL_GPL(mutex_lock_io_nested);
 
+void __sched
+slow_mutex_lock_nested(struct mutex *lock, unsigned int subclass)
+{
+	__slow_mutex_lock(lock, TASK_UNINTERRUPTIBLE, subclass, NULL, _RET_IP_);
+}
+
 static inline int
 ww_mutex_deadlock_injection(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
@@ -923,6 +940,16 @@ ww_mutex_lock_interruptible(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 }
 EXPORT_SYMBOL_GPL(ww_mutex_lock_interruptible);
 
+#else
+
+void __sched slow_mutex_lock(struct mutex *lock)
+{
+	might_sleep();
+
+	if (!__mutex_trylock_fast(lock))
+		__slow_mutex_lock(lock, TASK_UNINTERRUPTIBLE, 0, NULL, _RET_IP_);
+}
+
 #endif
 
 /*
-- 
2.47.3

