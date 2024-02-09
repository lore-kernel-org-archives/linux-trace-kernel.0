Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC4369D00
	for <linux-trace-kernel@vger.kernel.org>; Fri,  9 Feb 2024 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474137; cv=none; b=NDGpI+dAlzRQdmylx5uAd0I3m6gT8p0QTr0hwF6GnrkOLq/w1WQK4pni3oWrgcx7oYXG0GgNe5LeIilLxULNfYBwQQvyLC3Qlmue9GwOmJLUj497RBrGnm5RUhkYA/VZusAnCn0FbbbB/XmCWkKco33cvdIiuhKwHn3ib3Mtj8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474137; c=relaxed/simple;
	bh=tpt51FeO44HeEXQqmygp1fYLZoXSRZvsHL381MrJybw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cWPCaQ9J5Nb2YBrZyayuWJSmdj8/YtVfnWV5F6A6m8ug29V2PzxK6eiMeU0Rr/PcbGdDWERHhanWbEafwbjmiqAuDXVy+aSzk91Gv3ruHm8hYgOlwyBEfo7151P4mF6qot8xJsuOHsttlU2tHs9Nd47N22xjhXIStNIz+H3RdKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gEYqPfRh; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gEYqPfRh"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-410422e8cd1so4701015e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Feb 2024 02:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707474134; x=1708078934; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SqiLbHub5ruL/UvpG5IMav/eAn4s+2aSSt9gMa9+oOE=;
        b=gEYqPfRhT+Eb1+XX8ub6EbPGI6NA+Ll+z4OB29ZEb6haaMezhutfFhxMS72l/uhNhD
         k0btik0j4rhdMG5llfUKUSHFYInsKYc9UNBJR/7dtKVn/iMRXoAJx6uOgwBWPcOTg4Ck
         dPTG0GcWgGFPLHxDLCofgMiXYWHgcAed6KXdorSfJgUkh32SlewE+9J1Yy0vQ6UC6Phv
         gvcZwdRgVCOlZ0lHLr18HP/NzgMzIwQ9j2oTf5D6Ia97E6484V6TF9XWh/D8nemApfPR
         Jvn9IzT87Iu/5YqWS8xDGNU+fybD8SaymOmyo5GTDb5ZnqkO+zELxbIxo/kG8pNgfMmX
         s3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707474134; x=1708078934;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SqiLbHub5ruL/UvpG5IMav/eAn4s+2aSSt9gMa9+oOE=;
        b=ROEtV9h4V5FBBIVe8ysdbAPaPqF0oN7w9v1c6GKFc1P9L15wXJ8rx0oHfphyZ2KOnJ
         IPv72Aqja86rvqAox8gYrIpokAjqi10JDwkfvnJBcc7fyG0Y9IrAzJ686NHZdOM6SGyX
         wr5sm8IrmlYWixmhWKZAsIgWIw5f1HOhBvJNgb+F0/ev8JwkLfu0qCznQqROSq7Je9NO
         jRUg9StSPuwbPiTgCs7T2hUxr6NQn9xC99QS9GZOsb4I3Bd7FS960WEMfES3dJ7IYsHp
         QiAcoJK0qR6IxpnQ1brm8aKOSzRuwgw1ZvOT+8s4ZvMcuCaChYm2E/xfwu7xZnKvAGmq
         ICjg==
X-Forwarded-Encrypted: i=1; AJvYcCUQIaptmG6cZHLQ6ilySktJlgxare2JgR1nTfKZDEzyDxllVxwmAlA4fShQTg4k8xiEtR+9sxtOzvksCdgvFpI7Rori0EzZx7v9aLVV/BcZ/4xn
X-Gm-Message-State: AOJu0Yxot6jaBTgNe89H49lPIln3nzduSRLZRREcP4OhyqFqJHPZK74D
	jv9IHgZnbSCIetWmpNG7ARvyVu/omPBymMn8XvZlm9UNazGeZk4WepWVATw6Yy6jp7YlD/bwzEw
	r4YX79uE/hYoSX3XpBA==
X-Google-Smtp-Source: AGHT+IHsCSAWDoTALZ69dIqskVJ+bDPuZT95tyOFjyEZj05BeKokuUE1iA67QgC/IWMdyoq7Hn3fUiXGCF0cHWUR
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:54c9:b0:410:6ab1:4964 with
 SMTP id iw9-20020a05600c54c900b004106ab14964mr18382wmb.1.1707474133639; Fri,
 09 Feb 2024 02:22:13 -0800 (PST)
Date: Fri,  9 Feb 2024 10:21:57 +0000
In-Reply-To: <20240209102202.649049-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209102202.649049-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209102202.649049-2-vdonnefort@google.com>
Subject: [PATCH v15 1/6] ring-buffer: Zero ring-buffer sub-buffers
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for the ring-buffer memory mapping where each subbuf will
be accessible to user-space, zero all the page allocations.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index fd4bfe3ecf01..ca796675c0a1 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1472,7 +1472,8 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 
 		list_add(&bpage->list, pages);
 
-		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu), mflags,
+		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu),
+					mflags | __GFP_ZERO,
 					cpu_buffer->buffer->subbuf_order);
 		if (!page)
 			goto free_pages;
@@ -1557,7 +1558,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 
 	cpu_buffer->reader_page = bpage;
 
-	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, cpu_buffer->buffer->subbuf_order);
+	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_ZERO,
+				cpu_buffer->buffer->subbuf_order);
 	if (!page)
 		goto fail_free_reader;
 	bpage->page = page_address(page);
@@ -5525,7 +5527,8 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	if (bpage->data)
 		goto out;
 
-	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_NORETRY,
+	page = alloc_pages_node(cpu_to_node(cpu),
+				GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO,
 				cpu_buffer->buffer->subbuf_order);
 	if (!page) {
 		kfree(bpage);
-- 
2.43.0.687.g38aa6559b0-goog

