Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795363030;
	b=gv+/8IQMPRtt7TW/DhAR/a3XSR5WC+7NEa+QYpdYCK6P1hW26n8Ohh94odvbAkoVMmoJ
	 n40lOGOm1rSKdtOaLU+7TcJOL79zsAAmqv14NYz5TKgw5vbfE2n7fhN2UWAXYNLVjl+E7
	 bxYr/9fuBT/R5ZswNpbr3Va4I4sMckh1jw1ToqiZqcASUYEm8cYhjFQWIHksFd7ETteSh
	 o9h3uNPY3r3Y7oqrnODn2SYoakCq8JMbgjJmN36RZEfPbZhckDSqCo5FqhdWU/tTSMYZ6
	 zdf9o6nCuwdM5GBlPidVDXYHZIs2Z6rmkJqiSg3Lktx4bPHsDZpdoqkVQa4Jn3ZvdQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795363030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TLQyCMsvy09QyUXPiWKY2K4VQCxavVMU+Xlpye7L2/Q=;
	b=RQWLOsFl8MteqoP9WWE+vxftRPAumkAMzfajheZCoxuf46ZrfxkaMoq6WsGzuDe/qvJz
	 Y+1dr0ZZ6VYPxzpW7egwjWK9zx0jPx55+9DA79/wBaCJwwVLK0XL+iUDnG0hZEAiWpxEW
	 Cu9GwhDC5D8LJ9ASFUnEz6Ni6+X8eMzJmVx52JxHVY+AwEFusYdXLvMpI6pPjkZ8fdY+B
	 ehh62dbctSKfixEBF5lDou6+pEPl5NInkWY0m5gOoVX+0g5cb23A7fBbkOxAcZ58I4rQH
	 61OaoOCXgaJym8f0bmH0dxbjh1Re4xyMu36U6V/YeBbrRYHd03lQ/IfPgKK5Il5Kw/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="c/gmsNPI";
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30EC606A320
	for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Nov 2026 15:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C30EC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c/gmsNPI
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8c700d6cc0bso1846680b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Nov 2026 07:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795363029; x=1795967829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TLQyCMsvy09QyUXPiWKY2K4VQCxavVMU+Xlpye7L2/Q=;
        b=c/gmsNPIXsQr4SFgvieDaS9vN8kMJn/F7zOT6gVit4cZCnEZAdeVRY56OGkkFh0zT7
         2tQNP+FZucYItfDiEAvP6KVA/bYQOGWYsgn8/9BquU91WAauqGqKcq4W5wTN/t1TovuM
         dlionaEwc48fajftsT5J0kZhoEn/ePDG5vO9ivnmHOAhe25fc1c6x4pAoWICiiOmnIwI
         jCVcQBTvndZkptLEg34endAKAp39nk3yBtr1LxvTXlHqFu4js5N1nDGxKUjafmdhIAFl
         OrFjkerein0greGKQVeA8qbk6kv7sY7iAq/x1EhjG4PJpMj+9IkBVbhAGLrh3kMJrAT8
         0zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795363029; x=1795967829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TLQyCMsvy09QyUXPiWKY2K4VQCxavVMU+Xlpye7L2/Q=;
        b=QufDuLVRIN72logN+neDU9D4FLXZ03bmOEmk2GJ9yYFlGUjT3iZaaQmBDkV93MU+G4
         iMz5sZWDBoxUE5DOEloFXHnTt6nyVuvNmpGni2RiFrKnyrMoCTARKneEwHnhCcxQ5E9/
         Zp4G7fIfqfx/OxiwPjQfN7qgKcD9wDXqEpFi1wWbgcNeDeUuP1oA8b827585rYvjY5aP
         fFJ2davRpVeUkMjxhKwk1D/38V1mDl0hi6yxKZudjb46auU50bejBMeaTnQRixwg9j16
         NH42Jt4S0BpHClxRaBcEt25keI5jJ9SkU2eGB7ouwdWqyp1JxDlqmAjXdcNhftaNk/qq
         JQ6Q==
