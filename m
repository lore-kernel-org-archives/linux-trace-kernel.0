Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492896;
	b=U33DWDzkx1dJD8E6pAdJfADCBbYSD3FFvK2rsIEdRr1s+qyMZcZt0g0IoXON8ACOWtUg
	 bwEhmsuKkiMkAn1fVo9Mb6//ifSagA2s4JCQIMOi++p5eaoDRNp3zhHjUIDOy8iijBKom
	 kvYQa0ZPniZnuP4cu54h5aPPiIfyZjUHIsmdG2eoI1GSeA0GDoUu5SjQOWa80UD+VQTgX
	 yo1VlXsOpNL1b3o5UFC3+B7cdWMnogA4DDM1oUmp1pTQGxSkbRfi6QoPMspfHJ0P6A6cC
	 FlcByH91BUSXIskhJGlpvOge0Xo79r7Oqjx5wIdbP7cBSK6tgL2PkYjFM7hgcAkLDZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492896;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=O56ZQfqWB5aX6ZB7RcIEU+Nqg1mDJyhodrAqIyNtFBQ=;
	b=lqSofzdAmtXGsJ2HtwDCv4ON5l8WuuySnopuLWOb3gMfMHxIfeTpKHcjywweNVL16niU
	 5R36tXjFOk8eEdae47v6rO9Dm9di2HzCXNfon5+3HemSmNY/03Kns01hvKBPWOwxFP4zX
	 0gzF9c/NrG6+ZAlxAqYkvnQco+JDRk2yRjmr6kEYiX/ovdoCTYm+HbEfZdzQi52rl216z
	 O1i6RsT4+Z2Lwerm0nCNcNkm9SejAnrN2vLgR+QgOdF2wHwT+RVg+S1Kz+f1yy961Mfcp
	 J+IrKiJuvlsunrGXoiUfK6jvWDtOMT+PA/raDE/EFbFGqEgDjs4CKOVD/aJPmDsRqSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="TFLVI/3f";
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413AE606A8B8
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 14:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 413AE606A8B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TFLVI/3f
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a359b714f8so33276075e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 06:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794492895; x=1795097695; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O56ZQfqWB5aX6ZB7RcIEU+Nqg1mDJyhodrAqIyNtFBQ=;
        b=TFLVI/3f8Un7nDd2xva8NW7C51ujpEGmf0rm4NH9swHZV04Rti9q8ZUDyXfkxU/Xjb
         VR9IGllStHG4pVbmu/k3cYhvBHYf/Y/WARRodAVr30n257IciuwIq+Mzc59ySxBbcrwX
         rJpBq2lu2CEMM2OrS2ydre4dWQt/mAvkU0SxjOEhxPQuH9PLVcCpasBPMd+74apC8/V7
         CKtjhsXuKZwurFoLPw16dJ1CPeGpIyD3sg6Mz09eL+hwT3Zzq1cHIlKwQcmVv1lQFhum
         2KFAyH4P0BmWeT5LZf1bfv2a2wR8/GobVgKDiTmRhzl7mgstJCZONsjhh8hhH/NhT6KN
         Tv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794492895; x=1795097695;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O56ZQfqWB5aX6ZB7RcIEU+Nqg1mDJyhodrAqIyNtFBQ=;
        b=ST/gy3KHfH0yIZmfkAiJaM19GhAUR6Xg6zy79ogOj1GRZCjVD94P+VGmyHPruY3Vie
         ql9IHdWu8kGT5cgd1pGAsRK//HJzbpUJYB+UftjlY1JA6j1JOwzKPxqhmBp6hjxLRAKR
         nQjgrPrwR+3I8EGmRegfIv1JNsi1+nh+voDiNZqEyB+dK4Hoja8q0ew2otHfPYF5r+KR
         Bi6sCmRViXcm/VKJKBriVZdY4Rn9qDAhenhlFQwGw8wjm3oMUpXeJ63mCsiTge93OmOu
         D+M2ANfFAwtMbhk2IIZ1ZPsaJP5b51L2OaFZUzYUjwiYN3SiDFcXWcuH10Wc+yi6z6zf
         x8Ig==
X-Forwarded-Encrypted: i=1; AL+hErGMjFt/XTvxVIwBL5zpaRcNz8zutHi0/DuuNLrjm86sktX5CniFufRtc7CEUejVLESTtyokGu4dsTwtLtmk0iHyzcI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kAaIxJ2YboFnz3IERKBt0Nxmrg2yjJNz9G+oaN/NvMsh3dH3j
	6BZqvgYnurpAjeItrSEMCCiChieAUPSo7YO5QKgyoOMSE2Bml57iCHx22HYNWoUH+HUCdx3DToQ
	jDGZZBDgyI1nW/OCin9hkfg==
X-Received: from wmbz21.prod.google.com ([2002:a05:600c:c095:b0:4a1:f80d:2f25])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:46c5:b0:4a1:825a:56fd with SMTP id 5b1f17b1804b1-4ba093ab88emr111149475e9.32.1794492894569;
 Thu, 12 Nov 2026 06:14:54 -0800 (PST)
