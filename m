Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC2826461B;
	Wed,  9 Apr 2025 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206068; cv=none; b=T/dqsjzviCtxJl2awLFK+XQSGM809x9hUU3citqjg6wB2ykp5cIb73QBqfoP6Ey9q/x5LdyBNwM9ffwkRxTmzt4PBv0irJc5ooJZFm4LwEmnRY8S2WNkH5EvWaQkqNcwuVowkyQAfPBeH0TAJ/cM7ANF6ybvuyHMNZbQe4kFdIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206068; c=relaxed/simple;
	bh=+1atZIFJ5wuqFQAdnBtVviK8HirErlh/0SzSdL6g428=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=p7tq+XIUvodycdWLVUlYWgkFZwoQ3033dNpdGxo56vE7Dc9doIa1tWdXMnLM4GyycpIrKzGsUL4aIgvqT+hjxqqJePUptetVW85XaQ3LiQ+KtKcQOF38Qj6WLIjsuWRYX/k1vr4TCOGv0mky1llQfQI7u8fVoSFF90T5Zck7stU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73450C4CEE7;
	Wed,  9 Apr 2025 13:41:07 +0000 (UTC)
Date: Wed, 9 Apr 2025 09:42:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ftrace: Show subops in enabled_functions
Message-ID: <20250409094226.23f75293@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The function graph infrastructure uses subops of the function tracer.
These are not shown in enabled_functions. Add a "subops:" section to the
enabled_functions line to show what functions are attached via subops. If
the subops is from the function_graph infrastructure, then show the entry
and return callbacks that are attached.

Here's an example of the output:

schedule_on_each_cpu (1)                tramp: 0xffffffffc03ef000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60     subops: {ent:trace_graph_entry+0x0/0x20 ret:trace_graph_return+0x0/0x150}

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h |  2 ++
 kernel/trace/fgraph.c  |  2 ++
 kernel/trace/ftrace.c  | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index fbabc3d848b3..fc939ca2ff66 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -328,6 +328,7 @@ ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *ops);
  * DIRECT - Used by the direct ftrace_ops helper for direct functions
  *            (internal ftrace only, should not be used by others)
  * SUBOP  - Is controlled by another op in field managed.
+ * GRAPH  - Is a component of the fgraph_ops structure
  */
 enum {
 	FTRACE_OPS_FL_ENABLED			= BIT(0),
@@ -349,6 +350,7 @@ enum {
 	FTRACE_OPS_FL_PERMANENT                 = BIT(16),
 	FTRACE_OPS_FL_DIRECT			= BIT(17),
 	FTRACE_OPS_FL_SUBOP			= BIT(18),
+	FTRACE_OPS_FL_GRAPH			= BIT(19),
 };
 
 #ifndef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 8d925cbdce3a..c5b207992fb4 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1382,6 +1382,8 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	/* Always save the function, and reset at unregistering */
 	gops->saved_func = gops->entryfunc;
 
+	gops->ops.flags |= FTRACE_OPS_FL_GRAPH;
+
 	ret = ftrace_startup_subops(&graph_ops, &gops->ops, command);
 	if (!ret)
 		fgraph_array[i] = gops;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 1a48aedb5255..cd62f5ab3dfe 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4323,6 +4323,40 @@ static inline int print_rec(struct seq_file *m, unsigned long ip)
 }
 #endif
 
+static void print_subops(struct seq_file *m, struct ftrace_ops *ops, struct dyn_ftrace *rec)
+{
+	struct ftrace_ops *subops;
+	bool first = true;
+
+	list_for_each_entry(subops, &ops->subop_list, list) {
+		if (!((subops->flags & FTRACE_OPS_FL_ENABLED) &&
+		      hash_contains_ip(rec->ip, subops->func_hash)))
+			continue;
+		if (first) {
+			seq_printf(m, "\tsubops:");
+			first = false;
+		}
+		if (subops->flags & FTRACE_OPS_FL_GRAPH) {
+			struct fgraph_ops *gops;
+
+			gops = container_of(subops, struct fgraph_ops, ops);
+			seq_printf(m, " {ent:%pS ret:%pS}",
+				   (void *)gops->entryfunc,
+				   (void *)gops->retfunc);
+			continue;
+		}
+		if (subops->trampoline) {
+			seq_printf(m, " {%pS (%pS)}",
+				   (void *)subops->trampoline,
+				   (void *)subops->func);
+			add_trampoline_func(m, subops, rec);
+		} else {
+			seq_printf(m, " {%pS}",
+				   (void *)subops->func);
+		}
+	}
+}
+
 static int t_show(struct seq_file *m, void *v)
 {
 	struct ftrace_iterator *iter = m->private;
@@ -4375,6 +4409,7 @@ static int t_show(struct seq_file *m, void *v)
 						   (void *)ops->trampoline,
 						   (void *)ops->func);
 					add_trampoline_func(m, ops, rec);
+					print_subops(m, ops, rec);
 					ops = ftrace_find_tramp_ops_next(rec, ops);
 				} while (ops);
 			} else
@@ -4387,6 +4422,7 @@ static int t_show(struct seq_file *m, void *v)
 			if (ops) {
 				seq_printf(m, "\tops: %pS (%pS)",
 					   ops, ops->func);
+				print_subops(m, ops, rec);
 			} else {
 				seq_puts(m, "\tops: ERROR!");
 			}
-- 
2.47.2

