Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A09434DCE6
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Apr 2026 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776340841; cv=none; b=BJHISvkIEyS+Z4bfhp9DhrYJrsYMK1wXWjL1vJfyhxNNMuSnZwlTJrPQAvRKeSYV3sMhGqVWnr4AjeVY9/PkypFxQAHdlnYOddr+QjC5kBu2NheHO1XqyUGqzqUhOn8M0bXKF/aDiNKEaJav+J5Q26hvC5U76jnVoDvYoPnqlFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776340841; c=relaxed/simple;
	bh=MoHi6prVuLzeu6d7eQXsjI79aXMKe89NvsovSRhQ4hI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=TTC+4klqErU/JKn1hl+s67O7Qrn7KWqueZqM9YY8/RQ9xPJo4YQB/x44CypqfnYU/4Wam6z0C+OJImwHkwObQc73oDefJUihS3Ed05/tuIxqxMGvLSidTQIitT53JlOWqteoEU9ApGWKj/n6YEajBWgB2LtYkQ9E5dZdXyENwww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QvMo49PL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvMo49PL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776340837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ljg/vGkgzOJ0biq8IG4WkC/4yXpEyALjAfTw5FZo1Z0=;
	b=QvMo49PLT5EfqBE0wzB4Krfg0fg1dFryw7ZlL95hk76m75xCuXv9S/TAgBfIs5K0Pqz/Yg
	l8anN5fZeHKkInUNHFzxzQYSYqNqe1jjlN76p6pra1VZhUxH7rTNPDDy56390wvEqB9Ygf
	fxt7VDLOi9egzD/+FsBQ2zNpgVwjNaQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-cLGOezO-OOOQecrFjMxFrw-1; Thu,
 16 Apr 2026 08:00:32 -0400
X-MC-Unique: cLGOezO-OOOQecrFjMxFrw-1
X-Mimecast-MFC-AGG-ID: cLGOezO-OOOQecrFjMxFrw_1776340831
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD1E219560A6;
	Thu, 16 Apr 2026 12:00:31 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D3D1195608E;
	Thu, 16 Apr 2026 12:00:28 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v3] tracing/osnoise: Add option to align tlat threads
Date: Thu, 16 Apr 2026 13:59:42 +0200
Message-ID: <20260416115942.544032-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: PAfDjYyIUxIsy7Kyx6bKMTqR8DlYjGE1TNTujvyYXP0_1776340831
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add an option called TIMERLAT_ALIGN to osnoise/options, together with a
corresponding setting osnoise/timerlat_align_us.

This option sets the alignment of wakeup times between different
timerlat threads, similarly to cyclictest's -A/--aligned option. If
TIMERLAT_ALIGN is set, the first thread that reaches the first cycle
records its first wake-up time. Each following thread sets its first
wake-up time to a fixed offset from the recorded time, and increments
it by the same offset.

Example:

osnoise/timerlat_period is set to 1000, osnoise/timerlat_align_us is
set to 20. There are four threads, on CPUs 1 to 4.

- CPU 4 enters first cycle first. The current time is 20000us, so
the wake-up of the first cycle is set to 21000us. This time is recorded.
- CPU 2 enter first cycle next. It reads the recorded time, increments
it to 21020us, and uses this value as its own wake-up time for the first
cycle.
- CPU 3 enters first cycle next. It reads the recorded time, increments
it to 21040 us, and uses the value as its own wake-up time.
- CPU 1 proceeds analogically.

In each next cycle, the wake-up time (called "absolute period" in
timerlat code) is incremented by the (relative) period of 1000us. Thus,
the wake-ups in the following cycles (provided the times are reached and
not in the past) will be as follows:

CPU 1		CPU 2		CPU 3	 	CPU 4
21080us		21020us		21040us		21000us
22080us		22020us		22040us		22000us
...		...		...		...

