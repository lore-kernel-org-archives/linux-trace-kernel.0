Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E513C3C05;
	Tue,  3 Mar 2026 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772557420; cv=none; b=E+MsoveYX0KCCTeQ8xq4uCvEpKEyxXbB2N0aqu808QTwaHgApb7SYpgp8ZjNRDArJnaEIXIkIhu7zMuIZ2gy1/F2Ivqa2x4TsnbnLU25uFm34s9Gz8wK0tEqFfV9NnGWXf3H6TGuCBE/yG+M8ZjrTf/ugK+R954ic1GBps3/SMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772557420; c=relaxed/simple;
	bh=RcIs3EYS6s9uZO5MWk/0ruq+MB3NF/Vupp6QuKBDXZo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=IucZeU+faTsz8OW/AlaVQhZNM1ZIfOHcd+g/HtMqT8hGZJen0Y11CeXiG4zxd+LW5AigEMTMyGr1IINVpCA1mxf8T3rKO6ok38ILdwVu7EUoiK5+ysTDBvhPZIoCUaRzqCpYvV6qx2cV3btKmY5E5Y4JhSx8HQSZF81Ly9RoQts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 361D513A5C6;
	Tue,  3 Mar 2026 17:03:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 933902002D;
	Tue,  3 Mar 2026 17:03:30 +0000 (UTC)
Date: Tue, 3 Mar 2026 12:04:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Fix failure to read user space from system call
 trace events
Message-ID: <20260303120404.1824b894@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: n454ec9p84dhtc4yw7zyussxdxwt7ozr
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 933902002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19YQpWSiOmGxJ5W5ispY2vMbIOqLVIGRFs=
X-HE-Tag: 1772557410-793386
X-HE-Meta: U2FsdGVkX18iRlbM/ePx69n80EjffvrBN+ZUzQyrjSCIBkjKHVAX11MuHL4gYROSSYQfOSn34d23inSQNzEucsPG2kxAR5xCNbuMuZjNcDduTxmDV8ak7MMRsh70FTsy55ddS7wxfIu30qRnyT3wMCA4z74ZX3hD1Nu5hW5H8cXtxM2ZjMGvgUl3mQppn73WJEuc/0LZbsRjyc8fKYi+WeLPMjSR2nCJoS5qZBAUVmOYdCX3dqgVU+UVJX25LtVEwOc8pIuhwm4vlgMGH5NFiT1dHyuX6nzejpjRlt5rGjicp9BEPFJRFh23xrxrkw3YM+bl8ONg9iGE9H+86k6d3KVDtW3pe/mAN5sehIeKWEMCiCLBHGk34BRmI7w30yV4UHPRXMAxYuhA/UxcsAhDUQ==

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
 kernel/trace/trace.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 359ba2e73f49..cd45a09e0190 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6131,6 +6131,23 @@ char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
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

