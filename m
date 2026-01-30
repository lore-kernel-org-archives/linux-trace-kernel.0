Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EFE1E2614;
	Fri, 30 Jan 2026 01:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769738312; cv=none; b=Xpvxh0ondrtxcQlLaCaMbFoHYbT7HVuyniXIUd9CuOqU28s0fIzJnfvYH97Jy6yY0Wm4EOt7urFzB2s6xX5ZRlR0Ac59GloamyoddEY9tKa/0Uqf7ZWOMPLyYGsb8dkz0FWmB0M/CE09+FH7UaUMgKt2DTRyDutcZ7YDvm0lRlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769738312; c=relaxed/simple;
	bh=n+oLXOiFN9Vzn9pxqe6s87T2TsVR0Azx1ziuMsyo/GM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q1GWXbm3zbF9SQhHPDTYTMgjxxDBYhGng+TPJ0cQxdsRqU2nfVnScdPbk1rAWBaxDcebRatDz2x/b1vMj9C1F4orvGjjqeKGXx2eywRYKOjKeP+15/GFdqruWmC0eQ1AcLTRMBPFs+YSnDA2NE070OV9XAhilMgNYYGugyxS/O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EqQ+3Tuu; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EqQ+3Tuu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=td
	QcrZHMfAKkMOxd1rFwHv+NsGCD+caqYJKH7tX5TBc=; b=EqQ+3TuuFITvuKLbNw
	JagzuRsvXvERp8H5Bw8xAPWNXTgP5ZBuvdkerEfmiVeiazxVS80FTi7QAtY6Xlvy
	g2PxEtFwR+NdadrhRjUCYIVGyuQUn69UhvdTpwZw8kZkagOy6Fb9jh8s5N28pDDA
	oRF49K92eaBQd3v7uDOQmHLcQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3ybcVEHxpZC7oIA--.23746S2;
	Fri, 30 Jan 2026 09:57:42 +0800 (CST)
From: "jempty.liang" <imntjempty@163.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	"jempty.liang" <imntjempty@163.com>
Subject: [PATCH] tracing: Fix duration calculation bug (rettime - calltime) on ARM architecture
Date: Fri, 30 Jan 2026 01:57:40 +0000
Message-Id: <20260130015740.212343-1-imntjempty@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3ybcVEHxpZC7oIA--.23746S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GFW7uw4UJr4DJF17CFy7Awb_yoW7Wr18pa
	yfKa98Kr4kJrWYkryI9rs5Gr45XryxG34UJF47C34YyF97tr1avry7Xrn5XFyrt34kC34a
	vay0vrW5Cr45uwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRsF4ZUUUUU=
X-CM-SenderInfo: hlpq3yxhps35i6rwjhhfrp/xtbC9xaCg2l8EBZghAAA3X

This issue is reproducible on the QEMU vexpress-a9 platform with the
following steps:

Step 1: Launch the QEMU vexpress-a9 VM

~# qemu-system-arm -M vexpress-a9 -smp 1 -m 256 -kernel zImage -dtb \
	vexpress-v2p-ca9.dtb -drive file=rootfs.ext2,if=sd,format=raw \
	-append "console=ttyAMA0,115200 rootwait" -net nic,model=lan9118 \
	-net user -serial stdio

Step 2: Capture and view the trace with trace-cmd

~# trace-cmd record -p function_graph -g do_open_execat \
	--max-graph-depth 1 dd if=/dev/zero of=/tmp/1.bin \
	bs=1M count=1
~# trace-cmd report

Step 3: Observed behavior

Before:

dd-89 ... 5.764026: funcgraph_entry:   $ 2757369004 us |  do_open_execat()
dd-89 ... 5.765222: funcgraph_entry:   $ 2034790547 us |  do_open_execat();

After:

dd-91 ... 891.945577: funcgraph_entry:   ! 185.542 us |  do_open_execat();
dd-91 ... 891.946840: funcgraph_entry:   + 98.625 us  |  do_open_execat();

