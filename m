Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7B3287272
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424271; cv=none; b=PFY9BxhQ2nYj9vjEus0i3p7RzumUdoil3gmyQiYiNnv17rnJ9PqGXJ9Dij64kk6kMWxUVXV4WMVi2y59UH2Diec49kMy+ukAenw7wkX/C5oA72hxPixo1S198rcP37Fj424QWmFIn54ry2nVoCuhLPRao65sG+cg3l4F+MtcZ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424271; c=relaxed/simple;
	bh=tphl6mAsqf9TdCql8VKZuCvMxwvX6h4t9eRuE9p+KfI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a2a0n53SMtBY5gE4Wu/zEOqcxPc7zF31NDTQuCOmhdxU5PLqREN1Uw7V1paI30VtfW6COWCoqb/w9QtUH0xoVMlGsZjIrK0oV9WaYFyQIMAphG0/ryPs8/JskYFcDHWgGHD/1kuAJGdpVgurbxI0OWW4oB9Pq0+fFV+2Vb5MN9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zv/vxad0; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zv/vxad0"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4802bb29400so77855875e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 02:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769424268; x=1770029068; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WDghCh0fr0GDHLlC3mDjOKrkpIDo4KOlE5bpU6iht6g=;
        b=zv/vxad0aeWeW+GZrNF9uyIsY4fju3dg/xBj3jisN9cdC0HNQoRfoFuHBKSanPFONU
         QHHHoZmTFRfupzOnVsQyR4N2CdBSIU1h7I+wKfnXVdFewR3Y3JY3p++HpDt+2u5mZAiO
         scnsJPmuKYvwewr5Q4lo2z/MJnilLrHROGwF+BB9AtAaTxAsnOdUnPs3rNKVKu1ckHxC
         TckrjUK6tCSigw9oYbdnfu9H8TMl98gqrxk9vcjwh26E+TZRXvQ6TYB5SP1mGjWuBd6P
         5uXWtbVsJ4v60N6aS7GgYhZLCBZBrkQKvJ3c8LhXW+EtEhXPsttZ3yD8SVai+VCaZSjs
         nWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424268; x=1770029068;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDghCh0fr0GDHLlC3mDjOKrkpIDo4KOlE5bpU6iht6g=;
        b=VwAVDT9KyK4sszs5hVRBdTGU8sIjq2nvqyXV6HIe+52CQdA3l+C/Gb95MwW7CbWJ2p
         u0Lqv2ZvAbnEYQ3TrnKzNWLaNnBDjC1kX22Dd/rGYLKMPUapb8zq7uE5Ov7U8ATdgksx
         f8ODTXyIgJYQyeswZEomwSHo37m+AXhSYhRDIyIY/qQAu1hSC+tvQ1DTngqDO0rIjF1C
         Z7BeHzEgYmhBN6KpJBNIcNqtHb34J6NgfpDYiRJQrDkCG0xluuCbmjgOMiuG7wB1RxH0
         a6L58FEWr+4zMvgK3PeFaLZPG1K/Hj7idIisk2kTtTkjAD/RkN9nlKtGGH1SJhJAtmT8
         Ar3A==
X-Forwarded-Encrypted: i=1; AJvYcCUE658Xc1Lwx0rTcjXzddjPMNrpoQlACiSxbLZMEfDrX/oOPNEy8712TlcncgMpkGy0jYFVKQzokuIP+ZjGCSvnNvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJJEOMAT1Iz3XmC5QAsL34ci8IZF0Rye4rnaCanK0A1BEQiQT1
	lUYwmA35cDlSR/24TZcIfztxK35t6jXvNsLrbzcEFrd5/AS0XjiWPQl8diFCz3yGbGQgKRA+Es7
	Ef4MKNlgR33g5KzhjDxKJsg==
X-Received: from wmcq10.prod.google.com ([2002:a05:600c:c10a:b0:477:aa9e:db24])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8905:b0:47d:5e02:14e5 with SMTP id 5b1f17b1804b1-4805d9664a3mr42612985e9.5.1769424267888;
 Mon, 26 Jan 2026 02:44:27 -0800 (PST)
Date: Mon, 26 Jan 2026 10:43:51 +0000
In-Reply-To: <20260126104419.1649811-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126104419.1649811-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126104419.1649811-3-vdonnefort@google.com>
Subject: [PATCH v10 02/30] ring-buffer: Store bpage pointers into subbuf_ids
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The subbuf_ids field allows to point to a specific page from the
ring-buffer based on its ID. As a preparation or the upcoming
ring-buffer remote support, point this array to the buffer_page instead
of the buffer_data_page.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1187d632dd5d..a5d11487337e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -554,7 +554,7 @@ struct ring_buffer_per_cpu {
 	unsigned int			mapped;
 	unsigned int			user_mapped;	/* user space mapping */
 	struct mutex			mapping_lock;
-	unsigned long			*subbuf_ids;	/* ID to subbuf VA */
+	struct buffer_page		**subbuf_ids;	/* ID to subbuf VA */
 	struct trace_buffer_meta	*meta_page;
 	struct ring_buffer_cpu_meta	*ring_meta;
 
@@ -7013,7 +7013,7 @@ static void rb_free_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 }
 
 static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
-				   unsigned long *subbuf_ids)
+				   struct buffer_page **subbuf_ids)
 {
 	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
 	unsigned int nr_subbufs = cpu_buffer->nr_pages + 1;
@@ -7022,7 +7022,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 	int id = 0;
 
 	id = rb_page_id(cpu_buffer, cpu_buffer->reader_page, id);
-	subbuf_ids[id++] = (unsigned long)cpu_buffer->reader_page->page;
+	subbuf_ids[id++] = cpu_buffer->reader_page;
 	cnt++;
 
 	first_subbuf = subbuf = rb_set_head_page(cpu_buffer);
@@ -7032,7 +7032,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 		if (WARN_ON(id >= nr_subbufs))
 			break;
 
-		subbuf_ids[id] = (unsigned long)subbuf->page;
+		subbuf_ids[id] = subbuf;
 
 		rb_inc_page(&subbuf);
 		id++;
@@ -7041,7 +7041,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 
 	WARN_ON(cnt != nr_subbufs);
 
-	/* install subbuf ID to kern VA translation */
+	/* install subbuf ID to bpage translation */
 	cpu_buffer->subbuf_ids = subbuf_ids;
 
 	meta->meta_struct_len = sizeof(*meta);
@@ -7197,13 +7197,15 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 	}
 
 	while (p < nr_pages) {
+		struct buffer_page *subbuf;
 		struct page *page;
 		int off = 0;
 
 		if (WARN_ON_ONCE(s >= nr_subbufs))
 			return -EINVAL;
 
-		page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
+		subbuf = cpu_buffer->subbuf_ids[s];
+		page = virt_to_page((void *)subbuf->page);
 
 		for (; off < (1 << (subbuf_order)); off++, page++) {
 			if (p >= nr_pages)
@@ -7230,7 +7232,8 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		    struct vm_area_struct *vma)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	unsigned long flags, *subbuf_ids;
+	struct buffer_page **subbuf_ids;
+	unsigned long flags;
 	int err;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
@@ -7254,7 +7257,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	if (err)
 		return err;
 
-	/* subbuf_ids include the reader while nr_pages does not */
+	/* subbuf_ids includes the reader while nr_pages does not */
 	subbuf_ids = kcalloc(cpu_buffer->nr_pages + 1, sizeof(*subbuf_ids), GFP_KERNEL);
 	if (!subbuf_ids) {
 		rb_free_meta_page(cpu_buffer);
-- 
2.52.0.457.g6b5491de43-goog

