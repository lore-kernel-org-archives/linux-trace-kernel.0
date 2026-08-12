Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C2F466B4C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786548824; cv=none; b=WNK8Jiz8USK9+jY9IIcqwxaIr9t0hsxKJAdS5fJFt6I8qg8AQLuenVzx+X5Fwd3LtSY5f+3wXyUWpnrYpUHIF6ul9Qe52zJktD9SIEFug/dqjP9Fa47zHX7rUo4cMlcc98h5P07TzRLQ3dfUx1nCaUxuhAPs3wJT6t1NVU9QJ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786548824; c=relaxed/simple;
	bh=mXZOFdsJW8G6Lb5PUuw6s4qnNp0ezQNkWvaerQ2qRqA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uT4JSIJiEtZbjPpMEZI6k4JMKxG9PF0DZr70g3JCNIV7IONqVUXHpoH3gc36HOMcDmAFDKj78UWhmlLaVcaV9EOizqzATBynSf9SpmwvB56ogHfgqof58vTWwYfpckTdlabMLgNlBDGsfRnf0IghpD/UDb+7UEVikQEW/FrK2Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WA99MOzJ; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WA99MOzJ"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-496bbcf7d1eso8737025e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 08:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786548816; x=1787153616; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pz5loxNScpg5U4ANTwZht/BDh0bp7SxZ2CSKSmSMePM=;
        b=WA99MOzJ3WZGy2GKGZBbLvS7mxX7zq+pSDfBoQHPxXiWH4UYlvEr+lhcwo7mYnr6c+
         HVxUwyORxMmkqbvyhAz9vk85Vz0V8VgZUnqPXKEgrDMfXu/G6ti8MW0/iiL7h85BRXra
         55ZDBBuQlkM17Swg0ZzvkmJbgQL3183FAfYIS75T6E+t6yJmIjWxEERlznsfc+GxL/io
         W7Usp5DpoTKk2Bf7N+RMNk6Z4UFgmBbTqERKfA0ApQR3trIA8ULO1pdWASI25EHi88GW
         XafTlliD6UzKYUOPEWDjFGKOnHBv7P1ukaqODUk0LQxnXzQa5j4H73HqR43FVTO9qDvl
         SKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786548816; x=1787153616;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pz5loxNScpg5U4ANTwZht/BDh0bp7SxZ2CSKSmSMePM=;
        b=gXoGb4WQGOdV7ezaEzOXBpiiCIUrwPj+FU1WbP+hDGc6HyBqMrMP9UzVcMOD2FszHr
         uWJUmmxbOi0ztsRvQk8UIbpkZsHfEd2bGWma5IcBxeuh6A9xWVXlaE3C8qEBd+4E7a0j
         MmeRveKBEhWADNmtCWlKf3AOrwxUl7YOc1YUlQTKAVn7f2Up1Hc+LQ9lxHF8VyLUX/Xv
         WIxGdCxnq0Q8tQ6lLUbGHlvlsGC50FSMvPB5dekAhDL3kJ5jArG9V/AnXQkyCPuhq/eX
         tGqNZDxuIuAGn6qrr7g+5cTgvkHu1XJd2wDsyx0qfcAWpw+4IQIKD9OSrsfLCVdnbmLD
         YO0w==
X-Forwarded-Encrypted: i=1; AHgh+RrKIla0LxOMC5KiwKBsx41AhQk5zrGyrdbspScs6DPnNlD5gg6PxEhYXxgL6V7SgOIhOSpCMRK/3FaLWoipVNDRp8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFpG129gLsfgVgQ4achNcvsZwYQbLVGJJxZevRtC0hdf9iMhet
	EhQdN9rLbxOdY9S0vSlZr1UiR1qEQhthyeD///K8C4UqY86ibFde2DcJUC/04xL6MnIjJp32/QN
	MaWxCcFT16UWWyFztQrO7ZQ==
X-Received: from wmmp22.prod.google.com ([2002:a05:600c:656:b0:493:c2c8:a251])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:16ca:b0:493:cefc:d113 with SMTP id 5b1f17b1804b1-4997c0f207emr55994315e9.5.1786548816339;
 Wed, 12 Aug 2026 08:33:36 -0700 (PDT)
