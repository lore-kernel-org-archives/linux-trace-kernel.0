Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23503101CD;
	Wed,  1 Apr 2026 06:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775025480; cv=none; b=d5gAIqXhtO73Qp0kHDaA2i0sDalu90C7Dep+6BPUG832WUzxPqwqSa3eg27Bth8a8X0v9eU5B2AwbwIofpDakdz9vvGl42Cy7BSD6HJUc9UNe7bbfBFAAZaBd399+x4OGVX5EdSX9ZL8970dpdP8hOj8a2kk2h3ZSrgtFUCWAfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775025480; c=relaxed/simple;
	bh=bC2MMlcy8YZcValF01rEAyTep2kdu6A3CYNIsc2K3pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XyxsQQagx7Td5OnD6DhRJ/SNZ9+dMfoMKbgf/Gd0rzCSnXGlgkFJ+suRFmGqaT2245Z0tF1VnH42yWqsxGVAzqI7eHzsu8aoVGgo0XBWXFHHbvnudC8zOi4LHzbFktKicXlkh4G8/UlwkeWGZzfm94GIJbeGynffJHmW8hoGWIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jcd5gFgh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jcd5gFgh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7719C4CEF7;
	Wed,  1 Apr 2026 06:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775025479;
	bh=bC2MMlcy8YZcValF01rEAyTep2kdu6A3CYNIsc2K3pE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jcd5gFgh6IR4WTTXrLP4LTVhHEna/HBUJiwi/k3V2TifgWxoGiPHd5k9V33hctgRG
	 jTCnKHj5nYA1kMU6P2hlg4swv979qz9b5dhm0vfKrq6ehvafikU2t/T9jG8fWiXMDz
	 Z4kwBfxlGvAKzp6VksIXp3ymWow3pHMbfbIFliq0PH0Ji/oJRBJDQBx7cWSrW2bFrd
	 ZlFLSa8FjVYCCclq+43hS3DFPr3vh8GwSt5XAGe3lg4Dgg4bsRlPHMAPtkytGe3V7D
	 qb+fdg0ihBZLu82nx0g6IPq3cveP46S0EdVVteqWytdaer6+SSsEXolWVokjGFk3R9
	 w2yVD9jqbU/Sg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v10 2/3] tracing: Remove the backup instance automatically after read
Date: Wed,  1 Apr 2026 15:37:57 +0900
Message-ID:  <177502547711.1311542.12572973358010839400.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
In-Reply-To:  <177502545902.1311542.15822886746171808738.stgit@mhiramat.tok.corp.google.com>
References:  <177502545902.1311542.15822886746171808738.stgit@mhiramat.tok.corp.google.com>
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

Since the backup instance is readonly, after reading all data
via pipe, no data is left on the instance. Thus it can be
removed safely after closing all files.
This also removes it if user resets the ring buffer manually
via 'trace' file.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v10:
  - Fix to use trace_array_destroy() to make it safer.
  - Use cancel_work_sync() to wait for cancel when removing.
  - Remove unneeded work_pending() check in trace_array_kick_autoremove()
    (for trace_array_cancel_autoremove() to avoid deadlock of workqueue
    it still use work_pending() check)
 Changes in v9:
   - Fix to initialize autoremove workqueue only for backup.
   - Fix to return -ENODEV if trace_array_get() refers freeing instance.
 Changes in v6:
   - Fix typo in comment.
   - Only when there is a readonly trace array, initialize autoremove_wq.
   - Fix to exit loop in trace_array_get() if tr is found in the list.
 Changes in v4:
   - Update description.
---
 kernel/trace/trace.c |   79 ++++++++++++++++++++++++++++++++++++++++++++++----
 kernel/trace/trace.h |    6 ++++
 2 files changed, 79 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index fdffa62a2b4e..3b3ec6645feb 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -539,8 +539,59 @@ void trace_set_ring_buffer_expanded(struct trace_array *tr)
 	tr->ring_buffer_expanded = true;
 }
 
+static void trace_array_autoremove(struct work_struct *work)
+{
+	struct trace_array *tr = container_of(work, struct trace_array, autoremove_work);
+
+	trace_array_destroy(tr);
+}
+
+static struct workqueue_struct *autoremove_wq;
+
+static void trace_array_kick_autoremove(struct trace_array *tr)
+{
+	if (autoremove_wq)
+		queue_work(autoremove_wq, &tr->autoremove_work);
+}
+
+static void trace_array_cancel_autoremove(struct trace_array *tr)
+{
+	/*
+	 * Since this can be called inside trace_array_autoremove(),
+	 * it has to avoid deadlock of the workqueue.
+	 */
+	if (work_pending(&tr->autoremove_work))
+		cancel_work_sync(&tr->autoremove_work);
+}
+
+static void trace_array_init_autoremove(struct trace_array *tr)
+{
+	INIT_WORK(&tr->autoremove_work, trace_array_autoremove);
+}
+
+static void trace_array_start_autoremove(void)
+{
+	if (autoremove_wq)
+		return;
+
+	autoremove_wq = alloc_workqueue("tr_autoremove_wq",
+					WQ_UNBOUND | WQ_HIGHPRI, 0);
+	if (!autoremove_wq)
+		pr_warn("Unable to allocate tr_autoremove_wq. autoremove disabled.\n");
+}
+
 LIST_HEAD(ftrace_trace_arrays);
 
