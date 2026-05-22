Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BA8478E28;
	Fri, 22 May 2026 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779469828; cv=none; b=bNKFODsAOUQsAX+7A4U1OK9MkqoBhjuFhe2Ey5EjdWpf0Y2apL/LmgpvrRaZxgZWgpX+OeJfANrilqy2EwluXRb1l/iQ89z4Lw5Vq9YhQ6/s0CaB8X2YbgOCYoVfInmn0PQmDZX/tBD3XIrS/qPRVINrzCczBwR8lpp42/+hznY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779469828; c=relaxed/simple;
	bh=vZ0itRa1h7gizl/buabR44p6ml/rBcBGyfuOuuhtSTI=;
	h=Message-ID:Date:From:To:Cc:Subject; b=jXYlPZqjVSW9CBHfbCHEbniU4C4Wo781zYTNMQ1pirJsy0yl+XgpneiNLkMi5es5T1yOWI2Zwj8z0goqabexPbZB9a0IQ3zXDw0kuyL1fGPa7ELl5J6652BflJNBPCD1lpd8OTUlf7SWYcm/e1OGWQNKkDq5nJZ2xoHSpweTXVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Opt8y/Tp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Opt8y/Tp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9D41F000E9;
	Fri, 22 May 2026 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779469827;
	bh=Mdq68dCY/FY1GwiH6TrxtBE8wshjYx7lztXJjzc7WFo=;
	h=Date:From:To:Cc:Subject;
	b=Opt8y/TpmpoRYFygMKeQOdx+A7p3PWCXn40dc3m+eH4yo0wJbQ+yrism+bGsEtU0j
	 peX933l+wnq4ZCFE8lJ+0l9uQON4UgfmtyHcLeybiajsWrr+G8TrayXmhQnt6jr2uR
	 rC6Fkyx7AtqjI+KWD6mZJLSg9AXg0q9Sts6tWrk9XkgiFIVQ3vw5BB9r6D7tF+91XR
	 uePle2VHEJ3BSCsoDEYMpjqvx6dyycuhZwnUauTDvtZcDg5JuwXjaXcMuLutlKZDqs
	 mkAPkwIgIcwAe2pvXTyzlsDMxA/tpWDpqsefCBNXVLGFMt1be8ZgMFOTJX7Z4EJgAV
	 bEbvAcin5o90Q==
Received: from rostedt by gandalf with local (Exim 4.99.2)
	(envelope-from <rostedt@kernel.org>)
	id 1wQTOc-00000006BTt-3iYT;
	Fri, 22 May 2026 13:10:50 -0400
Message-ID: <20260522170857.263969486@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 22 May 2026 13:08:57 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ian Rogers <irogers@google.com>
Subject: [PATCH v21 0/9] ring-buffer: Making persistent ring buffers robust
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

This is to make the persistent ring buffer more robust when sub-buffers
are detected to be corrupted. Instead of invalidating the entire buffer,
just invalidate the individual sub-buffers.

I started with Masami's patches and modified some from Sashiko reviews.
I added a few patches to display the dropped events when the persistent
ring buffers validation checks found sub-buffers were dropped due to being
corrupted data.

Changes since v20: https://lore.kernel.org/all/20260520184938.749337513@kernel.org/

- squashed the fix for max_loops in rb_iter_peek()

- Still process reader page if head page fails validation (Sashiko)

- Removed left over printk() (Masami Hiramatsu)


Masami Hiramatsu (Google) (6):
      ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
      ring-buffer: Skip invalid sub-buffers when rewinding persistent ring buffer
      ring-buffer: Add persistent ring buffer invalid-page inject test
      ring-buffer: Show commit numbers in buffer_meta file
      ring-buffer: Cleanup persistent ring buffer validation
      ring-buffer: Cleanup buffer_data_page related code

Steven Rostedt (3):
      ring-buffer: Have dropped subbuffers be persistent across reboots
      ring-buffer: Show persistent buffer dropped events in trace file
      ring-buffer: Show persistent buffer dropped events in trace_pipe file

----
 include/linux/ring_buffer.h |   1 +
 kernel/trace/Kconfig        |  34 +++
 kernel/trace/ring_buffer.c  | 543 +++++++++++++++++++++++++++++---------------
 kernel/trace/trace.c        |   4 +
 4 files changed, 402 insertions(+), 180 deletions(-)
