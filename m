Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8222D2495;
	Sun, 19 Jul 2026 22:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784500142; cv=none; b=Nem34/sZ7mgqKQr2w3NvNBFfRwlKsdCtpUSCjBjT2QTYMwpgi/peamYVbGKc7JViZ1rQ/O0X+8sKz8dGnIixyFhnZrhPunn2PEF+LTHbg5SFV0g8Dmna7Cjz2aCL8NCI2r1nftIW/xypReVGse2iDVbtEHtapBlNQAtdD7hpQFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784500142; c=relaxed/simple;
	bh=ykqzF0nvitTCkIm8153hEK37Ld0yW+OhAozGCCqRH0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwvqJOm+AOoEF8nCwfJup3GLAOwM6ggR2h6XGip9Ox8xitkW3o3vMEhf7h2SvKIEWs9lZJKtT3DZ+H9HcdoNBCg5fZm4CqmCL+/rNgAktibASAnEnyJMDFzKCX2Zr8h24ynJ6hHZx+abdoySH8BnUNboTsx93aHXjSDOH/KYs7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T+KZpNyy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T+KZpNyy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s14CEhiEMvrJ+CO4bAEdF7C+l4zLaNcCXOHRTCm4syg=; b=T+KZpNyyRL4Q1eb+oGSpiTb4jp
	rH+h1D7JowafhWq4UOavSyi5cIj7dAan32/dV2iRMPJX+6JBik2MZZLHtTHYsEChsZje4qUCXymtB
	AxPcwv+aly50ZBIusRTNz/w6td1s7IkujvS64EUrIt9gy5xnMreSR5l4YkKG2aZYp7fm49WWYE1nY
	B2jYztCFHvGhU3D7Ayd02UKO/s4iHMlV4OAsAV7GlX3tlDY31em7rWZfb9XTiKmPi0UkGhjHygRpF
	3zPdhz8GZvmQJDUIKou4K6dprbprNnuqgjg7rF5hlvqar9hX4EDls11KyCvd81akFrkwsYTWni0/u
	FvJAf5YQ==;
Received: from [12.151.47.154] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wla09-00000005RFR-15QJ;
	Sun, 19 Jul 2026 22:28:49 +0000
Date: Sun, 19 Jul 2026 18:28:47 -0400
From: "Liam R . Howlett" <liam@infradead.org>
To: Aditya Sharma <adi.sharma@zohomail.in>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imbrenda@linux.ibm.com
Subject: Re: [RFC PATCH 0/7] mm: defer address-space teardown of large
 exiting processes to a kthread
Message-ID: <ljr2jkxomq4ccgzq2ip3c66mjdryomhl2gxkswv4wzry5ye2ax@xaehxzjkkk3m>
References: <20260719185409.409685-1-adi.sharma@zohomail.in>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719185409.409685-1-adi.sharma@zohomail.in>

On 26/07/20 12:24AM, Aditya Sharma wrote:
> Address-space teardown on process exit runs synchronously in the dying
> task's context: exit_mm() -> mmput() -> __mmput() -> exit_mmap() walks
> page tables, updates rmap, frees the RSS and drops file references, all
> on the exiting CPU. For a multi-GB process that is hundreds of
> milliseconds of exit-path latency, paid by whoever is waiting on the
> death: a supervisor's kill-and-respawn cycle, a shell's waitpid(), an
> orchestrator reaping a fleet of workers. On the test box below, killing
> a 16GB process costs ~280ms before the parent's waitpid() returns.
> 
> This series adds CONFIG_ASYNC_MM_TEARDOWN: an opt-in, default-off path
> that defers __mmput() of large exiting processes to a dedicated kernel
> thread (mm_reaper), so the exiting CPU is released as soon as the task
> is reaped and the teardown runs off to the side.

This reads like it was written by an AI, but there is no assisted-by
tags.  Which AI did you use to generate these patches and/or cover
letter?

I do not see a benefit to running the task cleanup 'off the side'.  In
modern computers, that may mean switching core types that run at
different speeds.

Regardless of speed, the CPU that will be doing the work is remote to
the workload by design, (or may be, depending on the scheduling?).  That
is, you are tasking another CPU to do cleanup of local CPU-aware
information.. The ideal CPU to do a task exit is the one that's doing it
already.

There are hidden costs to your approach and I don't really understand
how this could possibly speed things up - even parallelized tasks will
take more CPU time in total, even if locking issues are avoided.

Sure, the task waiting for cleanup to complete may think it's done and
continue to do the Next Thing - but if it really needs the cleanup to be
completed then you've just made it impossible to know when it has
happened.

Also, you've just made this extremely hard to debug if something is
missed.

The work that is done in teardown is necessary.  Your time (and tokens?)
would be better spent trying to improve what we have to do instead of
shifting the work around.

Thanks,
Liam
