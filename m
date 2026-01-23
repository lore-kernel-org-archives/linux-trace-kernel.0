Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC1722D7B1;
	Fri, 23 Jan 2026 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769183632; cv=none; b=GHbNaUO5XYTTe1gDvx1WB5yx/mgkXPZSycP1JEkQgEu153cAyDFXg8rBrxdhToLLML79MOkMklJgjYvCuBx218cuHzWpvydXm1a+zvv73PflTEYlP4nqoSncojtd9eThBt76+ZZgHgHv/X8afR5Vsz1J2XRzRRfjoyuhZbg/KGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769183632; c=relaxed/simple;
	bh=WIcz4SEjB3JTdLfmWpv8/EmdIZIDGm9Lagq/NT5yDBI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qSZBJH5du8Zl8cX3Xj8ypBJKwlZL58kwFT/1ZBkcnDHVtSLj+onYxvAKtZt0r9LMOdsUDPmyD9N1yDqj5sk9nGQagOfBgJOW2euN6vPUdsSae0uO6LicT61hwm2xIdUcC5qCsQUi4z97Uh8RjVtxz/0cpq6wq9nNbqfJxgr7Tso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 28FC78B749;
	Fri, 23 Jan 2026 15:53:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 7F5B920010;
	Fri, 23 Jan 2026 15:53:47 +0000 (UTC)
Date: Fri, 23 Jan 2026 10:54:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH] tracing: Up the hist stacktrace size from 16 to 31
Message-ID: <20260123105415.2be26bf4@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: x861r98ybrt3gjui4f4afx3ne6s115be
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 7F5B920010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19vqqBjOjrK7k9mi9j+cH+US+K5a+4H06M=
X-HE-Tag: 1769183627-766583
X-HE-Meta: U2FsdGVkX19LeirWW+Jix0+0TPV+FQNplR3TP69h2XCEjb9dbt8y0lo9t/qGB7gn93ay34DlS2KbFIXr3F/krQ8ImjWI6kAeU/8uBPMmyKFV83K5Y9Tpa25mtHhIM0xa3/wVV2+a4wSgVoy3VbZ2fsbQYyfSfDlyd4PsIwq5JwPbi/dm94wul1TTHZZBsRD6S6S2icP/IkzD3EFE0oae9Bshf8YFWSU7h5r38UBxyx7rVnSocK9CGP/rrXM0Oa8N0pNIdnd/QLuA8SEg2N2tkG2u81/bIwYRs18wWuBJNoRdhUw1FyYZQO8totdA8U35CT5jqhndfOuFneDm4hOyekDzJwFtmAwvL6lPfHHOJSXksIbaQmZoqoCy6hybmsUp

From: Steven Rostedt <rostedt@goodmis.org>

Recording stacktraces is very useful, but the size of 16 deep is very
restrictive. For example, in seeing where tasks schedule out in a non
running state, the following can be used:

 ~# cd /sys/kernel/tracing
 ~# echo 'hist:keys=common_stacktrace:vals=hitcount if prev_state & 3' > events/sched/sched_switch/trigger
 ~# cat events/sched/sched_switch/hist
[..]
{ common_stacktrace:
         __schedule+0xdc0/0x1860
         schedule+0x27/0xd0
         schedule_timeout+0xb5/0x100
         wait_for_completion+0x8a/0x140
         xfs_buf_iowait+0x20/0xd0 [xfs]
         xfs_buf_read_map+0x103/0x250 [xfs]
         xfs_trans_read_buf_map+0x161/0x310 [xfs]
         xfs_btree_read_buf_block+0xa0/0x120 [xfs]
         xfs_btree_lookup_get_block+0xa3/0x1e0 [xfs]
         xfs_btree_lookup+0xea/0x530 [xfs]
         xfs_alloc_fixup_trees+0x72/0x570 [xfs]
         xfs_alloc_ag_vextent_size+0x67f/0x800 [xfs]
         xfs_alloc_vextent_iterate_ags.constprop.0+0x52/0x230 [xfs]
         xfs_alloc_vextent_start_ag+0x9d/0x1b0 [xfs]
         xfs_bmap_btalloc+0x2af/0x680 [xfs]
         xfs_bmapi_allocate+0xdb/0x2c0 [xfs]
} hitcount:          1
[..]

The above stops at 16 functions where knowing more would be useful. As the
allocated storage for stacks is the same for strings, and that size is 256
bytes, there is a lot of space not being used for stacktraces.

 16 * 8 = 128

Up the size to 31 (it requires the last slot to be zero, so it can't be 32).

Also change the BUILD_BUG_ON() to allow the size of the stacktrace storage
to be equal to the max size. It already accounts for the empty slot via
a "+ 1":

  BUILD_BUG_ON((HIST_STACKTRACE_DEPTH + 1) * sizeof(long) >= STR_VAR_LEN_MAX);

Change that from ">=" to just ">", as now they are equal.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.h             | 2 +-
 kernel/trace/trace_events_hist.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 8888fc9335b6..69e7defba6c6 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -128,7 +128,7 @@ enum trace_type {
 
 #define FAULT_STRING "(fault)"
 
-#define HIST_STACKTRACE_DEPTH	16
+#define HIST_STACKTRACE_DEPTH	31
 #define HIST_STACKTRACE_SIZE	(HIST_STACKTRACE_DEPTH * sizeof(unsigned long))
 #define HIST_STACKTRACE_SKIP	5
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 24441b30a1a4..dfb7c4754bf8 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3154,7 +3154,7 @@ static inline void __update_field_vars(struct tracing_map_elt *elt,
 	u64 var_val;
 
 	/* Make sure stacktrace can fit in the string variable length */
-	BUILD_BUG_ON((HIST_STACKTRACE_DEPTH + 1) * sizeof(long) >= STR_VAR_LEN_MAX);
+	BUILD_BUG_ON((HIST_STACKTRACE_DEPTH + 1) * sizeof(long) > STR_VAR_LEN_MAX);
 
 	for (i = 0, j = field_var_str_start; i < n_field_vars; i++) {
 		struct field_var *field_var = field_vars[i];
-- 
2.51.0

