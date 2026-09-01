Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3EA47A873
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278099; cv=none; b=e8PVPgoSlyQ6Rr72ftTEvXindx+ecTYqTfe2N14b+j5CZ6cHRPP6EgItJ+ivjT/r4QSq04dtk7YxMCwagHI8/axE/GZqaMSS9pRkxSrQzF3WoWM+itNZxaVhrWtpcWVn82WySBPtrfYTC0A7NhPc9pLVNfHn3hm/TMUyk+TZJ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278099; c=relaxed/simple;
	bh=AvJkE5WnUbXl7SSzJ4FzUXZW4f2wy+QUeBEgjGH9bJo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FWzdXGSFdu9mn2voU0BF96gDDt6eiUuJl08mYgfg6shKqdKK8DS377zoKKtqP8TsKWYMBFtcaolcbZkVMVEOxuMDTSaRTygKMIvn3xY1+n5iGLyL1AFV1VGlWzzSPBiwximx+MuZEk+nEdUjybiO9BP3wZbVWmZtN4X5Lz/WPiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gFJtNFha; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gFJtNFha"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495529a93f9so45751155e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 08:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788278096; x=1788882896; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SYxx9E8yesdUYjVtGHE8XXuxisz/zZjtPq89YqGSK9k=;
        b=gFJtNFhavLwZbpC6PgkXKM8iRoeJH8BMKEaFxaq3Nz0Bj+35zaukR05C8+b6CYHA5M
         vvAxPxxCeamK72mC+EhGnw1wziMdhz16dbHpEL/djWx7Lh6Ckz31COxc2bKpehjMsSiC
         IQNlRKrvfb7lAXV7ioA1W08O17NK/bUvIQerCbijeKimA5MkuBZwFC0rPbXAJsg5YXj9
         oERh1+VHh6sILuILm6FDpy1fGMB6OGFqfZdn95HpndYU72aPtnu/iD4PCtc+xT6XJpXF
         j/ZtuaEiCuPv49XlLxt7kddZ9n2kjh5N7iUIExpOwJ23MF+8wyo9yrsl382LZbWX9Cfk
         P9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788278096; x=1788882896;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SYxx9E8yesdUYjVtGHE8XXuxisz/zZjtPq89YqGSK9k=;
        b=et8SeQA+nU8kResfnHDXi2lbpVlcUvvf8fYQjhIKrIejMijHkrkXNrmTxg3E0vm9zP
         ivL8MLCSHmKOauBPB0UOkUxllTOnOhXJrhQIOUGCoSFJQmCqdzXODPyA4PSy52z3HaAG
         Na1zG0wawIwNO1LjDWiMYr9f5KQW1m03VAxm+T5KvB0JNnUUh20opcvqXjgNv5geAplz
         RTxj29oNOW+c8K1tOCNquDbBOzMXcx5dtSKNDydNMnY4eOj7MPsu9FouP6mX+wq0wQhJ
         8C9p556sh0TE9IBpnHmUIJZJsDZv3ZjebsLiDuUbpqkUUSHbsWQkb+hjEWcd9tN1Yv3p
         aKzg==
X-Forwarded-Encrypted: i=1; AHgh+RqSb6co30EjPIqwgigm4LqoLjOMylTAo27e/pJIM3foW/xAnQEzCbgzYd5Vi6YmQ1reDG8kFIqdx45qrb4VLYqs30c=@vger.kernel.org
X-Gm-Message-State: AFuF++mru1vjlpFzXY714aXZFSl0DHgX1dZnq0GE2y/QnD72FIcajcFx
	VbMIz3Pm058/6UQE5618MutTBk9njczyMrouoOsee07+EhpNavlmaNOaGEfC/xa8tp5XC/odkpQ
	daa9iTztKUjTSHKmERTj15A==
X-Received: from wmbds11.prod.google.com ([2002:a05:600c:628b:b0:499:8840:6abc])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:19c8:b0:49b:c8e:a211 with SMTP id 5b1f17b1804b1-49b91c20bfamr546889925e9.5.1788278095515;
 Tue, 01 Sep 2026 08:54:55 -0700 (PDT)
Date: Tue,  1 Sep 2026 16:54:45 +0100
In-Reply-To: <20260901155445.1475405-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901155445.1475405-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260901155445.1475405-5-vdonnefort@google.com>
Subject: [PATCH v9 4/4] ring-buffer: Prevent truncation of nr_pages / nr_subbufs
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
index c4260d6ecdfc..ef66f726e2e2 100644
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
@@ -5875,12 +5875,12 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
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
@@ -6198,8 +6198,8 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	struct trace_buffer *buffer;
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_event *event;
-	int nr_loops = 0;
-	int max_loops;
+	unsigned long nr_loops = 0;
+	unsigned long max_loops;
 
 	if (ts)
 		*ts = 0;
@@ -7439,8 +7439,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct buffer_page *bpage, *tmp;
 	unsigned int old_capacity;
+	unsigned long nr_pages;
 	int old_order;
-	int nr_pages;
 	int psize;
 	int err;
 	int cpu;
@@ -7622,10 +7622,10 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
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
2.55.0.897.gb25b4bd76c-goog

