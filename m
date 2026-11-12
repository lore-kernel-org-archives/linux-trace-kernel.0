Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492894;
	b=Tl36LLpj1QBVTd7S9Qgo8P2d+7GlJmxzA8OfytPrtjTRd/AbGA+V78mN7VyBKXMBfgpo
	 a3xAZbAAtSwbHxOPYGGIkjwptxkDVnL0fvCOiMBmVrtj0ypPR3Ou/0z+ugOzce2F6Q/sJ
	 QqmXzKFxpMSWEdQvkELZ8GLJXH4x/7+e7a12XA2zEkZj5YHDE0WbqUg5+aVGwiqag63W1
	 tC7OgbC+kd4lZbVguEDyehpyiHjjZoszMqeMr67cXX7LKddXo21bCBYMcyHOUwE917bHP
	 dcjzu+9sF7AMkas289auleQI0+QySOGhTfM40HBclUXi7zaSaUJUfr84vxdROTl8oZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=xAClSiqpxgiWtN6dUqngBZJDx0kh28kPHWYf1nhrDXA=;
	b=HKEaty60RniTKnbIYgIq2pPr0UCZ5oXYCOxZaVKNks3Co8mxK3A/cyUA2252rCmjILMF
	 95eyYqkDI2P9dHpgiL9HeKoQfuqhRrY4DTNec1kci4Gmo4x4cafW+8bEBrub55nwdBTWy
	 1+9P2uEsBIdOEMYknmnWuVPyZQ1wuulPBzDfi1+PTZe5QIRKh/Qpa5tdn1pkAm7sXNhCD
	 oS5oilMO6azc+Sk1hpPNSZAGoqSC/AoMOB9l13DZMslU/cy+v4j3tWeN6YCbd0B7N+pEq
	 5rGiKYjeTQinhPmkySIQ2yoI94TCgtTt3spjn8es0Fi7LRMYqECuqx8ciysZA55iNRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jfrnVgTz;
	arc=none smtp.remote-ip=209.85.221.70
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4D6606A33E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 14:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C4D6606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jfrnVgTz
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-49034831bb3so3692346f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 06:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794492893; x=1795097693; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xAClSiqpxgiWtN6dUqngBZJDx0kh28kPHWYf1nhrDXA=;
        b=jfrnVgTzpxLUTf/eoqYwvOS2cAv8xZz8nodQW6ZnOEkjIqMsKK4HwbX/AnnnP9uFa3
         fjJ49ZWwutbFXu0cKoML/jqLSjljRv/B7n8VsCpnuymjV57R+pj1L49nqUgzWiU1AuVA
         /eLPWVmcEewRSMj0OTTkezz89TJbNUwpnsazNv9gdOEVQee8s7yjwepxaTCBPXYc4acs
         jHsymJXwk9Z/NelXTT1L0yQn6Am27pOkRbeeKrKwDHO1weQ9m/7NoTSKKb9fV9MKi6Q9
         fDnhCEct5mNFMIri322dAkKoDQwQJbIXvtQF8d1ZkiGHsVrP/ipAFqReRfw2tHXT7Hpk
         5FkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794492893; x=1795097693;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xAClSiqpxgiWtN6dUqngBZJDx0kh28kPHWYf1nhrDXA=;
        b=n5K5SG0fB74NIgvmPd89gbaZ9S/XWKwa5mZSp3r4bpXuLF9MIYFZX9Zry078p5bAE+
         WWGsDzI4v8PLz9RUSZVoqJrxMsq8WVEW3CpFgqbmbgY6XaK27k9VhtkUCSDuyyU+OlUH
         Pfn0D09Wct27yav23ZkZgPnOcwhG1XsYdek9BXCvPMIO8Qbhv00SEAqnBwbdujLvIyaJ
         h/SR9DDU7AUB/nMfwZvdLSRn9RutiTtuTGxKhe6w0CxFjBWuw9888oYB2+XyjXrRpwPm
         2jTRbM7JPfl8c4AE/Q53H2UqQHBuvYNfZ+Q2Aq362x1XTbSDxR2nIU5jkOGpUhYmUvUU
         0PvQ==
