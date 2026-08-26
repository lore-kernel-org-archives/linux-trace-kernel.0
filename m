Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C51280A56
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787737624; cv=none; b=QeCBZHkzJjXl60T3XgZ/pNsetgRPeUPCkBk9sMhNhGiv+HPGcum4D63OwnRJbN93QLVUSwupLPgIUNAA+cLY3tcY6RJRmUYMxW1uhbrzRJu4Kt+z7ePkrayyH5oLVE9tD3FGIK3EHoD82lJIWkdaRQjYGp7uLlgluiO5OyIcghI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787737624; c=relaxed/simple;
	bh=n9LyenMFcPw0B9rc52GW+H0nuObAcHawmJDkIecVI4I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PPvBi0zSvd+ddiOlE1Enbu3JVoNGaYb+21QW37CgXQ6PoLKfLmHNOzGA8EmI3jrJPBa7r86SOiWrMmXBbQhw6bMT1RGfubWOSQvJxFTSifco9eU9bxzROJOOiESVkoau62CXo4WVfkKz3I/QQnBTjDoaWrRExGC8HN4ueSLMoEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=skrkcqwp; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="skrkcqwp"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47fd4ee0ac0so535904f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787737621; x=1788342421; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JCN5ZDztYZPoXy473rXzWwFGq4crA1kqoBaWd7gcR/o=;
        b=skrkcqwpL8RyTUL+DEjbxUeZKtAzIUYQeTGQdUXvKo9YSvkTq9PrWVohDyA+FvKx8r
         x+tUYPB+pYVphLpTpM4Qa/KHAVtD/MJsSgDu/anGXjvjvGG7URiCuj0QBiKA71a535Qd
         vp6ILIPdOIlLEgckNVLy/4TQYKg+Qkxo74gzcsVHmlUdH7WZrzFVKx+Y5dJVia2uqafc
         ri+I7LiMNhr+PPGbrULON3/2DBscwyjKRoNjfktCyG730uOfdYsFvZrE5O2NRI6x5fXS
         QmizZCc3JtGvh8LrqXkH5TERlOUzUzHujjJKNEZTNWZE1NBGHAgxOB15WDFZInsjDPFx
         D0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787737621; x=1788342421;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JCN5ZDztYZPoXy473rXzWwFGq4crA1kqoBaWd7gcR/o=;
        b=YMidiFKsidfSBEGlMlwSxOoneNzvKiA+6QEJVTNTCGK6GAvTM0f2xakVV1DrQlWFx6
         KPFdJh2odLLyzjCROAoVKRDEe8xpTuwEFi17UB2ee43kuMsI9RHT41ZGMxpmVkK8lNeP
         hGrvJG4yqA1Mskk9YxBhPVkkBovI+suLPokaKzwvK55g/1GbHBU0IU9UxkF0S1EQ7on9
         RFCoUfvWvLaMPtdOsfVfhMrvIPMF7h5NeSEPg3dyplyebcPUqkaFv97vQ2+0Pm3iru76
         9xQ1Uw6YFR9K2IbvzyhR+K6a+mOKZ7vo9qShPuAB9MQngJV7VW21wjIK15Rw6TZDH6Xb
         8jxg==
X-Forwarded-Encrypted: i=1; AHgh+RrTXBl3/d8bSqS/2Y8jMBXH5W0CeAdrure57ag8ACVE3QQnynvPE1JFaokvDAvWehP2VQJb/gzUwcT6Cd7qm7XQDMs=@vger.kernel.org
X-Gm-Message-State: AFuF++mmlymMVgu8DHEE917wCMnaLM3p0kDdcX0zo/GyXiM/JQaLBdfB
	evGPXevdGrN7DKcsFk8waGKTfPEybd3C8ExkKsgwRngDore8gvXOb+nIEPR8ZmHLlbnbc2NUBQP
	XqtCnv6tiLIusfc5noBQmaQ==
X-Received: from wrwb11.prod.google.com ([2002:a5d:634b:0:b0:482:ddd8:17fc])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:6f07:0:b0:482:e64d:a1f7 with SMTP id ffacd0b85a97d-482e64da6e6mr1944582f8f.11.1787737534646;
 Wed, 26 Aug 2026 02:45:34 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:45:28 +0100
In-Reply-To: <20260826094528.3738023-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826094528.3738023-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260826094528.3738023-4-vdonnefort@google.com>
Subject: [PATCH v8 3/3] ring-buffer: Prevent truncation of nr_pages / nr_subbufs
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
index 6089fcc67e2b..1fcf55e2ca81 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1683,7 +1683,7 @@ static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
  * This is used to help find the next per cpu subbuffer within a mapped range.
  */
 static unsigned long
