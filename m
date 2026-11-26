Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729072;
	b=usfwrN0aBzxTiOD/BQG1hCFYv3nxLag9YDrDzgKR5AgBHo0Crn3qupqWbqtnA7G46r7+
	 dY84nRQfqEUZl+zwC9MJ/stzewvgWkAIECcwbmxGve4gMmPKJeFbDq7XUf7ENdjOwruHP
	 jTTeV/PATPZm3mHoJfEzHn/Ml+1No6fokc3ukRlOdcWkDZPdnuq1Xd+s73cOtfCX3O8Ko
	 D+H81NRUz3zvJv/FJBPh8s4wwV+EabIqpMTaHjXUv1SXJJrKHXtXzo9JyvAduDwxqNFb5
	 f1zxgd2YyNzR9Boztu1TZ8PkAITcaioOVYmqNnjp7qZEnILe6RdT/TGUikaA/LHyyRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=5Az0gPDunt2+zui3Z/fGv6Nk762mYWwFD5nBfm1scHI=;
	b=B0lODNnWXpJc34Z9NxCGz07hBjAaqFhCj7b7QwmXGKILKTUrKgnjjqGf6usqoJhBPe22
	 Ux4TuVZucOzhXbmXe5zSvugtXcI7WjB3TCouEoFgyjx++WhUdEduUjoDDh8ueXocNFenf
	 6u0mEy3qktUk9D9wcS/M86YpntPLLb9TBr5l2wHNEK/saUklz1RSDV+ulDsMLZvuWDEMv
	 HDdYBk7ojSGr35/hwuCYOWCLH7mHnEnBIVOaNqAPYRHQmQY2rCowlmyQRjBqX6N1oqSWt
	 FtHbZ/jPV7yTOTDilnqa/hB72blNwj8RZPn+K8EMYK3qnU4JMdvTZNfqCGO/ah5FGQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=g3k9Vb9x;
	arc=none smtp.remote-ip=209.85.128.69
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F366606A31C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 21:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F366606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=g3k9Vb9x
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4bb68d624baso42158045e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 13:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795729070; x=1796333870; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Az0gPDunt2+zui3Z/fGv6Nk762mYWwFD5nBfm1scHI=;
        b=g3k9Vb9xzVu7RJw5Jpu0xttzaTelZm0Qx/f+vuya2rwFeWhPBXEuijww1P6gVkFtl9
         VNV3BmizCaXJqE+JN2mIVtMKVj2gDXNHSsxJBVlxQR9Y3R7M1IpnL9X+QKPsLP/r7qcG
         P0lEl/8Xl9k+umCMXlqFnty7y/jctdP8/eOrIr69X/6jB033eLt11agxJfkcpUEh736n
         l+dKQPntSqfhlcDrJv4+ylMnKcGMA/qYNnZwkLqtX2RGhP+ZJL+X787CJRDSXbmrgSr1
         Y8RH8DgEX1laSYiwhfvTvzkJEOs/qJY8YRZs1r9lojeNFhA4c9yHj/07L/aWF3IgkX2j
         U/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729070; x=1796333870;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Az0gPDunt2+zui3Z/fGv6Nk762mYWwFD5nBfm1scHI=;
        b=RqJBRppS7j+9qGYdRFR+v/1xwHmtVPR4h0bLW8AdmBnOiXue2vVr2wtzvCKClk8smB
         ULC2toy+m7fzhUQSE+FSqS1H6dZJmpXDF04qAI0tFBZpR/vINcCep188/ufteNlkA0qT
         IYzk6IpqlHt/MwX8z/Xdac+5fPEt/nCmZ3LEXF2DohPjtvC1/vsax+vSmNc9fx4kLKb8
         8q4FG35/xuhxXY9Rkg1dkh2MsQuc9yBzMmzychpX+RZPZ8EC0ZTBHKIyjPIibXkBM7aS
         6jInk3W2DHRWozwO4MUHN3zrOG0tlUu/0OfFNqRf/d2/k1ZmjOhc34l9+EJe2aefcl5b
         ElGQ==