X-Forwarded-Encrypted: i=1; AL+hErGAIXHX2IaAGslmyIkR5mRJ4r1jn/9dQ6BfN9BK52PLIWuPCXXdxIBl6e9YxC2FkBcLOSXcpSsqZobFrrZik2kuoEA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BvLHDWHbkD5qUchZsmhQ6I4Mr8ZDnob+8Xp4/5HVt3CQOJH2t
	yvgn0hBiDsbeZs9h4+NYQXomQ4WUE4eElAvkV278C9/PyUskhbWcJ5oqHXF0qw9Hx7kvesJ5uou
	spqXOrhTe+wT/X2/e3odG+g==
X-Received: from wrol12.prod.google.com ([2002:adf:f48c:0:b0:48e:55f9:4a97])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4013:b0:48e:d27:bef2 with SMTP id ffacd0b85a97d-499c77414eemr9585917f8f.21.1794492892370;
 Thu, 12 Nov 2026 06:14:52 -0800 (PST)
Date: Thu, 12 Nov 2026 14:14:34 +0000
In-Reply-To: <20261112141440.3050124-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261112141440.3050124-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112141440.3050124-4-vdonnefort@google.com>
Subject: [PATCH v1 3/9] ring-buffer: Hold buffer->mutex in trace_rb_cpu_prepare()
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

ring_buffer_reset() walks buffer->cpumask twice across synchronize_rcu()
under buffer->mutex. If trace_rb_cpu_prepare() adds a CPU in between,
the second loop resets an undisabled buffer.

Hold buffer->mutex in trace_rb_cpu_prepare() to synchronise it with the
ring buffer reset instead of locking the entire hotplug path. As a
consequence, the cpus_read_lock() in ring_buffer_subbuf_order_set() can
be dropped. The one in ring_buffer_resize() still stands because it
schedules insertion or deletion of ring buffer pages on each CPU.

Fixes: b23d7a5f4a07 ("ring-buffer: speed up buffer resets by avoiding synchronize_rcu for each CPU")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 32d3c47dbdf0..80f500ffd7ac 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2824,10 +2824,10 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 	buffer->clock = trace_clock_local;
 	buffer->reader_lock_key = key;
 
+	mutex_init(&buffer->mutex);
 	init_irq_work(&buffer->irq_work.work, rb_wake_up_waiters);
 	init_waitqueue_head(&buffer->irq_work.waiters);
 
-
 	bsize = sizeof(void *) * nr_cpu_ids;
 	buffer->buffers = kzalloc(ALIGN(bsize, cache_line_size()),
 				  GFP_KERNEL);
@@ -2923,8 +2923,6 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 	if (ret < 0)
 		goto fail_free_buffers;
 
-	mutex_init(&buffer->mutex);
-
 	/* Persistent ring buffer needs to flush cache before reboot. */
 	if (start && end) {
 		buffer->flush_nb.notifier_call = rb_flush_buffer_cb;
@@ -3330,8 +3328,9 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 		return 0;
 
 	/*
-	 * Keep CPUs from coming online while resizing to synchronize
-	 * with new per CPU buffers being created.
+	 * Insertion or removal of pages in a ring buffer is scheduled on its
+	 * own CPU if online, so cpu_online_mask must stay stable. Must be taken
+	 * before buffer->mutex.
 	 */
 	guard(cpus_read_lock)();
 
@@ -7475,8 +7474,6 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	if (psize > RB_WRITE_MASK + 1)
 		return -EINVAL;
 
-	guard(cpus_read_lock)();
-
 	/* prevent another thread from changing buffer sizes */
 	guard(mutex)(&buffer->mutex);
 
@@ -8077,6 +8074,8 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node)
 	if (cpumask_test_cpu(cpu, buffer->cpumask))
 		return 0;
 
+	guard(mutex)(&buffer->mutex);
+
 	nr_pages = 0;
 	nr_pages_same = 1;
 	/* check if all cpu sizes are same */
-- 
2.56.0.567.gdb80ae8cd5-goog

