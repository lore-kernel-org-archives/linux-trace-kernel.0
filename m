Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB65C152166;
	Thu, 11 Jul 2024 08:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686464; cv=none; b=gqc9Ze7TC7RiMLoJMFZC+57FuBnjkEH88Js8kOVM/DlGVRoa0PYG/XnI9xwG0quGxRBbe62rBlTTAteLqhLkk+xO8fTUSmz6VoEVWWifx+gTon0KS305W6nDiwlznFuBKK7zZ65HdzGJVBkEokakyz+BSTfaRZrZ/R9mOrgnhhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686464; c=relaxed/simple;
	bh=QLkc0syHmfrJ4ooILR0YbhQf2XqmWSHnQs/1IzydFT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8WJFcBQSBWapKyneruJmTepKSJNSayqIQbIESECgifTkMiCgltwgt42tdlIuDk7XCZA8f1nSUK4rgEUm6re5LFeF8Lk4btXy5zmkNuBGPcb+YrLs5gw5aynHzOYrx3+bD/bsZUKfbjw57ivACuruhecvMAZ0CjWYLaCBv9JmMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SX17Fvi2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SX17Fvi2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zKpNKzwctbeTnY3N4R5E5wRN5p6CTobDSc8wD1nLfFg=; b=SX17Fvi2VRqdsTaVNibFtbV4pi
	LIdgXbYzqeeXRveI3+F2hA29TmLO9uRv8uCfSGNLtKz3ai827zPP4a4dOuuCiIaBx7JTgkliDFwVA
	cnnH2UOAF5doHsbfmroT/9AOWF1eWT+VPrOYLBGHa1fODjuRJWI4kOdCqwoj252hlt6rthkjjhdSI
	MQ1KZLw2T3jmX1q65vzoHqMgCWuWSa0Ujl/2g3kMsMwCo06oSwI2yy4BV1Fd77GChxnGa9CYcZI5O
	8wvf0/cHn5I2zRJWNcM6kt/3keU9JZpxbQqBIH8chYhlvD4/NRaCpQrNw1fbsR14Fbqv3EE67fMDt
	C920SOyQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRp9M-0000000Alir-4AQG;
	Thu, 11 Jul 2024 08:27:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9A436300848; Thu, 11 Jul 2024 10:27:36 +0200 (CEST)
Date: Thu, 11 Jul 2024 10:27:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: andrii@kernel.org, mhiramat@kernel.org, clm@meta.com, jolsa@kernel.org,
	mingo@kernel.org, paulmck@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] uprobes: future cleanups for review
Message-ID: <20240711082736.GG4587@noisy.programming.kicks-ass.net>
References: <20240710140017.GA1074@redhat.com>
 <20240710163022.GA13298@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710163022.GA13298@redhat.com>

On Wed, Jul 10, 2024 at 06:30:22PM +0200, Oleg Nesterov wrote:
> On 07/10, Oleg Nesterov wrote:
> >
> > Peter, these simple cleanups should not conflict with your changes,
> > but I can resend them later if it causes any inconvenience.
> 
> In fact I would like to push 2 more cleanups before the more significant
> changes, but they certainly conflict with your ongoing work, albeit only
> textually.
> 
> Let me send the patches for review anyway, perhaps you can take at least
> the 1st one.
> 
> 3/3 is only compile tested so far. Andrii, can you take a look?

I was going to post a new version today, but I can wait and rebase on
top of / include these 5 patches (or more, these things tend to grow).

