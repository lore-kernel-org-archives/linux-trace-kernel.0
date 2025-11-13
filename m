Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB0523EAB7;
	Thu, 13 Nov 2025 05:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763013398; cv=none; b=GQ266SVXNGc+0fSnK7Fk5YGIUCvu45T/X5oeOsjMwp9wfKq4vFzFLp251T/c+p+VK0m9Vry2zgIJ0MFfqzFJowInQAp5Twzt8/VpAy/vTBbdzFhJ0K6XoTb6DSpQk/dZJtEz5BVo51NPhsr/L+KrSbmjwpQbWszSXwLPHK9tp8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763013398; c=relaxed/simple;
	bh=6WGz9Kqg6eyW6tMj7qhCcRCbkyOl4odWeRrUrxE2nZo=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=aLttFWbOlwu7U2Wv31AHP0kuyDJi9JQxiUqWSk978PVdyptow87sqC44nt6qaZAPMgsvjQhcMgXbqPca3X2vN8hb/stvv0BL14119fPcMnIX/T44oDph0D0WF67bHQD9DUCabIJO01HoHU0G4s1FJOqqy2hKVtR0QQ/MWN80ESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4d6Tzh4Ylvz5PM32;
	Thu, 13 Nov 2025 13:56:32 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 5AD5uPD6088235;
	Thu, 13 Nov 2025 13:56:25 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 13 Nov 2025 13:56:27 +0800 (CST)
Date: Thu, 13 Nov 2025 13:56:27 +0800 (CST)
X-Zmail-TransId: 2af96915730bb14-1bcca
X-Mailer: Zmail v1.0
Message-ID: <20251113135627439rGwzvG7JzdmnN8VMHAfMs@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yaxin@zte.com.cn>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.desnoyers@efficios.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <hu.shengming@zte.com.cn>, <hang.run@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGZncmFwaDogRml4IGFuZCB0aWdodGVuIFBJRCBmaWx0ZXJpbmcgc3VwcG9ydA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5AD5uPD6088235
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Thu, 13 Nov 2025 13:56:32 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69157310.000/4d6Tzh4Ylvz5PM32

From: Shengming Hu <hu.shengming@zte.com.cn>

Function graph tracing did not honor set_ftrace_pid() rules properly.

The root cause is that for fgraph_ops, the underlying ftrace_ops->private
was left uninitialized. As a result, ftrace_pids_enabled(op) always
returned false, effectively disabling PID filtering in the function graph
tracer.

PID filtering seemed to "work" only because graph_entry() performed an
extra coarse-grained check via ftrace_trace_task(). Specifically,
ftrace_ignore_pid is updated by ftrace_filter_pid_sched_switch_probe
during sched_switch events. Under the original logic, when the intent
is to trace only PID A, a context switch from task B to A sets 
ftrace_ignore_pid to A’s PID. However, there remains a window
where B’s functions are still captured by the function-graph tracer. 
The following trace demonstrates this leakage
(B = haveged-213, A = test.sh-385):

 4)  test.sh-385   |               |    set_next_entity() {
 4)  test.sh-385   |   2.108 us    |      __dequeue_entity();
 4)  test.sh-385   |   1.526 us    |      __update_load_avg_se();
 4)  test.sh-385   |   1.363 us    |      __update_load_avg_cfs_rq();
 4)  test.sh-385   | + 14.144 us   |    }
 4)  test.sh-385   |   1.417 us    |    __set_next_task_fair.part.0();
 4)  test.sh-385   | + 77.877 us   |  }
 4)  test.sh-385   |               |  __traceiter_sched_switch() {
 4)  test.sh-385   |   2.097 us    |    _raw_spin_lock_irqsave();
 4)  test.sh-385   |   1.483 us    |    _raw_spin_unlock_irqrestore();
 4)  test.sh-385   | + 14.014 us   |  }
 ------------------------------------------
 4)  test.sh-385   =>  haveged-213  
 ------------------------------------------

 4)  haveged-213   |               |  switch_mm_irqs_off() {
 4)  haveged-213   |   2.387 us    |    choose_new_asid();
 4)  haveged-213   | + 12.462 us   |    switch_ldt();
 4)  haveged-213   | + 45.288 us   |  }
 4)  haveged-213   |   1.639 us    |  x86_task_fpu();
 4)  haveged-213   |               |  save_fpregs_to_fpstate() {
 4)  haveged-213   |   1.888 us    |    xfd_validate_state();
 4)  haveged-213   |   6.995 us    |  }
 ------------------------------------------
 4)  haveged-213   =>  test.sh-385  
 ------------------------------------------

 4)  test.sh-385   |               |    finish_task_switch.isra.0() {
 4)  test.sh-385   |   1.857 us    |      _raw_spin_unlock();
 4)  test.sh-385   |   5.618 us    |    }
 4)  test.sh-385   | ! 446.226 us  |  }
 4)  test.sh-385   |               |  __pte_offset_map_lock() {
 4)  test.sh-385   |               |    ___pte_offset_map() {
 4)  test.sh-385   |   1.933 us    |      __rcu_read_lock();
 4)  test.sh-385   |   6.271 us    |    }
 4)  test.sh-385   |   2.056 us    |    _raw_spin_lock();
 4)  test.sh-385   | + 14.281 us   |  }

