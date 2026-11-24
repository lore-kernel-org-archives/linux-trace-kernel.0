Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534173;
	b=TK0XzLwa3flqG9iMDJWcyf8kNHH82nYPrNosAguPYiO/FD3L4AgaOMNNOnMBt/hSEm9M
	 NiF6897KDtLcv9cDwv96ot1Pv0JdidqIO7Uu1/hhMvM/GWzoLNTqbM/ibgwTaDnCaQ/Fi
	 4mg94XmugTugO940St1ZlIJVLe398qdTWUFixDd8ome6cDzpyHeN52B0QFPGL9i0CabY8
	 Mt6cIkj8XdVPo/SUzuZsl0AGGeJVNOz7b7grfKNRhZ4xfME1gL3WBFPEuggHX+eUQ3Hvt
	 yDauoHfF7YvFzxz1WVIQ89ZIzYMMiaViYxHa7ZxKhSaKBpL8cVdxqytDeDnajnu/yyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=0G5x3xdS/WIa3w8/TkIKO+PMKsIvE2UD5dO8iiJFAnk=;
	b=fZJ8Zd4Kv9kQ453z+kT2z+zGb1aU+zYiLvcF51t//L6Az3LwWPMhyG7kjPzv2n/tRKyb
	 l4a6B5M6w4dq6DRWfZgbYua1Zr6pkIJA3U1LfApRFDqpK1wgVLfa/tw2U2pPp/lTHWAN7
	 ZyKm+/v4PUYsjOU35KkHOFEC/5Swt5oJf3RjRBvxIF7vgVgu733jvrPo38eT7I/OYQcZd
	 GoaM0OP0Xau/zxkvYWNtBgy7Hk9ZG02BI+QkzYzj6G8snUn2+efKzqEvvw+Q4kW1ChU3s
	 AGnSYArqFhfONXyLXRdW9wgI8C+Iy+ngxa9JADYg5UciA69exNAeUW9QokUIGcg3iEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fpijvnAl;
	arc=none smtp.remote-ip=209.85.221.70
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59EC606A339
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 15:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D59EC606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fpijvnAl
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48fcb657f32so2775647f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 07:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795534171; x=1796138971; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0G5x3xdS/WIa3w8/TkIKO+PMKsIvE2UD5dO8iiJFAnk=;
        b=fpijvnAlEq3vscAxY3gBGNHNHxFRJbh5QnBhyQsjgMor2GZasei3mJ8ZbU2hZKDjQu
         AOlyDMvV92mYJOflkgas5u8oG2FkbX1fUY1ryXHaEXRax18dN/aV51pixhKpJCo4pkOP
         pPGs0Ldy7FV1RO9DkM6zxo2Pn78Pu5xYh3g7HY6F5e7vKEV3KwC7e6Odb63ZsFMI2KJ9
         YG2SnlVljnHUAVjawVdIjpN74hoJRyq20Jb5i8EUuDGTPTn1RuUxgI68X6WGf3oO2+ZR
         LMXH3BOS0XQc76GSYyB0Ho8P3QiRQKaIyPp48JV5glauWiyLy+Bp+61FGwSJctwp5X6V
         NARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534171; x=1796138971;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0G5x3xdS/WIa3w8/TkIKO+PMKsIvE2UD5dO8iiJFAnk=;
        b=cPfp+IhbnRvxrK8jKZkuCu6YyIf/FFMoMmxI5CweWSLONFjAVM8yb06lvlf7pDQ+O0
         jk6VU+i/4ySQc1OZm4RwyBgdNK2Qi8LEy192ZmlCo3+Vs8jGvStrqWFqG4/JeMhxwe5O
         rbra5xQiA4MlwmcLkxaZc/uEDBtMCGYc5dsQ0epcXwfJP1wTckXH2C04qbxB3ah21a8x
         es0Q+8Sgree1S453OH2n/tYASyhzl8SOh/RlEdlbilyK7Rn6bo6Ea2cNI9R2WU1ttlU+
         luKTVb0AwafogW0uwB6elzlTbbLjNxB6q9oO8PxvVZgfQC4tBQMIAhTy9SR/8945QL4r
         U0MQ==
