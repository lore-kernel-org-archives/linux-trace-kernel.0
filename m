Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6624C51E442
	for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Sep 2026 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788858585; cv=none; b=pNBr3hF+FcJIjVQ3qvO1Ob9RhtEsAON6tSgDRrCLkbpXM6FFMNFybkok4abOO8H8YB4m8dZ5WNcqt4WXQZpsbmEAwoQqnfBDxrw/+IWSHUnL0x+UK68df94SQ4xQ397D0qdgHzma8veLwgsLAzRib/CJkYU8SofAZiN9+QhbUM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788858585; c=relaxed/simple;
	bh=p3zxjl8ilnmwnpnClhmv1lhN3YDJUhyC84MjPboOZ1U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rxmr0SSkaFuPN/rEMYJ0LrFoZqX+40S94OtziLmIqRnsL8LzI4uxo91s2HfsX7hwyll2te9Y/p1QtUDloRhkm6taLFcB6+tF0rr0McjKiogpIKGBRGErRfJWXfum2JTQbxy0cXTgcIiMWAVIHI6LBhY/BAIp8L0wCoxhgYGbYmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rUaLFt3A; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rUaLFt3A"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49cd83ca361so48747335e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 08 Sep 2026 02:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788858581; x=1789463381; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xlqGezA/G2NBw7aCDWm+M8LEXnlo9JX1bDlA7KCRjqc=;
        b=rUaLFt3AMfIurdgKG1L8I6QO9ZjzK+Vhg4JuFawU461AO6KhABhWZObVwyYnUybbuL
         hGIfLuT+c3it/Y+2I4UY12r9B/Jp5bNm3RMCh1ttkmVjYl2OKxuwfdHKmdZiOlKJUMXR
         jSrnwkh8M8FvU4FcEkRgGXo60LOJIzS4K53bSbDMSwss0i1s7M7qcipayB0DpsrmkwGS
         08lJ5waAaUyEEYm4nM1WnhS7qJa330ECEFJsiNX4DGUKCZFlyXdPESR7+aT5nw3lpv8R
         L0QAKCily8BbsrBeYlB9kCZaT3rHRVjEWsxZndZccaP78A2avYm36DiJoPWFpxsDlrNz
         GKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788858581; x=1789463381;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xlqGezA/G2NBw7aCDWm+M8LEXnlo9JX1bDlA7KCRjqc=;
        b=EXq81A76EFwaU5z5/SZEinrLnm/xZAgwa3UWuHnYPTYUJXSQ+HiQIu99KtjNq/DPD6
         3Yh1fhHhuRfWAww81fipMfQ38R2aaCIRd5iD9z5Z2DTmR/WUy8sfelHIEM3T6alh1ZAV
         mk31ZgupZOsQEEKOI0qo1JiglM8MlEU/ki4v8sD18HTrblz+8QDoxM5zMOKfnd/qXJJR
         4W2kT+FVsDGmMI5Jd6r2oiu0PLm7IaUqHYuc60ELJgIrxt44cNL8yFwK/CG8VIyPnby0
         mVCke+qfWYIJALpmImfJF4WcrUPFWQfykbG5JdeoAtQ7fFFmrzI9Lk/WUGJG5OHiF2+O
         F32A==
X-Forwarded-Encrypted: i=1; AKwUvBzMQGFlgnYB2XzmSg4khVPOXpzm1dRabY4fbHiYHvXgd3kgo7m3YFg+L2ZIQCBbmYPS7vnYP0Pixpl/O9R9Z3740jg=@vger.kernel.org
X-Gm-Message-State: AFuF++lcVa79YDhEead+XXdNXfi3UlUM+kxm1SPxRh4pQuW0UpXS5B7M
	Idsd6LMwAYOOiAtDmwE1Orwn35NzJImpqDi0D0ZY6PIwFFyb7/rKxHlGTz3rAP6TYPwh8XI6bj3
	SESsAJ6KGv8Z4MTKEOTIi1A==
