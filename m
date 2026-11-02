Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793603480;
	b=4vP8qKjk5Lk8IB06CxjWbchKMsgEeNMwbAt05bQ53eM59jpsmoMRfppcBZBj22VnI//R
	 we7abKnF2NCDYhta3LXnNpVRhM+xoW8BRopQWQoSGsDbhMlrrlXKcLLgI4zDtG9ocMuTj
	 BjKeTkKmYnLXqm0agAOXXXpYeeYmdrGWLUrSWHCUFzsng8IDh9SrP55M9xKTTerj+G2Dz
	 NTI/k+tFMHYr9xbZLJsxrhLpCF3hOX0dg+pyJ6eVfsCt9tWwhf0IPmwkRBhumKjYTIBna
	 KAiBVX9u2R5JgYjMtvbgbppGbAmYITHrSohz4rtXH98id/LqmZNHKp2YvRkvlbiCCQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793603480;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vdJ+DRR1faeDX0v1ueX7wcbZbUYELAr7oYz44rJN8Lo=;
	b=CWM63uInek8kxyMzayulTm0SKIzvmO/rgjj0FexVt0x89AwB+wKos42KJPiVE1PhN/OA
	 Z2293518nFGGbMYwy7oOnCfRnNB0bbuk1MQYVObdznW3vLrsxST6PxlLpQlKh8RFI6JqQ
	 ujfiBZY9K/odgM7hGZNZSKRYGLirfVJ7/d5rOXfsT3S8iOVWyhbikeELkiPEIykOyk4TK
	 g1d/uYTiLvfIxZc9aawXem1DhhTXp1ok8o73fwysDP2DFVjqwl2zuHZg19rWtbU2lrwCd
	 G/emeUIfse+F2Cq2JjT+WEvq5fHtuUwD8+R/biS7OShHJohSeyJpmD3tdrJ5kydj7Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PAmcE8te;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BD2606A326;
	Mon,  2 Nov 2026 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PAmcE8te
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B5C1F000C1;
	Mon,  2 Nov 2026 07:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793603479;
	bh=vdJ+DRR1faeDX0v1ueX7wcbZbUYELAr7oYz44rJN8Lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PAmcE8teEI5/r9lpAn92elD6CCPy5HQA1EENzUvMLrx9h4QpWTPRrvh3Qr2ysL1ND
	 2rx9LSOUusnFOklhFvhmP1wwjIJsRbidJ+wZhvggsFYFnEGyfrErVtngHlNlgNS309
	 v5GpNJnZO5ZIakjkIfiZQ4330b4wW4Buzjpnua6sB22gAnkja90hYun7d3PPR1Y9Qt
	 0l21iPPbcmR7Est63UlCoqALta9SUG0BExp1FyIiE6WJA5EvjpM1uGxDY5esXb/OuJ
	 8OR8wZRFcHAzL3hc4QCx+X4A0C9jTzLvinpgVW77q6V17sv6Y6il59qP/4RmzwEFSw
	 kily4Ig3ZOy+Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 2/3] samples/fprobe: Use trace_printk() and trace_dump_stack()
Date: Mon,  2 Nov 2026 16:11:15 +0900
Message-ID: <179360347512.115681.7201999490892291449.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179360345418.115681.193455787480210412.stgit@devnote2>
References: <179360345418.115681.193455787480210412.stgit@devnote2>
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Fprobe entry and exit callbacks execute in atomic context with
preemption disabled under ftrace recursion protection. Calling
printk() directly inside handlers can lead to deadlocks if console
or scheduler locks are already held by the probed or interrupted context.

Drop the use_trace module parameter and always use trace_printk()
for handler logging. In addition, replace stack_trace_print() (which
uses printk()) with trace_dump_stack(0) to output backtraces safely
to the ftrace buffer. Also update the module header comment to
reference /sys/kernel/tracing/trace.

