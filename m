Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458904746B7
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786548823; cv=none; b=gu/jbye31O6DKUtqpwYEY6ccsyHY/GO+/pwgJ73LgqHPx1G2BUyPJXUUgIlxnOGzv5new3iWHGhYyJxx4H7ciIsXSZK7szeHRsrDWYOJ6aoPxn1RWfSl6h79DlSYBijGQ9nkq55gib9oBt2h+qzcS2cyVgCIYblAYMRqXg16Pqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786548823; c=relaxed/simple;
	bh=/1BEHT5uq1pyqX/1MtifH9+r16Vbs7owcMJT5u84RA4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aJPsym7iGft2y6aSSUK1YH2LC4HSCG9FISX/uibQBfoFcgPI9SomJpvzvdTeLe/Mqxy2JTQ1Ojol7C1mebmSbOtBZbWjTRi7k19rqJP1iXpMfNY9l6AIOX+UvITGojDOQULVEf8z0zVJ00/YytjGPzWiyPj6D9CYKgAkIcwY2Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uaKIPR0U; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uaKIPR0U"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-481558a96e2so467333f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 08:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786548814; x=1787153614; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wvWrlX1DNJnVnzYlaWcWtcytq+ZX0Z/C9DkS8y8QXl8=;
        b=uaKIPR0U8qGg/kvydngDQGXl8dQOWaiocQIuwhn3uSBrxYI2l+kKeLRle5jcxh9+xe
         nAaE/OBBkdsiQCCqI6oGsRSDi6924RPEJb6l7O+BnG4OrMWuiBBgrPi/AN65OWllQDmU
         P4UaGLoAJU3B2JFkjrMGu9iLM8Fce1JFUW0FgArNdpl2jSw6qro6Te1CVvjogHaB+MqJ
         vozWh1ZFK1rLQ5qzFX5mT6dbGUS7cW12t4q5njxypEHJRAPs8RwIXNo7GIQbuLe3h8wA
         VZIMsDqI/ari+4lMiK3LY98CP/Tal4u2abqtjIvF5MLfCnLzkoKn5n+00WggMVYD5s9U
         Pajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786548814; x=1787153614;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wvWrlX1DNJnVnzYlaWcWtcytq+ZX0Z/C9DkS8y8QXl8=;
        b=syL742L/Wct5Y+L0yAvYO6mpeD52cybV8mQaTFjAP9/gZOHiElxUY8NHYpgrMQvO/P
         1w0GeDKfyqUUljM6FsxeZ1fsUwU5nH4KPBzKUJChDHqdPeCzR2+YpbKD5kb1usAhUYQn
         e+Qi9Tq76d6xXHhTnmNcDigs2u5E1Ub+tRAcHp24OBUGAU0iR4VYBCcTiENFG1R7gTp2
         sSc3SO4arTlK0rwEhTO8kYc25t5836/wa9MhxiA17tnk3zl7XzheejA42DKT3JPtwcPz
         FNHx3NWXvElWa+aqE8ndgw/jSBFQuchPOPPcq5sIkzGVoYxyzQVWPA4NQ8g1a9XlbK2l
         H0+g==
X-Forwarded-Encrypted: i=1; AHgh+RoJ/1Sx6mlD1EpYzkbaua663OpLWqS319PqrdxlTJpFPa3zPW8n5DHScmYEFzaNY9+S1JXYTgJoa0Sx150FStOzB38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfAsmd6KZgLmfjMR2Atx1txl/SEJpun9DB5n6Zp68uMkYfIAAc
	REYH54Pyu6cBoGFRXlZRkN72dV074i7DtDSq+YUnHhPekIl6e0Fr0+UcP8dMhgeCNVaOqnE9Hjn
	wNBZ20fAQx3uskgW2OeEaEQ==
X-Received: from wrux12.prod.google.com ([2002:a5d:650c:0:b0:47a:db72:56a])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2612:b0:47f:7b75:9dfe with SMTP id ffacd0b85a97d-481527aa517mr8598688f8f.8.1786548813673;
 Wed, 12 Aug 2026 08:33:33 -0700 (PDT)
Date: Wed, 12 Aug 2026 16:33:07 +0100
In-Reply-To: <20260812153311.2328812-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812153311.2328812-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812153311.2328812-7-vdonnefort@google.com>
Subject: [PATCH v4 6/9] ring-buffer: Dynamically calculate max_data_size
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
index f62d6853ee5c..64bf4ac853f5 100644
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
 
@@ -7976,7 +7990,7 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
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

