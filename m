Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD61269AF4;
	Tue, 18 Feb 2025 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739891352; cv=none; b=G8/6V+Ok9749Zi+3AWuq37WUkWM0Xex0Ybu9eFYtaICWRj6Jc8H3TbvaUaK2WnyXba+0fIDv9dItbTyANiuW3YP5SL4CC3sF5U7VzT0HHxu97afGTWzIfxhEngVt/AZi0XmMCNHXmCF9EFnSq8PooHjp/Ba/jynnuMW+Jpk9yNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739891352; c=relaxed/simple;
	bh=+d+1VZIgN3LNMc7YVtQVmKawA11NnKwFm+u6wA92Fcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=krYQfI3RxywLpkTOckdRPxZAnGGn3+lHY1HO1AQ/Tj4tB+K5/BVVWw/FYQDdk7LlZsJiwnP1SZpme9DOjl5jhsmCFUWmjDHtRkWOxbcuXg9IiklwvcJl27DTnzBinYVLwqhbfwlHYfTBXynHsoK0kA87jnmv+RommVQbgNb5wm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1fkO0T9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1fkO0T9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4C2C4CEE2;
	Tue, 18 Feb 2025 15:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739891352;
	bh=+d+1VZIgN3LNMc7YVtQVmKawA11NnKwFm+u6wA92Fcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C1fkO0T9sHWR/MXhOO4ABi24T1h8CKC/FU+oygEimshbWqP6c5f0Hx1DjsV817Ib3
	 JCIsIsVKaqVANO7Cn1YcwebdbheZTOnwnc6O+cksvDiIDNYCexR08eiU5+xfDcCu+R
	 eT+AesrWA8SvbkPEdS6jlvQ9PiHCBjy4+B4HsoZH3fUo+Zru4uxz6gO982wRu1ke6i
	 djAv8prKsnouKLIZm8YmJvIgq1rrL5JWfJ07ryo48I6IZMbNJzvlQeR9NxGEkQTayh
	 cVtQfT9PRJuYN4Eg1zZUOhJhjzVtXx+gei1kdpRUBz315UnOxVj+ta/IROKZMtXWqP
	 m4M49YhyS0+TA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	linux-mm@kvack.org
Subject: [PATCH v4 2/2] tracing: Freeable reserved ring buffer
Date: Wed, 19 Feb 2025 00:09:08 +0900
Message-ID: <173989134814.230693.18199312930337815629.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173989132750.230693.15749600013776132201.stgit@devnote2>
References: <173989132750.230693.15749600013776132201.stgit@devnote2>
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

~ # free
              total        used        free      shared  buff/cache   available
Mem:        1995548       50544     1927568       14964       17436     1911480
Swap:             0           0           0
~ # rmdir /sys/kernel/tracing/instances/boot_mapped/
[   23.704023] Freeing reserve_mem:trace memory: 20476K
~ # free
              total        used        free      shared  buff/cache   available
Mem:        2016024       41844     1956740       14968       17440     1940572
Swap:             0           0           0

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v4:
  - Update the result example in the description.
 Changes in v3:
  - Remove debug printk.
---
 kernel/trace/trace.c |   13 ++++++++++++-
 kernel/trace/trace.h |    1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0e6d517e74e0..cf57c7ac2c55 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9284,6 +9284,9 @@ static void free_trace_buffers(struct trace_array *tr)
 #ifdef CONFIG_TRACER_MAX_TRACE
 	free_trace_buffer(&tr->max_buffer);
 #endif
+
+	if (tr->range_addr_start)
+		vunmap((void *)tr->range_addr_start);
 }
 
 static void init_trace_flags_index(struct trace_array *tr)
@@ -9445,6 +9448,7 @@ trace_array_create_systems(const char *name, const char *systems,
 	free_cpumask_var(tr->pipe_cpumask);
 	free_cpumask_var(tr->tracing_cpumask);
 	kfree_const(tr->system_names);
+	kfree(tr->range_name);
 	kfree(tr->name);
 	kfree(tr);
 
@@ -9571,6 +9575,11 @@ static int __remove_instance(struct trace_array *tr)
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
@@ -10368,6 +10377,7 @@ __init static void enable_instances(void)
 		bool traceoff = false;
 		char *flag_delim;
 		char *addr_delim;
+		char *rname __free(kfree) = NULL;
 
 		tok = strsep(&curr_str, ",");
 
@@ -10424,6 +10434,7 @@ __init static void enable_instances(void)
 				pr_warn("Failed to map boot instance %s to %s\n", name, tok);
 				continue;
 			}
+			rname = kstrdup(tok, GFP_KERNEL);
 		}
 
 		if (start) {
@@ -10460,7 +10471,7 @@ __init static void enable_instances(void)
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
 

