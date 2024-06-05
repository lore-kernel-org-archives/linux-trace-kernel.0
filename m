Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C593D15099F;
	Wed,  5 Jun 2024 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619225; cv=none; b=qwS8byGIdfVGjiJRWL+MsyLiPUHSP7/gsQGTg28tHr6zncoYyhKHSYI46KqfOT51xDUlh9cfKfTeHNs9mB8nKgngJ8gPig0OsDBzpwuXLD9CJxiTwjhDRr/JZLju6MrO4ixmOd4aINRWJfeh1uzC7MS48MivGjy9MZoliHWwqOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619225; c=relaxed/simple;
	bh=syTGjDVnQ+cdUU7BaGwOwiOKne/SDex7bNLLogAsKak=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MAYyPQn/WfUB69FMJt9tfAIhCiuY0VOB+FCVIpBUONsiWtgxSjzdt848KnK/jsb8Y9vM852jO+r6qa44TOa9XWGnzgdTRT4TJXf4uyT1qX+o+wTW+CFc0nxKHt+LW8yScN5fWKzpn/VVIO6AZdi/da4pQm4406H1vPjiHmMvWeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668DDC32782;
	Wed,  5 Jun 2024 20:27:05 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sExDw-00000000i6v-1npP;
	Wed, 05 Jun 2024 16:27:08 -0400
Message-ID: <20240605202708.289105647@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 05 Jun 2024 16:26:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/6] ftrace: Declare function_trace_op in header to quiet sparse warning
References: <20240605202644.293295925@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Sparse complains that function_trace_op is not static but is not declared
in a header file. It is used only in assembly code. But add it to a header
so that sparse no longer complains:

 kernel/trace/ftrace.c:99:19: warning: symbol 'function_trace_op' was not declared. Should it be static?

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 9f61556a9491..4135dc171447 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1131,6 +1131,9 @@ extern void ftrace_graph_init_task(struct task_struct *t);
 extern void ftrace_graph_exit_task(struct task_struct *t);
 extern void ftrace_graph_init_idle_task(struct task_struct *t, int cpu);
 
+/* Used by assembly, but to quiet sparse warnings */
+extern struct ftrace_ops *function_trace_op;
+
 static inline void pause_graph_tracing(void)
 {
 	atomic_inc(&current->tracing_graph_pause);
-- 
2.43.0


