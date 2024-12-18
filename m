Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FA916CD1D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Dec 2024 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734557689; cv=none; b=kQu/iqZ4GHdqDsTdErhBTAKFgvBqrYvq/APOwWeYvgGtj3nAfWsVYunLo9IddyV+klwVSUAAyrkm9XyJdpcWfzV60EzEgJMK+11/LrndTT4mywyrPTen4pyxs2GaWqBNtvvi6yTehxhhkeNYlyd1CckrjwGpUf8KgIZ64mcGr3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734557689; c=relaxed/simple;
	bh=92kdn9FW2RL8vQcug2RW23wrELDQ6M2BpPMld9dYtCs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGj5vvJTtqwkwYAee8Yj2IaSP0ILgA8c0t98FU6XNfyIbaX3JQmA/hc+iAqTWb6fsZuLbbf3VStGcwvJYGwsJa5XQKFTfWrk6Bbk3ETM1fHzH1EPONnHdemPKa7ikqiz8qyv5K+MULHQ76lmxMD7/KIFpXwgs6BWxLvGpucCnJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58D8C4CECD;
	Wed, 18 Dec 2024 21:34:47 +0000 (UTC)
Date: Wed, 18 Dec 2024 16:35:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Cc: linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, Andreas Larsson <andreas@gaisler.com>
Subject: Re: [BUG] spinlock recursion when enabling function tracer on
 32-bit
Message-ID: <20241218163526.2569917f@gandalf.local.home>
In-Reply-To: <bb8485bf-d720-4803-aa3c-037ea1169f8a@gaisler.com>
References: <86fb4f86-a0e4-45a2-a2df-3154acc4f086@gaisler.com>
	<20241218110115.29d4cc77@gandalf.local.home>
	<bb8485bf-d720-4803-aa3c-037ea1169f8a@gaisler.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 22:05:20 +0100
Ludwig Rydberg <ludwig.rydberg@gaisler.com> wrote:

> I applied the patch and did some testing and the initial issue I reported
> seems to have been fixed but unfortunately I'm still able to trigger
> a spinlock recursion.
> 
> The following sequence works fine with the patch applied:
> # echo function > current_tracer
> # echo 1 > tracing_on
> # usleep 1
> # echo 0 > tracing_on
> # cat trace
> # ...
> 
> But this triggers a spinlock recursion:
> # echo 1 > tracing_on
> # find /
> 
> [   61.276675] BUG: spinlock recursion on CPU#0, find/119
> [   61.277571]  lock: 0xc1c076c0, .magic: dead4ead, .owner: find/119, .owner_cpu: 0
> [   61.278365] CPU: 0 UID: 0 PID: 119 Comm: find Not tainted 6.13.0-rc3 #5
> [   61.278724] Hardware name: riscv-virtio,qemu (DT)
> [   61.278994] Call Trace:

OK, let's forget that then. Since these locks are really architecture
specific just to implement 64bit atomics on 32bit systems, they really
should be arch_spin_lock() and not raw_spin_lock(). raw_spin_lock() gets
traced (and there's a lot of debugging that can happen when they are
traced).

