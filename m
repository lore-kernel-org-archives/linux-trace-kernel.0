Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB77A1E7677;
	Mon, 21 Oct 2024 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729523590; cv=none; b=VcUQVDVG8se3ioYWe844CsxPhiAsbAj4chS6VX6Vv5vV8lJ7N5Ib8lujzFLpj2lx+EC2JNUoS4XgPR+PYp3slQ/w+F4rw5nyUN8cyW2mPDbNhUOsmuS9yQe7q/GfYMjVspUtxNWvvQilwAMYZiqwl5VUvMJSxzd8RPKUNuDxxk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729523590; c=relaxed/simple;
	bh=5P2NQ2LTGqAw9tTdB+yi629BK+jCITFq2F+INjGiWE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oU1aqxQ4M30/dLamIV26sXaDIQRnk/oUxmTPzpfLQ43MOsM2OIabf8bNTcKEEUjXADb1I5gAo8KY4Q3+ZBxiEXl1CDvIJ2I61MfbUwtZTHQfsVqOLAXl3ArfzJMswcuM9mcN0+p/aYQTL0JO4TnEpdpsh+htSjxjrsG5oSec6BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aqz0JA1e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bt0EUuMo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aqz0JA1e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bt0EUuMo"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729523587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mJYXpgOv9Nb7Ka4YZwNzbNkv6qUKCXI6IA+AOiHpw0=;
	b=aqz0JA1e6EeyFYhZrVsWivhxlRtoaOJPvtOlZgPaez4aAgYGdKbf+VtkSIlB4x0yt630Qr
	8KJuyBA5pIpIZa8ik9mXHddNUJFU68vUETZpzgUTPv+QaijhRp2+Bd5TnD2uVs+gBpo6Gr
	WqgkAWYXLwVxRTVvCTjo7n5MpytrngZyNnHhnPBZR+1PcsDagkpj3iNObLuhIya609Rs5h
	3uHPkpHLZKUoJ/g2Yy2XAbn83lUFRXJ2G9yrLgHZoM2jPfhWox1Pjl+SdAeozWAyIr2MzL
	18+ZCEpeBY6kcFuzGIgyQlpaG0ya5rjZc4PvkgUw6HB4aAaiToqFkd8WcwfiLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729523587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mJYXpgOv9Nb7Ka4YZwNzbNkv6qUKCXI6IA+AOiHpw0=;
	b=Bt0EUuMo3fNCd6WivN40VtziHpHTDLxPNT8znL9fd6ifNCCpdgyFgUGoMWN4sscs6wdb7Q
	K5fX91JEUfMNaKDw==
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
Subject: [PATCH v2 1/3] tracing: Replace TRACE_FLAG_IRQS_NOSUPPORT with its config option.
Date: Mon, 21 Oct 2024 17:08:40 +0200
Message-ID: <20241021151257.102296-2-bigeasy@linutronix.de>
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

The TRACE_FLAG_IRQS_NOSUPPORT flag is used by tracing_gen_ctx.*() to
signal that CONFIG_TRACE_IRQFLAGS_SUPPORT is not enabled and tracing IRQ
flags is not supported.

This could be replaced by using the 0 as flags and then deducting that
there is no IRQFLAGS_SUPPORT based on the config option. The downside is
that without CONFIG_TRACE_IRQFLAGS_SUPPORT we can not distinguish
between no-IRQ passed flags and callers which passed 0. On the upside we
have room for one additional flags which could be used for LAZY_PREEMPTION.

Remove TRACE_FLAG_IRQS_NOSUPPORT and set it flags are 0 and
CONFIG_TRACE_IRQFLAGS_SUPPORT is not set.

[bigeasy: Commit descrption.]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/trace_events.h |    7 +++----
 kernel/trace/trace_output.c  |    2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -184,8 +184,7 @@ unsigned int tracing_gen_ctx_irq_test(un
=20
 enum trace_flag_type {
 	TRACE_FLAG_IRQS_OFF		=3D 0x01,
-	TRACE_FLAG_IRQS_NOSUPPORT	=3D 0x02,
-	TRACE_FLAG_NEED_RESCHED		=3D 0x04,
+	TRACE_FLAG_NEED_RESCHED		=3D 0x02,
 	TRACE_FLAG_HARDIRQ		=3D 0x08,
 	TRACE_FLAG_SOFTIRQ		=3D 0x10,
 	TRACE_FLAG_PREEMPT_RESCHED	=3D 0x20,
@@ -211,11 +210,11 @@ static inline unsigned int tracing_gen_c
=20
 static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
 {
-	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
+	return tracing_gen_ctx_irq_test(0);
 }
 static inline unsigned int tracing_gen_ctx(void)
 {
-	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
+	return tracing_gen_ctx_irq_test(0);
 }
 #endif
=20
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -460,7 +460,7 @@ int trace_print_lat_fmt(struct trace_seq
 		(entry->flags & TRACE_FLAG_IRQS_OFF && bh_off) ? 'D' :
 		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' :
 		bh_off ? 'b' :
-		(entry->flags & TRACE_FLAG_IRQS_NOSUPPORT) ? 'X' :
+		!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_SUPPORT) ? 'X' :
 		'.';
=20
 	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED |
