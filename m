Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0EA48422B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584900; cv=none; b=Xy8pDxc8YhKOjTTgdu4ugAeK89pdWSZ7JazwUTFm4Brc/2sMxZzewWJWLEf6v+LvS7WsIvqdtlNrR2dGKDO92MkE6s/VQkdeSTetC+Qy4J0xCxAUTRBwA6vgQ2yL6YiqEx7BhTHxKfOqLOYUYOnPCU0oc/cfV9rTPdJSiGHAlv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584900; c=relaxed/simple;
	bh=rDfLpvdhxoJ+dNOzSYz2bV9Hzifox3KM4sMPSPu0uKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsLy/25l+EcnIKS4EKK+BejnwdHEueT9zQiclvP5FVEw9rCqlPWD3UymSwVV/Tx8potWIex4EAONSnE5rAq2yHFz+z4SQRoheu4NYQDRztcIONLP9+gnJfVIIsvA1g+LaX4kbXLFp3L63/6ZwKmTXZ63vYZxZ2oHPmiQg1UwzDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQdeIB83; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQdeIB83"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-143880e27dfso514239c88.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 01:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790584896; x=1791189696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K8dyxn3O/q5DKXGdGGLOHA5Xn2kA5StX8PgsF6Z4VAU=;
        b=UQdeIB83W7cpUHXg7Hfs71OoJaH9IHsLgYaIyuIvpwEMZiIA65U4ed03makfSm7I9d
         IQb2HVkdggurfm0FJPDVcoO0Gxb/r1686WktwD6cGoaK6CoLa3ET56Ol0q+E5S8SpOdu
         vQ/v/wGd+a57qs+PTnXRUHmCFm3F0CTGbWkHUS9t3MbbPpEcQURJmYORNM8T50W1hbIl
         KOvVAu9PZ+4+cmM4FMNUdSqpL0KmRZi1GMs4JWehRRbZdto1j5M3x11Ob1meL+BxRxU9
         oqwVkFchnXalQjmw1At2FaL7fRHFUhH3MPqC8yQ1Rojcp0l+jC+4pLWQWR+DWdy9bYl2
         gaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790584896; x=1791189696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K8dyxn3O/q5DKXGdGGLOHA5Xn2kA5StX8PgsF6Z4VAU=;
        b=e3LCF1aoZinBGmIqCVINksC1o3uas6DiYQmwiD7gUP9tBhK6fq+aKpAMc5ZUZ4wg7R
         SCI75PPVwXZIRcP5GnHac7U0ql+r5VO38j08hYQR0+xTGLRp6KJN5YCBQtFe0CCnAq04
         9INnUs7Vn+L+ktbxDq4GGQ7mPDoiE4/KSADhTHlepkANtUAyl3IwCTXZJE6V1euISBOd
         TS2g2zFpHhJCpYEr0DXYwaWCFTE0UDjgRqARj9ma4x6gROizO3L95DMvtq6mDcZ31yZs
         XWPRtTl4WMGBAT3YA3EiB2qPkcmlwI3W/hBXTEGD8KLrlzjutRLyiaacLHQl8wOM/yjW
         lhkQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4khzMMsXLZIhdZw8gqMIhJp+2EOdEoQuzPXbjT5if5iwd9Y3bd2UoZND3BAAuo25BrWUnqcigWznO9i7oC6sAmIc=@vger.kernel.org
X-Gm-Message-State: AFuF++kMG5I+gOdxRrTgSd6DvFKXZ5kA1Vbg8OizY6RerOeonrnYidQO
	NjoG89+eu8TicawvEdcgWc5ddnnuicXPbq9neu36AngmkIoec8uI/0dogVmo9g==
X-Gm-Gg: AYBFou3x5ihhKDbBDY+pM++aSsARuMB/sZPawbVIw/9oKcPmz4spAJCnTliSQpEi5ik
	77dtc2pkNKRl63fkECO+JiiYCsgl5NqPDfVJW7ivQIBLly+ET2/6KxoItAc9hf79apd/qB7H646
	dR+dNGGhoYL6TqHd1yw0T46Al1MBiWv/k7MKPn4IlXJZmXlamdSclVMxvrrIkQnBCjtQxTXgtn3
	SheEXBAr4db4ApE3rNFhvF9CB47X5tbuczYd0VvqOZjUIw1PAZWuXAheYwxXc7AeRTdOglaznAq
	jHlul37zlYRP4v9NEHBzNSfJR/CSnBRCb4IlDxmb6YzEmJjLxXryhGfE1wSb9kLK8N687vq9YLQ
	Z2ZBdiWmro8o+VVBSVjWQuEJ8zfC8i+uU+pJYKkizlUY0oVBpzG7ldqD6vJ723JWMXBpAcLE8rK
	nCMJA9/wN0L3ykLEEA2KWeAtAWEXvAMK6gEa3gA6PRlKbDUakSZWDRp/5030xnJtlIiHCw5qUI5
	waqHDvQFaOp4kX6bg7GjtqpXojTKOk3QfadqDE7g68SrH4p/ZhFBQBiEYSqLFKXe7xITa2J7We2
	DZP1edjIs9IO7GKIdmFG5NG8Oqg3CoyKAzjOrvIhQ9+SeY69yOIAnotduoRVNbpjaUrhqF1RqA=
	=
