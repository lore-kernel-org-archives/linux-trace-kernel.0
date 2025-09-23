Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5163E321F3E;
	Tue, 23 Sep 2025 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632754; cv=none; b=HpTe/w7JCyJ5DyzYdBYlCsGu6+hAKFBiSWkbHvpLV4+9Ncs7Vr0hLnZ4EJNh5DKT2GIlEsuaXutuaimLt21kNbsvWaOvvwPR3RhgS9i6Nj80T21A6ttTLiPRCN9o15LrykYNcLeCgSoCHlA3wDie66Mq4efGZJ8W5eaeFHhtqHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632754; c=relaxed/simple;
	bh=MuLqyGbDmJEGOco6kler3imRlJOQ0leMTzdLfvljYFI=;
	h=Message-ID:Date:From:To:Cc:Subject; b=h905Hs9jBFNULuNobQ+cwgt1xKrCV8J7nOrVPFjq1oJyywXhFteVC1iQNFS1WYfTyivqZmuUt20k+kVcypLpK9DGUuxNu+nuMTixtBLpF02AP3RykaX6OMOqeCdEeQFRtt6vKQRdgKwqYClvxcnyCCbRJdHB8dQkqltZrvnm300=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ko7ltZo1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ko7ltZo1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7BEC4CEF5;
	Tue, 23 Sep 2025 13:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758632754;
	bh=MuLqyGbDmJEGOco6kler3imRlJOQ0leMTzdLfvljYFI=;
	h=Date:From:To:Cc:Subject:From;
	b=ko7ltZo17TJgnO6B08CAg4BDOOY48y1Spb2eFdTAgYyqzzgAGUnMMkoNn4tUvAJnX
	 ChKw41E99me4CZzPAUFUFf7HZ4g7bSlCq3hE1og+39wAVrJb3ky4qAMly5yT1fdIhz
	 FDZAACZKOCHQOKICEEC61RcelBZXJK6K3jKKtwQrHKb8g4A7RFENuHdxQjj5v30Iw+
	 UbcQukiDTJKAhpdQ+F6hqBpq/QS5UCdXPKko7PgsNW+F3VMCb2GokJWTGKfpZV1/aL
	 hWb0BpcuwjFYSHBV90vixDL701QUVIVKfUEzmw4nU7+QgikpvgYbBwwFPQ5hmIbJS9
	 SRCUEEBXaD+Dg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v12jh-0000000Cooe-2NAa;
	Tue, 23 Sep 2025 09:07:13 -0400
Message-ID: <20250923130457.901085554@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 23 Sep 2025 09:04:57 -0400
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
 Douglas Raillard <douglas.raillard@arm.com>
Subject: [PATCH v2 0/8] tracing: Show contents of syscall trace event user space fields
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

When a syscall trace event needs to read user memory, it reads the per CPU
sched switch counter. It then disables migration, enables preemption,
copies the user space memory into this buffer, then disables preemption again.
If the counter is the same as the original value the buffer is valid.
Otherwise it needs to try again. This is similar to how seqcount works, but
uses the per CPU sched switch counter as its sequence counter. If the counter
is not the same, it means another task scheduled in, and that task could have
used the same buffer and overwritten the data.

A new file is created in the tracefs directory (and also per instance) that
allows the user to shorten the amount copied from user space. It can be
completely disabled if set to zero (it will only display "" or (, ...)
but no copying from user space will be performed). The max size to copy is
hard coded to 128, which should be enough for this purpose.

This allows the output to look like this:

 sys_access(filename: 0x7f8c55368470 "/etc/ld.so.preload", mode: 4)
 sys_execve(filename: 0x564ebcf5a6b8 "/usr/bin/emacs", argv: 0x7fff357c0300, envp: 0x564ebc4a4820)
 sys_write(fd: 1, buf: 0x56430f353be0 (2f:72:6f:6f:74:0a) "/root.", count: 6)
 sys_sethostname(name: 0x5584310eb2a0 "debian", len: 6)
 sys_renameat2(olddfd: 0xffffff9c, oldname: 0x7ffe02facdff "/tmp/x", newdfd: 0xffffff9c, newname: 0x7ffe02face06 "/tmp/y", flags: 1)


Changes since v1: https://lore.kernel.org/linux-trace-kernel/20250805192646.328291790@kernel.org/

- Removed __rcu annotation to the fields that do not need RCU to protect
  them.

- Hide newsfstat around
  #if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
  as parisc failed to build without it. (kernel test robot)

- Fixed allocation of sinfo which used sizeof(sinfo) and not
  sizeof(*sinfo) (kernel test robot)

- Instead of incrementing a counter via the sched_switch tracepoint, use
  the nr_context_switches() API. (Mathieu Desnoyers).

- Use the length saved in the meta data of the event to limit the size of
  the string printed "%.*s", len, str.

- Add comment describing that the method to read the memory from user
  space is similar to how seqcount works.

- Hide kexec_file_load around
  #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
  to not break the i386 build.

- Added __user annotation to variable copying from user (kernel test robot)

- Change default to 63 (127 seemed too much)

- Change the max to 165 to fill in the extra data.

- Use the size macros of the max size and max args to calculate the size
  of the buffer to save the values in.

- Added new patch to show printable characters of binary arrays that are
  displayed.    


Steven Rostedt (8):
      tracing: Replace syscall RCU pointer assignment with READ/WRITE_ONCE()
      tracing: Have syscall trace events show "0x" for values greater than 10
      tracing: Have syscall trace events read user space string
      tracing: Have system call events record user array data
      tracing: Display some syscall arrays as strings
      tracing: Allow syscall trace events to read more than one user parameter
      tracing: Add syscall_user_buf_size to limit amount written
      tracing: Show printable characters in syscall arrays

----
 Documentation/trace/ftrace.rst |   8 +
 include/trace/syscall.h        |   8 +-
 kernel/trace/Kconfig           |  13 +
 kernel/trace/trace.c           |  52 +++
 kernel/trace/trace.h           |   7 +-
 kernel/trace/trace_syscalls.c  | 700 +++++++++++++++++++++++++++++++++++++++--
 6 files changed, 756 insertions(+), 32 deletions(-)
