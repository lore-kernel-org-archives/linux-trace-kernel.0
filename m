Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253C23DD852
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366637; cv=none; b=rXIo5VBhN6uliV/9hIrUEESVnYoKAal3V1qHaAF9dwazN4dKTvYZVbuDu+gTCMOopuA3QA16lPPmo4s4LNXjmMDArelSA8Hvfpu46LSNkuAjLTnuwtA6BJuRWCX0GcgNLf0T2bZBrP2baxsOkU0fNw8DvdDOtfB83HaEfG370Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366637; c=relaxed/simple;
	bh=pZRo7TDd7lyTr7a8dOBB3n71J4EdNoyHbZYkWkj2E8Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l8tvz8R6CefzWsPFTwea0OLgtyURgk1vjXkuJ5VbUhWLQij16kY57B+OkQ1nZbFAL5rnd8K74hP67RA2adycWRyFoI5fQnSulVks0MHuZk3MQwthAqOz5Lt0Ojv05ZcTxh4tftSj8jmVSiYP5DNyebIQGoQA2AimDp4I0UrNYqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wU/7mNyu; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wU/7mNyu"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49953abe51fso12035405e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 05:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786366633; x=1786971433; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SMao/WVwF3T9yILBUBhkEFjiJHWhusBInRu64gug9oo=;
        b=wU/7mNyuS0QfOXD/pljsCO5kKs6yk/aIuOyxH5VUOOB7ZLMuS0KCtNkRLN2Du+EYwH
         F6lcG3iEEwI+uVIslxbwD6OKdYXUXt9uI/jb5/aBk64khfiAvvdIfl1acQ6QKBGYffcB
         2gB0q0vv89BitBcLPzTfEJ1JS6vW2ve2+Z3bhaH7fX7KhB9gmWzcQqRnIxsmMhnxXJQn
         MhTUXfq6GNA1L9shKcMHoOJeBGKAvTNLRrfIUsDiuLFIlQsk5Fb4RN2b2RgwVg9Lq0QZ
         88csFsTX2RzVtRrIFCaYtLy+DYG4IgmCfOCiQWqZ5uUebe95KI4UlBG4YAqslpkuKbjy
         ni2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786366633; x=1786971433;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SMao/WVwF3T9yILBUBhkEFjiJHWhusBInRu64gug9oo=;
        b=QGUZRiTNi9slbUqvSXvLBLyzkkcMFts4xNVJv3M9cI2ioeBFFhgM+RbbE7EilJJXjm
         1e0TRfMqdHJrgXcnF0jazpsauvxNePitIjG82BOAecfyDMdIgRxW6XC/ow0CqoIe+GrS
         2wuBMzzMU6ZGvTHQQYnm2rC+EN685CCfGEVPkhOgVavGuiZKN6o1hp0EU3mxXI2LJiwM
         sFhI3XqA66PIqfih43n1zbdBLcqLOVv3p/jD6N8Le4qCJBj2O5/h7z2ZvTjtA8hj3oZc
         4ppRZa7ehbQiGFNcA++6mupt7XnxsrFAHuS/IGwrFDh27jmv6lu9Lq8np8wLjn1xs8il
         0HtA==
X-Forwarded-Encrypted: i=1; AHgh+RpH3l/FbADY+8IWv6bIJoYKYN3ZWnopG4zUDAV7Ctu895uHFGqiIUnbUX+LsNtb5Yw8vJfLO3ZRu1n0VbejPXq7vOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YysEuM4yZ02HgPH0zNZ/bBu7MxoHmc05ykcv0rnOr1UfmtWb8kW
	syxW0Zvnllrh/QXam89MRZ5e64UQElJSJ2GpuXjKODSlHs8C22pMZneAUUFgAGsgn1qorOVS7D8
	B0WYkrgiCOgVab1EGB8yOqg==
X-Received: from wmjx24.prod.google.com ([2002:a05:600c:21d8:b0:492:1eeb:6111])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e93:b0:499:49f3:77b1 with SMTP id 5b1f17b1804b1-4996193f165mr272364555e9.3.1786366632716;
 Mon, 10 Aug 2026 05:57:12 -0700 (PDT)
Date: Mon, 10 Aug 2026 13:56:32 +0100
In-Reply-To: <20260810125633.3344684-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810125633.3344684-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260810125633.3344684-6-vdonnefort@google.com>
Subject: [PATCH 5/6] ring-buffer: Remove ring_buffer_per_cpu::mapped
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