X-Forwarded-Encrypted: i=1; AL+hErHa6tGPeLe+4jyhnRL+XDUtMJIhTrCmkbjiCFoxm60p5rQgj//ia3Dq4sHj8JrgZX4S6pze4nOaVuzAV5doo52vSok=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Vq0GsPP25akbf/OLd2qFPooXAHwfd4DVvktyhNHcekfyBzue/
	v7Yw7SWwody019QkOh+ED/W1v25L0TzAHz3oqIJ5O4mFG6XNAmleg0FR
X-Gm-Gg: AZFdTZe5LGYtMviSsCGQGZ8xcnrxzyhEzkvUjH4sv8V+tzWkyRYwvEOWFWykxPj3AaS
	OluIFM9nkbTn74z4wPa4nbjkmNcNk6fhkb7p/EkZGyl8xR3Nq3gtkef3n19yPTYVBviImMo2VZL
	AuID/NglKuhZO6KWOiRB//FO0xEZo2KOae9NBSGQ5HSEL+trGC7pBlSM/Q09mkP9e57xZSy6Uem
	mzuCXF3tzbBET6/9VN/1FzRKiN3tGVt6FTd5o88rKrzAmAl1n87UAScfLqFAvRWnsmbYll95bX/
	JGW/E0RfPX9cDUKMgm56BmIeBiPGKCMOUG92ProziDP9NRQrdDNOiwj0J1NLPbcgFu8uWZXCntb
	hsPQqC6Z0P6LApQ/d7KQT2ufZd4vEqBXTynWKdeP/wyVG0MC17w/KLfCSOu532T1Rte6nXe+0G6
	IBGz6LWMV7VweizWep9rADfSwelnf80B9ZVg2Gm/eIY+aUQ2uyLo0hUce4F+MxAiSDy2qtsll2G
	1MrlS6xDQTsdmVHRZ+1SxuWLDkPjDbGVbLzuB49gUvIMy0Z52ZXC6bo7FE9/l+usfnhJYc8+xf2
	yWKDpVYHnN4Vu58YLijP71c7W3td0EaDdMu7HnjFR4MncFUx/YUI75mdyZKVxr0DYFa6kJ5ZJsa
	KTg==
X-Received: by 2002:a05:6300:492:b0:3e0:df21:9df2 with SMTP id adf61e73a8af0-4014ca45234mr4831520637.10.1795363029069;
        Sun, 22 Nov 2026 07:57:09 -0800 (PST)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c8706844a0sm4192683b3a.1.2026.11.22.07.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 07:57:08 -0800 (PST)
From: Weiming Shi <bestswngs@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	co+bba0c6b49150bef3@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH v2] ftrace: Finish removing subops after a hash update failure
Date: Sun, 22 Nov 2026 07:56:19 -0800
Message-ID: <20261122155620.319722-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When removing a non-final graph subop, ftrace_shutdown_subops() first
detaches it, then rebuilds and installs the manager hashes. If
rebuild_hashes() fails, the subop stays detached with its ENABLED and
SUBOP flags and manager pointer intact. If ftrace_update_ops() fails, the
subop is added back even though unregister_ftrace_graph() has already
removed its graph slot.

In the fprobe path, ftrace_free_filter() then warns and returns, while
__fprobe_graph_unregister() marks the shared graph operation unregistered.
A later registration follows the stale SUBOP state into an empty manager
list. rebuild_hashes() leaves its output pointers uninitialized in that
case, and ops_equal() dereferences one of them.

Complete non-final removal on both manager-hash failure paths and
initialize empty rebuild outputs to EMPTY_HASH. Keep direct dispatch
disabled after an update failure because the old manager hashes may cover
functions needed only by the removed subop; normal dispatch still applies
the remaining subops' filters.

