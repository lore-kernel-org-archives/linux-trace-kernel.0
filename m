Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63CA39769D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974486; cv=none; b=c5XCI3USivohyGXUmXkvKNCWI/nnKVrUV20jQVgsfcqcSQ+UttyWda+68G8dV8dBe+RMEt2iERFdpYAVJUevfuIExyDQZ9zd7PoIh3U+rikdPdrOwPyIN/sWqQzhT046tb+p4woAO5//Pvchx7SrOmHYytBsOF3QeNMG3DYWwBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974486; c=relaxed/simple;
	bh=pguN18YtXznx8P3V9pSnxt+sk3tsrWtwvv6YLqVT0O0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CxtzThP9pANh1UPf+/Db4Ic7Ue7bJv5pewcjx0ogAinw1mQGV6rEQdaut+Mp55u2Aa96HquJskSsC9Q7ThKR/6H0+qwExA1UNvGaHgL9oztr0vfuIF/SzchCb5bUQ3q46eolVBcB8cKqNNUYJ8MGSMOUwTmbowFjwZS3Y9F9hsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tCaG63wJ; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tCaG63wJ"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49545071724so33193645e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 06:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786974476; x=1787579276; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5tmH2WqTs/cXsxfhhS+vTGD7RzVlnvpECmTL23XrpgA=;
        b=tCaG63wJx+Ym99wzxB4Kp/Ann0vrX6VCXRrbYwqk297aHT88nhuWoH3r0WOoziQJcp
         uztC+A1CrhJnJahOoqQpIVJe340AVnC3w7+x7d1x227wVWDrw/xEWhfFNRzrkt1deOKE
         FmvviC8KvpJG2F01oMTDSrmUYLPvL/evSUdmxuLeJ+R6u3JPQaWslHeMRq3B9P3xhmsM
         Ra13K3hYsUcB+PiXV3zr+MNtLRVoUHPAANQXhSt8gZXmDLrJCKPex0+X3iYY2KiHmcnf
         qSLIY5hWSpzl7j6viw5/HN63OVUkiYstdOzCwlzYCduALixWp/zf+o7u+2QfSHOgwLYV
         hRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974476; x=1787579276;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5tmH2WqTs/cXsxfhhS+vTGD7RzVlnvpECmTL23XrpgA=;
        b=aTx6Ugqw5dke7YS96Zrj1TU8a6UvmF5A2kwV8rGhMxEZgBl3WEQv9f1kEhqH8Xk9zv
         i+AnN2DtLj/v79aGbVwcmjM+tt7MGWCztf/lK82EM85CSO6G1kebAkOpNJN52VjYN385
         0ffNbBRjbvBKotIqsAF25WExD8Lpz1gj2rc7YNCH3tIkpx4kxSn3smlIoxw9KEOBMr3b
         QHI60D5mCV+mc4BUxxRAfFxvKrMzbiXwANC1Ii0LnufzlnkGbN3QPyMgnwgokO68mPPb
         k/JJSSqNJHiKx0IjyXP44y2U86Q3Jn49zJgBTC7GZPnyzb7qMjAX8hARic+zinPNOgfG
         p7Lw==
X-Forwarded-Encrypted: i=1; AHgh+Rop5SXJY+xzxa04mw5pZNBjnvxSCQVpsbEUjyyEHCxOx29vdb/pg+nu6A9dl1ZMxbhLLNNfqQSxk0mZ4lvcq7q1Le8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqIbOT9JNUJP3UQmQfr/qM1LNnxejp21wB5jjX9zO1oVy0sU92
	rh/NloViki16PyWG8Xf0wSmmmGZENLGZ510uozAr8RpczfHby6PkzMJSdhC09JvqQLT/UCtM2kN
	2AYO3wWI8MqXzqy9fsQboNw==
X-Received: from wmbeq5.prod.google.com ([2002:a05:600c:8485:b0:493:f87d:7786])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b23:b0:499:8ae1:b900 with SMTP id 5b1f17b1804b1-4998ae1bb69mr307135485e9.12.1786974476388;
 Mon, 17 Aug 2026 06:47:56 -0700 (PDT)
Date: Mon, 17 Aug 2026 14:47:50 +0100
In-Reply-To: <20260817134750.3909384-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260817134750.3909384-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260817134750.3909384-4-vdonnefort@google.com>
Subject: [PATCH v7 3/3] ring-buffer: Prevent truncation of nr_pages / nr_subbufs
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Although ring_buffer_per_cpu::nr_pages is defined as unsigned long, it
is capped to 32-bits in a few places, limiting the operations possible
on a very large buffer. Use `unsigned long` where appropriate and
prevent truncation of values using nr_pages (or nr_subbufs).