+static int __trace_array_get(struct trace_array *this_tr)
+{
+	/* When free_on_close is set, this is not available anymore. */
+	if (autoremove_wq && this_tr->free_on_close)
+		return -ENODEV;
+
+	this_tr->ref++;
+	return 0;
+}
+
 int trace_array_get(struct trace_array *this_tr)
 {
 	struct trace_array *tr;
@@ -548,8 +599,7 @@ int trace_array_get(struct trace_array *this_tr)
 	guard(mutex)(&trace_types_lock);
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
 		if (tr == this_tr) {
-			tr->ref++;
-			return 0;
+			return __trace_array_get(tr);
 		}
 	}
 
@@ -560,6 +610,12 @@ static void __trace_array_put(struct trace_array *this_tr)
 {
 	WARN_ON(!this_tr->ref);
 	this_tr->ref--;
+	/*
+	 * When free_on_close is set, prepare removing the array
+	 * when the last reference is released.
+	 */
+	if (this_tr->ref == 1 && this_tr->free_on_close)
+		trace_array_kick_autoremove(this_tr);
 }
 
 /**
@@ -4829,6 +4885,10 @@ static void update_last_data(struct trace_array *tr)
 	/* Only if the buffer has previous boot data clear and update it. */
 	tr->flags &= ~TRACE_ARRAY_FL_LAST_BOOT;
 
+	/* If this is a backup instance, mark it for autoremove. */
+	if (tr->flags & TRACE_ARRAY_FL_VMALLOC)
+		tr->free_on_close = true;
+
 	/* Reset the module list and reload them */
 	if (tr->scratch) {
 		struct trace_scratch *tscratch = tr->scratch;
@@ -8442,8 +8502,8 @@ struct trace_array *trace_array_find_get(const char *instance)
 
 	guard(mutex)(&trace_types_lock);
 	tr = trace_array_find(instance);
-	if (tr)
-		tr->ref++;
+	if (tr && __trace_array_get(tr) < 0)
+		tr = NULL;
 
 	return tr;
 }
@@ -8540,6 +8600,8 @@ trace_array_create_systems(const char *name, const char *systems,
 	if (ftrace_allocate_ftrace_ops(tr) < 0)
 		goto out_free_tr;
 
+	trace_array_init_autoremove(tr);
+
 	ftrace_init_trace_array(tr);
 
 	init_trace_flags_index(tr);
@@ -8650,7 +8712,9 @@ struct trace_array *trace_array_get_by_name(const char *name, const char *system
 
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
 		if (tr->name && strcmp(tr->name, name) == 0) {
-			tr->ref++;
+			/* if this fails, @tr is going to be removed. */
+			if (__trace_array_get(tr) < 0)
+				tr = NULL;
 			return tr;
 		}
 	}
@@ -8689,6 +8753,7 @@ static int __remove_instance(struct trace_array *tr)
 			set_tracer_flag(tr, 1ULL << i, 0);
 	}
 
+	trace_array_cancel_autoremove(tr);
 	tracing_set_nop(tr);
 	clear_ftrace_function_probes(tr);
 	event_trace_del_tracer(tr);
@@ -9653,8 +9718,10 @@ __init static void enable_instances(void)
 		/*
 		 * Backup buffers can be freed but need vfree().
 		 */
-		if (backup)
+		if (backup) {
 			tr->flags |= TRACE_ARRAY_FL_VMALLOC | TRACE_ARRAY_FL_RDONLY;
+			trace_array_start_autoremove();
+		}
 
 		if (start || backup) {
 			tr->flags |= TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 2aa11178af59..a34f2d9479db 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -455,6 +455,12 @@ struct trace_array {
 	 * we do not waste memory on systems that are not using tracing.
 	 */
 	bool ring_buffer_expanded;
+	/*
+	 * If the ring buffer is a read only backup instance, it will be
+	 * removed after dumping all data via pipe, because no readable data.
+	 */
+	bool free_on_close;
+	struct work_struct	autoremove_work;
 };
 
 enum {