Completing removal also lets the caller free the subop filter. Split graph
unregistration into removal and callback-wait helpers so Tasks RCU waits
run before saved_func or the operation can be released. For asynchronous
fprobe removal, remove the graph operation immediately and defer the wait
and filter release to a worker that is flushed before reuse. Gate return
callbacks on fprobe_graph_registered while cleanup is pending.

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000802: 0000 [#1] SMP KASAN NOPTI
KASAN: probably user-memory-access in range [0x0000000000004010-0x0000000000004017]
RIP: ops_equal (kernel/trace/trace.h:1011 kernel/trace/ftrace.c:3416)
Call Trace:
 ftrace_update_ops (kernel/trace/ftrace.c:3464)
 ftrace_hash_move_and_update_subops.isra.0 (kernel/trace/ftrace.c:3795)
 ftrace_hash_move_and_update_ops (kernel/trace/ftrace.c:5095)
 ftrace_set_hash (kernel/trace/ftrace.c:6006)
 ftrace_set_filter_ips (kernel/trace/ftrace.c:6020 kernel/trace/ftrace.c:6769)
 register_fprobe_ips (kernel/trace/fprobe.c:290 kernel/trace/fprobe.c:1020)
 register_fprobe (kernel/trace/fprobe.c:979)
 __register_trace_fprobe.part.0 (kernel/trace/trace_fprobe.c:838)
 enable_trace_fprobe (kernel/trace/trace_fprobe.c:823 kernel/trace/trace_fprobe.c:1483)
 fprobe_register (kernel/trace/trace_fprobe.c:1553)
 __ftrace_event_enable_disable (kernel/trace/trace_events.c:913)
 event_enable_write (kernel/trace/trace_events.c:943 kernel/trace/trace_events.c:1995)
 vfs_write (fs/read_write.c:665)
 ksys_write (fs/read_write.c:719)
 do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:89)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
Kernel panic - not syncing: Fatal exception

Cc: stable@vger.kernel.org
Fixes: 0ae6b8ce200d ("ftrace: Fix accounting of subop hashes")
Reported-by: <co+bba0c6b49150bef3@bugs.sh>
Link: https://lore.kernel.org/r/20261103175832.3374540-2-bestswngs@gmail.com
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Changes in v2:
- Merge the dependent teardown and graph-reader fixes.
- Use Tasks RCU waits and defer the fprobe callback wait and filter release
  to a worker.
- Rebase onto 4405c18c95d2 and decode the reproduced crash trace.
- v1: https://lore.kernel.org/r/20261103175832.3374540-2-bestswngs@gmail.com

 kernel/trace/fgraph.c          | 53 +++++++++++++++++++++++++++++-----
 kernel/trace/fprobe.c          | 21 +++++++++++---
 kernel/trace/ftrace.c          | 22 +++++++++-----
 kernel/trace/ftrace_internal.h |  2 ++
 4 files changed, 79 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 6d87143b3..3760795d3 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1406,8 +1406,11 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	gops->ops.flags |= FTRACE_OPS_FL_GRAPH;
 
 	ret = ftrace_startup_subops(&graph_ops, &gops->ops, command);
-	if (!ret)
+	if (!ret) {
 		fgraph_array[i] = gops;
+		if (ftrace_graph_active == 1)
+			ftrace_graph_enable_direct(true, gops);
+	}
 
 error:
 	if (ret) {
@@ -1420,13 +1423,27 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	return ret;
 }
 
