Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33609471CF8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786548818; cv=none; b=khzCDYCowf716Md354NrxldKjfibw2OBdPCP468d6R99Bz6A+Ux8xqPKAzUUg8okjfi668MUWGCiYi6Ew4G30/JSVk4mdT+3GzZv6kbAjBstKLUg/MJ1644ReYyJqPYHrc6AsNvCU6mXAXG3r+4aT4k+dcovsH8fw7PFpBrlMZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786548818; c=relaxed/simple;
	bh=tujv8RbwhrzNmaNzcMSZ3HxX1V8/EjqjdRXAbYVULcE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F6u9FCTLAsBnpKLZWKftyBpUyEE7IArblPp2Xs8VNIDZeH/zQeL0e5maZkqiHY96CMFdWwhIa3K2BOHoMAoelUyR+0uWl/BGlGDCjukRVhlJWXLxRhXneXpMOn3dQWuTOGKZYb+UeiBFeaLjfrSSLI1zs/gxPQ+DRcMwQH16zvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sW2+6hj9; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sW2+6hj9"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49561facb1dso7265865e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 08:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786548809; x=1787153609; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SwGJJ+A9z3NJgDEvUS+8UxqlJZhSVXFUJkzDSX5uv20=;
        b=sW2+6hj9hcmu2PLSe+pHFde6nTN6EY9RPfBT+O+BghTz6t4m41ecCo7nZvnRp0+IbW
         /uti/s+aZCOXhJMcCmkZ8K55j21ML5lmO2nVmTWa5ehHi4kqB44PymMWU+8imBUbJniy
         6ITyEFkyrAB+FwuHjdz0rtb1sOAz7Wic3BuVfXe0BzFTJMjiWWDdxoa9D1YDFtzPzltH
         8GmjWgkIY3QOG4NEx3SOS4mmTu6f/HyfUy52LXZHf85fApYOBgU3ElDKOTYdZnhAjrb4
         CoqOq8lIy023km4VIiRZGghU5OAAPOV853CYR/95NJ+XVmNb9pF127TevGgWW+XylasH
         SUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786548809; x=1787153609;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SwGJJ+A9z3NJgDEvUS+8UxqlJZhSVXFUJkzDSX5uv20=;
        b=YzfdXh6ko1BDG3K0mXlJSzbvuFx9XxH9jwxTZOjqR2oRpTNqetmZmEXvhHngecCgwN
         +FdxGLvoBTadcl5OczFqLHt8utTyLaHh/sLewcgT25kcLDGJWS+uS0be2fsc9tnVY++4
         h7d0i9HnNHxEHIBh+FatiAYXJc09GvqpGY24nNqe/KvxsHO+gnihiy/2XrlPFIvsQhNX
         PJEe46kdnFjDton6nB7qksCcE6HnEcKrp0eLUDcwsbx4Tr0KnIDkcLRGtBXJJTt3X45Z
         pA8PfW/dp+Q4mOrs0SNoDfUqagvEzbAUVrTdtpNp70ma3XZ/yUtBRKL5rVtDE14iGruY
         5guQ==
X-Forwarded-Encrypted: i=1; AHgh+RppeZ/CuSZ7kb/I6WbaUmcnLgl630KEuJc5jULoLQp2biuSz44E1JLZ46JfvjvmQF0BjOEj1hHDjZi9S2JM8kYBCXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM55Uwg1wc7Pu/To4ZruhwzlDK4lsCyo7Wn5f4OdKcnwP5BFwP
	2u3R9VXW0vyB7gHcN9rNqIDHNLuUYEGuMWsDBFuxO+d8awiBt5d/tJXlsbyphmfzw8yV55lfTPd
	ftIAvvowGgIOXWZMlpqQFKA==
X-Received: from wmcm14.prod.google.com ([2002:a7b:ce0e:0:b0:493:ed72:8dad])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:6454:10b0:499:79ba:a754 with SMTP id 5b1f17b1804b1-4997c138bfamr64105245e9.11.1786548809168;
 Wed, 12 Aug 2026 08:33:29 -0700 (PDT)
Date: Wed, 12 Aug 2026 16:33:03 +0100
In-Reply-To: <20260812153311.2328812-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812153311.2328812-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812153311.2328812-3-vdonnefort@google.com>
Subject: [PATCH v4 2/9] ring-buffer: Hold cpu_buffer::lock when resizing a subbuf
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Because, ring_buffer_subbuf_order_set() can clear cpu_buffer->free_page,
hold cpu_buffer->lock to prevent races with
ring_buffer_alloc_read_page() and ring_buffer_free_read_page().

Fixes: 8e7b58c27b3c ("ring-buffer: Just update the subbuffers when changing their allocation order")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a3d28b2e2c94..ec4f5a0c93e8 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7431,8 +7431,10 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		cpu_buffer->nr_pages = cpu_buffer->nr_pages_to_update;
 		cpu_buffer->nr_pages_to_update = 0;
 
+		arch_spin_lock(&cpu_buffer->lock);
 		old_free_data_page = cpu_buffer->free_page;
 		cpu_buffer->free_page = NULL;
+		arch_spin_unlock(&cpu_buffer->lock);
 
 		rb_head_page_activate(cpu_buffer);
 
-- 
2.55.0.691.gc56d675ccc-goog