X-Forwarded-Encrypted: i=1; AL+hErFstmuD6jzmoe7w9Qa9xuNtQXTEilxRdrC3MGCEG337uZAhIaz2dEAFG4H8+y0V+6j5i99pukJJGD7EvmTDkSF6J4I=@vger.kernel.org
X-Gm-Message-State: APuU4Z8VvL/tzz9pAdtz+NhJkctMSFSgJ+2EHQDQ5H1GUx4H2tVOXTnG
	hYlAxah/+y6FaBrrU0F35kcpz2RXTVlmx/0repbzYtlcmVpnyNRpouSNRpJUWV1BK5KK5M9Ghvz
	VePMBh+cif8dSYVHIpELGqw==
X-Received: from wrsw10.prod.google.com ([2002:a5d:4b4a:0:b0:4ac:8319:4a6e])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4b1e:b0:493:2eb8:e7fb with SMTP id ffacd0b85a97d-4abb6930039mr25553556f8f.41.1795534170967;
 Tue, 24 Nov 2026 07:29:30 -0800 (PST)
Date: Tue, 24 Nov 2026 15:28:37 +0000
In-Reply-To: <20261124152845.2233401-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124152845.2233401-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124152845.2233401-14-vdonnefort@google.com>
Subject: [PATCH v9 13/21] ring-buffer: Use panic-friendly locking in
 ring_buffer_iter interface
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for allowing trace_remote to dump the buffer on panic,
make the non-consuming iterator functions panic-friendly.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 42507e97291f..f517bc651e84 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5697,6 +5697,9 @@ static void rb_iter_reset(struct ring_buffer_iter *iter)
 	}
 }
 
+static inline bool rb_reader_lock(struct ring_buffer_per_cpu *cpu_buffer);
+static inline void rb_reader_unlock(struct ring_buffer_per_cpu *cpu_buffer, bool locked);
+
 /**
  * ring_buffer_iter_reset - reset an iterator
  * @iter: The iterator to reset
@@ -5708,15 +5711,18 @@ void ring_buffer_iter_reset(struct ring_buffer_iter *iter)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	unsigned long flags;
+	bool dolock;
 
 	if (!iter)
 		return;
 
 	cpu_buffer = iter->cpu_buffer;
 
-	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+	local_irq_save(flags);
+	dolock = rb_reader_lock(cpu_buffer);
 	rb_iter_reset(iter);
-	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+	rb_reader_unlock(cpu_buffer, dolock);
+	local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_iter_reset);
 
@@ -6415,11 +6421,14 @@ ring_buffer_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	struct ring_buffer_per_cpu *cpu_buffer = iter->cpu_buffer;
 	struct ring_buffer_event *event;
 	unsigned long flags;
+	bool dolock;
 
  again:
-	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+	local_irq_save(flags);
+	dolock = rb_reader_lock(cpu_buffer);
 	event = rb_iter_peek(iter, ts);
-	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+	rb_reader_unlock(cpu_buffer, dolock);
+	local_irq_restore(flags);
 
 	if (event && event->type_len == RINGBUF_TYPE_PADDING)
 		goto again;
@@ -6565,12 +6574,15 @@ void ring_buffer_iter_advance(struct ring_buffer_iter *iter)
 {
 	struct ring_buffer_per_cpu *cpu_buffer = iter->cpu_buffer;
 	unsigned long flags;
+	bool dolock;
 
-	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+	local_irq_save(flags);
+	dolock = rb_reader_lock(cpu_buffer);
 	iter->missed_events = 0;
 	rb_advance_iter(iter);
 
-	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+	rb_reader_unlock(cpu_buffer, dolock);
+	local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_iter_advance);
 
-- 
2.56.1.809.ga0b61035b5-goog

