Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666891F63CD;
	Tue,  6 Jan 2026 01:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767663085; cv=none; b=cgmphfFR8/QQv2QtnEIpdWeiOWfiykWXSTi4ZWtcQb2LL19AFaXrVjWZeoo8q2/g3SCz5kiFPt3OsJVOxr6InyVmE+wzpV/7zUfLENHeDoIgD/cCHUmzM1Yn6BDN3ktyz/j1kq4zxBQXpkprzGYpQ6qkA7Itj69S3HWup6TjM2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767663085; c=relaxed/simple;
	bh=af12608cBm+UXtOClXsbHYZFCoiKJ4GFXnZQCqwBrn8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=axrZJ9754MSpsuu8UeGDFnl6IfMvr/KTLu81nLIRUmt0T5xXA3xvc+J355m1TOvWDXUkBiErypN5se0zbdZ7+yDOaEDPsmkiR85xOCnSLNshr0BNhtKepa5ZRq27HTxql9CkE06gZ0+1Hq1HT04gIYMg6YoljL0fsXumzQML4sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 9CEEF1402E1;
	Tue,  6 Jan 2026 01:31:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id BAE7630;
	Tue,  6 Jan 2026 01:31:18 +0000 (UTC)
Date: Mon, 5 Jan 2026 20:31:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Joel Fernandes <joel@joelfernandes.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Yao Kai <yaokai34@huawei.com>,
 Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH] tracing: Add recursion protection in kernel stack trace
 recording
Message-ID: <20260105203141.515cd49f@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: kbzddff3ye567pq8dhksb4fe3y866aww
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: BAE7630
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18brEZF82Ke4B4ar1UW602pC/3RNla7liA=
X-HE-Tag: 1767663078-860938
X-HE-Meta: U2FsdGVkX19QU9v2VQzh5Fziqbk+/yr/Vt1cQcMH7Fl/ZkX2q5KQySG3GB8wDaFeA/GxTBERMkkapB9QzTYLl6NM9n5JKuSruQZD8PDGgetYwfbuRD5rN8L7Cuiy9dOq5X1p1D+NGbP748a+XirxylpN1Zaj2sCMsybfPJIDuqnA42Qlt36s9aW8kCVL0LP7uRpnGDq57v25U5UG0XEcAWDdv2h6G4CNs3y79m+dzk9aymjj46V6tXOXBOYOONUOc+Ji/ELxmsuvSrX5eqM0zR3yn8GIIgCuYUUxiSQdESxuMvjfA6n5ll2CZ+pUFoPg1YZeHyAtEvFjUlfb1odlFp0AN7UczYb0GE72Wsd18sRvIjqEELJZBRWUVnfgMElXCOf3IFOp51kE9klw+hDqnUhag+poDXasuwHNiCWArWE=

From: Steven Rostedt <rostedt@goodmis.org>

A bug was reported about an infinite recursion caused by tracing the rcu
events with the kernel stack trace trigger enabled. The stack trace code
called back into RCU which then called the stack trace again.

Expand the ftrace recursion protection to add a set of bits to protect
events from recursion. Each bit represents the context that the event is
in (normal, softirq, interrupt and NMI).

Have the stack trace code use the interrupt context to protect against
recursion.

Note, the bug showed an issue in both the RCU code as well as the tracing
stacktrace code. This only handles the tracing stack trace side of the
bug. The RCU fix will be handled separately.

Link: https://lore.kernel.org/all/20260102122807.7025fc87@gandalf.local.home/

Cc: stable@vger.kernel.org
Reported-by: Yao Kai <yaokai34@huawei.com>
Tested-by: Yao Kai <yaokai34@huawei.com>
Fixes: 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in __rcu_read_unlock()")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_recursion.h | 9 +++++++++
 kernel/trace/trace.c            | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index ae04054a1be3..e6ca052b2a85 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -34,6 +34,13 @@ enum {
 	TRACE_INTERNAL_SIRQ_BIT,
 	TRACE_INTERNAL_TRANSITION_BIT,
 
+	/* Internal event use recursion bits */
+	TRACE_INTERNAL_EVENT_BIT,
+	TRACE_INTERNAL_EVENT_NMI_BIT,
+	TRACE_INTERNAL_EVENT_IRQ_BIT,
+	TRACE_INTERNAL_EVENT_SIRQ_BIT,
+	TRACE_INTERNAL_EVENT_TRANSITION_BIT,
+
 	TRACE_BRANCH_BIT,
 /*
  * Abuse of the trace_recursion.
@@ -58,6 +65,8 @@ enum {
 
 #define TRACE_LIST_START	TRACE_INTERNAL_BIT
 
+#define TRACE_EVENT_START	TRACE_INTERNAL_EVENT_BIT
+
 #define TRACE_CONTEXT_MASK	((1 << (TRACE_LIST_START + TRACE_CONTEXT_BITS)) - 1)
 
 /*
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6f2148df14d9..aef9058537d5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3012,6 +3012,11 @@ static void __ftrace_trace_stack(struct trace_array *tr,
 	struct ftrace_stack *fstack;
 	struct stack_entry *entry;
 	int stackidx;
+	int bit;
+
+	bit = trace_test_and_set_recursion(_THIS_IP_, _RET_IP_, TRACE_EVENT_START);
+	if (bit < 0)
+		return;
 
 	/*
 	 * Add one, for this function and the call to save_stack_trace()
@@ -3080,6 +3085,7 @@ static void __ftrace_trace_stack(struct trace_array *tr,
 	/* Again, don't let gcc optimize things here */
 	barrier();
 	__this_cpu_dec(ftrace_stack_reserve);
+	trace_clear_recursion(bit);
 }
 
 static inline void ftrace_trace_stack(struct trace_array *tr,
-- 
2.51.0

