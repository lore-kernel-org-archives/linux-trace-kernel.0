Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33A5367;
	Tue,  5 Aug 2025 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422324; cv=none; b=bwP3cl9MSBNo4hrZykuib9wLn2A0o+7Pb0B2Mfp+FE4bwTHwFgeFJaoRKhrbLZtcPLhcWak7ITlh9V7zEOBFembA1QzzGtpy/4xePr36P6aYqaQHHxtwS62vw1AU1TIzRqbfG6ZIqC6GlEZuXMFr02j6q63KaJvfNFg2/via/e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422324; c=relaxed/simple;
	bh=3l3+3RWxNKOOVwx/Liaox9HiydeNJkDezI9anxO0vb0=;
	h=Message-ID:Date:From:To:Cc:Subject; b=NKlwvu8hJzKwxBTtCFZwYkYjyvadC3mce7nbybSkeARuNo4DIK1oyoaTATxZ/w8WfexlFZ6+a4IEmPDE8J4Sq1s9+jxx0io10ZzijoDsQLATWAY7kBmY5jpbB1iTclph8kScCaXAH2+rtYdJzKwOkjFCgiSCQIeg4q7+7XNxVoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eutS6mZ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eutS6mZ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5785DC4CEF0;
	Tue,  5 Aug 2025 19:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754422324;
	bh=3l3+3RWxNKOOVwx/Liaox9HiydeNJkDezI9anxO0vb0=;
	h=Date:From:To:Cc:Subject:From;
	b=eutS6mZ1kE4OigkeCl8E7Ez+kb1zDhaJhb7VFdsDvYdOomzZUE+5lwb3iO06GA356
	 775Grv+h3jHflaAE67vECXpDoMfaJOhKHHuWcoaejA7LjPmS4LhCo93ZMKdLvf3XTz
	 FMJmWpgaHi+z4YUIxdJpJSxB3hwwUdbFFzj9rrvJ4wtJnsNjNR8PW5u3ZF2NmlIVas
	 VKP12lwi8ua4lM9sP4UoBbyjmEbRZ4KcPB3bzH6dWgjiDChSNT+vE+nu9IXeiOLjnd
	 85qwNjGi9mFMvd73mSUpTyGB7nuVsNfP8ibzbe9ttsvB/TsDurxAkWewnQDXOoK8m7
	 O3WTj/xfthpcw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ujNOk-0000000AtC9-30cD;
	Tue, 05 Aug 2025 15:32:34 -0400
Message-ID: <20250805192646.328291790@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 05 Aug 2025 15:26:46 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>,
 Tom Zanussi <zanussi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ian Rogers <irogers@google.com>,
 aahringo@redhat.com,
 Douglas Raillard <douglas.raillard@arm.com>
Subject: [PATCH 0/7] tracing: Show contents of syscall trace event user space fields
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


As of commit 654ced4a1377 ("tracing: Introduce tracepoint_is_faultable()")
system call trace events allow faulting in user space memory. Have some of
the system call trace events take advantage of this.

Introduce a way to read from user space addresses from the syscall trace
event. The way this is accomplished is by creating a per CPU temporary
buffer that is used to read unsafe user memory.

When a syscall trace event needs to read user memory, it reads a per CPU
counter that gets updated every time a user space task is scheduled on the
CPU. It then enables preemption, copies the user space memory into this
buffer, then disables preemption again. If the counter is less than two
from its original value the buffer is valid. Otherwise it needs to try
again.

The reason to check for less than two and not equal to the previous value
is because scheduling kernel tasks is fine. Only user space tasks will
write to this buffer. If the task schedules out and only kernel tasks run
and the tasks schedules back in, the counter will be incremented by one.

A new file is created in the tracefs directory (and also per instance) that
allows the user to shorten the amount copied from user space. It can be
completely disabled if set to zero (it will only display "" or (, ...)
but no copying from user space will be performed). The max size to copy is
hard coded to 128, which should be enough for this purpose.

This allows the output to look like this:

 sys_access(filename: 0x7f8c55368470 "/etc/ld.so.preload", mode: 4)
 sys_execve(filename: 0x564ebcf5a6b8 "/usr/bin/emacs", argv: 0x7fff357c0300, envp: 0x564ebc4a4820)
 sys_write(fd: 0xa, buf: 0x5646978d13c0 (01:00:05:00:00:00:00:00:01:87:55:89:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00), count: 0x20)
 sys_sethostname(name: 0x5584310eb2a0 "debian", len: 6)
 sys_renameat2(olddfd: 0xffffff9c, oldname: 0x7ffe02facdff "/tmp/x", newdfd: 0xffffff9c, newname: 0x7ffe02face06 "/tmp/y", flags: 1)

Steven Rostedt (7):
      tracing: Replace syscall RCU pointer assignment with READ/WRITE_ONCE()
      tracing: Have syscall trace events show "0x" for values greater than 10
      tracing: Have syscall trace events read user space string
      tracing: Have system call events record user array data
      tracing: Display some syscall arrays as strings
      tracing: Allow syscall trace events to read more than one user parameter
      tracing: Add syscall_user_buf_size to limit amount written

----
 Documentation/trace/ftrace.rst |   7 +
 include/trace/syscall.h        |   8 +-
 kernel/trace/Kconfig           |  13 +
 kernel/trace/trace.c           |  52 +++
 kernel/trace/trace.h           |   3 +
 kernel/trace/trace_syscalls.c  | 697 +++++++++++++++++++++++++++++++++++++++--
 6 files changed, 750 insertions(+), 30 deletions(-)
