Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34723A1E92;
	Tue,  7 Apr 2026 09:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553391; cv=none; b=DFiosQfVw/4ROgyOwRVvu7Y/qvHC5RfP0ZMp7jyKlT0sat9o8ofoTPx6K1PvXKzzScX8Jvdjwt9fyb0gJ4Hir5FEwxejVE1C3R2prP5xXUevPmpb936met3lRsoU6qTqTv7mGbZVYtZdESVjDFwZYerGE822EzKVa2EYU8T0FW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553391; c=relaxed/simple;
	bh=gBxhHFNYno0dv8TzAKVtDGRkFYkxhHhdIbMctsWg4fM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VNv9YGEoKaPp3F+o4ZEFmNMchZnIh+OKKxMy9q1Shy492CrSpjC48mv8nFpz8a/gRU8CSwOtpOEk+lnTNRjbsLRARFmX/UbSEuDYDfrsmJW2LcqTjApWtsTxAwIvZKOONl2MsQDCnThZPbPHBh3tgRNjDOgcntoB9ITDMBGBo6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UDZoY5U8; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UDZoY5U8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=eB
	L/vrw902qBX3b21thLeqL1AAQC/TNxpOKqcIBjw1g=; b=UDZoY5U8WvjMovVAe1
	dyUV4jTUqTqQ56jtW2wvU3af7QeC5SkQYgHfhqo2YaSMydy1nSOYevY4KDoIwDLH
	pL9H1Qh7q1P/FWfJSQYMK5Wy81H/fRhdb6/gAz3rYYCAPg1HMoHsIC7eZOSe6tVa
	pAPyAijdYt/GHGbUeIZiZK4rs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXqB5My9RpoAVQDw--.10006S2;
	Tue, 07 Apr 2026 17:15:57 +0800 (CST)
From: Cao Ruichuang <create0818@163.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] ring-buffer: Preserve true payload lengths in long data events
Date: Tue,  7 Apr 2026 17:15:50 +0800
Message-Id: <20260407091550.67963-1-create0818@163.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXqB5My9RpoAVQDw--.10006S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Cw43Wry7GryxWw1DGr13XFb_yoWDWryfpF
	y3Ka98tw4DXF12vFZ0k3Z8Zry5t3Wvgry7GFZxJw13Xr1UJFnxW3W7Gry2vr4YyrZrKry3
	tw1UK348C34UZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0tC7UUUUU=
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbC6A6VzmnUy04LWgAA3U

Long ring buffer data records currently store the aligned in-buffer size in
their length field. That makes ring_buffer_event_length() report padded
sizes, and small TRACE_PRINT / TRACE_RAW_DATA records lose their true
payload length entirely when they use the short type_len encoding.

Teach long data events to keep the true payload size in array[0], and let
the ring buffer derive the aligned in-buffer size separately when it needs
to walk or discard records. Then add a long-reserve helper and use it for
TRACE_PRINT and TRACE_RAW_DATA so their zero-length-array tails always
preserve the real payload size.

The temporary filtered-event buffer keeps the same long-record payload
length semantics, and a QEMU runtime reproducer for trace_marker_raw now
reports the expected byte counts again.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=210173
Signed-off-by: Cao Ruichuang <create0818@163.com>
---
 include/linux/ring_buffer.h |  2 ++
 kernel/trace/ring_buffer.c  | 56 ++++++++++++++++++++++++++-----------
 kernel/trace/trace.c        |  8 +++---
 kernel/trace/trace.h        | 15 ++++++++++
 kernel/trace/trace_printk.c |  8 +++---
 5 files changed, 65 insertions(+), 24 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index d862fa610..a4e46cb53 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -137,6 +137,8 @@ void ring_buffer_change_overwrite(struct trace_buffer *buffer, int val);
 
 struct ring_buffer_event *ring_buffer_lock_reserve(struct trace_buffer *buffer,
 						   unsigned long length);
+struct ring_buffer_event *ring_buffer_lock_reserve_long(struct trace_buffer *buffer,
+							unsigned long length);
 int ring_buffer_unlock_commit(struct trace_buffer *buffer);
 int ring_buffer_write(struct trace_buffer *buffer,
 		      unsigned long length, void *data);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 170170bd8..c9ade62df 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -206,10 +206,14 @@ rb_event_data_length(struct ring_buffer_event *event)
 	unsigned length;
 
 	if (event->type_len)
