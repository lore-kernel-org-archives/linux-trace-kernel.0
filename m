Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E95616BF
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789155614; cv=none; b=shuxNUbDD38r8nLvoY3UTF/DU7np/lORQYSyBhRRNNeJ/7qhB41bpShlEotUbOukVzhozx2/xhFEbWG8mIU79b4NP+fECR69Yp6m5dRkVGc03TyNGxtprI+qfqAUHNQ+9u6cdSUZOlK4o/C+U1s9G1TC4jBGToS4BgFwGAX5sCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789155614; c=relaxed/simple;
	bh=M6S66wtLpyo+yveSpW5ETKNDeT9jMUeCPYSrX3fey7U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=niY+zcRVEQx1csigDZhd6/dr0Pd+ZYS7U8mfL/Bx3kpXjHWwFDzcLdzX5wTJJPMAQ5jPfuUvHpK+ZPOrvH0dqcZ7O0qQc5e8qIKXD9QkzB847nS3qHC1KPoifRaq8QYJ3REn0z9V1QVNPOk2jYHoQp+LpPjhtyxqTVrXjgQCucc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AR1S8AnJ; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AR1S8AnJ"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49ccfad90f1so7655565e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 12:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789155594; x=1789760394; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/U2nrxWGjJiKW1yLpk0W49cM4yF19DMUslRfhb7YXzY=;
        b=AR1S8AnJlihss39i/NHT942fFdDRlQzKZk7acsFkXc5IDY5/jr9X+297YIRe5D4TX3
         Fu7BtDcd7O1QAxlPoMARMGYn1EQihbUtkwVSzUFnobPigSO+s+0711SvLppC8yYA7kSM
         S1mZL+Z4dDq9z1ORk4ddk+LHTtzS2QVbIl+pm36dxw+ZX9codVUyKw0h4jdvJwf917Ae
         oDlPi0oezp8TL9uNEDrfZJK9mCE++jzsoCPQ+HbVok2HZ7DPKNWXLx/y5JInwMIt3XhE
         eMVSkk8cpyTaXeMdMOX1jnwx/tUr4fUoS2GIghmE+AMgL6RFOT0Vw96whIIG8NZBFUcv
         ufyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789155594; x=1789760394;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/U2nrxWGjJiKW1yLpk0W49cM4yF19DMUslRfhb7YXzY=;
        b=IyzyX1rxmeMGTSFCkKO0vKq0ZQrYHzVSyOy7Bism2RQx+otLh7cHP0MbInTXW4j6yS
         sGT2e7N1Q5exS0xVU5SfaSv06QQPtmfGXKsck145dmrZZ/h+yt+cYZ8BXZi96uS0T5tA
         uPbEAgXqewAdSX/PArUrKHCAY01P5jQIFlvc4G/dSA99jqMXPK9gCO2nAUqJg3K1NtiH
         bZbVGp8AaE3DQTQrN1JRuUWyj7yL8L+AldJexyGsTuQf1lvsvB5aCNHYCRmL9aVBPupm
         b8LR0uf3Df6fX9yc1atukA0aj+hTS+JoiuX94X+XB8SV3TJ+A59VNZGhYwyrk/cwhoWF
         3U9w==
X-Forwarded-Encrypted: i=1; AKwUvByKpZyBgbWz10kSCXGfXxic0CmNKc+CvC8CA7XQFNctR8l3VX7Z33STrU4lkT6tokRO2wGamQtFGcvWBjm2ixh8Ypk=@vger.kernel.org
X-Gm-Message-State: AFuF++l9S0HG2KCW5dokf3EVQH5GckPrdocZgAi0VCz8p5M77+rZ2X8d
	iqBiApo+bFDkDpLTLVIUyTpV77GFwO9hETlY5+XWHaZCdOaGWspadMokY9B0kGFDdZ7p8nIKxkC
	ROk070A3ZY4AeBWXz7EHYsQ==
X-Received: from wmoi19.prod.google.com ([2002:a05:600c:4813:b0:499:b7b4:7c4])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b1f:b0:49c:cee2:1697 with SMTP id 5b1f17b1804b1-49e619e0f85mr68949845e9.16.1789155593836;
 Fri, 11 Sep 2026 12:39:53 -0700 (PDT)
Date: Fri, 11 Sep 2026 20:39:36 +0100
In-Reply-To: <20260911193937.602202-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260911193937.602202-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260911193937.602202-3-vdonnefort@google.com>
Subject: [PATCH v2 2/3] tracing/remotes: Catch nr_page_va overflow in
 ring_buffer_desc sizing
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The number of pages per remote ring buffer is capped by
ring_buffer_desc::nr_page_va (32 bits). A buffer_size large enough to
overflow that field would silently allocate a descriptor smaller than
what was asked for.

Return SIZE_MAX from trace_buffer_desc_size() on nr_page_va overflow.

Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 include/linux/ring_buffer.h | 4 ++++
 kernel/trace/trace_remote.c | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 11bffb6a142d..eac3e9080c3c 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -295,6 +295,10 @@ static inline size_t trace_buffer_desc_size(size_t buffer_size, unsigned int nr_
 	unsigned long nr_pages = __calc_nr_pages_ring_buffer_desc(buffer_size);
 	struct ring_buffer_desc *rbdesc;
 
+	/* Capped by ring_buffer_desc::nr_page_va */
+	if (nr_pages > UINT_MAX)
+		return SIZE_MAX;
+
 	return size_add(offsetof(struct trace_buffer_desc, __data),
 			size_mul(nr_cpus, struct_size(rbdesc, page_va, nr_pages)));
 }
diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index c17902e42ef1..2d5bc423efca 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -980,9 +980,12 @@ int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t desc_size,
 			      const struct cpumask *cpumask)
 {
 	size_t min_desc_size = trace_buffer_desc_size(buffer_size, cpumask_weight(cpumask));
-	unsigned int nr_pages = __calc_nr_pages_ring_buffer_desc(buffer_size);
 	struct ring_buffer_desc *rb_desc;
 	int cpu, ret = -ENOMEM;
+	unsigned int nr_pages;
+
+	if (min_desc_size == SIZE_MAX)
+		return -E2BIG;
 
 	if (desc_size < min_desc_size)
 		return -EINVAL;
@@ -991,6 +994,7 @@ int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t desc_size,
 	desc->struct_len = min_desc_size;
 
 	rb_desc = __first_ring_buffer_desc(desc);
+	nr_pages = __calc_nr_pages_ring_buffer_desc(buffer_size);
 
 	for_each_cpu(cpu, cpumask) {
 		unsigned int id;
-- 
2.55.0.1007.g17ff1f9808-goog

