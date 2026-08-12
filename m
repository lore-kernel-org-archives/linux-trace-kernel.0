Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9338643F0B0
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786548831; cv=none; b=bodtJXuk3lOaKrTRc2xmC2JI9q+0yrusGDFUJrpIMTdR+neCWklT3LBeYZ+KHrSTL6xe0o2ozOifPBeTOGvsGd1NzEmcok0Tz9OoXyMPNgZlAdJpfMPDVVieU8pXQhTjQo5CazMYt+eN+hALC/SuQ4Kk6stAbvc/sbLT/5qDgXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786548831; c=relaxed/simple;
	bh=+u6ruKpjI/mWvcOQC900P9kpILcTPVL6PLWAoMyJvcw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t7rnd8ybHl1aBTsOl/dweocYF4vG2u6i0Q7vCVqaQ/aOnr6rv5rdRR5edsa67/z0us6qVZJJQZqavaLRzQTIsgckvVrkZ66ZNGm/SB7tyOkoJ097p7kMuXlt3txNpjcu1OMUUXe5S6wYKOvBwfT/EILtgmhJ96ZbjMB3jAv6/Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SYxnZkU4; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SYxnZkU4"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4955e865174so5791345e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 08:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786548818; x=1787153618; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Al1AI1+q4Ne9/j+b+G1Wtjun9dFKpJAeJ0Aj+hRFSRI=;
        b=SYxnZkU4UukSVBTCDUEzBA2LvfL8HvOgSwzLoZzXepFGsTEIPEpCXEKpV46o8EfJtL
         VtGeK8s3MlbuvgOKBlZrJRenb5MfVKg/y+2L9PdQBBoe+2mUEkrzmzBeIZxxrZBZK9OL
         q7rwUslLLyh4Dh/hprbH8T0YhQUfoABGy6HVqwm2AvZoODVjuoxKwBh43+/EetqQ2uJD
         DLHZ+iU8ufdfP6+bIGBLku9qZFew6Mg+2xVowKR3Ay0naaM9mcHbz7+poNIwAffW31IN
         nB3NEAXmyc6blIwZq7W+PNvgGkrIn8iD2MBjAKRGYvjYseO/jDv2Mmmv8ZTEccFJv8jd
         qdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786548818; x=1787153618;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Al1AI1+q4Ne9/j+b+G1Wtjun9dFKpJAeJ0Aj+hRFSRI=;
        b=SMRqnY9gmTa7PtjgVP+T+PrMKpHwHGBiyD3BKZsAu0ah2jXpG5YFBZIwCqE+cIAJKt
         5VpQSKs/qYD3HZUMfhzcEfvxeOzana6cEVdpz8aGJkFIepGBzcF4eL/M18HReTIqowL0
         QhnoZ02rRnKFgBTZz9eWq3bTQCjLdl2kU/Tq0hVEzfqlKmyJg+5jkZ10YjFY6lgdUEZB
         3wbKl+6tkkzxcuDVbNIYmqCRy4ycsh3jmZ7SPrDsyHY5HN6TT1bgMnR/1zAdumdFKLc2
         z7MbzPlXXfOPxWKlR7u6ky/poKklXubUEQ6WQHkCAsuXhBXv6ZNNt5Tu40Urrj2jwuxJ
         /snw==
X-Forwarded-Encrypted: i=1; AHgh+RqTQh/KwhCG9exBNViRd88kxUl0Y16+CbZp0hxV4hu4lFj+6d7EjVPBQc4c+ZMhIA6wPbn1Po2qyxT4vQY17zjhwNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW89QdGIi5wPurbRS/AWiIarbBreU0tJBzRnAFAhFWeamZdnXY
	CUieasLbqWkidnWGnj42L/JF7uCHyuob/Mm6+QWLsSKScH3ARiln/65j2bK4fVZq8HRvLWCcpvp
	luORGYFWaHaING9hvE/l8wg==
X-Received: from wmj11.prod.google.com ([2002:a05:600c:24b:b0:493:d1ba:af39])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b2b:b0:499:4b5e:4077 with SMTP id 5b1f17b1804b1-4997c1306e9mr93335985e9.19.1786548817630;
 Wed, 12 Aug 2026 08:33:37 -0700 (PDT)