Date: Wed, 12 Aug 2026 16:33:09 +0100
In-Reply-To: <20260812153311.2328812-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812153311.2328812-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812153311.2328812-9-vdonnefort@google.com>
Subject: [PATCH v4 8/9] ring-buffer: Remove ring_buffer_per_cpu::mapped
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
index 45aa10f0b17e..990a904cefe8 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -514,7 +514,7 @@ struct ring_buffer_per_cpu {
 	int				cpu;
 	atomic_t			record_disabled;
 	atomic_t			resize_disabled;
-	struct trace_buffer	*buffer;
+	struct trace_buffer		*buffer;
 	raw_spinlock_t			reader_lock;	/* serialize readers */
 	arch_spinlock_t			lock;
 	struct lock_class_key		lock_key;
@@ -552,7 +552,6 @@ struct ring_buffer_per_cpu {
 	/* pages removed since last reset */
 	unsigned long			pages_removed;
 
-	unsigned int			mapped;
 	unsigned int			user_mapped;	/* user space mapping */
 	struct mutex			mapping_lock;
 	struct buffer_page		**subbuf_ids;	/* ID to subbuf VA */
@@ -648,6 +647,11 @@ unsigned long rb_subbuf_start(struct trace_buffer *buffer, unsigned long addr)
 	return addr & ~((unsigned long)(rb_subbuf_size(buffer) - 1));
 }
 
+static bool rb_is_static(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	return cpu_buffer->user_mapped || cpu_buffer->remote || cpu_buffer->ring_meta;
+}
+
 struct ring_buffer_iter {
 	struct ring_buffer_per_cpu	*cpu_buffer;
 	unsigned long			head;
@@ -2578,7 +2582,6 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 		 * Range mapped buffers have the same restrictions as memory
 		 * mapped ones do.
 		 */
-		cpu_buffer->mapped = 1;
 		cpu_buffer->ring_meta = rb_range_meta(buffer, nr_pages, cpu);
 		bpage->page = rb_range_buffer(cpu_buffer, 0);
 		if (!bpage->page)
@@ -6667,12 +6670,11 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
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
 
@@ -6921,8 +6923,8 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 	cpu_buffer_a = buffer_a->buffers[cpu];
 	cpu_buffer_b = buffer_b->buffers[cpu];
 
-	/* It's up to the callers to not try to swap mapped buffers */
-	if (WARN_ON_ONCE(cpu_buffer_a->mapped || cpu_buffer_b->mapped))
+	/* It's up to the callers to not try to swap static buffers */
+	if (WARN_ON_ONCE(rb_is_static(cpu_buffer_a) || rb_is_static(cpu_buffer_b)))
 		return -EBUSY;
 
 	/* At least make sure the two buffers are somewhat the same */
@@ -7157,7 +7159,6 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	unsigned int size;
 	unsigned int read;
 	u64 save_timestamp;
-	bool force_memcpy;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return -1;
@@ -7196,8 +7197,6 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	/* Check if any events were dropped */
 	missed_events = cpu_buffer->lost_events;
 
-	force_memcpy = cpu_buffer->mapped || cpu_buffer->remote;
-
 	/*
 	 * If this page has been partially read or
 	 * if len is not big enough to read the rest of the page or
@@ -7207,7 +7206,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	 */
 	if (read || (len < (size - read)) ||
 	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
-	    force_memcpy) {
+	    rb_is_static(cpu_buffer)) {
 		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
 		unsigned int rpos = read;
 		unsigned int pos = 0;
@@ -7668,11 +7667,7 @@ static int __rb_inc_dec_mapped(struct ring_buffer_per_cpu *cpu_buffer,
 
 	lockdep_assert_held(&cpu_buffer->mapping_lock);
 
-	/* mapped is always greater or equal to user_mapped */
-	if (WARN_ON(cpu_buffer->mapped < cpu_buffer->user_mapped))
-		return -EINVAL;
-
-	if (inc && cpu_buffer->mapped == UINT_MAX)
+	if (inc && cpu_buffer->user_mapped == UINT_MAX)
 		return -EBUSY;
 
 	if (WARN_ON(!inc && cpu_buffer->user_mapped == 0))
@@ -7681,13 +7676,10 @@ static int __rb_inc_dec_mapped(struct ring_buffer_per_cpu *cpu_buffer,
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
@@ -7859,7 +7851,6 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	if (!err) {
 		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 		/* This is the first time it is mapped by user */
-		cpu_buffer->mapped++;
 		cpu_buffer->user_mapped = 1;
 		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 	} else {
@@ -7916,8 +7907,6 @@ int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 
 	/* This is the last user space mapping */
-	if (!WARN_ON_ONCE(cpu_buffer->mapped < cpu_buffer->user_mapped))
-		cpu_buffer->mapped--;
 	cpu_buffer->user_mapped = 0;
 
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
-- 
2.55.0.691.gc56d675ccc-goog