-		length = event->type_len * RB_ALIGNMENT;
-	else
-		length = event->array[0];
-	return length + RB_EVNT_HDR_SIZE;
+		return event->type_len * RB_ALIGNMENT + RB_EVNT_HDR_SIZE;
+
+	/*
+	 * Long records store the true payload size in array[0], but still
+	 * consume an aligned amount of space in the buffer.
+	 */
+	length = event->array[0] + RB_EVNT_HDR_SIZE + sizeof(event->array[0]);
+	return ALIGN(length, RB_ARCH_ALIGNMENT);
 }
 
 /*
@@ -276,12 +280,13 @@ unsigned ring_buffer_event_length(struct ring_buffer_event *event)
 	if (extended_time(event))
 		event = skip_time_extend(event);
 
+	if (!event->type_len)
+		return event->array[0];
+
 	length = rb_event_length(event);
 	if (event->type_len > RINGBUF_TYPE_DATA_TYPE_LEN_MAX)
 		return length;
 	length -= RB_EVNT_HDR_SIZE;
-	if (length > RB_MAX_SMALL_DATA + sizeof(event->array[0]))
-                length -= sizeof(event->array[0]);
 	return length;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_event_length);
@@ -463,9 +468,11 @@ struct rb_event_info {
 	u64			delta;
 	u64			before;
 	u64			after;
+	unsigned long		data_length;
 	unsigned long		length;
 	struct buffer_page	*tail_page;
 	int			add_timestamp;
+	bool			force_long;
 };
 
 /*
@@ -3796,14 +3803,15 @@ rb_update_event(struct ring_buffer_per_cpu *cpu_buffer,
 
 	event->time_delta = delta;
 	length -= RB_EVNT_HDR_SIZE;
-	if (length > RB_MAX_SMALL_DATA || RB_FORCE_8BYTE_ALIGNMENT) {
+	if (length > RB_MAX_SMALL_DATA || RB_FORCE_8BYTE_ALIGNMENT ||
+	    info->force_long) {
 		event->type_len = 0;
-		event->array[0] = length;
+		event->array[0] = info->data_length;
 	} else
 		event->type_len = DIV_ROUND_UP(length, RB_ALIGNMENT);
 }
 
-static unsigned rb_calculate_event_length(unsigned length)
+static unsigned int rb_calculate_event_length(unsigned int length, bool force_long)
 {
 	struct ring_buffer_event event; /* Used only for sizeof array */
 
@@ -3811,7 +3819,7 @@ static unsigned rb_calculate_event_length(unsigned length)
 	if (!length)
 		length++;
 
-	if (length > RB_MAX_SMALL_DATA || RB_FORCE_8BYTE_ALIGNMENT)
+	if (length > RB_MAX_SMALL_DATA || RB_FORCE_8BYTE_ALIGNMENT || force_long)
 		length += sizeof(event.array[0]);
 
 	length += RB_EVNT_HDR_SIZE;
@@ -4605,7 +4613,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 static __always_inline struct ring_buffer_event *
 rb_reserve_next_event(struct trace_buffer *buffer,
 		      struct ring_buffer_per_cpu *cpu_buffer,
-		      unsigned long length)
+		      unsigned long length, bool force_long)
 {
 	struct ring_buffer_event *event;
 	struct rb_event_info info;
@@ -4641,7 +4649,9 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	}
 #endif
 