Date: Wed, 12 Aug 2026 16:33:10 +0100
In-Reply-To: <20260812153311.2328812-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812153311.2328812-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812153311.2328812-10-vdonnefort@google.com>
Subject: [PATCH v4 9/9] ring-buffer: Make nr_pages unsigned int
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

nr_pages is an int or unsigned int almost everywhere already. Also, all
the meta-data ring_buffer_desc, ring_buffer_cpu_meta and
trace_buffer_meta allowing to share information about the ring buffer
are already capping this value to 32-bits.

Make ring_buffer_per_cpu::nr_pages unsigned and align all the users to
it. As a side effect, this makes ring_buffer_per_cpu slightly smaller.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 990a904cefe8..2fccb950e593 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -519,7 +519,7 @@ struct ring_buffer_per_cpu {
 	arch_spinlock_t			lock;
 	struct lock_class_key		lock_key;
 	struct buffer_data_page		*free_page;
-	unsigned long			nr_pages;
+	unsigned int			nr_pages;
 	unsigned int			current_context;
 	struct list_head		*pages;
 	/* pages generation counter, incremented when the list changes */
@@ -561,7 +561,7 @@ struct ring_buffer_per_cpu {
 	struct ring_buffer_remote	*remote;
 
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
-	long				nr_pages_to_update;
+	int				nr_pages_to_update;
 	struct list_head		new_pages; /* new pages to add */
 	struct work_struct		update_pages_work;
 	struct completion		update_done;
@@ -1669,7 +1669,7 @@ static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
  * This is used to help find the next per cpu subbuffer within a mapped range.
  */
 static unsigned long
-rb_range_align_subbuf(unsigned long addr, int subbuf_size, int nr_subbufs)
+rb_range_align_subbuf(unsigned long addr, int subbuf_size, unsigned int nr_subbufs)
 {
 	addr += sizeof(struct ring_buffer_cpu_meta) +
 		sizeof(int) * nr_subbufs;
@@ -1679,13 +1679,13 @@ rb_range_align_subbuf(unsigned long addr, int subbuf_size, int nr_subbufs)
 /*
  * Return the ring_buffer_meta for a given @cpu.
  */
-static void *rb_range_meta(struct trace_buffer *buffer, int nr_pages, int cpu)
+static void *rb_range_meta(struct trace_buffer *buffer, unsigned int nr_pages, int cpu)
 {
 	int subbuf_size = rb_subbuf_size(buffer);
 	struct ring_buffer_cpu_meta *meta;
 	struct ring_buffer_meta *bmeta;
+	unsigned int nr_subbufs;
 	unsigned long ptr;
-	int nr_subbufs;
 
 	bmeta = buffer->meta;
 	if (!bmeta)
@@ -1840,7 +1840,7 @@ static bool rb_meta_init(struct trace_buffer *buffer, int scratch_size)
  * must be the same.
  */
 static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
-			      struct trace_buffer *buffer, int nr_pages,
+			      struct trace_buffer *buffer, unsigned int nr_pages,
 			      unsigned long *subbuf_mask)
 {
 	int subbuf_size = PAGE_SIZE;
@@ -2231,7 +2231,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	}
 }
 
-static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages, int scratch_size)
+static void rb_range_meta_init(struct trace_buffer *buffer, unsigned int nr_pages, int scratch_size)
 {
 	struct ring_buffer_cpu_meta *meta;
 	unsigned long *subbuf_mask;
@@ -2331,8 +2331,8 @@ static int rbm_show(struct seq_file *m, void *v)
 			   rb_meta_subbuf_idx(meta, (void *)meta->head_buffer));
 		seq_printf(m, "commit_buffer: %d\n",
 			   rb_meta_subbuf_idx(meta, (void *)meta->commit_buffer));
-		seq_printf(m, "subbuf_size:   %d\n", meta->subbuf_size);
-		seq_printf(m, "nr_subbufs:    %d\n", meta->nr_subbufs);
+		seq_printf(m, "subbuf_size:   %u\n", meta->subbuf_size);
+		seq_printf(m, "nr_subbufs:    %u\n", meta->nr_subbufs);
 		return 0;
 	}
 