While at it, subbuf_size must be at least `unsigned int`.

Note that persistent, remote and user-mapped ring buffers are capping
the number of pages to 31 bits already, making "int" safe in many
places.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 5e26eeff588f..7d22f10df3d6 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1678,7 +1678,7 @@ static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
  * This is used to help find the next per cpu subbuffer within a mapped range.
  */
 static unsigned long
-rb_range_align_subbuf(unsigned long addr, int subbuf_size, int nr_subbufs)
+rb_range_align_subbuf(unsigned long addr, unsigned int subbuf_size, unsigned long nr_subbufs)
 {
 	addr += sizeof(struct ring_buffer_cpu_meta) +
 		sizeof(int) * nr_subbufs;
@@ -1688,13 +1688,12 @@ rb_range_align_subbuf(unsigned long addr, int subbuf_size, int nr_subbufs)
 /*
  * Return the ring_buffer_meta for a given @cpu.
  */
-static void *rb_range_meta(struct trace_buffer *buffer, int nr_pages, int cpu)
+static void *rb_range_meta(struct trace_buffer *buffer, unsigned long nr_pages, int cpu)
 {
-	int subbuf_size = rb_subbuf_size(buffer);
+	unsigned int subbuf_size = rb_subbuf_size(buffer);
 	struct ring_buffer_cpu_meta *meta;
 	struct ring_buffer_meta *bmeta;
-	unsigned long ptr;
-	int nr_subbufs;
+	unsigned long ptr, nr_subbufs;
 
 	bmeta = buffer->meta;
 	if (!bmeta)
@@ -1740,7 +1739,7 @@ static void *rb_range_meta(struct trace_buffer *buffer, int nr_pages, int cpu)
 /* Return the start of subbufs given the meta pointer */
 static void *rb_subbufs_from_meta(struct ring_buffer_cpu_meta *meta)
 {
-	int subbuf_size = meta->subbuf_size;
+	unsigned int subbuf_size = meta->subbuf_size;
 	unsigned long ptr;
 
 	ptr = (unsigned long)meta;
@@ -1752,11 +1751,11 @@ static void *rb_subbufs_from_meta(struct ring_buffer_cpu_meta *meta)
 /*
  * Return a specific sub-buffer for a given @cpu defined by @idx.
  */
-static void *rb_range_buffer(struct ring_buffer_per_cpu *cpu_buffer, int idx)
+static void *rb_range_buffer(struct ring_buffer_per_cpu *cpu_buffer, unsigned int idx)
 {
 	struct ring_buffer_cpu_meta *meta;
+	unsigned int subbuf_size;
 	unsigned long ptr;
-	int subbuf_size;
 
 	meta = rb_range_meta(cpu_buffer->buffer, 0, cpu_buffer->cpu);
 	if (!meta)
@@ -1772,7 +1771,7 @@ static void *rb_range_buffer(struct ring_buffer_per_cpu *cpu_buffer, int idx)
 
 	ptr = (unsigned long)rb_subbufs_from_meta(meta);
 
-	ptr += subbuf_size * idx;
+	ptr += (unsigned long)subbuf_size * idx;
 	if (ptr + subbuf_size > cpu_buffer->buffer->range_addr_end)
 		return NULL;
 
@@ -1849,13 +1848,13 @@ static bool rb_meta_init(struct trace_buffer *buffer, int scratch_size)
  * must be the same.
  */
 static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
-			      struct trace_buffer *buffer, int nr_pages,
+			      struct trace_buffer *buffer, unsigned long nr_pages,
 			      unsigned long *subbuf_mask)
 {
-	int subbuf_size = PAGE_SIZE;
+	unsigned long subbuf_size = PAGE_SIZE;
 	unsigned long buffers_start;
 	unsigned long buffers_end;
-	int i;
+	unsigned long i;
 
 	if (!subbuf_mask)
 		return false;
@@ -2104,8 +2103,8 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	struct buffer_page *head_page, *orig_head, *orig_reader;
 	struct rb_validation_state state = { 0 };
 	bool skip = false;
+	unsigned long i;
 	int ret;
-	int i;
 
 	if (!meta || !meta->head_buffer)
 		return;
@@ -2156,7 +2155,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		rb_validate_buffer(head_page, cpu_buffer, meta, &state, 0, state.ts);
 	}
 	if (i)
-		pr_info("Ring buffer [%d] rewound %d pages\n", cpu_buffer->cpu, i);
+		pr_info("Ring buffer [%d] rewound %lu pages\n", cpu_buffer->cpu, i);
 
 	/* The last rewound page must be skipped. */
 	if (head_page != orig_head)
@@ -2240,7 +2239,8 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	}
 }
 
-static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages, int scratch_size)
+static void rb_range_meta_init(struct trace_buffer *buffer,
+			       unsigned long nr_pages, int scratch_size)
 {
 	struct ring_buffer_cpu_meta *meta;
 	unsigned long *subbuf_mask;
@@ -2340,8 +2340,8 @@ static int rbm_show(struct seq_file *m, void *v)
 			   rb_meta_subbuf_idx(meta, (void *)meta->head_buffer));
 		seq_printf(m, "commit_buffer: %d\n",
 			   rb_meta_subbuf_idx(meta, (void *)meta->commit_buffer));
