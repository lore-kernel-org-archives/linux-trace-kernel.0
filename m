Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728725;
	b=zeToE/6ykvMqJIzoEsPIui3Pfxb/+Bo2D7AGCx7ZVMpIwD5C/BdlZd3U+/m9LcQk7e0P
	 PX+mU2iQmyqCYMohXFlXj4NtdMhLjgiDU8oLJ/wTltMg9C+I9TfCW4cJU/iBjPwLQrec+
	 LQZomCsJgbcSVemCVdW/Fe2VU7z2csbLZy/4hRs+9lF7jhMx9tPveUWk0BSOwVTYpBLpf
	 TN8ubt4WKSdrBG1D1+/HKH7zgXUEHj+j4VbDXdna80xa2toO70p0hO2we5DffJsPtMvtf
	 ZyUVFwGSDfqNYkfsHKFiFxLN1CLizBLOQFHclFA7GrLsyv2O/iiI5qZwZgi1Xz7w2Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PElxI0aYTQe7EyopaZuArpxV8n0ScCes61k5/emAHuk=;
	b=1hRu0SkFah9+KyK0latDaD8rkGCuDtElHgJem3rjnxVINXybvdWUintn//Cya6/Uksbu
	 S60HKUUAfJON9Upx+Zu6UBeFcLd96K5ajOAuIiOPAWL2B3CMxcTya8ZsWjABg+AdoUZoK
	 EyHJWT2/xqTVlzQ+YDPzVuin6slAZSVUmTMeIerq3/djYxeGOUaYPlyPwmIC065Vfv55v
	 mu1S2ScgcwJcr+hFDMg4QpEiJMzb+7vlugyAH9LOKVpd2yi/YFKc3LB15QiyOHin3FhkK
	 OPMtaVrgXLTkjYrWYiYdotf6PZVXhoOKSuCnriNzdxiZZXDntNbO9gWlCKkqbrY9/EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="0iMPh/WP";
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A06606A324
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 17:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87A06606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0iMPh/WP
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36661f953e4so6732428eec.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Nov 2026 09:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793728724; x=1794333524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PElxI0aYTQe7EyopaZuArpxV8n0ScCes61k5/emAHuk=;
        b=0iMPh/WPjxqV5uoKPvI4vwhDncTSqaRmwcWFHV7NdZS/iITtkwufMIJa+5PfwfFisB
         dgg/jP2TTAUmdvOFygojVZh8NcS9OjMMpoPy9TyECJuOv71nbPo8PUd+rp7RMjzVXk2Y
         IhXOwB5zYhNrJlPJ0OD8KQUnkSaaDoM7zSH3tjzWj6fQawxUzEozsqP411NMGtt26V+Q
         DY+iNdphHkOSzh1nu4DZuNCOZEZtU0tEe00RizbGEk7dUug7o3xMedBpc8zX6IfvWT5o
         UGPtRvm3LjKkFH0iaxnhkenYtmjgV5CwMA97cr3KZimoMs7eaGDLdnixmyxeZ5rXG6iC
         dMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793728724; x=1794333524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PElxI0aYTQe7EyopaZuArpxV8n0ScCes61k5/emAHuk=;
        b=Z1Uw+uhw91B3+r6H0YLav6ybhflOgM+ROVeG9Cbg91sT+JyNg3q9H92AItvwWFT3cV
         LGJr+f+YKs7D/C5PkIK5tArIk0T34XOZFOISETPFK4oQdrQVfw41euTsmWlSjtLFG2N7
         3UTWQBZhIvXxLPka+KS3FoYeIL0EjnFmy1v6W7AA+P5gRhx8oYT0X3oobPIyz+zcE7Bq
         dto7NoxZmNLoi2V8/1nvmPuT9QDCJDtBbfaLBfOoTnGEu4XEfQYJhJtnjeFWMCoNSsbO
         0aYV6DXjqjQKaQuW6mpn8l5GmSZiGlKCIYKAgDp+aanL0VwjIwv8eMHgEr/2C7D0v5Vd
         abJg==
X-Forwarded-Encrypted: i=1; AKwUvBzDfEmTSQYMNVX9ZdwVOueNo7jZG5NOjlmfjJ938Xgn8ifXrU1Wn+HRHkVML/1rQEk0+mJ2y6ECxdlWPPTnFo2tuwk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wmxTcCffU2qD8HA7eK+HbW72DM66P4eYCqLgFKymRHZHIdKEK
	wATe9GgeCsPhjhnRpkjtocdp5i0jszxKUfDi4W7MBdMrGwO9lauaS8v9
