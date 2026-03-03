Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE283D75D0;
	Tue,  3 Mar 2026 21:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574548; cv=none; b=B3zJzIuLa086NYMZNqy2Lr4r+Ulm3qEvN2yYL+bTcRmmO/TZwDF+FDxindsNiIevT/+NChrdwmFqEXLVMgJ/oHovUy1QOyGcJ4NXbWxXNOn20fOXah3v+1yW9j9d3Rqg3vdUEUIA+I/n3M2w0JYocu2g1zcByB0htyq/gr4FUek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574548; c=relaxed/simple;
	bh=Tx8ArC1nfoXdrE+zu868PeLk0VTTYf+uHRPcFakUZAk=;
	h=Message-ID:Date:From:To:Cc:Subject; b=GbvSHXNqw+JBPf1wpqFrXrMy365stfvd+ZrAU65zprppR/PwyRaC9D7FsW+E10sGzT2Mvge6uTh/y0S5f0c9Uuqb5JRXREXgSOd+YUuIYB77iPYUeXOHq8dIwWYQhYB3m2+UUGa/vvz2GX2PyGSuHBIY7S33Vk82VZvjZpTjcJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WakEttWs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WakEttWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839BBC116C6;
	Tue,  3 Mar 2026 21:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772574547;
	bh=Tx8ArC1nfoXdrE+zu868PeLk0VTTYf+uHRPcFakUZAk=;
	h=Date:From:To:Cc:Subject:From;
	b=WakEttWsU02s9Xhao5YRsPWBbcNpklp4k5Xo+wW5DiASuZtogdtTh/C8A+0hkwq3H
	 FWJFMbkU+h5tPAwCFsOF50Oapz/LYlX/Qjrvd8KBGplFenDaOkt3XLpwLN6cIiUnZ/
	 PbIEOGClzq6ALauOG5hQ7EXl3ejxV1EG5W7ge2Cv8FA0cnO1WyWx38/R9VBbbzVGO7
	 F/OV+AmjZ194LKCz2SYu4ZmwSFd9j4RFvegfqqvq7txCIg0Kgt+dSgA1H43urQ2i7L
	 8pHMeetAMOmcbK3v/baWs45xTjur+QAWZk+6FlIQL6dKIB0G1YbaYWkOMO8oVUuUSq
	 qOtXRKmfVM9qw==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vxXcc-00000002tki-1gFB;
	Tue, 03 Mar 2026 16:49:42 -0500
Message-ID: <20260303214735.002154462@kernel.org>
User-Agent: quilt/0.69
Date: Tue, 03 Mar 2026 16:47:35 -0500
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
Subject: [PATCH 0/2] tracing: Read user data from futex system call trace event
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

   futex_requeue-1431    [004] .....   154.082233: sys_futex(uaddr: 0x7ffcadad2ff8 (0), FUTEX_WAIT, val: 0, timespec: 0x7f0785f83e90 (0.030000000))
   futex_requeue-1421    [002] .....   154.092286: sys_futex(uaddr: 0x7ffcadad2ff8 (0), FUTEX_CMP_REQUEUE, val: 3, val2: 0x7, uaddr2: 0x7ffcadad2ffc (0), val3: 0)
   futex_requeue-1421    [002] .....   154.092321: sys_futex(uaddr: 0x7ffcadad2ffc (0), FUTEX_WAKE, val: 2147483647)
     futex_waitv-1433    [006] .....   154.111394: sys_futex(uaddr: 0x55ed4a768554 (0), FUTEX_WAKE|FUTEX_PRIVATE_FLAG, val: 1)
     futex_waitv-1435    [002] .....   154.128186: sys_futex(uaddr: 0x7f035fa40000 (0), FUTEX_WAKE, val: 1)


Steven Rostedt (2):
      tracing: Have futex syscall trace event show specific user data
      tracing: Update futex syscall trace event to show more commands

----
 kernel/trace/trace_syscalls.c | 370 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 367 insertions(+), 3 deletions(-)
