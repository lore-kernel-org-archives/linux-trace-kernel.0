Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864B3157A43;
	Tue, 16 Jul 2024 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121547; cv=none; b=Byhq0sz7mrC7zuzP0UZsKOgOFiS+Kq3ViJONKBpIY02r7aisVyvV7isWygwZY4cOW3ZLGPfYIR8gWDWqKwixd5iTJZjpymYSz4mRjFS5azhK7Ni3axVwD69DwlIYAkKbg0gEvTFta9a3RiJ07Vh3JsAknwuiOSNOJdXJRub6xco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121547; c=relaxed/simple;
	bh=K8r96+NWXM9HvACg9ptDl+CrQpKzGn68GkYyfetMe1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5TkZ5feMuQIAtPsdJc0Z83npuHH86YIxggUv7T74yTmpITswwDR5oVOMIKdRM7q98QDwgUXnusipvBO56yBjQgAVtPhz62TlR2ffmzHMVQJ6FZdQ4+/8ZdLRg8KF96XvDatnnP1JZsDZHztSqnCeIHyc9AHkyg/P+XXhkO4KpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q9BYATXO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q9BYATXO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ar6ntNI1eFIpMIWTyK9TL2PHcE8HFBjg+tUUhYe8r28=; b=q9BYATXOq9EAT9t+HmMfI28VP1
	wtThkq5hKkJ/Q9emhJBaxobyROhVF5sELkAlt7qqIE/VPpMzuY3MOTXOfsOSDju8BLBqkO1wPDiHV
	fuPSm+Ka2Nc+bzByIPzFLZ5e75gDSUy7G8pLE+28HUYDu1bKjXZ054yHPzB/JimZlNkLnEXuugMrh
	GcUOkYmovIqKWsh5ZoZ0ZHsWqHvYArrYioiHPUTRDasJe/A6LrX4zRxMx5vAsHgV+pMXuhG+3bGm5
	1/2my1SdjHDfo1bZsGijuQmeqwH8bKaAw9bwmym3QweDt7xgX9BscIdLC50DuHbIlHl9nzdZc20fF
	YS3DSk2A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTeKi-0000000GvQS-366o;
	Tue, 16 Jul 2024 09:18:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F346F300694; Tue, 16 Jul 2024 11:18:51 +0200 (CEST)
Date: Tue, 16 Jul 2024 11:18:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tio Zhang <tiozhang@didiglobal.com>, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	vineethr@linux.ibm.com, akpm@linux-foundation.org,
	mathieu.desnoyers@efficios.com, mingo@kernel.org,
	mgorman@techsingularity.net, qyousef@layalina.io,
	vincent.guittot@linaro.org, elver@google.com, zyhtheonly@gmail.com,
	zyhtheonly@yeah.net, Juri Lelli <juri.lelli@gmail.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH 1/1] tracing/sched: sched_switch: place prev_comm and
 next_comm in right order
Message-ID: <20240716091851.GC26750@noisy.programming.kicks-ass.net>
References: <20240703033353.GA2833@didi-ThinkCentre-M930t-N000>
 <20240715150412.655abdda@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715150412.655abdda@rorschach.local.home>

On Mon, Jul 15, 2024 at 03:04:12PM -0400, Steven Rostedt wrote:
> 
> [ Adding sched maintainers, as this is a scheduling trace event ]
> 
> On Wed, 3 Jul 2024 11:33:53 +0800
> Tio Zhang <tiozhang@didiglobal.com> wrote:
> 
> > Switch the order of prev_comm and next_comm in sched_switch's code to
> > align with its printing order.
> 
> I'm going to pick this up in my tree, as it is pretty much a nop. It's
> just changing the ordering of the assignments of the comm names so that
> the copy of prev_comm is with the updates to the prev_fields, and the
> next_comm is with the updates to the next fields.

Right, have at. very close to a whitespace patch.
