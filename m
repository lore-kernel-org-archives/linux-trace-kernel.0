Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0757180A76;
	Wed,  9 Oct 2024 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728471441; cv=none; b=ftj4CiM+Lh51bdUBTS6ApqTSQcBuoGJwowWacpSSBKC9A724TxQ8Nt7+tL1Rz4aFXqHugdbfG5gAt3ZLND1tIkbdY4TrG41Ao2KybGdwS4KyGkol3HvP2+00O8kRo/59gO2//k55q1xQePPUwWoXmWtZrkf73W4eCVzHB2LQZd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728471441; c=relaxed/simple;
	bh=MRWe4v3iRf0x+zLdvJD/jJXYRhsIOHffPOS/tq1/X/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEBRs2uKeS05YP3h/HtQ7nrYYZ3INZOZn4v1w7r5hreh1riI5VIkmP9DPdiIX9vgx2QvIy4CH4n7FVg1QuoKjQU+cdBFjxwy9EfeB2/KQwPxqJSrGvav463bzaDiXVy25xxvp123vJeGh5EpTUHFx7tfFxOtbWgLk3I2m12O8dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Ll5+CQr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YO5pKMjQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Ll5+CQr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YO5pKMjQ"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728471438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3+l3+7pthbE+Am32bY9lcPp06P12lLOcWwdrOwYwkoI=;
	b=2Ll5+CQrPsTB2JuFBRCchw1c/b20akfmvTzD07nBqMtA0rtf9T+3TgydhXTJa8RSogKpt5
	YnFwFZODbuqb0b2NWtXaJarW+dZFsubjaqB99Z8UpLCMN2wDkdfdj0j6e/gqmBVpbhfXC9
	z7X204qJmp6GjwsULSDflRpYYhX+JlBv4sN94ZZk4wPM5CDP2h4y7LgeFA8dSz1/SigV27
	XNNOaHiUaVCd9hH8ayV6hFd2w8xSA+8Lb55orD8T2sS2lqCunIGuR/lEtGFAAVnPkvL/Jp
	jBBkmiMwoi3qwbUMrpF7rxDXuHAU0WhsGexaTVEdF3H1lw6G5wGTy6pttyVCbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728471438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3+l3+7pthbE+Am32bY9lcPp06P12lLOcWwdrOwYwkoI=;
	b=YO5pKMjQcWcbEVXFQfjyZ1qgeyKzKQw5XdctkHpUNFMiyPL/IFdEdsse8zdP0RAGdLJHxx
	Rj40OZpSAZv2TjDQ==
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
Subject: [PATCH 2/3] tracing: Record task flag NEED_RESCHED_LAZY.
Date: Wed,  9 Oct 2024 12:50:56 +0200
Message-ID: <20241009105709.887510-3-bigeasy@linutronix.de>
In-Reply-To: <20241009105709.887510-1-bigeasy@linutronix.de>
References: <20241009105709.887510-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The scheduler added NEED_RESCHED_LAZY scheduling. Record this state as
part of trace flags and expose it in the need_resched field.

Record and expose NEED_RESCHED_LAZY.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/trace_events.h |  1 +
 kernel/trace/trace.c         |  2 ++
 kernel/trace/trace_output.c  | 14 +++++++++++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index d5c0fcf20f024..4cae6f2581379 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -185,6 +185,7 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs=
_status);
 enum trace_flag_type {
 	TRACE_FLAG_IRQS_OFF		=3D 0x01,
 	TRACE_FLAG_NEED_RESCHED		=3D 0x02,
+	TRACE_FLAG_NEED_RESCHED_LAZY	=3D 0x04,
 	TRACE_FLAG_HARDIRQ		=3D 0x08,
 	TRACE_FLAG_SOFTIRQ		=3D 0x10,
 	TRACE_FLAG_PREEMPT_RESCHED	=3D 0x20,
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1c69ca1f10886..29d7703751aa9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2544,6 +2544,8 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int ir=
qs_status)
 		trace_flags |=3D TRACE_FLAG_NEED_RESCHED;
 	if (test_preempt_need_resched())
 		trace_flags |=3D TRACE_FLAG_PREEMPT_RESCHED;
+	if (tif_test_bit(TIF_NEED_RESCHED_LAZY))
+		trace_flags |=3D TRACE_FLAG_NEED_RESCHED_LAZY;
 	return (trace_flags << 16) | (min_t(unsigned int, pc & 0xff, 0xf)) |
 		(min_t(unsigned int, migration_disable_value(), 0xf)) << 4;
 }
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 829daa0764dd9..23ca2155306b1 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -463,17 +463,29 @@ int trace_print_lat_fmt(struct trace_seq *s, struct t=
race_entry *entry)
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
--=20
2.45.2

