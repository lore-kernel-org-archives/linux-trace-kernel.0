Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E724D2EFE
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630196; cv=none; b=X1RnKUzRbArHBJPbPN6F1aMDZh5ec/Mnpe/sZvsjOMrgX0A0/phsDsww70l8dafmoJ2RyS5D14REvPTObmJ16S+x7Vh2Fy1vvIWj6tKEIujtTvsLZjHvtIvWTzFfp0N7GTAc74d1CxamIHthjUV1+Sg69U6GIiG6ehmczU0chDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630196; c=relaxed/simple;
	bh=DfAy7VDDWVWCeAjRIRIufm3b9bHxUA2M4Zkkvw7Ac8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gc+wf5Osr74LnZwCDKAGkieIsawg7Qt1eJSgInooEpYC6WvI4/ZtGpzXTafxM7AiiQ+IhKskxf4GNv8w+o23Nu5RM5eyz3neNVeAr8ddcHPx7/n2zFrAxR9Gz9nMqHXF6FXFGkTs1tz8eTJCaN1K8xFIQuG7bKTPqGEwrPX3y8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e1x36G2K; arc=none smtp.client-ip=209.85.167.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e1x36G2K"
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5b2a35b9306so708593e87.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 03:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784630192; x=1785234992; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ckgKBhGXHZ9CaItTD4hbwZ0iER98qPnh6NKPNGH0tb0=;
        b=e1x36G2KjpNQS/SbCgsK4fhcHi29vMwG6yaZJMTuZNRKUDBGMDrWzpOCMVb3Mop0/W
         Zf8nhZHI9Fizphh4YgHOdM1Jkws2XZU8DDXF8WHZBWb2sDwqqlXKI7RbJ3oJ7S1nICEm
         uZDpj8TDBjkqkH9FDNBSOBrnDY5aeNgKpS3wBMYrJVrx7bMYNkBSjQhHOz2F5tIIY1MN
         lueMndi5uBQPANQIG0LFTQsjm3Q8JVw7fR7PkActU0bLnqzjV6feTRJokyxX8Ys/ebX2
         rT6xor9kpRmrz+Iex57uPglEkMbZHd4cJpvliKNGpcCbm5atnefUp9pP2S+jUcsBNO0R
         7Y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784630192; x=1785234992;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ckgKBhGXHZ9CaItTD4hbwZ0iER98qPnh6NKPNGH0tb0=;
        b=ZS72ffxUg6GGBNPet7GP2MEDst/WpDFIAlPmE7MkFy/q4XQ/ZHQLjMOpnX3xupOCar
         JTUAbrDP4EH67RgnnZOG7XfGcCK9Kinw4flfsJ2ODoBQQrKBYA/rzGJhmTfRVxTd8q0r
         jGDdcPsYy+kAyMt6UMan0X46hAlTBBM9FrrVHx7tOcj4UG8MY+WeUq3hyWxut0u9Y0Fo
         bor7t6dty2wJSR7MhVLS1hOzSQHda2u2+nTU1VYGMqz1SmYWY/6GjFtDM/7f16jGKmwK
         TdGWzGnYJVKB7lNV0rzdzVneFMAQG4zxer9mNeXvFGAqRg7aALxUeVeA1PuCWpSXr3tl
         NSUA==
X-Forwarded-Encrypted: i=1; AHgh+Rrn1wvJkmKs5Uggc6nI4rhORSe0Wi5WIMbuWw0dMF6oRr1atC1CbbqEOFnNlIjHXUHtCTb3iJRuFkdAgwi0M23jsPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw04zR2g8chFfF3VSmmqDF3/Xd7O2CiAUkDSSX89C+pXcMYADaG
	AQ2uCBdFZrkVqnQEo4Ht9/YF6hcI6osq+sHyyZI5wLt71b+RVfd32H+GFkbZrZz6uYNbj1MFwJH
	7275JTuKQNeEZ108AGIvt2w==
X-Received: from lfvf7.prod.google.com ([2002:a05:6512:3b07:b0:5b2:913c:f995])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6512:63ce:10b0:5ae:d7dd:5815 with SMTP id 2adb3069b0e04-5b28f9ac979mr2254062e87.41.1784630191977;
 Tue, 21 Jul 2026 03:36:31 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:35:55 +0100
In-Reply-To: <20260721103603.342266-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721103603.342266-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721103603.342266-11-vdonnefort@google.com>
Subject: [PATCH v3 10/18] ring-buffer: Use panic-friendly locking in
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

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f970d461b2ba..517bdb061083 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5601,6 +5601,9 @@ static void rb_iter_reset(struct ring_buffer_iter *iter)
 	}
 }
 
+static inline bool rb_reader_lock(struct ring_buffer_per_cpu *cpu_buffer);
+static inline void rb_reader_unlock(struct ring_buffer_per_cpu *cpu_buffer, bool locked);
+
 /**
  * ring_buffer_iter_reset - reset an iterator
  * @iter: The iterator to reset
@@ -5612,15 +5615,18 @@ void ring_buffer_iter_reset(struct ring_buffer_iter *iter)
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
 
@@ -6297,11 +6303,14 @@ ring_buffer_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
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
@@ -6439,12 +6448,15 @@ void ring_buffer_iter_advance(struct ring_buffer_iter *iter)
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
2.55.0.229.g6434b31f56-goog

