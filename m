Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A4544CF5E;
	Tue, 31 Mar 2026 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774980815; cv=none; b=rtXP9F5bJxyzp86voFWw/T6imCaZBIDF1CVx25uniyMN2AIGJJt22Ve2ggWTJ4UMyXiurLNafMZTcd/Mi3sp+hCVB4tgQWhYdBNpeJx0b7tVHsP6TNhgRdygOa0MiB6zcvS/5oFLEZIxeGszcFA4RlxFaH/ksOQ9W/a3GXBpRwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774980815; c=relaxed/simple;
	bh=Tk38+TRw4xkKSFdeekYweRA+YfY9CMW4lNPi/6d0oqs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rT5KlN7GwZlqvpZRHw1PH/mMhNfkRHPP2nnceJ9j7a/02R12wsbqaVwU6yF2MCg78b3eS9dZ/8ByYSKU4TU2bOgRiCw8JguOjtAuEdCnYCdPnzG/7UrLwvzwuvaQtK4K2klQ9LjK3Xg20HSLGPiYXtrUp8OBMCm0vBYaXjgSq9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJZCST7S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJZCST7S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D2CC2BCB5;
	Tue, 31 Mar 2026 18:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774980814;
	bh=Tk38+TRw4xkKSFdeekYweRA+YfY9CMW4lNPi/6d0oqs=;
	h=Date:From:To:Cc:Subject:References:From;
	b=IJZCST7Sec29/h5dvWdwkzrurTVN8ch2PEXZ/yL/oetWZrXn8c4ydrEiMAMwCA+Sk
	 3TSlHVJK0HQQfp/d4cHxKvDiA+JG8Ep2FfxD6fm7YZ4jsYMs1t1dr7r3oklnqAuPss
	 rQlqLyYTJF0F6tVPifCVFi25GmENKbYG1FkUSlETNXmrN+ENf1JPzVJksS2wZxG/n6
	 f+nkUmP2zfCRuBDap0F9azt8k4hQbCozTYcR+qadKVno4RRSRXTVuQzDQaXcwxAlLE
	 i6FwNx2cymFPaMWTuZWhSZ9dYVEkgQdrCigfpB0WpFFRCkzwpN5Xe75D2WlrTzR/++
	 U0nHzdtaxM9Xg==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1w7dbl-0000000H8u4-1u44;
	Tue, 31 Mar 2026 14:14:33 -0400
Message-ID: <20260331181433.309946057@kernel.org>
User-Agent: quilt/0.69
Date: Tue, 31 Mar 2026 14:13:52 -0400
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
Subject: [PATCH v3 3/3] tracing: Show TID and flags for PI futex system call trace event
References: <20260331181349.062575155@kernel.org>
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

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/futex/syscalls.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 265ec0a236d0..8144781a9ff0 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -213,6 +213,9 @@ void futex_print_syscall(struct seq_buf *s, int nr_args, unsigned long *args,
 	unsigned int op, cmd;
 	bool done = false;
 
+	op = args[1];
+	cmd = op & FUTEX_CMD_MASK;
+
 	for (int i = 0; !done && i < nr_args; i++) {
 
 		if (seq_buf_has_overflowed(s))
@@ -227,11 +230,30 @@ void futex_print_syscall(struct seq_buf *s, int nr_args, unsigned long *args,
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


