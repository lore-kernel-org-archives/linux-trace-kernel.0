Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CF847CA7C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786626727; cv=none; b=q94AVJ9v5DuNz3aGI6gRPNCwmbO6pq3mKtDWF4qffCKlWN0+NdqapG1GwNuTdV01NfwfBzwSspRg32fFm3zDmjlChFlQkHD3H5FBvY0Vo76u6LWVkeQNnIPt+Fe+w+sDhpkPLnKhU332RuyhZ3MyKL0KhpBeExKxWVk65Kxti9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786626727; c=relaxed/simple;
	bh=kh+/+F7Yrso+LdumKNDYNclbFEAYJdZStq8JXTkEJVo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aMbi+UBBZFQ1YTCQpCSz3uku637gz+cpfmPCKMoamR1clOV1C87N5NZPjhTCh5/2kyiWK7bSEgQH6+faQg4JwbAUtpxPC9cY6n6XtYg+080xV+/rc+prxXKWML4sBpEXZHdan/8QQsJQqWfzlw8TOjDpYnNM+xSapaG5mQspA4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JvRJjPXN; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JvRJjPXN"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493fa6e28a7so8393645e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 06:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786626724; x=1787231524; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hFL43jjwG4Hy2J+x31lo72TgMA0D0unaTk/Ok+c8KgA=;
        b=JvRJjPXNlbSr1mL2vE00tnB8UnGXh/f0dnPg/jOdhB31UVQd7umfY4ENjGD/x0NZyP
         trj7tQEm0xt6paGJfTxe1iDj+MgCCHPDBY03Q4KMG/1hmMlHJS/j0mJj5cEaJPfp2fMq
         ZfOctTz8mfbISGTJ/Urh6qyn2Fmb4POnnSIq7YRcnmsMOeUHxu369P/6NCRGzpM2oZzr
         rKkT5o4OIhGm4AhkMr6Zpje67Ijh4xmkWBBiOppaXqiQj24YlAaP/9y4IuK4elavtbRy
         VFavB+YYglXEtobHGfLs8y/KpChcRoBfxIVmWPvct1VsYN0vODgLwats4WkMvmxFPFa4
         lw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786626724; x=1787231524;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hFL43jjwG4Hy2J+x31lo72TgMA0D0unaTk/Ok+c8KgA=;
        b=B6nSRecMxdB2uYTB2TQfwBIAoiEYpVeMt4ADSmjRovncVWIA/+MH8cEVB0XrqY5Q64
         lVuGgc8ZN+0NRt079/3JzekC7oukewTDb1v1lUdjKAFuy5dugfZqXmnAs6cJZywB386q
         zW46WhAOGf9QQYrkfo9gKocCDFrdRTNGnD90wyOdFMAFDAt1OpAs3OmLtRNVxSTiQqlQ
         7oXS+Gft6V5QNnf/43rGou2BhFUmKMzuRFeDBhNsDZ6CYXrk1EtETlPKapx2mkcJ2eKx
         asj3tvxoM1lRgF9pNdcUg4x98Qcwpi/av5MbfmJHTNLUnO9gR8r4UHi6ZzwIuRi2e9t5
         y7MQ==
X-Forwarded-Encrypted: i=1; AHgh+RqSC4gOKuAzvpDy73+wxl6ZN2MQi5Y6yCcqYgKkv/4iALC0Vmoq55dUqwZi4WFkMy1uae6k5Rzy4VeBadgDmoStx8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBol4HIi8AGCaZoC0m9AbLbpjxFhRhlMnEfLbqP6j2kwSFF0y0
	vLhUDGpsvch4GcBP5enNIM7GYjVEvJuLQP0b1nI4qdAiJOCyJarDWkEybGizqD1kGnLb7lLVHtg
	nQCPwbKbvgdgxbmnTg9hpoQ==
X-Received: from wmj9.prod.google.com ([2002:a05:600c:249:b0:495:43e1:542c])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:840f:b0:493:cc25:85cb with SMTP id 5b1f17b1804b1-4998215ed62mr64783775e9.8.1786626723660;
 Thu, 13 Aug 2026 06:12:03 -0700 (PDT)
Date: Thu, 13 Aug 2026 14:11:49 +0100
In-Reply-To: <20260813131152.3589632-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813131152.3589632-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813131152.3589632-8-vdonnefort@google.com>
Subject: [PATCH v5 07/10] ring-buffer: Dynamically calculate max_data_size
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The ring buffer order can be dynamically modified and temporarily
disables writing to do so. It is therefore safe to use the updated value
to calculate the maximum event size which can be written onto the ring
buffer.