Even if any cycle is skipped due to e.g. the first cycle calculation
happening later, the alignment stays in place.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Reviewed-by: Wander Lairson Costa <wander@redhat.com>
Reviewed-by: Crystal Wood <crwood@redhat.com>
---
v2 + discussion: https://lore.kernel.org/linux-trace-kernel/20260302131316.385987-1-tglozar@redhat.com/T/#u

v1 + discussion: https://lore.kernel.org/linux-trace-kernel/20260227150420.319528-1-tglozar@redhat.com/T/#u

v3:
- Move align_next up and reset it in tlat_var_reset() instead of
osnoise_workload_start() to fix build failure with CONFIG_TIMERLAT_TRACER=n.
(Bug found by Steven Rostedt, fix suggested by Crystal Wood.)

v2:
- Make align_next global and reset it to 0 in osnoise_workload_start()
so that it gets set by the first thread of each measurement and is not stuck
on what is set by the first measurement until reboot.
- Use atomic64_add_return_relaxed() in place of atomic64_fetch_add_relaxed()
to make the code shorter and easier to read.
- Add more detailed comments to the alignment synchronization logic.
- Fix two typos in the commit message: 50 -> 20 in the example introduction,
and incremenets -> increments.

I tested the patch the same way I did for v2:

[root@cs9 tglozar]# cd /sys/kernel/tracing/osnoise/
[root@cs9 osnoise]# echo TIMERLAT_ALIGN > options
[root@cs9 osnoise]# echo 40 > timerlat_align_us
[root@cs9 osnoise]# rtla timerlat top -q -c 0,1,2,3 -d 1s
...
[root@cs9 osnoise]# rtla timerlat top -q -c 0,1,2,3 -d 1s
...
[root@cs9 osnoise]# dmesg | tail -n9
[   25.664229] timerlat: thread 0 setting align_next to 25659481645
[   25.664794] timerlat: aligning thread 1 to 25659521645
[   25.665294] timerlat: aligning thread 2 to 25659561645
[   25.665770] timerlat: aligning thread 3 to 25659601645
[   30.370790] NFSD: all clients done reclaiming, ending NFSv4 grace period (net effffff9)
[   30.442436] timerlat: thread 0 setting align_next to 30437695876
[   30.442853] timerlat: aligning thread 1 to 30437735876
[   30.443141] timerlat: aligning thread 2 to 30437775876
[   30.443659] timerlat: aligning thread 3 to 30437815876
[root@cs9 osnoise]#

to show that align_next is indeed reset. Additionaly I tested that building
without CONFIG_TIMERLAT_TRACER works.

 kernel/trace/trace_osnoise.c | 54 +++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index be6cf0bb3c03..75678053b21c 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -58,6 +58,7 @@ enum osnoise_options_index {
 	OSN_PANIC_ON_STOP,
 	OSN_PREEMPT_DISABLE,
 	OSN_IRQ_DISABLE,
+	OSN_TIMERLAT_ALIGN,
 	OSN_MAX
 };
 
@@ -66,7 +67,8 @@ static const char * const osnoise_options_str[OSN_MAX] = {
 							"OSNOISE_WORKLOAD",
 							"PANIC_ON_STOP",
 							"OSNOISE_PREEMPT_DISABLE",
-							"OSNOISE_IRQ_DISABLE" };
+							"OSNOISE_IRQ_DISABLE",
+							"TIMERLAT_ALIGN" };
 
 #define OSN_DEFAULT_OPTIONS		0x2
 static unsigned long osnoise_options	= OSN_DEFAULT_OPTIONS;
