Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE3D1922FB;
	Sat,  1 Feb 2025 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738411174; cv=none; b=nSBZR2X213DC75S15f14oHhfjrnm6A44P/cW2L8foSX3w03qIyFVifdiXcw+4KDASbNvyAuEbUV5zVeNRAnPAwEdbcUiGpWImmoxwE9xbQxeToVl8uaVcYoMoC2LelBtjpCWA5ytTfKWLPqsX13v0+qUX49gs4wgD3++qWWZzw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738411174; c=relaxed/simple;
	bh=JVMhM4qCrmK4aX+7L342+sXAVZzs3aIzPbSc3dIh3Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJLnv6kSPip+97EWJmgV9hYcITJfwCE6oJkUP9kVsPhLGbEpBywwrB7qcQfr0Uahv7l9pm0B/MFOz8g17ZtwVE2tvBegiJoK+eNrS9SWXwJIE4G8iOUwU9Ovp+K7YBSeQDCJjGK0J8REx73I+Pmb6SqZ+e3teWglHLa9Az+7ywI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pbk2aSBT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pbk2aSBT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/Pt1uWe8pX1nlypB41dI+IU4abjKeio0meMwwO8iri4=; b=pbk2aSBTYZ5V8ONbwp65zM0Ba4
	I9+/GmnAJlsmsFqCivqC3ThWnuihfRazhzYCd+b1a0GZmF2D1nGtbdKrd3FKrH58g5B289udr+S34
	3984lxdf985wEf8Zfr4RM71HSStHx/HGAWcCFipZMAxcB28M6TMBDll4Fo0q9aaf5kcvvmfXxcDvi
	RZA2Ay412X74tojgGQ9FLgUtki1KuXKgu5M82U9wGBmYG1mhB5uMeOpjSwTbOSrKzZ+uHajsde7CK
	8fB7Fa8PlS7E6Bh461N5iFTMa9MO1PheHK8JgZctX7X+pYKXWrL1Lys56BeC/9jGgJE4eT5g/vQcB
	fJ1B+FqA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1teC9T-0000000FxRh-2GuG;
	Sat, 01 Feb 2025 11:59:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1E7DE30050D; Sat,  1 Feb 2025 12:59:07 +0100 (CET)
Date: Sat, 1 Feb 2025 12:59:06 +0100
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
Message-ID: <20250201115906.GB8256@noisy.programming.kicks-ass.net>
References: <20250131225837.972218232@goodmis.org>
 <20250131225942.365475324@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131225942.365475324@goodmis.org>

On Fri, Jan 31, 2025 at 05:58:38PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> This is to improve user space implemented spin locks or any critical
> section. It may also be extended for VMs and their guest spin locks as
> well, but that will come later.
> 
> This adds a new field in the struct rseq called cr_counter. This is a 32 bit
> field where bit zero is a flag reserved for the kernel, and the other 31
> bits can be used as a counter (although the kernel doesn't care how they
> are used, as any bit set means the same).
> 
> This works in tandem with PREEMPT_LAZY, where a task can tell the kernel
> via the rseq structure that it is in a critical section (like holding a
> spin lock) that it will be leaving very shortly, and to ask the kernel to
> not preempt it at the moment.

I still have full hate for this approach.
