Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CFC22DFAB;
	Tue, 11 Feb 2025 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739285237; cv=none; b=keVZZFXlcRmrYlUKmoJGzunLvcuYhnIJ7bVv59UL/vMite3OEgEIY1j31mmRslaeMgUSKpUpw8rA+luJwXnRVBrLX9PwSo5SV+bdOFtVTasdDaWlwvoby6KFvLCXhspjJhz6C4X+NMkLZUO0/Ztl/dlJeVOu+EFxSQ/e0hLHIlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739285237; c=relaxed/simple;
	bh=IMXhUh+LvBqqnxHDzfR/z2JEf/R81KABs+3oYdSif1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vEfiZmi1U2XlwtjcSEyRxQtsZSboS2btsMLvkXqx1gxbVYw+YnzV29fWQ/ma6iI5N96BAs9kCrF9clXWHFS4hUPMMvJ6SIBneVi6VK9OYP1MSgyCFGYlAroxIz0pd77fn2hQOWVoLkYQEziN3BoHZBkPJTghKJyHDFWRzr27B54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7cr8pj3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7cr8pj3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E36C4CEDD;
	Tue, 11 Feb 2025 14:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739285236;
	bh=IMXhUh+LvBqqnxHDzfR/z2JEf/R81KABs+3oYdSif1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W7cr8pj3Ld3Dc6xTThGJKIgA2IoB4QRlUh2I2sYRDvE66QuUx+gABmkdANdAhQhNM
	 lJ1mG/xunrvDPEUkhYFMH0zdHOAavxOBwEGytzf405lX0Yfof4Kt9xG7YEqVb19v2H
	 tA5QRi3c5UX12N5B04K3xRLEZVe6XFKfpWc7++OuaVZi7iiVYGFjCw/KeOtL4Na0RA
	 mVtG7/530Q4MkMIWcKlE5WSOMQ2muw0tZIn6Y3sOA9ZHNHbeoedjUPhnDW7K9xlnXn
	 Gb+sYTKPfYKItukcZ0enPYmYP8TESsqyMzzuuAVFvRyFGwjDXTSBs6Smb6O4J6hWX2
	 5HCJ7pTihzA0A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 2/2] tracing: Freeable reserved ring buffer
Date: Tue, 11 Feb 2025 23:47:13 +0900
Message-ID: <173928523317.906035.18148624462817732309.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173928521419.906035.17750338150436695675.stgit@devnote2>
References: <173928521419.906035.17750338150436695675.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Make the ring buffer on reserved memory to be freeable. This allows us
to free the trace instance on the reserved memory without changing
cmdline and rebooting. Even if we can not change the kernel cmdline
for security reason, we can release the reserved memory for the ring
buffer as free (available) memory.

For example, boot kernel with reserved memory;
"reserve_mem=20M:2M:trace trace_instance=boot_mapped^traceoff@trace"

 # free
              total        used        free      shared  buff/cache   available
Mem:        1994720       45292     1931960       14908       17468     1915920
Swap:             0           0           0
 # rmdir /sys/kernel/tracing/instances/boot_mapped/
 # free
              total        used        free      shared  buff/cache   available
Mem:        1994720       17204     1960060       14912       17456     1944012
Swap:             0           0           0

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Remove debug printk.
---
 kernel/trace/trace.c |   13 ++++++++++++-
 kernel/trace/trace.h |    1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1496a5ac33ae..9c7921ec7e91 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9286,6 +9286,9 @@ static void free_trace_buffers(struct trace_array *tr)
 #ifdef CONFIG_TRACER_MAX_TRACE
 	free_trace_buffer(&tr->max_buffer);
 #endif
+
+	if (tr->range_addr_start)
+		vunmap((void *)tr->range_addr_start);
 }
 
 static void init_trace_flags_index(struct trace_array *tr)
@@ -9447,6 +9450,7 @@ trace_array_create_systems(const char *name, const char *systems,
 	free_cpumask_var(tr->pipe_cpumask);
 	free_cpumask_var(tr->tracing_cpumask);
 	kfree_const(tr->system_names);
+	kfree(tr->range_name);
 	kfree(tr->name);
 	kfree(tr);
 
@@ -9573,6 +9577,11 @@ static int __remove_instance(struct trace_array *tr)
 	free_trace_buffers(tr);
 	clear_tracing_err_log(tr);
 
+	if (tr->range_name) {
+		reserve_mem_release_by_name(tr->range_name);
+		kfree(tr->range_name);
+	}
+
 	for (i = 0; i < tr->nr_topts; i++) {
 		kfree(tr->topts[i].topts);
 	}
@@ -10370,6 +10379,7 @@ __init static void enable_instances(void)
 		bool traceoff = false;
 		char *flag_delim;
 		char *addr_delim;
+		char *rname __free(kfree) = NULL;
 
 		tok = strsep(&curr_str, ",");
 
@@ -10426,6 +10436,7 @@ __init static void enable_instances(void)
 				pr_warn("Failed to map boot instance %s to %s\n", name, tok);
 				continue;
 			}
+			rname = kstrdup(tok, GFP_KERNEL);
 		}
 
 		if (start) {
@@ -10462,7 +10473,7 @@ __init static void enable_instances(void)
 		 */
 		if (start) {
 			tr->flags |= TRACE_ARRAY_FL_BOOT;
-			tr->ref++;
+			tr->range_name = no_free_ptr(rname);
 		}
 
 		while ((tok = strsep(&curr_str, ","))) {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 9c21ba45b7af..93b6279d3da4 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -348,6 +348,7 @@ struct trace_array {
 	unsigned int		mapped;
 	unsigned long		range_addr_start;
 	unsigned long		range_addr_size;
+	char			*range_name;
 	long			text_delta;
 	long			data_delta;
 

