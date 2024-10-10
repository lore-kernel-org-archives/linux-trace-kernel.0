Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9400829AF;
	Thu, 10 Oct 2024 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728557776; cv=none; b=PKrU63UsDY4oQGU4+n1h22hKZnps4NIMK+uBwebjC/+qSUwM0Cxdqognt88FOEgINENgqqRFddhIjFDQ7EREbQ8HqXpbMN9DtxzUedQNzu8oTsbDkmpov1xXZ5G36Ol8YTl5qHaWB+cnpFYrTZFJqphEJ0vqymlOJ6uvaGcnht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728557776; c=relaxed/simple;
	bh=sM/WpCGRUFat8NJ8Aj7W8AxtMjWtIcKJ2XFfTMtncT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLkG9MPCEfMZn0Sdemwm6e8oCgelDgqe/Es/geSIkJ3gx4B3+snNpcA9in4kO8omag+Ig+XrhNAtRA+rC5yJAazsTUgraBfqsHMqD/f3HIQwfYenVUn2XfgaXVMsfwxI0/wT/XNTW7FhjHNPdGHtmLU8jd27tL+Z8HIWRaIjYv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YAhC9fwP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RkIsZK1z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YAhC9fwP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RkIsZK1z"
Date: Thu, 10 Oct 2024 12:56:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728557772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2h+cf/fY+xugXV5EJ6YNiysYlAKXMnFhqgcdS4IEblg=;
	b=YAhC9fwPgC/4FrBt5yq4FbjTel1N3mXX2/Fl6np5nBfp479zEHKMnZ5ZjzZ0FhkD8hwzbj
	Q7+iFmrVAb/EC9DaEkilOTb4ptYGfEUR/K0TRQEn9W/yWOF2uN6zmYsRh8y0U6lDNr+FMD
	yAFJUECjO4bDiGZhqMvCtArqzC+8YU1ZLh7ce+HY906gu7tY1WvX06zzxi2kS/V/lZZAMM
	KenDTWve72VXyAd1Vm816y6rusMQGc/3b/kTeb1L60eETDS7KHwgniLzwwClqXvYlsp2uG
	KDKryKg4ANBnouFnu85jiJaJNZqxclh2joyiM4Y7uZL3O9sT3+EV0w2ikl6lbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728557772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2h+cf/fY+xugXV5EJ6YNiysYlAKXMnFhqgcdS4IEblg=;
	b=RkIsZK1zyUHiLWNpg4Nh3Hr8YsNQv6E2KXdmYwBvuZ4bfBGHau47Lyy7UnSEv0efPCzQqD
	RqSgSTQOn9n5mPBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
	mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, efault@gmx.de,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/3] tracing: Record task flag NEED_RESCHED_LAZY.
Message-ID: <20241010105611.VArhcxcr@linutronix.de>
References: <20241009105709.887510-1-bigeasy@linutronix.de>
 <20241009105709.887510-3-bigeasy@linutronix.de>
 <87iku1b2vf.fsf@oracle.com>
 <20241009133328.23fc671c@gandalf.local.home>
 <87bjztaz7e.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bjztaz7e.fsf@oracle.com>

On 2024-10-09 11:49:41 [-0700], Ankur Arora wrote:
> > So this should be:
> >
> > 	if (IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY) &&
> > 	    tif_test_bit(TIF_NEED_RESCHED_LAZY))
> >
> > ?
> 
> Yeah, exactly that.

Okay, this makes sense, this is what I ended up with:

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index d5c0fcf20f024..4cae6f2581379 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -185,6 +185,7 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status);
 enum trace_flag_type {
 	TRACE_FLAG_IRQS_OFF		= 0x01,
 	TRACE_FLAG_NEED_RESCHED		= 0x02,
+	TRACE_FLAG_NEED_RESCHED_LAZY	= 0x04,
 	TRACE_FLAG_HARDIRQ		= 0x08,
 	TRACE_FLAG_SOFTIRQ		= 0x10,
 	TRACE_FLAG_PREEMPT_RESCHED	= 0x20,
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1c69ca1f10886..fb839d00aad12 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2544,6 +2544,8 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
 		trace_flags |= TRACE_FLAG_NEED_RESCHED;
 	if (test_preempt_need_resched())
 		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
+	if (IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY) && tif_test_bit(TIF_NEED_RESCHED_LAZY))
+		trace_flags |= TRACE_FLAG_NEED_RESCHED_LAZY;
 	return (trace_flags << 16) | (min_t(unsigned int, pc & 0xff, 0xf)) |
 		(min_t(unsigned int, migration_disable_value(), 0xf)) << 4;
 }
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 829daa0764dd9..23ca2155306b1 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -463,17 +463,29 @@ int trace_print_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
 		!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_SUPPORT) ? 'X' :
 		'.';
 
-	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED |
+	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY |
 				TRACE_FLAG_PREEMPT_RESCHED)) {
+	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
+		need_resched = 'B';
+		break;
 	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_PREEMPT_RESCHED:
 		need_resched = 'N';
 		break;
+	case TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
+		need_resched = 'L';
+		break;
+	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY:
+		need_resched = 'b';
+		break;
 	case TRACE_FLAG_NEED_RESCHED:
 		need_resched = 'n';
 		break;
 	case TRACE_FLAG_PREEMPT_RESCHED:
 		need_resched = 'p';
 		break;
+	case TRACE_FLAG_NEED_RESCHED_LAZY:
+		need_resched = 'l';
+		break;
 	default:
 		need_resched = '.';
 		break;
-- 
2.45.2


Sebastian
