Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151FA2E1C7B;
	Thu, 25 Sep 2025 07:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758785187; cv=none; b=NnfEKG2LiaWvkJhmPG89nJdBB6+xKIHTJjgJG1JLwL2WY8mmRmPZGp1k0bBPpfUaKilZUkzvd6YkZURaUsfRLPCFiuC6oV2UOUP72+3KxrL1gT24cy/miCyE3J8Uu8gPtMI5t7CXKaJxQSQfQ0J4QrJsaeuwFIN7xIgGZPf6qZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758785187; c=relaxed/simple;
	bh=SVO+RJygcgJvp2Jegwed4omZG0pEp6kOknD7au5J3Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ch1i4MdAhzioB5W9pN+pbIJpKvw+PEYdtBTwa9PoeuAWXkkzeYQP4KJXxcSel/6wfMo/IuWx6GhBulqnpQFKq2yZWIUFnbJeFGLClUgD6dYzpELHYh+0B+53CmzjshH/x/QJwbFotXTZC2b52OAYYufBRaqhF56tfjFEVDhi76Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D+FT4rt6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D+FT4rt6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ka9ph0LAuyJVkaL1ah3rnWDOfvHTmklrLGkQl8UFMNc=; b=D+FT4rt6zbKsX21lgKDfaTqeIW
	Ka60A+egf06e/2rlo8wLBv/XGo+LGOhaApSQzAbjNL1GJIobCOwYgydzfLyvycZFBX1jj9HsOYwet
	nnj6jNRT89mRER1onC2V21OZ6uF/uiCCgicQ5mRRKwQ/u0LmACGq1yGEnK/uwbT9AiLIbkaJBgaXZ
	PXG4dfpeEgcZ9/JNmkxxpdGJ++2r5lBoswVZScW1kIlAaowyz94nVe1ohkikwZusdHQGLACOnus3e
	PMinZazQ0EWj4OA4a7LqteQBQw9aogYydVADhs00VWc2CVttgicJ1kyAMMSBu+Pq8ziA9ccWCI7Jx
	0Cje2XAA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1gMk-0000000Beum-3oqM;
	Thu, 25 Sep 2025 07:26:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6D6F330043D; Thu, 25 Sep 2025 09:26:09 +0200 (CEST)
Date: Thu, 25 Sep 2025 09:26:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Takaya Saeki <takayas@google.com>, Tom Zanussi <zanussi@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ian Rogers <irogers@google.com>,
	Douglas Raillard <douglas.raillard@arm.com>
Subject: Re: [PATCH v2 3/8] tracing: Have syscall trace events read user
 space string
Message-ID: <20250925072609.GU4067720@noisy.programming.kicks-ass.net>
References: <20250923130457.901085554@kernel.org>
 <20250923130713.936188500@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923130713.936188500@kernel.org>

On Tue, Sep 23, 2025 at 09:05:00AM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> As of commit 654ced4a1377 ("tracing: Introduce tracepoint_is_faultable()")
> system call trace events allow faulting in user space memory. Have some of
> the system call trace events take advantage of this.
> 
> Introduce a way to read strings that are nul terminated into the trace
> event. The way this is accomplished is by creating a per CPU temporary
> buffer that is used to read unsafe user memory.
> 
> When a syscall trace event needs to read user memory, it reads the per CPU
> schedule switch counter. It then disables migration and enables
> preemption, copies the user space memory into this buffer, then disables
> preemption again. It reads the per CPU schedule switch counter again and
> if it matches it considers the buffer is valid.  Otherwise it needs to try
> again. This is similar to how seqcount works, but uses the per CPU context
> switch counter as the sequence counter.

And you can't just allocate memory and not bother with the
migrate_disable() and retry stuff because?
