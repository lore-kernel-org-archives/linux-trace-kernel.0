Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DD0BE67;
	Sun,  2 Feb 2025 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738535366; cv=none; b=HhBQUnK9wZ6wL/gde/SB1I1zsEAo1rtcc0CCsQFb4Q4uio5JLpAQyiaqTFWzwgHFr09SKEc9d0XxhXtZQkZrToWqVYXsgv6sAQ5Dxr5NK9CgBmRf38bjrU/MJioC+l0GvlEfflA248vlX3xELHCrx4LAav5JtYu+O/OhfeI8JSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738535366; c=relaxed/simple;
	bh=5jco9qkJre/Jm0X5veB3Q7E4Z6Vl+c8of7hxfrfDpBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=caXD5E+cyXAqodw4xJD0o+vufipzdAL3SU+8MpXjFtJRWYmHHqk5h14TXIkvvDdQW4+/D5XaOpJv+H6HYhZoCzMZm+P1TyboeJA2fi+hIBqyPOYLl/UhbsmeHvlbnlpfxfZS3Zw5IzWMk2DrvXfdRqqL1Ibc4CjuBon1aEHZx+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3C3C4CED1;
	Sun,  2 Feb 2025 22:29:22 +0000 (UTC)
Date: Sun, 2 Feb 2025 17:29:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Ankur Arora
 <ankur.a.arora@oracle.com>, linux-mm@kvack.org, x86@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, mgorman@suse.de, jon.grimm@amd.com,
 bharata@amd.com, raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com, Joel
 Fernandes <joel@joelfernandes.org>, Vineeth Pillai <vineethrp@google.com>,
 Suleiman Souhlal <suleiman@google.com>, Ingo Molnar <mingo@kernel.org>,
 Clark Williams <clark.williams@gmail.com>, bigeasy@linutronix.de,
 daniel.wagner@suse.com, joseph.salisbury@oracle.com, broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250202172921.6bcce689@batman.local.home>
In-Reply-To: <Z58dIOGlJ3grsAge@casper.infradead.org>
References: <20250131225837.972218232@goodmis.org>
	<20250131225942.365475324@goodmis.org>
	<e83ce086-b55f-431a-a499-f83a434b70db@efficios.com>
	<20250201180810.1faf4906@batman.local.home>
	<CAHk-=wgTWVF6+dKPff-mhVwngFwBu_G9+fwOTF2Ds+YPj3xkeQ@mail.gmail.com>
	<20250201222208.0b0d0f5c@batman.local.home>
	<Z58dIOGlJ3grsAge@casper.infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Feb 2025 07:22:08 +0000
Matthew Wilcox <willy@infradead.org> wrote:

> On Sat, Feb 01, 2025 at 10:22:08PM -0500, Steven Rostedt wrote:
> > And before seeing Peter's use of yield(), I was reluctant to use it for
> > the very same reasons you mentioned above. In my test programs, I was
> > simply using getuid(), as that was one of the quickest syscalls.  
> 
> Is getuid() guaranteed to issue a syscall?  It feels like the kind of
> information that a tricksy libc could cache.  Traditionally, I think
> we've used getppid() as the canonical "very cheap syscall" as no layer
> can cache that information.

Maybe that was what I used. Can't remember. And I think I even open
coded it using syscall() to not even rely on glibc.

-- Steve
