Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41982D5436;
	Mon, 29 Sep 2025 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759140793; cv=none; b=g3XgW+ziWGDj4mUOp9qFIncgMlAPDXFJXycLGhIPNCU7fJJI9gvOErOEIdjlGEkvr4tE0ps9lVFwbg7upJ5hLCJjrbQbXrjtC3VFmpqLJnWUyHyD6Nr3E2ymNr8dkSQAplUQXWYN3dYgaiDyBaUXYPzUEFOdnmZ9Xm8BPItQ2Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759140793; c=relaxed/simple;
	bh=5TJ7rXc9PceY5+Uq+nP+sm9j3Ynhc3o6j6tQt62kVEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhB/sWz/YuuWmFQeSvMbinVyKWXhmabxYmD5vRx+JSFO7HcaGPltrVIbayTzwxvjaQQPjEiutOQPc27Dz+cqbek9c/e3iVwf4wKWcINH4n9A8r0+dW8OG7EP8TVJALpDVdx5wKtnwDLpKhm0RQwFSEtPdCzrScFRCp1hW81FYHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=drTFvnbL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="drTFvnbL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tXmRHJ8HqJUwPcuCeHwLbY1HiJTJxK6IF+F+zlaEzHU=; b=drTFvnbL+hJI5lOYlNL2eHaO9X
	WnQws3KA0w2wuerQ7uvB08r/SHgYh9x0EjnEUb4I1HrPp7TD8Ws//UsPvAvkeibZ8/rzy8Js4hZso
	tJ0qYFR6HpXGnYHGEha6KzCRy9ThyAigfdiVwyIqHJY9ra3gFGOtVB0S1Fm2UsI0rrgpOEP09wmt7
	6Vg8wrUokt8dwL8KdyjjELyZwlRGBz4Rxo1Om3xtyjatNdrsdwtrVf2KUcm7nRUvTK06Eg7fQCwHk
	kUQsePcvUbwA9k+bLeIi5aMymMN+fcLBKFsDPz50oEfPMel5/GcVYxdQdC383EYEe3g4OnAK8VAmq
	POj5K4cA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3AsQ-0000000BzB0-3paa;
	Mon, 29 Sep 2025 10:13:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D4280300359; Mon, 29 Sep 2025 12:12:59 +0200 (CEST)
Date: Mon, 29 Sep 2025 12:12:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, chenyuan_fl@163.com,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Yuan Chen <chenyuan@kylinos.cn>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] tracing: Fix race condition in kprobe initialization
 causing NULL pointer dereference
Message-ID: <20250929101259.GE3245006@noisy.programming.kicks-ass.net>
References: <20250929143916.5984441b32e6f84618b4deb8@kernel.org>
 <20250929065731.1351028-1-chenyuan_fl@163.com>
 <20250929044836.7169d5be@batman.local.home>
 <84seg5d2p3.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84seg5d2p3.fsf@jogness.linutronix.de>

On Mon, Sep 29, 2025 at 11:38:08AM +0206, John Ogness wrote:

> >> Problem:
> >> 1. CPU0 executes (1) assigning tp_event->perf_events = list
> 
> smp_wmb()
> 
> >> 2. CPU0 executes (2) enabling kprobe functionality via class->reg()
> >> 3. CPU1 triggers and reaches kprobe_dispatcher
> >> 4. CPU1 checks TP_FLAG_PROFILE - condition passes (step 2 completed)
> 
> smp_rmb()
> 
> >> 5. CPU1 calls kprobe_perf_func() and crashes at (3) because
> >>    call->perf_events is still NULL
> >> 
> >> The issue: Assignment in step 1 may not be visible to CPU1 due to
> >> missing memory barriers before step 2 sets TP_FLAG_PROFILE flag.
> 
> A better explanation of the issue would be: CPU1 sees that kprobe
> functionality is enabled but does not see that perf_events has been
> assigned.
> 
> Add pairing read and write memory barriers to guarantee that if CPU1
> sees that kprobe functionality is enabled, it must also see that
> perf_events has been assigned.
> 
> Note that this could also be done more efficiently using a store_release
> when setting the flag (in step 2) and a load_acquire when loading the
> flag (in step 4).

The RELEASE+ACQUIRE is a better pattern for these cases. 

And I'll argue the barrier should be in 2 not 1, since it is 2 that sets
the flag checked in 4.  Any store before that flag might be affected,
not just the ->perf_events list.
