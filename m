Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795331850;
	b=S2Jb60NSCNTQeRc4mCTDrRd+GcBSI/bI9o1X1bZ/pSRHE+lcoIyNQgHFITPLu0rwxFaV
	 mWPQK7/kVuMy4cKbXv6oTO+2NzckixMBNkmlk6IqyWYxaTi3Y13zBIRxdnOKgU9hArFvs
	 gr+/CjLGPINmflEHdWF2lV7kOJrIBCRUlRBrJFYUJ83EfJ6/HK94yVe8Ad+dp0/fv23DS
	 gyzdGfFI3QHiEjYEcuDS4LnAn/k61wXmfpf1EZkppK8mvtxFytNVJwNXN7m5lAmETeFni
	 GMSPdvCqDsUf3YCUvh0UMGN+OUlzqClOoyA5QMKK4QuvpM9gBdolDfnhF/JyMUsbmnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795331850;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kzSbAYvdyPWhGp1DiO14R5295VN64FwTzICg6FuR2Tw=;
	b=XYjwfl5jQ+Zd+/eQpNKCTdh6XZSG+mLuy35iIGY4ebeDOPPS85W4OcIsmrD3EPBKpdV7
	 o/p5pX7cASOOHmppv5/thBLuxM7K9OK47i+yD0SK5OM8x859Y2IduYHjfYWSIvLlVj4xZ
	 tg3DLxKpNgtqTg5kqpteVI+/TewUlRMHiNNRWrcX+M7iDybBLuMjzKEuPVZWkQxgLjc0v
	 KKVm8SwZj4dxj+lpwzeObtpzXDGtL2tZEt+xcaaCm0QAFiQIl8Fl7DHYq4bb2nUDbg/Wy
	 XlkIU01DQrLLkVUBz8WnoSv6ac55Fh43zXkv4tbRYKMpE+Rjb7KHLdAq1QHbaqzogcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJlsaaSM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711AE606A320;
	Sun, 22 Nov 2026 07:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJlsaaSM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F74A1F000C6;
	Sun, 22 Nov 2026 07:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795331850;
	bh=kzSbAYvdyPWhGp1DiO14R5295VN64FwTzICg6FuR2Tw=;
	h=From:To:Cc:Subject:Date;
	b=XJlsaaSMk2vbyflWM5lILxEZSpdjDWtbdGu27FQPN/KIXh26wueCKv5C1jFeNwQFD
	 6Zpao3cuIrUtbqwaJAu0so+Sb+iTQ8g6+Dx5t3Hi0HJV647zN9GOmIOO05cjQxAL/F
	 7qM3RafVa4JAUIpUCxcwIvI1i9uVuEu7dfbZvAK6WNAadpRIagLOBp5+vlo1DWrV4b
	 z6jdpkbSryN9916UAFBziN+edMQ3dSHI00j3McRw9ddJtyka3es6XDt8q1SoNm8JbF
	 ojfA8gRCn1SB8pMXxq7PUL9LsnNq8Aj239r+N16E1lG4NyIOB9m0I7wF0ovPDvKNLx
	 aX5XRKUdTPmJA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/filters: Use atomic bitops and READ_ONCE() for trace_event_file::flags
Date: Sun, 22 Nov 2026 16:17:26 +0900
Message-ID: <179533184612.139632.4029978219979965754.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

syzbot reported a KCSAN data race on struct trace_event_file::flags
between filter_disable() and __trace_trigger_soft_disabled():

  BUG: KCSAN: data-race in __trace_trigger_soft_disabled /
  apply_subsystem_event_filter

  write to 0xffff888100172888 of 8 bytes by task 5433 on cpu 0:
   filter_disable [inline]
   process_system_preds [inline]
   create_system_filter [inline]
   apply_subsystem_event_filter+0x28f/0xcd0
   subsystem_filter_write+0x79/0xd0

  read to 0xffff888100172888 of 8 bytes by task 5440 on cpu 1:
   __trace_trigger_soft_disabled+0x20/0x1a0
   trace_trigger_soft_disabled [inline]

