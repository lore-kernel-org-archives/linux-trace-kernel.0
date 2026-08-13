Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED3047F2FE
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786626732; cv=none; b=HLvsonW3u9EmtESCMvIWxIRyKFyvLeVpwqevGlqoOkMUjKd1KG0gBdWtdrWr6NDazCZisF5Fsx5YlavglBvbX3PO4j9x4r3s3qEHtxSAtXdFNJlSUReVa9ELGCO8xLQ6TUagPOcWXagxQHfafYSDhzqz012UR8s5xOlvuBOGkRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786626732; c=relaxed/simple;
	bh=nOJoLqrwTpDzBVqNbCTjH0DquY9mGdJ+fc0XSh/Fjjw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bt42ZMsJEXJY0g5STIbFIbP/dEdD2/b7UO7w61KzzUngarWmslvzkRCATOYXx8oWgSMhzgPNgXvLrE6yMGjZnpdbCMWtzX0ARdeqiAB79pVnY5dzFi0cmTfGI1xhcxTNjvHbb+4ut1RGRwSzDzjoS/+eP8kEnRAlKajEkxbb9D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OUlJeYh+; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OUlJeYh+"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f835ac1aeso1404980f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 06:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786626728; x=1787231528; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P7yxw9NdSYhmxpBqTEBYSZkvDkPpkkrxkZ9pUY5Xfdc=;
        b=OUlJeYh+8npGIQZYfDv/25mUkxTbC1Gylx4keehOUUg/EaT5twTUcy2kS4jV3/cw+P
         pKl7wKwqHOw47dppJxGCFOcE5FvTWRgjg+NyRDih6AguyYmPfpN2K5uJkzcQMGbzoj/E
         XUc4A6u69cfPJC7fM4mJEwpPNfG1L/pi726ujzIsgXRmKkLjmEkWSdHadUnQ3PEMrphz
         eydzfE9nEohXZSrz+bPHoZfs3G2IbGnBMPZNz36/QknJnTq+xYhM0qmHhXE/n5pveY55
         RIDufIPwDjcdHQwJWK1Te4OP1HoyqcfAmCEBn7ycexnSC5sdpPwxK1jBGsj4hyUkZPq9
         UB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786626728; x=1787231528;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P7yxw9NdSYhmxpBqTEBYSZkvDkPpkkrxkZ9pUY5Xfdc=;
        b=j3/2FW4uNvrZ0PK9ljxnN7hpLNjf1P4QetPqlwQ1WOKV9o/9k1opG7YpTxcJzkNRhn
         sZl5G2l1AO4so2P/vD2S5yP1GUSxY5ujnrHb7a66xze3qvwLs7v8U1E72HvT3PuNeU+y
         fcH9kxv7MN2Nb7w2kTiYJi2MkRUiK87bz12OW5D+1gVWkfqSzVjB+Ws5cpahpHqanSll
         FAf2VxOYfQ+Zej4SStmA53MzyF4VdKO5u3BPdhN9whTRdsN4C+62JXIObkmlT0xuGuWj
         jbwVRCsStYTWF5NNJ+LNxSYWCMzY+v7jT+W+rWeJkZ2p5J7V1yAPH643syKyidDGsArT
         EjsA==
X-Forwarded-Encrypted: i=1; AHgh+RoYlyvUeJ59EjaXpOhqGfSqyVeOidiPmqhd03/8DcoPmI33rD+zHhiPt+LmeDKflewRyLLTgc/itpFkdEBNW5cfneY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXzlpixWltbmjewyajb8vsYwJU/kahnhbgWSdVEMLrio6LMDIM
	O7gQVhItklxu6WtWHMDfab69A5SosgPxvuprtRPhRbKUNHo8R0yue3CZDJmxNo/33dco7Cf0CYm
	9VMA0+HdIUpX8rHFwETyOpQ==