-void unregister_ftrace_graph(struct fgraph_ops *gops)
+/**
+ * unregister_ftrace_graph_start - remove a function graph operation
+ * @gops: graph operation to remove
+ *
+ * Remove @gops from graph dispatch, release its array slot, and update the
+ * graph and subop state. Existing graph callbacks may still be using @gops
+ * after this returns.
+ *
+ * Return: true if @gops was removed. The caller must then invoke
+ * unregister_ftrace_graph_finish() exactly once before releasing @gops or its
+ * filter, even if the subop hash update failed.
+ */
+bool unregister_ftrace_graph_start(struct fgraph_ops *gops)
 {
 	int command = 0;
+	int ret = -EINVAL;
+	bool removed = false;
 
 	if (WARN_ONCE(!(gops->ops.flags & FTRACE_OPS_FL_GRAPH),
 		      "function graph ops unregistered without registering"))
-		return;
+		return false;
 
 	guard(mutex)(&ftrace_lock);
 
@@ -1440,16 +1457,17 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 	if (fgraph_lru_release_index(gops->idx) < 0)
 		goto out;
 
-	fgraph_array[gops->idx] = &fgraph_stub;
+	WRITE_ONCE(fgraph_array[gops->idx], &fgraph_stub);
+	removed = true;
 
 	ftrace_graph_active--;
 
 	if (!ftrace_graph_active)
 		command = FTRACE_STOP_FUNC_RET;
 
-	ftrace_shutdown_subops(&graph_ops, &gops->ops, command);
+	ret = ftrace_shutdown_subops(&graph_ops, &gops->ops, command);
 
-	if (ftrace_graph_active == 1)
+	if (ftrace_graph_active == 1 && !ret)
 		ftrace_graph_enable_direct(true, NULL);
 	else if (!ftrace_graph_active)
 		ftrace_graph_disable_direct(false);
@@ -1460,7 +1478,28 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 		unregister_pm_notifier(&ftrace_suspend_notifier);
 		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
 	}
-	gops->saved_func = NULL;
  out:
 	gops->ops.flags &= ~FTRACE_OPS_FL_GRAPH;
+	return removed;
+}
+
+/**
+ * unregister_ftrace_graph_finish - wait for callbacks using a removed operation
+ * @gops: graph operation previously removed by unregister_ftrace_graph_start()
+ *
+ * Wait for existing graph readers, then clear the saved callback. This may
+ * sleep. The caller may release @gops and its filter after this returns.
+ */
+void unregister_ftrace_graph_finish(struct fgraph_ops *gops)
+{
+	/* Graph callbacks can run where RCU is not watching. */
+	synchronize_rcu_tasks_rude();
+	synchronize_rcu_tasks();
+	gops->saved_func = NULL;
+}
+
+void unregister_ftrace_graph(struct fgraph_ops *gops)
+{
+	if (unregister_ftrace_graph_start(gops))
+		unregister_ftrace_graph_finish(gops);
 }
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 47d565a1e..29fc2bfc4 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -14,9 +14,11 @@
 #include <linux/rhashtable.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
+#include <linux/workqueue.h>
 
 #include <asm/fprobe.h>
 
+#include "ftrace_internal.h"
 #include "trace.h"
 
 #define FPROBE_IP_HASH_BITS 8
@@ -279,6 +281,14 @@ static struct fgraph_ops fprobe_graph_ops = {
 static int nr_fgraph_fprobes;
 /* Is fprobe_graph_ops registered? */
 static bool fprobe_graph_registered;
+static void fprobe_graph_cleanup_workfn(struct work_struct *work);
+static DECLARE_WORK(fprobe_graph_cleanup_work, fprobe_graph_cleanup_workfn);
+
+static void fprobe_graph_cleanup_workfn(struct work_struct *work)
+{
+	unregister_ftrace_graph_finish(&fprobe_graph_ops);
+	ftrace_free_filter(&fprobe_graph_ops.ops);
+}
 
 /* Add @addrs to the ftrace filter and register fgraph if needed. */
 static int fprobe_graph_add_ips(unsigned long *addrs, int num)
@@ -286,6 +296,7 @@ static int fprobe_graph_add_ips(unsigned long *addrs, int num)
 	int ret;
 
 	lockdep_assert_held(&fprobe_mutex);
+	flush_work(&fprobe_graph_cleanup_work);
 
 	ret = ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 0, 0);
 	if (ret)
