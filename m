Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836B61E633C;
	Mon, 24 Mar 2025 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742816164; cv=none; b=hKttQixCHda/0lOLdxfHWrPTMdFNf6970Bv/L8+WamgxeSpU5LDndgxt6vRRdiCSUWJfshDoVdxWJfFZPngAd3+PoBhZ/8L2n7AKDmIacct9YxmNH013dSJEZ32U8jZcZG7IrZt3yks+3fscxdSekiko4MRJGfvUh7EoggHldmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742816164; c=relaxed/simple;
	bh=ytcy48div7CFIbiXZhMFGrSyuBr3KX93xUGDCThz93c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imcV92wNz8BwJWkoo34kbH1B52vr2J3b5jzVrAEBcWxnpRySpgzIo3mXJD/rV+1XzZw2INRfOhdf7JIcCtlhpqXwC9kV39ZZ5IKpN1ofjfMlXv5PfNWl7NG/I0npwMlFBBZqxkyQnEl1g9HR/yI46Mjlt7Om7NEiC88zgjre1t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qwYnnJty; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qwYnnJty"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sYdr3C6pKaGDkQFwyBPg1o8YgdweUacsqf/nfU8wmZA=; b=qwYnnJtyMgyVR/DP2CDRSItzSG
	2Vg3Xj6DNrZpFId4M7Wq+gxxfaS6MOojxl0U1h70dTME+6O4rdWOLkD5i9StgqBdX5jnm2oGOz6eh
	FfQtaOhcjwErU0yCyBM6gecfiJmn6kr0URPcxkKWCXdtGjwkwJxrh9O6RXWi8zenYbil/FvsF1Wdm
	nDCgfZFb0sbxCnHvfOQO2RPvGek7sUzGGsTloJ593f4cex5v2e2CUqM8+xJxUAP+9k8RDrG/gD2kK
	ikTU5bdKnugKv3yll+htPv/Ew3fBOgoHGNMEO0kkVaq3t0AfOmZVr5+IESbMj+Z0RBFSmsnJX0F8d
	2v4+musw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1twg60-00000000YJI-0w10;
	Mon, 24 Mar 2025 11:35:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3C95E3004AF; Mon, 24 Mar 2025 12:35:55 +0100 (CET)
Date: Mon, 24 Mar 2025 12:35:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v5 1/9] sched: Add sched tracepoints for RV task model
Message-ID: <20250324113555.GC14944@noisy.programming.kicks-ass.net>
References: <20250305140406.350227-1-gmonaco@redhat.com>
 <20250305140406.350227-2-gmonaco@redhat.com>
 <20250307123849.1e5d7543@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307123849.1e5d7543@gandalf.local.home>

On Fri, Mar 07, 2025 at 12:38:49PM -0500, Steven Rostedt wrote:
> 
> Can I get an Acked-by from one of the scheduler maintainers?

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
