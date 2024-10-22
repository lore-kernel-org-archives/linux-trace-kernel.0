Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB4319538D;
	Tue, 22 Oct 2024 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729594880; cv=none; b=NWAatVRr/GixmUEaGtCB769VU0aEEc+Ex9i2q8mK7XzKLIYz8KP9Mcl4anyaBRe4znWu5mjVJ2fpER7ie+Y1oK0jQ29jPyR7rcuRlWsOP42skaLRxS8rCfzN2H25cQeG4WsUmp1q4onzRx2oY08g4G/0OVxv/BJHuWA36eLHI3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729594880; c=relaxed/simple;
	bh=HVkSqnGOBpsqQO1xHCUF3g/eS3YtpU/pW0Qa2VQhcVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UD0mSW/uFfNjY474mBbUjxoG43hcsuzENjb7QXZaE4rm06isW0sVwrGLp4/aXqRCIBikqu8N7H3ZMD2tZxYqOAeKKbG4NKxua3YXcDOadguZkBx7zg+8uD+ZMhkTs56ffUq1dOKsnXpYbry+D0sG5n/8sF8jI3BgHzfJ0l+UzW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aOuoyCDT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=55dRDKH9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aOuoyCDT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="55dRDKH9"
Date: Tue, 22 Oct 2024 13:01:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729594876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MxWE8Uynb/jxx/OThMKkflP3dXRyCIEezsyO4Jj/tDM=;
	b=aOuoyCDTCtzYrSC7zWBIvNccKev0DfTTHileph1IOMFgoXm/tGslE2qedbli9Kwy2KDGeO
	ipkCUtta6hWFn5kIBSfk2RHl9hzwd/ma1wrsfIxnt0KQBGl9rnsx30zL92r4dyTsTOlyEZ
	3oaetfZLyEJR1/brlALLaxTmHi5q/nC2vY5WHTpGqX04IKd3b3fqKdX8K1kXJy+LZZvhqN
	+1tHVxXEoholOyqpEy5i45kJPxCTfURDKAZSF5QtrsW7e7Oo418mQpHO9TaXVsqcW5zpKE
	iQFVpRUNz6BnuwKuffJHXQIfJeU+M+RAbSAAbH21D3vIpPQfJE3h6/iUCKoxew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729594876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MxWE8Uynb/jxx/OThMKkflP3dXRyCIEezsyO4Jj/tDM=;
	b=55dRDKH9DtGUzOIo5theAQ35TpeMQ8seadi4YfHOPmJDy0wIlthYeKZxBONVHToZf5hbp2
	rRDevhZkVN3Jx+Bw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
	mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, ankur.a.arora@oracle.com, efault@gmx.de,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Remove TRACE_FLAG_IRQS_NOSUPPORT
Message-ID: <20241022110112.XJI8I9T2@linutronix.de>
References: <20241021151257.102296-1-bigeasy@linutronix.de>
 <20241021151257.102296-2-bigeasy@linutronix.de>
 <20241022031418.12154e63@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022031418.12154e63@rorschach.local.home>

It was possible to enable tracing with no IRQ tracing support. The
tracing infrastructure would then record TRACE_FLAG_IRQS_NOSUPPORT as
the only tracing flag and show an 'X' in the output.

The last user of this feature was PPC32 which managed to implement it
during PowerPC merge in 2009. Since then, it was unused and the PPC32
dependency was finally removed in commit 0ea5ee035133a ("tracing: Remove
PPC32 wart from config TRACING_SUPPORT").
Since the PowerPC merge the code behind !CONFIG_TRACE_IRQFLAGS_SUPPORT
with TRACING enabled can no longer be selected used and the 'X' is not
displayed or recorded.

Remove the CONFIG_TRACE_IRQFLAGS_SUPPORT from the tracing code. Remove
TRACE_FLAG_IRQS_NOSUPPORT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
On 2024-10-22 03:14:18 [-0400], Steven Rostedt wrote:
> So this can't even be built without TRACE_IRQFLAGS_SUPPORT!

What about this as a first step? This bit was not used since 2009.

 Documentation/trace/ftrace.rst |  3 ---
 include/linux/trace_events.h   | 13 -------------
 kernel/trace/trace_output.c    |  1 -
 3 files changed, 17 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 4073ca48af4ad..74d5bd801b1a8 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1031,9 +1031,6 @@ explains which is which.
   CPU#: The CPU which the process was running on.
 
   irqs-off: 'd' interrupts are disabled. '.' otherwise.
-	.. caution:: If the architecture does not support a way to
-		read the irq flags variable, an 'X' will always
-		be printed here.
 
   need-resched:
 	- 'N' both TIF_NEED_RESCHED and PREEMPT_NEED_RESCHED is set,
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 42bedcddd5113..467dadb990cbe 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -184,7 +184,6 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status);
 
 enum trace_flag_type {
 	TRACE_FLAG_IRQS_OFF		= 0x01,
-	TRACE_FLAG_IRQS_NOSUPPORT	= 0x02,
 	TRACE_FLAG_NEED_RESCHED		= 0x04,
 	TRACE_FLAG_HARDIRQ		= 0x08,
 	TRACE_FLAG_SOFTIRQ		= 0x10,
@@ -193,7 +192,6 @@ enum trace_flag_type {
 	TRACE_FLAG_BH_OFF		= 0x80,
 };
 
-#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
 static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
 {
 	unsigned int irq_status = irqs_disabled_flags(irqflags) ?
@@ -207,17 +205,6 @@ static inline unsigned int tracing_gen_ctx(void)
 	local_save_flags(irqflags);
 	return tracing_gen_ctx_flags(irqflags);
 }
-#else
-
-static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
-{
-	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
-}
-static inline unsigned int tracing_gen_ctx(void)
-{
-	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
-}
-#endif
 
 static inline unsigned int tracing_gen_ctx_dec(void)
 {
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 868f2f912f280..2ee6613dce6dc 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -460,7 +460,6 @@ int trace_print_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
 		(entry->flags & TRACE_FLAG_IRQS_OFF && bh_off) ? 'D' :
 		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' :
 		bh_off ? 'b' :
-		(entry->flags & TRACE_FLAG_IRQS_NOSUPPORT) ? 'X' :
 		'.';
 
 	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED |
-- 
2.45.2

