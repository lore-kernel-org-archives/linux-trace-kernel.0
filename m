Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1B441D65D
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Aug 2026 21:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786050804; cv=none; b=MusQL/hlUlqNA/vsnH7eg5uGI5oHwp6vGyUuZ2yDUCm63eQ5ERkC8MzDI83p5T488y+TjSWbYYTyEImz/RBTcpWs7j98GZtKQ4S9waA5d+y19uBDl3LEh9HeQL+NNDAxH3NMFQfd6Wm9pyMimXMQggqwjoZI+wMo15+bbEgLFKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786050804; c=relaxed/simple;
	bh=VlE2z08t6X+XiA0gzWlpQ0jC0Shgst1Sw2nE7qYF9Rc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s/X8y3K6IMqs5p8m4sDqa2R68WZPOdnVgmtOyHWLyvr6ozOL/shFuP6NPa74yw/wpyoe8tI+DLt0R3Jl0vOt9mq2L+S0nZIZZLv7hbZmg89lcVdPozQMwX7ljFGpijXDpxLm+05+XCKFzHoWYhlxfYFKtKCSG+mgBqe+9DGWJBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=voo+6P/x; arc=none smtp.client-ip=209.85.221.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="voo+6P/x"
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f83450a8eso2225896f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Aug 2026 14:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786050799; x=1786655599; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SqgSmYxo3yxK1py85ThH2dimY8H9aTvliysywkSNw6M=;
        b=voo+6P/x7E02YLOUqqcXg4eOV7s9n29Pz1C1uPoTtXao83OHkIh7zUbx+4lzMs3NUe
         xV7054D1k4N80N1gTMB6hH6PCe0LntpKMZQA03saIWqmYMDz6gs0I1/s7CGIrencrS6q
         S4oJFH5jyb5PKT15KbMUtax7VlZkz+9TsL1+a717OJhwpKxwr2pCAwGWTMo4dpwSJJtG
         ZVi7YYjUMUV2ytbCo+DP9WzlAn8BotJgYStxWHr2M8Rhbo02tppx4pq81mL+W9mJw2rH
         Oh9bs1fwMV0ExBSv+LJkggRJnrTxmbC4TegOvi9wgmEYkzSSLPUG9JZ9TRI++lijXCfg
         1VAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786050799; x=1786655599;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SqgSmYxo3yxK1py85ThH2dimY8H9aTvliysywkSNw6M=;
        b=XK10PoQSbugTGEFtTcKTCRdPR1RWp0KGvNb9cxAai4+heWns3WvwBgAYAPSTw6WTYG
         WdDxkm+Z6SIbI7S9tw6xmG6tQpWuVzmuEZT9xnA7xpzhrL/9SB7FYY1qMH7GdMQZQwNZ
         jV/CO5Fxcu2xsG8qrxxeC1fZ2QM1fhMT31T2bpS67eOWBpDV19Yqsbo6PjyTQ2a+b5b4
         3X/IaOqw1HktietnkD3B33rSO7nRDIjIgMCjN7g2qIwdJlm87MhtvfmK5JogwGID0+6a
         3421wcnQdx5PahA37ZKLmZjtwuPaYst8kH/d0/qSw/XcY3DTWx9YDEutd4Pu+WsWP5JA
         nYFA==
X-Forwarded-Encrypted: i=1; AHgh+RrCz3zw60cRKRCEj8zjxF6fxPSVOSzWFL+voibLZBWo2vLSM2HZeVXS+3hwk9V0bN0JPFpV+LbjEx+DpjmiBR0pNoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8bYcv6d9b779Mzw6Fl8LWC6u1ddK4CJGjC7AnUvMZ/gvzII6H
	DPZql1SA2xdpUedJkzaCKoWsCf9JuNp2H48XokNu548Qp1cK57Sej+oJ7+pHYGYh7PlI1lfZMcg
	3DB95HsUmPI3ZmvobUzo9+w==
X-Received: from wrmj5.prod.google.com ([2002:adf:e505:0:b0:47f:5376:d9bb])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1208:b0:47f:6fe0:294a with SMTP id ffacd0b85a97d-47fec62b8d5mr22301130f8f.23.1786050798715;
 Thu, 06 Aug 2026 14:13:18 -0700 (PDT)
Date: Thu,  6 Aug 2026 22:13:03 +0100
In-Reply-To: <20260806211306.3704194-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806211306.3704194-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260806211306.3704194-4-vdonnefort@google.com>
Subject: [PATCH 3/6] ring-buffer: Initialise reader page order in rb_allocate_cpu_buffer()
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In rb_allocate_cpu_buffer(), bpage->order was omitted, leaving it as 0.
This is an issue for a ring-buffer with subbufs bigger than PAGE_SIZE if
when freed: free_buffer_page() relies on this value. Align the value
with the actual allocation size (buffer::subbuf_order).

Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9bc467c4dbbb..4747cf427575 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2510,6 +2510,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	bpage = alloc_cpu_page(cpu);
 	if (!bpage)
 		return NULL;
+	bpage->order = cpu_buffer->buffer->subbuf_order;
 
 	rb_check_bpage(cpu_buffer, bpage);
 
-- 
2.55.0.654.g21b8a5bc05-goog

