Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4F32D8795;
	Tue, 31 Mar 2026 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774980815; cv=none; b=GCFTK+yNyYwrXs1tOxAogNJ/Wq8T7PtJJcvSmwqONYecThZkEYBARcjUaX4AoV8ajGFEabJgNQ/5FcWBVmtLUC8xBSWScIquKZbUaXO4HskMIHoWbPONH4BPjFQJ/XlmNZhCrsmL5sDh32jtsPFmeOWXVgOENooYfTfawqeqyNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774980815; c=relaxed/simple;
	bh=3yAQyAuRQsfHVvAhjVJdp/nnHilwLzVLtgJLUyZFeJY=;
	h=Message-ID:Date:From:To:Cc:Subject; b=LgRtitEi3zWsgrHTryRXA51MMXJydkb9RNmMWRXB5OeapTZ9l6ad63I58f8RRThjfKP/zF9eydbvDu0v6vNYb4Am2znGjQ8ioe8K43CyvUaeNLf0Q6nr9bmgKxsU1fxpxhY+6fGKz9qCroBji1yNb7z/o8xv8JI+Bos+yecyBg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V025tcrS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V025tcrS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E3DC19424;
	Tue, 31 Mar 2026 18:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774980814;
	bh=3yAQyAuRQsfHVvAhjVJdp/nnHilwLzVLtgJLUyZFeJY=;
	h=Date:From:To:Cc:Subject:From;
	b=V025tcrS7CnhWttvu3KRVbYW8VPauOEUp/9FR1kRkrfGfleNVG+XvXYOPaiFLLGNA
	 a4QGRyQfF+GHK2C8dwMLrKZzNc/iPgZF/Wnogtl/6cy1oW+xqPxGntZTjirln31IJQ
	 9cYeRe/JsTp4rZ8yQFYvv4tbnK1/G8ClusXyz64pKlTvBqdHhZXp7tp+VPhZSpMui8
	 V5EPxlTqfFPpGKcrzAgTuKQJfZD73cAxns+E6XvTJoHbWOb/ppoDJI8+2KZNBZgiVj
	 pMARbYIVt2F1M890qQlqQJUWIMC9xurE1eKfEcHQXJdfm3V+ssGJA1qCMH5GDyDP/C
	 cDE2cbUpoCv7A==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1w7dbk-0000000H8sZ-44LZ;
	Tue, 31 Mar 2026 14:14:32 -0400
Message-ID: <20260331181349.062575155@kernel.org>
User-Agent: quilt/0.69
Date: Tue, 31 Mar 2026 14:13:49 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>,
 Brian Geffon <bgeffon@google.com>,
 John Stultz <jstultz@google.com>,
 Ian Rogers <irogers@google.com>,
 Suleiman Souhlal <suleiman@google.com>
Subject: [PATCH v3 0/3] tracing: Read user data from futex system call trace event
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

We are looking at the performance of futexes and require a bit more
information when tracing them.

The two patches here extend the system call reading of user space to
create specific handling of the futex system call. It now reads the
user space relevant data (the addr, utime and addr2), as well as
parses the flags. This adds a little smarts to the trace event as
it only shows the parameters that are relevant, as well as parses
utime as either a timespec or as val2 depending on the futex_op.

Here's an example of the new output:

 sys_futex(uaddr: 0x56196292e830 (0), FUTEX_WAKE|FUTEX_PRIVATE_FLAG)
 sys_futex(uaddr: 0x56196292e834 (0x4a7) tid: 1191, FUTEX_UNLOCK_PI|FUTEX_PRIVATE_FLAG)
 sys_futex(uaddr: 0x56196292e834 (0) tid: 0, FUTEX_LOCK_PI|FUTEX_PRIVATE_FLAG)
 sys_futex(uaddr: 0x56196292e830 (0), FUTEX_WAIT|FUTEX_PRIVATE_FLAG)
 sys_futex(uaddr: 0x56196292e838 (0), FUTEX_WAIT_REQUEUE_PI|FUTEX_PRIVATE_FLAG, timespec: 0x7ffc1b91a9f0 (163.048528790), uaddr2: 0x56196292e834 (4aa), val3: 0)
 sys_futex(uaddr: 0x56196292e834 (0x4aa) tid: 1194, FUTEX_LOCK_PI|FUTEX_PRIVATE_FLAG)
 sys_futex(uaddr: 0x56196292e838 (0), FUTEX_WAIT_REQUEUE_PI|FUTEX_PRIVATE_FLAG, timespec: 0x7ffc1b91a9f0 (163.048528790), uaddr2: 0x56196292e834 (800004aa), val3: 0)
 sys_futex(uaddr: 0x7f7ed6b29990 (0x4ab), FUTEX_WAIT_BITSET|FUTEX_CLOCK_REALTIME)
 sys_futex(uaddr: 0x56196292e834 (0x800004aa) tid: 1194 (WAITERS), FUTEX_LOCK_PI|FUTEX_PRIVATE_FLAG)
 sys_futex(uaddr: 0x56196292e838 (0), FUTEX_WAIT_REQUEUE_PI|FUTEX_PRIVATE_FLAG, timespec: 0x7ffc1b91a9f0 (163.048528790), uaddr2: 0x56196292e834 (800004aa), val3: 0)
 sys_futex(uaddr: 0x56196292e834 (0x800004aa) tid: 1194 (WAITERS), FUTEX_LOCK_PI|FUTEX_PRIVATE_FLAG)

Changes since v2: https://lore.kernel.org/all/20260310200954.285663884@kernel.org/

- Removed unused "buf" variable (kernel test robot)

- Iterate __futex_cmds[] make the print statement.
  Note this required exposing __futex_cmds[] to trace_syscall.c
  (Masami Hiramatsu)

- Added back val statement (with the move to futex/syscall.c the
  third parameter was dropped).

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
futex/core

Head SHA1: 79b0609ad15b24d0bbfb1790e17902a6c210ae69


Steven Rostedt (3):
      tracing: Have futex syscall trace event show specific user data
      tracing: Update futex syscall trace event to show more commands
      tracing: Show TID and flags for PI futex system call trace event

----
 include/linux/futex.h         |  39 ++++++-
 kernel/futex/syscalls.c       | 137 +++++++++++++++++++++---
 kernel/trace/trace_syscalls.c | 237 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 396 insertions(+), 17 deletions(-)