However, notice it is hardly making any difference for trace_marker
because of the TRACE_MARKER_MAX_SIZE limit. For an 8KiB subbuf size,
trace_marker can take 4096 characters while it can 'only' take 4054
bytes for smaller subbufs.

Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 83292d90599e..d7b3c56e4263 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -598,7 +598,6 @@ struct trace_buffer {
 	struct ring_buffer_meta		*meta;
 
 	unsigned int			subbuf_order;
-	unsigned int			max_data_size;
 };
 
 static __always_inline unsigned int rb_subbuf_size(struct trace_buffer *buffer)
@@ -620,6 +619,23 @@ static __always_inline unsigned int rb_subbuf_capacity(struct trace_buffer *buff
 	return rb_subbuf_size(buffer) - BUF_PAGE_HDR_SIZE;
 }
 
+/**
+ * rb_subbuf_max_data_size - Get the maximum payload size of a single event
+ * @buffer:	A trace buffer
+ *
+ * Return: The maximum data payload size that can be stored in a single event.
+ */
+static __always_inline unsigned int rb_subbuf_max_data_size(struct trace_buffer *buffer)
+{
+	struct ring_buffer_event *event;
+
+	/*
+	 * surely rb_subbuf_capacity() is bigger than
+	 * RINGBUF_TYPE_DATA_TYPE_LEN_MAX (see ring_buffer_event_length).
+	 */
+	return rb_subbuf_capacity(buffer) - RB_EVNT_HDR_SIZE - sizeof(event->array[0]);
+}
+
 /**
  * rb_subbuf_start - Get the start address of a subbuffer
  * @buffer:	A trace buffer
@@ -2773,9 +2789,6 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 	buffer->subbuf_order = order;
 	subbuf_size = (PAGE_SIZE << order);
 
-	/* Max payload is buffer page size - header (8bytes) */
-	buffer->max_data_size = rb_subbuf_capacity(buffer) - (sizeof(u32) * 2);
-
 	buffer->flags = flags;
 	buffer->clock = trace_clock_local;
 	buffer->reader_lock_key = key;
@@ -4941,7 +4954,7 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	if (ring_buffer_time_stamp_abs(cpu_buffer->buffer)) {
 		add_ts_default = RB_ADD_STAMP_ABSOLUTE;
 		info.length += RB_LEN_TIME_EXTEND;
-		if (info.length > cpu_buffer->buffer->max_data_size)
+		if (info.length > rb_subbuf_max_data_size(cpu_buffer->buffer))
 			goto out_fail;
 	} else {
 		add_ts_default = RB_ADD_STAMP_NONE;
@@ -5016,7 +5029,7 @@ ring_buffer_lock_reserve(struct trace_buffer *buffer, unsigned long length)
 	if (unlikely(atomic_read(&cpu_buffer->record_disabled)))
 		goto out;
 
-	if (unlikely(length > buffer->max_data_size))
+	if (unlikely(length > rb_subbuf_max_data_size(buffer)))
 		goto out;
 
 	if (unlikely(trace_recursive_lock(cpu_buffer)))
@@ -5163,7 +5176,7 @@ int ring_buffer_write(struct trace_buffer *buffer,
 	if (atomic_read(&cpu_buffer->record_disabled))
 		return -EBUSY;
 
-	if (length > buffer->max_data_size)
+	if (length > rb_subbuf_max_data_size(buffer))
 		return -EBUSY;
 
 	if (unlikely(trace_recursive_lock(cpu_buffer)))
@@ -6522,8 +6535,9 @@ unsigned long ring_buffer_max_event_size(struct trace_buffer *buffer)
 {
 	/* If abs timestamp is requested, events have a timestamp too */
 	if (ring_buffer_time_stamp_abs(buffer))
-		return buffer->max_data_size - RB_LEN_TIME_EXTEND;
-	return buffer->max_data_size;
+		return rb_subbuf_max_data_size(buffer) - RB_LEN_TIME_EXTEND;
+
+	return rb_subbuf_max_data_size(buffer);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_max_event_size);
 
@@ -7982,7 +7996,7 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 			 * missed events, then record it there.
 			 */
 			commit = rb_page_size(reader);
-			if (rb_subbuf_capacity(buffer) - commit >= sizeof(missed_events)) {
+			if (rb_page_capacity(reader) - commit >= sizeof(missed_events)) {
 				memcpy(&dpage->data[commit], &missed_events,
 				       sizeof(missed_events));
 				local_add(RB_MISSED_STORED, &dpage->commit);
-- 
2.55.0.691.gc56d675ccc-goog

