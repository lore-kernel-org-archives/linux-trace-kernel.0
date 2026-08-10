Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E763DDDD0
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366637; cv=none; b=snT8GnjjAxGQFg0hfO3zqyWH6whLZYOY0Vr24K+eAnc9kcPEiPbM2pVeDtBWu8vOu0YE8VarmYfR8HPASIxq+c+cRrXvEPu4EgisiU304ehUoPnzkrJtZGUsQnhk3My3u8JcvQEuJVoPPY1pXyogEhYninDPkWXkeLgyAiizVsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366637; c=relaxed/simple;
	bh=1/9PUPvAHN/Dsq55N/EeJHPX9nEN+6cuH56JseQbDl0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n2JNGjiyemu4kUn3t8K0bbdUDQUCYbcX98kBCNMQWBJX0Anr7z15PWUzMdnWCKO52j/l3sW/Y9Xy6X3H9XLWTPTyYWFoXKN7dii3E+CtbW0QQj60ouINzYNQLYpeLd1NFwuwZkhOkrOdS2IdQoYOxpMyKNCi/YF/GakPb1/w29I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HKdq6LB1; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HKdq6LB1"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493fa6e28a7so19865955e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 05:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786366634; x=1786971434; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RySXVYR53jNrb3m6dzhVWv03bYvMPLV77A9VcDGyRFY=;
        b=HKdq6LB1MSD5e4/OsSUSfNYGCLnzWMmsdA/TGpsyQrO+AzSjCuh46Q/eq600ExuvvV
         9aFxexlsCvd1eXBSTwiwWybg8sgq4AMTFh4O0vE7SkUgicTtTrR1bBxQBtTKn05QiBAk
         ffmTuxUr8d8TzFabxDvfK0XdXfDeJiNgabrP56JsuPIwgQeDNnhZrkYKBCWQzEeXka5j
         hXfiuan/BqviheGbXWtGHuUPTZQsjP/QdnYxuSm9Pj0TCTBeBZwNaR+pCs4Wtf/8DWgt
         AEuapPII+jbdlWLr/jViOG0x9PKWYy2ZqEQ3B5u1JrujhX1svDT4h+4aUIfki086ci1Y
         lAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786366634; x=1786971434;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RySXVYR53jNrb3m6dzhVWv03bYvMPLV77A9VcDGyRFY=;
        b=NugxErYB42fnlPgn6oLxEvj+tqJ3z3Y+d+8n++XAiOiecyDrggcnKtcjP2rQwS1Hbk
         xXS7hYniJeR2rtWhdJCpwhsQTyUu9YbXHEazUMW63mTRPJCFzuLQ+F/UKiGxdaHUIwuq
         FY5MrxNbZZ7fQ979WMfbziUXm49lX+uvex0t/JOcKWw72uzoy2Fc7l88PLMHKmVbKmTx
         YhQwYxNPtDAX7m9paykT1fqc9QJCT/PvXuFCd2CGnybzvIG1rpoY3nThJtIW1xYy8w7O
         zir8OEXADmlHugh/yvcjFZLDanWAV9ZjjN3aFJ425b6YiYFMiXiTugXbfKE9TrTz/3i5
         ruKA==
X-Forwarded-Encrypted: i=1; AHgh+Rr/yeMMvNTKRxAr6XQPMtCKfTEU5Nav7RG2F5I+4Vcy/6AHXe+3eEB9mtXl2P8ejx5ukjVLvsOIZV6aR/kxAbUpMQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ3K8/TIA/IGO0QgTIOLck2EWOGFh8AtgToVLqYsPjXosb6GCm
	t+8nblyWyb51TelsN/aWTsE+ISNG+NE+8P6EP5YViz6BS5Z/K0sncSe2t5jFSq+ckXtYULMUZ6k
	8N3BRycFnpJGjqjiJQIka6w==
X-Received: from wmsk20-n2.prod.google.com ([2002:a05:600d:8494:20b0:493:bba5:775a])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6089:b0:498:ee7:e407 with SMTP id 5b1f17b1804b1-499727e7eaemr30314455e9.17.1786366633964;
 Mon, 10 Aug 2026 05:57:13 -0700 (PDT)