X-Received: from wrsz9.prod.google.com ([2002:a5d:4c89:0:b0:481:511c:80e6])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:fa0a:0:b0:47f:9662:85fe with SMTP id ffacd0b85a97d-4815a0223cdmr6410816f8f.16.1786626727470;
 Thu, 13 Aug 2026 06:12:07 -0700 (PDT)
Date: Thu, 13 Aug 2026 14:11:52 +0100
In-Reply-To: <20260813131152.3589632-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813131152.3589632-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813131152.3589632-11-vdonnefort@google.com>
Subject: [PATCH v5 10/10] ring-buffer: Make nr_pages unsigned int
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

Where necessary, use unsigned long for the size to ensure
multiplications are not truncated to 32-bits.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 79459c99ce9a..d9dcd6d4e7cc 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -519,7 +519,7 @@ struct ring_buffer_per_cpu {
 	arch_spinlock_t			lock;
 	struct lock_class_key		lock_key;
 	struct buffer_data_read_page	free_page;
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
+rb_range_align_subbuf(unsigned long addr, unsigned long subbuf_size, unsigned int nr_subbufs)
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
-	int subbuf_size = rb_subbuf_size(buffer);
+	unsigned long subbuf_size = rb_subbuf_size(buffer);
 	struct ring_buffer_cpu_meta *meta;
 	struct ring_buffer_meta *bmeta;
+	unsigned int nr_subbufs;
 	unsigned long ptr;
-	int nr_subbufs;
 
 	bmeta = buffer->meta;
 	if (!bmeta)
@@ -1731,7 +1731,7 @@ static void *rb_range_meta(struct trace_buffer *buffer, int nr_pages, int cpu)
 /* Return the start of subbufs given the meta pointer */
 static void *rb_subbufs_from_meta(struct ring_buffer_cpu_meta *meta)
 {
-	int subbuf_size = meta->subbuf_size;
+	unsigned long subbuf_size = meta->subbuf_size;
 	unsigned long ptr;
 
 	ptr = (unsigned long)meta;
@@ -1746,8 +1746,7 @@ static void *rb_subbufs_from_meta(struct ring_buffer_cpu_meta *meta)
 static void *rb_range_buffer(struct ring_buffer_per_cpu *cpu_buffer, int idx)
 {
 	struct ring_buffer_cpu_meta *meta;
-	unsigned long ptr;
-	int subbuf_size;
+	unsigned long subbuf_size, ptr;
 
 	meta = rb_range_meta(cpu_buffer->buffer, 0, cpu_buffer->cpu);
 	if (!meta)
@@ -1840,10 +1839,10 @@ static bool rb_meta_init(struct trace_buffer *buffer, int scratch_size)
  * must be the same.
  */
 static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
-			      struct trace_buffer *buffer, int nr_pages,
+			      struct trace_buffer *buffer, unsigned int nr_pages,
 			      unsigned long *subbuf_mask)
 {
-	int subbuf_size = PAGE_SIZE;
+	unsigned long subbuf_size = PAGE_SIZE;
 	unsigned long buffers_start;
 	unsigned long buffers_end;
 	int i;
@@ -2231,7 +2230,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	}
 }
 
-static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages, int scratch_size)
+static void rb_range_meta_init(struct trace_buffer *buffer, unsigned int nr_pages, int scratch_size)
 {
 	struct ring_buffer_cpu_meta *meta;
 	unsigned long *subbuf_mask;
@@ -2331,8 +2330,8 @@ static int rbm_show(struct seq_file *m, void *v)
 			   rb_meta_subbuf_idx(meta, (void *)meta->head_buffer));
 		seq_printf(m, "commit_buffer: %d\n",
 			   rb_meta_subbuf_idx(meta, (void *)meta->commit_buffer));
-		seq_printf(m, "subbuf_size:   %d\n", meta->subbuf_size);
-		seq_printf(m, "nr_subbufs:    %d\n", meta->nr_subbufs);
+		seq_printf(m, "subbuf_size:   %u\n", meta->subbuf_size);
+		seq_printf(m, "nr_subbufs:    %u\n", meta->nr_subbufs);
 		return 0;
 	}
 
