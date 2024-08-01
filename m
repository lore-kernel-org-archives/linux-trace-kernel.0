Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB5713D520;
	Thu,  1 Aug 2024 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722519382; cv=none; b=g+gZOULVNqkeZoZTvTqAZnscokDVZawGFsH2WxqyI1yVrUwCRIXJNaJyvjwf3+6GfuDibhmoUDGN0cnUs9uTsfWaeRQsx5w2QBOT0QhzJqj0+SATBQQnCgSt39WoyKxp38eEtstDdZIqi/5RhYkbC6q1qOmNjMIyWqEC9hJEOF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722519382; c=relaxed/simple;
	bh=5uoTlD88MjhSCVgxTKLb4XpctYOlDRDeyGiwMWJEoOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvHjgE2nropD2b+P11+c1cPIpVT+/QBDixWCk3SLvm2VOjN8fOm4UhivaBXH1AVfhgiF8U5hTWMzL5b7UWxuCFXhn/B4+QEsZk/JVw8OFgeGhhMusxEyhkThGkHoJJmM45WW6aPf+HFWTTqbg5wRQRrXXwYclxcedxvZydit7aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gXl0Gxtk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gXl0Gxtk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5uoTlD88MjhSCVgxTKLb4XpctYOlDRDeyGiwMWJEoOk=; b=gXl0Gxtke94g4eaSAKQXNZrGOg
	UrR5xhsOI5W9XYoGMi7x/mn7ModVo/mh3AJgYhbB6m3vdeX8se5CaOvlRZ4j7796VF2BuLvl+xsEJ
	dyQA2fjQtfqnlQ69xlXcEM5YaSj/2fEpxGmzqqq6wM2gM3zwnfGekSrtpin9IzT5jG6qSFppfV0sM
	WeWAAGjeI/U6x9rA42UYN+eVWxScj7TAJkgUGVMkcEz1TNkdhSkG0/7FB2X85VE3VtN3bEqQ3jVuG
	DQ3HAiKIArVGik4xwrHO6e0aAAiDhMhiIHTZSMGVMYyIqVYmdOlF1SDd68R5UnJvVpwFm/1vOgmSm
	Ky1NhSIg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZVyc-0000000HVae-0K0C;
	Thu, 01 Aug 2024 13:36:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9D12330074E; Thu,  1 Aug 2024 15:36:17 +0200 (CEST)
Date: Thu, 1 Aug 2024 15:36:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: andrii@kernel.org, mhiramat@kernel.org, jolsa@kernel.org,
	rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/9] uprobes: misc cleanups/simplifications
Message-ID: <20240801133617.GA39708@noisy.programming.kicks-ass.net>
References: <20240801132638.GA8759@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801132638.GA8759@redhat.com>

On Thu, Aug 01, 2024 at 03:26:38PM +0200, Oleg Nesterov wrote:
> (Andrii, I'll try to look at your new series on Weekend).

OK, I dropped all your previous patches and stuffed these in.

They should all be visible in queue/perf/core, and provided the robot
doesn't scream, I'll push them into tip/perf/core soonish.
