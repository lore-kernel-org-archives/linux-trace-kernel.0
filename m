Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173A9359A80;
	Tue,  3 Mar 2026 22:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772577861; cv=none; b=FTjhda8M+hJaiTIip7q7DLzov67TF7roURtXWotwNrq4Nn6+BV0bBz6i3LYgf8sl64ioABl5u4wy79TPQ7da+Vs1CBaWZ6mB6h2XQWfezAYYiRObMDSzkUV6tiNKisgkXtaulvT/bGofiq2uypzXEZbXbMCmKnU/pqgB8TSAjbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772577861; c=relaxed/simple;
	bh=4Ih/2o/t9doKo62D+kFikmb1MNMCyvP4c2VW3hJ0Kmc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWc3bidJZRZ5mrIXxwMc1xALJRAUOoXo99AwvL8sddODzXLpPvrkCqjCztKgoABJqQPrWi0fOXh1RPiJ7r5+3bSF1+1rMhDUOgjpiWlpcNqzMZgMn3LBV2TkwzLes+41RBVpt7UZNdxDEYnvMSkCv1Pt3MpURQAZgEhJGfYRKbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id D3ED0140107;
	Tue,  3 Mar 2026 22:44:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 530B220028;
	Tue,  3 Mar 2026 22:44:07 +0000 (UTC)
Date: Tue, 3 Mar 2026 17:44:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
 <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Brian Geffon
 <bgeffon@google.com>, John Stultz <jstultz@google.com>, Ian Rogers
 <irogers@google.com>, Suleiman Souhlal <suleiman@google.com>
Subject: [PATCH 3/2] tracing: Show TID and flags for PI futex system call
 trace event
Message-ID: <20260303174442.548b6524@gandalf.local.home>
In-Reply-To: <20260303214735.002154462@kernel.org>
References: <20260303214735.002154462@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 530B220028
X-Rspamd-Server: rspamout06
X-Stat-Signature: 8s5yqswghkyr3p1j18bswtjszc6m3hu4
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX199QX2aqCE6wlXIzurzdMJRFtW9F45R+pU=
X-HE-Tag: 1772577847-32625
X-HE-Meta: U2FsdGVkX18yDN8+OAhsaIQqgqHZeika6QDM1Ooh57Z4i4MlA89QFDkWFkGnCB7qM6srYmrasfQ01NhhBDlSad8X3a/hAiddu0a1AJR2eUGmb0eBmeNaKXW79XhkIaiwZ1Z7Bg2V1Qtbo5Jxz6j9FjaoxQRFFgL6z4yED14vzORZtKX49Ah8OWWbDh5lkPAVNjEhnMnU4YzOVk8EgIt7Sr7QY/PCK4rI2Tlrs0toiHau4LDdXwdKOAsBOtOR6St5ARBNYq57IwBUvdwRWN1iaz2znUBUJq6xqc/dCgmiLPCQSMTETDYMjonU/Z8p6FuIB9Hint6Un0fUA9YLI8GH+ydUq+SwYFhHCG0WJ0dEkvVpFFbAC2GoKsuRKRfzdxRH

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
 kernel/trace/trace_syscalls.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index d128dcb218a7..b3eddfee1a6b 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -300,6 +300,9 @@ sys_enter_futex_print(struct syscall_trace_enter *trace, struct syscall_metadata
 
 	trace_seq_printf(s, "%s(", entry->name);
 
+	op = trace->args[1];
+	cmd = op & FUTEX_CMD_MASK;
+
 	for (i = 0; !done && i < entry->nb_args; i++) {
 
 		if (trace_seq_has_overflowed(s))
@@ -314,11 +317,29 @@ sys_enter_futex_print(struct syscall_trace_enter *trace, struct syscall_metadata
 					trace_seq_printf(s, " (%u)", val);
 				else
 					trace_seq_printf(s, " (0x%x)", val);
+
+				switch(cmd) {
+				case FUTEX_LOCK_PI:
+				case FUTEX_UNLOCK_PI:
+					trace_seq_printf(s, " tid: %d", val & FUTEX_TID_MASK);
+
+					if (!(val & (FUTEX_OWNER_DIED|FUTEX_WAITERS)))
+						break;
+
+					trace_seq_puts(s, " (");
+					if (val & FUTEX_WAITERS)
+						trace_seq_puts(s, "WAITERS");
+					if (val & FUTEX_OWNER_DIED) {
+						if (op & FUTEX_WAITERS)
+							trace_seq_putc(s, '|');
+						trace_seq_puts(s, "DIED");
+					}
+					trace_seq_putc(s, ')');
+					break;
+				}
 			}
 			continue;
 		case 1:
-			op = trace->args[i];
-			cmd = op & FUTEX_CMD_MASK;
 			if (cmd <= FUTEX_LOCK_PI2)
 				trace_seq_printf(s, ", %s", __futex_cmds[cmd]);
 			else
-- 
2.51.0

