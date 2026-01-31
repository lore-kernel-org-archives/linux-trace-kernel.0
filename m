Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBAD3587BD
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 13:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769866181; cv=none; b=o1teFOzibOGr2LAIo1jezRNpeUiedHbA41oJnJ1BfUBoM7EJo6Fhp5nrkMvKW8STWrPq8i3t1rVjRRN9Oc51WNz5UJbLezHDJgb/g7GuLKCz9p/QWr3DdhRyrRoX3t3NT1gHrUHd/K591TNDOdVCSWxVdciFmkUcG/kq2PUwLa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769866181; c=relaxed/simple;
	bh=Sxuqk4VZ6qANkzLXQvZSMabSZh60GttBUsq4LMXjS1E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sKkRFIAQm+IjDdi0KLQrqGC4y7NV8SZ6KQtfWmQ8nvDyeDzNiHuWsgWff87+Oh/exZ6zaSkJ6UEjBMlswYqWBIeopCVo4+NkojF2DKhopcCcFPb5udtk0eU0DgearNJ7JIEk8iRrOj627wTBLdWE2ry4KUTj/QZe27AUEvvL9+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V2nslo7t; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V2nslo7t"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-4325b182e3cso1998616f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 05:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769866177; x=1770470977; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g1mZ+ZNkONBjyfcjUN3hF7cGlkHOrtSmM6+OwF5eQuA=;
        b=V2nslo7t1iXCqDj+kqE0eNseZ7KuhitQtpCr/P9oKvTUqx2/9PIhwbV2CsEzGZEYGp
         6Sq3hzTiMhcbWa531IuHNKk/gYjp/MogdFK5bJBxaLfFgC09OI12y+yDeaHF1Owjq7CA
         V4TzjD4CkVHTZUV4W2AQZ2DV8STi6h5wjUgSRROfaZbTTLFIlJo6JqPReD0Li3lDD/GF
         saBd0I4cPUP3IvBanGRHKA4guXxqS7LBlJCMAlXZobAM6fM/BKePFAuoqe2z0I6kU+i7
         rhujp2n8Bi0oVsvo6l5UHabxwyypvcbETzPrU2qU0Rpm53JZ0wR5fdoOvOiwmQd8kJMO
         dX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769866177; x=1770470977;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1mZ+ZNkONBjyfcjUN3hF7cGlkHOrtSmM6+OwF5eQuA=;
        b=oAIJzLdE7mXlobDh/o/DLELOV9fCUdzhd8VqQ7HPU5GVhSgHwwcFWciI7L9VkDwkZf
         0QozbobIrHzyB0cB8GwHo929IPK92m9HKzGepLg8WqE9Cio9C2Lmkq3c3zmQH2DHbN+Z
         heRCpvotmaLlS4Cm68rzQ5B6uUiMkczOsB590yUGYiPytduwWDzb558Op7/HnmIkQh3u
         bGu1hCS/OH7BKyCmbjIFtESZlV5KCFdYTFxzhVs9/yobfxGKbTXymt2Pq2Q3a8jc/RWU
         Oq+VoKK/bJBvd70YdPXjSTS6HLfhS2fGaugYmWKuArR9rOzLrJKdwxh5tx9Jke7dDUoI
         gHSA==
X-Forwarded-Encrypted: i=1; AJvYcCUb05EefDfZh+8HUnSxQGLS7PKHjIKX9+Q1nskvDW2pJeXbSR22eYYQi/n2vlBBNbG+rwkVvujQp2KRMH6x6w16toE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi41W9PpeVU1W7sAQeC6XhSEiy73z2hybqMx7YukyqVyVPru14
	5/uxIixnRCo4sSHHOf0FUcl+iGXAxA8KKWGROI4ZTN64kgoyHxIRoJ/gD9/B7NDsbB/z/dDCTDo
	C+07//NH5DNHjbPPfNQ+NiQ==
X-Received: from wrbek14.prod.google.com ([2002:a05:6000:220e:b0:435:f777:d162])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:3103:b0:435:dbbe:1130 with SMTP id ffacd0b85a97d-435f3a6ca95mr9449773f8f.11.1769866177281;
 Sat, 31 Jan 2026 05:29:37 -0800 (PST)
