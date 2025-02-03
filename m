Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB13D2066FA;
	Mon,  3 Feb 2025 08:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738572209; cv=none; b=LK5TJ1LPajM55dqdAXpdV59N6/LMXI8yqcgRpeb74kvw3Mon6KnYqWncB9rJkyw4x4VB0C3j4NjNRhkNLvEhDCh2bwnbI8k532756cdPUIHNtE18KlJ2UuIQKSHf4x4EDoLTLMOSstz7WE6hYGNfQ86n/BGK6YbXgl0rg5AkAWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738572209; c=relaxed/simple;
	bh=fXhPEdlXHe0fBZGS1xbkQPDvaFDRrEfIxZ7Skt0NEAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3r45vVws/qBNjbK0xSYFSbMgKgei4D7kZq942OyaNti6VdsLK93tsUtEs3+9s9widmgiDiTg/BGLJsMhi5pL9MFQHlbCZOvHWSHeqewI/nIu9uK3voQ1DFoeUj/m6BfY18qsnVbd+iqaS+H3kumU8X949y22Tv1f3X1Y/e5D3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B+Dv/jU2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B+Dv/jU2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oFXjD8g8xVNyhnYAipqjv5HHkEWDGSdwQyIftVMCgiE=; b=B+Dv/jU2mnRuU3Mi2LQOxrklDr
	x7plI9PkW2FDvB7bOwqX1JO0JYEV/g8hI7DXUPU0phpXonZXYIegT5ii5bL1CP8qKjU28FsDAl832
	1ShOETXDlzwXGphAHP6gmnGRsy8FWHVHq811hEqYTYI/Wh1p7dJsg/RForNJzutwTsSeuX/DVJMQa
	+akCL59lwWJ+KEZePhPR7P8SZcTNXAI5+FCqtEyjnf0tgBgaK6dmDVoms3W0+/8/3bARNhLMeCdaK
	I4Utc11vgbsrAie2zLjw9X9r5gmHp3HwIY27vpNVoqLg81CUqLhLyT6bZFUOvH3OaN6RwkIzGUTmG
	AdFtQCyw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tes2t-00000000k6G-2Wem;
	Mon, 03 Feb 2025 08:43:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9DDE1300310; Mon,  3 Feb 2025 09:43:06 +0100 (CET)
Date: Mon, 3 Feb 2025 09:43:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
	bharata@amd.com, raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com,
	Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineethrp@google.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Clark Williams <clark.williams@gmail.com>, bigeasy@linutronix.de,
	daniel.wagner@suse.com, joseph.salisbury@oracle.com,
	broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250203084306.GC505@noisy.programming.kicks-ass.net>
References: <20250131225837.972218232@goodmis.org>
 <20250131225942.365475324@goodmis.org>
 <20250201115906.GB8256@noisy.programming.kicks-ass.net>
 <F30E23B6-7452-46F9-BF53-48799AE02F75@goodmis.org>
 <20250201181129.GA34937@noisy.programming.kicks-ass.net>
 <20250201180617.491ce087@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201180617.491ce087@batman.local.home>

On Sat, Feb 01, 2025 at 06:06:17PM -0500, Steven Rostedt wrote:
> On Sat, 1 Feb 2025 19:11:29 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Sat, Feb 01, 2025 at 07:47:32AM -0500, Steven Rostedt wrote:
> > > 
> > > 
> > > On February 1, 2025 6:59:06 AM EST, Peter Zijlstra <peterz@infradead.org> wrote:
> > >   
> > > >I still have full hate for this approach.  
> > > 
> > > So what approach would you prefer?  
> > 
> > The one that does not rely on the preemption method -- I think I posted
> > something along those line, and someone else recently reposted something
> > bsaed on it.
> > 
> > Tying things to the preemption method is absurdly bad design -- and I've
> > told you that before.
> 
> How exactly is it "bad design"? Changing the preemption method itself
> changes the way applications schedule and can be very noticeable to the
> applications themselves.

Lazy is not the default, nor even the recommended preemption method at
this time.

Lazy will not ever be the only preemption method, full isn't going
anywhere.

Lazy only applies to fair (and whatever bpf things end up using
resched_curr_lazy()).

Lazy works on tick granularity, which is variable per the HZ config, and
way too long for any of this nonsense.

So by tying this to lazy, you get something that doesn't actually work
most of the time, and when it works, it has variable and bad behaviour.

So yeah, crap.

This really isn't difficult to understand, and I've told you this
before.