X-Gm-Gg: AYBFou0N0Y4UA+E9nEqE3Bg3ks/WddhPBFbqtG0wovNIgF5EjVS/5hNtOcgIo1hOV1J
	/r9xYuIUgEt03P5oosPxlJeL9k+EoiqLxYQuBL+D5WPlAIo6z9xiqTZTjlsy4Z/IbccdoI6L81w
	+UC1jwu+kL560Kt32E+A3dKSUmNqc9OPvmKfCSwYEroSfXCtXM21LXq+KlPRj2pKg4B5ifRLyEt
	o3ZUzkOzHRpDPtztA8a6dMQAAeTh0KWCLbU31Iba1marzE4pKB1ObwrXpYpWIP/DN3oj5DVLvxI
	4M1xnBqpRxZTZ2/cvxJJjmKX1jzbmYZSWcWm/lt+3Xfe5z1XcCVCPxR0GfE6hhjAe1gnVIzW3xa
	QsqpOTvPr5GdATKKcyHOJkGf8eYroXRSue8P00VzGUmmz7y6Xn99y5Hpzuhvemo1QpB45MFbfdU
	4EYVJP+xQPi6DCBBJlEH4vL8li8xKqN6WaBE+gJQU/mvZ4KdGWNF4PKBWhpxNBVXZqBJV1QKbbk
	RnFf2RwASo/bRzMtezhx12xD2e8fucYsgUGhJLie/kf4S74Sltf6+dqvdAkKPC44Ku65tW8rsBM
	E15rl0QFVYkajCGt61nJ0ywXYkCmZBhBmevCN6rcErI/eRyaY99V4vhjrLsmQ2dZQNpVcMVBhto
	9aw==
X-Received: by 2002:a05:7301:7e14:b0:367:363f:6fe4 with SMTP id 5a478bee46e88-36a423f6947mr18594964eec.32.1793728723530;
        Tue, 03 Nov 2026 09:58:43 -0800 (PST)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42952e1csm52256902eec.20.2026.11.03.09.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 09:58:42 -0800 (PST)
From: Weiming Shi <bestswngs@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	co+bba0c6b49150bef3@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ftrace: Wait for graph readers before releasing operations
Date: Tue,  3 Nov 2026 09:58:30 -0800
Message-ID: <20261103175832.3374540-1-bestswngs@gmail.com>
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

unregister_ftrace_graph() removes an operation from the graph array before
returning. A graph callback may already hold the operation or its filter,
however, while the caller can release them as soon as unregistration
completes.

This can happen without a hash update failure. For example, consider three
graph operations with identical filters where one also enables PID
filtering. Removing that operation leaves the manager hashes unchanged, so
an in-flight fgraph_pid_func() may call gops->saved_func after unregister
has cleared it.

Graph callbacks run with preemption disabled and may run while RCU is not
watching. Separate removing the operation from graph dispatch from waiting
for callbacks that may still be using it. Keep unregister_ftrace_graph()
synchronous by performing both steps, and require internal users of the
split interface to pair every successful removal with a reader wait.

For fprobes, unpublish the graph operation and release its slot
synchronously, then queue the reader waits and filter release. This keeps
the waits out of unregister_fprobe_async(). Flush the work before reusing
the shared graph operation.

Disable fprobe return dispatch before unpublishing the operation and check
that state inside the callback's RCU critical section. Re-enable dispatch
only after graph registration succeeds, so a return callback cannot use a
released fprobe while cleanup is pending.

Cc: stable@vger.kernel.org
Fixes: df3ec5da6a1e ("function_graph: Add pid tracing back to function graph tracer")
Reported-by: <co+bba0c6b49150bef3@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 kernel/trace/fgraph.c          | 47 +++++++++++++++++++++++++++++++---
 kernel/trace/fprobe.c          | 21 ++++++++++++---
 kernel/trace/ftrace_internal.h |  2 ++
 3 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index ed455b535..14733f519 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1420,13 +1420,26 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	return ret;
 }
 
-void unregister_ftrace_graph(struct fgraph_ops *gops)
+/**
+ * unregister_ftrace_graph_start - unpublish a function graph operation
+ * @gops: graph operation to remove
+ *
+ * Remove @gops from graph dispatch, release its array slot, and update the
+ * graph and subop state. Existing graph callbacks may still be using @gops
+ * after this returns.
+ *
+ * Return: true if @gops was unpublished. The caller must then invoke
+ * unregister_ftrace_graph_finish() exactly once before releasing @gops or its
+ * filter, even if the subop hash update failed.
+ */
+bool unregister_ftrace_graph_start(struct fgraph_ops *gops)
 {
 	int command = 0;
+	bool removed = false;
 
 	if (WARN_ONCE(!(gops->ops.flags & FTRACE_OPS_FL_GRAPH),
 		      "function graph ops unregistered without registering"))
-		return;
+		return false;
 
 	guard(mutex)(&ftrace_lock);
 
@@ -1440,7 +1453,8 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 	if (fgraph_lru_release_index(gops->idx) < 0)
 		goto out;
 
-	fgraph_array[gops->idx] = &fgraph_stub;
+	WRITE_ONCE(fgraph_array[gops->idx], &fgraph_stub);
+	removed = true;
 
 	ftrace_graph_active--;
 
@@ -1460,7 +1474,32 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
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
+ * unregister_ftrace_graph_finish - wait for readers of an unpublished operation
+ * @gops: graph operation previously unpublished by unregister_ftrace_graph_start()
+ *
+ * Wait for existing graph readers, then clear the saved callback. This may
+ * sleep. The caller may release @gops and its filter after this returns.
+ */
+void unregister_ftrace_graph_finish(struct fgraph_ops *gops)
+{
+	/*
+	 * The graph callbacks run with preemption disabled and may run while
+	 * RCU is not watching. Wait for both kinds of readers before the
+	 * caller can release the graph ops or its filter.
+	 */
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
index da286619c..c53ad37a0 100644
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

