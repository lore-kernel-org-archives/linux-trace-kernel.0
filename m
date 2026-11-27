Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795792421;
	b=1+7jjhl8Qr1nDZQkkLX1yIYy8Obzy8xkh/l+Xaf1+03luw4Ci586bt8oYSDFtkbsBMhS
	 tUrU5uPscohe7JDYGJSzY9Ah6RttaAOPU5I1wOuokX/F2+chjgAJmE8yW1TlZWhYjO/rV
	 RDDtmw4L5UNxaOlCk50hWLUAAIjyAUHde3dYMtGRclPkuDVyVfG9VcGVWdq6Wvr72nYst
	 8Cfl+jUWQEK66rAQoHH2WUC9Pv+qGrkgRsWsZ5J04gHu82UUcf28MnNIEBgZDLXACNBZQ
	 k3kFPyjy87NJ/QdkIdCNG5iNkBG/eHS2SpQuAskVCgdi1yvoogDc/+f3Iw7jtwq2lhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=0snJA/p3qoZflzr6S+Is/MiZdzdW+xQl+yqw+NL2eXs=;
	b=W61p1oBxCCDrHb5X/ZeipMbhx/wqPSv3F+A4JmU28GaxcDMZrVJJiuBhgtp0wzwzdoeL
	 WZMHgwQczZm6ZBYqrasS/k46isRpAL8gLwuaxyU/S1GCiuqSTyPgjIzea+xN7Hx5W5iQz
	 WIqXQprimNaDhn8FTs/jmd0x5w5USnAAKupcpJpZ9w+UHAXrS3FX7VWaswMML0/3L5uBi
	 4idF/LYFzazgV0UY4LvFNkqNUmsCEKUuYuKqa5lAAsgElhUgOB/bWZNuL+wTB8bwc2sQU
	 k66nvmDyYjyr9IaXN0aoVBeBwFHYNKWTmUCpyIG9xdYY+JbdkyJrFtRjrvlfKJfVVZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="MOT/hKYN";
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D919B606A326
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 15:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D919B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MOT/hKYN
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4bba856092dso19884785e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 07:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795792419; x=1796397219; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0snJA/p3qoZflzr6S+Is/MiZdzdW+xQl+yqw+NL2eXs=;
        b=MOT/hKYNoYZIHUYNtgI7Svut9HQ8qieGUNBtHupehQEDZfrjJWwyumg2grlu/c/INl
         ZJoq+fLZZfeqq7mKdQzDTDD/fpQ/t+lkp4wlC/cSR2R/hfSxmPy2SVLX6AYQmVFpuLSj
         /SpFYiVeN+SPYPgL4ZAYmefqxTTzKby8ibF1Jlrxb3uo5h5J36yuXZh1a37cwE7f+EN4
         0YBwOEr0I4j7/ZLf3gLo2jx6Cv305eCVId97AeCMyMbCzXJHpznO7DuwEurtZnqFIJyH
         GJDGYbIT6Vnv/XgrohFz4Q0+9ZVQ6djjdqkq0Uz0HFr3xMgygFA5CV7KeNnYTwfVQJKX
         +RxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795792419; x=1796397219;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0snJA/p3qoZflzr6S+Is/MiZdzdW+xQl+yqw+NL2eXs=;
        b=EDXZhXynSC5VAH7lyuT35GaUa2KeqBs/rUaik+3QWe+srEugGxyfeDG1USMq0JYHdy
         Q+tbaBI1kk02X+x6a2C6j42aLb+Ny4fjWua/+mU+WIn3D0LM/aU+0pEx5QKanEG1FRrE
         nBIBs3P/2ERmI6UkV5mAW08OPRXmuVMWl1msfYmfb7i78vH06nWQQ/JEXnbSle4fi/zh
         JiJ2KjHMHpJnNklLpcWU7k2GUr0onm0uVVMfnfY+Hr1jsqwje0j0NuVNYTYy93Txiguw
         EJydZVdQhCIDApjKo+mYeu9dRsl4mEZWkoasit+eH8soA75cyrXsmnhGHZNxeU8AI4xq
         0AOA==
X-Forwarded-Encrypted: i=1; AL+hErHo2guesgdRs8kmm0AIlzNVdA/JW1sGs7n+xkOwfc6A++qSGGb0kfsOXTyiRqHJJpUChg1V+DqkRXNJ55lznAB+pGE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dGx6RPjzZY8Ieo3aGou8NJNY0/Md+nzPBpbbmhChGdFG2q3C9
	rZCeypc9SUdqNp8uG0hhAgvd0IEzNjawn88trqBUDeqGyooeGA6H6nWtAr2ZM7q8iYYLwg1s+V9
	jLtUnbzUhK9l2EI1cd8Alrw==
X-Received: from wmee23.prod.google.com ([2002:a05:600c:2197:b0:4bb:4bbf:7120])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:9:b0:4bb:aa4f:c025 with SMTP id 5b1f17b1804b1-4bbaa4fc0f1mr120603915e9.1.1795792418988;
 Fri, 27 Nov 2026 07:13:38 -0800 (PST)
Date: Fri, 27 Nov 2026 15:13:23 +0000
In-Reply-To: <20261127151326.515232-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261127151326.515232-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261127151326.515232-2-vdonnefort@google.com>
Subject: [PATCH v2 1/3] ring-buffer: Use kvzalloc_objs for user mapping arrays
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Mapping a large trace buffer to user space requires allocating arrays of
struct buffer_page * and struct page *. For large ring buffers, these
contiguous allocations can fail under memory fragmentation.

Switch both to kvzalloc_objs() to use the vmalloc fallback under memory
pressure.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a5a0adc934fa..484fb1c08682 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7762,9 +7762,9 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
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
 
@@ -7801,7 +7801,7 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 
 	nr_pages = nr_vma_pages;
 
-	pages = kzalloc_objs(*pages, nr_pages);
+	pages = kvzalloc_objs(*pages, nr_pages);
 	if (!pages)
 		return -ENOMEM;
 
@@ -7893,7 +7893,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		return err;
 
 	/* subbuf_ids includes the reader while nr_pages does not */
-	subbuf_ids = kzalloc_objs(*subbuf_ids, cpu_buffer->nr_pages + 1);
+	subbuf_ids = kvzalloc_objs(*subbuf_ids, cpu_buffer->nr_pages + 1);
 	if (!subbuf_ids) {
 		rb_free_meta_page(cpu_buffer);
 		return -ENOMEM;
@@ -7917,7 +7917,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		cpu_buffer->user_mapped = 1;
 		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 	} else {
-		kfree(cpu_buffer->subbuf_ids);
+		kvfree(cpu_buffer->subbuf_ids);
 		cpu_buffer->subbuf_ids = NULL;
 		rb_free_meta_page(cpu_buffer);
 		atomic_dec(&cpu_buffer->resize_disabled);
@@ -7974,7 +7974,7 @@ int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
 
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
-	kfree(cpu_buffer->subbuf_ids);
+	kvfree(cpu_buffer->subbuf_ids);
 	cpu_buffer->subbuf_ids = NULL;
 	rb_free_meta_page(cpu_buffer);
 	atomic_dec(&cpu_buffer->resize_disabled);
-- 
2.56.1.839.g22a8290db9-goog

