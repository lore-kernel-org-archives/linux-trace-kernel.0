Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7611F9F73
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498758; cv=none; b=jGEzzG1EZcZq2451HG10im4zSUsiyvAm9rvfGjB+l1q2QfQYcjb8r12hcNaLLvYdxee5pEqCsMJksnfZGm2BAmOc1MIxfqv/JAxqdTvhpUYm+GtJ36hSn7OGTtvL06pIDnhfN1inEfI9MjriG2LWYyflRG0SZoJecSIvEGgWM44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498758; c=relaxed/simple;
	bh=3Gyq8aA8JN0nK+7FXBMD7LVv1KmJh45YjAAyxT/uPCw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L0Jcat+nudyZLQQm4x+d9x5uBVizXN8sLkRYU2vr9/jfua8Bxd+in9S8OJug+5lrPiLlCqVMjQu1k5kxBWFMrvN6Tc/RGHzAw5W+E20GkqJBnqGHABY7N6GL5ECkFb9SvGAXDxm2Df0p85PvqraqJkzLJF9gS1uhkFKkX8U/EN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lao6h/qg; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lao6h/qg"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-401dbafbcfaso1446369f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759498753; x=1760103553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cusWrm7Pe7Vzh2zNqiDKt7LKbdzyFf6LREbhhod2FBw=;
        b=Lao6h/qgwbSPXuxKRlQhRIR+tILvaqUoMprgAexnGedblVpa3CqYF8Fllpf4YNE0ne
         zxeC2+EtY+F7UKlzUXri18vu/fc5k4dTJ4RXC8zq6vfYV0L5UzWiF7NTC8aQNIdI1RSF
         yteLmgrsQ66+wrypH27mbdiLTy2x7uTjxFUsMSMM+Um/O4VXZwElcxVRRcmbzLMnypAx
         fiefd5DAgpTQv4UY8MJ/vbnxq79Vty4PwWgruSVx5BagU8qoQ2/3fS1rDBA9K47qFLrQ
         L/XJYLpdmLLFALw5A3ANZuNSa883W9ABoK3TJw0Jdjniu9Pwo/jrfNPf5xMenJeg7wDc
         UkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759498753; x=1760103553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cusWrm7Pe7Vzh2zNqiDKt7LKbdzyFf6LREbhhod2FBw=;
        b=fiQtRRezI1Q2lEnPgoLxyB20iUziiFvWrJuIOus5gDPNoAQ+XtEFEWpkNMK8za3X+5
         OdX1oM6sbXE/lUr7QSdyoQWhnMR/zvoLFMlToLLQyfsfZpKPUWzEXKIDrh6E3spLdgij
         YToW+/oEc6+pvvQ76MbJMPI8aVYigJkwQrkm63nnw1eEyYnCGAewQKzfCuVbV+swwbBZ
         qoLRqE5JFF3ATTeuED2TbppHEm58k2NwJYUoMSJ3VJfsfIc7tqkqbm5FSAqBsQ3UThLi
         J8PhoIvezAEu0RR/Ua0mO4wzvN8j0WJaex1KoMRxwDUaUf1+8/vAEEyiPfBw5JKM6aSU
         WeUA==
X-Forwarded-Encrypted: i=1; AJvYcCW93koAMSqOBXx3wladqFoKDwrrtc7wC7CeZEJ3BvCAvckMhfvsiaeRMgpBpkv0KmvgRT1Q5EUs3y5eaoJU60Y7THw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqEwFkj3rarjOnlzg+CvO21k/35VXRBt75NO9ELUAkHxc8kzVk
	VBzypcd0UuD//bwYuumVrWdnKkqe/3JdMsDZo5wgqUWYdC5Iuei/xgiEtdfTqXz82kCk0C6YlGg
	5kJU+9XTMrLhE7S9P0piGhQ==
