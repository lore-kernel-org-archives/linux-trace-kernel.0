Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB6C2D638;
	Fri, 22 Nov 2024 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296726; cv=none; b=H3OdcY2SLVBxSQnvLHRveuaSTCtvdsm5FETZjUhXtFwISYER4aWSiF0Oqw+RRSrobvH6mujTeRYfCE5u8fvCzMM/dVAm43ptZn8opw3o9RT4MWuohxDy6svSpdhXgp3/LNv4T5tsffYxZ0LGQXX8pc8fzfkqEIbUgkjV2wYk7Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296726; c=relaxed/simple;
	bh=DTgcuZZK+mVPnIdMa/DUKbH25Ek8gr3gW8S01DVua+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TqYzxAx2mLutHP9Oz6c4oU47FG2xdlPn2TOqoaLCHgCMjsuFZQuxOblKXUcRtG7zuB7JRUAFJy5fm774+vn/xgcd7eQrstQU/cOqQg/Ql77psKBgw7o9ulCcls3BbmfA+X366DzU1dscvqYwr+QZCjHa6DVCua8xtH7dpsoRGvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OV6yMgt9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kh8AFfjr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OV6yMgt9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kh8AFfjr"
Date: Fri, 22 Nov 2024 18:32:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732296722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7vOgU3NocPHUUkohMIpqePO+43urjVeU+r5yhU/I7Dk=;
	b=OV6yMgt9tSgzOngAtZ/p/BlCkpm+Db/Bzo/7jjg6VpXJAcJJzVDvmThXO2Djb+AP2rpP+X
	jkFXlR/QVqBpwUyDUrZQ1ObzbUEaoKWoZ0V119zB11yy8tsPd9i9dYxDFLyJcRer/XHt/6
	Da1IwHkN1oSK/EwEGPMIXyQ5VC+728NFT2eOql6lT6cvR4HugMIwHsiSKv1GV/3In0K7/2
	bKbUYC93vkrD4gbV+m4LJ6TwzjFZL+96EyYQVv9j7oHbasPl5/uz2D3QZKo82DL6dZ7en1
	TB2SeR5zIFN5SkkEjzsxd+OGRqHbR3zDg/M1FVGWbNJDk6MP8/693QoY+ixdEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732296722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7vOgU3NocPHUUkohMIpqePO+43urjVeU+r5yhU/I7Dk=;
	b=Kh8AFfjr5ix+qzOJoTTr9by+FQIo/fqn6d1pHhD8PDis6IwoCCV5eghn5zaJiqTpTcnvyH
	YTTRG8tfwnEw6RAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
	mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, ankur.a.arora@oracle.com,
	efault@gmx.de, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v3] tracing: Record task flag NEED_RESCHED_LAZY.
Message-ID: <20241122173201.tsqK0eeD@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Thomas Gleixner <tglx@linutronix.de>

The scheduler added NEED_RESCHED_LAZY scheduling. Record this state as
part of trace flags and expose it in the need_resched field.

Record and expose NEED_RESCHED_LAZY.

[bigeasy: Commit description, documentation bits.]

Reviewed-by: Ankur Arora <ankur.a.arora@oracle.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v2=E2=80=A6v3:
  - Use 0x02 for TRACE_FLAG_NEED_RESCHED_LAZY which is the freshly
    created gap.

 Documentation/trace/ftrace.rst |  4 ++++
 include/linux/trace_events.h   |  1 +
 kernel/trace/trace.c           |  2 ++
 kernel/trace/trace_output.c    | 14 +++++++++++++-
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 74d5bd801b1a8..16892b844108c 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1033,9 +1033,13 @@ explains which is which.
   irqs-off: 'd' interrupts are disabled. '.' otherwise.
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
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 016b29a56c875..2a5df5b62cfc7 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -184,6 +184,7 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs=
_status);
=20
 enum trace_flag_type {
 	TRACE_FLAG_IRQS_OFF		=3D 0x01,
+	TRACE_FLAG_NEED_RESCHED_LAZY	=3D 0x02,
 	TRACE_FLAG_NEED_RESCHED		=3D 0x04,
 	TRACE_FLAG_HARDIRQ		=3D 0x08,
 	TRACE_FLAG_SOFTIRQ		=3D 0x10,
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3ef047ed97055..be62f0ea1814d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2552,6 +2552,8 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int ir=
qs_status)
 		trace_flags |=3D TRACE_FLAG_NEED_RESCHED;
 	if (test_preempt_need_resched())
 		trace_flags |=3D TRACE_FLAG_PREEMPT_RESCHED;
+	if (IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY) && tif_test_bit(TIF_NEED_RES=
CHED_LAZY))
+		trace_flags |=3D TRACE_FLAG_NEED_RESCHED_LAZY;
 	return (trace_flags << 16) | (min_t(unsigned int, pc & 0xff, 0xf)) |
 		(min_t(unsigned int, migration_disable_value(), 0xf)) << 4;
 }
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index e08aee34ef63d..da748b7cbc4d5 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -462,17 +462,29 @@ int trace_print_lat_fmt(struct trace_seq *s, struct t=
race_entry *entry)
 		bh_off ? 'b' :
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
--=20
2.45.2