Date: Sat, 31 Jan 2026 13:28:35 +0000
In-Reply-To: <20260131132848.254084-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260131132848.254084-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260131132848.254084-18-vdonnefort@google.com>
Subject: [PATCH v11 17/30] tracing: load/unload page callbacks for simple_ring_buffer
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Add load/unload callback used for each admitted page in the ring-buffer.
This will be later useful for the pKVM hypervisor which uses a different
VA space and need to dynamically map/unmap the ring-buffer pages.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/simple_ring_buffer.h b/include/linux/simple_ring_buffer.h
index 2c4c0ae336bc..21aec556293e 100644
--- a/include/linux/simple_ring_buffer.h
+++ b/include/linux/simple_ring_buffer.h
@@ -54,4 +54,12 @@ int simple_ring_buffer_reset(struct simple_rb_per_cpu *cpu_buffer);
 
 int simple_ring_buffer_swap_reader_page(struct simple_rb_per_cpu *cpu_buffer);
 
+int simple_ring_buffer_init_mm(struct simple_rb_per_cpu *cpu_buffer,
+			       struct simple_buffer_page *bpages,
+			       const struct ring_buffer_desc *desc,
+			       void *(*load_page)(unsigned long va),
+			       void (*unload_page)(void *va));
+
+void simple_ring_buffer_unload_mm(struct simple_rb_per_cpu *cpu_buffer,
+				  void (*unload_page)(void *));
 #endif
diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring_buffer.c
index 88afd28ffef7..2adfeb5a8f4d 100644
--- a/kernel/trace/simple_ring_buffer.c
+++ b/kernel/trace/simple_ring_buffer.c
@@ -71,7 +71,7 @@ static void simple_bpage_reset(struct simple_buffer_page *bpage)
 	local_set(&bpage->page->commit, 0);
 }
 
-static void simple_bpage_init(struct simple_buffer_page *bpage, unsigned long page)
+static void simple_bpage_init(struct simple_buffer_page *bpage, void *page)
 {
 	INIT_LIST_HEAD(&bpage->link);
 	bpage->page = (struct buffer_data_page *)page;
@@ -376,19 +376,15 @@ int simple_ring_buffer_reset(struct simple_rb_per_cpu *cpu_buffer)
 }
 EXPORT_SYMBOL_GPL(simple_ring_buffer_reset);
 
-/**
- * simple_ring_buffer_init - Init @cpu_buffer based on @desc
- *
- * @cpu_buffer:	A simple_rb_per_cpu buffer to init, allocated by the caller.
- * @bpages:	Array of simple_buffer_pages, with as many elements as @desc->nr_page_va
- * @desc:	A ring_buffer_desc
- *
- * Returns: 0 on success or -EINVAL if the content of @desc is invalid
- */
-int simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer, struct simple_buffer_page *bpages,
-			    const struct ring_buffer_desc *desc)
+int simple_ring_buffer_init_mm(struct simple_rb_per_cpu *cpu_buffer,
+			       struct simple_buffer_page *bpages,
+			       const struct ring_buffer_desc *desc,
+			       void *(*load_page)(unsigned long va),
+			       void (*unload_page)(void *va))
 {
 	struct simple_buffer_page *bpage = bpages;
+	int ret = 0;
+	void *page;
 	int i;
 
 	/* At least 1 reader page and two pages in the ring-buffer */
@@ -397,15 +393,22 @@ int simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer, struct simple_
 
 	memset(cpu_buffer, 0, sizeof(*cpu_buffer));
 
-	cpu_buffer->bpages = bpages;
+	cpu_buffer->meta = load_page(desc->meta_va);
+	if (!cpu_buffer->meta)
+		return -EINVAL;
 
-	cpu_buffer->meta = (void *)desc->meta_va;
 	memset(cpu_buffer->meta, 0, sizeof(*cpu_buffer->meta));
 	cpu_buffer->meta->meta_page_size = PAGE_SIZE;
 	cpu_buffer->meta->nr_subbufs = cpu_buffer->nr_pages;
 
 	/* The reader page is not part of the ring initially */
-	simple_bpage_init(bpage, desc->page_va[0]);
+	page = load_page(desc->page_va[0]);
+	if (!page) {
+		unload_page(cpu_buffer->meta);
+		return -EINVAL;
+	}
+
+	simple_bpage_init(bpage, page);
 	bpage->id = 0;
 
 	cpu_buffer->nr_pages = 1;
@@ -415,7 +418,13 @@ int simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer, struct simple_
 	cpu_buffer->head_page = bpage + 1;
 
 	for (i = 1; i < desc->nr_page_va; i++) {
-		simple_bpage_init(++bpage, desc->page_va[i]);
+		page = load_page(desc->page_va[i]);
+		if (!page) {
+			ret = -EINVAL;
+			break;
+		}
+
+		simple_bpage_init(++bpage, page);
 
 		bpage->link.next = &(bpage + 1)->link;
 		bpage->link.prev = &(bpage - 1)->link;
@@ -424,6 +433,14 @@ int simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer, struct simple_
 		cpu_buffer->nr_pages = i + 1;
 	}
 
+	if (ret) {
+		for (i--; i >= 0; i--)
+			unload_page((void *)desc->page_va[i]);
+		unload_page(cpu_buffer->meta);
+
+		return ret;
+	}
+
 	/* Close the ring */
 	bpage->link.next = &cpu_buffer->tail_page->link;
 	cpu_buffer->tail_page->link.prev = &bpage->link;
@@ -431,25 +448,50 @@ int simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer, struct simple_
 	/* The last init'ed page points to the head page */
 	simple_bpage_set_head_link(bpage);
 
+	cpu_buffer->bpages = bpages;
+
 	return 0;
 }
