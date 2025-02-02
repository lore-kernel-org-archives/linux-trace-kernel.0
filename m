Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F36A932;
	Sun,  2 Feb 2025 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738480938; cv=none; b=STF5E5PPnSpw0q12cuBQLamPb7C8hglgVpHCyH4BpqeVzzwY/NNhEeLXvEEfhlw0HfeqfRcG2RZ4kCFbgpudIYd6cfogIdlJfa30RxQsiH6DfJbblpe+DwmAgEEBQ2hzXcYNTpxZgfg6HN4F8aV1UNZxqrt4bjclpHM9AYK2A9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738480938; c=relaxed/simple;
	bh=2HQjkYIl3cLMQLG5F9U/gL5vESvDQQN09ZIPGSpFLHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yvbgp+aAn3v8f5xb1BfLBvwUtgTFrNuK2xZbwt4HoQumtJaRI/Bh5PXv0GfR3wemIj8qRc6siXjHkKL75eSj6vk8LbHh/8pvdiyAPRPzI+gjyfcOQKasUTzevGt078iuFQCNuxZLVZa4LAuhI1fMl2R6JEBvD9S1EfUp0XI9v3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m00Tytcw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m00Tytcw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kp2R2I4n2SrI5B0Gs6YVxJP2t+wd8P6NNyGAbLFTZGw=; b=m00TytcwXw3m/eh4wx2QP57IIO
	KDlRq87Ws9UqQuU802qi0q1wDPal06L6KlJyzis7q8VdzfqAGuxqY55BDuavRt6xp1cmrFdAmOdWk
	Ju6TIELAc2Zvb2l1Fc9B/qUf1CMlJZE8keYumrSgit1ASCivCgQ53LPqMlEx+99jts2vNgpiE54Jq
	X25b8mNhvj7hJBd8DrEASfsyOBhTrx/3zHp0gCrmO7t/+UGCnlxT7j/8k2c5q/b+dtx9Qnn/J6e3k
	ORcjw4cpFUc6g1Tk68Nl4vbGCDBWEbxhNuo+z6paJwpGNoFNKuPLpvxZ1YHLMqTDRZRKG0JA45wlC
	34aaEigA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1teUIy-0000000GkyH-1NvM;
	Sun, 02 Feb 2025 07:22:08 +0000
Date: Sun, 2 Feb 2025 07:22:08 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ankur Arora <ankur.a.arora@oracle.com>, linux-mm@kvack.org,
	x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
	jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com,
	andrew.cooper3@citrix.com, Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineethrp@google.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Clark Williams <clark.williams@gmail.com>, bigeasy@linutronix.de,
	daniel.wagner@suse.com, joseph.salisbury@oracle.com,
	broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <Z58dIOGlJ3grsAge@casper.infradead.org>
References: <20250131225837.972218232@goodmis.org>
 <20250131225942.365475324@goodmis.org>
 <e83ce086-b55f-431a-a499-f83a434b70db@efficios.com>
 <20250201180810.1faf4906@batman.local.home>
 <CAHk-=wgTWVF6+dKPff-mhVwngFwBu_G9+fwOTF2Ds+YPj3xkeQ@mail.gmail.com>
 <20250201222208.0b0d0f5c@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201222208.0b0d0f5c@batman.local.home>

On Sat, Feb 01, 2025 at 10:22:08PM -0500, Steven Rostedt wrote:
> And before seeing Peter's use of yield(), I was reluctant to use it for
> the very same reasons you mentioned above. In my test programs, I was
> simply using getuid(), as that was one of the quickest syscalls.

Is getuid() guaranteed to issue a syscall?  It feels like the kind of
information that a tricksy libc could cache.  Traditionally, I think
we've used getppid() as the canonical "very cheap syscall" as no layer
can cache that information.
