Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFCB318EF3;
	Wed, 18 Feb 2026 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409686; cv=none; b=e+QqP/IAw4Iv0m2KjISeGBB98Js2NPkiFNB9SGjJgX+cGB1AV1hyMVlklTBT1igqZ6FhV0cVWE3YsvWKWIpVLIdkdxl/FoefYXcWXwNIoWQrj8KjwHGnNBJ15jira80gjZtEA1LCgBQsrV3EcSqYDFWSbRyeEofeKhH15dTJYRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409686; c=relaxed/simple;
	bh=zEPxgTozeXwayd3dN/+UCEPOsTsIXSSTPsBPi1Uh0R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfw+9b7ilxwcJdj30DlMJLH6ZCo07WQOgQfWCGvy8M7rgR3qeiBQcFQO+yutGhd33cZ93CKN9Y9XaRs39mZ0mVHa/s/sVHUHee5E1M1ha6VsZkID464+KNQa0BpbkiUl5NHEGkuPvAg6psgUIJVLbuzcncz4HdIRfueOoX2mM7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noK4Q9BP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noK4Q9BP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157D6C19421;
	Wed, 18 Feb 2026 10:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409685;
	bh=zEPxgTozeXwayd3dN/+UCEPOsTsIXSSTPsBPi1Uh0R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=noK4Q9BPNaMRoNjE7sAvQ5BRvbF7j0k7xhzphPwEbVMLP9j3l/qN0nb/xb6cXfx4A
	 Ehw4oCc26O3WTyXRRbo1lliaMg5adIZNpXOX/yi8DgWETqyhb1GkkDrUMu37KXYhhF
	 dobYyL6BZH2WYsZ9SOap4PZgDNOGJ0mXuAhBHxLYCTUA6hyqYvdno2rfDcaVNMC56D
	 U3jVRwkRZuzO7ACL0AM+Nd1pPfo1XXcyW9bvThdJ8iucmMv3XHYhf97I53e+hmFSi+
	 2+yqIXWZhLQv6FrOQDskiamRnvAFN2RvXeJNftCU0jzX07pQTHx8QAjF0sYCVYnyr0
	 JXqS5TLngffxA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] ring-buffer: Record invalid buffer event
Date: Wed, 18 Feb 2026 19:14:43 +0900
Message-ID:  <177140968338.1537493.3298484599734677165.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
In-Reply-To:  <177140965047.1537493.15501794841217306382.stgit@mhiramat.tok.corp.google.com>
References:  <177140965047.1537493.15501794841217306382.stgit@mhiramat.tok.corp.google.com>
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

Record an invalid buffer event on the invalidated sub buffer
so that user can notice how much data is skipped.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/ring_buffer.c   |   43 ++++++++++++++++++++++++++++++++++++------
 kernel/trace/trace.h         |    1 +
 kernel/trace/trace_entries.h |   15 +++++++++++++++
 3 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 0ae2a5ad8c3e..98df5a67de26 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1911,6 +1911,38 @@ static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu)
 	return rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
 }
 
+/* Inject invalid_buffer event */
+static void rb_record_invalid_buffer(struct buffer_page *buffer,
+				     long commit_bytes, long entries,
+				     int buffer_index)
+{
+	struct buffer_data_page *dpage = buffer->page;
+	struct invalid_subbuf_entry *entry;
+	struct ring_buffer_event *event;
+	long length;
+
+	length = DIV_ROUND_UP(sizeof(*entry), RB_ALIGNMENT);
+
+	/*
+	 * Instead of ring_buffer_lock_reserve(), directly allocate it on
+	 * the first entry of specific buffer_page.
+	 */
+	event = (struct ring_buffer_event *)&dpage->data[0];
+	event->type_len = length;
+	event->time_delta = 0;
+
+	trace_event_setup(event, TRACE_INVALID_BUF, 0);
+
+	entry = ring_buffer_event_data(event);
+	entry->lost_bytes = commit_bytes;
+	entry->lost_entries = entries;
+	entry->buffer_index = buffer_index;
+
+	/* This buffer_page has only one event. */
+	local_set(&buffer->entries, 1);
+	local_set(&buffer->page->commit, rb_event_data_length(event));
+}
+
 /* If the meta data has been validated, now validate the events */
 static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 {
@@ -2043,12 +2075,11 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 
 		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu);
 		if (ret < 0) {
-			pr_info("Ring buffer meta [%d] invalid buffer page\n",
-				cpu_buffer->cpu);
-			/* Instead of invalidate whole ring buffer, just clear this subbuffer. */
-			local_set(&head_page->entries, 0);
-			local_set(&head_page->page->commit, 0);
-			/* TODO: commit an event to mark this is broken. */
+			/* Discard invalid buffer and record it. */
+			rb_record_invalid_buffer(head_page,
+				local_read(&head_page->page->commit),
+				local_read(&head_page->entries),
+				rb_meta_subbuf_idx(meta, head_page->page));
 		} else {
 			/* If the buffer has content, update pages_touched */
 			if (ret)
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 7894bf55743c..667834edb5b9 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -57,6 +57,7 @@ enum trace_type {
 	TRACE_TIMERLAT,
 	TRACE_RAW_DATA,
 	TRACE_FUNC_REPEATS,
+	TRACE_INVALID_BUF,
 
 	__TRACE_LAST_TYPE,
 };
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index f6a8d29c0d76..df39fc245ab4 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -457,3 +457,18 @@ FTRACE_ENTRY(timerlat, timerlat_entry,
 		 __entry->context,
 		 __entry->timer_latency)
 );
+
+FTRACE_ENTRY(invalid_subbuf, invalid_subbuf_entry,
+	TRACE_INVALID_BUF,
+
+	F_STRUCT(
+		__field(	long,			lost_bytes	)
+		__field(	long,			lost_entries	)
+		__field(	int,			buffer_index	)
+	),
+
+	F_printk("lost_bytes:%ld\tlost_entries:%ld\tbuffer_index:%d\n",
+		 __entry->lost_bytes,
+		 __entry->lost_entries,
+		 __entry->buffer_index)
+);