Signed-off-by: jempty.liang <imntjempty@163.com>
---
 include/linux/ftrace.h               |  2 ++
 kernel/trace/trace_entries.h         |  8 ++++----
 kernel/trace/trace_functions_graph.c | 19 +++++++++----------
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index a3a8989e3268..52727a342273 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1191,6 +1191,8 @@ struct ftrace_graph_ret {
 	int depth;
 	/* Number of functions that overran the depth limit for current task */
 	unsigned int overrun;
+	unsigned long long calltime;
+	unsigned long long rettime;
 } __packed;
 
 struct fgraph_ops;
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index f6a8d29c0d76..362a757e65a2 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -127,8 +127,8 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 		__field_packed(	unsigned long,	ret,		retval	)
 		__field_packed(	unsigned int,	ret,		depth	)
 		__field_packed(	unsigned int,	ret,		overrun	)
-		__field(unsigned long long,	calltime		)
-		__field(unsigned long long,	rettime			)
+		__field_packed(unsigned long long,	ret,	calltime)
+		__field_packed(unsigned long long,	ret,	rettime)
 	),
 
 	F_printk("<-- %ps (%u) (start: %llx  end: %llx) over: %u retval: %lx",
@@ -149,8 +149,8 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 		__field_packed(	unsigned long,	ret,		func	)
 		__field_packed(	unsigned int,	ret,		depth	)
 		__field_packed(	unsigned int,	ret,		overrun	)
-		__field(unsigned long long,	calltime		)
-		__field(unsigned long long,	rettime			)
+		__field_packed(unsigned long long,	ret,	calltime)
+		__field_packed(unsigned long long,	ret,	rettime)
 	),
 
 	F_printk("<-- %ps (%u) (start: %llx  end: %llx) over: %u",
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 1de6f1573621..5798aeb31f05 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -317,6 +317,8 @@ __trace_graph_function(struct trace_array *tr,
 	struct ftrace_graph_ret ret = {
 		.func     = ip,
 		.depth    = 0,
+		.calltime = time,
+		.rettime = time,
 	};
 
 	__trace_graph_entry(tr, &ent, trace_ctx);
@@ -346,8 +348,8 @@ void __trace_graph_return(struct trace_array *tr,
 		return;
 	entry	= ring_buffer_event_data(event);
 	entry->ret				= *trace;
-	entry->calltime				= calltime;
-	entry->rettime				= rettime;
+	entry->ret.calltime				= calltime;
+	entry->ret.rettime				= rettime;
 	trace_buffer_unlock_commit_nostack(buffer, event);
 }
 
@@ -372,10 +374,9 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 	struct trace_array *tr = gops->private;
 	struct fgraph_times *ftimes;
 	unsigned int trace_ctx;
-	u64 calltime, rettime;
 	int size;
 
-	rettime = trace_clock_local();
+	trace->rettime = trace_clock_local();
 
 	ftrace_graph_addr_finish(gops, trace);
 
@@ -390,10 +391,10 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 
 	handle_nosleeptime(tr, trace, ftimes, size);
 
-	calltime = ftimes->calltime;
+	trace->calltime = ftimes->calltime;
 
 	trace_ctx = tracing_gen_ctx();
-	__trace_graph_return(tr, trace, trace_ctx, calltime, rettime);
+	__trace_graph_return(tr, trace, trace_ctx, trace->calltime, trace->rettime);
 }
 
 static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
@@ -956,7 +957,7 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 
 	graph_ret = &ret_entry->ret;
 	call = &entry->graph_ent;
-	duration = ret_entry->rettime - ret_entry->calltime;
+	duration = graph_ret->rettime - graph_ret->calltime;
 
 	if (data) {
 		struct fgraph_cpu_data *cpu_data;
@@ -1280,9 +1281,7 @@ print_graph_return(struct ftrace_graph_ret_entry *retentry, struct trace_seq *s,
 		   u32 flags)
 {
 	struct ftrace_graph_ret *trace = &retentry->ret;
-	u64 calltime = retentry->calltime;
-	u64 rettime = retentry->rettime;
-	unsigned long long duration = rettime - calltime;
+	unsigned long long duration = trace->rettime - trace->calltime;
 	struct fgraph_data *data = iter->private;
 	struct trace_array *tr = iter->tr;
 	unsigned long func;
-- 
2.25.1

