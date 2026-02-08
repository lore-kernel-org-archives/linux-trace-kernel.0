Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF65014A0BC;
	Sun,  8 Feb 2026 04:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770523298; cv=none; b=L7Yw/YPcdBSq6of/nzniFeBQcRDft7ebThD4ceM6lMAvYytjk8jUSsJlT5L4i3hwdHkBHsifPNg36S319p27tHJu6oB4hIJqY3RgGBbMXqb3V66q3fKVGfXEuowVzMuhq/2I5pwmWnHjkUl72ZwAifbcVdnUD1Ae03/V4ZWqDBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770523298; c=relaxed/simple;
	bh=hDGjFmtasAU1n8AWaPYo3ErnvXzs7uIxqWvFUwrRKPA=;
	h=Message-ID:Date:From:To:Cc:Subject; b=dwYO79JbqKsHzY9M3lC6AHh/rc5+BEeeSGUnitHpm0Et2BLMQJkl0p9/ltiwlY+fTK2tJSe7jOof3OunsWliTCcJIrL+yCW6hF4TIqCbpMomuXuzmT5pyDBEmu29ycgFsEv4wehwDzQtHPoGake7iOs3XYQP/frE+p/oW7rG7sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqM4YRDd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqM4YRDd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CB1C4CEF7;
	Sun,  8 Feb 2026 04:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770523298;
	bh=hDGjFmtasAU1n8AWaPYo3ErnvXzs7uIxqWvFUwrRKPA=;
	h=Date:From:To:Cc:Subject:From;
	b=bqM4YRDdA2/ZVN33gtvmNckqHd8YLSoiiNqjO63g0LPysaRQ3MD98/5LMrD0f5EbD
	 EkgMqcfdjo2kKPMRH0bHW0a7q7EN3SS98NPojY1DwYYXMY0ehkVYUmKc050GjtlT0D
	 9UOTLBzayxx1/kAikPUhlU8jvsmvsE3kma8UwW4JDUhItbHqQIGEI9J76Iuacwtocz
	 30aAKxp/Pu15bwwuQXMQ+CUqggA1e8vi1+43ZZfQSMrEfrl4Ky/z/1WU7p/9Nbfepi
	 eWwrsIjdgqou3FV5OFc+GgcnCaKwiuDrD9Vmxi83CJuTLM4MBsKmFuZHXBaxHFLPAS
	 E+7qQGmffsjoA==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vow05-0000000AOx2-2wfK;
	Sat, 07 Feb 2026 23:02:21 -0500
Message-ID: <20260208040156.005531619@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 07 Feb 2026 23:01:56 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 0/3] tracing: Clean up the snapshot and max tracer code
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

When tracing first was added it had latency tracers that used a separate
snapshot buffer to swap the current buffer being written to with a static
buffer that is only read. This later became a feature that user space could
use by attaching to the latency tracer snapshot buffer. But the buffer was
named max_buffer which is not what it is used for in all cases.

Rename the max_buffer name to snapshot_buffer.

The "use_max_tr" field of the tracer structure is only defined when
CONFIG_TRACER_MAX_TRACE is defined. To get rid of some of the #ifdefs in the
code around accesses of that field, use a helper function
tracer_uses_snapshot() that access the field when the config is defined, or
returns false if not.

Finally, since the latency tracers use the snapshot buffer and snapshot
buffers do not need latency tracers, have the TRACER_MAX_TRACE config select
TRACE_SNAPSHOT config and not the other way around. Also clean up the code
to properly protect the max tracer references and the snapshot references.

Changes since v1: https://lore.kernel.org/linux-trace-kernel/20260206193741.767171392@kernel.org/

- This separates the updates to snapshot buffer and max tracers from
  the last series. It was a rewrite.

Steven Rostedt (3):
      tracing: Rename trace_array field max_buffer to snapshot_buffer
      tracing: Add tracer_uses_snapshot() helper to remove #ifdefs
      tracing: Better separate SNAPSHOT and MAX_TRACE options

----
 kernel/trace/Kconfig          |   8 +-
 kernel/trace/trace.c          | 190 +++++++++++++++++++-----------------------
 kernel/trace/trace.h          |  44 ++++++----
 kernel/trace/trace_selftest.c |  10 +--
 4 files changed, 127 insertions(+), 125 deletions(-)
