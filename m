Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54142517BDA
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790062202; cv=none; b=l/E48ZaH29Sj4qivNo4x90vffYNxbtWsn000Mvu1TcVO7nI+ufcQ8vc84Vmfhp29X6h2ok0KYyzQs53cvvvgHqrGoVoa4p4AbFLWbqLqqfylsWEpPOolaTeQ+xci0nXKx4oAXIFC7x9SaAegnS/02nrBM085bYTGDCvYZ9K91pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790062202; c=relaxed/simple;
	bh=P2j4H5OOPy1kkyjHKrQvlylI3nUgsfi679sciLI2LvQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=br2mSRtlFG+VkAscNpSkw3aNt2G0hBE0QAvAUojXQzWE8XfihTy0gbZq9WcXtBzyNE6tnjvj6eZ338MV/JU7ic1MG5ecDzLR1c6qXiJ6gZXSmlFABmIbijb0Oiq98SDUVRenWw20LT8n3Gw6KM/jgTmuJcaElvLDC00Nb0eOREc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GKw2hUpK; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GKw2hUpK"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49e73659ac5so53779245e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 00:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790062198; x=1790666998; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QUOBcf3HiZT7N7pYBnaY6Oqumehc4v9l69pjwog+28Y=;
        b=GKw2hUpK1KlAnsENgfyDU403oG1jLrMMd1pw/auFrSnyYryauoB5zTuxEp+RXdyBrD
         PIgPpTQxmSk196m1KHf0LHjg9LA7N1WizDS17eiaagdGxXYSU6ZOsjQh7eG0AkNLSufg
         VYqROB+t7E0moIn5HokpevLNuxZnYcE15b4M8zv+DENwMxW3RTdGG8sy2NZZ7jdfSC7x
         ve6k6T4t1H0TvNm2+eRkuF3zpyzaZ+418UV+RmIPdSJIn41VlWxroRsCyioxJhPh1j+0
         B4enxD/YU03XyZkc4B3BlCQnxxPKBGF5jjKQrExI2FpptvvrH0ZTu1vq32NbvJHzXpBs
         bdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790062198; x=1790666998;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QUOBcf3HiZT7N7pYBnaY6Oqumehc4v9l69pjwog+28Y=;
        b=fMHXwTawFnu5ydhmkJUdBv08sFQdoI7UktB/PPSNECPbpU2BnKIZwOIMjzr8z0BPHP
         VPr88WnKA8Bex6znnDy5V96r7udzMxtopVWT4xv0cakMOAlVmFgb5a8cuSQ5GyCpRnk6
         Wgpm3E/w+ZNCEn9bioBnT+6+x6UVqUiqhpI6WhC3HOSfFyVn64it+4GXBEaOPm7PMTyg
         k+co0z/A+h47+hDA0A8Ef1A+k1xY+zKJ/c73zbInOr96KLvrGQM/qFKOtiPvPfjcFugB
         8GnwQMDVs/mpxdBDiCxcrRQe7F4Zl8tEaqkPspf+V/1FwVMXJKs7yHjDyx7KrVJ0QTao
         +hOg==
X-Forwarded-Encrypted: i=1; AKwUvBw+Xfe2z9fASqmXXYLZs99AhMnMKgbmQd8xMZ+328LT/VCwCJRm89Bbojy1h2gy4VVcfBJVTIB3WeY6fd/j25bO+6E=@vger.kernel.org
X-Gm-Message-State: AFuF++myLBlUBJalCKIP/hxypHqu2J/+ztxcEsbHWShegSrddSIa3E3x
	B/5QSiYUkq1tSv4moAHEdKT36PCk0edHeeOVAR9HVK8GOWKg2arC7/rupL6mBlymgPf3vw7bUQ6
	P0PE7/rKT6YC0sdArtNKqZQ==
X-Received: from wmsl27.prod.google.com ([2002:a05:600c:1d1b:b0:49e:7d32:b790])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b05:b0:49e:6249:268b with SMTP id 5b1f17b1804b1-49fc574194amr168813245e9.32.1790062197497;
 Tue, 22 Sep 2026 00:29:57 -0700 (PDT)
Date: Tue, 22 Sep 2026 08:29:44 +0100
In-Reply-To: <20260922072944.1281427-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922072944.1281427-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922072944.1281427-5-vdonnefort@google.com>
Subject: [PATCH 4/4] ring-buffer: Use kvmalloc for ring_buffer_iter::event
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The maximum size for an event correspond to the capacity of a single
ring buffer subbuf, which could be multiple pages, making this
contiguous allocation likely to fail with memory fragmentation

Switch it to kvmalloc() to use the vmalloc fallback under memory
pressure.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 3129589e2d0e..f03fb9ed3372 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6467,6 +6467,7 @@ ring_buffer_read_start(struct trace_buffer *buffer, int cpu, gfp_t flags)
 {
 	struct ring_buffer_iter *iter __free(kfree) = kzalloc_obj(*iter, flags);
 	struct ring_buffer_per_cpu *cpu_buffer;
+	unsigned int max_event_size;
 
 	if (!iter)
 		return NULL;
@@ -6489,7 +6490,9 @@ ring_buffer_read_start(struct trace_buffer *buffer, int cpu, gfp_t flags)
 		mutex_unlock(&buffer->mutex);
 
 	/* Holds the entire event: data and meta data. */
-	iter->event = kmalloc(rb_subbuf_capacity(buffer), flags);
+	max_event_size = rb_subbuf_capacity(buffer);
+	iter->event = gfpflags_allow_blocking(flags) ?
+		kvmalloc(max_event_size, flags) : kmalloc(max_event_size, flags);
 	if (!iter->event) {
 		atomic_dec(&cpu_buffer->resize_disabled);
 		return NULL;
@@ -6520,7 +6523,7 @@ ring_buffer_read_finish(struct ring_buffer_iter *iter)
 	rb_check_pages(cpu_buffer);
 
 	atomic_dec(&cpu_buffer->resize_disabled);
-	kfree(iter->event);
+	kvfree(iter->event);
 	kfree(iter);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_read_finish);
-- 
2.55.0.1082.g2b9226bbc0-goog