-	info.length = rb_calculate_event_length(length);
+	info.length = rb_calculate_event_length(length, force_long);
+	info.data_length = length ? : 1;
+	info.force_long = force_long;
 
 	if (ring_buffer_time_stamp_abs(cpu_buffer->buffer)) {
 		add_ts_default = RB_ADD_STAMP_ABSOLUTE;
@@ -4698,8 +4708,9 @@ rb_reserve_next_event(struct trace_buffer *buffer,
  * Must be paired with ring_buffer_unlock_commit, unless NULL is returned.
  * If NULL is returned, then nothing has been allocated or locked.
  */
-struct ring_buffer_event *
-ring_buffer_lock_reserve(struct trace_buffer *buffer, unsigned long length)
+static struct ring_buffer_event *
+__ring_buffer_lock_reserve(struct trace_buffer *buffer, unsigned long length,
+			   bool force_long)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_event *event;
@@ -4727,7 +4738,7 @@ ring_buffer_lock_reserve(struct trace_buffer *buffer, unsigned long length)
 	if (unlikely(trace_recursive_lock(cpu_buffer)))
 		goto out;
 
-	event = rb_reserve_next_event(buffer, cpu_buffer, length);
+	event = rb_reserve_next_event(buffer, cpu_buffer, length, force_long);
 	if (!event)
 		goto out_unlock;
 
@@ -4739,8 +4750,21 @@ ring_buffer_lock_reserve(struct trace_buffer *buffer, unsigned long length)
 	preempt_enable_notrace();
 	return NULL;
 }
+
+struct ring_buffer_event *
+ring_buffer_lock_reserve(struct trace_buffer *buffer, unsigned long length)
+{
+	return __ring_buffer_lock_reserve(buffer, length, false);
+}
 EXPORT_SYMBOL_GPL(ring_buffer_lock_reserve);
 
+struct ring_buffer_event *
+ring_buffer_lock_reserve_long(struct trace_buffer *buffer, unsigned long length)
+{
+	return __ring_buffer_lock_reserve(buffer, length, true);
+}
+EXPORT_SYMBOL_GPL(ring_buffer_lock_reserve_long);
+
 /*
  * Decrement the entries to the page that an event is on.
  * The event does not even need to exist, only the pointer
@@ -4874,7 +4898,7 @@ int ring_buffer_write(struct trace_buffer *buffer,
 	if (unlikely(trace_recursive_lock(cpu_buffer)))
 		return -EBUSY;
 
-	event = rb_reserve_next_event(buffer, cpu_buffer, length);
+	event = rb_reserve_next_event(buffer, cpu_buffer, length, false);
 	if (!event)
 		goto out_unlock;
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a626211ce..ffc1b1e9c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6503,8 +6503,8 @@ static ssize_t write_marker_to_buffer(struct trace_array *tr, const char *buf,
 	size = cnt + meta_size;
 
 	buffer = tr->array_buffer.buffer;
-	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
-					    tracing_gen_ctx());
+	event = __trace_buffer_lock_reserve_long(buffer, TRACE_PRINT, size,
+						 tracing_gen_ctx());
 	if (unlikely(!event)) {
 		/*
 		 * If the size was greater than what was allowed, then
@@ -6917,8 +6917,8 @@ static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
 	if (size > ring_buffer_max_event_size(buffer))
 		return -EINVAL;
 
-	event = __trace_buffer_lock_reserve(buffer, TRACE_RAW_DATA, size,
-					    tracing_gen_ctx());
+	event = __trace_buffer_lock_reserve_long(buffer, TRACE_RAW_DATA, size,
+						 tracing_gen_ctx());
 	if (!event)
 		/* Ring buffer disabled, return as if not open for write */
 		return -EBADF;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b8f380458..da55717c9 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1613,6 +1613,21 @@ __trace_buffer_lock_reserve(struct trace_buffer *buffer,
 	return event;
 }
 
+static __always_inline struct ring_buffer_event *
+__trace_buffer_lock_reserve_long(struct trace_buffer *buffer,
+				 int type,
+				 unsigned long len,
+				 unsigned int trace_ctx)
+{
+	struct ring_buffer_event *event;
+
+	event = ring_buffer_lock_reserve_long(buffer, len);
+	if (event != NULL)
+		trace_event_setup(event, type, trace_ctx);
+
+	return event;
+}
+
 static __always_inline void
 __buffer_unlock_commit(struct trace_buffer *buffer, struct ring_buffer_event *event)
 {
diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
index 9f67ce42e..1441b2bd4 100644
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -444,8 +444,8 @@ int __trace_array_puts(struct trace_array *tr, unsigned long ip,
 	trace_ctx = tracing_gen_ctx();
 	buffer = tr->array_buffer.buffer;
 	guard(ring_buffer_nest)(buffer);
-	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, alloc,
-					    trace_ctx);
+	event = __trace_buffer_lock_reserve_long(buffer, TRACE_PRINT, alloc,
+						 trace_ctx);
 	if (!event)
 		return 0;
 
@@ -725,8 +725,8 @@ int __trace_array_vprintk(struct trace_buffer *buffer,
 
 	size = sizeof(*entry) + len + 1;
 	scoped_guard(ring_buffer_nest, buffer) {
-		event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
-						    trace_ctx);
+		event = __trace_buffer_lock_reserve_long(buffer, TRACE_PRINT, size,
+							 trace_ctx);
 		if (!event)
 			goto out;
 		entry = ring_buffer_event_data(event);
-- 
2.39.5 (Apple Git-154)

