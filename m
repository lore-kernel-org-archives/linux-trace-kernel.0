Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D32D2DFF04;
	Mon, 17 Nov 2025 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399178; cv=none; b=bPrHFgKebxoQ/b0Fit6tas3ga8sRtpir/AUpzvM59S0dXXTw0TCHkqFuPyLFfXMl0Z0SA6+O3Fi8/YmQUSr9Z5gkn0i71jvhEM/25L0Q4fhHk9ehuPFLeq2LDAKS5sysYKfnNlJhmg4LhORHC/GPHLbR7gGExiJJFqP8Zp4x8ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399178; c=relaxed/simple;
	bh=S/drtOn2gb6+LvBIK4wwwD5Oo3YANnIxfIMHFOLZ5EM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cbtrGspXWLPuNd5gSiFFCerkq87X0C4+8ciItAc4+kgwU52qtv+T3wippCZa+pHMGQ+9dvjZhBakdWWkHxnZvfuFt/NQbnEHB+WflVt7gj2PRsH18WWNiahWe+n0N6SFQhfc6fVyma/9B3e68TOyfWoYI6FNhCqE7WdLN18fEfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 2CB6B573BF;
	Mon, 17 Nov 2025 17:06:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 5F0E86000B;
	Mon, 17 Nov 2025 17:06:12 +0000 (UTC)
Date: Mon, 17 Nov 2025 12:06:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: [PATCH] tracing: Remove unused variable in
 tracing_trace_options_show()
Message-ID: <20251117120637.43ef995d@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 5F0E86000B
X-Stat-Signature: n59fajnwnbep8fhs7pyt4b66f1xyu7gr
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19mpJ8CdsKHAzE29AoR3uFYvIJNXtvTg/g=
X-HE-Tag: 1763399172-498585
X-HE-Meta: U2FsdGVkX1+1fbQ1HL57qXLluUvZvLNCw7yYmkD+QHCB/p1/iN1x9cXn89bHWwfz8Xjh8Fm89kfs12fobj4NspPdWL8NWGgROmiApTo4J+7TdLfdT4YtS3j3tiGYFlp9wB/g+kLx0oWzbIA2AobJ2t6pvBp9qwUI9zGL16izGcRAVpwYJStR+XtjJAQpmnCJtTaOWqOcyD9ueUqSf5PScmzd5ws4vRQXFN+uUfX1yCN8HUC++sVtk32no63h8Eq2RyGFSd/oCOXWi9H2G+t3L8g4kVJ+ZnOFqnMkTRGZ5v3nODpqIYPBaO+k2dCWyVAmPplCTjy+CdLS5xhpo3TFK2tegxJLjNv/WSddoGxlvsgZxIk8hpN5O+YHInTgnFvmY2Cc564LTy4usJbyMJW++sh6qdBXeBRN7iwjy6akPvk=

From: Steven Rostedt <rostedt@goodmis.org>

The flags and opts used in tracing_trace_options_show() now come directly
from the trace array "current_trace_flags" and not the current_trace. The
variable "trace" was still being assigned to tr->current_trace but never
used. This caused a warning in clang.

Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Closes: https://lore.kernel.org/all/aRtHWXzYa8ijUIDa@black.igk.intel.com/
Fixes: 428add559b692 ("tracing: Have tracer option be instance specific")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8ae95800592d..59cd4ed8af6d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5167,7 +5167,6 @@ static int tracing_trace_options_show(struct seq_file *m, void *v)
 	struct tracer_opt *trace_opts;
 	struct trace_array *tr = m->private;
 	struct tracer_flags *flags;
-	struct tracer *trace;
 	u32 tracer_flags;
 	int i;
 
@@ -5184,8 +5183,6 @@ static int tracing_trace_options_show(struct seq_file *m, void *v)
 	if (!flags || !flags->opts)
 		return 0;
 
-	trace = tr->current_trace;
-
 	tracer_flags = flags->val;
 	trace_opts = flags->opts;
 
-- 
2.51.0

