Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6A5749C;
	Thu, 27 Mar 2025 02:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040939; cv=none; b=k3zsuNeHjaSrXpsDcXSYUGjzVjzWkwruRZKs3zC2OVfWjnrTmIq3AY9sIUp3YQAdz0Plb4VEKfTeoKnhp6C1n4QtWqA3Vu9oqUHEgrEYxtcGymgGrvU6AK68MIzIUQvPtT/Jiz44aVonzpOV/cofJkWb7O2NjIus82ygXFtb5YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040939; c=relaxed/simple;
	bh=QTm8aqWhBr/Vv2WvqLMhBkqrqN8N/oJe1ueW/F/El1o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mY1eKKbZBcpy1TjkYiyWR8bNfnZ2iP34AJcXyckn6Tvjc/DWk1piTSQfjZ1P49iNIhSeCUYccRuNjfHzJmGxhIidWL9OiBD79DC2/f3X/oacHwMtRAreMtOGgPy1qzCYWS95G1DlFxUZHoZeKYU9NgqIWbjz+XKy2OY80f259T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BD2C4CEE2;
	Thu, 27 Mar 2025 02:02:17 +0000 (UTC)
Date: Wed, 26 Mar 2025 22:03:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Use _text and the kernel offset in last_boot_info
Message-ID: <20250326220304.38dbedcd@gandalf.local.home>
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

Instead of using kaslr_offset() just record the location of "_text". This
makes it possible for user space to use either the System.map or
/proc/kallsyms as what to map all addresses to functions with.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 85128ef96246..3b8f5e3313e0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -51,7 +51,7 @@
 #include <linux/workqueue.h>
 #include <linux/sort.h>
 
-#include <asm/setup.h> /* COMMAND_LINE_SIZE and kaslr_offset() */
+#include <asm/setup.h> /* COMMAND_LINE_SIZE */
 
 #include "trace.h"
 #include "trace_output.h"
@@ -5995,7 +5995,7 @@ struct trace_mod_entry {
 };
 
 struct trace_scratch {
-	unsigned long		kaslr_addr;
+	unsigned long		text_addr;
 	unsigned long		nr_entries;
 	struct trace_mod_entry	entries[];
 };
@@ -6137,11 +6137,7 @@ static void update_last_data(struct trace_array *tr)
 	kfree_rcu(module_delta, rcu);
 
 	/* Set the persistent ring buffer meta data to this address */
-#ifdef CONFIG_RANDOMIZE_BASE
-	tscratch->kaslr_addr = kaslr_offset();
-#else
-	tscratch->kaslr_addr = 0;
-#endif
+	tscratch->text_addr = (unsigned long)_text;
 }
 
 /**
@@ -7000,7 +6996,7 @@ static void show_last_boot_header(struct seq_file *m, struct trace_array *tr)
 	 * should not be the same as the current boot.
 	 */
 	if (tscratch && (tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
-		seq_printf(m, "%lx\t[kernel]\n", tscratch->kaslr_addr);
+		seq_printf(m, "%lx\t[kernel]\n", tscratch->text_addr);
 	else
 		seq_puts(m, "# Current\n");
 }
@@ -9465,10 +9461,8 @@ static void setup_trace_scratch(struct trace_array *tr,
 	tr->scratch = tscratch;
 	tr->scratch_size = size;
 
-#ifdef CONFIG_RANDOMIZE_BASE
-	if (tscratch->kaslr_addr)
-		tr->text_delta = kaslr_offset() - tscratch->kaslr_addr;
-#endif
+	if (tscratch->text_addr)
+		tr->text_delta = (unsigned long)_text - tscratch->text_addr;
 
 	if (struct_size(tscratch, entries, tscratch->nr_entries) > size)
 		goto reset;
-- 
2.47.2