X-Received: from wmnv20.prod.google.com ([2002:a05:600c:4454:b0:49b:51c5:e9b2])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e06:b0:49c:fc6c:be1b with SMTP id 5b1f17b1804b1-49cfc6cc0e9mr221475155e9.33.1788858581136;
 Tue, 08 Sep 2026 02:09:41 -0700 (PDT)
Date: Tue,  8 Sep 2026 10:09:35 +0100
In-Reply-To: <20260908090937.838544-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260908090937.838544-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908090937.838544-2-vdonnefort@google.com>
Subject: [PATCH v2 1/3] ring-buffer: Rename ring_buffer_size() to ring_buffer_capacity()
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Since commit 8a5f63637890 ("ring-buffer: Fix subbuf resize race with
ring buffer readers"), "capacity" refers to the memory available for
events (excluding subbuffer headers) while "size" refers to the raw
allocation.  ring_buffer_size() actually calculates this event capacity.
Rename it to ring_buffer_capacity() to align with this convention.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 include/linux/ring_buffer.h |  2 +-
 kernel/trace/ring_buffer.c  | 13 +++++++++----
 kernel/trace/trace.c        |  6 +++---
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index afc7daa6ee7d..9e23ab66176b 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -165,7 +165,7 @@ void ring_buffer_iter_reset(struct ring_buffer_iter *iter);
 int ring_buffer_iter_empty(struct ring_buffer_iter *iter);
 bool ring_buffer_iter_dropped(struct ring_buffer_iter *iter);
 
-unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu);
+unsigned long ring_buffer_capacity(struct trace_buffer *buffer, int cpu);
 unsigned long ring_buffer_max_event_size(struct trace_buffer *buffer);
 
 void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9c03a555a6ba..cd1ee3ca6f46 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6547,18 +6547,23 @@ void ring_buffer_iter_advance(struct ring_buffer_iter *iter)
 EXPORT_SYMBOL_GPL(ring_buffer_iter_advance);
 
 /**
- * ring_buffer_size - return the size of the ring buffer (in bytes)
+ * ring_buffer_capacity - return the capacity of the ring buffer (in bytes)
  * @buffer: The ring buffer.
- * @cpu: The CPU to get ring buffer size from.
+ * @cpu: The CPU to get ring buffer capacity from.
+ *
+ * Capacity is the total memory available for recording event data in the
+ * ring buffer. It excludes subbuffer headers.
+ *
+ * Returns the capacity in bytes, or 0 if the CPU is not set in the buffer mask.
  */
-unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
+unsigned long ring_buffer_capacity(struct trace_buffer *buffer, int cpu)
 {
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return 0;
 
 	return rb_subbuf_capacity(buffer) * buffer->buffers[cpu]->nr_pages;
 }
-EXPORT_SYMBOL_GPL(ring_buffer_size);
+EXPORT_SYMBOL_GPL(ring_buffer_capacity);
 
 /**
  * ring_buffer_max_event_size - return the max data size of an event
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8658cad53cb5..f0251788ec75 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4712,9 +4712,9 @@ void trace_set_buffer_entries(struct array_buffer *buf, unsigned long val)
 static void update_buffer_entries(struct array_buffer *buf, int cpu)
 {
 	if (cpu == RING_BUFFER_ALL_CPUS) {
-		trace_set_buffer_entries(buf, ring_buffer_size(buf->buffer, 0));
+		trace_set_buffer_entries(buf, ring_buffer_capacity(buf->buffer, 0));
 	} else {
-		per_cpu_ptr(buf->data, cpu)->entries = ring_buffer_size(buf->buffer, cpu);
+		per_cpu_ptr(buf->data, cpu)->entries = ring_buffer_capacity(buf->buffer, cpu);
 	}
 }
 
@@ -8476,7 +8476,7 @@ int allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int
 
 	/* Allocate the first page for all buffers */
 	trace_set_buffer_entries(&tr->array_buffer,
-				 ring_buffer_size(tr->array_buffer.buffer, 0));
+				 ring_buffer_capacity(tr->array_buffer.buffer, 0));
 
 	return 0;
 }
-- 
2.55.0.979.g7e5102b832-goog

