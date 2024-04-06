Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1E4446C8
	for <linux-trace-kernel@vger.kernel.org>; Sat,  6 Apr 2024 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712425034; cv=none; b=Ik4KkD/G6/5ZJxY/AdzNFXZnOKQ8ypRttDCnmZI+E0Nxizu6EeBOdqWC5U+jQ4G4g9K3+xeh1O7n/HGGbSXa+ZjzcFlDImUE7NwnWfOMeCRBLoyFjGt2oOw8sZCn0ewbzMh2Uhc5HumHPKFiQu6L6PALXGpWFEi6e1MuEw0hqec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712425034; c=relaxed/simple;
	bh=BeIrHW+T2nh/AGpI3eEBpBah42JowlQbOvynMRVHWBE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SsZ9bw7dmlCbyZrxYHFPGTor6vI61X0DqMRiDM4ue8w1pN14RRDPcf4bxqyGeoLcS4ctJQVC+TNiBp28KWiAMpkdJO80Zc+eHyOpLooSuPipK9Aei5/hzjs56m4aeL1kSoL3Jrf6c5lPyGnuEeTgOXJP0D4NysdXt+wguyzeo8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lGZhU82z; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lGZhU82z"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-41545bc8962so15819205e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 06 Apr 2024 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712425031; x=1713029831; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lAJeOxdOPDtRW76Ag7FnaqNs2+ZUgqSGGU0SIC7i8bQ=;
        b=lGZhU82zQ4tUm8IlLBAOp86bCg9WLxWqMRAWRY/ugb7C8YtLJKfBvrMo+v36yEntHb
         8lr8DLYMXWFRHIMlw5r2o/TmtSapToJI6CPmGaj+db7Pdg7GGVDe54JeGOnMmXcp/fu6
         RcptK5igHVuicl7SXeKJRf/FE05PFl+OYok6ZRxaisoAohKKTjt1fLUrUZO2EKe5eNmx
         dhViKerNhDD9T28+MjD1bovNdqqSJCotHTPnqHFXP6m9gzhPep4XeD8PeOwpbeSVl8g0
         lFB6j1Uxme1g+kgPlNXFbjJVDkk5tEk4Z3I89xel95hpQWcaJg+h9SyInOsUL1Nqwbl0
         2bOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712425031; x=1713029831;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lAJeOxdOPDtRW76Ag7FnaqNs2+ZUgqSGGU0SIC7i8bQ=;
        b=T2eJS5bjs58SK3UBftUFR12g3Bf87tJ6NtzkOD8AhT1C+7RKNbZ2c92uv1nbHyZbvk
         0hqsqkFlSWMMcPn69ziZTP5I6nxcAJgViFRMqexcMBOQSyKWpYNKJRYW4CcmxlAJ3yuV
         Ml3fU4DTb4N/0wUmaw2hSkRJfK0xquWJ0SVMTokCFNEXDYDqHCg++NXOjhb8m1XJgZkA
         VxwusEuWW/sxG59sO+hdP9lCNdCNodXfkg425QQU1RpVDiBuIyC8q2XnhR8/am4oDtf5
         alg62AefN9NQCKRRidNYusJbwUNqSOxDmKnTCoovJpn/I4OWX59rnosy1JfxUL54gvdA
         5Rtg==
X-Forwarded-Encrypted: i=1; AJvYcCVCadbLkiiUKhcqqKb09bMOvYscdUlC92xaVwlCPLYrmVJgc3DdCenbQyZEM5TlZKZcqG8y6+Ei7XSKOP3/up2hc4EwoEUb+eFdD2FtArpnK+Gs
X-Gm-Message-State: AOJu0YyJrQvofEUv0h9W0cFHxrStbccP+HmErstTSW8En8kHWG9TwuBk
	dKWHtw0VcLVdAPlk7tIkvHM2ZU/8fXRhK4Y24h9DhaCCtioxV0M72NCGPKnVEM9k8sO9GG+dxdG
	zpRiXBVrfE6egRKoA3Q==
X-Google-Smtp-Source: AGHT+IGLf/sk84IAjrrdGcpvC7gOW00K9LWZoLZtutt6vhBA/F6UXSAP20h0RiEYwW6ZuGGixOZHwRNs6xRpsmmM
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:46ce:b0:414:63ba:ac04 with
 SMTP id q14-20020a05600c46ce00b0041463baac04mr12446wmo.8.1712425030803; Sat,
 06 Apr 2024 10:37:10 -0700 (PDT)
Date: Sat,  6 Apr 2024 18:36:45 +0100
In-Reply-To: <20240406173649.3210836-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240406173649.3210836-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240406173649.3210836-2-vdonnefort@google.com>
Subject: [PATCH v20 1/5] ring-buffer: allocate sub-buffers with __GFP_COMP
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	rdunlap@infradead.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for the ring-buffer memory mapping, allocate compound
pages for the ring-buffer sub-buffers to enable us to map them to
user-space with vm_insert_pages().

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 25476ead681b..cc9ebe593571 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1524,7 +1524,7 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 		list_add(&bpage->list, pages);
 
 		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu),
-					mflags | __GFP_ZERO,
+					mflags | __GFP_COMP | __GFP_ZERO,
 					cpu_buffer->buffer->subbuf_order);
 		if (!page)
 			goto free_pages;
@@ -1609,7 +1609,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 
 	cpu_buffer->reader_page = bpage;
 
-	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_ZERO,
+	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_COMP | __GFP_ZERO,
 				cpu_buffer->buffer->subbuf_order);
 	if (!page)
 		goto fail_free_reader;
@@ -5579,7 +5579,7 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 		goto out;
 
 	page = alloc_pages_node(cpu_to_node(cpu),
-				GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO,
+				GFP_KERNEL | __GFP_NORETRY | __GFP_COMP | __GFP_ZERO,
 				cpu_buffer->buffer->subbuf_order);
 	if (!page) {
 		kfree(bpage);
-- 
2.44.0.478.gd926399ef9-goog

