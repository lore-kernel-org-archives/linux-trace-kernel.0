Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F79199385;
	Wed, 11 Mar 2026 11:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230082; cv=none; b=Uy4BELDLcuvIJUd3JLxx/4eBTVs7KmJvH3vpw/HNixcNZLXeo6ZHbZD+UH/hZ+YN+4CpIZFd/3Y/0305lK4UltJeUusUqhVDsJlO1E0btKbBH5C37MCCJ3YMEqXlPPLbf5Pr3z8WwrSpkRnY2tbFidN053QucXbEvntmm6GM7ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230082; c=relaxed/simple;
	bh=EidTyh2bDPIk45jmCsXGDOwzqiBrVExrxIUDRR2fLt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osN7JodNzf5I5/KM8yp/ZbTv8JOSiDVdjjYfS4GIZ9qpRwj1ZNa2absj1OvTXZ4ndubiD3XchsC1EtAOgr+xenEE+xVexjtmIYauDMq/gm2KvuQICaVVjexKBYwfPRBxoX4Pcuhi0aEJ538UEBSDX7U+xECTEXQdaU+zhZYpecQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OBMvbDTM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OBMvbDTM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KWhGOAlEBCau0ZeASMxuQ5m1pl0GcEQs8QPIpJnbIzM=; b=OBMvbDTMalK5FwHgx/2kSjIO8w
	G6WsWoBK90KfX0eJ6+JOuemd/Hk0h+qYkgkzLSYNHbjlUvy9vV1Jy4+EL4cd5zww6Ho8VFyWRlnUI
	8+5Ct64CUGGzWEdEfbuoSvML1A3S3t3PJ3mR5r6jEkgnqJhfC04hKD1WmjSa+HrzziPnldLguP6Bh
	KJx/q++z3ZRT1Ci9QQMwbd7evubADz8MGMQ15EJNRX+ukrxw7OM+RW4M/NAVxkGwcrwDT5XhaFB6U
	wBhCYHw//r/Zyvifff8l7OAq6k81WDdCHpNaXaNTLCghlCnWLS8yXUhI6OBPjRazzUUGByaBfpwu0
	1U1kSywA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0I92-00000009YUi-41I3;
	Wed, 11 Mar 2026 11:54:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CC3A6300462; Wed, 11 Mar 2026 12:54:26 +0100 (CET)
Date: Wed, 11 Mar 2026 12:54:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mingo@redhat.com, will@kernel.org, boqun@kernel.org, longman@redhat.com,
	rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com, david.laight.linux@gmail.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] disable optimistic spinning for ftrace_lock
Message-ID: <20260311115426.GN606826@noisy.programming.kicks-ass.net>
References: <20260311115250.78488-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311115250.78488-1-laoar.shao@gmail.com>

On Wed, Mar 11, 2026 at 07:52:47PM +0800, Yafang Shao wrote:
> Recently, we resolved a latency spike issue caused by concurrently running
> bpftrace processes. The root cause was high contention on the ftrace_lock
> due to optimistic spinning. We can optimize this by disabling optimistic
> spinning for ftrace_lock.
> 
> While semaphores may present similar challenges, I'm not currently aware of
> specific instances that exhibit this exact issue. Should we encounter
> problematic semaphores in production workloads, we can address them at that
> time.
> 
> PATCH #1: introduce slow_mutex_[un]lock to disable optimistic spinning
> PATCH #2: add variant for rtmutex
> PATCH #3: disable optimistic spinning for ftrace_lock
> 

So I really utterly hate this.