@@ -297,7 +308,7 @@ static int fprobe_graph_add_ips(unsigned long *addrs, int num)
 			ftrace_free_filter(&fprobe_graph_ops.ops);
 			return ret;
 		}
-		fprobe_graph_registered = true;
+		WRITE_ONCE(fprobe_graph_registered, true);
 	}
 	return 0;
 }
@@ -305,9 +316,9 @@ static int fprobe_graph_add_ips(unsigned long *addrs, int num)
 static void __fprobe_graph_unregister(void)
 {
 	if (fprobe_graph_registered) {
-		unregister_ftrace_graph(&fprobe_graph_ops);
-		ftrace_free_filter(&fprobe_graph_ops.ops);
-		fprobe_graph_registered = false;
+		WRITE_ONCE(fprobe_graph_registered, false);
+		if (unregister_ftrace_graph_start(&fprobe_graph_ops))
+			schedule_work(&fprobe_graph_cleanup_work);
 	}
 }
 
@@ -679,6 +690,8 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
 	ret_ip = ftrace_regs_get_instruction_pointer(fregs);
 
 	guard(rcu_sched_notrace)();
+	if (!READ_ONCE(fprobe_graph_registered))
+		return;
 
 	curr = 0;
 	while (size_words > curr) {
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c7d74b33d..7c712d99f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3672,6 +3672,8 @@ static int rebuild_hashes(struct ftrace_hash **filter_hash, struct ftrace_hash *
 	bool first = true;
 	int ret;
 
+	*filter_hash = EMPTY_HASH;
+	*notrace_hash = EMPTY_HASH;
 	temp_hash.filter_hash = EMPTY_HASH;
 	temp_hash.notrace_hash = EMPTY_HASH;
 
@@ -3713,7 +3715,13 @@ static int rebuild_hashes(struct ftrace_hash **filter_hash, struct ftrace_hash *
  * will not affect functions that are being traced by other subops that
  * still exist in @ops.
  *
- * If the last subops is removed from @ops, then @ops is shutdown normally.
+ * If @subops is the last subop, @ops is shut down normally. Otherwise,
+ * @subops is detached even if the manager hash update fails. The manager
+ * hashes may be partially updated, but still cover all functions required by
+ * the remaining subops.
+ *
+ * Return: 0 on success, or a negative error code on shutdown or hash update
+ * failure.
  */
 int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command)
 {
@@ -3753,15 +3761,13 @@ int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, in
 	/* Rebuild the hashes without subops */
 	ret = rebuild_hashes(&filter_hash, &notrace_hash, ops);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = ftrace_update_ops(ops, filter_hash, notrace_hash);
-	if (ret < 0) {
-		list_add(&subops->list, &ops->subop_list);
-	} else {
-		subops->flags &= ~(FTRACE_OPS_FL_ENABLED | FTRACE_OPS_FL_SUBOP);
-		subops->managed = NULL;
-	}
+
+out:
+	subops->flags &= ~(FTRACE_OPS_FL_ENABLED | FTRACE_OPS_FL_SUBOP);
+	subops->managed = NULL;
 	free_ftrace_hash(filter_hash);
 	free_ftrace_hash(notrace_hash);
 	return ret;
diff --git a/kernel/trace/ftrace_internal.h b/kernel/trace/ftrace_internal.h
index 3235470e6..abb7776a2 100644
--- a/kernel/trace/ftrace_internal.h
+++ b/kernel/trace/ftrace_internal.h
@@ -52,6 +52,8 @@ static inline int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_o
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 extern int ftrace_graph_active;
+bool unregister_ftrace_graph_start(struct fgraph_ops *gops);
+void unregister_ftrace_graph_finish(struct fgraph_ops *gops);
 # ifdef CONFIG_DYNAMIC_FTRACE
 extern void fgraph_update_pid_func(void);
 # else
-- 
2.56.0