X-Forwarded-Encrypted: i=1; AL+hErEuRsKu6TmCeVyLaDGJk6OYDuTxosfFiD+Yig7joqY4BtEqh6w+veN/3W2dvfh/0utq84W5t1m9BpVuQ1zS7XRwRjQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Za0lll4HM+RU63/47gOqhlRGh4dHtfRCJqUlvTw4uwLkHuINE
	fUS8CVPa6s5vGKNJbstErXURSeQ30wc5Ydw9bsxTTyLd3ygz+nNYP4bu7YlexGs3ctWWiXsWNxD
	7hoGUKmzrPtayHYsqXatDCA==
X-Received: from wmil12.prod.google.com ([2002:a7b:c44c:0:b0:4a1:70b0:32e3])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d8c:b0:4a1:c5eb:b445 with SMTP id 5b1f17b1804b1-4bb88820436mr458108115e9.35.1795729070371;
 Thu, 26 Nov 2026 13:37:50 -0800 (PST)
Date: Thu, 26 Nov 2026 21:37:42 +0000
In-Reply-To: <20261126213743.3044079-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261126213743.3044079-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261126213743.3044079-2-vdonnefort@google.com>
Subject: [PATCH v2 1/2] ring-buffer: Remove unused absolute timestamp mode
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Since commit b94bc80df648 ("tracing: Use a no_filter_buffering_ref to
stop using the filter buffer") dropped the last user of
ring_buffer_set_time_stamp_abs(), there's been no one enabling absolute
timestamps on the ring buffer.

Drop the support to simplify the ring buffer code, along with the
tracefs timestamp_mode file and its documentation.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 Documentation/trace/ftrace.rst | 24 -----------
 include/linux/ring_buffer.h    |  2 -
 kernel/trace/ring_buffer.c     | 77 ++++++++++------------------------
 kernel/trace/trace.c           | 43 -------------------
 4 files changed, 21 insertions(+), 125 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 9423722848c6..f42f4e483709 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -710,30 +710,6 @@ of ftrace. Here is a list of some of the key files:
 
 	See events.rst for more information.
 
-  timestamp_mode:
-
-	Certain tracers may change the timestamp mode used when
-	logging trace events into the event buffer.  Events with
-	different modes can coexist within a buffer but the mode in
-	effect when an event is logged determines which timestamp mode
-	is used for that event.  The default timestamp mode is
-	'delta'.
-
-	Usual timestamp modes for tracing:
-
-	  # cat timestamp_mode
-	  [delta] absolute
-
-	  The timestamp mode with the square brackets around it is the
-	  one in effect.
-
-	  delta: Default timestamp mode - timestamp is a delta against
-	         a per-buffer timestamp.
-
-	  absolute: The timestamp is a full timestamp, not a delta
-                 against some other value.  As such it takes up more
-                 space and is less efficient.
-
   hwlat_detector:
 
 	Directory for the Hardware Latency Detector.
diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 649b2276b557..378d336effca 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -220,8 +220,6 @@ void ring_buffer_normalize_time_stamp(struct trace_buffer *buffer,
 				      int cpu, u64 *ts);
 void ring_buffer_set_clock(struct trace_buffer *buffer,
 			   u64 (*clock)(void));
-void ring_buffer_set_time_stamp_abs(struct trace_buffer *buffer, bool abs);
-bool ring_buffer_time_stamp_abs(struct trace_buffer *buffer);
 
 size_t ring_buffer_nr_dirty_pages(struct trace_buffer *buffer, int cpu);
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a5a0adc934fa..2d8395c03496 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -480,14 +480,12 @@ struct rb_event_info {
  * Used for the add_timestamp
  *  NONE
  *  EXTEND - wants a time extend
- *  ABSOLUTE - the buffer requests all events to have absolute time stamps
  *  FORCE - force a full time stamp.
  */
 enum {
 	RB_ADD_STAMP_NONE		= 0,
 	RB_ADD_STAMP_EXTEND		= BIT(1),
-	RB_ADD_STAMP_ABSOLUTE		= BIT(2),
-	RB_ADD_STAMP_FORCE		= BIT(3)
+	RB_ADD_STAMP_FORCE		= BIT(2)
 };
 /*
  * Used for which event context the event is in.
@@ -595,7 +593,6 @@ struct trace_buffer {
 	u64				(*clock)(void);
 
 	struct rb_irq_work		irq_work;
-	bool				time_stamp_abs;
 
 	unsigned long			range_addr_start;
 	unsigned long			range_addr_end;
@@ -3061,16 +3058,6 @@ void ring_buffer_set_clock(struct trace_buffer *buffer,
 	buffer->clock = clock;
 }
 
-void ring_buffer_set_time_stamp_abs(struct trace_buffer *buffer, bool abs)
-{
-	buffer->time_stamp_abs = abs;
-}
-
-bool ring_buffer_time_stamp_abs(struct trace_buffer *buffer)
-{
-	return buffer->time_stamp_abs;
-}
-
 static inline unsigned long rb_page_entries(struct buffer_page *bpage)
 {
 	return local_read(&bpage->entries) & RB_WRITE_MASK;
@@ -4079,8 +4066,7 @@ static void rb_add_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
 				      u64 *delta,
 				      unsigned int *length)
 {
-	bool abs = info->add_timestamp &
-		(RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE);
+	bool abs = info->add_timestamp & RB_ADD_STAMP_FORCE;
 
 	if (unlikely(info->delta > (1ULL << 59))) {
 		/*
@@ -4761,8 +4747,7 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 	if (tail == CHECK_FULL_PAGE) {
 		full = true;
 		tail = rb_data_page_commit(dpage);
-	} else if (info->add_timestamp &
-		   (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE)) {
+	} else if (info->add_timestamp & RB_ADD_STAMP_FORCE) {
 		/* Ignore events with absolute time stamps */
 		return;
 	}
@@ -4827,26 +4812,22 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	barrier();
 	info->ts = rb_time_stamp(cpu_buffer->buffer);
 
-	if ((info->add_timestamp & RB_ADD_STAMP_ABSOLUTE)) {
-		info->delta = info->ts;
+	/*
+	 * If interrupting an event time update, we may need an
+	 * absolute timestamp.
+	 * Don't bother if this is the start of a new page (w == 0).
+	 */
+	if (!w) {
+		/* Use the sub-buffer timestamp */
+		info->delta = 0;
+	} else if (unlikely(info->before != info->after)) {
+		info->add_timestamp |= RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND;
+		info->length += RB_LEN_TIME_EXTEND;
 	} else {
-		/*
-		 * If interrupting an event time update, we may need an
-		 * absolute timestamp.
-		 * Don't bother if this is the start of a new page (w == 0).
-		 */
-		if (!w) {
-			/* Use the sub-buffer timestamp */
-			info->delta = 0;
-		} else if (unlikely(info->before != info->after)) {
-			info->add_timestamp |= RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND;
+		info->delta = info->ts - info->after;
+		if (unlikely(test_time_stamp(info->delta))) {
+			info->add_timestamp |= RB_ADD_STAMP_EXTEND;
 			info->length += RB_LEN_TIME_EXTEND;
-		} else {
-			info->delta = info->ts - info->after;
-			if (unlikely(test_time_stamp(info->delta))) {
-				info->add_timestamp |= RB_ADD_STAMP_EXTEND;
-				info->length += RB_LEN_TIME_EXTEND;
-			}
 		}
 	}
 
@@ -4874,8 +4855,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 		 * will be different and then next event will just be forced
 		 * to use an absolute timestamp.
 		 */
-		if (likely(!(info->add_timestamp &
-			     (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE))))
+		if (likely(!(info->add_timestamp & RB_ADD_STAMP_FORCE)))
 			/* This did not interrupt any time update */
 			info->delta = info->ts - info->after;
 		else
@@ -4928,8 +4908,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	 * If this is the first commit on the page, then it has the same
 	 * timestamp as the page itself.
 	 */
-	if (unlikely(!tail && !(info->add_timestamp &
-				(RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE))))
+	if (unlikely(!tail && !(info->add_timestamp & RB_ADD_STAMP_FORCE)))
 		info->delta = 0;
 
 	/* We reserved something on the buffer */
@@ -4960,7 +4939,6 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	struct ring_buffer_event *event;
 	struct rb_event_info info;
 	int nr_loops = 0;
-	int add_ts_default;
 
 	/*
 	 * ring buffer does cmpxchg as well as atomic64 operations
@@ -4993,17 +4971,8 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 
 	info.length = rb_calculate_event_length(length);
 
-	if (ring_buffer_time_stamp_abs(cpu_buffer->buffer)) {
-		add_ts_default = RB_ADD_STAMP_ABSOLUTE;
-		info.length += RB_LEN_TIME_EXTEND;
-		if (info.length > rb_subbuf_max_data_size(cpu_buffer->buffer))
-			goto out_fail;
-	} else {
-		add_ts_default = RB_ADD_STAMP_NONE;
-	}
-
  again:
-	info.add_timestamp = add_ts_default;
+	info.add_timestamp = RB_ADD_STAMP_NONE;
 	info.delta = 0;
 
 	/*
@@ -5021,7 +4990,7 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	event = __rb_reserve_next(cpu_buffer, &info);
 
 	if (unlikely(PTR_ERR(event) == -EAGAIN)) {
-		if (info.add_timestamp & (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND))
+		if (info.add_timestamp)
 			info.length -= RB_LEN_TIME_EXTEND;
 		goto again;
 	}
@@ -6600,10 +6569,6 @@ EXPORT_SYMBOL_GPL(ring_buffer_capacity);
  */
 unsigned long ring_buffer_max_event_size(struct trace_buffer *buffer)
 {
-	/* If abs timestamp is requested, events have a timestamp too */
-	if (ring_buffer_time_stamp_abs(buffer))
-		return rb_subbuf_max_data_size(buffer) - RB_LEN_TIME_EXTEND;
-
 	return rb_subbuf_max_data_size(buffer);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_max_event_size);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 65b9d67647e5..cf3932351626 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4227,9 +4227,6 @@ static const char readme_msg[] =
 #ifdef CONFIG_X86_64
 	"     x86-tsc:   TSC cycle counter\n"
 #endif
-	"\n  timestamp_mode\t- view the mode used to timestamp events\n"
-	"       delta:   Delta difference against a buffer-wide timestamp\n"
-	"    absolute:   Absolute (standalone) timestamp\n"
 	"\n  trace_marker\t\t- Writes into this file writes into the kernel buffer\n"
 	"\n  trace_marker_raw\t\t- Writes into this file writes binary data into the kernel buffer\n"
 	"  tracing_cpumask\t- Limit which CPUs to trace\n"
@@ -6576,36 +6573,6 @@ static int tracing_clock_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
-static int tracing_time_stamp_mode_show(struct seq_file *m, void *v)
-{
-	struct trace_array *tr = m->private;
-
-	guard(mutex)(&trace_types_lock);
-
-	if (ring_buffer_time_stamp_abs(tr->array_buffer.buffer))
-		seq_puts(m, "delta [absolute]\n");
-	else
-		seq_puts(m, "[delta] absolute\n");
-
-	return 0;
-}
-
-static int tracing_time_stamp_mode_open(struct inode *inode, struct file *file)
-{
-	struct trace_array *tr = inode->i_private;
-	int ret;
-
-	ret = tracing_check_open_get_tr(tr);
-	if (ret)
-		return ret;
-
-	ret = single_open(file, tracing_time_stamp_mode_show, inode->i_private);
-	if (ret < 0)
-		trace_array_put(tr);
-
-	return ret;
-}
-
 u64 tracing_event_time_stamp(struct trace_buffer *buffer, struct ring_buffer_event *rbe)
 {
 	if (rbe == this_cpu_read(trace_buffered_event))
@@ -6693,13 +6660,6 @@ static const struct file_operations trace_clock_fops = {
 	.write		= tracing_clock_write,
 };
 
-static const struct file_operations trace_time_stamp_mode_fops = {
-	.open		= tracing_time_stamp_mode_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= tracing_single_release_tr,
-};
-
 static const struct file_operations last_boot_fops = {
 	.open		= tracing_last_boot_open,
 	.read		= seq_read,
@@ -9047,9 +9007,6 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	trace_create_file("trace_clock", writable_mode, d_tracer, tr,
 			  &trace_clock_fops);
 
-	trace_create_file("timestamp_mode", TRACE_MODE_READ, d_tracer, tr,
-			  &trace_time_stamp_mode_fops);
-
 	tr->buffer_percent = 50;
 
 	trace_create_file("buffer_subbuf_size_kb", writable_mode, d_tracer,
-- 
2.56.1.839.g22a8290db9-goog

