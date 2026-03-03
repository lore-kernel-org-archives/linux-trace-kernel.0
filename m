Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAC83D3B3;
	Tue,  3 Mar 2026 02:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772505324; cv=none; b=CiWNCLJ1mQj8N1BtV9i6cpDnd6LBVGdXlxt3Arqc8jSe/FAwcSRD+qHidNIIbzxcbeV6Ln8ydQrh4OColyDxfw57SrUtUekIsiPrL3zSD6hMPCVdaaG5JwsFrK/bBEwN/jpEerjSqEbcUA8UmDW93HQjFwCCyALYsrsGLn40moY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772505324; c=relaxed/simple;
	bh=ESg7xJNf9DmDp3R0qn62psWT4KrAcRLjHoWmghfJrhE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=X90oFcK2QfDqcJ0mHR/hmlJpWcM66OXYKsAk1r7sC0/97vTvDGAIakDoWYilBRy0174ncLStyNR5mWRB50CDP3zGUzHIGi5WVooJYGRaB+nm7vVYuMmmFgaTSKnHWw1BgLQwyySpliUOytY7P+NOu/KlyKAM67lG3DgN3MZc4rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 492E31C6E3;
	Tue,  3 Mar 2026 02:35:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 9B6D120027;
	Tue,  3 Mar 2026 02:35:14 +0000 (UTC)
Date: Mon, 2 Mar 2026 21:35:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ftrace: Disable preemption in the tracepoint callbacks
 handling filtered pids
Message-ID: <20260302213546.156e3e4f@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 4gbrwfbqrenzpnaj6oh6drdi1s1fzkn8
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 9B6D120027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Ey3ILC8BD+HNi4XT0Ud+T5JmvIF6tf8k=
X-HE-Tag: 1772505314-329927
X-HE-Meta: U2FsdGVkX1/Iqjt/l8T4/hsCB0B2Ty4WJyk/Pqt5bcfZAAXUiiV/09Gn/JBz64BAWiBJS2ZYKn/xpUspsYNllg1vWdX8UC6zSsbxHTSvnqdLilKZT8kqB/MNfaHoV6U3Xgz+VFjMV8I7d1uOgA8iWivFJk9XNsl2iPv7cQe0/MbnAZneheUyQOnMc3Om50+3mC3kwKu6M4PxD6Vd/IKyZb6HVh5b4zfMDb82g1YdzTFpZXp8Rvn/HuQsUsofubZE/K0LwCxkxbhyvEhLb6l49ylxpuUIoJeuyrBm+LU7on9sCqBs4HwiOjdZG8H0z+Z85pZm27GztN8/4to7NwpRDgl/AkJr7J1TAeAEHafzZYPJ/+ZvLYYAvEaE2hvkiMrj

From: Steven Rostedt <rostedt@goodmis.org>

When function trace PID filtering is enabled, the function tracer will
attach a callback to the fork tracepoint as well as the exit tracepoint
that will add the forked child PID to the PID filtering list as well as
remove the PID that is exiting.

Commit a46023d5616e ("tracing: Guard __DECLARE_TRACE() use of
__DO_TRACE_CALL() with SRCU-fast") removed the disabling of preemption
when calling tracepoint callbacks.

The callbacks used for the PID filtering accounting depended on preemption
being disabled, and now the trigger a "suspicious RCU usage" warning message.

Make them explicitly disable preemption.

Fixes: a46023d5616e ("tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 1ce17c8af409..5274e0cab8f3 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -8611,6 +8611,7 @@ ftrace_pid_follow_sched_process_fork(void *data,
 	struct trace_pid_list *pid_list;
 	struct trace_array *tr = data;
 
+	guard(preempt)();
 	pid_list = rcu_dereference_sched(tr->function_pids);
 	trace_filter_add_remove_task(pid_list, self, task);
 
@@ -8624,6 +8625,7 @@ ftrace_pid_follow_sched_process_exit(void *data, struct task_struct *task)
 	struct trace_pid_list *pid_list;
 	struct trace_array *tr = data;
 
+	guard(preempt)();
 	pid_list = rcu_dereference_sched(tr->function_pids);
 	trace_filter_add_remove_task(pid_list, NULL, task);
 
-- 
2.51.0