@@ -2417,7 +2416,7 @@ static void *ring_buffer_desc_page(struct ring_buffer_desc *desc, unsigned int p
 }
 
 static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
-		long nr_pages, struct list_head *pages)
+			       unsigned int nr_pages, struct list_head *pages)
 {
 	struct trace_buffer *buffer = cpu_buffer->buffer;
 	struct ring_buffer_cpu_meta *meta = NULL;
@@ -2520,7 +2519,7 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 }
 
 static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
-			     unsigned long nr_pages)
+			     unsigned int nr_pages)
 {
 	LIST_HEAD(pages);
 
@@ -2545,7 +2544,7 @@ static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 }
 
 static struct ring_buffer_per_cpu *
-rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
+rb_allocate_cpu_buffer(struct trace_buffer *buffer, unsigned int nr_pages, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer __free(kfree) =
 		alloc_cpu_buffer(cpu);
@@ -2703,7 +2702,7 @@ static void rb_test_inject_invalid_pages(struct trace_buffer *buffer)
 	struct buffer_data_page *dpage;
 	unsigned long entry_bytes = 0;
 	unsigned long ptr;
-	int subbuf_size;
+	unsigned long subbuf_size;
 	int invalid = 0;
 	int cpu;
 	int i;
@@ -2773,8 +2772,8 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 					 struct ring_buffer_remote *remote)
 {
 	struct trace_buffer *buffer __free(kfree) = NULL;
-	long nr_pages;
-	int subbuf_size;
+	unsigned long subbuf_size;
+	unsigned int nr_pages;
 	int bsize;
 	int cpu;
 	int ret;
@@ -3037,12 +3036,12 @@ static inline unsigned long rb_page_write(struct buffer_page *bpage)
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
 
@@ -3264,7 +3263,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 			int cpu_id)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	unsigned long nr_pages;
+	unsigned int nr_pages;
 	int cpu, err;
 
 	/*
@@ -4229,7 +4228,7 @@ rb_set_commit_to_write(struct ring_buffer_per_cpu *cpu_buffer)
 	 * assign the commit to the tail.
 	 */
  again:
-	max_count = cpu_buffer->nr_pages * 100;
+	max_count = cpu_buffer->nr_pages * 100UL;
 
 	while (cpu_buffer->commit_page != READ_ONCE(cpu_buffer->tail_page)) {
 		if (RB_WARN_ON(cpu_buffer, !(--max_count)))
@@ -6522,7 +6521,7 @@ unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return 0;
 
-	return rb_subbuf_capacity(buffer) * buffer->buffers[cpu]->nr_pages;
+	return (unsigned long)rb_subbuf_capacity(buffer) * buffer->buffers[cpu]->nr_pages;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_size);
 
@@ -7418,8 +7417,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct buffer_page *bpage, *tmp;
 	unsigned int old_capacity;
+	unsigned int nr_pages;
 	int old_order;
-	int nr_pages;
 	int psize;
 	int err;
 	int cpu;
@@ -7465,8 +7464,9 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		}
 
 		/* Update the number of pages to match the new size */
-		nr_pages = old_capacity * buffer->buffers[cpu]->nr_pages;
-		nr_pages = DIV_ROUND_UP(nr_pages, rb_subbuf_capacity(buffer));
+		nr_pages = DIV_ROUND_UP(
+			(unsigned long)old_capacity * buffer->buffers[cpu]->nr_pages,
+			rb_subbuf_capacity(buffer));
 
 		/* we need a minimum of two pages */
 		if (nr_pages < 2)
@@ -7708,8 +7708,8 @@ static int __rb_inc_dec_mapped(struct ring_buffer_per_cpu *cpu_buffer,
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
@@ -8039,9 +8039,9 @@ static void rb_cpu_sync(void *data)
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

