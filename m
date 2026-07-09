Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D6B42E00A
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Jul 2026 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612848; cv=none; b=oiThxxfiWh4sz6YlS0XWMYSDo7jew6WbT2aR6g4RW+NAhv67suBp34o8g/5nnq30x+PF3DMDIzlAuZ5rxnuUUdLYt6gDOOqpvY+rBIPp1HJPh8bAMoDYAXjATBLGY7Ge0oaZEkHoWTGeKpdkdQSSwNKYH5qt0oqXUdYilBCbeEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612848; c=relaxed/simple;
	bh=rLGcEWQLDsuBOlJtQaU04lVEFpTg/6Zm5TPaRWNb5r0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=klFWDCT4UyJ8q77ZaLkVJZe93qXcteSmxgDa/3TDpq4eSmRdEWwHgd9FkCvLI1fuY1yJmsd3MDCGpJY3Asn8MZssXsSPlLYpKwyf1DdOv2pEYnGYh2Wc38KVVRBltEIIfA/UUqhGkSCLyaTfp3lrIUzU3MAoBCqnwekuSfHQpMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VXNc0LW4; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VXNc0LW4"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-476608a9fefso830815f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Jul 2026 09:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783612846; x=1784217646; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Unj4WErTghUtss2IKhQJXeY0+igl+yHyxF7jgGiRQLQ=;
        b=VXNc0LW4FUqil+yJPfLaSxM6T1x6RhFjYWrpNqOccDPWIqoBqRFqkGSkLSpFPJqXNf
         xThvJN8+0PWM/JjqTHhbx6YkxKasy1RVHnV8wvWHoFWcEdNve/jpea9WqSB2LKQM2eAM
         2nblQwRIFbap5YKsO9cewBT/GJwh3rZ2f/OVEa5Ky/VywfsLugQnc0gYQrPuac2Y9d8j
         GAqpWLBIY8JuN3GNAuGWh0Cupmu7eEXbU7Q3HJLXkDeNmc9Dzm1Ojrk5ByN3beXsZjZu
         E+ZcqwO2OBFijND/EWZtMrWIqWkvOeQjfCIkamckOKX+mSa61fXe3jJrX1WrRGdYhK0k
         1u/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612846; x=1784217646;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Unj4WErTghUtss2IKhQJXeY0+igl+yHyxF7jgGiRQLQ=;
        b=GVzSygWJ2n1XdMD7ixJWz8sqzI7ocdJS/uX3Asta46iW1TAOZ3A4Cg9WZ+wZ/tGNs6
         xajSONC5LbxhiIH56rD1Y3/JVqM068QE22Gxw4t9GFU1T/uqMsA+nFm2Nm0YbLdso39c
         VSTecXToFQNhqo1fWZHuDJdDaQGq1rotc1sC2Jb3VoKwGxcz1E9wx4EVuLZz6roolJUU
         B5Puv7zu3aa94XDB7NVpGFSVNF4DiFc0qMAVcszsYhBIWiEtw7Z2DoREwFlHAVI/e+2h
         nj9dMBoS8ADtbBf9ilKYTg/WLHNWO3Y+WvlKHDreokxItMmLqsbYtA6rR0/Sx02crja+
         HJ/A==
X-Forwarded-Encrypted: i=1; AHgh+RrJrzlOisJMc0gv5Ec3cvpuRyVgTIH7Y74CyERpYHdRFjO97QGG0fZq9/Km9FJUaMw/L9yYmOZw32xTsOp+vB5UdF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9+aUHFYoheFQ7mRjuVp3sK7azY6y+/OV+Uvmi18Fq/MI5LX3S
	Ar0FQIbcggjaAZfuqgJVftIbD4/1nC0VkMtdh7jldCMFdlYH0XzIuPCIJGeMBYKbpxbIzyyylaY
	uFHGe8+k4N3a0GmZKx+HvXw==
X-Received: from wrbdl3.prod.google.com ([2002:a05:6000:b83:b0:470:4c2:a55f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2509:b0:475:da0e:744d with SMTP id ffacd0b85a97d-47df754dbc2mr4056983f8f.8.1783612845468;
 Thu, 09 Jul 2026 09:00:45 -0700 (PDT)
Date: Thu,  9 Jul 2026 17:00:16 +0100
In-Reply-To: <20260709160017.1729517-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709160017.1729517-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709160017.1729517-3-vdonnefort@google.com>
Subject: [PATCH v2 2/3] tracing/remotes: Fix struct_len in trace_remote_alloc_buffer()
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Pre-calculate desc->struct_len up-front in trace_remote_alloc_buffer()
with trace_buffer_desc_size() to fix double-counting.

While at it, use the accessor __first_ring_buffer_desc().

Fixes: 96e43537af54 ("tracing: Introduce trace remotes")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index d48042239d58..0f6ef5c36d84 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -979,27 +979,22 @@ EXPORT_SYMBOL_GPL(trace_remote_free_buffer);
 int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t desc_size, size_t buffer_size,
 			      const struct cpumask *cpumask)
 {
+	size_t min_desc_size = trace_buffer_desc_size(buffer_size, cpumask_weight(cpumask));
 	unsigned int nr_pages = max(DIV_ROUND_UP(buffer_size, PAGE_SIZE), 2UL) + 1;
-	void *desc_end = desc + desc_size;
 	struct ring_buffer_desc *rb_desc;
 	int cpu, ret = -ENOMEM;
 
-	if (desc_size < struct_size(desc, __data, 0))
+	if (desc_size < min_desc_size)
 		return -EINVAL;
 
 	desc->nr_cpus = 0;
-	desc->struct_len = struct_size(desc, __data, 0);
+	desc->struct_len = min_desc_size;
 
-	rb_desc = (struct ring_buffer_desc *)&desc->__data[0];
+	rb_desc = __first_ring_buffer_desc(desc);
 
 	for_each_cpu(cpu, cpumask) {
 		unsigned int id;
 
-		if ((void *)rb_desc + struct_size(rb_desc, page_va, nr_pages) > desc_end) {
-			ret = -EINVAL;
-			goto err;
-		}
-
 		rb_desc->cpu = cpu;
 		rb_desc->nr_page_va = 0;
 		rb_desc->meta_va = (unsigned long)__get_free_page(GFP_KERNEL);
@@ -1015,8 +1010,6 @@ int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t desc_size,
 
 			rb_desc->nr_page_va++;
 		}
-		desc->struct_len += offsetof(struct ring_buffer_desc, page_va);
-		desc->struct_len += struct_size(rb_desc, page_va, rb_desc->nr_page_va);
 		rb_desc = __next_ring_buffer_desc(rb_desc);
 	}
 
-- 
2.55.0.795.g602f6c329a-goog