But arch_spin_lock() does not get traced, and is used in the tracing
and lockdep infrastructure. As these locks are never generic (archs that
have 64 bit atomics don't need them), lets switch them over to
arch_spin_lock().

Can you test this patch?

-- Steve

diff --git a/lib/atomic64.c b/lib/atomic64.c
index caf895789a1e..1a72bba36d24 100644
--- a/lib/atomic64.c
+++ b/lib/atomic64.c
@@ -25,15 +25,15 @@
  * Ensure each lock is in a separate cacheline.
  */
 static union {
-	raw_spinlock_t lock;
+	arch_spinlock_t lock;
 	char pad[L1_CACHE_BYTES];
 } atomic64_lock[NR_LOCKS] __cacheline_aligned_in_smp = {
 	[0 ... (NR_LOCKS - 1)] = {
-		.lock =  __RAW_SPIN_LOCK_UNLOCKED(atomic64_lock.lock),
+		.lock =  __ARCH_SPIN_LOCK_UNLOCKED,
 	},
 };
 
-static inline raw_spinlock_t *lock_addr(const atomic64_t *v)
+static inline arch_spinlock_t *lock_addr(const atomic64_t *v)
 {
 	unsigned long addr = (unsigned long) v;
 
@@ -45,12 +45,14 @@ static inline raw_spinlock_t *lock_addr(const atomic64_t *v)
 s64 generic_atomic64_read(const atomic64_t *v)
 {
 	unsigned long flags;
-	raw_spinlock_t *lock = lock_addr(v);
+	arch_spinlock_t *lock = lock_addr(v);
 	s64 val;
 
-	raw_spin_lock_irqsave(lock, flags);
+	local_irq_save(flags);
+	arch_spin_lock(lock);
 	val = v->counter;
-	raw_spin_unlock_irqrestore(lock, flags);
+	arch_spin_unlock(lock);
+	local_irq_restore(flags);
 	return val;
 }
 EXPORT_SYMBOL(generic_atomic64_read);
@@ -58,11 +60,13 @@ EXPORT_SYMBOL(generic_atomic64_read);
 void generic_atomic64_set(atomic64_t *v, s64 i)
 {
 	unsigned long flags;
-	raw_spinlock_t *lock = lock_addr(v);
+	arch_spinlock_t *lock = lock_addr(v);
 
-	raw_spin_lock_irqsave(lock, flags);
+	local_irq_save(flags);
+	arch_spin_lock(lock);
 	v->counter = i;
-	raw_spin_unlock_irqrestore(lock, flags);
+	arch_spin_unlock(lock);
+	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(generic_atomic64_set);
 
@@ -70,11 +74,13 @@ EXPORT_SYMBOL(generic_atomic64_set);
 void generic_atomic64_##op(s64 a, atomic64_t *v)			\
 {									\
 	unsigned long flags;						\
-	raw_spinlock_t *lock = lock_addr(v);				\
+	arch_spinlock_t *lock = lock_addr(v);				\
 									\
-	raw_spin_lock_irqsave(lock, flags);				\
+	local_irq_save(flags);						\
+	arch_spin_lock(lock);						\
 	v->counter c_op a;						\
-	raw_spin_unlock_irqrestore(lock, flags);			\
+	arch_spin_unlock(lock);						\
+	local_irq_restore(flags);					\
 }									\
 EXPORT_SYMBOL(generic_atomic64_##op);
 
@@ -82,12 +88,14 @@ EXPORT_SYMBOL(generic_atomic64_##op);
 s64 generic_atomic64_##op##_return(s64 a, atomic64_t *v)		\
 {									\
 	unsigned long flags;						\
-	raw_spinlock_t *lock = lock_addr(v);				\
+	arch_spinlock_t *lock = lock_addr(v);				\
 	s64 val;							\
 									\
-	raw_spin_lock_irqsave(lock, flags);				\
+	local_irq_save(flags);						\
+	arch_spin_lock(lock);						\
 	val = (v->counter c_op a);					\
-	raw_spin_unlock_irqrestore(lock, flags);			\
+	arch_spin_unlock(lock);						\
+	local_irq_restore(flags);					\
 	return val;							\
 }									\
 EXPORT_SYMBOL(generic_atomic64_##op##_return);
@@ -96,13 +104,15 @@ EXPORT_SYMBOL(generic_atomic64_##op##_return);
 s64 generic_atomic64_fetch_##op(s64 a, atomic64_t *v)			\
 {									\
 	unsigned long flags;						\
-	raw_spinlock_t *lock = lock_addr(v);				\
+	arch_spinlock_t *lock = lock_addr(v);				\
 	s64 val;							\
 									\
-	raw_spin_lock_irqsave(lock, flags);				\
+	local_irq_save(flags);						\
+	arch_spin_lock(lock);						\
 	val = v->counter;						\
 	v->counter c_op a;						\
-	raw_spin_unlock_irqrestore(lock, flags);			\
+	arch_spin_unlock(lock);						\
+	local_irq_restore(flags);					\
 	return val;							\
 }									\
 EXPORT_SYMBOL(generic_atomic64_fetch_##op);
@@ -131,14 +141,16 @@ ATOMIC64_OPS(xor, ^=)
 s64 generic_atomic64_dec_if_positive(atomic64_t *v)
 {
 	unsigned long flags;
-	raw_spinlock_t *lock = lock_addr(v);
+	arch_spinlock_t *lock = lock_addr(v);
 	s64 val;
 
-	raw_spin_lock_irqsave(lock, flags);
+	local_irq_save(flags);
+	arch_spin_lock(lock);
 	val = v->counter - 1;
 	if (val >= 0)
 		v->counter = val;
-	raw_spin_unlock_irqrestore(lock, flags);
+	arch_spin_unlock(lock);
+	local_irq_restore(flags);
 	return val;
 }
 EXPORT_SYMBOL(generic_atomic64_dec_if_positive);
@@ -146,14 +158,16 @@ EXPORT_SYMBOL(generic_atomic64_dec_if_positive);
 s64 generic_atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
 {
 	unsigned long flags;
-	raw_spinlock_t *lock = lock_addr(v);
+	arch_spinlock_t *lock = lock_addr(v);
 	s64 val;
 
-	raw_spin_lock_irqsave(lock, flags);
+	local_irq_save(flags);
+	arch_spin_lock(lock);
 	val = v->counter;
 	if (val == o)
 		v->counter = n;
-	raw_spin_unlock_irqrestore(lock, flags);
+	arch_spin_unlock(lock);
+	local_irq_restore(flags);
 	return val;
 }
 EXPORT_SYMBOL(generic_atomic64_cmpxchg);
@@ -161,13 +175,15 @@ EXPORT_SYMBOL(generic_atomic64_cmpxchg);
 s64 generic_atomic64_xchg(atomic64_t *v, s64 new)
 {
 	unsigned long flags;
-	raw_spinlock_t *lock = lock_addr(v);
+	arch_spinlock_t *lock = lock_addr(v);
 	s64 val;
 
-	raw_spin_lock_irqsave(lock, flags);
+	local_irq_save(flags);
+	arch_spin_lock(lock);
 	val = v->counter;
 	v->counter = new;
-	raw_spin_unlock_irqrestore(lock, flags);
+	arch_spin_unlock(lock);
+	local_irq_restore(flags);
 	return val;
 }
 EXPORT_SYMBOL(generic_atomic64_xchg);
@@ -175,14 +191,16 @@ EXPORT_SYMBOL(generic_atomic64_xchg);
 s64 generic_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	unsigned long flags;
-	raw_spinlock_t *lock = lock_addr(v);
+	arch_spinlock_t *lock = lock_addr(v);
 	s64 val;
 
-	raw_spin_lock_irqsave(lock, flags);
+	local_irq_save(flags);
+	arch_spin_lock(lock);
 	val = v->counter;
 	if (val != u)
 		v->counter += a;
-	raw_spin_unlock_irqrestore(lock, flags);
+	arch_spin_unlock(lock);
+	local_irq_restore(flags);
 
 	return val;
 }
