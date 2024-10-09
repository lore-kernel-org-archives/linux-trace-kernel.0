Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07AE18BC36;
	Wed,  9 Oct 2024 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728471441; cv=none; b=tQ6Nk6WKr1qVWOrCFAZLTdFmjvaGA0+iDWJf9FxQYCFj65rNWQUYYqcMK0K0xbuAdhhkiEddXVJqAujNy/QR8rLs2Bh9P8G58TD7tGWv7K8H5veOWnMvWir+1FfRM7RBynMi79ozpHalNcTanbOxPcRGASmzDkIUQMstRRLY+XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728471441; c=relaxed/simple;
	bh=iDWYBrHg5qqjQYVFOvq/CNnwptF+1Qmy7B+kHS/CRMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYdwxUpjhgiWXfO9iZgq9xFv/sdhuRAZc5zGx3QFaAs7HjtSh4YQ+9zFRC4JYuNPF7teWajOkeWyCgVAAF2fKLukfIsptMTnWZRdAeVxOY3/nOqVFA9nPo/MVJXQGiue401KwA3xXiP8c4hLGpxnyw5yFFpfjlLgkh5OjUn+Dy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3xRPp7Z5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rvCec705; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3xRPp7Z5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rvCec705"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728471438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7xZ9AA5APDuKqSLhS5SMXynjCeDZ/YuZZ8AnHRWQU8=;
	b=3xRPp7Z5dbOwZznCmoE1hGomYc6c8I0cuBoaKnr1UJLvC6aAczdXwYUWJLclPG9rlrBToG
	nWP1dWo2mRAK4xA16pB4Grq3BVo+OQns3kHakl/LkAHhKi1ooR/p3kgyU7iJ54gwXYdXDs
	FrdyjAz9j7DowypFk4A2CBbmowspQtKfq178b+RcVahKPrGP3sVqVFIqENecZKJCyumfG7
	QFlf2j43xeAKjlkmz0jGKZPNujDajfuFAkW3jFr5BLRFhEIXa2WjAsxKrEfogplxhxKDPQ
	lKshchz/U1EjBqpyo/xjl7m5/9QJtqRXj9xuMbanGHIuz9gHAac21uICjK82bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728471438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7xZ9AA5APDuKqSLhS5SMXynjCeDZ/YuZZ8AnHRWQU8=;
	b=rvCec7054qrXJ+ZzLeQG0Nj1CQh4cmBKyKMBG9/1SPPviVEsSM3zNF29vM4+sExGf2+kTx
	p8wO38M7e+nrogDQ==
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
Subject: [PATCH 1/3] tracing: Replace TRACE_FLAG_IRQS_NOSUPPORT with its config option.
Date: Wed,  9 Oct 2024 12:50:55 +0200
Message-ID: <20241009105709.887510-2-bigeasy@linutronix.de>
In-Reply-To: <20241009105709.887510-1-bigeasy@linutronix.de>
References: <20241009105709.887510-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/trace_events.h | 7 +++----
 kernel/trace/trace_output.c  | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 42bedcddd5113..d5c0fcf20f024 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -184,8 +184,7 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs=
_status);
=20
 enum trace_flag_type {
 	TRACE_FLAG_IRQS_OFF		=3D 0x01,
-	TRACE_FLAG_IRQS_NOSUPPORT	=3D 0x02,
-	TRACE_FLAG_NEED_RESCHED		=3D 0x04,
+	TRACE_FLAG_NEED_RESCHED		=3D 0x02,
 	TRACE_FLAG_HARDIRQ		=3D 0x08,
 	TRACE_FLAG_SOFTIRQ		=3D 0x10,
 	TRACE_FLAG_PREEMPT_RESCHED	=3D 0x20,
@@ -211,11 +210,11 @@ static inline unsigned int tracing_gen_ctx(void)
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
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 868f2f912f280..829daa0764dd9 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -460,7 +460,7 @@ int trace_print_lat_fmt(struct trace_seq *s, struct tra=
ce_entry *entry)
 		(entry->flags & TRACE_FLAG_IRQS_OFF && bh_off) ? 'D' :
 		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' :
 		bh_off ? 'b' :
-		(entry->flags & TRACE_FLAG_IRQS_NOSUPPORT) ? 'X' :
+		!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_SUPPORT) ? 'X' :
 		'.';
=20
 	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED |
--=20
2.45.2

