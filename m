Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F3B27587D;
	Mon,  5 May 2025 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480150; cv=none; b=n5k5ndbiEgS4qBSaCn186JbRhPmBQ3tdmFIYVzYd4PEAA7325KkWdek8vL6OqaC+nlsqaTwY1KKp3Tmub8bFNXEsqpgs8vmVXsVLuaVvJJ5GwNFrnizxbxJXjhYMiA90OACJ17qh0q5nu5jkOzKIZIHclD16wgL0HlWsYGz1FsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480150; c=relaxed/simple;
	bh=kDDwdzFGDecCKLKcAFTEIhC27hC7gy2Pe7+JNQFKbjg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ghdzIXHKtpdeTBk9VGyZe30kriih++/AA4RkbBZcyp7TUZWynoe60eTA1ZEU20b9/N8827u/6BphJWatSndspHt7Qvjs+AJtILzoJbSVWE4pw54ccJhmrbKwXONzKXAzsqpsW0LhNm6pNQHimpoiPUYCRdgMHUZckREBq38c4E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8548CC4CEE4;
	Mon,  5 May 2025 21:22:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uC3Gm-00000000yFk-1ZKj;
	Mon, 05 May 2025 17:22:36 -0400
Message-ID: <20250505212236.224658526@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 05 May 2025 17:21:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 10/13] tracing: branch: Use trace_tracing_is_on_cpu() instead of "disabled"
 field
References: <20250505212104.986494754@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The branch tracer currently checks the per CPU "disabled" field to know if
tracing is enabled or not for the CPU. As the "disabled" value is not used
anymore to turn of tracing generically, use tracing_tracer_is_on_cpu()
instead.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20250502205349.299144667@goodmis.org

- Fixed "raw_smp_process_id()" to "raw_smp_processor_id()"
  (kernel test robot)

 kernel/trace/trace_branch.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace_branch.c b/kernel/trace/trace_branch.c
index 6d08a5523ce0..6809b370e991 100644
--- a/kernel/trace/trace_branch.c
+++ b/kernel/trace/trace_branch.c
@@ -32,7 +32,6 @@ probe_likely_condition(struct ftrace_likely_data *f, int val, int expect)
 {
 	struct trace_array *tr = branch_tracer;
 	struct trace_buffer *buffer;
-	struct trace_array_cpu *data;
 	struct ring_buffer_event *event;
 	struct trace_branch *entry;
 	unsigned long flags;
@@ -54,8 +53,7 @@ probe_likely_condition(struct ftrace_likely_data *f, int val, int expect)
 
 	raw_local_irq_save(flags);
 	current->trace_recursion |= TRACE_BRANCH_BIT;
-	data = this_cpu_ptr(tr->array_buffer.data);
-	if (atomic_read(&data->disabled))
+	if (!tracer_tracing_is_on_cpu(tr, raw_smp_processor_id()))
 		goto out;
 
 	trace_ctx = tracing_gen_ctx_flags(flags);
-- 
2.47.2


