Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C57252496;
	Wed, 11 Dec 2024 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943218; cv=none; b=bE++CPq/MgHVMbPsxKvIb+YmevyvVEqATwYQSbcY6bw8lkIBa0jvkMEACKTdCOhnZ4MKhV5y2VNhdZe7iY4PG+JKGqZx82mRCmnED4Ca8HITWMKcD/Dtwb4+fQByr8dFKFsFw4PO6NMa18sc2nKaCsz2uqxy/EkaEBfnjA57LH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943218; c=relaxed/simple;
	bh=avb4WuD0VNAVSZQsNE1CfG9LwILOm46zt+jwD3q4+sc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gl93P5x6v/EBvDNPSj6zcjrf0zFQDPaMczNxOuuLSV+AzT99kCBBfSJsyUyyJd67SDFHLNPCgGu0K66c1apoxDaVm5MmoGR/sVSzU1yzjqDG1tBe0SYFmx3ab9BUCbxWWfWdQeDKa+JwWhRTVq1VaBqYwwRk8Om9L0G6n721W7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2795AC4CEDE;
	Wed, 11 Dec 2024 18:53:37 +0000 (UTC)
Date: Wed, 11 Dec 2024 13:53:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] fgraph: Still initialize idle shadow stacks when starting
Message-ID: <20241211135335.094ba282@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

A bug was discovered where the idle shadow stacks were not initialized
for offline CPUs when starting function graph tracer, and when they came
online they were not traced due to the missing shadow stack. To fix
this, the idle task shadow stack initialization was moved to using the
CPU hotplug callbacks. But it removed the initialization when the
function graph was enabled. The problem here is that the hotplug
callbacks are called when the CPUs come online, but the idle shadow
stack initialization only happens if function graph is currently
active. This caused the online CPUs to not get their shadow stack
initialized.

The idle shadow stack initialization still needs to be done when the
function graph is registered, as they will not be allocated if function
graph is not registered.

Cc: stable@vger.kernel.org
Fixes: 2c02f7375e65 ("fgraph: Use CPU hotplug mechanism to initialize idle shadow stacks")
Reported-by: Linus Walleij <linus.walleij@linaro.org>
Closes: https://lore.kernel.org/all/CACRpkdaTBrHwRbbrphVy-=SeDz6MSsXhTKypOtLrTQ+DgGAOcQ@mail.gmail.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 0bf78517b5d4..ddedcb50917f 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1215,7 +1215,7 @@ void fgraph_update_pid_func(void)
 static int start_graph_tracing(void)
 {
 	unsigned long **ret_stack_list;
-	int ret;
+	int ret, cpu;
 
 	ret_stack_list = kcalloc(FTRACE_RETSTACK_ALLOC_SIZE,
 				 sizeof(*ret_stack_list), GFP_KERNEL);
@@ -1223,6 +1223,12 @@ static int start_graph_tracing(void)
 	if (!ret_stack_list)
 		return -ENOMEM;
 
+	/* The cpu_boot init_task->ret_stack will never be freed */
+	for_each_online_cpu(cpu) {
+		if (!idle_task(cpu)->ret_stack)
+			ftrace_graph_init_idle_task(idle_task(cpu), cpu);
+	}
+
 	do {
 		ret = alloc_retstack_tasklist(ret_stack_list);
 	} while (ret == -EAGAIN);
-- 
2.45.2

