Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2461B87E0;
	Mon, 16 Dec 2024 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734385561; cv=none; b=rXNZUfgXIgqXAAON/WQ62ikW35dz1063GgD/pwIRBOrnhZWonNaf6Ibngbjobq4ukexQ/CjFu1QinjYfvFpUXDdGSIeKSXHBN9efA35MonqTuj6vBJIw5NIukGFErDWRMLbAVQO+GCzFfBNLO4yKNGshu/7063yZtxchYuxMvP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734385561; c=relaxed/simple;
	bh=nZYfZErGXFFaOfoXBYO5Ut9hZ2ETjfjWqO7Od6pEiWw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=l5f2yy7fwUCTMa1etM/LzP7OG/z4dyfS1zkudjauOyZyChtdfEhn1M8WxV1SzN0yuQRxzbxExyn8A646oFv+ENf+j9rIwF9GMhwkhU0xyUzmitqaB7UBNEv2za1TdL8CDGnKx3FSIDk/4AM7epXpsaOx6a1St4rWCptsXgvWnRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF36C4CED0;
	Mon, 16 Dec 2024 21:46:00 +0000 (UTC)
Date: Mon, 16 Dec 2024 16:46:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, Al
 Viro <viro@ZenIV.linux.org.uk>, Michal Simek <monstr@monstr.eu>, Jeff Xie
 <jeff.xie@linux.dev>
Subject: [PATCH v1] ftrace: Do not find "true_parent" if
 HAVE_DYNAMIC_FTRACE_WITH_ARGS is not set
Message-ID: <20241216164633.6df18e87@gandalf.local.home>
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

When function tracing and function graph tracing are both enabled (in
different instances) the "parent" of some of the function tracing events
is "return_to_handler" which is the trampoline used by function graph
tracing. To fix this, ftrace_get_true_parent_ip() was introduced that
returns the "true" parent ip instead of the trampoline.

To do this, the ftrace_regs_get_stack_pointer() is used, which uses
kernel_stack_pointer(). The problem is that microblaze does not implement
kerenl_stack_pointer() so when function graph tracing is enabled, the
build fails. But microblaze also does not enabled HAVE_DYNAMIC_FTRACE_WITH_ARGS.
That option has to be enabled by the architecture to reliably get the
values from the fregs parameter passed in. When that config is not set,
the architecture can also pass in NULL, which is not tested for in that
function and could cause the kernel to crash.

Fixes: 60b1f578b578 ("ftrace: Get the true parent ip for function tracer")
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20241211153634.69c75afa@batman.local.home

- The issue with Microblaze was that it does not implement HAVE_DYNAMIC_FTRACE_WITH_ARGS
  and not that it didn't have kernel_stack_pointer() implemented. With the above
  config option implemented, function_get_true_parent_ip() will not work at all.

 kernel/trace/trace_functions.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 74c353164ca1..d358c9935164 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -176,7 +176,8 @@ static void function_trace_start(struct trace_array *tr)
 	tracing_reset_online_cpus(&tr->array_buffer);
 }
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+/* fregs are guaranteed not to be NULL if HAVE_DYNAMIC_FTRACE_WITH_ARGS is set */
+#if defined(CONFIG_FUNCTION_GRAPH_TRACER) && defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS)
 static __always_inline unsigned long
 function_get_true_parent_ip(unsigned long parent_ip, struct ftrace_regs *fregs)
 {
-- 
2.45.2

