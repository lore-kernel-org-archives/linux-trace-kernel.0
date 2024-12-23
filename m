Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630161C07FB;
	Mon, 23 Dec 2024 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734979730; cv=none; b=NbFdmf6RMvvE3o8EHhT+DGdzjXQu5mKdnlB/BJs/EWBX6/ELFpLcHSISzBBVnn4xp4Iptw7K07jVjwA9kL8yMSwnCnOtX1O69Lte9CdsbBMSPq+VKpuMYDtGAIhIVgt1sdm1wY+pGDnV1QcXeUhO9IM7ix/pf125Z78PCXX65Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734979730; c=relaxed/simple;
	bh=jbIPBvdPutff/hYUESS3eB2ty/hhQ8f5+d24Q0pT3FI=;
	h=Message-ID:Date:From:To:Cc:Subject; b=j32aORSpR7XDFOFh5vKBL4G1OEewxbdqj0AvUFzITyc+ca74A8xvcmdKv2ZwxN8RP0V7hN3D5EhfSXvN1/yc9KO4TFIdMcQx7i3t2LklB5Kot4onQ3ZsyMthGp1A7R++7MoYECJ7eW7cxxoeqbfF4IdZ+vDWw2RVJMOOCuDwiTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4263C4CED7;
	Mon, 23 Dec 2024 18:48:49 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tPnUr-0000000Dclb-0jrw;
	Mon, 23 Dec 2024 13:49:41 -0500
Message-ID: <20241223184618.176607694@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 23 Dec 2024 13:46:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/4] ftrace: Graph tracing performance enhancements and clean ups.
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


ftrace update for 6.14:

I've always known that function graph tracing had a significant overhead
compared to function tracing. More than just double (since it also
traces the return of functions). I never looked too deep into the cause,
but I just noticed one of the reasons. As supposed to the function tracer,
the function graph tracer disables interrupts for every function entry
and exit it traces. It has been doing this since it was created back in
2008! A lot has changed since then, and there's no reason to disable
interrupts as it can handle recursion. It also forces a disable that
even prevents NMIs from being traced (so function graph tracing will
drop NMI functions if it preempts a current trace).

This is totally unneeded, especially since most of the complex code of
the shadow stack has been removed from the function graph tracer and
put into the fgraph.c file. The function graph tracer is only one consumer
of that code today, and the disabling was due to protect the code that
it no longer calls.

Remove the interrupt disabling as well as forcing a disable of the
function graph tracer while it is being recorded. This gives a significant
improvement to function graph tracing.

Running perf stat on "hackbench 10".

  Before:  4.8423 +- 0.0892 seconds time elapsed  ( +-  1.84% )
  After:   3.490 +- 0.112 seconds time elapsed  ( +-  3.22% )

That's ~28% speed up!

Do the same for the function profiler as well.

  Before:  3.332 +- 0.101 seconds time elapsed  ( +-  3.04% )
  After:   1.9590 +- 0.0484 seconds time elapsed  ( +-  2.47% )

Which gives ~41% speed up!!!

I may mark those commits with Fixes tags for performance only.
I would not mark them for stable as I would like to verify a bit
more that they do not cause any regressions. But for those that are
interested in better performance from the function graph tracer, it
may be good to backport.

The other two changes clean up the ftrace goto code. There were three
places that simply did a goto to the end of the function that returned
a value. No unlocking, no freeing, just a simple return. That was
changed to just return in place.

The second change was to implement the guard() logic around mutexes.

All of these commits are agnostic from each other and may be applied
separately.

Steven Rostedt (4):
      fgraph: Remove unnecessary disabling of interrupts and recursion
      ftrace: Do not disable interrupts in profiler
      ftrace: Remove unneeded goto jumps
      ftrace: Switch ftrace.c code over to use guard()

----
 kernel/trace/ftrace.c                | 130 ++++++++++++-----------------------
 kernel/trace/trace_functions_graph.c |  37 ++++------
 2 files changed, 60 insertions(+), 107 deletions(-)