@@ -250,6 +252,11 @@ struct timerlat_variables {
 
 static DEFINE_PER_CPU(struct timerlat_variables, per_cpu_timerlat_var);
 
+/*
+ * timerlat wake-up offset for next thread with TIMERLAT_ALIGN set.
+ */
+static atomic64_t align_next;
+
 /*
  * this_cpu_tmr_var - Return the per-cpu timerlat_variables on its relative CPU
  */
@@ -268,6 +275,7 @@ static inline void tlat_var_reset(void)
 
 	/* Synchronize with the timerlat interfaces */
 	mutex_lock(&interface_lock);
+
 	/*
 	 * So far, all the values are initialized as 0, so
 	 * zeroing the structure is perfect.
@@ -278,6 +286,12 @@ static inline void tlat_var_reset(void)
 			hrtimer_cancel(&tlat_var->timer);
 		memset(tlat_var, 0, sizeof(*tlat_var));
 	}
+	/*
+	 * Reset also align_next, to be filled by a new offset by the first timerlat
+	 * thread that wakes up, if TIMERLAT_ALIGN is set.
+	 */
+	atomic64_set(&align_next, 0);
+
 	mutex_unlock(&interface_lock);
 }
 #else /* CONFIG_TIMERLAT_TRACER */
@@ -326,6 +340,7 @@ static struct osnoise_data {
 	u64	stop_tracing_total;	/* stop trace in the final operation (report/thread) */
 #ifdef CONFIG_TIMERLAT_TRACER
 	u64	timerlat_period;	/* timerlat period */
+	u64	timerlat_align_us;	/* timerlat alignment */
 	u64	print_stack;		/* print IRQ stack if total > */
 	int	timerlat_tracer;	/* timerlat tracer */
 #endif
@@ -338,6 +353,7 @@ static struct osnoise_data {
 #ifdef CONFIG_TIMERLAT_TRACER
 	.print_stack			= 0,
 	.timerlat_period		= DEFAULT_TIMERLAT_PERIOD,
+	.timerlat_align_us		= 0,
 	.timerlat_tracer		= 0,
 #endif
 };
@@ -1829,6 +1845,26 @@ static int wait_next_period(struct timerlat_variables *tlat)
 	 */
 	tlat->abs_period = (u64) ktime_to_ns(next_abs_period);
 
+	/*
+	 * Align thread in the first cycle on each CPU to the set alignment
+	 * if TIMERLAT_ALIGN is set.
+	 *
+	 * This is done by using an atomic64_t to store the next absolute period.
+	 * The first thread that wakes up will set the atomic64_t to its
+	 * absolute period, and the other threads will increment it by
+	 * the alignment value.
+	 */
+	if (test_bit(OSN_TIMERLAT_ALIGN, &osnoise_options) && !tlat->count
+	    && atomic64_cmpxchg_relaxed(&align_next, 0, tlat->abs_period)) {
+		/*
+		 * A thread has already set align_next, use it and increment it
+		 * to be used by the next thread that wakes up after this one.
+		 */
+		tlat->abs_period = atomic64_add_return_relaxed(
+			osnoise_data.timerlat_align_us * 1000, &align_next);
+		next_abs_period = ns_to_ktime(tlat->abs_period);
+	}
+
 	/*
 	 * If the new abs_period is in the past, skip the activation.
 	 */
@@ -2650,6 +2686,17 @@ static struct trace_min_max_param timerlat_period = {
 	.min	= &timerlat_min_period,
 };
 
+/*
+ * osnoise/timerlat_align_us: align the first wakeup of all timerlat
+ * threads to a common boundary (in us). 0 means disabled.
+ */
+static struct trace_min_max_param timerlat_align_us = {
+	.lock	= &interface_lock,
+	.val	= &osnoise_data.timerlat_align_us,
+	.max	= NULL,
+	.min	= NULL,
+};
+
 static const struct file_operations timerlat_fd_fops = {
 	.open		= timerlat_fd_open,
 	.read		= timerlat_fd_read,
@@ -2746,6 +2793,11 @@ static int init_timerlat_tracefs(struct dentry *top_dir)
 	if (!tmp)
 		return -ENOMEM;
 
+	tmp = tracefs_create_file("timerlat_align_us", TRACE_MODE_WRITE, top_dir,
+				  &timerlat_align_us, &trace_min_max_fops);
+	if (!tmp)
+		return -ENOMEM;
+
 	retval = osnoise_create_cpu_timerlat_fd(top_dir);
 	if (retval)
 		return retval;
-- 
2.53.0