-		seq_printf(m, "subbuf_size:   %d\n", meta->subbuf_size);
-		seq_printf(m, "nr_subbufs:    %d\n", meta->nr_subbufs);
+		seq_printf(m, "subbuf_size:   %u\n", meta->subbuf_size);
+		seq_printf(m, "nr_subbufs:    %u\n", meta->nr_subbufs);
 		return 0;
 	}
 
@@ -2426,7 +2426,7 @@ static void *ring_buffer_desc_page(struct ring_buffer_desc *desc, unsigned int p
 }
 
 static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
-		long nr_pages, struct list_head *pages)
+			       unsigned long nr_pages, struct list_head *pages)
 {
 	struct trace_buffer *buffer = cpu_buffer->buffer;
 	struct ring_buffer_cpu_meta *meta = NULL;
@@ -2554,7 +2554,7 @@ static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 }
 
 static struct ring_buffer_per_cpu *
-rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
+rb_allocate_cpu_buffer(struct trace_buffer *buffer, unsigned long nr_pages, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer __free(kfree) =
 		alloc_cpu_buffer(cpu);
@@ -2711,8 +2711,8 @@ static void rb_test_inject_invalid_pages(struct trace_buffer *buffer)
 	struct ring_buffer_cpu_meta *meta;
 	struct buffer_data_page *dpage;
 	unsigned long entry_bytes = 0;
+	unsigned int subbuf_size;
 	unsigned long ptr;
-	int subbuf_size;
 	int invalid = 0;
 	int cpu;
 	int i;
@@ -2782,8 +2782,8 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 					 struct ring_buffer_remote *remote)
 {
 	struct trace_buffer *buffer __free(kfree) = NULL;
-	long nr_pages;
-	int subbuf_size;
+	unsigned int subbuf_size;
+	unsigned long nr_pages;
 	int bsize;
 	int cpu;
 	int ret;
@@ -5867,12 +5867,12 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
 static struct buffer_page *
 __rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	int max_loops = cpu_buffer->ring_meta ? cpu_buffer->nr_pages : 3;
+	unsigned long max_loops = cpu_buffer->ring_meta ? cpu_buffer->nr_pages : 3;
 	struct buffer_page *reader = NULL;
+	unsigned long nr_loops = 0;
 	unsigned long overwrite;
 	unsigned long flags;
 	int missed_events = 0;
-	int nr_loops = 0;
 	bool ret;
 
 	local_irq_save(flags);
@@ -6190,8 +6190,8 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	struct trace_buffer *buffer;
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_event *event;
-	int nr_loops = 0;
-	int max_loops;
+	unsigned long nr_loops = 0;
+	unsigned long max_loops;
 
 	if (ts)
 		*ts = 0;
@@ -7438,8 +7438,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct buffer_page *bpage, *tmp;
 	unsigned int old_capacity;
+	unsigned long nr_pages;
 	int old_order;
-	int nr_pages;
 	int psize;
 	int err;
 	int cpu;
@@ -7621,10 +7621,10 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 				   struct buffer_page **subbuf_ids)
 {
 	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
-	unsigned int nr_subbufs = cpu_buffer->nr_pages + 1;
+	unsigned long nr_subbufs = cpu_buffer->nr_pages + 1;
 	struct buffer_page *first_subbuf, *subbuf;
-	int cnt = 0;
-	int id = 0;
+	unsigned int cnt = 0;
+	unsigned int id = 0;
 
 	id = rb_page_id(cpu_buffer, cpu_buffer->reader_page, id);
 	subbuf_ids[id++] = cpu_buffer->reader_page;
-- 
2.55.0.691.gc56d675ccc-goog

