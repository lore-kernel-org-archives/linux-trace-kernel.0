Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF2B353EEB;
	Wed,  4 Mar 2026 02:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772593064; cv=none; b=q4xLEkMRWJPrEp5IAX32vYEpq6B643ssxnQbjia7r/cO4KmNZeYIOqqAGzVRT9FLa2MmfiM13ktf4f5eNNyCv7GwavHbS0gVJZGpacgpHqFZ1Q2SRTFIYbegDOztFpmVZY19NR4AtLQHQP6m1zYEpQunR7qAYkwZU65IAhfmgug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772593064; c=relaxed/simple;
	bh=aJjaomSZzKrR57E1HQy8Fn5m2f58eMc5nlNxIHZOfG8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=N4l9GTqRZhORw8l165z7CeS/XhpXF9tbywsi2GtaoV7oX2DBnW5Q0sHB5VmeFU4LWHg1pU3I31UvwOWeWA0xDUjh8nl3BnWqYW8soOQHkXKvyMqhj8b663hfWBJea3JAp20WNRGres/n4ZQd3JjDbvQw9liO1srFQ/0zA0gh3Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id C611F140346;
	Wed,  4 Mar 2026 02:57:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 2DFE020012;
	Wed,  4 Mar 2026 02:57:40 +0000 (UTC)
Date: Tue, 3 Mar 2026 21:57:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Disable preemption in the tracepoint callbacks
 handling filtered pids
Message-ID: <20260303215738.6ab275af@fedora>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2DFE020012
X-Stat-Signature: waoenrcx4naznomeg4ppkik9uescooh9
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX183dxQlyeIQ+cv2GIbPJ9uY1tZP6FVVsG4=
X-HE-Tag: 1772593060-128877
X-HE-Meta: U2FsdGVkX1/nvthC+0B3KO7CvcwyeqH7Th9pTJIxJwCPq6lB98aGY5GTP013E43xrTkGcJnxpoJfKyNKtyBI4p8XAvmS0KS5e57xSACIWVTG4ghs9fRKj4aTG9epTV1a3cYPb/hg6IxtDHMB8yQZ+J2s7noFZXvQwyYCOSZUAyLOtbwXLMmdHQB95rHsAz3JPeN+MQGo1m/J/h6oiXSQADZHRCJjjkJBH10cNGU7RyD3tB1BpkAgzfmQq77SPUyOorHN1GB8REFI4Hl7Pnvz0r/qquZIpdLZeha35fmy4ELpKtzF41vEyiGsKSyW/btWKI9WMZBXli2BN9DBwAJvHfYzhSGvq/rx6p53RYIs1t63NVzup54CHQL3wHu1auoyDLPb449Dn2Vx7WYHTRjTmU3oRQ8lawdAuh1Ki5rXIW9UyJhP2IIILSP+nyhNHMmVx6Cyjpbod0DjIUVwdovIe7vcQHguySD/VURfDZUcqJU=

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Filtering PIDs for events triggered the following during selftests:

[37] event tracing - restricts events based on pid notrace filtering
[  155.874095]
[  155.874869] =============================
[  155.876037] WARNING: suspicious RCU usage
[  155.877287] 7.0.0-rc1-00004-g8cd473a19bc7 #7 Not tainted
[  155.879263] -----------------------------
[  155.882839] kernel/trace/trace_events.c:1057 suspicious rcu_dereference_check() usage!
[  155.889281]
[  155.889281] other info that might help us debug this:
[  155.889281]
[  155.894519]
[  155.894519] rcu_scheduler_active = 2, debug_locks = 1
[  155.898068] no locks held by ftracetest/4364.
[  155.900524]
[  155.900524] stack backtrace:
[  155.902645] CPU: 1 UID: 0 PID: 4364 Comm: ftracetest Not tainted 7.0.0-rc1-00004-g8cd473a19bc7 #7 PREEMPT(lazy)
[  155.902648] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
[  155.902651] Call Trace:
[  155.902655]  <TASK>
[  155.902659]  dump_stack_lvl+0x67/0x90
[  155.902665]  lockdep_rcu_suspicious+0x154/0x1a0
[  155.902672]  event_filter_pid_sched_process_fork+0x9a/0xd0
[  155.902678]  kernel_clone+0x367/0x3a0
[  155.902689]  __x64_sys_clone+0x116/0x140
[  155.902696]  do_syscall_64+0x158/0x460
[  155.902700]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  155.902702]  ? trace_irq_disable+0x1d/0xc0
[  155.902709]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  155.902711] RIP: 0033:0x4697c3
[  155.902716] Code: 1f 84 00 00 00 00 00 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
[  155.902718] RSP: 002b:00007ffc41150428 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
[  155.902721] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004697c3
[  155.902722] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
[  155.902724] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000003fccf990
[  155.902725] R10: 000000003fccd690 R11: 0000000000000246 R12: 0000000000000001
[  155.902726] R13: 000000003fce8103 R14: 0000000000000001 R15: 0000000000000000
[  155.902733]  </TASK>
[  155.902747]

The tracepoint callbacks recently were changed to allow preemption. The
event PID filtering callbacks that were attached to the fork and exit
tracepoints expected preemption disabled in order to access the RCU
protected PID lists.

Add a guard(preempt)() to protect the references to the PID list.

Cc: stable@vger.kernel.org
Fixes: a46023d5616e ("tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast")
Link: https://patch.msgid.link/20260303131706.96057f61a48a34c43ce1e396@kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index e989362c7709..a4c6469e15d0 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1039,6 +1039,7 @@ event_filter_pid_sched_process_exit(void *data, struct task_struct *task)
 	struct trace_pid_list *pid_list;
 	struct trace_array *tr = data;
 
+	guard(preempt)();
 	pid_list = rcu_dereference_raw(tr->filtered_pids);
 	trace_filter_add_remove_task(pid_list, NULL, task);
 
@@ -1054,6 +1055,7 @@ event_filter_pid_sched_process_fork(void *data,
 	struct trace_pid_list *pid_list;
 	struct trace_array *tr = data;
 
+	guard(preempt)();
 	pid_list = rcu_dereference_sched(tr->filtered_pids);
 	trace_filter_add_remove_task(pid_list, self, task);
 
-- 
2.51.0

