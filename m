Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A9F41DDF3
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Aug 2026 21:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786050805; cv=none; b=cklZA7bqjvzmtYBGN3pUauO+DQXqM1ypIAIoP4uZPLBUr3Quvp7wweUFienG9NaLmgtgKnsn8BCkKOmqtXG+JnwNgF84DlwFNMmnTFm7S81OuUy8tHMQ/MNJXVS+YEcSsi80bICgG5V0ohpKOZ0UfYjQFlu+x7m4Kz8v151L3FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786050805; c=relaxed/simple;
	bh=SvJyWwsI9ZU6rrrZROxXRUnmssX8edBRrxKJszTFRnA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=un7t7/W++KRpTVtjJiZb4KocsZdUIUI3WdVxB13XvB/VXUL02ui2R7XWM5GOSNsJoMjCmBpDX4JORO2YUYbrAkoS1BxlHK5h/daoDnlAbj2dagvFjE1qAT0IbPq3qYS/HQU0mqHWXiqDRCPbKeWY4Z3hBEDW/CI23hTWDl6z4jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hNVG9j1W; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hNVG9j1W"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4955fd77c18so15180025e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Aug 2026 14:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786050802; x=1786655602; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RFyN105iXFuGlJPAnwQ0AEHc6sQHsfnwpATvskXdjFw=;
        b=hNVG9j1WY2UnWZyh381PiWMiBAo3n2TUmziviC3VKjOgf6sOsPQ73zCj2ejCFr0vhb
         s18kpqR9XN3iJwc+iBE9KkZDjm0rMU8sR/QE3fqxgwZNWkJ0Ul9T7Mb2kG/G8QZf4K2r
         gTgvxmsiv3HUmSanEstXfUP8jXhg3LhdnmOx1X8JUD8EW0SD+MTTwGjEB3Dq5Fv0Jkh7
         m/74CU1GPyLVIxS58YwrypM1qiBa+lXtBenHSXVWgRDz68WgWjszxbmQuZdSKP0Jb/Db
         SLBqG/6hQ0GZ4N6RldbX1pTbI+gzQ8LIxr98qXlkIfozGqQ+Cf4U/PmabSrYBzxAhgAo
         etdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786050802; x=1786655602;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RFyN105iXFuGlJPAnwQ0AEHc6sQHsfnwpATvskXdjFw=;
        b=PeUNTjZLVjnr74T1jzrLsIFA16ErNN+Pnhe/yMYAkK+5E3/OjTpY6Ff/FKGL9lSM3S
         ZQOLpUOD0SOCEs8aXvtGghcOOMCjPGjbPm+ynVaItI5AODLrN9tsOnZuWyTCx1UTCyrT
         8mqRki8dSTvqgmxOfWYuC0mNBPr6neb7R+TFvmB5tZnK3qYijsrWeCaL1YdoTrgLG4LS
         wiGlN6AR1sssQrqyQfr36qjvNCkqXGwdIwWafK2lfbV8lObYtnGL7O5vYS5S+JN9l0ML
         ZJK+DM2T9QO0l4Fomga0PTYj52GPQHX6xdK5dmztaDapC+NhMaG25OR4nGodTZMqYfZ1
         1UYQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq98TQfeflilo9A3Jjye324SFbqFskPR+l2w/ff2OGXjGPKeEhH1FsEkBxGN/aWMV063B5DCpWSsXg0pXDHTrL3Q1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzOcW8nb+3wH5CLsjxAatKDJ9d8PFsWOwZYREVmHRCzxteoyWk
	CIrU1dkYIziiPwqEsMrQLkC2wpHrTUm5vLVwcACWJYP1eAfQAZCj0bw7Vg1rubUZkkbRiqbk0T2
	sUVIbzAkSlDl2lG7yjmThdQ==
X-Received: from wmbd15.prod.google.com ([2002:a05:600c:58cf:b0:493:b719:1145])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:19cd:b0:498:519:e660 with SMTP id 5b1f17b1804b1-4994e72f7b6mr228897425e9.4.1786050802294;
 Thu, 06 Aug 2026 14:13:22 -0700 (PDT)
