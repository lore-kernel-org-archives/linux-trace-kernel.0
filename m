Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792F3414DCA
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122117; cv=none; b=E5MgIVugqCYzC9RC5/xLnOtswKPGA/Kau6z+n9CL2wrC2jl1t1lqQMkfniAiOA3tzDdJlLIzUXUZP29hW+DET20A0ZzMGpY6evsPPDkzGGmPH/gG7GbtqNJCHldnYW7Y7copGPhcqRMCGRK0cvfmP2NZ4e3RRxBdoU/+/kBaLVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122117; c=relaxed/simple;
	bh=qw011LRouAvatOm0UiGZNDiGqsaC7P6Tf+LSQCU/DNc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UeoxncxrWb9JxX+XbVQ/O0JGx7T6r4l+4j46ZqQOQWvxZbsdza3eGoAiDvLS3+JEjo6VdjAPK5g+KVTQSsLy1LZKxFyI5bZGGEr/eSVg4HACtIOVODmTm5sXV9smJr919f66euEi4iEt+MD7W84HhRw7RoHTAd7Wqlg0L42P6jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=187WImQH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2aw0AV4d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="187WImQH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2aw0AV4d"
Date: Fri, 11 Sep 2026 12:21:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789122113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=xcUoo+iiMhZ6ySO0Df1FVUgoMnP8vC08X30Kb/Le3Ls=;
	b=187WImQHlS575JMo7FJ0QyKzLgxD6GL+oyJ7lYt6I5R9Q//NNBTDDU5KK9JnffATbNAPeF
	rKeZEgmuriV3qoaIWSxq1twoJ1pFtq0vvX0l3+xkhuan1H5y6MxHva9uBX0LnyW/DRfOAy
	aLuKQDLtPsQNPvmKtrYZwRTQXrWUmVeqNB+M4MxWg2UdJlTIpxqGZ7FUWbWaWIZLVV3+l4
	obQaC8zryUtrTHA6Ny+ygj8rCZ1byG5Gg8sz1WBwnLgj48rj6tQ5FvM7UD2Vuk5oPfWqar
	4QMaGudN1h9XTnjGfmzxRgDvt3IfYckjhwmsM9JLApA7u7zuzR8MBgEtts+goA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789122113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=xcUoo+iiMhZ6ySO0Df1FVUgoMnP8vC08X30Kb/Le3Ls=;
	b=2aw0AV4dX/GQaYkYhDctDadL6S0lhSuIjb66lquJg1d4gUQNdAmDgx/wyQ2AGboh88nB57
	Gfmg+llJ93+JYNBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>
Subject: [PATCH] ring-buffer: Acquire the lock with irqsave in
 rb_wake_up_waiters()
Message-ID: <20260911102152.YEtwkBj9@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

rb_wake_up_waiters() is a irq_work callback which is initialized with
init_irq_work(). As such it will be invoked in thread context on
PREEMPT_RT. Invoking the callback in IRQ context on PREEMPT_RT is not an
option due its usage of wake_up_all().
Since this callback may run in thread context, it needs to acqurie
ring_buffer_per_cpu::reader_lock with disabling interrupts and may not
assume that they are disabled.

Use raw_spinlock_irqsave() to acquire ring_buffer_per_cpu::reader_lock.

Fixes: 68282dd930ea3 ("ring-buffer: Fix resetting of shortest_full")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/trace/ring_buffer.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9c03a555a6ba2..681f9daf6fabb 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -904,14 +904,13 @@ static void rb_wake_up_waiters(struct irq_work *work)
 		struct ring_buffer_per_cpu *cpu_buffer =
 			container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
 
-		/* Called from interrupt context */
-		raw_spin_lock(&cpu_buffer->reader_lock);
-		rbwork->wakeup_full = false;
-		rbwork->full_waiters_pending = false;
+		scoped_guard(raw_spinlock_irqsave, &cpu_buffer->reader_lock) {
+			rbwork->wakeup_full = false;
+			rbwork->full_waiters_pending = false;
 
-		/* Waking up all waiters, they will reset the shortest full */
-		cpu_buffer->shortest_full = 0;
-		raw_spin_unlock(&cpu_buffer->reader_lock);
+			/* Waking up all waiters, they will reset the shortest full */
+			cpu_buffer->shortest_full = 0;
+		}
 
 		wake_up_all(&rbwork->full_waiters);
 	}
-- 
2.55.0

