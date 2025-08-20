Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E15C2E1755;
	Wed, 20 Aug 2025 23:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755734125; cv=none; b=X34yLdtNu2siL8/cFpecaNlLGokV/4PMhZp7eImRpZnZuycrL991XEQ8ki5RDZHGOtC8dQcLs/OEC0mtyMmHkrToxPo3RwUN0HsFexSz3T3b49J8FkqZUn/joozMiQ+eTIa/9moB/PiO1xo0kWTN3c2T0KMD9MWuIg4SByE2DYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755734125; c=relaxed/simple;
	bh=4FQEkCWqdY78+jwxdtb56YU9bypzV4vfhgUnjjYSSUc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HqER8CocOMl056TCBMLhT40YXnso2RV790KIaWDIWzPkgKCRaTRZSB6ivuU4sEQijocHwoHzAO39IBzUdwZ0rr/aGZ7dW3HkysemQskapnzoJmTbRgr7nAJKqXyyARaFx8uVLVTJrfBEJSp2HCLVwarP8ah8LdXj8blzHAQuys0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id D3F1E1A01C7;
	Wed, 20 Aug 2025 23:55:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 1CED42000E;
	Wed, 20 Aug 2025 23:55:20 +0000 (UTC)
Date: Wed, 20 Aug 2025 19:55:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Sasha Levin <sashal@kernel.org>
Subject: [PATCH] fgraph: Copy args in intermediate storage with entry
Message-ID: <20250820195522.51d4a268@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: oodrmk36m89xpuof3z9rsndmopu9xeyz
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 1CED42000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX192FjGdpQpdRtBDmIXFSErr+fWyHu8ou3Q=
X-HE-Tag: 1755734120-889586
X-HE-Meta: U2FsdGVkX1/6Hum9duZFAPDU4iRpI/5qMWBIySOLhPQiISnDYl6+GXNWgN/iFnwg1R+nGJIuRAnhg4m2/ZVP4iKwMJK/iRIaQ9UEyVfiImcro5/HBBt+46TeRUCX1Iw0RdurRHuDpCe7zPXFhalyCikmosxffrgjOTfg6tSW0C13+9W31n3DzFKjoHQii2am35vITHtYxAO3+7okxIliOHyMD5iZSqGnf07GFnHNWlQ1yE8BorHRyNhGZLvmbKxQVd8F3mNrM+4Xu+afCgq2K/QhIcZweH/zJrTfyp6qfycjn7PklUq2h9pNoPVbJjvpBu5VcWdLqMn1RnzDFdI1ZRNIj8xXEg/sZPyhKpTIJLOPGl/XL7ay+WPOpkgn1mUSoCl+R0dHhc/xJtve0n/gCg==

From: Steven Rostedt <rostedt@goodmis.org>

The output of the function graph tracer has two ways to display its
entries. One way for leaf functions with no events recorded within them,
and the other is for functions with events recorded inside it. As function
graph has an entry and exit event, to simplify the output of leaf
functions it combines the two, where as non leaf functions are separate:

 2)               |              invoke_rcu_core() {
 2)               |                raise_softirq() {
 2)   0.391 us    |                  __raise_softirq_irqoff();
 2)   1.191 us    |                }
 2)   2.086 us    |              }

The __raise_softirq_irqoff() function above is really two events that were
merged into one. Otherwise it would have looked like:

 2)               |              invoke_rcu_core() {
 2)               |                raise_softirq() {
 2)               |                  __raise_softirq_irqoff() {
 2)   0.391 us    |                  }
 2)   1.191 us    |                }
 2)   2.086 us    |              }

In order to do this merge, the reading of the trace output file needs to
look at the next event before printing. But since the pointer to the event
is on the ring buffer, it needs to save the entry event before it looks at
the next event as the next event goes out of focus as soon as a new event
is read from the ring buffer. After it reads the next event, it will print
the entry event with either the '{' (non leaf) or ';' and timestamps (leaf).

The iterator used to read the trace file has storage for this event. The
problem happens when the function graph tracer has arguments attached to
the entry event as the entry now has a variable length "args" field. This
field only gets set when funcargs option is used. But the args are not
recorded in this temp data and garbage could be printed. The entry field
is copied via:

  data->ent = *curr;

Where "curr" is the entry field. But this method only saves the non
variable length fields from the structure.

Add a helper structure to the iterator data that adds the max args size to
the data storage in the iterator. Then simply copy the entire entry into
this storage (with size protection).

Reported-by: Sasha Levin <sashal@kernel.org>
Closes: https://lore.kernel.org/all/aJaxRVKverIjF4a6@lappy/
Fixes: ff5c9c576e75 ("ftrace: Add support for function argument to graph tracer")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions_graph.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 66e1a527cf1a..a7f4b9a47a71 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -27,14 +27,21 @@ struct fgraph_cpu_data {
 	unsigned long	enter_funcs[FTRACE_RETFUNC_DEPTH];
 };
 
+struct fgraph_ent_args {
+	struct ftrace_graph_ent_entry	ent;
+	/* Force the sizeof of args[] to have FTRACE_REGS_MAX_ARGS entries */
+	unsigned long			args[FTRACE_REGS_MAX_ARGS];
+};
+
 struct fgraph_data {
 	struct fgraph_cpu_data __percpu *cpu_data;
 
 	/* Place to preserve last processed entry. */
 	union {
-		struct ftrace_graph_ent_entry	ent;
+		struct fgraph_ent_args		ent;
+		/* TODO allow retaddr to have args */
 		struct fgraph_retaddr_ent_entry	rent;
-	} ent;
+	};
 	struct ftrace_graph_ret_entry	ret;
 	int				failed;
 	int				cpu;
@@ -627,10 +634,13 @@ get_return_for_leaf(struct trace_iterator *iter,
 			 * Save current and next entries for later reference
 			 * if the output fails.
 			 */
-			if (unlikely(curr->ent.type == TRACE_GRAPH_RETADDR_ENT))
-				data->ent.rent = *(struct fgraph_retaddr_ent_entry *)curr;
-			else
-				data->ent.ent = *curr;
+			if (unlikely(curr->ent.type == TRACE_GRAPH_RETADDR_ENT)) {
+				data->rent = *(struct fgraph_retaddr_ent_entry *)curr;
+			} else {
+				int size = min((int)sizeof(data->ent), (int)iter->ent_size);
+
+				memcpy(&data->ent, curr, size);
+			}
 			/*
 			 * If the next event is not a return type, then
 			 * we only care about what type it is. Otherwise we can
-- 
2.50.1

