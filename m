Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF37754904
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447471; cv=none; b=Ot01vDbnhUMOKUWh0IIukgh+F0ZnjtadePzNGfkQTVJRL1/T0QSXyzFYPnxpNL3jRCBua234V0kOeS0ZlUOGoraEcHp40WGUdhFb3WFW55Z7jsOdiGiEOqX7NYuBiR3KRw1W5TGYvH4YSa00aW7EtXCxfwbJfgGJg2AzINI2qVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447471; c=relaxed/simple;
	bh=fmGO1bl7uIIHf3GZWx4iYgb5Kr3yiA9pjGjZZE++s/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q+zHKMKYntEladSVCq+bRiQGxXSeQwSmsR6Mr6/qe3ow4ndGLyKqPX6fYnXYFmt11o1GCV4h202tPrcCVBaOJQEkj8DtkWx5iA92sOGVYR70t43RWt5tsBU7JqbcAbHgonYAkj9B9HKNAj75T4TJfF7O8kAGBv1TqhFvfaPWVnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N5Ay0qJX; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N5Ay0qJX"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4140dd880b2so28768455e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711447468; x=1712052268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3D5T04RutDX7ZRsYqi7kr5/lV+ciJTNJOpTaA63uf9M=;
        b=N5Ay0qJX6Jq5BAFwZO+oA1CQZ7nmjGepqIk+7gOlu7pp9oAsXWNwiOkshmq2IJrN19
         WG36QVNhhTT0783qzNRzKTN0upfNV5yE1r+cr6euL0Y7rgtSHDfgcwjIlhsHRmKpBCya
         mOKP1Q3koczXQ2htzLn9Mb+wtAkE46NhxPmT6zCqtBrXu4cpy2LhPVjCVK26WnFO3Ubz
         FXWUYWQaSBt3d3Q2lCV96ROJhJbYvcB3zaq0yczCni8S+2N3VBTpdafpNs0ktHZpqIEx
         eE5uFCAYZDx7fVjVRXIKw33ryB3EN9FwFojTIhL/5AiJ7v8NPnTkAAOU/JC0gFa1CNLj
         E+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711447468; x=1712052268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3D5T04RutDX7ZRsYqi7kr5/lV+ciJTNJOpTaA63uf9M=;
        b=P8G6PhrgelwBlOpBzOtadhsBwTsxHA+Vn06cDNdCIvYCwQSfOhRQc+DUJykS0/nX8c
         X6BWh/zYpA0mMd160wdVq16nmZKzWZKUjaeaix7+5Eoy8j91TPdq7sykuuwe84z3Cuzw
         BeNty03pKCvQjE240sFzqCJjLXsHGzPH9HvUxfnBr2AObqenEx1VrtuB+m7zWhdLJ8o8
         tVRKE6mOnxHlILPflXAAw4rAYnzRdwabj3hMKRNiED0LfXVw4Kbm9mbs8DhTKB4G8WFH
         ZWEGY9Kkfus1Q6jUpS9RlLSlnyp1YJr/AQlqmQpzaIGmwIO3B/vMGKPCondVGsvhHkeN
         SYxw==
X-Forwarded-Encrypted: i=1; AJvYcCXBVVpLyllAd6PyW24dJjGYnVVmbt/NfNBLKkivSFiJ9N6ZcCE2Ap2AJRX1xMGx0p6lED9/lrsXl123tCkVKzH18fNXAvyTAF6mGaK8DfdHUV+/
X-Gm-Message-State: AOJu0Yzin1CC1MV1WMYcGGITZRyxDzIBoJPX4YYb07rtBxO6qgrjiLVu
	675ll/89gYAuEJhrAHeFNcof5oUQx0zCSd3OuF0IEIevSftvJrQxhv3GSd+gOqPw1DxbkgGM88u
	DUOHSGSjkFWyXRFdLiA==
X-Google-Smtp-Source: AGHT+IGwIllNDYK+IPKSgqo7E8qVb5bWLE1exNxNqbZF8sc5BBGjPKB3Hez5pkqa0YWrbNcvisvZKgiM/PBLH9AG
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:1d08:b0:414:afb:6199 with SMTP
 id l8-20020a05600c1d0800b004140afb6199mr67220wms.6.1711447468440; Tue, 26 Mar
 2024 03:04:28 -0700 (PDT)
Date: Tue, 26 Mar 2024 10:03:26 +0000
In-Reply-To: <20240326100330.1321861-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240326100330.1321861-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326100330.1321861-2-vdonnefort@google.com>
Subject: [PATCH v19 1/5] ring-buffer: allocate sub-buffers with __GFP_COMP
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
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
2.44.0.396.g6e790dbe36-goog

