Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988479;
	b=t7/fgs364NM7t+QZ/OGIaI57DDCXMjDQEGwFmi9nSpNGV9Gsqwt7MnQ3nMSMDmL8fc+V
	 Xwg6cSQNz8DJfO8RoPa6CtGwSkrT0eZSLYeIclUzz4ghs7v0tke4VkhMjCsTAuXdI3GwF
	 b812Gz7TM4R92HBjOEv4iVesSapQtP+anhdXESnhaK960UkLNTeGvusaISc3MjU6+re02
	 oO4iQUOHWGU3kO1Vfdr9lJTGWcfiMSWA3OF2irPYrogD6q4pRMLt9r2ajB+d4px0lZ4eB
	 4gMUJiM662k/pEC6ePwFRZXFU1a2widc0dvSfc1nBkHC7rRBcuFPcez9VpE5NWdxRVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988479;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=cC3M+M7HNGl6VpKhALDRkxF/MNtxhDncWW/zm3AEr1c=;
	b=JFP4o5MdBLseXn78c5V65WGBjWMPOt0a4YxkROaC/USpQcH9+MZ9HeCIPqeYmkYX9eSp
	 E4PpX3LJFNb/XyuuQCj5Kk0kuHOCoTXjCdoxNyb7EzOhEeIqw9v2seicdmjH55zJM9Kpt
	 AJvn9fGUQIBAyRiqrz4kZVQr51LG1y/zWPcNDblW6/q1ji8IJwvI6IxxcsM2MCf/7aLu5
	 Yc00N+gkvzHzUZIktXIpO0CDWxbObiF8Q0vwDdMSxGyYoUzPJBrpo6EXRnDQdyhLfYFJ4
	 jhsxG/8dJEzqOpQ9xVs7wOcB1nbYDoNM2joWbmB2EJffFOsT6jzlmaBljq37lQ8KJ7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b0xZork3;
	arc=none smtp.remote-ip=209.85.218.72
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BD16082BC1
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 18:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70BD16082BC1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b0xZork3
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c44903d6927so109764666b.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 10:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793988478; x=1794593278; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cC3M+M7HNGl6VpKhALDRkxF/MNtxhDncWW/zm3AEr1c=;
        b=b0xZork3SYlyK2remk0H5QpDeh2x/bs44/W72/gP2JghKBAMrnx7XdgTqihJNirgwT
         m+NsnQQRpTa1XUug8JRuwAZj/6efhU1LSDkjLWaszO6wGbsDRomCmUpr0JiD2+EyH9AM
         nB27l/Wlf+sDCDEjNtyZesRcVfr6XoPECSCQdbO1DBS3IgMTARCxG6yXGCTYDzxi9FxJ
         RXQP88q+vG4AdW+YgC+/ffU+uSRsT5egWPcD46whdGt0jRddWbDQlwrGgwpz+0eYE67F
         vE/o8Jl40BQ/5YAFGElxpOAHJotWF1CJE1gkhWyqPDtsw9u9Jg0ql9NNkAdrWa4tVpFV
         3MNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988478; x=1794593278;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cC3M+M7HNGl6VpKhALDRkxF/MNtxhDncWW/zm3AEr1c=;
        b=YBpijE4BImc3zPeKbMWfbGsifnPuJPmLQD9edichiB97cm+cXVq0YSC0R/BDfyeaP5
         4MZZyoaS9ynAWRPYe0EzE66u69j+ZWSzsL8JyMCcapfvGdAM7YFM2YSIf/yANGOwhy4l
         UqwnErGAvY9iI2MrehFWPswdQ1D4+1R7vWttmtSuDIxoy4i8NWmuIR6A6xdSM8ABwF3R
         fECRXmbH5p3KgkBYZdIKn7FzY75sDxo+TSJ10q3dbeB022SCWBcIu7rOPzy/kleIFAMV
         V7MobEKJE3aeBem/CJAEXzjaD6XL/zoeUygh5NYzQA1Z4Lhw/lDR/8KL95Gmvl9grs1z
         zs9A==
X-Forwarded-Encrypted: i=1; AKwUvBwEYA9zSJ00TMz6p0sIis5b3FAxsPsvUnmR/fErBIACQKIC9MGKpwUVcqNDv5PXowlPMsbC4Nmisqiu6fxa6ukFsu0=@vger.kernel.org
X-Gm-Message-State: APuU4Z87+lhTYO852VpCciD4AUyDUWjKrTARBKcexQP5I58iPkI65bMr
	oeIfmiN7f2fx+d1/h4+MAodN6o6Ibl8rzLcA8WxQpPBSoGYESnE4J7Rxqrkl8eSD+et5hZIKX+S
	ysmzzdXCx60GW4L0B04bU9Q==
X-Received: from ejcjx18.prod.google.com ([2002:a17:907:7612:b0:c3f:741d:2c1d])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:728f:b0:c29:f5d8:9c75 with SMTP id a640c23a62f3a-c4d3536d200mr269675566b.36.1793988477702;
 Fri, 06 Nov 2026 10:07:57 -0800 (PST)
Date: Fri,  6 Nov 2026 18:06:49 +0000
In-Reply-To: <20261106180657.2460376-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106180657.2460376-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106180657.2460376-14-vdonnefort@google.com>
Subject: [PATCH v8 13/21] ring-buffer: Use panic-friendly locking in
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
index 0dc661a95d67..9c707cb751ba 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5690,6 +5690,9 @@ static void rb_iter_reset(struct ring_buffer_iter *iter)
 	}
 }
 
+static inline bool rb_reader_lock(struct ring_buffer_per_cpu *cpu_buffer);
+static inline void rb_reader_unlock(struct ring_buffer_per_cpu *cpu_buffer, bool locked);
+
 /**
  * ring_buffer_iter_reset - reset an iterator
  * @iter: The iterator to reset
@@ -5701,15 +5704,18 @@ void ring_buffer_iter_reset(struct ring_buffer_iter *iter)
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
 
@@ -6389,11 +6395,14 @@ ring_buffer_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
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
@@ -6539,12 +6548,15 @@ void ring_buffer_iter_advance(struct ring_buffer_iter *iter)
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
2.56.0.455.g6c5a503b38-goog

