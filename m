Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941A74B4027
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791886946; cv=none; b=eKc+rTdvI5iGLAyuDWav9TYs1mulrM0KdjVK6sHTX8BCqkkgFMA0qq/lA8t5O8ka8PrWtYzS4t9BE4YOke4W+i6ZGUsSYY8xUKcrKGipX8XUgwEFXwdDwXk4SR/ADCmm5KTNWzlgCTelY3rOGPvzZhWhhJdXgSUEzIkH5yCaDHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791886946; c=relaxed/simple;
	bh=N1Xc7iRJCL8xK52U3E2xf+99h/Nvqa1jFoAcp8xf1KQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GxbinygCP9K3kRroPSIA4Ga/hxnxHYTuf/DIa0ee69JZUg4J/B1Z05ptF/y2WfVdo2Oby+dWDmncttFml8FlFyMkdsDCLRurNT0jqdYT2A+0akQDi9CKYrrRe1Sc80BUaDbUZ690IpAYYVV2dAdvzJZNKqNU98wL2NbqzvdQ2fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CeUZZpSH; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CeUZZpSH"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c46582442so1799786f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 03:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791886943; x=1792491743; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lzZOzCHmRQkt/K2BSsAPDeJWnc3SgPPj3hLhIMFZqEM=;
        b=CeUZZpSHMGfISlNjxOFdpAmxrYyULAB6hEiXbhwKz0gtYhG2ND75f5cVop+8Rhi6B1
         D2F06B8T/kqWgXFY6pUmDXIWMYJa8hdxb2rXz3xwLj4XPEgaAXm6IqGlrBUVmgs6JzWW
         UEcLY2raP73SN6daKnN5ad43Ik+/k217EuL4ioVTFgS+IVPZLO1PFshLr7D/tTFPre8R
         d0ar7g4UM/6+xZMldrIcfrng/nT9ITMxL0ICOYXFlnY1q+Rpa6wMVffsofuE4Xh78rEV
         ygPrFQFUJ4TzZTQUxQh91BA/xwBz2B/mse1RFH93fYy4+nWrZE+YIPpMqH3EKltSi2Vy
         6gQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791886943; x=1792491743;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lzZOzCHmRQkt/K2BSsAPDeJWnc3SgPPj3hLhIMFZqEM=;
        b=kPsyNhajSVpnsy/CWICGjUxkQlnJLZ3M+eBUhJxl6fDXCci3L+dC255T09w9hrVPXR
         /B+HnQEmj/ejq9XNd+rngFfhNA8UWutmhGp7a2sbLLiKKySr/DjPxKCdTwGWDQcB977L
         0aAm6g6KmLTDr8Ov8e0uEIUYcjaPMySvy+awMuCoRXfqncXIRlQgT5u8Ij3oEWshY+96
         XS8THUUC4+3NDr1R1dYoiw82s6q43S+asD8dAQWDIX0CVyqSsSxKL+Cka3/fNxQV+lVt
         aCNuHEfwbwzpP8A9EeX5hj2wYsfMEn6Hs1GeAMHGis6GyzqUMAdHE6ccSojdC+cL4oUK
         DtSA==
X-Forwarded-Encrypted: i=1; AKwUvBxdvyGsLZ2w7yCF4OvOFIIyCMTTWgrrzU0wEuTy0bVu+hk14fofqB2MyEnh0x7cb9rh+pJN9aWnToX59NvFx7Ltr1E=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZLDx7BSovhAv09xWW/mYBNR1pUeTv9EkEdWY5Om6e7EKXfRG2
	vSPkt/zDak7qcE+bGBDWWdv7VmryxQhYEEVyBwIM436/m6+fiWg2GkRbhTgvIDbOCZZVn4wd2pu
	r8fJOo6Lnsh05WaGeXjvBvQ==
X-Received: from wrth8.prod.google.com ([2002:a5d:5048:0:b0:485:97bb:77ba])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:821a:b0:4a1:74a1:7ecc with SMTP id 5b1f17b1804b1-4a18e446ef5mr197195765e9.1.1791886942488;
 Tue, 13 Oct 2026 03:22:22 -0700 (PDT)
Date: Tue, 13 Oct 2026 11:20:47 +0100
In-Reply-To: <20261013102047.1488347-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013102047.1488347-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013102047.1488347-3-vdonnefort@google.com>
Subject: [PATCH v2 2/2] ring-buffer: Use subbuf_order in available memory estimation
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

To avoid failing in the middle of an allocation of a ring-buffer,
__rb_allocate_pages() looks at the available memory estimation with
si_mem_available(). Use the subbuffer order with this estimation to fail
early if necessary for ring-buffers with an order > 0.

Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index b3a30a0413a5..63001ab1eef2 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2440,6 +2440,7 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 			       unsigned long nr_pages, struct list_head *pages)
 {
 	struct trace_buffer *buffer = cpu_buffer->buffer;
+	unsigned int subbuf_order = buffer->subbuf_order;
 	struct ring_buffer_cpu_meta *meta = NULL;
 	struct buffer_page *bpage, *tmp;
 	struct ring_buffer_desc *desc = NULL;
@@ -2461,7 +2462,7 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 		 * not going to succeed.
 		 */
 		i = si_mem_available();
-		if (i < nr_pages)
+		if (i < (nr_pages << subbuf_order))
 			return -ENOMEM;
 
 		user_thread = current->mm != NULL;
@@ -2514,12 +2515,11 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 			bpage->id = i + 1;
 			cpu_buffer->subbuf_ids[i + 1] = bpage;
 		} else {
-			bpage->page = alloc_cpu_data(cpu_buffer->cpu,
-						     cpu_buffer->buffer->subbuf_order);
+			bpage->page = alloc_cpu_data(cpu_buffer->cpu, subbuf_order);
 			if (!bpage->page)
 				goto free_pages;
 		}
-		bpage->order = cpu_buffer->buffer->subbuf_order;
+		bpage->order = subbuf_order;
 
 		if (user_thread && fatal_signal_pending(current))
 			goto free_pages;
-- 
2.56.0.385.gd3acb90ef8-goog