Additionally, update CONFIG_SAMPLE_FPROBE in samples/Kconfig to
depend on EVENT_TRACING so that the tracing subsystem is enabled
when building the sample.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 samples/Kconfig                 |    2 +-
 samples/fprobe/fprobe_example.c |   49 ++++++++-------------------------------
 2 files changed, 11 insertions(+), 40 deletions(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index 54414e57ff75..744d991ea620 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -88,7 +88,7 @@ config SAMPLE_HW_BREAKPOINT
 
 config SAMPLE_FPROBE
 	tristate "Build fprobe examples -- loadable modules only"
-	depends on FPROBE && m
+	depends on FPROBE && EVENT_TRACING && m
 	help
 	  This builds a fprobe example module. This module has an option 'symbol'.
 	  You can specify a probed symbol or symbols separated with ','.
diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
index bfe98ce826f3..3b94839b3199 100644
--- a/samples/fprobe/fprobe_example.c
+++ b/samples/fprobe/fprobe_example.c
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Here's a sample kernel module showing the use of fprobe to dump a
- * stack trace and selected registers when kernel_clone() is called.
+ * stack trace and function entry/exit when kernel_clone() is called.
  *
- * For more information on theory of operation of kprobes, see
- * Documentation/trace/kprobes.rst
+ * For more information on theory of operation of fprobe, see
+ * Documentation/trace/fprobe.rst
  *
- * You will see the trace data in /var/log/messages and on the console
+ * You will see the trace data in /sys/kernel/tracing/trace
  * whenever kernel_clone() is invoked to create a new process.
  */
 
@@ -15,10 +15,9 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/fprobe.h>
-#include <linux/sched/debug.h>
 #include <linux/slab.h>
+#include <linux/trace_printk.h>
 
-#define BACKTRACE_DEPTH 16
 #define MAX_SYMBOL_LEN 4096
 static struct fprobe sample_probe;
 static unsigned long nhit;
@@ -35,34 +34,14 @@ static bool stackdump = true;
 module_param(stackdump, bool, 0644);
 MODULE_PARM_DESC(stackdump, "Enable stackdump.");
 
-static bool use_trace = false;
-module_param(use_trace, bool, 0644);
-MODULE_PARM_DESC(use_trace, "Use trace_printk instead of printk. This is only for debugging.");
-
-static void show_backtrace(void)
-{
-	unsigned long stacks[BACKTRACE_DEPTH];
-	unsigned int len;
-
-	len = stack_trace_save(stacks, BACKTRACE_DEPTH, 2);
-	stack_trace_print(stacks, len, 24);
-}
-
 static int sample_entry_handler(struct fprobe *fp, unsigned long ip,
 				unsigned long ret_ip,
 				struct ftrace_regs *fregs, void *data)
 {
-	if (use_trace)
-		/*
-		 * This is just an example, no kernel code should call
-		 * trace_printk() except when actively debugging.
-		 */
-		trace_printk("Enter <%pS> ip = 0x%p\n", (void *)ip, (void *)ip);
-	else
-		pr_info("Enter <%pS> ip = 0x%p\n", (void *)ip, (void *)ip);
+	trace_printk("Enter <%pS> ip = 0x%p\n", (void *)ip, (void *)ip);
 	nhit++;
 	if (stackdump)
-		show_backtrace();
+		trace_dump_stack(0);
 	return 0;
 }
 
@@ -72,19 +51,11 @@ static void sample_exit_handler(struct fprobe *fp, unsigned long ip,
 {
 	unsigned long rip = ret_ip;
 
-	if (use_trace)
-		/*
-		 * This is just an example, no kernel code should call
-		 * trace_printk() except when actively debugging.
-		 */
-		trace_printk("Return from <%pS> ip = 0x%p to rip = 0x%p (%pS)\n",
-			(void *)ip, (void *)ip, (void *)rip, (void *)rip);
-	else
-		pr_info("Return from <%pS> ip = 0x%p to rip = 0x%p (%pS)\n",
-			(void *)ip, (void *)ip, (void *)rip, (void *)rip);
+	trace_printk("Return from <%pS> ip = 0x%p to rip = 0x%p (%pS)\n",
+		     (void *)ip, (void *)ip, (void *)rip, (void *)rip);
 	nhit++;
 	if (stackdump)
-		show_backtrace();
+		trace_dump_stack(0);
 }
 
 static int __init fprobe_init(void)

