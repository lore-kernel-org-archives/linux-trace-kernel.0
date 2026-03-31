Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CAD402BA9;
	Tue, 31 Mar 2026 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974756; cv=none; b=QpVjoqHWDy9Zqmc0TS4dv/S3v3+R6RQ7sSMvHMXCv5EenHZcNFaeZk+BEJ6JjfjV16iBCouEpGZ/3UaO8QfKyatgyUTQ/YPNSoMoJ6c5c6c/ttat+1Sblb37TdV80z6DxHVQt3fEA/604ZRtXMEBAGEfT5uBc9M9iKzdwrngTho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974756; c=relaxed/simple;
	bh=UOAO6XujdJV+n7CK9mVVCRv84ROTAg0qJONCnoaInzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRkpGPneFV/mlT2r+plrXrzqd+Addd7aiVGXF868P/j+Wkb89BJwp7ba6EsMM1ZMESFXm67au6VXRJ+TnUDkXbBvdPNRusgPZY6cOFMpDz3/JDi1hbhGkneryI1kLOxQukJg6BGD4wAArd4N3Pxt/N25QIssq2ByUnMTTPtvh8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5cVWW97; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5cVWW97"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEE0C2BCB1;
	Tue, 31 Mar 2026 16:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774974755;
	bh=UOAO6XujdJV+n7CK9mVVCRv84ROTAg0qJONCnoaInzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F5cVWW97BZGqEv9QFU1e9wQHgjrO5bOztHdpqaRfuD/4UldnR8A8/wWraee43SowJ
	 KLY27CjGDqKEKKAGE0EYIULszSTbYS760jOLnSrXtnoXFnGdItmQRO0DHeSKA5f01Y
	 uj1q6cIlzgSFVeK3BDPWqMva4XkdzYacrJkcs50Qu/l/SJEToq/VN1jQHj08fLJTFx
	 9svzSOQVn1GUFqHkRDJmdjlqKb/2kPAhcuQV80YYnYIGg+0oHUYWG/0EKNpFraKNd3
	 Plh4muceKEIEtPPwvPuMsKGvn0PZfTZ5bscKi5U7f7zBstfbxmH7/oSEuG0xtTJ/Ro
	 7bwJWdjdYBtAw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v9 2/3] tracing: Remove the backup instance automatically after read
Date: Wed,  1 Apr 2026 01:32:33 +0900
Message-ID:  <177497475349.569199.11513916633426967730.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
In-Reply-To:  <177497473558.569199.6527680985537865638.stgit@mhiramat.tok.corp.google.com>
References:  <177497473558.569199.6527680985537865638.stgit@mhiramat.tok.corp.google.com>
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
 kernel/trace/trace.c |   85 ++++++++++++++++++++++++++++++++++++++++++++++----
 kernel/trace/trace.h |    6 ++++
 2 files changed, 85 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8cec7bd70438..1d73400a01c7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -539,8 +539,65 @@ void trace_set_ring_buffer_expanded(struct trace_array *tr)
 	tr->ring_buffer_expanded = true;
 }
 
+static int __remove_instance(struct trace_array *tr);
+
+static void trace_array_autoremove(struct work_struct *work)
+{
+	struct trace_array *tr = container_of(work, struct trace_array, autoremove_work);
+
+	guard(mutex)(&event_mutex);
+	guard(mutex)(&trace_types_lock);
+
+	/*
+	 * This can be fail if someone gets @tr before starting this
+	 * function, but in that case, this will be kicked again when
+	 * putting it. So we don't care about the result.
+	 */
+	__remove_instance(tr);
+}
+
+static struct workqueue_struct *autoremove_wq;
+
+static void trace_array_kick_autoremove(struct trace_array *tr)
+{
+	if (autoremove_wq && !work_pending(&tr->autoremove_work))
+		queue_work(autoremove_wq, &tr->autoremove_work);
+}
+
+static void trace_array_cancel_autoremove(struct trace_array *tr)
+{
+	if (autoremove_wq && work_pending(&tr->autoremove_work))
+		cancel_work(&tr->autoremove_work);
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
@@ -548,8 +605,7 @@ int trace_array_get(struct trace_array *this_tr)
 	guard(mutex)(&trace_types_lock);
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
 		if (tr == this_tr) {
-			tr->ref++;
-			return 0;
+			return __trace_array_get(tr);
 		}
 	}
 
@@ -560,6 +616,12 @@ static void __trace_array_put(struct trace_array *this_tr)
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
@@ -4829,6 +4891,10 @@ static void update_last_data(struct trace_array *tr)
 	/* Only if the buffer has previous boot data clear and update it. */
 	tr->flags &= ~TRACE_ARRAY_FL_LAST_BOOT;
 
+	/* If this is a backup instance, mark it for autoremove. */
+	if (tr->flags & TRACE_ARRAY_FL_VMALLOC)
+		tr->free_on_close = true;
+
 	/* Reset the module list and reload them */
 	if (tr->scratch) {
 		struct trace_scratch *tscratch = tr->scratch;
@@ -8442,8 +8508,8 @@ struct trace_array *trace_array_find_get(const char *instance)
 
 	guard(mutex)(&trace_types_lock);
 	tr = trace_array_find(instance);
-	if (tr)
-		tr->ref++;
+	if (tr && __trace_array_get(tr) < 0)
+		tr = NULL;
 
 	return tr;
 }
@@ -8540,6 +8606,8 @@ trace_array_create_systems(const char *name, const char *systems,
 	if (ftrace_allocate_ftrace_ops(tr) < 0)
 		goto out_free_tr;
 
+	trace_array_init_autoremove(tr);
+
 	ftrace_init_trace_array(tr);
 
 	init_trace_flags_index(tr);
@@ -8650,7 +8718,9 @@ struct trace_array *trace_array_get_by_name(const char *name, const char *system
 
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
 		if (tr->name && strcmp(tr->name, name) == 0) {
-			tr->ref++;
+			/* if this fails, @tr is going to be removed. */
+			if (__trace_array_get(tr) < 0)
+				tr = NULL;
 			return tr;
 		}
 	}
@@ -8689,6 +8759,7 @@ static int __remove_instance(struct trace_array *tr)
 			set_tracer_flag(tr, 1ULL << i, 0);
 	}
 
+	trace_array_cancel_autoremove(tr);
 	tracing_set_nop(tr);
 	clear_ftrace_function_probes(tr);
 	event_trace_del_tracer(tr);
@@ -9653,8 +9724,10 @@ __init static void enable_instances(void)
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
index 2d9d26d423f1..60e079177492 100644
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