@@ -2417,7 +2417,7 @@ static void *ring_buffer_desc_page(struct ring_buffer_desc *desc, unsigned int p
 }
 
 static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
-		long nr_pages, struct list_head *pages)
+			       unsigned int nr_pages, struct list_head *pages)
 {
 	struct trace_buffer *buffer = cpu_buffer->buffer;
 	struct ring_buffer_cpu_meta *meta = NULL;
@@ -2520,7 +2520,7 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 }
 
 static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
-			     unsigned long nr_pages)
+			     unsigned int nr_pages)
 {
 	LIST_HEAD(pages);
 
@@ -2545,7 +2545,7 @@ static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 }
 
 static struct ring_buffer_per_cpu *
-rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
+rb_allocate_cpu_buffer(struct trace_buffer *buffer, unsigned int nr_pages, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer __free(kfree) =
 		alloc_cpu_buffer(cpu);
@@ -2773,7 +2773,7 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 					 struct ring_buffer_remote *remote)
 {
 	struct trace_buffer *buffer __free(kfree) = NULL;
-	long nr_pages;
+	unsigned int nr_pages;
 	int subbuf_size;
 	int bsize;
 	int cpu;
@@ -3037,12 +3037,12 @@ static inline unsigned long rb_page_write(struct buffer_page *bpage)
 }
 
 static bool
-rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
+rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned int nr_pages)
 {
 	struct list_head *tail_page, *to_remove, *next_page;
 	struct buffer_page *to_remove_page, *tmp_iter_page;
 	struct buffer_page *last_page, *first_page;
-	unsigned long nr_removed;
+	unsigned int nr_removed;
 	unsigned long head_bit;
 	int page_entries;
 
@@ -3264,7 +3264,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 			int cpu_id)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	unsigned long nr_pages;
+	unsigned int nr_pages;
 	int cpu, err;
 
 	/*
@@ -6522,7 +6522,7 @@ unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return 0;
 
-	return rb_subbuf_capacity(buffer) * buffer->buffers[cpu]->nr_pages;
+	return (unsigned long)rb_subbuf_capacity(buffer) * buffer->buffers[cpu]->nr_pages;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_size);
 
@@ -7412,8 +7412,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct buffer_page *bpage, *tmp;
 	unsigned int old_capacity;
+	unsigned int nr_pages;
 	int old_order;
-	int nr_pages;
 	int psize;
 	int err;
 	int cpu;
@@ -7459,8 +7459,9 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		}
 
 		/* Update the number of pages to match the new size */
-		nr_pages = old_capacity * buffer->buffers[cpu]->nr_pages;
-		nr_pages = DIV_ROUND_UP(nr_pages, rb_subbuf_capacity(buffer));
+		nr_pages = DIV_ROUND_UP(
+			(unsigned long)old_capacity * buffer->buffers[cpu]->nr_pages,
+			rb_subbuf_capacity(buffer));
 
 		/* we need a minimum of two pages */
 		if (nr_pages < 2)
@@ -7702,8 +7703,8 @@ static int __rb_inc_dec_mapped(struct ring_buffer_per_cpu *cpu_buffer,
 static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 			struct vm_area_struct *vma)
 {
-	unsigned long nr_subbufs, nr_pages, nr_vma_pages, pgoff = vma->vm_pgoff;
-	unsigned int subbuf_pages, subbuf_order;
+	unsigned long nr_pages, nr_vma_pages, pgoff = vma->vm_pgoff;
+	unsigned int nr_subbufs, subbuf_pages, subbuf_order;
 	struct page **pages __free(kfree) = NULL;
 	int p = 0, s = 0;
 	int err;
@@ -8033,9 +8034,9 @@ static void rb_cpu_sync(void *data)
 int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node)
 {
 	struct trace_buffer *buffer;
-	long nr_pages_same;
+	unsigned int nr_pages;
+	int nr_pages_same;
 	int cpu_i;
-	unsigned long nr_pages;
 
 	buffer = container_of(node, struct trace_buffer, node);
 	if (cpumask_test_cpu(cpu, buffer->cpumask))
-- 
2.55.0.691.gc56d675ccc-goog

