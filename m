Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03004274B59;
	Sun,  1 Feb 2026 03:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769916565; cv=none; b=tShcPh++VYlfeugBZo3oCnJYMHkyTOoyrN2jUnUisVQrTa83G2wt4iBUSz09RwI8e11fIu1eTplZryr2AtfJI9g0qDUhx3nRgE7s0fa5U1u3glQ3doomg12BjMvxKdfFPmYzheWVH8FAvEf0qEet/9i9BJxyECi4cbnvNlWv1Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769916565; c=relaxed/simple;
	bh=X2qTMbcPWgZf3o9AI+NacQE8n5NUtJv9GQJPPo/EM+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Maj7KSrQGXyWc5in1WupAbIcHo0wVRcR0yBCx3QQ47ovcll8gkHgl65vju3wYlrLmF6W0ZQei1uZD5p5T56Nb4riWkppreI+tqIIPVwOrJb/r4eCTSxR8JJVM4DmXNLviypPIYnr0+NKpIH/8L2viODuFAiQYv/HuZOcdHZcUAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2RGyOeF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2RGyOeF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FCFC4CEF7;
	Sun,  1 Feb 2026 03:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769916564;
	bh=X2qTMbcPWgZf3o9AI+NacQE8n5NUtJv9GQJPPo/EM+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t2RGyOeF3TDVaGsY924oPHfHb0OizKRutecHXWztOdw0yY1RWXEOSQ6roFzgPxsrz
	 Ws2b2b6BZQGSbJhf7aIvSGE1yDBBkajngcYvCGzdNvXvCYz2inmn2ZngKpcoyFt5mr
	 uv+Oe/0pcUL9t5thsFZXTVyhydGzcojJ2XVe6iE17/Fyw2SiyRuY6zNRiHkyffgcwP
	 LolSc3CquJqMNcSkFGzgA05kdowpPpVYVkCz6qff5dyTJcNWkhpBCTt9pgejWIRDwg
	 KCTI6aFfUWf6u9C2g7h9WhYKYzYNYKk++HkfvnzGOonnFORjt9edP0nxrkrz5pBi3F
	 /s3F+pNjdch7A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v6 3/4] tracing: Remove the backup instance automatically after read
Date: Sun,  1 Feb 2026 12:29:22 +0900
Message-ID:  <176991656245.4025429.16456388648872177605.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
In-Reply-To:  <176991653525.4025429.12655335935351822711.stgit@mhiramat.tok.corp.google.com>
References:  <176991653525.4025429.12655335935351822711.stgit@mhiramat.tok.corp.google.com>
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
index b0efcf1e0809..9d09befd5da5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -590,6 +590,51 @@ void trace_set_ring_buffer_expanded(struct trace_array *tr)
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
@@ -599,7 +644,8 @@ int trace_array_get(struct trace_array *this_tr)
 	guard(mutex)(&trace_types_lock);
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
 		if (tr == this_tr) {
-			tr->ref++;
+			if (!tr->free_on_close)
+				tr->ref++;
 			return 0;
 		}
 	}
@@ -611,6 +657,12 @@ static void __trace_array_put(struct trace_array *this_tr)
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
@@ -6237,6 +6289,10 @@ static void update_last_data(struct trace_array *tr)
 	/* Only if the buffer has previous boot data clear and update it. */
 	tr->flags &= ~TRACE_ARRAY_FL_LAST_BOOT;
 
+	/* If this is a backup instance, mark it for autoremove. */
+	if (tr->flags & TRACE_ARRAY_FL_VMALLOC)
+		tr->free_on_close = true;
+
 	/* Reset the module list and reload them */
 	if (tr->scratch) {
 		struct trace_scratch *tscratch = tr->scratch;
@@ -10415,6 +10471,8 @@ trace_array_create_systems(const char *name, const char *systems,
 	if (ftrace_allocate_ftrace_ops(tr) < 0)
 		goto out_free_tr;
 
+	trace_array_init_autoremove(tr);
+
 	ftrace_init_trace_array(tr);
 
 	init_trace_flags_index(tr);
@@ -10563,6 +10621,7 @@ static int __remove_instance(struct trace_array *tr)
 	if (update_marker_trace(tr, 0))
 		synchronize_rcu();
 
+	trace_array_cancel_autoremove(tr);
 	tracing_set_nop(tr);
 	clear_ftrace_function_probes(tr);
 	event_trace_del_tracer(tr);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 4ff7ebd8a32b..4c5ef9d8f8ad 100644
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

