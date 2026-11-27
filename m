Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795792423;
	b=PNxSewP8g0AHGc6pNt4ZB0q0mZKp3P5OXcLtsF4iqzDevAaDMNa3Z6yGOzTAwBsf7tNr
	 5ETzZRZQZ3DdrGtWNXuy++WiNHsdLY9WVyFsZ0XJS9ZMiDdPLqusu1Q+cD8tZ8djmb1FO
	 ipNvMvo/8apWYi+gvLFba0C3JnHYBP4rO5n6026DltN2Uq0hu7SCgL9lqU5RbQjye/ip6
	 CNyOtpuigwc+C+6GkySSYUgz6kPT+vaj9YAbfQiuWktZJCik4O/PuuX1X3macN2zCeaMt
	 rVePsfrAV78JOP9jcTQfaHMvRcTWSfJ629CoFW6xo/MCJH2iDlABssKPKG03oPk+glA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792423;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=A7NcaP6FDZ+XY+/FocjZD2VG21QQhrjTLgCEJNn9mRo=;
	b=dSpl7KPlM9mDvt2E9nz7t45jDgYByWqlM6RJEjYXF0YS50y+TYVUI4fM50cQ6hS8boVH
	 4pwQ0QsLw8IlvQz47dUgvYeYMYkxRsW6dv1x3mln0L6L4JuBYQFcp2CvCdYjB++Ky8nuT
	 OYnUnt2RSu3yepP/VdXF0EDyLvfxlwc2fe9Td7oieVh2GC+EvlLobJgyuKRXUPis7zpei
	 wEMWGMGTIPr81A0HcSKqoV6LiXm6vPgv03/yJsjddCND1WZ2fcsG6t7QnpZeMZr0nxT5f
	 j/7CxbehBtVQQ8kzi3X8n8cqtWF5X8yEsDNGcis5IcAp47aLA+IdHqbi8rjzAbZKinQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jOzOdJIT;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE450606A68B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 15:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE450606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jOzOdJIT
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4b9f8c66f72so11138095e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 07:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795792421; x=1796397221; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A7NcaP6FDZ+XY+/FocjZD2VG21QQhrjTLgCEJNn9mRo=;
        b=jOzOdJITVGSsJVdQDT58zLr/mtr6JJAosTtEUOVJnhMXcwsnu80Tv192UiNieQstE4
         nwld3BlCEtabX2ngmKRX7CNc/IZ80yDw4DbL+3DAzrnjKoYPudwiNYD8u3Ge2+CtUfix
         15iuFlB7w+vRd2V300mxA4FsZBuycwehT9nEemFDyuleA4DQ8nHxUSNel4EtZTsiMJXI
         QV0CVEEYWH1CF29SOwK4/G/lzP91FJV4rbI5trb5YnnE0DGsTlFIdwlTU27Q7z1XmRzB
         HEYqrti539I6m1g8m8x0s5B3lx+mqD3xL/CqUaoG5ILnvaygQNuh2PTSAd0cmkkc6O7u
         dfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795792421; x=1796397221;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A7NcaP6FDZ+XY+/FocjZD2VG21QQhrjTLgCEJNn9mRo=;
        b=2fd5T3rpbEv8NjURKrx7MierbpBtGWAfGY3glgXc+ZGJ+XO4rEA2vbSNIuD60Ay025
         B50tcJfYxxS/RnS+43mNBFeQkOz8ZQelNGupt/5a3cJx/DT0YsqhwyfasTCM9HUXZCWu
         AgKGxkLUCP9W6NNLctn3cIkX53uGXCj5GoFUYAss8I1XWaxZOaiyIRlC9gVCaH/dM3N2
         tPeLNjqdgBcfJv8b1eig0jo9to2CGQPJ8nCo38M3xTjKHrCHK/upeHC+0DxbV9cfyFoc
         kjQr9gzL+y/rom4EV6/mrDH8jgU3u8YWPN4yAKHa6m0ymCbb3nsmQPROTkcd97r83diY
         lgkg==
X-Forwarded-Encrypted: i=1; AL+hErGcF11CiPFtwfItVazr0Yljstfw5YKBzTt3Pc1K71oOfhrMDo5dv45M7IBJ8jhsFLVPxXkP5xwH9SrNwOIkupYXxwI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4j/4oj3rp1zCtmfXg0SYihPig/GUPcPqC42MIkxtVOteyIO5U
	2PYKXvKd5eYH7weFjIOgOVIlvDRTzmpp69UwL1G0PAgnl4Mu0ryzEJWtEyT+j70QR4IRRx+f8vC
	0co0CU/YVaO906/dWCOqSOQ==
X-Received: from wmcn11.prod.google.com ([2002:a05:600c:c0cb:b0:4a1:d8be:ba51])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8210:b0:4a1:dbdf:17a8 with SMTP id 5b1f17b1804b1-4bb887e25e8mr494342265e9.2.1795792421059;
 Fri, 27 Nov 2026 07:13:41 -0800 (PST)
Date: Fri, 27 Nov 2026 15:13:25 +0000
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
Message-ID: <20261127151326.515232-4-vdonnefort@google.com>
Subject: [PATCH v2 3/3] ring-buffer: Use kvmalloc for ring_buffer_iter::event
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The maximum size for an event corresponds to the capacity of a single
ring-buffer sub-buffer, which can span multiple pages and fail
contiguous allocations under memory fragmentation.

Switch it to kvmalloc() to fall back to vmalloc under memory pressure,
keeping kmalloc() when blocking is disallowed.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index bcff4c12680f..c543c200f769 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6517,7 +6517,8 @@ ring_buffer_read_start(struct trace_buffer *buffer, int cpu, gfp_t flags)
 
 	/* Holds the entire event: data and meta data. */
 	iter->event_size = rb_page_capacity(READ_ONCE(cpu_buffer->reader_page));
-	iter->event = kmalloc(iter->event_size, flags);
+	iter->event = gfpflags_allow_blocking(flags) ?
+		kvmalloc(iter->event_size, flags) : kmalloc(iter->event_size, flags);
 	if (!iter->event) {
 		atomic_dec(&cpu_buffer->resize_disabled);
 		return NULL;
@@ -6548,7 +6549,7 @@ ring_buffer_read_finish(struct ring_buffer_iter *iter)
 	rb_check_pages(cpu_buffer);
 
 	atomic_dec(&cpu_buffer->resize_disabled);
-	kfree(iter->event);
+	kvfree(iter->event);
 	kfree(iter);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_read_finish);
-- 
2.56.1.839.g22a8290db9-goog

