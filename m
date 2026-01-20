Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2347B3BB57;
	Tue, 20 Jan 2026 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768871388; cv=none; b=sm4ZoWxUy8/avA19fHE2BL87ghwIiOrgGv63wcWi2q6nLZGN6TjG9iydfDm9A/S2fdj9QQjiWm3wNeLTOoBFJ7EOdnFla1R9AuPO+T9tkpiF96HLiVwVR3DO/UwvhLfa8aKfW8fYyTVPQd/TmHdVyJ2zijn3BwcJ/axIhkM5Xm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768871388; c=relaxed/simple;
	bh=EvEKBerZnuyaXVWqI2juRsdFyqQcXzo2yf2xobNO7zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R84ojdiOtZe6MXYLQrLNOkCGqS6DCjEfY9mEN3OSXUifvV1MFoHUUrdqCbKLfq6SPTh1UGWGVJmvqE5xThzd0LMM6LJY5q91Q6cpkbvdMmwPZaPL6N3cXFDjSsxz5S+Da4DjUbozBH1H+VCG8ikqi/KkOux99iZrdHp6AMLwKCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJxMZqWu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJxMZqWu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D96C116C6;
	Tue, 20 Jan 2026 01:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768871385;
	bh=EvEKBerZnuyaXVWqI2juRsdFyqQcXzo2yf2xobNO7zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJxMZqWuz4dthBJPVaUx236z+zAVVggtnlzt4zWvt878GGrNT4hHdzF4Lg1vsJ6FW
	 Rr/yrTbQYBigw3QGThE3Fd6NrB43/Jffe3MxdCVcfrHc1b2HFplvzgmPXRmO/sR0Og
	 1FnUtCB/KZW7v5tA+m6SJfrBdm6yB4O7dmfzNfrUFn2cGzJNIle1x0Bw6QjK8mE4bz
	 5YaIgNPuL3oFNFONLZvMTMKfIqlVsbhvBwERWH3DAd8MSsJViwnxqRyG7qW9WFwAAF
	 0etBdyKp7b4G0UBmuenK8qp1tF597z3ij63Fg0JAve34z+KCeXHYNpGVEWw/5WHS0B
	 yiv4X+/aiD++Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] tracing: Remove the backup instance automatically after read
Date: Tue, 20 Jan 2026 10:09:43 +0900
Message-ID:  <176887138332.578403.342690450188917584.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To:  <176887135615.578403.6988045330349053692.stgit@mhiramat.tok.corp.google.com>
References:  <176887135615.578403.6988045330349053692.stgit@mhiramat.tok.corp.google.com>
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
index b27e1cdeffb0..7fa0809cd71b 100644
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
@@ -6219,6 +6274,10 @@ static void update_last_data(struct trace_array *tr)
 	/* Only if the buffer has previous boot data clear and update it. */
 	tr->flags &= ~TRACE_ARRAY_FL_LAST_BOOT;
 
+	/* If this is a backup instance, mark it for autoremove. */
+	if (tr->flags & TRACE_ARRAY_FL_VMALLOC)
+		tr->free_on_close = true;
+
 	/* Reset the module list and reload them */
 	if (tr->scratch) {
 		struct trace_scratch *tscratch = tr->scratch;
@@ -10390,6 +10449,8 @@ trace_array_create_systems(const char *name, const char *systems,
 	if (ftrace_allocate_ftrace_ops(tr) < 0)
 		goto out_free_tr;
 
+	trace_array_init_autoremove(tr);
+
 	ftrace_init_trace_array(tr);
 
 	init_trace_flags_index(tr);
@@ -10538,6 +10599,7 @@ static int __remove_instance(struct trace_array *tr)
 	if (update_marker_trace(tr, 0))
 		synchronize_rcu();
 
+	trace_array_cancel_autoremove(tr);
 	tracing_set_nop(tr);
 	clear_ftrace_function_probes(tr);
 	event_trace_del_tracer(tr);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index a098011951cc..947f641a9cf0 100644
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

