Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E002609DC;
	Wed, 26 Nov 2025 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764187678; cv=none; b=anf2C5f0gSqVP2087Meumgri4fQtSV4Z+RbKVp7IizTD1/CXbl/SdZ8TdMINDvDqVLWa4xEL1Ijibx81Z75MLc8N/q76JnC8ap4Gcb5KQ+kl6f3TT2lys6wAHGdMHRUN5E1QxYUGb4tS4O6m2E+vJDgaX4shb5XGSytsGKOuJx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764187678; c=relaxed/simple;
	bh=oNQV0mTC1MJMmTqQ0KNS5M+/45sau+6OTgJezXRGHeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dkv47orCsAGt4lae2enFGtgNzka7EgRwqtvbuOm7Fbt7sx/Umi441BCoh6rXvOPkrrC5ENi/aNLXqJ9v7yLtVwRZTX0xcu8S5wfrB6MUn4EHE+KuLw76LNXwJWN5d+bh9JIkJqSd96d+ahEzCA86AJXicsmMaPwRd+SSseKmjFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 5E27213BAF1;
	Wed, 26 Nov 2025 20:07:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 54E822002A;
	Wed, 26 Nov 2025 20:07:46 +0000 (UTC)
Date: Wed, 26 Nov 2025 15:08:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Cc: Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH] overflow: Introduce struct_offset() to get offset of
 member
Message-ID: <20251126150832.77e2162f@gandalf.local.home>
In-Reply-To: <20251126145249.05b1770a@gandalf.local.home>
References: <20251126145249.05b1770a@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: fn9rqqdwmz9bui9hug9dkwi6h9q1ewjf
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 54E822002A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Gvs1muf0ySEdtxuGNr8yWoU8fIpb9R6Y=
X-HE-Tag: 1764187666-306283
X-HE-Meta: U2FsdGVkX18Q9J3wxqnO53i8DQngllaM0LAtSodvpYs0j/dtHBP1PZ9yP7iRQalCiP6fK/iwnuSI1/d6XQMCt3E1ARKoUUWRcFeXFwq0A1JFuO7ImeMrNGyv+l54kG5DgkwlTxeM+roraySfdRbaLo7I9QpKyOqfJFYgXGbkNRxqqcNYCYeW4dk5jKWfcusYeI5MlRF8Kh6qRLNeO1YtTiYF2JF+hXlGWF25dHDhlsQQy2jMJyd5SbR71/j25qWigHiglRsq5nE4TeAhg6bXW9rIj6aq+EZ7zGXZwrnS6/vCZybmEw/u4EcXzbx9gshCN1OP/o9dM37W/6uE+Y9+M06ZmKmz19h198V0hzLDlTpSJu5d7TwBtPvi1L8IuJKw

On Wed, 26 Nov 2025 14:52:49 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> This will likely come in handy for other use cases too.

Just looking at kernel/trace, I can see the following use cases too:

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index e21176f396d5..b6a4c2050127 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1482,7 +1482,7 @@ static void blk_trace_synthesize_old_trace(struct trace_iterator *iter)
 {
 	struct trace_seq *s = &iter->seq;
 	struct blk_io_trace *t = (struct blk_io_trace *)iter->ent;
-	const int offset = offsetof(struct blk_io_trace, sector);
+	const int offset = struct_offset(t, sector);
 	struct blk_io_trace old = {
 		.magic	  = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION,
 		.time     = iter->ts,
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 17c75cf2348e..7ff2a23e23c9 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -955,7 +955,7 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 	int cpu = iter->cpu;
 	int i;
 
-	args_size = iter->ent_size - offsetof(struct ftrace_graph_ent_entry, args);
+	args_size = iter->ent_size - struct_offset(entry, args);
 
 	graph_ret = &ret_entry->ret;
 	call = &entry->graph_ent;
@@ -1048,7 +1048,7 @@ print_graph_entry_nested(struct trace_iterator *iter,
 
 	trace_seq_printf(s, "%ps", (void *)func);
 
-	args_size = iter->ent_size - offsetof(struct ftrace_graph_ent_entry, args);
+	args_size = iter->ent_size - struct_offset(entry, args);
 
 	if (args_size >= FTRACE_REGS_MAX_ARGS * sizeof(long))
 		print_function_args(s, FGRAPH_ENTRY_ARGS(entry), func);
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index ebbab3e9622b..30113756d56f 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1167,7 +1167,7 @@ static enum print_line_t trace_fn_trace(struct trace_iterator *iter, int flags,
 
 	trace_assign_type(field, iter->ent);
 
-	args_size = iter->ent_size - offsetof(struct ftrace_entry, args);
+	args_size = iter->ent_size - struct_offset(field, args);
 	if (args_size >= FTRACE_REGS_MAX_ARGS * sizeof(long))
 		args = field->args;
 	else
@@ -1799,7 +1799,7 @@ static enum print_line_t trace_raw_data(struct trace_iterator *iter, int flags,
 
 	trace_seq_printf(&iter->seq, "# %x buf:", field->id);
 
-	for (i = 0; i < iter->ent_size - offsetof(struct raw_data_entry, buf); i++)
+	for (i = 0; i < iter->ent_size - struct_offset(field, buf); i++)
 		trace_seq_printf(&iter->seq, " %02x",
 				 (unsigned char)field->buf[i]);
 
It better associates the variable with its member offset.

-- Steve