Date: Thu, 12 Nov 2026 14:14:36 +0000
In-Reply-To: <20261112141440.3050124-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261112141440.3050124-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112141440.3050124-6-vdonnefort@google.com>
Subject: [PATCH v1 5/9] ring-buffer: Validate event length against rb_page_capacity()
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In rb_reserve_next_event(), the absolute timestamp path compares length
against rb_subbuf_max_data_size(). The latter subtracts the event
header while rb_calculate_event_length() already accounts for it, which
incorrectly rejects valid reservations of ring_buffer_max_event_size().

Compare against commit_page capacity instead so event headers are
accounted for consistently on both sides. This check also applies to
normal timestamp mode, so share it across both paths.

In rb_reserve_next_event(), commit_page is stable and avoids accessing
the mutex-protected buffer::subbuf_order, rendering the early calls to
rb_subbuf_max_data_size() in ring_buffer_lock_reserve() and
ring_buffer_write() unnecessary. Drop them.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 44 ++++++++++++++------------------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 80f500ffd7ac..9834f9dae440 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -625,23 +625,6 @@ static __always_inline unsigned int rb_subbuf_capacity(struct trace_buffer *buff
 	return rb_subbuf_size(buffer) - BUF_PAGE_HDR_SIZE;
 }
 
-/**
- * rb_subbuf_max_data_size - Get the maximum payload size of a single event
- * @buffer:	A trace buffer
- *
- * Return: The maximum data payload size that can be stored in a single event.
- */
-static __always_inline unsigned int rb_subbuf_max_data_size(struct trace_buffer *buffer)
-{
-	struct ring_buffer_event *event;
-
-	/*
-	 * surely rb_subbuf_capacity() is bigger than
-	 * RINGBUF_TYPE_DATA_TYPE_LEN_MAX (see ring_buffer_event_length).
-	 */
-	return rb_subbuf_capacity(buffer) - RB_EVNT_HDR_SIZE - sizeof(event->array[0]);
-}
-
 static unsigned long rb_calculate_nr_pages(struct trace_buffer *buffer, unsigned long size)
 {
 	return max(DIV_ROUND_UP(size, rb_subbuf_capacity(buffer)), RING_BUFFER_MIN_NR_PAGES);
@@ -4143,7 +4126,7 @@ rb_update_event(struct ring_buffer_per_cpu *cpu_buffer,
 		event->type_len = DIV_ROUND_UP(length, RB_ALIGNMENT);
 }
 
-static unsigned rb_calculate_event_length(unsigned length)
+static unsigned long rb_calculate_event_length(unsigned long length)
 {
 	struct ring_buffer_event event; /* Used only for sizeof array */
 
@@ -4986,12 +4969,13 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	if (ring_buffer_time_stamp_abs(cpu_buffer->buffer)) {
 		add_ts_default = RB_ADD_STAMP_ABSOLUTE;
 		info.length += RB_LEN_TIME_EXTEND;
-		if (info.length > rb_subbuf_max_data_size(cpu_buffer->buffer))
-			goto out_fail;
 	} else {
 		add_ts_default = RB_ADD_STAMP_NONE;
 	}
 
+	if (unlikely(info.length > rb_page_capacity(cpu_buffer->commit_page)))
+		goto out_fail;
+
  again:
 	info.add_timestamp = add_ts_default;
 	info.delta = 0;
@@ -5061,9 +5045,6 @@ ring_buffer_lock_reserve(struct trace_buffer *buffer, unsigned long length)
 	if (unlikely(atomic_read(&cpu_buffer->record_disabled)))
 		goto out;
 
-	if (unlikely(length > rb_subbuf_max_data_size(buffer)))
-		goto out;
-
 	if (unlikely(trace_recursive_lock(cpu_buffer)))
 		goto out;
 
@@ -5208,9 +5189,6 @@ int ring_buffer_write(struct trace_buffer *buffer,
 	if (atomic_read(&cpu_buffer->record_disabled))
 		return -EBUSY;
 
-	if (length > rb_subbuf_max_data_size(buffer))
-		return -EBUSY;
-
 	if (unlikely(trace_recursive_lock(cpu_buffer)))
 		return -EBUSY;
 
@@ -6575,11 +6553,21 @@ EXPORT_SYMBOL_GPL(ring_buffer_capacity);
  */
 unsigned long ring_buffer_max_event_size(struct trace_buffer *buffer)
 {
+	struct ring_buffer_event *event;
+	unsigned long max_data_size;
+
+	/*
+	 * surely rb_subbuf_capacity() is bigger than
+	 * RINGBUF_TYPE_DATA_TYPE_LEN_MAX (see ring_buffer_event_length).
+	 */
+	max_data_size = rb_subbuf_capacity(buffer) - RB_EVNT_HDR_SIZE -
+			sizeof(event->array[0]);
+
 	/* If abs timestamp is requested, events have a timestamp too */
 	if (ring_buffer_time_stamp_abs(buffer))
-		return rb_subbuf_max_data_size(buffer) - RB_LEN_TIME_EXTEND;
+		return max_data_size - RB_LEN_TIME_EXTEND;
 
-	return rb_subbuf_max_data_size(buffer);
+	return max_data_size;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_max_event_size);
 
-- 
2.56.0.567.gdb80ae8cd5-goog

