Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE6733D6D4;
	Tue, 10 Feb 2026 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770713049; cv=none; b=l4BamhJBv3ub0r8bI1sDZqQKbxz8fmM5T4OfjoqOKGGDmBRlVJquEgjHV8kdYdHU6/n+yQXHP4Y3KqHrK9Z9/msBpvahsOwqltBW8KFF+NpUMPdph46VHdXXIwqMf3qDnHIi4WcGUZMKmh6XW97DMWHJ6T74x7qSXmlhNKo6WKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770713049; c=relaxed/simple;
	bh=dmL/SN0o8o4iYGF7T+Lwxd9F8Mqog2atTJFmtAWWWvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qe+lf4Fs9HbTBMfPvrIx/YLvAhD6aBvcLtMXGCoTuht7kwO62yxldX81Mh803C9U1k7RH83OcPt2AS/lMU9E7SCt5UXW/YLRMbUKh8bETWXFrfo+DR2hM9ZgIz6KJUSz2onaTwbsCYBKpW8TOksiZ4VvB9dZ438eVgs/MUPZ9aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kr2y4gCQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kr2y4gCQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4CAC116C6;
	Tue, 10 Feb 2026 08:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770713049;
	bh=dmL/SN0o8o4iYGF7T+Lwxd9F8Mqog2atTJFmtAWWWvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kr2y4gCQ1WoY0WvLXRrC3TF/e8eB5WExn28xy2HEQ8HLkKchWbD96xscINazv5K72
	 vmUlBoD28upSrMkT3hvezwOsf9SjzEuujjUrORjOzD3vW5GcnrZ53hVzAi8ZrxNLdX
	 46H+R0+eVlvMEu8PJlJ/gz+MvymOr2dOAvpZLqUqRhKXfybPysmwuhQweE8HuO+zCN
	 IbuUQ3RmJcpWYpRm4A39JIvpzPieOlDzo3+EHIbAn6uDMysQJswFMXU2+phT1XSMk4
	 l3j62KOEaD417toeM4jAw72KhBnDTI5vr2r07gj4lfCnWOHnbEo5T7akIaa/X3YWgu
	 wA7CetjIhPavQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v8 5/6] tracing: Remove the backup instance automatically after read
Date: Tue, 10 Feb 2026 17:44:06 +0900
Message-ID:  <177071304674.2293046.14437823490848309611.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
In-Reply-To:  <177071300558.2293046.12057922262682243630.stgit@mhiramat.tok.corp.google.com>
References:  <177071300558.2293046.12057922262682243630.stgit@mhiramat.tok.corp.google.com>
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
index 566d1e824360..c746cb4c6e38 100644
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
@@ -5463,6 +5515,10 @@ static void update_last_data(struct trace_array *tr)
 	/* Only if the buffer has previous boot data clear and update it. */
 	tr->flags &= ~TRACE_ARRAY_FL_LAST_BOOT;
 
+	/* If this is a backup instance, mark it for autoremove. */
+	if (tr->flags & TRACE_ARRAY_FL_VMALLOC)
+		tr->free_on_close = true;
+
 	/* Reset the module list and reload them */
 	if (tr->scratch) {
 		struct trace_scratch *tscratch = tr->scratch;
@@ -9596,6 +9652,8 @@ trace_array_create_systems(const char *name, const char *systems,
 	if (ftrace_allocate_ftrace_ops(tr) < 0)
 		goto out_free_tr;
 
+	trace_array_init_autoremove(tr);
+
 	ftrace_init_trace_array(tr);
 
 	init_trace_flags_index(tr);
@@ -9744,6 +9802,7 @@ static int __remove_instance(struct trace_array *tr)
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