Date: Mon, 10 Aug 2026 13:56:33 +0100
In-Reply-To: <20260810125633.3344684-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810125633.3344684-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260810125633.3344684-7-vdonnefort@google.com>
Subject: [PATCH 6/6] ring-buffer: Make nr_pages unsigned int
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
index 8dae55ddbe15..820ad72961fe 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -513,7 +513,7 @@ struct ring_buffer_per_cpu {
 	arch_spinlock_t			lock;
 	struct lock_class_key		lock_key;
 	struct buffer_data_page		*free_page;
-	unsigned long			nr_pages;
+	unsigned int			nr_pages;
 	unsigned int			current_context;
 	struct list_head		*pages;
 	/* pages generation counter, incremented when the list changes */
@@ -555,7 +555,7 @@ struct ring_buffer_per_cpu {
 	struct ring_buffer_remote	*remote;
 
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
-	long				nr_pages_to_update;
+	int				nr_pages_to_update;
 	struct list_head		new_pages; /* new pages to add */
 	struct work_struct		update_pages_work;
 	struct completion		update_done;
@@ -1635,7 +1635,7 @@ static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
  * This is used to help find the next per cpu subbuffer within a mapped range.
  */
 static unsigned long
-rb_range_align_subbuf(unsigned long addr, int subbuf_size, int nr_subbufs)
+rb_range_align_subbuf(unsigned long addr, int subbuf_size, unsigned int nr_subbufs)
 {
 	addr += sizeof(struct ring_buffer_cpu_meta) +
 		sizeof(int) * nr_subbufs;
@@ -1645,13 +1645,13 @@ rb_range_align_subbuf(unsigned long addr, int subbuf_size, int nr_subbufs)
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
@@ -1806,7 +1806,7 @@ static bool rb_meta_init(struct trace_buffer *buffer, int scratch_size)
  * must be the same.
  */
 static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
-			      struct trace_buffer *buffer, int nr_pages,
+			      struct trace_buffer *buffer, unsigned int nr_pages,
 			      unsigned long *subbuf_mask)
 {
 	int subbuf_size = PAGE_SIZE;
@@ -2197,7 +2197,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	}
 }
 
-static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages, int scratch_size)
+static void rb_range_meta_init(struct trace_buffer *buffer, unsigned int nr_pages, int scratch_size)
 {
 	struct ring_buffer_cpu_meta *meta;
 	unsigned long *subbuf_mask;
@@ -2297,8 +2297,8 @@ static int rbm_show(struct seq_file *m, void *v)
 			   rb_meta_subbuf_idx(meta, (void *)meta->head_buffer));
 		seq_printf(m, "commit_buffer: %d\n",
 			   rb_meta_subbuf_idx(meta, (void *)meta->commit_buffer));
-		seq_printf(m, "subbuf_size:   %d\n", meta->subbuf_size);
-		seq_printf(m, "nr_subbufs:    %d\n", meta->nr_subbufs);
+		seq_printf(m, "subbuf_size:   %u\n", meta->subbuf_size);
+		seq_printf(m, "nr_subbufs:    %u\n", meta->nr_subbufs);
 		return 0;
 	}
 
@@ -2383,14 +2383,14 @@ static void *ring_buffer_desc_page(struct ring_buffer_desc *desc, unsigned int p
 }
 
 static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
-		long nr_pages, struct list_head *pages)
+			       unsigned int nr_pages, struct list_head *pages)
 {
 	struct trace_buffer *buffer = cpu_buffer->buffer;
 	struct ring_buffer_cpu_meta *meta = NULL;
 	struct buffer_page *bpage, *tmp;
 	bool user_thread = current->mm != NULL;
 	struct ring_buffer_desc *desc = NULL;
-	long i;
+	unsigned int i;
 
 	/*
 	 * Check if the available memory is there first.
@@ -2486,7 +2486,7 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 }
 
 static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
-			     unsigned long nr_pages)
+			     unsigned int nr_pages)
 {
 	LIST_HEAD(pages);
 
@@ -2511,7 +2511,7 @@ static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 }
 
 static struct ring_buffer_per_cpu *
-rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
+rb_allocate_cpu_buffer(struct trace_buffer *buffer, unsigned int nr_pages, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer __free(kfree) =
 		alloc_cpu_buffer(cpu);
@@ -2739,7 +2739,7 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 					 struct ring_buffer_remote *remote)
 {
 	struct trace_buffer *buffer __free(kfree) = NULL;
-	long nr_pages;
+	unsigned int nr_pages;
 	int subbuf_size;
 	int bsize;
 	int cpu;
@@ -3003,12 +3003,12 @@ static inline unsigned long rb_page_write(struct buffer_page *bpage)
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
 
@@ -3230,7 +3230,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 			int cpu_id)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	unsigned long nr_pages;
+	unsigned int nr_pages;
 	int cpu, err;
 
 	/*
@@ -6489,7 +6489,7 @@ unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return 0;
 
-	return rb_subbuf_capacity(buffer) * buffer->buffers[cpu]->nr_pages;
+	return (unsigned long)rb_subbuf_capacity(buffer) * buffer->buffers[cpu]->nr_pages;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_size);
 
@@ -7344,8 +7344,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct buffer_page *bpage, *tmp;
 	unsigned int old_capacity;
+	unsigned int nr_pages;
 	int old_order;
-	int nr_pages;
 	int psize;
 	int err;
 	int cpu;
@@ -7632,8 +7632,8 @@ static int __rb_inc_dec_mapped(struct ring_buffer_per_cpu *cpu_buffer,
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
@@ -7963,9 +7963,9 @@ static void rb_cpu_sync(void *data)
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
2.55.0.654.g21b8a5bc05-goog

