Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0CB3F7869
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420326; cv=none; b=Awh3GdAH5Li136qWYt3fP7iXDhYCmBRBpG2a4/PeaoHxBR0lP80/SDgvyh7kCG0SGyHudkuBreXJPAo+A024bsJxOqLzdSo0p1QhSqV5FUVsYRn2trzQj53snMkVn+qt836NWQUG9ZIEhw4A76FGgcvOlgM2WMPUECxD3cLsfUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420326; c=relaxed/simple;
	bh=Q30wfvwfRpbHDg6rxGmsrkKyehqPNoJREGvcRn4VEiQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ilfKONKQurmgSHZBNMNXbfxYhOO9+jLo4an4RHxIf8oNVlGn6277ydEhbC3U7xorPUitdoftIBnShwUyhZWiZ5xkwhpWXB9UK5Ge1SMuSzAXeYkKp+iu8cfLwmW8hWnkOR/gJRr+oOHfk1xbMqd/7Pcta8V1QZ/+AfOFGOo7Js4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M0CkdZS6; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M0CkdZS6"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490479c2911so119103785e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 10:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780420323; x=1781025123; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U6YpLWln6rNYg8goMmTtQg8dewg16u+Xzw0q2j6WzZM=;
        b=M0CkdZS6izF4YtnkLDSKO1ix8Z8pFdMBJIsxSohLmWYiXmaKmisOXFX2vefne9eK5t
         P83oO5XhlTORdAb0vTFM0ALlINz58/CJpRfNW2RDSOMUD8kFhvBjjTG+g95dBSaL9Abo
         qBHa0s9ZwLyE1Nupkx9NVAj847gBVXGmwUEASYLH/ctYfSfUKSmEcrjIvDzG0eYMhTEJ
         nM2/ZSUYOdA6cniX8rtKZ7sKSRZmtRD8FC6XLN84jw4rQ7UAnpJxs6FKMGmSBF7P2uv4
         RkhJ39Ct0o/OieiQ/CfKarlYVSQoFl8xKvpUcNy0HTjxTbcUJasV1K6i/a23NwvKWhsW
         43VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420323; x=1781025123;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6YpLWln6rNYg8goMmTtQg8dewg16u+Xzw0q2j6WzZM=;
        b=CicHZJ4zooeQmvUjaI+Ug3Xz3IUFGBaqo583ByObiYO+FsL4XlcYq3iro/w5FAnio+
         r4h0CzR3PsBxVzQ2bwJLdy4ZAB87N3Vmp/oKGTPLIUt4GKySmyA1MN8RG8+Gdhi5sddG
         ZHjUmelguN5IfQs56OwPVus4p/r3Pxrr692CxvybyxenYG+AahphF1UQLR1FiQ92++J9
         ExHPoR2iROEa2niTZ5mdoc6HvLFWUidVt70gtqBJ8jyAAw7tKKwHEMguWALbDRlv4KkF
         fEQSsoIMOX58w6sEARFWzMpzXBKwrtQTuQDVRNQGk7MNfanQ3BcgMpE/wmLgdW932xee
         dRhg==
X-Forwarded-Encrypted: i=1; AFNElJ8x4vDglu9hgzMLwp0bqDkicewK8BPVmYZ+7wUu1KreGmkmi9zFkpIi6rLV5fp71LUJllBOdFNJFYBAyXSq1Jgtz5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdoV5jSPqhfNI0fGI0LU50ZLB2P+Oc7kcjN1WP5xoz4PqzVZV9
	iy4QwHlcZaC5l2hDFa2AmWJ5dyEW376uOvTwnK/ycnryttQdwp2UI4PkVMBxVCWuST/eubAoRiP
	1o7fYNRe98pt+jQAkcrRjLg==
X-Received: from wrxc12.prod.google.com ([2002:a05:6000:104c:b0:451:b0e6:cf33])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5394:b0:490:b0f1:c27e with SMTP id 5b1f17b1804b1-490b50b2b54mr10704585e9.24.1780420323397;
 Tue, 02 Jun 2026 10:12:03 -0700 (PDT)
Date: Tue,  2 Jun 2026 18:11:36 +0100
In-Reply-To: <20260602171146.2238998-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602171146.2238998-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260602171146.2238998-5-vdonnefort@google.com>
Subject: [PATCH 04/13] tracing/simple_ring_buffer: Add support for compressed length
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The array length is the total size in bytes of the data for the current
event. It is possible to compress this value into the event header type,
which has 28 unused types, saving 32 bits for sufficiently small events.

The compressed length is expressed as a multiple of the ring-buffer
alignment, 4-bytes by default. Enforces this alignment.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring_buffer.c
index f4642f5adda3..6be4aa19adca 100644
--- a/kernel/trace/simple_ring_buffer.c
+++ b/kernel/trace/simple_ring_buffer.c
@@ -207,7 +207,12 @@ static unsigned long rb_event_size(unsigned long length)
 {
 	struct ring_buffer_event *event;
 
-	return length + RB_EVNT_HDR_SIZE + sizeof(event->array[0]);
+	length = ALIGN(length, RB_ALIGNMENT);
+
+	if (length > RB_MAX_SMALL_DATA)
+		length += sizeof(event->array[0]);
+
+	return length + RB_EVNT_HDR_SIZE;
 }
 
 static struct ring_buffer_event *
@@ -223,12 +228,15 @@ rb_event_add_ts_extend(struct ring_buffer_event *event, u64 delta)
 static struct ring_buffer_event *
 simple_rb_reserve_next(struct simple_rb_per_cpu *cpu_buffer, unsigned long length, u64 timestamp)
 {
-	unsigned long ts_ext_size = 0, event_size = rb_event_size(length);
 	struct simple_buffer_page *tail = cpu_buffer->tail_page;
+	unsigned long event_size, array_size, ts_ext_size = 0;
 	struct ring_buffer_event *event;
 	u32 write, prev_write;
 	u64 time_delta;
 
+	event_size = rb_event_size(length);
+	array_size = event_size - RB_EVNT_HDR_SIZE;
+
 	time_delta = timestamp - cpu_buffer->write_stamp;
 
 	if (test_time_stamp(time_delta))
@@ -259,9 +267,13 @@ simple_rb_reserve_next(struct simple_rb_per_cpu *cpu_buffer, unsigned long lengt
 		time_delta = 0;
 	}
 
-	event->type_len = 0;
+	if (length > RB_MAX_SMALL_DATA) {
+		event->type_len = 0;
+		event->array[0] = array_size;
+	} else {
+		event->type_len = DIV_ROUND_UP(array_size, RB_ALIGNMENT);
+	}
 	event->time_delta = time_delta;
-	event->array[0] = event_size - RB_EVNT_HDR_SIZE;
 
 	return event;
 }
@@ -284,7 +296,7 @@ void *simple_ring_buffer_reserve(struct simple_rb_per_cpu *cpu_buffer, unsigned
 
 	rb_event = simple_rb_reserve_next(cpu_buffer, length, timestamp);
 
-	return &rb_event->array[1];
+	return rb_event->type_len ? &rb_event->array[0] : &rb_event->array[1];
 }
 EXPORT_SYMBOL_GPL(simple_ring_buffer_reserve);
 
-- 
2.54.0.1032.g2f8565e1d1-goog

