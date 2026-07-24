Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E137473C87;
	Fri, 24 Jul 2026 22:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784932964; cv=none; b=aVDCifxxNZWjwQpjdrsby+1MFQQuRDT6iK7M6u0mUEeVlXSXWmS1R93vNEFNeje/8nrxXJ/r12D4FamDUbt7lH+gW9DZ2/23r7IZ/4ftQwUrfhp8YasXtQcTnw2lEJ3zuFdEtr/k5Hkt/f5PaahVEUMLsS4jGdqiM0NRAOqPMGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784932964; c=relaxed/simple;
	bh=K5m1c0+F4247yANYiHa2rY4YwrOMCanKduPUtQe+2tI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Zp62c8hJk9xdDvDJMQe6FXjdP76DU5wAZmQpZk3nMl/9GI/q6BdIGFuhifZbmxjQM/MSgZbrtY27iYjgmnU9iQpjbigM+1UeRmGQw2SocJrwYm9AwVNEaMf/JXUgs1Wev7rYo9/iSpvc0O8Bv6rBjAb9xT2DcTU/IXM4OiIfIdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 8D2D3801CB;
	Fri, 24 Jul 2026 22:42:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id A47D220029;
	Fri, 24 Jul 2026 22:42:26 +0000 (UTC)
Date: Fri, 24 Jul 2026 18:42:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>
Subject: [PATCH] tracing: perf: Fix stale head for perf syscall tracing
Message-ID: <20260724184250.357e91f1@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: cbqk6kgbkaq1dim79f19obs9xp766ix5
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: A47D220029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18nMpjcVNIQwkq4gGec3IPyBftJ+bLkX84=
X-HE-Tag: 1784932946-355235
X-HE-Meta: U2FsdGVkX19cXiA6HQso88AG41tz8JlMyQb2siCPo8dFNxpvp6htKAMc9bdAKgmuMdrooY+gtv86fnwn7SdIxK+bQaL6PtccJkC1/5ImopxPUIMoKFrJhwwvOIUpdRKIFNfM5UKGmVwyMPfVcLVhbGcQLKBVe3hKkbVglxWKyM2bTFboVdtXbREgkHor/6aYgBm2hRaALogrJxxOQUSCHgfXZoEMK7QNN991QS+CBCj66rnZ4AGCz6M2a/uBf65Izxe5Im1E52ymMPHy5n1jD7crn0tQxjGA7oABymQJ9d/tGRWl+EklUfdXeaWcF5uuuaqBXh9hKzNbTNSXJnY7cUjhKtEShyBIB8jWCv6a/3pk9XaYU2gpfIgF7J+/L5T6SC9RYdDNQHKFxpnjLJbslpNSVSrLYphZD978878Xc11biVPUiX/sar5p3IxSGfqTStTWHlKQtxQlMheklrqzFg==

From: Steven Rostedt <rostedt@goodmis.org>

The code that can read the user space parameters of a system call may
enable preemption and migrate. The head of the per CPU perf events list
may be pointing to the wrong CPU event if the code migrates.

Move the taking assignment of the head pointer to after the faulting code
is called.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260717173252.3431565-1-usama.arif%40linux.dev
Fixes: edca33a56297d ("tracing: Fix failure to read user space from system call trace events")
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_syscalls.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index e98ee7e1e66f..e541e964d193 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -1440,19 +1440,20 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	 */
 	guard(preempt_notrace)();
 
-	head = this_cpu_ptr(sys_data->enter_event->perf_events);
-	if (hlist_empty(head))
-		return;
-
 	/* Check if this syscall event faults in user space memory */
 	mayfault = sys_data->user_mask != 0;
 
 	if (mayfault) {
+		/* Enables preemption and may migrate */
 		if (syscall_get_data(sys_data, args, &user_ptr,
 				     &size, user_sizes, &uargs, buf_size) < 0)
 			return;
 	}
 
+	head = this_cpu_ptr(sys_data->enter_event->perf_events);
+	if (hlist_empty(head))
+		return;
+
 	/* get the size after alignment with the u32 buffer size field */
 	size += sizeof(unsigned long) * sys_data->nb_args + sizeof(*rec);
 	size = ALIGN(size + sizeof(u32), sizeof(u64));
-- 
2.53.0