-EXPORT_SYMBOL_GPL(simple_ring_buffer_init);
+
+static void *__load_page(unsigned long page)
+{
+	return (void *)page;
+}
+
+static void __unload_page(void *page) { }
 
 /**
- * simple_ring_buffer_unload - Prepare @cpu_buffer for deletion
+ * simple_ring_buffer_init - Init @cpu_buffer based on @desc
  *
- * @cpu_buffer:	A simple_rb_per_cpu that will be deleted.
+ * @cpu_buffer:	A simple_rb_per_cpu buffer to init, allocated by the caller.
+ * @bpages:	Array of simple_buffer_pages, with as many elements as @desc->nr_page_va
+ * @desc:	A ring_buffer_desc
+ *
+ * Returns: 0 on success or -EINVAL if the content of @desc is invalid
  */
-void simple_ring_buffer_unload(struct simple_rb_per_cpu *cpu_buffer)
+int simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer, struct simple_buffer_page *bpages,
+			    const struct ring_buffer_desc *desc)
 {
+	return simple_ring_buffer_init_mm(cpu_buffer, bpages, desc, __load_page, __unload_page);
+}
+EXPORT_SYMBOL_GPL(simple_ring_buffer_init);
+
+void simple_ring_buffer_unload_mm(struct simple_rb_per_cpu *cpu_buffer,
+				  void (*unload_page)(void *))
+{
+	int p;
+
 	if (!simple_rb_loaded(cpu_buffer))
 		return;
 
 	simple_rb_enable_tracing(cpu_buffer, false);
 
+	unload_page(cpu_buffer->meta);
+	for (p = 0; p < cpu_buffer->nr_pages; p++)
+		unload_page(cpu_buffer->bpages[p].page);
+
 	cpu_buffer->bpages = NULL;
 }
-EXPORT_SYMBOL_GPL(simple_ring_buffer_unload);
 
 /**
  * simple_ring_buffer_enable_tracing - Enable or disable writing to @cpu_buffer
@@ -459,6 +501,12 @@ EXPORT_SYMBOL_GPL(simple_ring_buffer_unload);
  *
  * Returns 0 on success or -ENODEV if @cpu_buffer was unloaded
  */
+void simple_ring_buffer_unload(struct simple_rb_per_cpu *cpu_buffer)
+{
+	return simple_ring_buffer_unload_mm(cpu_buffer, __unload_page);
+}
+EXPORT_SYMBOL_GPL(simple_ring_buffer_unload);
+
 int simple_ring_buffer_enable_tracing(struct simple_rb_per_cpu *cpu_buffer, bool enable)
 {
 	if (!simple_rb_loaded(cpu_buffer))
-- 
2.53.0.rc1.225.gd81095ad13-goog

