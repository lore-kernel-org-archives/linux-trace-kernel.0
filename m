Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226233DA7E4
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366633; cv=none; b=CUwYMk/ea64ZuzTSH21hbmDdfTdD7hnlJIDLiCQVkQEee98IvnWdE2EpTtlr+O/oUv/nxt/b0Hh9xXpvx65x64EsEvAHCm9kj3cn8xIGV3Y59FP4W0kGO2aH/XHNOYLcz3h+Z4war6Xa4zzcJRPtBAkukrMmhRPN1ZWtJd0cWRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366633; c=relaxed/simple;
	bh=HnuPv5w82kLrjAtpZAgJdR0Ka68bREO/g7+O+QPiR7k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Drvdo+b3DsqzwSPT59NSzb1jZD4ZMvr7ScCOy+ApBqqVAPGgec4Rjyd8d+IIW6p9H27Cu16BlhBF8XgLJT4t0B9kHcyAzAOWjLZHg0Xvz2LUj7DgCi6bJPdA8coKjLjqSXAZ64RfEjQq5e2yw700x48Bf9e+kFqTZQcV4dAVZrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kN+JWs+C; arc=none smtp.client-ip=209.85.221.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kN+JWs+C"
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f84ac1990so1398527f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 05:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786366630; x=1786971430; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DRyjIzp7u1CLzE+pgWjrfw6hI8EsXd45V/o+2avGbBo=;
        b=kN+JWs+CyQHo07AWTSpXhz+AsOPn5Xa/Ux/Fy/peKLFadGbpjsq3wftqrM0vOmCEHz
         kRVbwDojmrcb49DqbfS9512341edJiDctYzg4M6K8y1H0aQiykFxtWOpArCm6CZbzTe+
         wymdIWGqYjymjHpMkoGPJ5qcR1aRG6nOnYg4IExuZwm3tgTe4mqTsGga2ImrQ6YcT0a9
         T76WNSb/0msaQjwZhsi1sRRn0uNax4Odqd/ZOO4LBa1wrmzL4E+RICNe1BdJ+Y9woDoO
         Jr5pW4iBZm+ysshPS8uDqwYdbsqtt9wxweTYjJMFv/ZG/KnNVxUIVDG1c3abcxZ/uTA+
         RswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786366630; x=1786971430;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DRyjIzp7u1CLzE+pgWjrfw6hI8EsXd45V/o+2avGbBo=;
        b=qhgCd3DHafmcPGsE2kqACEOcK1yrm222jH6huFZXBnzJorQT+ToX45j5iws0XE9AFv
         PCnLsDbukDUd8duJ9td2JY1R7b7ZwqqaA0mLSv45i/DsgXkCpgGcN+MMCDosjYs1C80q
         qS4wfPtr7SgoFrL9v3/D+40q8w/TCnBEjuVzvfXesVHtm9wd8yo3Ta21uSpyKh3l8USG
         OW4IzBqdGl9j5x5ZioWRRbmMaaxFlO9zWuX5bzKTxX3JtCJfXh2UovXHlr3MjpmDHr2r
         yEZNKFx7GkgyjyVhiUFWz6xo+WUreEMfcSYUhqG4+1mJ6tBgzPF+zzNaATAWpZG16EzY
         0LdQ==
X-Forwarded-Encrypted: i=1; AHgh+RoV46crEh1lJkV7/5MwHaNcOVE+wxiS0/6izO6eIPNQ1MytADJbK6XuLVBqys+SeeCaiWMriZJVBpiYAwcT10Xi52Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Kvhnjs0YELMUYIcM+Mctl7yI3de4mkMAh18DeHGdxf6hM1zN
	v7IToKovVpVOfw9amdY+DobMEXhuVNj6w7zUdYYE9LLqdZGKx/+0Y8lzOkO8LADwpBUEyPcQotz
	asnnEmEZ6HhPt+rj21cAdbg==
X-Received: from wmba2.prod.google.com ([2002:a05:600c:6dc2:b0:492:45de:dde6])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3548:b0:498:8e6:d464 with SMTP id 5b1f17b1804b1-4995e0def7bmr304428285e9.14.1786366629236;
 Mon, 10 Aug 2026 05:57:09 -0700 (PDT)
Date: Mon, 10 Aug 2026 13:56:29 +0100
In-Reply-To: <20260810125633.3344684-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810125633.3344684-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260810125633.3344684-3-vdonnefort@google.com>
Subject: [PATCH 2/6] ring-buffer: Dynamically calculate max_data_size
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
index 29901668e18c..026658c70351 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -592,7 +592,6 @@ struct trace_buffer {
 	struct ring_buffer_meta		*meta;
 
 	unsigned int			subbuf_order;
-	unsigned int			max_data_size;
 };
 
 static __always_inline unsigned int rb_subbuf_size(struct trace_buffer *buffer)
@@ -605,6 +604,17 @@ static __always_inline unsigned int rb_subbuf_capacity(struct trace_buffer *buff
 	return rb_subbuf_size(buffer) - BUF_PAGE_HDR_SIZE;
 }
 
+static __always_inline unsigned int rb_max_data_size(struct trace_buffer *buffer)
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
 struct ring_buffer_iter {
 	struct ring_buffer_per_cpu	*cpu_buffer;
 	unsigned long			head;
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

