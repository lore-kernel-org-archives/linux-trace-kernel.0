Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED9D1F0E2F;
	Mon, 20 Jan 2025 23:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737417440; cv=none; b=q0HoQIpVV2YryI7wTKns8rJe+GcTCZi8IndJ+AkjHK52YIq4p89z2JBR5NbEB5aI2JIEzYrU1WBgO7NnzMR+40wxYcqgOfC4oCA1XEqJXfKoSias+HiXazrIve2ZQ35BOB9Rc9sX8Fhpc/i5Z+44YX8U5CROHOiZRHwI/fKyv+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737417440; c=relaxed/simple;
	bh=VDAeEd7dekmEtPBzpN1a6SL9yozBUgqf3i5ntz/Glfs=;
	h=Message-ID:Date:From:To:Cc:Subject; b=QbAPMlMkIk2mVP3X1UzvfPIV/836jQbOw5R3Y9+IbcDpahO32XGfx40Yo98MZMzJMMiFwvQArdRjrnLJUylWuMT7TmELbSqgBVUlI03adNSNuU6nyX92tdnEZDff0Y7A/MR6px5n9Ckvps63rJZk/jTqo+9hRCy4oH5Gz0G5LJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A1AC4CEDD;
	Mon, 20 Jan 2025 23:57:19 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1ta1dx-0000000096i-1aQl;
	Mon, 20 Jan 2025 18:57:21 -0500
Message-ID: <20250120235655.144537620@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 20 Jan 2025 18:56:55 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ludwig Rydberg <ludwig.rydberg@gaisler.com>,
 Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH 0/2] lib/atomic64: ring-buffer: Fix infinite recursion on some 32bit archs
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

It was reported that the tracing ring buffer code would cause an infinite
recursion and crash on risc32 and sparc32 architectures. The reason is that
they use the generic atomic64 operations which call raw_spin_locks. As
raw_spin_locks can be traced this would cause an infinite recursion, because
the atomic64 operations call raw_spin_locks. Instead, the generic atomic64
operations should be calling arch_spin_locks as this is architecture
specific implementation and the locks that are taken should never have any
other locks taken while they are held, and are always taking with interrupts
disabled. This means they do not need to be tested by lockdep either.

Another issue was that locks should not be taken in NMI context and the ring
buffer can be called in NMI. If the arch uses the generic atomic64
operations, do not allow events to be recorded in NMI as the atomic64
operations are not safe in NMI context.

Steven Rostedt (2):
      ring-buffer: Do not allow events in NMI with generic atomic64 cmpxchg()
      atomic64: Use arch_spin_locks instead of raw_spin_locks

----
 kernel/trace/ring_buffer.c |  9 ++++--
 lib/atomic64.c             | 78 ++++++++++++++++++++++++++++------------------
 2 files changed, 55 insertions(+), 32 deletions(-)
