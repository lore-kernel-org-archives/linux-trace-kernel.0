Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0E1421257;
	Fri, 24 Jul 2026 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784935916; cv=none; b=bYF2GspveW/TpnE80VHltfqKSXSlHRDNqtanasgXRyUg5PI6pBdf2TREuVPoT7+32Q4JVG+9DvQ8g4TK7YoYb7+rA2a92g+xBNHP42TuHtTZ93nogvoPZQFgRVy5oUFoGljg92k48JSNw6eVktDYtk1wQMhbyeQd8Trglh/dj8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784935916; c=relaxed/simple;
	bh=JgcE56mwcj6Gq2/UutaZ0JI+mRw33n6RJOT7YLZBzOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=baMbdqe1EOqGqmok7eTyj7DfqMVBk1riB/mLBHGVVwKXYKgW38XJ2MW0G2qyuWUJLOwMxvLPVvx7cdnIauJfnnnQiSU070DGoTjcz1TciMZWKH9jP8D7qd8MRDYf1LOuG5P7Gv1DA0oC5wTK8k4QDRPuYdHObE7ovR3FRxgL3UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 44A63401A3;
	Fri, 24 Jul 2026 23:31:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 883E717;
	Fri, 24 Jul 2026 23:31:45 +0000 (UTC)
Date: Fri, 24 Jul 2026 19:32:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>
Subject: [PATCH v2] tracing: perf: Fix stale head for perf syscall tracing
Message-ID: <20260724193210.03fae1d6@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ckftzyqne913jfk58py1yqrrrdc9mq8n
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 883E717
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19As+RF7zQz/DYlYsQ+HyofbEgPhO6q0Ck=
X-HE-Tag: 1784935905-371215
X-HE-Meta: U2FsdGVkX19DvBi8lcX2NimK9A+N1aQOFRD31ed8WcBHVcP05NQ89+uGIQFOV5SdoW7n7lQdd71mDQaqAVg3hOlPKb248GEOtAHLj9P/1TeoxEssR7Xi0VhfAn6FZ5xIo3voKzJgFs4XT4FQieO3strU2eZNJGOK4Hw5a+PmJiJdx6egfYCsJ0qizS63gLG63PsA99YvfDOhY3w57Cuy/lvaMVm5N6YA1k581zSP0ZkRccTPJ3rFfXbyFffBSGxXPY3uXIbzM/LXk28avvkQxkVrZIJyZtsyHZF3l6FqtUZXt9ya+jkH6d8an1arSCkJamNM9s6TXeKVbMdNftnGkjOZwdW6Zd2MtEfU8jYxrivyJFGAvpCWy0Nuh9c1P4H8XpJRRUeBnDRnle21OO9Duqj6kwjAshuYkmeUN/k0PoTLkHiEKbikH+s0W7i0Yq3ItYi/0AvwNdgTFiQKe5/OCw==

From: Steven Rostedt <rostedt@goodmis.org>

The code that can read the user space parameters of a system call may
enable preemption and migrate. The head of the per CPU perf events list
may be pointing to the wrong CPU event if the code migrates the task.

Reassign the head pointer if the system call event called the code that
may have caused a migration.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <>
Link: https://sashiko.dev/#/patchset/20260717173252.3431565-1-usama.arif%40linux.dev
Fixes: edca33a56297d ("tracing: Fix failure to read user space from system call trace events")
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/all/20260724184250.357e91f1@gandalf.local.home/

- Keep the shortcut out if the current CPU is not tracing the system call.
  Instead, reassign the head pointer only if the syscall_get_data() is called.

 kernel/trace/trace_syscalls.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index e98ee7e1e66f..8a4f3c75e39f 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -1451,6 +1451,11 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 		if (syscall_get_data(sys_data, args, &user_ptr,
 				     &size, user_sizes, &uargs, buf_size) < 0)
 			return;
+
+		/* The above may have caused a migration */
+		head = this_cpu_ptr(sys_data->enter_event->perf_events);
+		if (hlist_empty(head))
+			return;
 	}
 
 	/* get the size after alignment with the u32 buffer size field */
-- 
2.53.0

