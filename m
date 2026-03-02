Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AAF35AC2A
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457263; cv=none; b=ZLjD4QkyABsn1xIzoov+x6oEj97uMJ+UOc3e3bB9mCOC0QxV3b3oessc+2FwwuAKee+yMZYW0+OEM0xyxW4xvXWWbujN+7wYszedZN96saAkygM6UpnIZ6EFPnw3uA27cZhYoHODcTZZXXHIeH7jFJ3KvzacraZatU+1702c/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457263; c=relaxed/simple;
	bh=kF4XVeoAfHxGJSSlsooJP7Uo7M06fSw89MuNkSE9u8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=qyvy64BWufvgvD1pEJu1pBLTsp2zW6s2tivC+P9xz0nbDF+eadFFqSep+TLyBeZKebLHifTgYS5vrmaCJWx/5ijoZUoOPRZqbgjmMVuBCFVFUN47nGNB6oFUNTScQoq2x2VxKahEG1StfKlzSj3rYiX2nuNrJ8NaMOo4Yd0xiIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hsXKEFYa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsXKEFYa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772457260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dMKdJ1my1tkMG8FcGXFi+jO4sAEDyDWkdYI16D2K2Ik=;
	b=hsXKEFYaXdOLRGX50m55piEEC8lJwYxgy+MkXjoZAwi7H0HrEJ2ToFjRaTrbHAkz3eUsOX
	raYuyMThFPMhGVB2Mng5wTDtP0WJKhnW/DoAh04ghpKKcylUnCQ2vkaPJh/J5usouxI6Ba
	reU/QUEEVnCh9FeVZ6vZYdiLPYDfNgs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-8iN0qFF7N6aCdyTsyod0Gw-1; Mon,
 02 Mar 2026 08:14:17 -0500
X-MC-Unique: 8iN0qFF7N6aCdyTsyod0Gw-1
X-Mimecast-MFC-AGG-ID: 8iN0qFF7N6aCdyTsyod0Gw_1772457256
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44E5A195608F;
	Mon,  2 Mar 2026 13:14:16 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.222])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3B2C030001B9;
	Mon,  2 Mar 2026 13:14:11 +0000 (UTC)
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
Subject: [PATCH v2] tracing/osnoise: Add option to align tlat threads
Date: Mon,  2 Mar 2026 14:13:16 +0100
Message-ID: <20260302131316.385987-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: p_wt8GmmUrcsrnw0hV9z1ybvIVodrQFQ0sA6Nyor9gQ_1772457256
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
---
v1 + discussion: https://lore.kernel.org/linux-trace-kernel/20260227150420.319528-1-tglozar@redhat.com/T/#u

v2:
- Make align_next global and reset it to 0 in osnoise_workload_start()
so that it gets set by the first thread of each measurement and is not stuck
on what is set by the first measurement until reboot.
- Use atomic64_add_return_relaxed() in place of atomic64_fetch_add_relaxed()
to make the code shorter and easier to read.
- Add more detailed comments to the alignment synchronization logic.
- Fix two typos in the commit message: 50 -> 20 in the example introduction,
and incremenets -> increments.

I tested v2 with the same command I used for v1. I also added debug printk()
calls and verified that the logic is implemented correctly:

[  120.273901] timerlat: thread 2 setting align_next to 119896370619
[  120.273977] timerlat: aligning thread 1 to 119896370619
[  120.274385] timerlat: aligning thread 3 to 119896370619
[  120.274476] timerlat: aligning thread 4 to 119896370619
[  142.457440] timerlat: thread 1 setting align_next to 142080851122
[  142.457529] timerlat: aligning thread 2 to 142080871122
[  142.457629] timerlat: aligning thread 3 to 142080891122
[  142.458033] timerlat: aligning thread 4 to 142080911122

 kernel/trace/trace_osnoise.c | 52 +++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index dee610e465b9..1cde1da57f97 100644
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
@@ -326,6 +328,7 @@ static struct osnoise_data {
 	u64	stop_tracing_total;	/* stop trace in the final operation (report/thread) */
 #ifdef CONFIG_TIMERLAT_TRACER
 	u64	timerlat_period;	/* timerlat period */
+	u64	timerlat_align_us;	/* timerlat alignment */
 	u64	print_stack;		/* print IRQ stack if total > */
 	int	timerlat_tracer;	/* timerlat tracer */
 #endif
@@ -338,6 +341,7 @@ static struct osnoise_data {
 #ifdef CONFIG_TIMERLAT_TRACER
 	.print_stack			= 0,
 	.timerlat_period		= DEFAULT_TIMERLAT_PERIOD,
+	.timerlat_align_us		= 0,
 	.timerlat_tracer		= 0,
 #endif
 };
@@ -1813,6 +1817,11 @@ static enum hrtimer_restart timerlat_irq(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+/*
+ * timerlat wake-up offset for next thread with TIMERLAT_ALIGN set.
+ */
+static atomic64_t align_next;
+
 /*
  * wait_next_period - Wait for the next period for timerlat
  */
@@ -1829,6 +1838,26 @@ static int wait_next_period(struct timerlat_variables *tlat)
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
@@ -2650,6 +2679,17 @@ static struct trace_min_max_param timerlat_period = {
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
@@ -2746,6 +2786,11 @@ static int init_timerlat_tracefs(struct dentry *top_dir)
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
@@ -2877,6 +2922,11 @@ static int osnoise_workload_start(void)
 		return 0;
 
 	osn_var_reset_all();
+	/*
+	 * Reset also align_next, to be filled by a new offset by the first timerlat
+	 * thread that wakes up, if TIMERLAT_ALIGN is set.
+	 */
+	atomic64_set(&align_next, 0);
 
 	retval = osnoise_hook_events();
 	if (retval)
-- 
2.53.0

