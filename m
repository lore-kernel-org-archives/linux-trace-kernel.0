Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436813ACA5A;
	Thu, 10 Sep 2026 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789071852; cv=none; b=Yr5VpEkrSOmfvbPdGHNPxf8c1GTqn3pRtfLCwvRNQMbXbZt0UY9/jXufN3ODMfi4000noF26PQjHo9FnDTuIidNcrETdL2SWkDRnR/uDq0RyPIqrHQUDvBv+pbQI+Y6b0P5t4Lu15TjB652zy4Qx/D2+yuCc6oej6MlR6RGaeCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789071852; c=relaxed/simple;
	bh=9deOYyvnTTkhxsY98oq4xlH4xNfQmmfKN6g16aS+6/c=;
	h=Message-ID:Date:From:To:Cc:Subject; b=qfvs7ScRrMCqPgUDoLG8bNTJdIk7p5+gkrSUa1JMbXWo5aMnBseZvLUBwtz/j4jUm4GxO+Z9o1SGdQEJy8WepWJ8Fftx9unM+DzGYc87efPlLwnCL4Kerhg2E1bCV0pBOqrWAxUKFS5KYYv2oxKipq6bu6NmngsiPbgIMSbchwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5hdMcTt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5hdMcTt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042231F000FF;
	Thu, 10 Sep 2026 20:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789071849;
	bh=BAEIVnRV4OuITxb/TBYSDWuCKdW42kcerr9zuWe+828=;
	h=Date:From:To:Cc:Subject;
	b=M5hdMcTtsi4gfDMsmsGFslBEtOAgOzzsqnY4tsOmSn6QR9MBqZ0fdfkPLjLOyQVFd
	 pLQxSdbbjc8spclGaPuifcSvXg6GQvXJxEDaRf/3wV808NgSYkTLGNTOOiuLgbED2h
	 6Bh5ObWRmlTtxN3zxMGaGs8ZH9L3LjT8sbVqQZc1mgrKWW1UejwEmGx1L2x+bf+mU8
	 Ob0M9GiG/c5t9UPX1tf8VAldMEYiFqvnFmf17wQIOet487YR2uxy7pStvuHNqVYOvv
	 DJkFpsyqnDXN+7oViU0Eyz6Zf4Q3x55x2JVHpP8EhI71GQoJZeCdFAg6hgCpe7hf5w
	 A7KA6KHZn6BZA==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x4lKq-00000008eYp-1yqk;
	Thu, 10 Sep 2026 16:25:28 -0400
Message-ID: <20260910202421.612273038@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 10 Sep 2026 16:24:21 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 0/2] tracing: Do not clean up hiter in mmiotrace read function
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


When the mmiotrace trace was first created, it allocated a descriptor in
its pipe_open() method. Since there was no pipe_close() method when it was
created (in May of 2008, and pipe_close() was added in December of 2009),
it cleaned up the allocated descriptors in the read.

Now that the clean up is in the pipe_close() method that now exists,
remove the clean up from the read as it is no longer needed.

Also simplify the code by inverting the early exit conditional into a
conditional to perform the logic and get rid of the goto.

Link: https://lore.kernel.org/all/20260715143604.14481-1-gaikwad.dcg@gmail.com/
Link: https://lore.kernel.org/all/20260721211143.36dbd559@gandalf.local.home/

Changse since v1: https://lore.kernel.org/linux-trace-kernel/20260721212010.76e9ed61@gandalf.local.home/

- Broke it up into two patches. Nothing else changed.

Steven Rostedt (2):
      tracing: Do not clean up hiter in mmiotrace read function
      tracing: Invert the logic in mmio_read() to get rid of the goto

----
 kernel/trace/trace_mmiotrace.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)