ring_buffer_per_cpu::mapped tracks if a ring-buffer is either mapped by
user-space or if it is a persistent buffer. We already have user_mapped
for the former and ring_meta for the latter. Get rid of mapped and
instead create rb_is_static(). A static ring-buffer cannot be resized,
swapped or have its pages extracted.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index d128bda5b661..8dae55ddbe15 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -508,7 +508,7 @@ struct ring_buffer_per_cpu {
 	int				cpu;
 	atomic_t			record_disabled;
 	atomic_t			resize_disabled;
-	struct trace_buffer	*buffer;
+	struct trace_buffer		*buffer;
 	raw_spinlock_t			reader_lock;	/* serialize readers */
 	arch_spinlock_t			lock;
 	struct lock_class_key		lock_key;
@@ -546,7 +546,6 @@ struct ring_buffer_per_cpu {
 	/* pages removed since last reset */
 	unsigned long			pages_removed;
 
-	unsigned int			mapped;
 	unsigned int			user_mapped;	/* user space mapping */
 	struct mutex			mapping_lock;
 	struct buffer_page		**subbuf_ids;	/* ID to subbuf VA */
@@ -614,6 +613,11 @@ static __always_inline unsigned int rb_max_data_size(struct trace_buffer *buffer
 	return rb_subbuf_capacity(buffer) - RB_EVNT_HDR_SIZE - sizeof(event->array[0]);
 }
 
+static bool rb_is_static(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	return cpu_buffer->user_mapped || cpu_buffer->remote || cpu_buffer->ring_meta;
+}
+
 struct ring_buffer_iter {
 	struct ring_buffer_per_cpu	*cpu_buffer;
 	unsigned long			head;
@@ -2544,7 +2548,6 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 		 * Range mapped buffers have the same restrictions as memory
 		 * mapped ones do.
 		 */
-		cpu_buffer->mapped = 1;
 		cpu_buffer->ring_meta = rb_range_meta(buffer, nr_pages, cpu);
 		bpage->page = rb_range_buffer(cpu_buffer, 0);
 		if (!bpage->page)
@@ -6634,12 +6637,11 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	rb_head_page_activate(cpu_buffer);
 	cpu_buffer->pages_removed = 0;
 
-	if (cpu_buffer->mapped) {
-		rb_update_meta_page(cpu_buffer);
-		if (cpu_buffer->ring_meta) {
-			struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
-			meta->commit_buffer = meta->head_buffer;
-		}
+	rb_update_meta_page(cpu_buffer);
+	if (cpu_buffer->ring_meta) {
+		struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
+
+		meta->commit_buffer = meta->head_buffer;
 	}
 }
 
@@ -6888,8 +6890,8 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 	cpu_buffer_a = buffer_a->buffers[cpu];
 	cpu_buffer_b = buffer_b->buffers[cpu];
 
-	/* It's up to the callers to not try to swap mapped buffers */
-	if (WARN_ON_ONCE(cpu_buffer_a->mapped || cpu_buffer_b->mapped))
+	/* It's up to the callers to not try to swap static buffers */
+	if (WARN_ON_ONCE(rb_is_static(cpu_buffer_a) || rb_is_static(cpu_buffer_b)))
 		return -EBUSY;
 
 	/* At least make sure the two buffers are somewhat the same */
@@ -7101,7 +7103,6 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	unsigned int size;
 	unsigned int read;
 	u64 save_timestamp;
-	bool force_memcpy;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return -1;
@@ -7140,8 +7141,6 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	/* Check if any events were dropped */
 	missed_events = cpu_buffer->lost_events;
 
-	force_memcpy = cpu_buffer->mapped || cpu_buffer->remote;
-
 	/*
 	 * If this page has been partially read or
 	 * if len is not big enough to read the rest of the page or
@@ -7151,7 +7150,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	 */
 	if (read || (len < (size - read)) ||
 	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
-	    force_memcpy) {
+	    rb_is_static(cpu_buffer)) {
 		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
 		unsigned int rpos = read;
 		unsigned int pos = 0;
@@ -7598,11 +7597,7 @@ static int __rb_inc_dec_mapped(struct ring_buffer_per_cpu *cpu_buffer,
 
 	lockdep_assert_held(&cpu_buffer->mapping_lock);
 
-	/* mapped is always greater or equal to user_mapped */
-	if (WARN_ON(cpu_buffer->mapped < cpu_buffer->user_mapped))
-		return -EINVAL;
-
-	if (inc && cpu_buffer->mapped == UINT_MAX)
+	if (inc && cpu_buffer->user_mapped == UINT_MAX)
 		return -EBUSY;
 
 	if (WARN_ON(!inc && cpu_buffer->user_mapped == 0))
@@ -7611,13 +7606,10 @@ static int __rb_inc_dec_mapped(struct ring_buffer_per_cpu *cpu_buffer,
 	mutex_lock(&cpu_buffer->buffer->mutex);
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 
-	if (inc) {
+	if (inc)
 		cpu_buffer->user_mapped++;
-		cpu_buffer->mapped++;
-	} else {
+	else
 		cpu_buffer->user_mapped--;
-		cpu_buffer->mapped--;
-	}
 
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 	mutex_unlock(&cpu_buffer->buffer->mutex);
@@ -7789,7 +7781,6 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	if (!err) {
 		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 		/* This is the first time it is mapped by user */
-		cpu_buffer->mapped++;
 		cpu_buffer->user_mapped = 1;
 		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 	} else {
@@ -7846,8 +7837,6 @@ int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 
 	/* This is the last user space mapping */
-	if (!WARN_ON_ONCE(cpu_buffer->mapped < cpu_buffer->user_mapped))
-		cpu_buffer->mapped--;
 	cpu_buffer->user_mapped = 0;
 
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
-- 
2.55.0.654.g21b8a5bc05-goog

