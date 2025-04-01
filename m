Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B97156C62;
	Tue,  1 Apr 2025 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525865; cv=none; b=BA9XSG3hIOKPaQFln4n9otZkuoXCyWBt9eayf5J2EUtB9iTPF9jESUdKBjkOJeLWov8hJEC6q5Rv1dOyFoc8BpakIEXhWNvSPlilT8Y1ad5AYY0O0hdld2MAgoGfwfCkS+MnF8vI1wuaSiTG7Qc10K+jFlUbuFjwjjk5ZnnPLFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525865; c=relaxed/simple;
	bh=KlYyLdHcGHJAXtSia8h2djWc7kPY4GDhFkHcNMM2Vvk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ss+edHA2jA1U2pNv7bXA+Mrb06H3zBM0Ebr49rLG2NQ7+8/YMib0AsPqV+z4x1TAR6uiQwWd9gqyuGx0BMrx6MmGqQSrShykffFTT+UMKSipcQ2Fh3JvUv3xwKgq3aRDK+44a5EV63UKyvX/HybCepdurfXOM2/+vVyyTkiAclM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80EEC4CEE4;
	Tue,  1 Apr 2025 16:44:24 +0000 (UTC)
Date: Tue, 1 Apr 2025 12:45:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Free module_delta on freeing of persistent ring
 buffer
Message-ID: <20250401124525.1f9ac02a@gandalf.local.home>
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

If a persistent ring buffer is created, a "module_delta" array is also
allocated to hold the module deltas of loaded modules that match modules
in the scratch area. If this buffer gets freed, the module_delta array is
not freed and causes a memory leak.

Fixes: 35a380ddbc65 ("tracing: Show last module text symbols in the stacktrace")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 103b193875b3..de6d7f0e6206 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9609,6 +9609,7 @@ static void free_trace_buffers(struct trace_array *tr)
 		return;
 
 	free_trace_buffer(&tr->array_buffer);
+	kfree(tr->module_delta);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
 	free_trace_buffer(&tr->max_buffer);
-- 
2.47.2

