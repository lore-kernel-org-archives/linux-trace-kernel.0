Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A05F41DE02
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Aug 2026 21:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786050816; cv=none; b=IIerCwwsVRDIOEnMIIWCidz8ibD9MBN4+nmU56qY2sKZ72CY5dLH9PIBCUzn68l7EgeKjR+y7IPwz0EixPsSNFnhvnn76ptyHyw2GJePyUiGuZTzZ3hT7PO2I2Tq3xS/XisYt2ZDMZ+VFW5/7CaCebSHdw9+sfI8tbpI5YVQxKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786050816; c=relaxed/simple;
	bh=CNQvFhVdRoGryLzJvLKX3hSTsH+qre2RJpUcVf9nXh4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RXq/n+nloElINz8Nspz1YoCnDyh9IR+A1n4cYv8Iy/WK/gzLQBs4WxhE0mO/xP74YnCXUhSIwRaB5RcUj2G/CRytriuJDDqbhCmOH1fjBW2YdqFg+61ddxEeT4NPb2cPRM+oFTfLFt8WTA16FULuN+fGSFBEJ4V5fH/phCMGN9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IccDDM99; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IccDDM99"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4955843c6cdso22826135e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Aug 2026 14:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786050801; x=1786655601; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cXf5OkyQb5t84Kc/wGzH1+QneGiHelNLSJRdaS24HXA=;
        b=IccDDM99e7E1RAIfTfbyL7r97zFtwKJF28/mG7tHKgjjMHrRyMDI9HZBi5BRqIaI9F
         kYU65IBfh8JyuES9n6ZSUn5D2oS7rzmYSR3wqaeka3hULvuQ/Um0zXKOlWzbbF3VrdkK
         s8Bj18bqiRnht2URu9HtedVOFcMlg/e88Z9UYM3y0UE2wtxMMSpnbetMVawu3HxszkHy
         sVM4eYTLNEZJwCz1BOm/9z5fcga43Ximpm/AQ0TOvZQ/knZh+gjUGbN6vs3c/bfDfuO5
         GpMDbA8+xuC/wrga7YYZrswgmqg9vU+dM2Jy2h9egfRJmQd40Wg3rXR3T9nAknF/Ge9Y
         ZyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786050801; x=1786655601;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cXf5OkyQb5t84Kc/wGzH1+QneGiHelNLSJRdaS24HXA=;
        b=DKzs+U7xx1mNgqLSQltxaaBvDQv2Cn2odIdb0EKVLa5FSxby94hAFA7YoaDo7zSKbs
         Iiiwl83yeRA7v61tNxCI0tBV31b+QYgs2VjATcmx2qH7B9MtMdHTM1mqsHmmDmsEcDPP
         2sTKXAylnTnWaLhlUKNQ/1NnXcn7LULju5I30j7LyrGJG7scZyF3IQ7sxpDPp9qFWF6p
         pLpJqCH2viLiZWmy7OF+GNrupA5fecRTpZ7yd8EMoH1rEx+eGTML0MQlH3+hjI4eV80b
         FyRqEXJXFnEqmJKwI040BGJM4U7VPq/4VuqVV8FFFY+pl8vhQdHqvkzp4OyriOJCy+Ru
         21jA==
X-Forwarded-Encrypted: i=1; AHgh+RqGxLuF7CPZ8SthDbMUQ1gf1muiJh47CaEkf499g9VjBtUT33Tfp9fvSx26RoSGwa1HTJhOd8Tn43XOUhcUclYo578=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7fekYVMHzH8kok0gktyF3hrC3ofd/ES42suIGuLHqcushJeUE
	RqFa75OljhSfgbiyY+19EJB6Nwz5ZYRf15Ci3VfSiWsqwQOi8VtE3GGS9HJXrgPJt6OqpQ7VTe/
	axGta8W6eJj5aS3LbRk6Daw==
