Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8011363C5F;
	Mon,  9 Feb 2026 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629150; cv=none; b=fYP3pDSSpkPBXRxPkhy/mnp8eteFKk9loCeE7uffqP/Je0/mXev/JrcM8K/3wf8MGBQhlX+X+mCuOeGi0RFx5+29yhlswOfx1p1gI660r4+vn/38gsJSHwGHMTLl5RsCoTDhFaGKmwxRLCt1jNvpmciuXQx9RMpk442goQNht+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629150; c=relaxed/simple;
	bh=pCzvfWrzlFOPbKK45aEVCRm4pai9yuFSyLdYWLspulw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FSxd45yDRMPB3GVNMJfdtkCj7d1Ez6TRm9pG53/yTYovxNVSt9WeSMurLnTkRbZDmL9vfLZECupR1O/XYliTfRj9pOyNi6JA2OuXf7aDrZnVNsDVumGJ0LzHdUDN7SZoT5+qewGRyHfE4YBZf8+TWyLZ2l8KU1hV5mMz8yS/Vqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwrmJNcG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwrmJNcG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7625C19424;
	Mon,  9 Feb 2026 09:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770629149;
	bh=pCzvfWrzlFOPbKK45aEVCRm4pai9yuFSyLdYWLspulw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uwrmJNcGf2bhFS+ohLSnkap8LtsPcUcJ6fVyLV4d0tJWfAyfjEmPUjQVTz7sRV352
	 ZvdCpOTyMVavT5wcMhhXCMtzUGvd4/ad1Q+EEsdA1iQrRC7Lm5XffuHV8Gw31NHEXz
	 8xXwSPTfeVtfoYQqgeUWbiYF1TenUhOpXGXp8ARtlJ+ImeikeXvSk9PvmaV9XK9oQu
	 G6tTS4CJbiMPpnjRXbomKAx8b9Lyr64x+mdI6Jtmwbbj54Pk2Y+dII281lH24dAE0P
	 l+NhrFvJfZhinseO3UYIDJesmBT55d0Z0U+iheqvWijrNvaeCIrE5UVetuPzhAyykC
	 YKvWZ+b9wB+8A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 3/4] tracing: Remove the backup instance automatically after read
Date: Mon,  9 Feb 2026 18:25:47 +0900
Message-ID:  <177062914725.1230888.771199849824532374.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
In-Reply-To:  <177062912135.1230888.17419570791737357433.stgit@mhiramat.tok.corp.google.com>
References:  <177062912135.1230888.17419570791737357433.stgit@mhiramat.tok.corp.google.com>
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
 Changes in v6:
   - Fix typo in comment.
   - Only when there is a readonly trace array, initialize autoremove_wq.
   - Fix to exit loop in trace_array_get() if tr is found in the list.
 Changes in v4:
   - Update description.
---
 kernel/trace/trace.c |   61 +++++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace.h |    6 +++++
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index eee1f283c5f4..3dd9896612d5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -578,6 +578,51 @@ void trace_set_ring_buffer_expanded(struct trace_array *tr)
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
+
+	/* Only readonly trace_array can kick the autoremove. */
+	if (!trace_array_is_readonly(tr) || autoremove_wq)
+		return;
+
+	autoremove_wq = alloc_workqueue("tr_autoremove_wq",
+					WQ_UNBOUND | WQ_HIGHPRI, 0);
+	if (!autoremove_wq)
+		pr_warn("Unable to allocate tr_autoremove_wq. autoremove disabled.\n");
+}
+
 LIST_HEAD(ftrace_trace_arrays);
 
 int trace_array_get(struct trace_array *this_tr)
@@ -587,7 +632,8 @@ int trace_array_get(struct trace_array *this_tr)
 	guard(mutex)(&trace_types_lock);
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
 		if (tr == this_tr) {
-			tr->ref++;
+			if (!tr->free_on_close)
+				tr->ref++;
 			return 0;
 		}
 	}
@@ -599,6 +645,12 @@ static void __trace_array_put(struct trace_array *this_tr)
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
@@ -5471,6 +5523,10 @@ static void update_last_data(struct trace_array *tr)
 	/* Only if the buffer has previous boot data clear and update it. */
 	tr->flags &= ~TRACE_ARRAY_FL_LAST_BOOT;
 
+	/* If this is a backup instance, mark it for autoremove. */
+	if (tr->flags & TRACE_ARRAY_FL_VMALLOC)
+		tr->free_on_close = true;
+
 	/* Reset the module list and reload them */
 	if (tr->scratch) {
 		struct trace_scratch *tscratch = tr->scratch;
@@ -9619,6 +9675,8 @@ trace_array_create_systems(const char *name, const char *systems,
 	if (ftrace_allocate_ftrace_ops(tr) < 0)
 		goto out_free_tr;
 
+	trace_array_init_autoremove(tr);
+
 	ftrace_init_trace_array(tr);
 
 	init_trace_flags_index(tr);
@@ -9767,6 +9825,7 @@ static int __remove_instance(struct trace_array *tr)
 	if (update_marker_trace(tr, 0))
 		synchronize_rcu();
 
+	trace_array_cancel_autoremove(tr);
 	tracing_set_nop(tr);
 	clear_ftrace_function_probes(tr);
 	event_trace_del_tracer(tr);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 393be92768f1..48b94759ba1c 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -450,6 +450,12 @@ struct trace_array {
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

