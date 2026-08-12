Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E29476077
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551239; cv=none; b=XbWDkTHmbDXN7RIc+RvbNgYpYc/VInWRuNsbqwnCrPnjTfJQGQFNQTemfM5J2zCmn1oxwLX3MNm6+YtM8hKPdAWF/OfPxA6yay0VaZTy04XZX+sA6ITiO31vzmZRjZ9fmHfGPGfpYIuzzN7IQ1ptC7HzU5CXWeyATQx5qoKBROE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551239; c=relaxed/simple;
	bh=0M9O34Bfn50KXPp1sBQdxY5eZUJ2wQes7/cvZipOkvI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dH2fBbqsUuaE2F25YltyS0ZR0qPBqkKtLwSD7pis7w81rDAEcmfYX0xaC+rIRlzrMVv/76syieIOU/MhLyV4Lkhj95uHHriBkpdQ9HruTqfjvGc5EiZTr0SylnR8ESPimvJN/R57JDdzT8etC0MifUdLpC0hbdhRXb+hD3l3geM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fr2LSMhH; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fr2LSMhH"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493bfc3b84aso6502545e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 09:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786551236; x=1787156036; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bg9/bmvqjVw8QcEaoOrv810Auclb8Q2b1RfjVRg8lfs=;
        b=Fr2LSMhH1KD54PFDODKhYEOBZB2q2YN5KgQKpL4DBd7/P/7tReBLrJ4ev3/SfFu7C6
         9UNqVVhgDI4l8d0pCkkDfETnVUr6rJZGyEq5opqhiZaq7UCdzmkb7voco57ns2lobTuq
         DOaUD1PpzNCp0fqCTeFaLmdwZ8dEPwEtU7R35xKjhZFT1Xsscp8iJRcFRBNznbSQLWL3
         X+jiqYjdbLe99lAYPGPjkHUuId5+/O0AlTu17R26EumZgWqc5GkxDZfy0kcc7Dffs2/1
         FxuKqNRg/o4/Stn36O6ZOTPbfcZFMG0uzrB6pInztqdQH671LH8NotKUHucKTJLmlOIZ
         v+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551236; x=1787156036;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bg9/bmvqjVw8QcEaoOrv810Auclb8Q2b1RfjVRg8lfs=;
        b=AigVjsXmbDoU29O2LOgCTPZdZS9Gvq9WsQp3JEzotOOt5XMjqfVFwoxHLeeLcyXYNu
         8ryAX0zWA9CdQeGO/UFP94WqZK7YBCUHFFOy81SyzUveUhxawcZeMl+BkXFMD93fXzZG
         QcTbrWki8FjQTV1U9izFAaEsOvgu2s5KcU6xRvZGDi6Y7DS5L5f7vqN+PJrC3M7MKC1x
         BXplbgIUA3xZWB6RtabRYOXXCT/u57+NQGyrn06Kmye2ZzBcesYbD7bvBZWFIznGZ6dC
         q50OcvHXnIivBm3Tm78xWPHZMXoNtcgDV9qjmpwIiDZkAfAwMoPG7Lo17W+Nr20imlVo
         /iWw==
X-Forwarded-Encrypted: i=1; AHgh+RpLMipMKRayYh+KZifgG7a+exGk9HOlY5I5I1MFpcefHLCsh99ADrXeXSYICPZv5KFG7xhdGNQ922+PP9xId48cLw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxFgUlWbTxibUQpKQulLmHr16LgMFbvowd5IFVq8/caO7I7chk
	+klyrrxS3Cx+d/EEjOEeBL1c296qYGbWyd+8bDIeNE78kx2uyCgchhbH3quou0lCmhF+QgnJIoS
	EaqYloMW0vowXid6Lc0iJSA==
X-Received: from wmow7.prod.google.com ([2002:a05:600c:4747:b0:495:5b59:7a9c])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c4ac:b0:496:c18c:f9a3 with SMTP id 5b1f17b1804b1-4997c0f0472mr70483175e9.5.1786551235432;
 Wed, 12 Aug 2026 09:13:55 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:13:32 +0100
In-Reply-To: <20260812161340.2417322-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812161340.2417322-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812161340.2417322-11-vdonnefort@google.com>
Subject: [PATCH v5 10/18] ring-buffer: Use panic-friendly locking in
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
index a7d9936b4c83..a6f2293f409b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5605,6 +5605,9 @@ static void rb_iter_reset(struct ring_buffer_iter *iter)
 	}
 }
 
+static inline bool rb_reader_lock(struct ring_buffer_per_cpu *cpu_buffer);
+static inline void rb_reader_unlock(struct ring_buffer_per_cpu *cpu_buffer, bool locked);
+
 /**
  * ring_buffer_iter_reset - reset an iterator
  * @iter: The iterator to reset
@@ -5616,15 +5619,18 @@ void ring_buffer_iter_reset(struct ring_buffer_iter *iter)
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
 
@@ -6302,11 +6308,14 @@ ring_buffer_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
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
@@ -6444,12 +6453,15 @@ void ring_buffer_iter_advance(struct ring_buffer_iter *iter)
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
2.55.0.691.gc56d675ccc-goog

