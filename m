Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE4038AC83
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Jul 2026 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612847; cv=none; b=ZcYqiY0/UE5iJ9zzufIj4Vun2476z9Cers0FGg9kOlKGx/qjsb1nkTMWgxBMhIzT3XgyVWpjZQrC73KlQBYRT1emowwGbwUIrlrJ5nX1Gs2FWT/8ESn8cY7d4zMm3ktYVKeSQ6O6QF68g3j+1fZev42w7dApPzPVSiOJUN6J3J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612847; c=relaxed/simple;
	bh=EC3M3lbvE4Ah6Cdk2ZmS1cpRkqxWxAjf2qf7huO7k/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jd3JKZPmk1sV9LnmIMR+E2fpKdNag6C2gkfElTHb1XHYDJ8F8UDbDTf5epaXKH93iB48reaSHXg20CiNUYaIQjzUem9WwBHxEg+FKlK7jclAUvOKY6S8qTYtq4G5YKQ7slKT9hG2NEUwl/JP7wVf7I8qEvjUii66cDzvX01W1Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qmkR1JkZ; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qmkR1JkZ"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-47e9f03e80bso24068f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Jul 2026 09:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783612844; x=1784217644; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oyvCL0bKz+nO4OOFv5PVnwcYDaKn8u8UpjNOH2RDU34=;
        b=qmkR1JkZPZDHuZ29nPmu2uw6eafL3YeK+oRHpfORvMf9FLLb1AiX6St7xvJfaNiTSl
         Wa0YDTlxN/sCuE/NFKaWa2Y7E0Q1J3gzQ7Vyk5YHhfbbhjx/u4xdPcVRsK2q97R0N0R8
         UKprvDUf5bt4k7TysFHEkEb1bdCb+jH2KfAa2kvsac4tha/RUxCYsTV8G9IceykkQk6T
         Ysl6PSHZhqHL03kHwOVApTQEVYNbGfy6kePMM5Vv+A7NHXo1Fo8+1SnUThgX4URu/M1d
         0aXabq8gnwa0mkja2hx/dCd2K4gwLz4ovGeGCnJi3veKZB1gIF41n0eA6pGEFgZP/6Yh
         fR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612844; x=1784217644;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oyvCL0bKz+nO4OOFv5PVnwcYDaKn8u8UpjNOH2RDU34=;
        b=sTQzeHb3vvbGcsQzEU/9maQ5MbvNIzuze0InQtjEsCKCi0nB1MO5m0PwTZH3dKyeYX
         siBgbAmgh9Q27ToY2vbJDkjPRKs96+1UUcueM8TFtnfNs+tFXJrGLVR0VhrjkwfV1HjR
         9X4+nBiuK53SJzqBqw+4tnZvjMogLy35Xs59p0cUjF4oj0/2nwoJHdbFTbNsrVrS9Ogo
         9KZvcRyv4drmtuzI6Zw/IZpycyawfotlKk0TidSOZZDHUEA0IERhBDSo37cMRXzIQWFs
         o1KvEg0MeHA5tdijmM8BIQl8FxyucAM0lrWF+vv27bmXekWpa6IK/F7P587wBXmlgORG
         9Y9Q==
X-Forwarded-Encrypted: i=1; AHgh+RqwX5Sv8I/OnCm6BaEF+TOTmAz5BT3VIilxfk1OFR7+sCLIiQp+BvOQrsR8HygCA7Wt0s65AxCsOWVXndOPyKl9VjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK7tAEGKgAGCcBaYqCZLQNXE6Ke5G344bXZ0W8IatoQ0U4mm9a
	Flh5jXE/fiFNjRpFpXthQxR0gfhivCzj8/f7lqdnEG/TmI7o8PyyGGhkJUZmWpOpArzt1AgYvxb
	Z+pLobXLGTdt8EQ4ttW6GOQ==
X-Received: from wmpe35.prod.google.com ([2002:a05:600c:4ba3:b0:493:bc2d:feac])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5394:b0:493:ece1:86b9 with SMTP id 5b1f17b1804b1-493ed949ffemr30608445e9.8.1783612844117;
 Thu, 09 Jul 2026 09:00:44 -0700 (PDT)
Date: Thu,  9 Jul 2026 17:00:15 +0100
In-Reply-To: <20260709160017.1729517-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709160017.1729517-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709160017.1729517-2-vdonnefort@google.com>
Subject: [PATCH v2 1/3] tracing/remotes: Fix leak in trace_remote_alloc_buffer()
 error path
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

If page allocation fails in trace_remote_alloc_buffer(), desc->nr_cpus
is not yet incremented for the current CPU. As a consequence, on error,
half-allocated rb_desc will not be freed in trace_remote_free_buffer().

Increment desc->nr_cpus as soon as the first allocation for the current
CPU has succeeded.

Fixes: 96e43537af54 ("tracing: Introduce trace remotes")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 2a6cc000ec98..d48042239d58 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -1006,6 +1006,8 @@ int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t desc_size,
 		if (!rb_desc->meta_va)
 			goto err;
 
+		desc->nr_cpus++;
+
 		for (id = 0; id < nr_pages; id++) {
 			rb_desc->page_va[id] = (unsigned long)__get_free_page(GFP_KERNEL);
 			if (!rb_desc->page_va[id])
@@ -1013,7 +1015,6 @@ int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t desc_size,
 
 			rb_desc->nr_page_va++;
 		}
-		desc->nr_cpus++;
 		desc->struct_len += offsetof(struct ring_buffer_desc, page_va);
 		desc->struct_len += struct_size(rb_desc, page_va, rb_desc->nr_page_va);
 		rb_desc = __next_ring_buffer_desc(rb_desc);
-- 
2.55.0.795.g602f6c329a-goog