X-Received: by 2002:a05:701b:42c1:20b0:143:2982:1046 with SMTP id a92af1059eb24-146d039e8e0mr9312569c88.39.1790584896143;
        Mon, 28 Sep 2026 01:41:36 -0700 (PDT)
Received: from FT6N242TWK ([223.181.116.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ac67c505sm22947647c88.5.2026.09.28.01.41.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 01:41:35 -0700 (PDT)
From: Shashank Mohan Jain <jain.sm@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Wu <wuqiang.matt@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] lib/tests: add KUnit test for nested objpool pushes
Date: Mon, 28 Sep 2026 14:11:25 +0530
Message-ID: <20260928084125.67104-3-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928084125.67104-1-jain.sm@gmail.com>
References: <20260928084125.67104-1-jain.sm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

objpool_push() only pushes to the slot of the local CPU, but a push from
NMI context (a kretprobe'd function returning in NMI) can interrupt it
and push to the same slot.

UML has no NMIs. So the test pushes from task context with interrupts
enabled, through __objpool_try_add_slot(). A pinned hard hrtimer on the
same CPU pushes with objpool_push() every 10 us. That nests the same way
an NMI would. HRTIMER_MODE_REL_PINNED_HARD keeps the timer in hardirq
context on PREEMPT_RT as well.

- objpool_test_nested_push checks that no entry is left unpublished
  once the task push returns (slot->last == slot->tail).
- objpool_test_nested_push_remote_pop pops from another CPU with
  objpool_pop(). It checks that every popped object was in the pool,
  and that no object is lost from the pool. It is skipped when only one
  CPU is online.

Only a few timer pushes land inside a task push. The test counts those
and fails if there were none, as it would then have tested nothing.

Each case runs for 5 seconds.

Assisted-by: LLM
Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
---
Notes (not part of the changelog):

Tested (master 72d3fcf802c4, v7.3-rc5):
- UML x86_64 with ncpus=4, 3 runs without patch 1/2 (both cases fail)
  and 3 runs with it (both pass). Real nestings per case with patch 1/2:
  5013-5237 (local) and 32994-35223 (remote pop).
- UML with ncpus=1: the local case fails without patch 1/2 and passes
  with it; the remote-pop case is skipped. CONFIG_SMP=n: the local case
  passes with patch 1/2.
- W=1 build for x86_64 and i386, with OBJPOOL_KUNIT_TEST=m: no warnings.
- checkpatch.pl --strict: clean apart from the missing Signed-off-by.

Not tested:
- Architectures other than UML x86_64 (the test was only built for
  x86_64 and i386), and PREEMPT_RT.

It calls the internal __objpool_try_add_slot() with interrupts enabled
on purpose: that is what lets the hrtimer nest.

This patch was prepared with Claude Code (Anthropic), model Claude Opus
5.5 (claude-opus-5-5): the test and the changelog were written with the
assistant.

 MAINTAINERS               |   1 +
 lib/Kconfig.debug         |  13 ++
 lib/tests/Makefile        |   1 +
 lib/tests/objpool_kunit.c | 329 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 344 insertions(+)
 create mode 100644 lib/tests/objpool_kunit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 72294ddfa5b7..0d319f2c2948 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19872,6 +19872,7 @@ S:	Supported
 F:	include/linux/objpool.h
 F:	lib/objpool.c
 F:	lib/test_objpool.c
+F:	lib/tests/objpool_kunit.c
 
 OBJTOOL
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 134b15a44625..3d9c2783ac9b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3378,6 +3378,19 @@ config TEST_OBJPOOL
 
 	  If unsure, say N.
 
+config OBJPOOL_KUNIT_TEST
+	tristate "KUnit test for nested objpool pushes" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Stress test for an objpool push that is interrupted by another
+	  push to the same per-CPU slot, as happens when a kretprobe'd
+	  function returns in NMI context.  An hrtimer stands in for the
+	  NMI.  The test runs for about ten seconds.  The case that pops
+	  from another CPU is skipped when only one CPU is online.
+
+	  If unsure, say N.
+
 config TEST_KEXEC_HANDOVER
 	bool "Test for Kexec HandOver"
 	default n
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 3cac3b63a752..f0238587cc8a 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_IS_SIGNED_TYPE_KUNIT_TEST) += is_signed_type_kunit.o
 obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LIST_PRIVATE_KUNIT_TEST) += list-private-test.o