Fix this by:
  1. Properly initializing gops->ops->private so that
     ftrace_pids_enabled() works as expected.
  2. Removing the imprecise fallback check in graph_entry().
  3. Updating register_ftrace_graph() to set gops->entryfunc =
     fgraph_pid_func whenever PID filtering is active, so the correct
     per-task filtering is enforced at entry time.

With this change, function graph tracing will respect the configured
PID filter list consistently, and the redundant coarse check is no
longer needed.

Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
---
 kernel/trace/fgraph.c                | 9 +++++++--
 kernel/trace/trace.h                 | 9 ---------
 kernel/trace/trace_functions_graph.c | 3 ---
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 484ad7a18..00df3d4ac 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1019,6 +1019,7 @@ void fgraph_init_ops(struct ftrace_ops *dst_ops,
 		mutex_init(&dst_ops->local_hash.regex_lock);
 		INIT_LIST_HEAD(&dst_ops->subop_list);
 		dst_ops->flags |= FTRACE_OPS_FL_INITIALIZED;
+		dst_ops->private = src_ops->private;
 	}
 #endif
 }
@@ -1375,6 +1376,12 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	gops->idx = i;

 	ftrace_graph_active++;
+	/* Always save the function, and reset at unregistering */
+	gops->saved_func = gops->entryfunc;
+#ifdef CONFIG_DYNAMIC_FTRACE
+	if (ftrace_pids_enabled(&gops->ops))
+		gops->entryfunc = fgraph_pid_func;
+#endif

 	if (ftrace_graph_active == 2)
 		ftrace_graph_disable_direct(true);
@@ -1395,8 +1402,6 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	} else {
 		init_task_vars(gops->idx);
 	}
-	/* Always save the function, and reset at unregistering */
-	gops->saved_func = gops->entryfunc;

 	gops->ops.flags |= FTRACE_OPS_FL_GRAPH;

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index a3a15cfab..048a53282 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1162,11 +1162,6 @@ struct ftrace_func_command {
 					char *params, int enable);
 };
 extern bool ftrace_filter_param __initdata;
-static inline int ftrace_trace_task(struct trace_array *tr)
-{
-	return this_cpu_read(tr->array_buffer.data->ftrace_ignore_pid) !=
-		FTRACE_PID_IGNORE;
-}
 extern int ftrace_is_dead(void);
 int ftrace_create_function_files(struct trace_array *tr,
 				 struct dentry *parent);
@@ -1184,10 +1179,6 @@ void ftrace_clear_pids(struct trace_array *tr);
 int init_function_trace(void);
 void ftrace_pid_follow_fork(struct trace_array *tr, bool enable);
 #else
-static inline int ftrace_trace_task(struct trace_array *tr)
-{
-	return 1;
-}
 static inline int ftrace_is_dead(void) { return 0; }
 static inline int
 ftrace_create_function_files(struct trace_array *tr,
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index fe9607edc..0efe831e4 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -232,9 +232,6 @@ static int graph_entry(struct ftrace_graph_ent *trace,
 		return 1;
 	}

-	if (!ftrace_trace_task(tr))
-		return 0;
-
 	if (ftrace_graph_ignore_func(gops, trace))
 		return 0;

-- 
2.25.1