X-Google-Smtp-Source: AGHT+IF6GiKCqwKfjKEeuxZgNsXAZSGVRxvCwcB1YwHTIPjTMo5AijDWEtVQrQi9EZhBvqgSIyLZKQ4QheeyH+xU
X-Received: from wmby13.prod.google.com ([2002:a05:600c:c04d:b0:46e:3771:b9c9])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:18a9:b0:404:ac77:6598 with SMTP id ffacd0b85a97d-4256713ac9dmr2185339f8f.11.1759498753278;
 Fri, 03 Oct 2025 06:39:13 -0700 (PDT)
Date: Fri,  3 Oct 2025 14:38:14 +0100
In-Reply-To: <20251003133825.2068970-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003133825.2068970-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003133825.2068970-18-vdonnefort@google.com>
Subject: [PATCH v7 17/28] tracing: load/unload page callbacks for simple_ring_buffer
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
index f324df2f875b..ecd0e988c699 100644
--- a/include/linux/simple_ring_buffer.h
+++ b/include/linux/simple_ring_buffer.h
@@ -110,4 +110,11 @@ int simple_ring_buffer_reset(struct simple_rb_per_cpu *cpu_buffer);
  */
 int simple_ring_buffer_swap_reader_page(struct simple_rb_per_cpu *cpu_buffer);
 
+int __simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer,
+			      struct simple_buffer_page *bpages,
+			      const struct ring_buffer_desc *desc,
+			      void *(*load_page)(unsigned long va),
+			      void (*unload_page)(void *va));
+void __simple_ring_buffer_unload(struct simple_rb_per_cpu *cpu_buffer,
+				 void (*unload_page)(void *));
 #endif
diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring_buffer.c
index 20e3cd6071a2..c2ec6017c37c 100644
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
@@ -338,10 +338,15 @@ int simple_ring_buffer_reset(struct simple_rb_per_cpu *cpu_buffer)
 	return 0;
 }
 
-int simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer, struct simple_buffer_page *bpages,
-			    const struct ring_buffer_desc *desc)
+int __simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer,
+			      struct simple_buffer_page *bpages,
+			      const struct ring_buffer_desc *desc,
+			      void *(*load_page)(unsigned long va),
+			      void (*unload_page)(void *va))
 {
 	struct simple_buffer_page *bpage = bpages;
+	int ret = 0;
+	void *page;
 	int i;
 
 	/* At least 1 reader page and two pages in the ring-buffer */
@@ -350,15 +355,22 @@ int simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer, struct simple_
 
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
@@ -368,7 +380,13 @@ int simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer, struct simple_
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
@@ -377,6 +395,14 @@ int simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer, struct simple_
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
@@ -384,19 +410,46 @@ int simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer, struct simple_
 	/* The last init'ed page points to the head page */
 	simple_bpage_set_head_link(bpage);
 
+	cpu_buffer->bpages = bpages;
+
 	return 0;
 }
 
-void simple_ring_buffer_unload(struct simple_rb_per_cpu *cpu_buffer)
+static void *__load_page(unsigned long page)
 {
+	return (void *)page;
+}
+
+static void __unload_page(void *page) { }
+
+int simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer, struct simple_buffer_page *bpages,
+			    const struct ring_buffer_desc *desc)
+{
+	return __simple_ring_buffer_init(cpu_buffer, bpages, desc, __load_page, __unload_page);
+}
+
+void __simple_ring_buffer_unload(struct simple_rb_per_cpu *cpu_buffer,
+				 void (*unload_page)(void *))
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
 
+void simple_ring_buffer_unload(struct simple_rb_per_cpu *cpu_buffer)
+{
+	return __simple_ring_buffer_unload(cpu_buffer, __unload_page);
+}
+
 int simple_ring_buffer_enable_tracing(struct simple_rb_per_cpu *cpu_buffer, bool enable)
 {
 	if (!simple_rb_loaded(cpu_buffer))
-- 
2.51.0.618.g983fd99d29-goog

