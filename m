Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E35225A634;
	Tue,  4 Feb 2025 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738660602; cv=none; b=SqzN4LxKeKRtZ1Y3kx/TEhz3OUlBGtjl25SzWReTvJ5ajvdsuXpjPDBEg8pZNEGo8mFFnlyh/vbWsQHJZlUPlxxyhwNPHKiTMOw5Rpnfqxek59a7O7PjwhpWGzEnoJOU59MjqCpgXUumLlh0b3nuZdrJTQaEX1BDkhVW65rUYII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738660602; c=relaxed/simple;
	bh=Cyj86Xfk9KWNzVaA2X1/8q1w+RnezCPqu3yiMSnaY34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGJk/Cm0J1Ns3TvrAI/S5i1PDb8huKWNo1Y6wk84Fw/4b+nnYEkgZFU6xupLZW4qCZRVPa1gum0WiaEX3KhH1C7sDSdNtr0iH2GgQYnl+VaVguXRDtwmP8i3Wqk6Hg1Y/fKR0v7jmeLfGh8Iywx13jy3/8XINDA9OeAVpUDJjqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kYYe3Dmf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kYYe3Dmf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=t0DEtC3PKgp7BXTIfritcGnBk8Mae1xwU2+pF395sTM=; b=kYYe3Dmf/GzcBPUe5bN2ze2o1H
	IJXz23hzmqCYF90ZGKaTFcThAXuBST2ypBR0yvblo4QjGqjh6NOh/ekMgEEHgAAbhmOiX/Syzyeaa
	uIPrNMkx9jNQm00okElA+0qedocki1HCEoWsrpXh2kKnA00tUyj7HIx+PpSX9cZwUHINVWhSoHkCD
	+vXo9mw5ldAtwfyCCtvwD5fQ4yREdYleWwWmJDTUSd1/9d5pHGjDqsWAYbtXCguIyVGqf3bN3FsEc
	XL/ASyxYN/HrFPoiFcTJ93l9PdYPVwDuLTFrRBUE87lx1Vi28FbCH2+ZVtGCa3OUrdETjC5eUBOOU
	TqhmJNWg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tfF2U-00000002SwU-0bJl;
	Tue, 04 Feb 2025 09:16:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1915F300599; Tue,  4 Feb 2025 10:16:13 +0100 (CET)
Date: Tue, 4 Feb 2025 10:16:13 +0100
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
Message-ID: <20250204091613.GQ7145@noisy.programming.kicks-ass.net>
References: <20250131225837.972218232@goodmis.org>
 <20250131225942.365475324@goodmis.org>
 <20250201115906.GB8256@noisy.programming.kicks-ass.net>
 <F30E23B6-7452-46F9-BF53-48799AE02F75@goodmis.org>
 <20250201181129.GA34937@noisy.programming.kicks-ass.net>
 <20250201180617.491ce087@batman.local.home>
 <20250203084306.GC505@noisy.programming.kicks-ass.net>
 <20250203114537.6a30c7c0@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203114537.6a30c7c0@gandalf.local.home>

On Mon, Feb 03, 2025 at 11:45:37AM -0500, Steven Rostedt wrote:

> > Lazy only applies to fair (and whatever bpf things end up using
> > resched_curr_lazy()).
> 
> Is that a problem? User spin locks for RT tasks are very dangerous. If an
> RT task preempts the owner that is of lower priority, it can cause a
> deadlock (if the two tasks are pinned to the same CPU). Which BTW,
> Sebastion mentioned in the Stable RT meeting that glibc supplies a
> pthread_spin_lock() and doesn't have in the man page anything about this
> possible scenario.

Yeah, we've known that for at least a decade if not longer. That's not
new. Traditionally glibc people haven't been very RT minded -- the whole
condvar thing comes to mind as well.

And yes, you can still use the whole 'delay preemption' hint for RT
tasks just fine. Spinlocks isn't the only thing. It can be used to make
any RSEQ section more likely to succeed.


> Patch 2 changes that to do what you wrote the last time. It has a max wait
> time of 50us.

I'm so confused, WTF do you then need the lazy crap?

You're making things needlessly complicated again.