X-Received: from wmbb14.prod.google.com ([2002:a05:600c:588e:b0:495:4a25:69f7])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f4a:b0:499:51f0:a9b2 with SMTP id 5b1f17b1804b1-49959e0179bmr50513235e9.1.1786050801122;
 Thu, 06 Aug 2026 14:13:21 -0700 (PDT)
Date: Thu,  6 Aug 2026 22:13:05 +0100
In-Reply-To: <20260806211306.3704194-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806211306.3704194-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260806211306.3704194-6-vdonnefort@google.com>
Subject: [PATCH 5/6] ring-buffer: Dynamically calculate max_data_size
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
index 3531005aab43..d2480ccc81b8 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -587,7 +587,6 @@ struct trace_buffer {
 	struct ring_buffer_meta		*meta;
 
 	unsigned int			subbuf_order;
-	unsigned int			max_data_size;
 };
 
 static inline unsigned int rb_subbuf_size(struct trace_buffer *buffer)
@@ -600,6 +599,17 @@ static inline unsigned int rb_subbuf_capacity(struct trace_buffer *buffer)
 	return rb_subbuf_size(buffer) - BUF_PAGE_HDR_SIZE;
 }
 
+static inline unsigned int rb_max_data_size(struct trace_buffer *buffer)
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
 static inline unsigned int rb_page_capacity(struct buffer_page *bpage)
 {
 	return (PAGE_SIZE << bpage->order) - BUF_PAGE_HDR_SIZE;
@@ -2745,9 +2755,6 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 	buffer->subbuf_order = order;
 	subbuf_size = (PAGE_SIZE << order);
 
-	/* Max payload is buffer page size - header (8bytes) */
-	buffer->max_data_size = rb_subbuf_capacity(buffer) - (sizeof(u32) * 2);
-
 	buffer->flags = flags;
 	buffer->clock = trace_clock_local;
 	buffer->reader_lock_key = key;
@@ -4914,7 +4921,7 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	if (ring_buffer_time_stamp_abs(cpu_buffer->buffer)) {
 		add_ts_default = RB_ADD_STAMP_ABSOLUTE;
 		info.length += RB_LEN_TIME_EXTEND;
-		if (info.length > cpu_buffer->buffer->max_data_size)
+		if (info.length > rb_max_data_size(cpu_buffer->buffer))
 			goto out_fail;
 	} else {
 		add_ts_default = RB_ADD_STAMP_NONE;
@@ -4989,7 +4996,7 @@ ring_buffer_lock_reserve(struct trace_buffer *buffer, unsigned long length)
 	if (unlikely(atomic_read(&cpu_buffer->record_disabled)))
 		goto out;
 
-	if (unlikely(length > buffer->max_data_size))
+	if (unlikely(length > rb_max_data_size(buffer)))
 		goto out;
 
 	if (unlikely(trace_recursive_lock(cpu_buffer)))
@@ -5136,7 +5143,7 @@ int ring_buffer_write(struct trace_buffer *buffer,
 	if (atomic_read(&cpu_buffer->record_disabled))
 		return -EBUSY;
 
-	if (length > buffer->max_data_size)
+	if (length > rb_max_data_size(buffer))
 		return -EBUSY;
 
 	if (unlikely(trace_recursive_lock(cpu_buffer)))
@@ -6495,8 +6502,9 @@ unsigned long ring_buffer_max_event_size(struct trace_buffer *buffer)
 {
 	/* If abs timestamp is requested, events have a timestamp too */
 	if (ring_buffer_time_stamp_abs(buffer))
-		return buffer->max_data_size - RB_LEN_TIME_EXTEND;
-	return buffer->max_data_size;
+		return rb_max_data_size(buffer) - RB_LEN_TIME_EXTEND;
+
+	return rb_max_data_size(buffer);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_max_event_size);
 
-- 
2.55.0.654.g21b8a5bc05-goog

