Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3EE3CF04A;
	Mon, 16 Mar 2026 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680836; cv=none; b=SWl/8UlkwLId1JGar9JK/xzAGCc/PBOIhQgEigMP4HggLunIH0RON10/NFTzhMqhnMc/Bqtie8AahYesCoT2j6vO+k0cjVUvcRCVa0SQJQbdTiOcMqP1JZL9uEkHSES0nbmvcRi5LeKklctootNsAuQrCWmx9LG99PqgVYlAzg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680836; c=relaxed/simple;
	bh=PRjom+pNrClZS2LbHVl0d3bGE2Rn8HAoHks5xNJDAZE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=T/c7Rp63g/kHsoCL6k7UnvcR6ij6+5Pj7LdaahJ2eVR8Rs6OlMEOzrqMjqzy54SyAMPZwZ+eAFkPD5abiQ/KpOM7spFgV2ESSl8ZHU2SX2HUWxR/uMSgWILojbiV9sYHmdiwMbDxXd75BrNdYo7jvgPy4KVWxOwk1LUxhNIoRtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id EBD12160368;
	Mon, 16 Mar 2026 17:07:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 5DDD01A;
	Mon, 16 Mar 2026 17:07:11 +0000 (UTC)
Date: Mon, 16 Mar 2026 13:07:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] tracing: Fix failure to read user space from system call
 trace events
Message-ID: <20260316130734.1858a998@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 5DDD01A
X-Stat-Signature: 7b5pioggbphnhg886h6uk66m855ywnfb
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+vFFZxYw3KMvJqe6bOH7CexgCq7Wc+Ddo=
X-HE-Tag: 1773680831-561193
X-HE-Meta: U2FsdGVkX1/ivveTbMJce5suHTDebzPIW5BRa8ITriPUoE0Js1HOQGz50zT67G5Qw01XpolA1Z3jMfTqAKjF9YIKMSjxlPSjOzQchhBRh2CGSN3llBiMzWVuTZ/YF2hlIa4hZk1GycLGMmb2NJWiijTjTL/IL7HyxpveX16IlDyLNB4ssQwxfWbnzI8SPEkSkY5Vcfb+CURFL7hjZY0rrEciWOx2xg3U9Othp09rI9TsxYXAoDOP1P6m/wh3yVTCfSDd9cwbJizvP4dzmrJSGRhJNrS2Q+u98xuDkM3rwW3f77j10Rs66MFHdGjOMueYZGB3fO8iT7B6qSGm3sC8P2lW2sbiFEvMrItu2fqLVwFdbkaNJeoIdAlor1WVRrxRU0LPkx9B74Ik1NR6oCBbwO9VZr8ECXf/qleeKOF+oQBzinx2vVahqGFOmO7w+kUAC4phkgQz79119cfhkRyaLbKBuXdNda+VVXXmYgyhFHE=

From: Steven Rostedt <rostedt@goodmis.org>

The system call trace events call trace_user_fault_read() to read the user
space part of some system calls. This is done by grabbing a per-cpu
buffer, disabling migration, enabling preemption, calling
copy_from_user(), disabling preemption, enabling migration and checking if
the task was preempted while preemption was enabled. If it was, the buffer
is considered corrupted and it tries again.

