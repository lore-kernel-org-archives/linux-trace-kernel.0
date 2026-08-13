Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8253247D460
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786626721; cv=none; b=eyVS9jOtGO7RNTCthmiRVJHayrJyc0wVAbks2bu6Y4qfrNess5MGY+ZS5Gh+Y3sjDjaiRvKNpmmUGb6pe/H4l1KtjNV0u3PkEyn2MHv542ySPPIxtT8xiTWUh/dEHuamJlx4wK452i3RLd9P7L6dIeveekS90xWD0jGJYEq6usc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786626721; c=relaxed/simple;
	bh=tujv8RbwhrzNmaNzcMSZ3HxX1V8/EjqjdRXAbYVULcE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K4IbF5nXr5DRHePDMPCdCuYF03NsL/SZ88I3PZ2tyvh/n/5B1BGDtihwhgUFLAOlQroD4Iv5nSWYO+QeS7cy4LKvGu5ihGAjgayAuC1ThlsJeX1AO4A/70KBZ+A4+sp1FYqyMwXCJOKQJlAIhqImEOBiEGi7kLDwj0BVKkewLnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fi0uHD1j; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fi0uHD1j"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso5813005e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 06:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786626718; x=1787231518; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SwGJJ+A9z3NJgDEvUS+8UxqlJZhSVXFUJkzDSX5uv20=;
        b=fi0uHD1jzMz8ceNNeT0Ll8lUKzomGviB1cqowK0+s8iDYNPndAcyfdFrGUbV9gm24W
         CRwaeQU6nGh4TjPAruwcw+62VsZrbKZjhGBnvsBQpKjZCFKwDVezQ1cj1XCL+g7xuZ7i
         Axy5sYPB5NPepLOY5zHTfgZ8g3MLmqK5ZMoiLauVQFBoATs5bDa26RvAdNfoPnctaHXS
         YRh214zeo7mjqqbdkaBlGkwQNjrh7Gwh3zBGfmgzpsevIuASBolk0uPMpdByAc8F7YWB
         dZQwuvw7lheMsEd7TxBRsQhFwwx7ilHFq1s5KAX3UNfOq74A15i5S6BUco8yAvi5O684
         bxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786626718; x=1787231518;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SwGJJ+A9z3NJgDEvUS+8UxqlJZhSVXFUJkzDSX5uv20=;
        b=cYhMa3KWltaEO7iRfip2Cm8wBwiORik1jFsjCDVQNssDJiQCTvWs0D4Tfsiw24G4TQ
         bBwnYXM7tEM7qHMnZ0ii5NMggTYrCWNdzziK9dK/j0JdXq7dxbbcohahNSjq47ZZzCwp
         osPwxYIH/c9EA4pRMl2ScIGkKq9qLx0P+FIxl/wXh/8M4wed76P2vp1zAgdjbHdG716e
         OTrzATOmLwzTSVXLOr5QwafUrYpkyUaVpgQ8FobDo0Iyhb9fJoGOC5mTH4UREJCnAhR4
         LzTt8Tuima5u1y4Ll0BMkEbM0WR21quB821No11LbchZPbMFCEVqN9xVK87LTFuXy/79
         eWBg==
X-Forwarded-Encrypted: i=1; AHgh+RpnHRsqxJJqWd72NX2+ZQpk6lEg6Wejs5roqx1BdGG9sFcKbutdOXyVnliGjz0XHvwwzZO7sH5JOv5h3UWiqBD7rqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmeLIQAZKQW4spatc3AtNAh6UN3Ts0mJsLc+8eG5gDWUfOagFb
	mCkaUaNlnN5m0GsRjEeE9xAms7o5AKx8fLgxMS64KiAhjGEsbC2r6qLmBa/njUt06lOQCyCysu1
	H5ysvNpddn0fvAwfdUkqxMA==
X-Received: from wmrk17.prod.google.com ([2002:a05:600c:b51:b0:493:f79d:63cc])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3506:b0:499:4892:d022 with SMTP id 5b1f17b1804b1-499821c5b19mr62829445e9.8.1786626717503;
 Thu, 13 Aug 2026 06:11:57 -0700 (PDT)
Date: Thu, 13 Aug 2026 14:11:44 +0100
In-Reply-To: <20260813131152.3589632-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813131152.3589632-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813131152.3589632-3-vdonnefort@google.com>
Subject: [PATCH v5 02/10] ring-buffer: Hold cpu_buffer::lock when resizing a subbuf
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

