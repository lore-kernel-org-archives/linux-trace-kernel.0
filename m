Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA8332E146;
	Wed,  7 Jan 2026 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797170; cv=none; b=fa0S3wkUqL8tikdFLq8AR5Uzjq49IY/SGIqQznv9qzxlm7SjWyznFOoVYcQoJKs+ZUtjIOyV4sJtMFFOT9bRkoyHvlzdOyl0PGEduoovoRq+int+B2A13Eeb84T5/4Q9Li62PIhGefZ/VPImyt6qfO73shGTROgWxAJiAoxGIYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797170; c=relaxed/simple;
	bh=/0PDR36dqC9wzWmvey0pigsToRSURj9qy0p8V5fwbNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tn105CpPjerAgk+Si+kVsd1Ya0qAVscxy8Zez2tq/9p7zi0/5Q05FK0QX4VR8t8rstIolStxLPxZQMxm7fKzL7ngyl5K9gcJ+/YZAnIHCKCyIUYsMtWSqbMMh4d+GCEj/BWLyrHqbdrNqGR/fUXJX3RytEMFFDrBpVAdt7QtLQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7eit0Xv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7eit0Xv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8818C4CEF1;
	Wed,  7 Jan 2026 14:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767797169;
	bh=/0PDR36dqC9wzWmvey0pigsToRSURj9qy0p8V5fwbNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K7eit0Xvz8Scor6fUi3/lZkvpZ5IHJDnpR6NnE4MEejVoRh14PdJZryCKfKp3ICdH
	 Ihy3OvzdTLuqifMdqO69mkqMdetEIKgsB0kzC1Y2Hjm2t8HR8/miY42fTqx7jT8uQQ
	 cfJmaI8chbQKiBE5AMqqlpOumAmmmGRfraOq+D51nspDTS8H1ik6NgSxF2nnVWwbkT
	 AbiGLLuv00S2/BaheOhDgyR8P3ROw7+iPehq3l+nzD1Vh1V82whg4dQwe5IULB4opQ
	 RlBvCECNDugzTiKGZCBM5VHi3Gk1paGVweC7/7Jj38SmxVH+1rwW3pURGhYH90fzHl
	 3VRiO6m7lad6w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/2] tracing: Add autoremove feature to the backup instance
Date: Wed,  7 Jan 2026 23:46:07 +0900
Message-ID:  <176779716708.4193242.18165634129732047971.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
In-Reply-To:  <176779714767.4193242.1978666866487010024.stgit@mhiramat.tok.corp.google.com>
References:  <176779714767.4193242.1978666866487010024.stgit@mhiramat.tok.corp.google.com>
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

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace.h |    6 +++++
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 725930f5980e..dfd4385603e6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -590,6 +590,55 @@ void trace_set_ring_buffer_expanded(struct trace_array *tr)
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
+	 * putting it. So we don't care the result.
+	 */
+	__remove_instance(tr);
+}
+
+static struct workqueue_struct *autoremove_wq;
+
+static void trace_array_init_autoremove(struct trace_array *tr)
+{
+	INIT_WORK(&tr->autoremove_work, trace_array_autoremove);
+}
+
+static void trace_array_kick_autoremove(struct trace_array *tr)
+{
+	if (!work_pending(&tr->autoremove_work) && autoremove_wq)
+		queue_work(autoremove_wq, &tr->autoremove_work);
+}
+
+static void trace_array_cancel_autoremove(struct trace_array *tr)
+{
+	if (work_pending(&tr->autoremove_work))
+		cancel_work(&tr->autoremove_work);
+}
+
+__init static int trace_array_init_autoremove_wq(void)
+{
+	autoremove_wq = alloc_workqueue("tr_autoremove_wq",
+					WQ_UNBOUND | WQ_HIGHPRI, 0);
+	if (!autoremove_wq) {
+		pr_err("Unable to allocate tr_autoremove_wq\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+late_initcall_sync(trace_array_init_autoremove_wq);
+
 LIST_HEAD(ftrace_trace_arrays);
 
 int trace_array_get(struct trace_array *this_tr)
@@ -598,7 +647,7 @@ int trace_array_get(struct trace_array *this_tr)
 
 	guard(mutex)(&trace_types_lock);
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
-		if (tr == this_tr) {
+		if (tr == this_tr && !tr->free_on_close) {
 			tr->ref++;
 			return 0;
 		}
@@ -611,6 +660,12 @@ static void __trace_array_put(struct trace_array *this_tr)
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
@@ -6212,6 +6267,10 @@ static void update_last_data(struct trace_array *tr)
 	/* Only if the buffer has previous boot data clear and update it. */
 	tr->flags &= ~TRACE_ARRAY_FL_LAST_BOOT;
 
+	/* If this is a backup instance, mark it for autoremove. */
+	if (tr->flags & TRACE_ARRAY_FL_VMALLOC)
+		tr->free_on_close = true;
+
 	/* Reset the module list and reload them */
 	if (tr->scratch) {
 		struct trace_scratch *tscratch = tr->scratch;
@@ -10392,6 +10451,8 @@ trace_array_create_systems(const char *name, const char *systems,
 	if (ftrace_allocate_ftrace_ops(tr) < 0)
 		goto out_free_tr;
 
+	trace_array_init_autoremove(tr);
+
 	ftrace_init_trace_array(tr);
 
 	init_trace_flags_index(tr);
@@ -10540,6 +10601,7 @@ static int __remove_instance(struct trace_array *tr)
 	if (update_marker_trace(tr, 0))
 		synchronize_rcu();
 
+	trace_array_cancel_autoremove(tr);
 	tracing_set_nop(tr);
 	clear_ftrace_function_probes(tr);
 	event_trace_del_tracer(tr);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index bc0eeb2d1d07..a8088a106d67 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -446,6 +446,12 @@ struct trace_array {
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

