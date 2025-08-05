Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319FE286434;
	Tue,  5 Aug 2025 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408725; cv=none; b=tEefWvqBz6NM5Y4dw27gVqqt0SgOdwLcnT3NLSL26XZGB3AG/ksGk8x2Wu8+fTAZRu7K8mqK3fFRXUf9Tfh1LS2p/y4EqceETgIUEWoycjSAtm6LPACmL3/r+M8Dm9ohtKKWWzVZYxqaGFFaYG8QOQksQxXBnqU0tTa08SJbbQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408725; c=relaxed/simple;
	bh=HoxdE6jwa3liY1NRo15slzQzMH7KqknqK+hG56lQ8HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ouw80B9zwDGFg5lmFF4gxzsShw30qbtpH4yKX+d2C3k+C7cEG8LNPwu2iUhPID69RecQBUYcCaVMgNlLnbVbVbFnkSG+JU50YMi+ZA1qmn4zSLoL1xXcJaYid+G67U+/Ra8dV9A2ovsuSRk0zxTt1g8sGNIKFJlKLaPpICa8QUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lduXrDup; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aJNh4Gl4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lduXrDup";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aJNh4Gl4"
Date: Tue, 5 Aug 2025 17:45:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754408721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4rfhcJ52gaQkFE1q/jWz1hzPvkEMrx0BQFf5ulaRXc=;
	b=lduXrDupwYh0a+DXp4SpGDoRm32XfU1qB3Mr/7fTkOO+coFkL7iClkpF7x5iW9FBNtCuJY
	SOzoKi7fat3H1jtOn2lcigu8/hm3n2gPvIm88xGProB5obl6TvEgWaG9W5CBkkz9Gxs1gD
	FGycOY7g8vfZtSwB4vffhdzMT1LhzMN3gk5R2uUoC4iaSWJhqf+EgkiZLPeVyXXSoqWVIh
	fQi0DmmarY5sRwoDgf8Gy+CYdZnNQKu8PqtS/gmV7XLfRewc8Iu1YPyve1bcz1qWounjsK
	BKudImcYnzG46QIclW8rJ55qbUG4INCO7so0QWQPtMc0PKyUVxgYmZ4HvLlNgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754408721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4rfhcJ52gaQkFE1q/jWz1hzPvkEMrx0BQFf5ulaRXc=;
	b=aJNh4Gl4q4S13mS1zPP5SX51bFIJ9hsuAUECIr3NoKnCqp4UyB4Ve+y83w+a8rVIXWRKZF
	zXSj8L67UV4SnOCg==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] rv: Add rts monitor
Message-ID: <20250805154515.CchJtec3@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
 <20834b8fcd4dfe75642cec2097e29f4c636a33fb.1753879295.git.namcao@linutronix.de>
 <b3499e8d79c2215b4fb765c0ceb5294f322efa3a.camel@redhat.com>
 <20250805122215.hXbwUchz@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250805122215.hXbwUchz@linutronix.de>

On Tue, Aug 05, 2025 at 02:22:17PM +0200, Nam Cao wrote:
> On Tue, Aug 05, 2025 at 10:40:30AM +0200, Gabriele Monaco wrote:
> > Hello Nam,
> > 
> > I just built and booted up the monitor in a VM (virtme-ng), the
> > configuration has preemptirq tracepoints and all monitors so far (as we
> > have seen earlier, it doesn't build if rtapp monitors are not there
> > because of the circular dependency in the tracepoints).
> > 
> > All I did was to enable the monitor and printk reactor, but I get a
> > whole lot of errors (as in, I need to quit the VM for it to stop):
> > 
> > [ 1537.699834] rv: rts: 7: violation detected
> > [ 1537.699930] rv: rts: 3: violation detected
> > [ 1537.701827] rv: rts: 6: violation detected
> > [ 1537.704894] rv: rts: 0: violation detected
> > [ 1537.704925] rv: rts: 0: violation detected
> > [ 1537.704988] rv: rts: 3: violation detected
> > [ 1537.705019] rv: rts: 3: violation detected
> > [ 1537.705998] rv: rts: 0: violation detected
> > [ 1537.706024] rv: rts: 0: violation detected
> > [ 1537.709875] rv: rts: 6: violation detected
> > [ 1537.709921] rv: rts: 6: violation detected
> > [ 1537.711241] rv: rts: 6: violation detected
> > 
> > Curiously enough, I only see those CPUs (0, 3, 6 and 7).
> > Other runs have different CPUs but always a small subset (e.g. 10-15,
> > 6-7 only 2).
> > It doesn't always occur but enabling/disabling the monitor might help
> > triggering it.
> > 
> > Any idea what is happening?

There are two issues:

  - When the monitor is disabled then enabled, the number of queued task
    does not reset. The monitor may mistakenly thinks there are queued RT
    tasks, but there aren't.

  - The enqueue tracepoint is registered before the dequeue tracepoint.
    Therefore there may be a enqueue followed by a dequeue, but the monitor
    missed the latter.

The first issue can be fixed by reseting the queued task number at
enabling.

For the second issue, LTL monitors need something similar to
da_monitor_enabled_##name(void). But a quick workaround is reordering the
tracepoint registerations.

So with the below diff, I no longer see the issue.

Thanks again for noticing this!

Nam

diff --git a/kernel/trace/rv/monitors/rts/rts.c b/kernel/trace/rv/monitors/rts/rts.c
index 473004b673c5..3ddbf09db0dd 100644
--- a/kernel/trace/rv/monitors/rts/rts.c
+++ b/kernel/trace/rv/monitors/rts/rts.c
@@ -81,14 +81,21 @@ static void handle_sched_switch(void *data, bool preempt, struct task_struct *pr
 
 static int enable_rts(void)
 {
+	unsigned int cpu;
 	int retval;
 
 	retval = ltl_monitor_init();
 	if (retval)
 		return retval;
 
-	rv_attach_trace_probe("rts", enqueue_task_rt_tp, handle_enqueue_task_rt);
+	for_each_possible_cpu(cpu) {
+		unsigned int *queued = per_cpu_ptr(&nr_queued, cpu);
+
+		*queued = 0;
+	}
+
 	rv_attach_trace_probe("rts", dequeue_task_rt_tp, handle_dequeue_task_rt);
+	rv_attach_trace_probe("rts", enqueue_task_rt_tp, handle_enqueue_task_rt);
 	rv_attach_trace_probe("rts", sched_switch, handle_sched_switch);
 
 	return 0;
