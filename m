Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4102727EE;
	Sun,  8 Feb 2026 03:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770521046; cv=none; b=WsaChErZMGWcp+AID0Kw06A+wz/JexObQi9/Ykk46FlhCh3UrqCK7N+E49T2tH9z0M3e+HGmRCrm1+kvVyXQJN8sFY/hsJGOenm47JpDzPTHdNVGbQELj91KhgtdJ4OWNdxEfjA3xx92ZY5oe7JA3r+A7dP1uFo06r/DLniFWrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770521046; c=relaxed/simple;
	bh=TVY5/Od+heBqjIQ5+vq6IRh4sdsQMghBwJtHFLa5qHM=;
	h=Message-ID:Date:From:To:Cc:Subject; b=iaLY5zxVHYrkJXrwmaqQ7Yjw+rvSQoUPgBZbEYf5ow/eAXCsQiG9M0ZzJI5ARjahnbR/Z40Zymt4KWuegewjjI1SOd2SyvE/9foYQRX7z5b000ev4BR/45tWp5Tlgn2KIMTQ2kP9EklgdASaQLW7zwAKhJ+K5UftUd+RD4Agl70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3qcukM0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3qcukM0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF7DC4CEF7;
	Sun,  8 Feb 2026 03:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770521046;
	bh=TVY5/Od+heBqjIQ5+vq6IRh4sdsQMghBwJtHFLa5qHM=;
	h=Date:From:To:Cc:Subject:From;
	b=E3qcukM08yHgDVRPCODDCzP44qwom6OZ3gBVSyy/yhcaU8rWwp75+0QBe4WEMfMYB
	 gtIoKkavzpsWZiDsxH9KR+dBQ5z0tdzaVrh35izmNlPnat0/8PFvCLTHQ4Yt7uCb7J
	 YcJFtp0qGNqCVRw3TlVegBN8EO5i9ha4jbPDz5fXx3ofmgXAPSDyiKiqo0S5uT5Zwd
	 Kxix+D3d7poBRULC0jnDkOEucTnLLXZg4fzOuSuL1d61cA0s3xWesd06TTkLqRjKlC
	 WcP7VLb/p0RsSU/OVCxyBdHNVSfa5HvVs5QTdfhEV/1gSmeaksitnODWtaf5zSj4gH
	 9UyA3FxoVcRag==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vovPl-0000000AOak-1uxG;
	Sat, 07 Feb 2026 22:24:49 -0500
Message-ID: <20260208032417.262341179@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 07 Feb 2026 22:24:17 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 00/10] tracing: Clean up trace.c and move some code into other files
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

The trace.c file was a dumping ground for most tracing code. Start
organizing it better by moving various functions out into their own files.

The trace.c file is almost 12000 lines in size, this is an effort to
bring that number down.

- Move some generic always_inline functions into trace.h

- Move the trace_printk functions into the existing trace_printk.c file.
  This also required some clean up of the code.

- Move the pid filtering code into a new file: trace_pid.c.

This is mostly a non-functional change. But due to some clean ups, there
is still slightly some functional changes (but for the better).

This will also cause some existing code being worked on to conflict,
but I'll handle that.

Changes since v1: https://lore.kernel.org/linux-trace-kernel/20260206193741.767171392@kernel.org/

- These patches did not change, but the snapshot code movement was removed.

- This version has been tested more, but still needs more testing.

Steven Rostedt (10):
      tracing: Make tracing_disabled global for tracing system
      tracing: Make tracing_selftest_running global to the tracing subsystem
      tracing: Move __trace_buffer_{un}lock_*() functions to trace.h
      tracing: Move ftrace_trace_stack() out of trace.c and into trace.h
      tracing: Make printk_trace global for tracing system
      tracing: Make tracing_update_buffers() take NULL for global_trace
      tracing: Have trace_printk functions use flags instead of using global_trace
      tracing: Use system_state in trace_printk_init_buffers()
      tracing: Move trace_printk functions out of trace.c and into trace_printk.c
      tracing: Move pid filtering into trace_pid.c

----
 kernel/trace/Makefile       |   1 +
 kernel/trace/trace.c        | 779 +-------------------------------------------
 kernel/trace/trace.h        |  80 ++++-
 kernel/trace/trace_events.c |   2 +-
 kernel/trace/trace_kprobe.c |   2 +-
 kernel/trace/trace_pid.c    | 246 ++++++++++++++
 kernel/trace/trace_printk.c | 431 ++++++++++++++++++++++++
 7 files changed, 771 insertions(+), 770 deletions(-)
 create mode 100644 kernel/trace/trace_pid.c
