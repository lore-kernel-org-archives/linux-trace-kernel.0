Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7731FAC3B;
	Mon, 21 Oct 2024 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729523595; cv=none; b=pTY/KacfYdzctliPY0ZffwmDD6iR6q1lsB+wwAChABJZc3+EFlB5eYBjlES/rxhQnsdxiBwLrDc+fKjBZwWjgu4HQpPs19vecHtcHhQ6mtPIL8hEibo9FgXTl+d5mnx0oPXOvR8XueMZ08jcJTS0FQ5Mnuffo3ub3fJnYynmzFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729523595; c=relaxed/simple;
	bh=QjIvZlCtVBiBsmsnr8cISyDYLEv8628810IVww1WNSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4LspOB1TaSomrWA4IBdgN4kgl/dx7bqWPV1ZxZ6S8yHCDWv0cqzgzyN4/Z4CSW6ME4Ze+PoyJGFcHAbS+lMXSVbwNXByWu6Ek/q0QXrgqBXC9n3ci8097HF/adwxRDIvrMxTfhEj+nUuE9wIw5JgEK8uIYXwPUnp3kjAohTenc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0HF2jZDA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WeY5DLKy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0HF2jZDA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WeY5DLKy"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729523587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HaEaP85s+bDV/FR3UNIae3NhDHTKAM5R8mgLmDl9h4A=;
	b=0HF2jZDAXbmVVSgQ6C909u3k9wAUIjb5QwKmPFALR1hwemXqQft7BwtjujT4D1xRW460GW
	uwiJ5fGXhxuNtxopfV+jG//m2aUk6ugATphTWuvJ8Q69NVo0nFJ3BULKvcghCV7v8Dl5Jq
	Q9LlejV0LMuU7kuGyMxDs48z1UrkfVKkGnrtoH25+HWx7VuOlF++AMp/EuKINMQTqmgcbR
	dx43OP5ikRlFIc03+PBTulOLqUt6zssS7XGfpGW4rmRHK2VKN5yn64FJWjYQ7Fo2KvBwV9
	7WO2D4F2jDtuUIouWHi4jRhw2Hefs+ThkR4ukmUT8zBvABStt2ICTXiOotTKdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729523587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HaEaP85s+bDV/FR3UNIae3NhDHTKAM5R8mgLmDl9h4A=;
	b=WeY5DLKyyb2I3Br33YRRtuMkTu3/UaKNldq7aX4F8R4F7RrE1hS+3GyQJaTrmHX8H0HGhP
	58by9NFPNJIm1mCw==
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	tglx@linutronix.de,
	mingo@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	ankur.a.arora@oracle.com,
	efault@gmx.de,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 2/3] tracing: Record task flag NEED_RESCHED_LAZY.
Date: Mon, 21 Oct 2024 17:08:41 +0200
Message-ID: <20241021151257.102296-3-bigeasy@linutronix.de>
In-Reply-To: <20241021151257.102296-1-bigeasy@linutronix.de>
References: <20241021151257.102296-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Thomas Gleixner <tglx@linutronix.de>

The scheduler added NEED_RESCHED_LAZY scheduling. Record this state as
part of trace flags and expose it in the need_resched field.

Record and expose NEED_RESCHED_LAZY.

[bigeasy: Commit description, documentation bits.]

Reviewed-by: Ankur Arora <ankur.a.arora@oracle.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 Documentation/trace/ftrace.rst |    4 ++++
 include/linux/trace_events.h   |    1 +
 kernel/trace/trace.c           |    2 ++
 kernel/trace/trace_output.c    |   14 +++++++++++++-
 4 files changed, 20 insertions(+), 1 deletion(-)

--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1036,9 +1036,13 @@ explains which is which.
 		be printed here.
=20
   need-resched:
+	- 'B' all, TIF_NEED_RESCHED, PREEMPT_NEED_RESCHED and TIF_RESCHED_LAZY is=
 set,
 	- 'N' both TIF_NEED_RESCHED and PREEMPT_NEED_RESCHED is set,
 	- 'n' only TIF_NEED_RESCHED is set,
 	- 'p' only PREEMPT_NEED_RESCHED is set,
+	- 'L' borg PREEMPT_NEED_RESCHED and TIF_RESCHED_LAZY is set,
+	- 'b' borg TIF_NEED_RESCHED and TIF_RESCHED_LAZY is set,
+	- 'l' only TIF_RESCHED_LAZY is set
 	- '.' otherwise.
=20
   hardirq/softirq:
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -185,6 +185,7 @@ unsigned int tracing_gen_ctx_irq_test(un
 enum trace_flag_type {
 	TRACE_FLAG_IRQS_OFF		=3D 0x01,
 	TRACE_FLAG_NEED_RESCHED		=3D 0x02,
+	TRACE_FLAG_NEED_RESCHED_LAZY	=3D 0x04,
 	TRACE_FLAG_HARDIRQ		=3D 0x08,
 	TRACE_FLAG_SOFTIRQ		=3D 0x10,
 	TRACE_FLAG_PREEMPT_RESCHED	=3D 0x20,
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2544,6 +2544,8 @@ unsigned int tracing_gen_ctx_irq_test(un
 		trace_flags |=3D TRACE_FLAG_NEED_RESCHED;
 	if (test_preempt_need_resched())
 		trace_flags |=3D TRACE_FLAG_PREEMPT_RESCHED;
+	if (IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY) && tif_test_bit(TIF_NEED_RES=
CHED_LAZY))
+		trace_flags |=3D TRACE_FLAG_NEED_RESCHED_LAZY;
 	return (trace_flags << 16) | (min_t(unsigned int, pc & 0xff, 0xf)) |
 		(min_t(unsigned int, migration_disable_value(), 0xf)) << 4;
 }
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -463,17 +463,29 @@ int trace_print_lat_fmt(struct trace_seq
 		!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_SUPPORT) ? 'X' :
 		'.';
=20
-	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED |
+	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED=
_LAZY |
 				TRACE_FLAG_PREEMPT_RESCHED)) {
+	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_=
PREEMPT_RESCHED:
+		need_resched =3D 'B';
+		break;
 	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_PREEMPT_RESCHED:
 		need_resched =3D 'N';
 		break;
+	case TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
+		need_resched =3D 'L';
+		break;
+	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY:
+		need_resched =3D 'b';
+		break;
 	case TRACE_FLAG_NEED_RESCHED:
 		need_resched =3D 'n';
 		break;
 	case TRACE_FLAG_PREEMPT_RESCHED:
 		need_resched =3D 'p';
 		break;
+	case TRACE_FLAG_NEED_RESCHED_LAZY:
+		need_resched =3D 'l';
+		break;
 	default:
 		need_resched =3D '.';
 		break;