Date: Thu,  6 Aug 2026 22:13:06 +0100
In-Reply-To: <20260806211306.3704194-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806211306.3704194-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260806211306.3704194-7-vdonnefort@google.com>
Subject: [PATCH 6/6] ring-buffer: Remove ring_buffer_per_cpu::mapped
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
index d2480ccc81b8..e18e2c315545 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -503,7 +503,7 @@ struct ring_buffer_per_cpu {
 	int				cpu;
 	atomic_t			record_disabled;
 	atomic_t			resize_disabled;
-	struct trace_buffer	*buffer;
+	struct trace_buffer		*buffer;
 	raw_spinlock_t			reader_lock;	/* serialize readers */
 	arch_spinlock_t			lock;
 	struct lock_class_key		lock_key;
@@ -541,7 +541,6 @@ struct ring_buffer_per_cpu {
 	/* pages removed since last reset */
 	unsigned long			pages_removed;
 
-	unsigned int			mapped;
 	unsigned int			user_mapped;	/* user space mapping */
 	struct mutex			mapping_lock;
 	struct buffer_page		**subbuf_ids;	/* ID to subbuf VA */
@@ -615,6 +614,11 @@ static inline unsigned int rb_page_capacity(struct buffer_page *bpage)
 	return (PAGE_SIZE << bpage->order) - BUF_PAGE_HDR_SIZE;
 }
 
+static inline bool rb_is_static(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	return cpu_buffer->user_mapped || cpu_buffer->remote || cpu_buffer->ring_meta;
+}
+
 struct ring_buffer_iter {
 	struct ring_buffer_per_cpu	*cpu_buffer;
 	unsigned long			head;
@@ -2545,7 +2549,6 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 		 * Range mapped buffers have the same restrictions as memory
 		 * mapped ones do.
 		 */
-		cpu_buffer->mapped = 1;
 		cpu_buffer->ring_meta = rb_range_meta(buffer, nr_pages, cpu);
 		bpage->page = rb_range_buffer(cpu_buffer, 0);
 		if (!bpage->page)
@@ -6636,12 +6639,11 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
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
 
@@ -6890,8 +6892,8 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 	cpu_buffer_a = buffer_a->buffers[cpu];
 	cpu_buffer_b = buffer_b->buffers[cpu];
 
-	/* It's up to the callers to not try to swap mapped buffers */
-	if (WARN_ON_ONCE(cpu_buffer_a->mapped || cpu_buffer_b->mapped))
+	/* It's up to the callers to not try to swap static buffers */
+	if (WARN_ON_ONCE(rb_is_static(cpu_buffer_a) || rb_is_static(cpu_buffer_b)))
 		return -EBUSY;
 
 	/* At least make sure the two buffers are somewhat the same */
@@ -7103,7 +7105,6 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	unsigned int size;
 	unsigned int read;
 	u64 save_timestamp;
-	bool force_memcpy;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return -1;
@@ -7142,8 +7143,6 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	/* Check if any events were dropped */
 	missed_events = cpu_buffer->lost_events;
 
-	force_memcpy = cpu_buffer->mapped || cpu_buffer->remote;
-
 	/*
 	 * If this page has been partially read or
 	 * if len is not big enough to read the rest of the page or
@@ -7153,7 +7152,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	 */
 	if (read || (len < (size - read)) ||
 	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
-	    force_memcpy) {
+	    rb_is_static(cpu_buffer)) {
 		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
 		unsigned int rpos = read;
 		unsigned int pos = 0;
@@ -7600,11 +7599,7 @@ static int __rb_inc_dec_mapped(struct ring_buffer_per_cpu *cpu_buffer,
 
 	lockdep_assert_held(&cpu_buffer->mapping_lock);
 
-	/* mapped is always greater or equal to user_mapped */
-	if (WARN_ON(cpu_buffer->mapped < cpu_buffer->user_mapped))
-		return -EINVAL;
-
-	if (inc && cpu_buffer->mapped == UINT_MAX)
+	if (inc && cpu_buffer->user_mapped == UINT_MAX)
 		return -EBUSY;
 
 	if (WARN_ON(!inc && cpu_buffer->user_mapped == 0))
@@ -7613,13 +7608,10 @@ static int __rb_inc_dec_mapped(struct ring_buffer_per_cpu *cpu_buffer,
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
@@ -7791,7 +7783,6 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	if (!err) {
 		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 		/* This is the first time it is mapped by user */
-		cpu_buffer->mapped++;
 		cpu_buffer->user_mapped = 1;
 		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 	} else {
@@ -7848,8 +7839,6 @@ int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 
 	/* This is the last user space mapping */
-	if (!WARN_ON_ONCE(cpu_buffer->mapped < cpu_buffer->user_mapped))
-		cpu_buffer->mapped--;
 	cpu_buffer->user_mapped = 0;
 
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
-- 
2.55.0.654.g21b8a5bc05-goog

