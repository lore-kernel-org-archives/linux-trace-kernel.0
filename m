Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E058C2A1CF;
	Wed, 28 Jan 2026 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769559007; cv=none; b=gzONkfnuiQN/riU79BYNsQpKgvr19d+DOBS1czcj2T4q6F8IzOWxvAVyPoYYqdo9arOSDiPYmiFk+n6vTY9k9pRJcBlZvG2vNBFTEaluLRQr5NIhb0VVoIMGuXiQOu+QzHZqo9w6SjTFHYbF+N2okY8KICxbJxChiiAjqTR3bnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769559007; c=relaxed/simple;
	bh=iPwQ2a5g9OEaU5Rr9tijgRDDChhJH0iR0vO9BuhN2/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JsHj6ROzCjKznJRyaqsKBwudnZs1XrOg3xRqaSKRTHO0lAWjIRxNYHgNBjFTBvk+jCrrXy+nwnHxlwr3IvnIFogVJloytU3T7ciHMtTGQUY3QQuVf9S5DbgjpjVQwNfMdaclFwASp6QbOjCSUzfqiCEKogEjYnNXRFl/2KmsWNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUxg7xv9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUxg7xv9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB683C116C6;
	Wed, 28 Jan 2026 00:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769559006;
	bh=iPwQ2a5g9OEaU5Rr9tijgRDDChhJH0iR0vO9BuhN2/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oUxg7xv9qYHaMay73MCEv0d96biOaJbqBkT3p067EqrljmrHrzbkaJqPlYSwhp/V3
	 U8ClmjbzcT6auCM2AO7/mWfm42obe9lSPsBcPswsusQ6pibRMA47nZX1AaEmzv5TIX
	 /vxEnkoabfFKBKgflkU8Wm9Tvbn9kR7ieXj3J/Q2uKwKFthsfAg5W6oS+YfWK5qGWm
	 JSkr7T9ALUutkMJoTgD5ZVU0xCh+Lgnc1pewwxt+ecvnM7OYCqZhtkfCjMRYNwRgYf
	 XgWFL5EUHfcBSxaaZAbRenAah5JGB5/1Qk/o5d5Vt9dIlK+f1KFYskcVTPnlx0xAHi
	 lu0zlZdRll1Qw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] tracing: Remove the backup instance automatically after read
Date: Wed, 28 Jan 2026 09:10:04 +0900
Message-ID:  <176955900407.2786091.16663650848612163366.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To:  <176955897718.2786091.11948759407196200082.stgit@mhiramat.tok.corp.google.com>
References:  <176955897718.2786091.11948759407196200082.stgit@mhiramat.tok.corp.google.com>
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
 Changes in v4:
   - Update description.
---
 kernel/trace/trace.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace.h |    6 +++++
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d39f6509c12a..7d615a74f915 100644
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
@@ -6237,6 +6292,10 @@ static void update_last_data(struct trace_array *tr)
 	/* Only if the buffer has previous boot data clear and update it. */
 	tr->flags &= ~TRACE_ARRAY_FL_LAST_BOOT;
 
+	/* If this is a backup instance, mark it for autoremove. */
+	if (tr->flags & TRACE_ARRAY_FL_VMALLOC)
+		tr->free_on_close = true;
+
 	/* Reset the module list and reload them */
 	if (tr->scratch) {
 		struct trace_scratch *tscratch = tr->scratch;
@@ -10418,6 +10477,8 @@ trace_array_create_systems(const char *name, const char *systems,
 	if (ftrace_allocate_ftrace_ops(tr) < 0)
 		goto out_free_tr;
 
+	trace_array_init_autoremove(tr);
+
 	ftrace_init_trace_array(tr);
 
 	init_trace_flags_index(tr);
@@ -10566,6 +10627,7 @@ static int __remove_instance(struct trace_array *tr)
 	if (update_marker_trace(tr, 0))
 		synchronize_rcu();
 
+	trace_array_cancel_autoremove(tr);
 	tracing_set_nop(tr);
 	clear_ftrace_function_probes(tr);
 	event_trace_del_tracer(tr);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 0adc644084bf..d9d45dd3c0f3 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -447,6 +447,12 @@ struct trace_array {
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