filter_disable() and event_set_filtered_flag() update
EVENT_FILE_FL_FILTERED using non-atomic read-modify-write operations on
file->flags and compare old_flags != file->flags to decide whether to
call trace_buffered_event_disable() / trace_buffered_event_enable().

Because other bits in file->flags (such as
EVENT_FILE_FL_SOFT_DISABLED_BIT from event enable/disable triggers) can
be modified concurrently without event_mutex using atomic bitops, the
non-atomic RMW can lose concurrent bit updates or misdetect a flag
transition and unbalance the buffered event refcount.

Use test_and_clear_bit() / test_and_set_bit() on
EVENT_FILE_FL_FILTERED_BIT in filter_disable() and
event_set_filtered_flag(), and use READ_ONCE() / test_bit() for lockless
readers of file->flags in the trace event fast paths.

Reported-by: syzbot+1faa12be48036b80e416@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6b0234dc.44b41460.34b83f.0019.GAE@google.com
Fixes: 0fc1b09ff1ff ("tracing: Use temp buffer when filtering events")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/trace_events.h        |    2 +-
 kernel/trace/trace.c                |    7 ++++---
 kernel/trace/trace.h                |   18 ++++++++++--------
 kernel/trace/trace_events.c         |    2 +-
 kernel/trace/trace_events_filter.c  |   12 ++----------
 kernel/trace/trace_events_trigger.c |    5 +++--
 6 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5cbd09c8be8d..3cd719d9f497 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -764,7 +764,7 @@ bool __trace_trigger_soft_disabled(struct trace_event_file *file);
 static __always_inline bool
 trace_trigger_soft_disabled(struct trace_event_file *file)
 {
-	unsigned long eflags = file->flags;
+	unsigned long eflags = READ_ONCE(file->flags);
 
 	if (likely(!(eflags & (EVENT_FILE_FL_TRIGGER_MODE |
 			       EVENT_FILE_FL_SOFT_DISABLED |
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e4a490d3d08c..00b161fa8a9b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1868,7 +1868,8 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
 	*current_rb = tr->array_buffer.buffer;
 
 	if (!tr->no_filter_buffering_ref &&
-	    (trace_file->flags & (EVENT_FILE_FL_SOFT_DISABLED | EVENT_FILE_FL_FILTERED))) {
+	    (READ_ONCE(trace_file->flags) &
+	     (EVENT_FILE_FL_SOFT_DISABLED | EVENT_FILE_FL_FILTERED))) {
 		preempt_disable_notrace();
 		/*
 		 * Filtering is on, so try to use the per cpu buffer first.
@@ -1929,7 +1930,7 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
 	 * to store the trace event for the trigger to use. It's recursive
 	 * safe and will not be recorded anywhere.
 	 */
-	if (!entry && trace_file->flags & EVENT_FILE_FL_TRIGGER_COND) {
+	if (!entry && (READ_ONCE(trace_file->flags) & EVENT_FILE_FL_TRIGGER_COND)) {
 		*current_rb = temp_buffer;
 		entry = __trace_buffer_lock_reserve(*current_rb, type, len,
 						    trace_ctx);
@@ -1960,7 +1961,7 @@ static void output_printk(struct trace_event_buffer *fbuffer)
 
 	file = fbuffer->trace_file;
 	if (test_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags) ||
-	    (unlikely(file->flags & EVENT_FILE_FL_FILTERED) &&
+	    (unlikely(test_bit(EVENT_FILE_FL_FILTERED_BIT, &file->flags)) &&
 	     !filter_match_preds(file->filter, fbuffer->entry)))
 		return;
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 3749485a7d85..42551c50872c 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1732,24 +1732,26 @@ __event_trigger_test_discard(struct trace_event_file *file,
 			     void *entry,
 			     enum event_trigger_type *tt)
 {
-	unsigned long eflags = file->flags;
+	unsigned long eflags = READ_ONCE(file->flags);
 
-	if (eflags & EVENT_FILE_FL_TRIGGER_COND)
+	if (eflags & EVENT_FILE_FL_TRIGGER_COND) {
 		*tt = event_triggers_call(file, buffer, entry, event);
+		eflags = READ_ONCE(file->flags);
+	}
 
-	if (likely(!(file->flags & (EVENT_FILE_FL_SOFT_DISABLED |
-				    EVENT_FILE_FL_FILTERED |
-				    EVENT_FILE_FL_PID_FILTER))))
+	if (likely(!(eflags & (EVENT_FILE_FL_SOFT_DISABLED |
+			       EVENT_FILE_FL_FILTERED |
+			       EVENT_FILE_FL_PID_FILTER))))
 		return false;
 
-	if (file->flags & EVENT_FILE_FL_SOFT_DISABLED)
+	if (eflags & EVENT_FILE_FL_SOFT_DISABLED)
 		goto discard;
 
-	if (file->flags & EVENT_FILE_FL_FILTERED &&
+	if (eflags & EVENT_FILE_FL_FILTERED &&
 	    !filter_match_preds(file->filter, entry))
 		goto discard;
 
-	if ((file->flags & EVENT_FILE_FL_PID_FILTER) &&
+	if ((eflags & EVENT_FILE_FL_PID_FILTER) &&
 	    trace_event_ignore_this_pid(file))
 		goto discard;
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 30c0ddf90887..7a8d1e6e53e0 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -698,7 +698,7 @@ void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
 {
 	struct trace_event_call *event_call = trace_file->event_call;
 
-	if ((trace_file->flags & EVENT_FILE_FL_PID_FILTER) &&
+	if (test_bit(EVENT_FILE_FL_PID_FILTER_BIT, &trace_file->flags) &&
 	    trace_event_ignore_this_pid(trace_file))
 		return NULL;
 
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 2b46ca536045..ff5eba48b560 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1297,11 +1297,7 @@ static void free_prog(struct event_filter *filter)
 
 static void filter_disable(struct trace_event_file *file)
 {
-	unsigned long old_flags = file->flags;
-
-	file->flags &= ~EVENT_FILE_FL_FILTERED;
-
-	if (old_flags != file->flags)
+	if (test_and_clear_bit(EVENT_FILE_FL_FILTERED_BIT, &file->flags))
 		trace_buffered_event_disable();
 }
 
@@ -2242,11 +2238,7 @@ static int process_preds(struct trace_event_call *call,
 
 static inline void event_set_filtered_flag(struct trace_event_file *file)
 {
-	unsigned long old_flags = file->flags;
-
-	file->flags |= EVENT_FILE_FL_FILTERED;
-
-	if (old_flags != file->flags)
+	if (!test_and_set_bit(EVENT_FILE_FL_FILTERED_BIT, &file->flags))
 		trace_buffered_event_enable();
 }
 
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 4d2fde996c0f..190f8d27956e 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -214,7 +214,7 @@ EXPORT_SYMBOL_GPL(event_triggers_call);
 
 bool __trace_trigger_soft_disabled(struct trace_event_file *file)
 {
-	unsigned long eflags = file->flags;
+	unsigned long eflags = READ_ONCE(file->flags);
 
 	if (eflags & EVENT_FILE_FL_TRIGGER_MODE)
 		event_triggers_call(file, NULL, NULL, NULL);
@@ -1690,7 +1690,8 @@ event_enable_count_func(struct event_trigger_data *data,
 		return false;
 
 	/* Skip if the event is in a state we want to switch to */
-	if (enable_data->enable == !(enable_data->file->flags & EVENT_FILE_FL_SOFT_DISABLED))
+	if (enable_data->enable == !test_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT,
+					     &enable_data->file->flags))
 		return false;
 
 	if (data->count != -1)

