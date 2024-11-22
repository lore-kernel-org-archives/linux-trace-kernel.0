Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F2E1662E4;
	Fri, 22 Nov 2024 20:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732307335; cv=none; b=fDJRRwxEKsHzl6RUfH7PisWUwdoycQsuPBXDMgvs6YyK9VZskMoGO/fxgqgyiJ/bZxeqfGGQs5Lw1h3jB+V+S6HbE78onOlVKyHEytwO0lwJAqiAIzWCnSYq3i5UMGiZVWBf3bf65MRefztPBzw5M4A+HzheTGYA6b0AwDSDDFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732307335; c=relaxed/simple;
	bh=jnaEE87Td7HGIQHHt6A6qhH1ePOVKMdXcf7v43nHwFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFEdBt6Puw1YYALB44vEjNMgxxCAHJYl+ilbO89oZR3ZhbgXd2tFSOyTkQCzPgVe+Lb2KKUlQnYjlLH5nsB4JQGZWe1AprpSEgO3o79OqpYV7O5DzbiIWd+iMuckfjkWwGw0hIhWTXlsSL8KapRDLWB6GZmtel0mX+piGXTO+qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TvRlzpH8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+khonDTs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TvRlzpH8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+khonDTs"
Date: Fri, 22 Nov 2024 21:28:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732307330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JIGUZvxoo1e9xOUa/J29MW200Oz8FYsU0+aB3VY6yGs=;
	b=TvRlzpH8u5qKyXhapSVBMR5X83VWPYF/D44JgHsXhr/N+1XEPXyCnB3lkRFqEHVgKpiKZU
	bFaIQcRhL4N5AkxQeeLOFzVNK1jBgLUpzXRHct14F17RusNLm5da0XlUuOVTx2/z2jyani
	oVlZVQkxAnjYjhvGEDAvfBkQwEV3A6FY4M61XhpTzABGUdO5xeglU3+66keRyYq5g0htCo
	rfjOSExTAkmUj+nRuG/E9I78bHPQ4zttzFJKmWxWoBn/kA8TIcbn5nIvqin/rDaXub/MWF
	6C1YnHCgep+2y8pydSGAY44bs9E5PI+kLMXTov3azf8JW79HzBMoVOhln1RV6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732307330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JIGUZvxoo1e9xOUa/J29MW200Oz8FYsU0+aB3VY6yGs=;
	b=+khonDTsMWynj4M5LrfgUtvlWT4hw6PLCNXq/Ez5F5qQEOok+G991FAt0bTQIu0UPq8UlU
	yDfwuQC7Gwf0+iDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
	mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, ankur.a.arora@oracle.com, efault@gmx.de,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v4] tracing: Record task flag NEED_RESCHED_LAZY.
Message-ID: <20241122202849.7DfYpJR0@linutronix.de>
References: <20241122173201.tsqK0eeD@linutronix.de>
 <20241122143742.038c77fa@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241122143742.038c77fa@gandalf.local.home>

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
v3=E2=80=A6v4:
  - s/borg/both

 Documentation/trace/ftrace.rst |  4 ++++
 include/linux/trace_events.h   |  1 +
 kernel/trace/trace.c           |  2 ++
 kernel/trace/trace_output.c    | 14 +++++++++++++-
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 74d5bd801b1a8..272464bb7c602 100644
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
+	- 'L' both PREEMPT_NEED_RESCHED and TIF_RESCHED_LAZY is set,
+	- 'b' both TIF_NEED_RESCHED and TIF_RESCHED_LAZY is set,
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