There's a safety mechanism that will fail out of this loop if it fails 100
times (with a warning). That warning message was triggered in some
pi_futex stress tests. Enabling the sched_switch trace event and
traceoff_on_warning, showed the problem:

 pi_mutex_hammer-1375    [006] d..21   138.981648: sched_switch: prev_comm=pi_mutex_hammer prev_pid=1375 prev_prio=95 prev_state=R+ ==> next_comm=migration/6 next_pid=47 next_prio=0
     migration/6-47      [006] d..2.   138.981651: sched_switch: prev_comm=migration/6 prev_pid=47 prev_prio=0 prev_state=S ==> next_comm=pi_mutex_hammer next_pid=1375 next_prio=95
 pi_mutex_hammer-1375    [006] d..21   138.981656: sched_switch: prev_comm=pi_mutex_hammer prev_pid=1375 prev_prio=95 prev_state=R+ ==> next_comm=migration/6 next_pid=47 next_prio=0
     migration/6-47      [006] d..2.   138.981659: sched_switch: prev_comm=migration/6 prev_pid=47 prev_prio=0 prev_state=S ==> next_comm=pi_mutex_hammer next_pid=1375 next_prio=95
 pi_mutex_hammer-1375    [006] d..21   138.981664: sched_switch: prev_comm=pi_mutex_hammer prev_pid=1375 prev_prio=95 prev_state=R+ ==> next_comm=migration/6 next_pid=47 next_prio=0
     migration/6-47      [006] d..2.   138.981667: sched_switch: prev_comm=migration/6 prev_pid=47 prev_prio=0 prev_state=S ==> next_comm=pi_mutex_hammer next_pid=1375 next_prio=95
 pi_mutex_hammer-1375    [006] d..21   138.981671: sched_switch: prev_comm=pi_mutex_hammer prev_pid=1375 prev_prio=95 prev_state=R+ ==> next_comm=migration/6 next_pid=47 next_prio=0
     migration/6-47      [006] d..2.   138.981675: sched_switch: prev_comm=migration/6 prev_pid=47 prev_prio=0 prev_state=S ==> next_comm=pi_mutex_hammer next_pid=1375 next_prio=95
 pi_mutex_hammer-1375    [006] d..21   138.981679: sched_switch: prev_comm=pi_mutex_hammer prev_pid=1375 prev_prio=95 prev_state=R+ ==> next_comm=migration/6 next_pid=47 next_prio=0
     migration/6-47      [006] d..2.   138.981682: sched_switch: prev_comm=migration/6 prev_pid=47 prev_prio=0 prev_state=S ==> next_comm=pi_mutex_hammer next_pid=1375 next_prio=95
 pi_mutex_hammer-1375    [006] d..21   138.981687: sched_switch: prev_comm=pi_mutex_hammer prev_pid=1375 prev_prio=95 prev_state=R+ ==> next_comm=migration/6 next_pid=47 next_prio=0
     migration/6-47      [006] d..2.   138.981690: sched_switch: prev_comm=migration/6 prev_pid=47 prev_prio=0 prev_state=S ==> next_comm=pi_mutex_hammer next_pid=1375 next_prio=95
 pi_mutex_hammer-1375    [006] d..21   138.981695: sched_switch: prev_comm=pi_mutex_hammer prev_pid=1375 prev_prio=95 prev_state=R+ ==> next_comm=migration/6 next_pid=47 next_prio=0
     migration/6-47      [006] d..2.   138.981698: sched_switch: prev_comm=migration/6 prev_pid=47 prev_prio=0 prev_state=S ==> next_comm=pi_mutex_hammer next_pid=1375 next_prio=95
 pi_mutex_hammer-1375    [006] d..21   138.981703: sched_switch: prev_comm=pi_mutex_hammer prev_pid=1375 prev_prio=95 prev_state=R+ ==> next_comm=migration/6 next_pid=47 next_prio=0
     migration/6-47      [006] d..2.   138.981706: sched_switch: prev_comm=migration/6 prev_pid=47 prev_prio=0 prev_state=S ==> next_comm=pi_mutex_hammer next_pid=1375 next_prio=95
 pi_mutex_hammer-1375    [006] d..21   138.981711: sched_switch: prev_comm=pi_mutex_hammer prev_pid=1375 prev_prio=95 prev_state=R+ ==> next_comm=migration/6 next_pid=47 next_prio=0
     migration/6-47      [006] d..2.   138.981714: sched_switch: prev_comm=migration/6 prev_pid=47 prev_prio=0 prev_state=S ==> next_comm=pi_mutex_hammer next_pid=1375 next_prio=95
 pi_mutex_hammer-1375    [006] d..21   138.981719: sched_switch: prev_comm=pi_mutex_hammer prev_pid=1375 prev_prio=95 prev_state=R+ ==> next_comm=migration/6 next_pid=47 next_prio=0
     migration/6-47      [006] d..2.   138.981722: sched_switch: prev_comm=migration/6 prev_pid=47 prev_prio=0 prev_state=S ==> next_comm=pi_mutex_hammer next_pid=1375 next_prio=95
 pi_mutex_hammer-1375    [006] d..21   138.981727: sched_switch: prev_comm=pi_mutex_hammer prev_pid=1375 prev_prio=95 prev_state=R+ ==> next_comm=migration/6 next_pid=47 next_prio=0
     migration/6-47      [006] d..2.   138.981730: sched_switch: prev_comm=migration/6 prev_pid=47 prev_prio=0 prev_state=S ==> next_comm=pi_mutex_hammer next_pid=1375 next_prio=95
 pi_mutex_hammer-1375    [006] d..21   138.981735: sched_switch: prev_comm=pi_mutex_hammer prev_pid=1375 prev_prio=95 prev_state=R+ ==> next_comm=migration/6 next_pid=47 next_prio=0
     migration/6-47      [006] d..2.   138.981738: sched_switch: prev_comm=migration/6 prev_pid=47 prev_prio=0 prev_state=S ==> next_comm=pi_mutex_hammer next_pid=1375 next_prio=95

What happened was the task 1375 was flagged to be migrated. When
preemption was enabled, the migration thread woke up to migrate that task,
but failed because migration for that task was disabled. This caused the
loop to fail to exit because the task scheduled out while trying to read
user space.

Every time the task enabled preemption the migration thread would schedule
in, try to migrate the task, fail and let the task continue. But because
the loop would only enable preemption with migration disabled, it would
always fail because each time it enabled preemption to read user space,
the migration thread would try to migrate it.

To solve this, when the loop fails to read user space without being
scheduled out, enabled and disable preemption with migration enabled. This
will allow the migration task to successfully migrate the task and the
next loop should succeed to read user space without being scheduled out.

Cc: stable@vger.kernel.org
Fixes: 64cf7d058a005 ("tracing: Have trace_marker use per-cpu data to read user space")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://patch.msgid.link/20260303120404.1824b894@gandalf.local.home

- Removed extra whitespace at end of comment line.

 kernel/trace/trace.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ebd996f8710e..bb4a62f4b953 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6783,6 +6783,23 @@ char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
 	 */
 
 	do {
+		/*
+		 * It is possible that something is trying to migrate this
+		 * task. What happens then, is when preemption is enabled,
+		 * the migration thread will preempt this task, try to
+		 * migrate it, fail, then let it run again. That will
+		 * cause this to loop again and never succeed.
+		 * On failures, enabled and disable preemption with
+		 * migration enabled, to allow the migration thread to
+		 * migrate this task.
+		 */
+		if (trys) {
+			preempt_enable_notrace();
+			preempt_disable_notrace();
+			cpu = smp_processor_id();
+			buffer = per_cpu_ptr(tinfo->tbuf, cpu)->buf;
+		}
+
 		/*
 		 * If for some reason, copy_from_user() always causes a context
 		 * switch, this would then cause an infinite loop.
-- 
2.51.0

