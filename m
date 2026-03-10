Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDAC3E8C7E;
	Tue, 10 Mar 2026 20:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173426; cv=none; b=b2JCO1oXFiWsZbdR77rEmZbAEqrkM/uJxJ958NpDD3RjJPjSCt6g1bMjbeMQPBBKfidB5QXHa7hJW/qFCVGRGbKZAbNZ2NORRSN4wtWRoUeugicIShbjPCjEga96ZYMryv1BwtrZsoFwVH8NqIlm+KhzJfezpEML45rF1nFV420=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173426; c=relaxed/simple;
	bh=g3Qin43JOdng5JEhq1pTxOt5zCxSIkxPZc1syVcWxoU=;
	h=Message-ID:Date:From:To:Cc:Subject; b=mFWXUa8F6FxGKKL2d3QbD6a8JfO//xN7T9dApV2Eo3TTsZ6oG8EsPtFkhOXO7wbzNLTuG12ASq4/IE11U2VngnJiwO6vXF45tJLxfoDtFnpUf5eC45fbWDYYwmdjExSpTDKaXdeUtKrtflG2TlZZbmTrEhqa1zVq3OSw3BUb2B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6S227z/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6S227z/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A5EC19423;
	Tue, 10 Mar 2026 20:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773173426;
	bh=g3Qin43JOdng5JEhq1pTxOt5zCxSIkxPZc1syVcWxoU=;
	h=Date:From:To:Cc:Subject:From;
	b=p6S227z/mnvwydIeSDcnWj8DhbEHCz2EAyigp32c7ZqQ5nxIA91prUx/wWzubTl+o
	 JFOk5cTZ6PZ7V1rs96JctIbA/N+rnk2SyLfQwkbgUigHMcFO+2Y/rc7osFKjqQod+H
	 uOY/m7IugiuNhsFQvu3vG7egYDI1P47+N2It2Tz03Xc5nn+tdeq7aY+rBi7pejvSuI
	 2VsWHN9JmAJcIaaEy7TvzvCx2+u5ahx1/A5JIChlTtSH7rgBTj9KZr1hlMdDi2oM03
	 AGjzmeSboZOiKyH0D7nBjv6ssOKdSKRw4lIlkMYRqOv+W4jTQDcznwMwkr+daRNYWX
	 WlNGd3AYP94lw==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1w03PY-00000002kqP-2Ak7;
	Tue, 10 Mar 2026 16:10:36 -0400
Message-ID: <20260310200954.285663884@kernel.org>
User-Agent: quilt/0.69
Date: Tue, 10 Mar 2026 16:09:54 -0400
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
Subject: [PATCH v2 0/3] tracing: Read user data from futex system call trace event
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


Changes since v1: https://lore.kernel.org/all/20260303214735.002154462@kernel.org/

- Moved the printing of the futex parameters to kernel/futex/syscall.c to
  keep it closer to the actual system call.

- Moved the always_inline functions: futex_cmd_has_timeout()
  and futex_cmd_has_addr2() into include/linux/futex.h so that they
  can be both used by the futex and tracing syscall code.


Steven Rostedt (3):
      tracing: Have futex syscall trace event show specific user data
      tracing: Update futex syscall trace event to show more commands
      tracing: Show TID and flags for PI futex system call trace event

----
 include/linux/futex.h         |  38 +++++-
 kernel/futex/syscalls.c       | 129 ++++++++++++++++++---
 kernel/trace/trace_syscalls.c | 261 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 411 insertions(+), 17 deletions(-)

