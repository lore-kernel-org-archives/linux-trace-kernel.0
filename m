Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455C547DD4A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786626728; cv=none; b=b+kXx6enH69PkM/RIFrmg5LAByK9KaAS8pARgLHu17fvs1zJyUejlkPELVXukIp2+q0ToO/xUvfOjOXygHcVvTV2u2kJ5jSgIfcSo4IeDMwCILLVSZAg4AGRExL1gEPuKd84+ID6Zrq7p/5eYqk+T3SVDTlf5wE75yMc78PMrrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786626728; c=relaxed/simple;
	bh=GDfudVeqUNJDDsQyGfFgyXJRGIi8nBlg1DBu2jtXP/E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=arOoZS9FNTZbELrWMhukNICd6WdpC2NLiU/axtlaBweZOJo9pGzaMmKFUVovKSjr/J2bJxIMExlBRWWB6R4vtF9L9WFe/tuYeuL7Ly9ts1f0hN+0G0EoaMItU4MQSBxMGm6lCuW0IGd5NekiLHPcXcLxdJTq0gdVTYtwYAtS/hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mHMfr5fi; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mHMfr5fi"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so14939995e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 06:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786626721; x=1787231521; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ElOrjdWXgbGM4dlqT5NvceC6FVfQO/iUb68RR1af7yw=;
        b=mHMfr5fiy166N9mdFF5R6g9RIUOjYQHmrTr92I/z/APZr7HPOOz6Xq9OOfgQK82Bf9
         9Jn0ROCk0M7b3Xc037ITsUuYDCFfyVk7JRx+3qCdRtLVUiWGGyFUxg7oXBH1bN3yelFM
         1pphcPqWf5C2fKz2FmKCZg6gBhF+KIJMBv8katU1sydvNu77tB0MZRaQJdzcHo0BxT43
         +4dntL/PvqHeaFOykKtQXqJMPgS8XaSI9//sJbNVXatlhjEcDX7cXBTryp/uJcze5VjT
         zsq808fFNtzLfBzdSC5HfCXdvRUWehgbeSJ1kL3hUnFDKcuXXaMhMXuDjRvgph2qDHAY
         dFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786626721; x=1787231521;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ElOrjdWXgbGM4dlqT5NvceC6FVfQO/iUb68RR1af7yw=;
        b=n40woZefqjRijk+6gythScwffaH+FxVTOTHGaloeBXlgngwTmkHIxn9GFLjccXPwpq
         2PDR7MkwLL8bA5cHMVdRDw6ELhGuXvkRHsrnVwLpURpAHy7Hge4XPUOv6M2jPeVzkjZB
         9JkWnXR2HRl8Btj+aRbQrQe+GLhq9c1bQN/qQfRSazDK4Oh1rGEKtk734Fc4GW6VYoQD
         aI87DplIschCUJJ4/Q4L9y0GRCnvXWvICRgBkwqDZGK2iPbwBxgORboKElE+ruoF/5QZ
         LvBXmDJ36o53arrMWg4H3G8ZoGKmC7JcjtM1TWbIx0Ee7o2+22ROjiVz8MyCL2SbMfv4
         hWOw==
X-Forwarded-Encrypted: i=1; AHgh+RpbhAFe2DjfKd7Q+xPmIOzOil2hCB/bpjB81gzLOJH+GLOZxGHayj3I8Oe2j5M0CcCS1QdPCSdhO5QBFT3AODODsok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7i31kQZjFp+CViezkA6lSctzRRR7fBi63SRX9a2RATMnq2vWV
	WT5PRT6CM3z4SLzWbQdfReyeu8DXSIU1XBh0FJflmhOfdybvah4wm0ukvikuIgfnpYuU2ovHjMy
	TpmAmTmF8IQZBNRWMtxpOuQ==
X-Received: from wmbf15.prod.google.com ([2002:a05:600c:594f:b0:499:4fc8:f8eb])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1da8:b0:499:726b:7375 with SMTP id 5b1f17b1804b1-499821c3119mr86065855e9.14.1786626721227;
 Thu, 13 Aug 2026 06:12:01 -0700 (PDT)
Date: Thu, 13 Aug 2026 14:11:47 +0100
In-Reply-To: <20260813131152.3589632-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813131152.3589632-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813131152.3589632-6-vdonnefort@google.com>
Subject: [PATCH v5 05/10] ring-buffer: Fix subbuf resize race with ring_buffer_alloc_read_page()
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

ring_buffer_alloc_read_page() is racy with ring_buffer_subbuf_order_set,
it can allocate a reader page with an outdated order. This isn't a big
issue, the user can still re-allocate a new reader page and try again.

However, what is more problematic is if the value of subbuf_order
changes in the middle of ring_buffer_alloc_read_page(). In that case,
bpage->order might not match the actual allocated memory.

Use bpage->order for the allocation to prevent this race.

Fixes: bce761d75745 ("ring-buffer: Read and write to ring buffers with custom sub buffer size")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ec520c72124e..a00ab8a9cbd0 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7018,7 +7018,7 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	if (bpage->data) {
 		rb_init_data_page(bpage->data);
 	} else {
-		bpage->data = alloc_cpu_data(cpu, cpu_buffer->buffer->subbuf_order);
+		bpage->data = alloc_cpu_data(cpu, bpage->order);
 		if (!bpage->data) {
 			kfree(bpage);
 			return ERR_PTR(-ENOMEM);
-- 
2.55.0.691.gc56d675ccc-goog

