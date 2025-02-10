Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D603241C89;
	Mon, 10 Feb 2025 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739202262; cv=none; b=Aa+1Zw3P98lr079/7RJze8aeWGFiOEVlQGXJoBwJqiQ6/rNrg+RFaMTLdcnbKjZrRvmoK04fzx8CTcznrEmKeXvSaCDmOJKQCd8IhDW5vTcbEX9WgJQn2W806MkJSV2DOCww7QPITYqGNq5hQjclanJjPbt9NiPxIIZ98AJplRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739202262; c=relaxed/simple;
	bh=a1YPttl+qkE5UPQa+Ej7ligSEOM91uyMY3DsNFx/Ops=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncjdGAtb5RgHJDaS+UAvFp5AMjtwDl0wXTNipxuchUmDNO7YXnZHLiwAaKrIHg0BYTPC0yOj0l2mqDEkJmovowuSibH4ZNah1wAljz4yFsf+mP+DjL7YxIOyubjix3UasRUYwIPw8L6HUhOTIzGYazYZvAaoqXAzvgaLVc2SgcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buqlvxwG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buqlvxwG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C30C4CED1;
	Mon, 10 Feb 2025 15:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739202262;
	bh=a1YPttl+qkE5UPQa+Ej7ligSEOM91uyMY3DsNFx/Ops=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=buqlvxwGzRgS9DeXYQ+MjvkLCJEHL0Wxn+Ebq5PZaum/c6jXytv/wRu/7TBWw0nMB
	 3NKC69Nu1bHvKFBu9t2x1Y94ckDNY0NCmhdTY35fZUOYGvBYYmNVx3vpZSuvCzMUpT
	 QvUsaQK9isnSriujDOoe25jOeb9xoXF05Hyx7ofUDk4nCCEwYtJ04fwU3VwhBHxd+C
	 uj6DtDZvXQ0h8ZcIojWZxaVA+ttLh7ZLiL+fryG4Qt3BNxHK1S9bfL+ykMP3XlofPQ
	 ybOsx5CQi4ZRZwVsogW2DurSfr5tWQuhBBjVMUsxhQ43PXnrwT43eTRwKm9Lc1yzy/
	 ptcQNsBApq7kQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH v2 3/3] tracing: Freeable reserved ring buffer
Date: Tue, 11 Feb 2025 00:44:17 +0900
Message-ID: <173920225773.826592.6428338529686044470.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173920222697.826592.3726270716809214055.stgit@devnote2>
References: <173920222697.826592.3726270716809214055.stgit@devnote2>
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
 kernel/trace/trace.c |   17 +++++++++++++++--
 kernel/trace/trace.h |    1 +
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index dde8000a5614..113ad3179ecd 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9594,6 +9594,9 @@ static void free_trace_buffers(struct trace_array *tr)
 #ifdef CONFIG_TRACER_MAX_TRACE
 	free_trace_buffer(&tr->max_buffer);
 #endif
+
+	if (tr->range_addr_start)
+		vunmap((void *)tr->range_addr_start);
 }
 
 static void init_trace_flags_index(struct trace_array *tr)
@@ -9755,6 +9758,7 @@ trace_array_create_systems(const char *name, const char *systems,
 	free_cpumask_var(tr->pipe_cpumask);
 	free_cpumask_var(tr->tracing_cpumask);
 	kfree_const(tr->system_names);
+	kfree(tr->range_name);
 	kfree(tr->name);
 	kfree(tr);
 
@@ -9857,8 +9861,10 @@ static int __remove_instance(struct trace_array *tr)
 	int i;
 
 	/* Reference counter for a newly created trace array = 1. */
-	if (tr->ref > 1 || (tr->current_trace && tr->trace_ref))
+	if (tr->ref > 1 || (tr->current_trace && tr->trace_ref)) {
+		pr_info("Instance is busy: ref %d trace_ref %d\n", tr->ref, tr->trace_ref);
 		return -EBUSY;
+	}
 
 	list_del(&tr->list);
 
@@ -9881,6 +9887,11 @@ static int __remove_instance(struct trace_array *tr)
 	free_trace_buffers(tr);
 	clear_tracing_err_log(tr);
 
+	if (tr->range_name) {
+		reserved_mem_release_by_name(tr->range_name);
+		kfree(tr->range_name);
+	}
+
 	for (i = 0; i < tr->nr_topts; i++) {
 		kfree(tr->topts[i].topts);
 	}
@@ -10740,6 +10751,7 @@ __init static void enable_instances(void)
 		bool traceoff = false;
 		char *flag_delim;
 		char *addr_delim;
+		char *rname __free(kfree) = NULL;
 
 		tok = strsep(&curr_str, ",");
 
@@ -10796,6 +10808,7 @@ __init static void enable_instances(void)
 				pr_warn("Failed to map boot instance %s to %s\n", name, tok);
 				continue;
 			}
+			rname = kstrdup(tok, GFP_KERNEL);
 		}
 
 		if (start) {
@@ -10832,7 +10845,7 @@ __init static void enable_instances(void)
 		 */
 		if (start) {
 			tr->flags |= TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT;
-			tr->ref++;
+			tr->range_name = no_free_ptr(rname);
 		}
 
 		while ((tok = strsep(&curr_str, ","))) {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 47c0742fe9ec..ae8f7fac6592 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -348,6 +348,7 @@ struct trace_array {
 	unsigned int		mapped;
 	unsigned long		range_addr_start;
 	unsigned long		range_addr_size;
+	char			*range_name;
 	long			text_delta;
 	int			nr_modules;
 	long			*module_delta;