-rb_range_align_subbuf(unsigned long addr, int subbuf_size, int nr_subbufs)
+rb_range_align_subbuf(unsigned long addr, unsigned int subbuf_size, unsigned long nr_subbufs)
 {
 	addr += sizeof(struct ring_buffer_cpu_meta) +
 		sizeof(int) * nr_subbufs;
@@ -1693,13 +1693,12 @@ rb_range_align_subbuf(unsigned long addr, int subbuf_size, int nr_subbufs)
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
@@ -1745,7 +1744,7 @@ static void *rb_range_meta(struct trace_buffer *buffer, int nr_pages, int cpu)
 /* Return the start of subbufs given the meta pointer */
 static void *rb_subbufs_from_meta(struct ring_buffer_cpu_meta *meta)
 {
-	int subbuf_size = meta->subbuf_size;
+	unsigned int subbuf_size = meta->subbuf_size;
 	unsigned long ptr;
 
 	ptr = (unsigned long)meta;
@@ -1757,11 +1756,11 @@ static void *rb_subbufs_from_meta(struct ring_buffer_cpu_meta *meta)
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
@@ -1777,7 +1776,7 @@ static void *rb_range_buffer(struct ring_buffer_per_cpu *cpu_buffer, int idx)
 
 	ptr = (unsigned long)rb_subbufs_from_meta(meta);
 
-	ptr += subbuf_size * idx;
+	ptr += (unsigned long)subbuf_size * idx;
 	if (ptr + subbuf_size > cpu_buffer->buffer->range_addr_end)
 		return NULL;
 
@@ -1854,13 +1853,13 @@ static bool rb_meta_init(struct trace_buffer *buffer, int scratch_size)
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
@@ -2109,8 +2108,8 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	struct buffer_page *head_page, *orig_head, *orig_reader;
 	struct rb_validation_state state = { 0 };
 	bool skip = false;
+	unsigned long i;
 	int ret;
-	int i;
 
 	if (!meta || !meta->head_buffer)
 		return;
@@ -2161,7 +2160,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		rb_validate_buffer(head_page, cpu_buffer, meta, &state, 0, state.ts);
 	}
 	if (i)
-		pr_info("Ring buffer [%d] rewound %d pages\n", cpu_buffer->cpu, i);
+		pr_info("Ring buffer [%d] rewound %lu pages\n", cpu_buffer->cpu, i);
 
 	/* The last rewound page must be skipped. */
 	if (head_page != orig_head)
@@ -2245,7 +2244,8 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	}
 }
 
-static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages, int scratch_size)
+static void rb_range_meta_init(struct trace_buffer *buffer,
+			       unsigned long nr_pages, int scratch_size)
 {
 	struct ring_buffer_cpu_meta *meta;
 	unsigned long *subbuf_mask;
@@ -2345,8 +2345,8 @@ static int rbm_show(struct seq_file *m, void *v)
 			   rb_meta_subbuf_idx(meta, (void *)meta->head_buffer));
 		seq_printf(m, "commit_buffer: %d\n",
 			   rb_meta_subbuf_idx(meta, (void *)meta->commit_buffer));
-		seq_printf(m, "subbuf_size:   %d\n", meta->subbuf_size);
-		seq_printf(m, "nr_subbufs:    %d\n", meta->nr_subbufs);
+		seq_printf(m, "subbuf_size:   %u\n", meta->subbuf_size);
+		seq_printf(m, "nr_subbufs:    %u\n", meta->nr_subbufs);
 		return 0;
 	}
 
@@ -2431,7 +2431,7 @@ static void *ring_buffer_desc_page(struct ring_buffer_desc *desc, unsigned int p
 }
 
 static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
-		long nr_pages, struct list_head *pages)
+			       unsigned long nr_pages, struct list_head *pages)
 {
 	struct trace_buffer *buffer = cpu_buffer->buffer;
 	struct ring_buffer_cpu_meta *meta = NULL;
@@ -2559,7 +2559,7 @@ static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 }
 
 static struct ring_buffer_per_cpu *
-rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
+rb_allocate_cpu_buffer(struct trace_buffer *buffer, unsigned long nr_pages, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer __free(kfree) =
 		alloc_cpu_buffer(cpu);
@@ -2716,8 +2716,8 @@ static void rb_test_inject_invalid_pages(struct trace_buffer *buffer)
 	struct ring_buffer_cpu_meta *meta;
 	struct buffer_data_page *dpage;
 	unsigned long entry_bytes = 0;
+	unsigned int subbuf_size;
 	unsigned long ptr;
-	int subbuf_size;
 	int invalid = 0;
 	int cpu;
 	int i;
@@ -2787,8 +2787,8 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
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
@@ -5872,12 +5872,12 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
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
@@ -6195,8 +6195,8 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	struct trace_buffer *buffer;
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_event *event;
-	int nr_loops = 0;
-	int max_loops;
+	unsigned long nr_loops = 0;
+	unsigned long max_loops;
 
 	if (ts)
 		*ts = 0;
@@ -7442,8 +7442,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct buffer_page *bpage, *tmp;
 	unsigned int old_capacity;
+	unsigned long nr_pages;
 	int old_order;
-	int nr_pages;
 	int psize;
 	int err;
 	int cpu;
@@ -7625,10 +7625,10 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
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
2.55.0.860.g4b6b3295ed-goog