+obj-$(CONFIG_OBJPOOL_KUNIT_TEST) += objpool_kunit.o
 obj-$(CONFIG_KFIFO_KUNIT_TEST) += kfifo_kunit.o
 obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
diff --git a/lib/tests/objpool_kunit.c b/lib/tests/objpool_kunit.c
new file mode 100644
index 000000000000..d86ef00dd088
--- /dev/null
+++ b/lib/tests/objpool_kunit.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for objpool pushes that nest on the same per-CPU slot.
+ *
+ * objpool_push() only pushes to the slot of the local CPU and runs with
+ * interrupts disabled, but it can still be interrupted by an NMI that
+ * pushes to the same slot: kretprobes are allowed in NMI context, and a
+ * probed function that returns in NMI context recycles its instance with
+ * objpool_push().  UML has no NMIs, so these tests push from task context
+ * with interrupts enabled, and a pinned hrtimer pushes to the same slot
+ * from hardirq context in between.  Nesting is the same as with an NMI.
+ */
+
+#include <kunit/test.h>
+#include <linux/atomic.h>
+#include <linux/completion.h>
+#include <linux/cpumask.h>
+#include <linux/hrtimer.h>
+#include <linux/jiffies.h>
+#include <linux/kthread.h>
+#include <linux/objpool.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#define OP_NR_OBJS	64
+#define OP_RESERVE	4
+#define OP_TIMER_NS	(10 * NSEC_PER_USEC)
+#define OP_RUN_MS	5000
+
+enum { OP_TASK, OP_IRQ, OP_NR_STOCKS };
+
+struct op_obj {
+	atomic_t held;		/* 0 while the object is in the pool */
+	int owner;		/* stock the object goes back to */
+};
+
+struct op_ctx {
+	struct objpool_head pool;
+	struct op_obj *objs[OP_NR_OBJS];
+	struct op_obj *reserve[OP_RESERVE];
+	int nreserve;
+
+	raw_spinlock_t lock;	/* protects the stocks */
+	struct op_obj *stock[OP_NR_STOCKS][OP_NR_OBJS];
+	int nstock[OP_NR_STOCKS];
+
+	struct hrtimer timer;
+	int cpu;
+	bool remote_pop;
+	bool stop;
+	bool popper_done;
+
+	bool in_push;		/* the task is inside __objpool_try_add_slot() */
+
+	unsigned long pushes, irq_pushes, pops;
+	unsigned long nested;	/* timer pushes that interrupted a task push */
+	unsigned long hidden;	/* last != tail after the task's push returned */
+	unsigned long doubles;	/* pop returned an object that is not in the pool */
+	struct completion done;
+};
+
+static struct op_obj *op_take(struct op_ctx *ctx, int stock)
+{
+	struct op_obj *obj = NULL;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&ctx->lock, flags);
+	if (ctx->nstock[stock])
+		obj = ctx->stock[stock][--ctx->nstock[stock]];
+	raw_spin_unlock_irqrestore(&ctx->lock, flags);
+	return obj;
+}
+
+static void op_give(struct op_ctx *ctx, struct op_obj *obj)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&ctx->lock, flags);
+	ctx->stock[obj->owner][ctx->nstock[obj->owner]++] = obj;
+	raw_spin_unlock_irqrestore(&ctx->lock, flags);
+}
+
+/* an object popped from the pool: it must have been in the pool */
+static void op_popped(struct op_ctx *ctx, struct op_obj *obj)
+{
+	ctx->pops++;
+	if (atomic_xchg(&obj->held, 1)) {
+		/* someone else holds it: don't put it in a stock twice */
+		ctx->doubles++;
+		return;
+	}
+	op_give(ctx, obj);
+}
+
+static enum hrtimer_restart op_timer_fn(struct hrtimer *timer)
+{
+	struct op_ctx *ctx = container_of(timer, struct op_ctx, timer);
+	struct op_obj *obj;
+
+	if (READ_ONCE(ctx->stop))
+		return HRTIMER_NORESTART;
+
+	/* the "NMI": push to the slot of the CPU it interrupted */
+	obj = op_take(ctx, OP_IRQ);
+	if (obj) {
+		if (READ_ONCE(ctx->in_push))
+			ctx->nested++;
+		atomic_set(&obj->held, 0);
+		objpool_push(obj, &ctx->pool);
+		ctx->irq_pushes++;
+	}
+
+	hrtimer_forward_now(timer, ns_to_ktime(OP_TIMER_NS));
+	return HRTIMER_RESTART;
+}
+
+/* push from task context, with interrupts enabled so that the timer can nest */
+static void op_task_push(struct op_ctx *ctx, struct op_obj *obj)
+{
+	struct objpool_slot *slot = ctx->pool.cpu_slots[ctx->cpu];
+	unsigned long flags;
+
+	atomic_set(&obj->held, 0);
+	WRITE_ONCE(ctx->in_push, true);
+	__objpool_try_add_slot(obj, &ctx->pool, ctx->cpu);
+	WRITE_ONCE(ctx->in_push, false);
+	ctx->pushes++;
+
+	/*
+	 * No push to this slot is in flight now: the timer only interrupts
+	 * us, and other CPUs never push to it.  Every entry must be visible.
+	 */
+	local_irq_save(flags);
+	if (READ_ONCE(slot->last) != READ_ONCE(slot->tail))
+		ctx->hidden++;
+	local_irq_restore(flags);
+}
+
+static int op_task_fn(void *data)
+{
+	struct op_ctx *ctx = data;
+	unsigned long end = jiffies + msecs_to_jiffies(OP_RUN_MS);
+	struct op_obj *obj;
+	unsigned long flags;
+
+	hrtimer_start(&ctx->timer, ns_to_ktime(OP_TIMER_NS),
+		      HRTIMER_MODE_REL_PINNED_HARD);
+
+	while (time_before(jiffies, end)) {
+		obj = op_take(ctx, OP_TASK);
+		if (obj)
+			op_task_push(ctx, obj);
+
+		if (!ctx->remote_pop) {
+			/* consume what is visible, like kretprobe entries would */
+			local_irq_save(flags);
+			while ((obj = __objpool_try_get_slot(&ctx->pool, ctx->cpu)))
+				op_popped(ctx, obj);
+			local_irq_restore(flags);
+		}
+		cond_resched();
+	}
+
+	WRITE_ONCE(ctx->stop, true);
+	hrtimer_cancel(&ctx->timer);
+
+	/*
+	 * A remote pop may be spinning because 'last' went backwards; any
+	 * later push to the slot releases it.  Use the reserve for that.
+	 */
+	while (ctx->remote_pop && !READ_ONCE(ctx->popper_done)) {
+		/* keep one reserve object for the teardown */
+		if (ctx->nreserve > 1) {
+			obj = ctx->reserve[--ctx->nreserve];
+			atomic_set(&obj->held, 0);
+			local_irq_save(flags);
+			__objpool_try_add_slot(obj, &ctx->pool, ctx->cpu);
+			local_irq_restore(flags);
+		}
+		schedule_timeout_uninterruptible(1);
+	}
+
+	complete(&ctx->done);
+	return 0;
+}
+
+static int op_popper_fn(void *data)
+{
+	struct op_ctx *ctx = data;
+	struct op_obj *obj;
+
+	while (!READ_ONCE(ctx->stop)) {
+		obj = objpool_pop(&ctx->pool);
+		if (obj)
+			op_popped(ctx, obj);
+		cond_resched();
+	}
+	WRITE_ONCE(ctx->popper_done, true);
+	return 0;
+}
+
+static int op_objinit(void *obj, void *context)
+{
+	atomic_set(&((struct op_obj *)obj)->held, 0);
+	return 0;
+}
+
+static void op_run(struct kunit *test, bool remote_pop)
+{
+	struct task_struct *task, *popper = NULL;
+	struct objpool_slot *slot;
+	struct op_ctx *ctx;
+	unsigned long flags;
+	int i, n = 0, cpu, pcpu, in_pool = 0, lost;
+	struct op_obj *obj;
+
+	if (remote_pop && num_online_cpus() < 2)
+		kunit_skip(test, "needs at least 2 CPUs");
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	ctx->remote_pop = remote_pop;
+	raw_spin_lock_init(&ctx->lock);
+	init_completion(&ctx->done);
+	hrtimer_setup(&ctx->timer, op_timer_fn, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_PINNED_HARD);
+
+	KUNIT_ASSERT_EQ(test, 0, objpool_init(&ctx->pool, OP_NR_OBJS,
+					      sizeof(struct op_obj), GFP_KERNEL,
+					      NULL, op_objinit, NULL));
+
+	/* take every object out of the pool; hand them to the stocks */
+	while (n < OP_NR_OBJS && (obj = objpool_pop(&ctx->pool)))
+		ctx->objs[n++] = obj;
+	KUNIT_ASSERT_EQ(test, n, OP_NR_OBJS);
+	for (i = 0; i < OP_NR_OBJS; i++) {
+		obj = ctx->objs[i];
+		atomic_set(&obj->held, 1);
+		if (i < OP_RESERVE) {
+			ctx->reserve[ctx->nreserve++] = obj;
+			obj->owner = OP_TASK;
+			continue;
+		}
+		obj->owner = i & 1 ? OP_IRQ : OP_TASK;
+		ctx->stock[obj->owner][ctx->nstock[obj->owner]++] = obj;
+	}
+
+	cpu = cpumask_first(cpu_online_mask);
+	pcpu = cpumask_next(cpu, cpu_online_mask);
+	ctx->cpu = cpu;
+	slot = ctx->pool.cpu_slots[cpu];
+
+	task = kthread_create(op_task_fn, ctx, "objpool_kunit_push");
+	KUNIT_ASSERT_FALSE(test, IS_ERR(task));
+	kthread_bind(task, cpu);
+	if (remote_pop) {
+		popper = kthread_create(op_popper_fn, ctx, "objpool_kunit_pop");
+		KUNIT_ASSERT_FALSE(test, IS_ERR(popper));
+		kthread_bind(popper, pcpu);
+		wake_up_process(popper);
+	}
+	wake_up_process(task);
+	wait_for_completion(&ctx->done);
+
+	/*
+	 * Quiescent now.  Objects that are in the pool but outside
+	 * [head, tail) can never be popped again: they are lost.
+	 */
+	for (i = 0; i < OP_NR_OBJS; i++)
+		if (!atomic_read(&ctx->objs[i]->held))
+			in_pool++;
+	lost = in_pool - (int)(READ_ONCE(slot->tail) - READ_ONCE(slot->head));
+
+	kunit_info(test, "%lu task pushes, %lu timer pushes (%lu nested), %lu pops: %lu hidden, %lu double handouts, %d lost\n",
+		   ctx->pushes, ctx->irq_pushes, ctx->nested, ctx->pops,
+		   ctx->hidden, ctx->doubles, lost);
+
+	/* no nesting means the test proved nothing */
+	KUNIT_EXPECT_GT(test, ctx->nested, 0UL);
+	KUNIT_EXPECT_EQ(test, ctx->hidden, 0UL);
+	KUNIT_EXPECT_EQ(test, ctx->doubles, 0UL);
+	KUNIT_EXPECT_EQ(test, lost, 0);
+
+	/*
+	 * Tear down: republish the slot (a push sets 'last' past 'head'),
+	 * drain it, then drop every object and the pool.
+	 */
+	if (ctx->nreserve) {
+		obj = ctx->reserve[--ctx->nreserve];
+		atomic_set(&obj->held, 0);
+		local_irq_save(flags);
+		__objpool_try_add_slot(obj, &ctx->pool, cpu);
+		local_irq_restore(flags);
+	}
+	if ((int)(READ_ONCE(slot->last) - READ_ONCE(slot->head)) >= 0) {
+		while (objpool_pop(&ctx->pool))
+			;
+	}
+	for (i = 0; i < OP_NR_OBJS; i++)
+		objpool_drop(ctx->objs[i], &ctx->pool);
+	objpool_fini(&ctx->pool);
+}
+
+static void objpool_test_nested_push(struct kunit *test)
+{
+	op_run(test, false);
+}
+
+static void objpool_test_nested_push_remote_pop(struct kunit *test)
+{
+	op_run(test, true);
+}
+
+static struct kunit_case objpool_test_cases[] = {
+	KUNIT_CASE_SLOW(objpool_test_nested_push),
+	KUNIT_CASE_SLOW(objpool_test_nested_push_remote_pop),
+	{}
+};
+
+static struct kunit_suite objpool_test_suite = {
+	.name = "objpool",
+	.test_cases = objpool_test_cases,
+};
+
+kunit_test_suite(objpool_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for objpool");
+MODULE_LICENSE("GPL");
-- 
2.43.0

