Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918373E92A5;
	Tue, 10 Mar 2026 20:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173427; cv=none; b=BBt3eet9bO358TeW8jcwFhD9mwZHDI+wF0VR430r12UBipscwpoOWDQRiaa8zBe9Jop9L3DuqQvVxgtK6w+Wn99dzH8anyXoeG7EY9Q12ROn5OqWaQSOXw3GjV2rvQTxwZiF/9hMX+n5MxzN2I4W5986yeGM3+12LhtbtxvtQAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173427; c=relaxed/simple;
	bh=XfA5H3AsxhCs2jUx2EWo2pLzbnzAQC+9ctmRamPslRM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=YMNs54x7q/YxidYFcwOffwfQglUrxW2L/4nvpiQscK9Moc/HY72mXu9YnuxQQTgRqmV9SAGL7VOydBQNwoHwsfiT2DnwiA/52twCdRP20+jNjubcgSddy2C9R6jzelLuwdwVPPgoBOthE9SyQENBlAVAoXS4X4bnd4WG9OtDgrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivFo7AVu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivFo7AVu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E011C19423;
	Tue, 10 Mar 2026 20:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773173427;
	bh=XfA5H3AsxhCs2jUx2EWo2pLzbnzAQC+9ctmRamPslRM=;
	h=Date:From:To:Cc:Subject:References:From;
	b=ivFo7AVuHlM3ewrftnCH9GP+N0KGc7DPl9pBUivAsyi7aSw1ofLl7YXSikDo3uueR
	 OHd4+uM4NUBLx63ESalk79vBcgOjVQhHBHJxCKtmawe+L6m3LmQKrIVFYIz3KuIEpd
	 AhvZKNxHpZv31q4UsYAzWONh4zhQ8KQBeM5gpO9MErXehzdnX/xyHYxwFUwgOEtGtL
	 c2jFligw3z8pvDziTcXjosVDQSm489kUhjix852eQz5Po79bXAidYcFnfOUFvzJ7ro
	 25rjvKElKw+xWrb5v7pqXbI/HKPL4VMB3eZbk324JtHegTJtJczvnoUcZDjw7SZpqi
	 XuWBoe3bSGSxw==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1w03PZ-00000002krt-06Cg;
	Tue, 10 Mar 2026 16:10:37 -0400
Message-ID: <20260310201036.879130564@kernel.org>
User-Agent: quilt/0.69
Date: Tue, 10 Mar 2026 16:09:57 -0400
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
Subject: [PATCH v2 3/3] tracing: Show TID and flags for PI futex system call trace event
References: <20260310200954.285663884@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

For the futex system call trace event for FUTEX_LOCK_PI and
FUTEX_UNLOCK_PI commands, show the TID from the value (which is usually in
hex) as well as translate the flags (DIED and WAITERS).

 pi_mutex_hammer-1098    [000] .....   121.876928: sys_futex(uaddr: 0x560f40cc8180 (0x450) tid: 1104, FUTEX_LOCK_PI|FUTEX_PRIVATE_FLAG, val: 0, timespec: 0x7f2f9d4b1e50 (0.000100000))
 pi_mutex_hammer-1128    [000] .....   121.877120: sys_futex(uaddr: 0x560f40cc8180 (0x8000042a) tid: 1066 (WAITERS), FUTEX_LOCK_PI|FUTEX_PRIVATE_FLAG, val: 0, timespec: 0x7f2f8e493e50 (0.000100000))
 pi_mutex_hammer-1106    [000] .....   121.877242: sys_futex(uaddr: 0x560f40cc8180 (0x80000452) tid: 1106 (WAITERS), FUTEX_UNLOCK_PI|FUTEX_PRIVATE_FLAG, val: 0)

This makes it easier to see the hand off of a mutex and who the owner was.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/all/20260303174442.548b6524@gandalf.local.home/

- Updated to have the print processing in kernel/futex/syscall.c

 kernel/futex/syscalls.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index a46706d6bc6c..24d912d9b20d 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -211,6 +211,9 @@ void futex_print_syscall(struct seq_buf *s, int nr_args, unsigned long *args,
 	unsigned int op, cmd;
 	bool done = false;
 
+	op = args[1];
+	cmd = op & FUTEX_CMD_MASK;
+
 	for (int i = 0; !done && i < nr_args; i++) {
 
 		if (seq_buf_has_overflowed(s))
@@ -225,11 +228,30 @@ void futex_print_syscall(struct seq_buf *s, int nr_args, unsigned long *args,
 					seq_buf_printf(s, " (%u)", val);
 				else
 					seq_buf_printf(s, " (0x%x)", val);
+
+				switch(cmd) {
+				case FUTEX_LOCK_PI:
+				case FUTEX_UNLOCK_PI:
+					seq_buf_printf(s, " tid: %d",
+						       val & FUTEX_TID_MASK);
+
+					if (!(val & (FUTEX_OWNER_DIED|FUTEX_WAITERS)))
+						break;
+
+					seq_buf_puts(s, " (");
+					if (val & FUTEX_WAITERS)
+						seq_buf_puts(s, "WAITERS");
+					if (val & FUTEX_OWNER_DIED) {
+						if (op & FUTEX_WAITERS)
+							seq_buf_putc(s, '|');
+						seq_buf_puts(s, "DIED");
+					}
+					seq_buf_putc(s, ')');
+					break;
+				}
 			}
 			continue;
 		case 1:
-			op = args[i];
-			cmd = op & FUTEX_CMD_MASK;
 			if (cmd <= FUTEX_LOCK_PI2)
 				seq_buf_printf(s, ", %s", __futex_cmds[cmd]);
 			else
-- 
2.51.0


