Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780D82248B2;
	Mon, 17 Feb 2025 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810964; cv=none; b=AgjIJSG8hDG72T8ygUeqNaxG3KHq9uTg6sU/E1LncGbXAkm508OzwKqgksESX+TwlGMeILvbUe07OoqSPlRLwEUP54xRLvfrhWP8gt+QaVHZvUix/KmyXyXi+wkXQ6GCJjt5jnOzVgQfEpyPw18NYNJ0Aq8KSuSEUpl26vpokDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810964; c=relaxed/simple;
	bh=JboDu0TQIuen63q5qPzsV/LcUn/RP7ekbSiDOWPJ8Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwhzcaUuB6JcxST1zlq/TMeW08dphc99TT0Wq6oy/yUmT/Gbe/QLYudjbXla5LzDx+0sP8u+6jGWIUHB+VFUFz2JcqOMEeQ/r768FScWx8DPzyIN7ke35fJiHMQz1XvFr9OcUpFidO5lnFc1tEv3RaKTnwwTOMLI1KhKDmbo0CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W51vjcvD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W51vjcvD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p4cOO+qlUr7HNQs1Rexuf+LmTFJw1DE5zTywYs4+BVw=; b=W51vjcvDQvJvOrztgtfKX9klA4
	P9B2xvEsMiiiMUn+I54I9jXpLqvl0HKr2elnlbpwXkyrqwEcPm0h/Lisd2VTf/gIsXjFFkA9qixV3
	bJ7EnkShApdn7dU/QFrc4ruC7lsZJlEoWnXqck2ZmJJ5x2T8EjsoW3kD1BSxdiUKK4rWqRXBqwb0/
	3gzd1ZFhdLCHtZzqcEpJ5t+CiiJrKPDLCVnZR4TtN1+Bwhj70gV911vmz/9VnE6Wnw+ltHRD434I0
	C9EiMWKchD7rlHU89gh/DkYUeJOlgctM8X1/RlM8e2ayue9oGGo1DekUSDgQQ0OoIUa3bpLWSBvHg
	+T3THfoA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tk4J4-00000001rCW-4A0V;
	Mon, 17 Feb 2025 16:49:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A9E03300783; Mon, 17 Feb 2025 17:49:17 +0100 (CET)
Date: Mon, 17 Feb 2025 17:49:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v2 03/11] sched: Add sched tracepoints for RV task model
Message-ID: <20250217164917.GB40464@noisy.programming.kicks-ass.net>
References: <20250213090819.419470-1-gmonaco@redhat.com>
 <20250213090819.419470-4-gmonaco@redhat.com>
 <20250217113844.5ad7893c@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217113844.5ad7893c@gandalf.local.home>

On Mon, Feb 17, 2025 at 11:38:44AM -0500, Steven Rostedt wrote:

> > +void __do_trace_set_current_state(int state_value)
> > +{
> > +	__do_trace_sched_set_state_tp(current, current->__state, state_value);
> 
> And this should not be using the internal macros of a trace point. It should be:
> 
> 	trace_sched_set_state_tp(current, state_value);
> 
> (I removed the current->__state as mentioned above).

But the static branch is already in the caller, no point duplicating
that.
