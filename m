Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DD5342502
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771513404; cv=none; b=OP8u8JlYZsUOUL8H5jt/pUm4ejc7FtOa3Ay/TiRmsUlYVrWMDaD6L8ANcXzopX++/3LGTKg490FP+MwByAxBxG2BZWke+0E6vV3WhG4HoP7bLRbg0mImWuGzH5wgIl7p1dXkvGKz+svVrZBO1z0RcofmsymwFOCB3Bgi7N/xDzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771513404; c=relaxed/simple;
	bh=EoWxZ82AW5xJLupiOg+CFC0qrGUjxS6o93+2XTOyPJQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EKWaPYPE/UgHv9tNdTMdfr99HziW7wqeSi6j6wqQ9qltgemCH5NOhz2UqP56lHMM12Ntzx/v7THAjQLfz3nSu7N9MxBYjHZE9K4JKcY2RONSwIQW7EUZvL2aKp7DQojfiM8VMmZ+4LOMko7KkVXlYlvXFISHAyAhEwp0s3obZFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EkyXDsJt; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EkyXDsJt"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b8704795d25so90214866b.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 07:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771513400; x=1772118200; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=URJ3le00qFg4aOMtpOoA5s7sZJE+RppKHRUBLLdA0KU=;
        b=EkyXDsJtj5fymcUZiDeKYKLwFx5Ir1YfME2YEqgO1a/ScQZzoSCFqZXoGQTWkBM9lz
         gOWN5tW27O3moKfe9bYp625HA4FfGt/fmEJvJFaPeytxXIn6I+c2V7+ek34Q5imb1DMV
         0JgbcsDn7iBwyUGMZ+Msu/pTfA/NzOMPxW3zBvgMl6FSSZ3jNWOjrYeZNBJT5dHcOAH3
         p4zudl64hb7gmwqrsf5HEo4EtfhBDXV+Ty+dJ4eAt3uI0S+AsxHGPeDG5TZPkfI4+jMs
         8YGBR8KhWrLl+ATCKi/eztVBqofjzZWsM6DmOWKwz8EuFZUZg/oe6QbNrxNiKChL2lJI
         HR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771513400; x=1772118200;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=URJ3le00qFg4aOMtpOoA5s7sZJE+RppKHRUBLLdA0KU=;
        b=ilqdqfmgdpbV32kOfUl35PsY74ddpgOTshqvd+hZRcBJZF7fJIOfPcIWT6xOIxMZNa
         +HxAK3/BpWWLAritf1ZuJye2VH8CSi91uW33hcg8nl+fmerGuK5aP84SeqxHg2J90jax
         r0z98qArLkQ2uDIJaDnbksz4CI3UFGovVYDyrRmehEwQRtE7iA3r0uz909/g0XKfIkPA
         weTGclWrQT7S/E8wxJVolSKkkyrP8MLsBvz6jNNtlw7r2P6ixg41ZMKSYiVDvtBcvDjr
         DsfMmQQGl2fdwRcM6/+j8A11M4wWEzkDfYfWzl42z0cOH0X8SStvoAdU8XYGSYkTz1vI
         oVCw==
X-Forwarded-Encrypted: i=1; AJvYcCXwENAyoSNNEPPi8GcIhzqVVh/Ev4kz/ZcByn21VUsSX0EnTuA9D/xxWWl/0ofNFRVf5RkxvTrRqzJ16Kr7GiAfWWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSTzIlm75L2QyJMn0TVUbIj3ZSD8mtdgbA/0Unn0+Q3XvOMZMu
	+fdLU8zcx40TsB9bbMqy27S2VSRw+AbfvyPnVqEefAaiebVZwYyTlxKKdVYPLdplGMy4TstIBRV
	304BMsbj7Hs3BWHzajyvG6Q==
X-Received: from ejcm18.prod.google.com ([2002:a17:906:7d2:b0:b8f:8f61:e060])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:dc8c:b0:b7a:18ba:a63 with SMTP id a640c23a62f3a-b8fc3a3a05amr875259466b.19.1771513399894;
 Thu, 19 Feb 2026 07:03:19 -0800 (PST)
Date: Thu, 19 Feb 2026 15:02:39 +0000
In-Reply-To: <20260219150307.14538-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260219150307.14538-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.335.g19a08e0c02-goog
Message-ID: <20260219150307.14538-3-vdonnefort@google.com>
Subject: [PATCH v12 02/30] ring-buffer: Store bpage pointers into subbuf_ids
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

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 210c3811ba48..228c127b4489 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -555,7 +555,7 @@ struct ring_buffer_per_cpu {
 	unsigned int			mapped;
 	unsigned int			user_mapped;	/* user space mapping */
 	struct mutex			mapping_lock;
-	unsigned long			*subbuf_ids;	/* ID to subbuf VA */
+	struct buffer_page		**subbuf_ids;	/* ID to subbuf VA */
 	struct trace_buffer_meta	*meta_page;
 	struct ring_buffer_cpu_meta	*ring_meta;
 
@@ -7031,7 +7031,7 @@ static void rb_free_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 }
 
 static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
-				   unsigned long *subbuf_ids)
+				   struct buffer_page **subbuf_ids)
 {
 	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
 	unsigned int nr_subbufs = cpu_buffer->nr_pages + 1;
@@ -7040,7 +7040,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 	int id = 0;
 
 	id = rb_page_id(cpu_buffer, cpu_buffer->reader_page, id);
-	subbuf_ids[id++] = (unsigned long)cpu_buffer->reader_page->page;
+	subbuf_ids[id++] = cpu_buffer->reader_page;
 	cnt++;
 
 	first_subbuf = subbuf = rb_set_head_page(cpu_buffer);
@@ -7050,7 +7050,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 		if (WARN_ON(id >= nr_subbufs))
 			break;
 
-		subbuf_ids[id] = (unsigned long)subbuf->page;
+		subbuf_ids[id] = subbuf;
 
 		rb_inc_page(&subbuf);
 		id++;
@@ -7059,7 +7059,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 
 	WARN_ON(cnt != nr_subbufs);
 
-	/* install subbuf ID to kern VA translation */
+	/* install subbuf ID to bpage translation */
 	cpu_buffer->subbuf_ids = subbuf_ids;
 
 	meta->meta_struct_len = sizeof(*meta);
@@ -7215,13 +7215,15 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
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
@@ -7248,7 +7250,8 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		    struct vm_area_struct *vma)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	unsigned long flags, *subbuf_ids;
+	struct buffer_page **subbuf_ids;
+	unsigned long flags;
 	int err;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
@@ -7272,7 +7275,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	if (err)
 		return err;
 
-	/* subbuf_ids include the reader while nr_pages does not */
+	/* subbuf_ids includes the reader while nr_pages does not */
 	subbuf_ids = kcalloc(cpu_buffer->nr_pages + 1, sizeof(*subbuf_ids), GFP_KERNEL);
 	if (!subbuf_ids) {
 		rb_free_meta_page(cpu_buffer);
-- 
2.53.0.335.g19a08e0c02-goog

