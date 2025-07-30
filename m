Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A83513AD38;
	Wed, 30 Jul 2025 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888703; cv=none; b=SLDru6e1+rj9uFnV7/sw7I9O/MBNGolWD7Q7kzuygyA0GxzG1fs0oemFrlFz/9ALEPaeCsfnoPE50BA1bbz1bCS+1CbzioCVYvNHdYtWDr8xdHmjQSbAQ+4S9glyUoyvRBHSTosrjPWSL76PxZxcU/kmh3eQ4TKVhBa3pCQ3Xd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888703; c=relaxed/simple;
	bh=kzz6rxfN+Fgy4xuTgWtE9bGnLrdoXXgMDbz0lnfvswA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czvxKOpBrVWtocdusANSwp/S8YUH8imit24jobWOWBVTBR9YCsOFL6kMbC1YkFwc8kjW02rY9135CVvWmf1ncURgOzwXbgPF7L3OtIzagwIilpJBQoN3+VmGVJEHFQxUbbYevxZZ07fpCRmgZSwYqlC1n+ZcFmPYIWa8nOT6GEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nc01vCO6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e1hqUMOS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nc01vCO6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e1hqUMOS"
Date: Wed, 30 Jul 2025 17:18:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753888700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A3gZrMeoDLZoxHHiM7qzk4/zQZah7/LS2/SAvFh22+E=;
	b=nc01vCO6ihLSn47cphSiDdud9wInqMksz97KjNwLzwcrBtziU7DXav9jSiuooLVb4W9BlO
	JQEnvd1l6e5G03lrcdfr+9TKiYx/4U8rMixb71BMRfslRBU5QX3xtvZN1a1yJPaHucKLc2
	yrmPy2C0EKKcb3lizu6q0w1QhZgboiRkYg0AykwdnI23QMEDir/juMUCZcO8mF3zDF5Hav
	5IUZgQc6EcPPkpMmlO+5KjgCFRIPgo6Vx8Ir49je7hzY4bf5E+XgNtBnw1Vz67uBs1Fyo1
	xGJnizriemMLGPBs/AeoXGs4CRS0y4sKCD9qy23J65bLUwnjV9uk48jVKdPSdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753888700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A3gZrMeoDLZoxHHiM7qzk4/zQZah7/LS2/SAvFh22+E=;
	b=e1hqUMOSlAX+ADhdO/e7vlpx8sq3gscQGo1ygG2VSYtN7JKyUOL6q/KW8Tuc2AIPIajfq0
	AmVKIopd7fjCB9Bw==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH 4/5] sched: Add rt task enqueue/dequeue trace points
Message-ID: <20250730151818.7RemAREO@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
 <8f83869a5040bd7cd3096bd12090c1ab110ae5c4.1753879295.git.namcao@linutronix.de>
 <767a9d59081220594d21856f329fb35988ef7925.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <767a9d59081220594d21856f329fb35988ef7925.camel@redhat.com>

On Wed, Jul 30, 2025 at 03:53:14PM +0200, Gabriele Monaco wrote:
> On Wed, 2025-07-30 at 14:45 +0200, Nam Cao wrote:
> > Add trace points into enqueue_task_rt() and dequeue_task_rt(). They
> > are useful to implement RV monitor which validates RT scheduling.
> > 
> 
> I get it's much simpler this way, but is it that different to follow
> the task's existing tracepoints?
> 
> * task going to sleep (switch:prev_state != RUNNING) is dequeued
> * task waking up is enqueued
> * changing the tasks's policy (setpolicy and setattr syscalls) should
> enqueue/dequeue as well
> 
> This is more thinking out loud, but I'm doing right now something
> rather similar with the deadline tasks and this seems reasonable, at
> least on paper.
> 
> What do you think?

I think more or less the same. The fewer tracepoints, the better. But the
monitor is way more obvious this way.

Let me see how hard it is to use the existing tracepoints...

Nam
