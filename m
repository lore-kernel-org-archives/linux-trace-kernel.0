Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07EE2C21DF
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790062197; cv=none; b=T90Yfkb5lBzS1VaHodG3iF05AewdPy5D/zLXBxpOrHm+dtDoBLslS67ZEBYrSobw0uvSp7dJemkscuq4X5mBPOHA0iLKk/Jeo0Fd6cqKuQkC5nehPt5VpNINXY/QFkvlUO/nKvAGfBlXbF/Kx5a/43o1YpHks4/ab0xJn5q7Bas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790062197; c=relaxed/simple;
	bh=iLd3VpRPihpMEoCTG7s8D3tK96vwfiQDnJH8Y0KX7K8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nevQTwiE4VHaBxVWq7KKfQB6MDoNvL1qS9aC3npjJYokA2MgBe2FHd0cfxndzs79pQu8Y/E8FmC7mNk8KHe1WYjnQF09rtRzsv9sDj8DVG0SyzAnb6BqJWOzNY5tV0XINHtXyeIxWN4zW/OD3CRSfP9JDDH8klso4ZwFe1EXdXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kdOmPfc9; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kdOmPfc9"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e6683d48fso38629795e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 00:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790062194; x=1790666994; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OQURR16ZQrDof5sRfE4GrcE/4jkuBXxswl7UtFVvz6Q=;
        b=kdOmPfc9AAffJ3Mu2gH/7jyQoTjQ9z1bDp3BerLzhvKMIdEfrr2CJKj5q6ag2hEEGa
         FuALioPSbn1INCaF8Z4Hg5AcXgaZBjwvD0wOC4F+ZHdovV0j5EwNhRlHRxkgnecqku2V
         ht0q9X5KAZRAdTUR4iw2763tN6nzd1Cn518AdqVXEbv3Cfa5y5mEfQWHqAuuIsFNOa7x
         QzvL76r3TakuA6yQ8bAjnFDKQdvY1NDTFAwI8/fplMTOb75ncjrL4a8RUB3sSY8EM1fw
         Z7J07I0DlNr/hlCOgBiigK/hb1qWEvR9lG+iEI2fIfe+9sDgiKB4DCI+g6rvnpAMYNNN
         6LFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790062194; x=1790666994;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OQURR16ZQrDof5sRfE4GrcE/4jkuBXxswl7UtFVvz6Q=;
        b=OEOvpRE1XmbatK79xXC/hVBeCDpcmJ3t/EMiqqd7tY1RSA+HGGrt0wu3jcIn4b7QNq
         vywwMgEJWWvTAjWSfqjmkb8I/jVB+h3sNsDqBfDg4G7iLgTZfMIHsonyIty4+32HSq85
         gfC0mY79jiqGl8G/7u28ohvlWVdiGbPWWq6bbUlxc1kmIqpw59Oa71/PQSkRUImV3nVC
         WSflOvL7LRDhRNkLTRsE0BxMuFt0Po3U3sEkKhjvYOqg/S74unzmzk/uFJahOSo4RPC0
         RZV18akQ4FKCZznvP6FlyVfirfrlom9yKqMuNkzk/VCEE2pq1v+kcCdXhxMcf+iDjph3
         u/yw==
X-Forwarded-Encrypted: i=1; AKwUvByxpA+QSsv/UrctxaA/2cqnUlh1Rd+VK4UjqHQH8IHpTMamdMk6BxXtnp9mCZ2OhvQG96dOsy/wIH1rJhVLjaT9+Oc=@vger.kernel.org
X-Gm-Message-State: AFuF++nFg4YpboNZhTF7cp7rioYAU/ua71hxiXMAu/j9z8zw3bE7usYF
	a7NxbhdOVwbc8TkVqDorBvJ6eOxR13tXCXFcgam7S5n84E7muEYrt3Xxqfj7BiANgu3oJef8PNN
	WVUrszmx1nbHCz1J0UCz29g==
X-Received: from wmqi16.prod.google.com ([2002:a05:600c:3550:b0:49e:7c6e:110f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:4453:10b0:49f:cbf1:e77b with SMTP id 5b1f17b1804b1-49fcbf1e9eamr110035115e9.10.1790062194147;
 Tue, 22 Sep 2026 00:29:54 -0700 (PDT)
Date: Tue, 22 Sep 2026 08:29:41 +0100
In-Reply-To: <20260922072944.1281427-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922072944.1281427-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922072944.1281427-2-vdonnefort@google.com>
Subject: [PATCH 1/4] ring-buffer: Use kvzalloc_objs for user mapping arrays
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Mapping a large trace buffer to user space requires allocating an array
of struct bpage and one of struct page. For large ring buffers, these
contiguous allocations are likely to fail with memory fragmentation.

Switch both to kvzalloc_objs() to use the vmalloc fallback under memory
pressure.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 04bb94c29f58..f9be87c2cc3d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7746,9 +7746,9 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 			struct vm_area_struct *vma)
 {
 	unsigned long nr_subbufs, nr_pages, nr_vma_pages;
-	pgoff_t pgoff = vma_start_pgoff(vma);
+	struct page **pages __free(kvfree) = NULL;
 	unsigned int subbuf_pages, subbuf_order;
-	struct page **pages __free(kfree) = NULL;
+	pgoff_t pgoff = vma_start_pgoff(vma);
 	int p = 0, s = 0;
 	int err;
 
@@ -7785,7 +7785,7 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 
 	nr_pages = nr_vma_pages;
 
-	pages = kzalloc_objs(*pages, nr_pages);
+	pages = kvzalloc_objs(*pages, nr_pages);
 	if (!pages)
 		return -ENOMEM;
 
@@ -7877,7 +7877,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		return err;
 
 	/* subbuf_ids includes the reader while nr_pages does not */
-	subbuf_ids = kcalloc(cpu_buffer->nr_pages + 1, sizeof(*subbuf_ids), GFP_KERNEL);
+	subbuf_ids = kvzalloc_objs(*subbuf_ids, cpu_buffer->nr_pages + 1);
 	if (!subbuf_ids) {
 		rb_free_meta_page(cpu_buffer);
 		return -ENOMEM;
@@ -7901,7 +7901,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		cpu_buffer->user_mapped = 1;
 		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 	} else {
-		kfree(cpu_buffer->subbuf_ids);
+		kvfree(cpu_buffer->subbuf_ids);
 		cpu_buffer->subbuf_ids = NULL;
 		rb_free_meta_page(cpu_buffer);
 		atomic_dec(&cpu_buffer->resize_disabled);
@@ -7958,7 +7958,7 @@ int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
 
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
-	kfree(cpu_buffer->subbuf_ids);
+	kvfree(cpu_buffer->subbuf_ids);
 	cpu_buffer->subbuf_ids = NULL;
 	rb_free_meta_page(cpu_buffer);
 	atomic_dec(&cpu_buffer->resize_disabled);
-- 
2.55.0.1082.g2b9226bbc0-goog

