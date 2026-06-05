Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC2F3A1D01
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Jun 2026 16:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677590; cv=none; b=XNpQVV7s/UvGy1dmAOF50ZVbLRGkbkZxd5qUSfl6tzHbN6MuaUihnqbCS3ClObyb+XNbSAZv4czA9vaOhKQZexD0iBs7yeVsc/ITbMLogEv4wKivDwhHi4EU3GHYoiijvusmK4p8YiLYCM6qbmMMY7+f8LxAv2yxU4T92wrkcoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677590; c=relaxed/simple;
	bh=ArSGT8tOq6w348G5Go1wBVmGLGQtyQsktFCCVTDRrVs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KYF0gUNGaKcmRXd4ambkG6ndjSn7zBC5QXvsFBqzWyHuGtAYDdKGYsCivn3ttPcrT7C8cspNJSLbQtaHcK7OhLac7zRYk7eYQZ5PnrFBVbEeFfFxpYIoGr8e5T4VPF5ihPzk10zS+EVDfFWI5Tk7auUDR605vwNvurkxl4xaNxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J45jI51O; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J45jI51O"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-460153ce644so1459388f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Jun 2026 09:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780677586; x=1781282386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9WWkF3u1yq5oxctLX3mC0x5uRggcBZEMmZ/xQSiWvuQ=;
        b=J45jI51ORCZ2a0QEDoFx6cDAZrUH/PAbCZDd/E2DgBYtaZ6RdX9xhbe6QOXeengmIX
         VSDS1/CbgODCu5pVgi4u89LCv9XV6hdObmAHVO9lXushSL2FU01jf0ryQjPQgBZb4W/6
         kXfFKarO1n44qkRt39EkBA58/R+wAs3HPWEQMtG5jS4bm2KmONU8lbRLR9ssEHoN3jOy
         1p/e4WzUIKFS07b9Sgge/MtIoJflHv5AaxoTFwy7EgGBCQrzl62Jg8DZbGDtoxwaRBO1
         1AyVKtpZvm16om+Ql9XMHpnV7mTLj3UDtISwQCe0tuGRazNEWbWcBac1B8c6NXRX7Bn9
         vtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780677586; x=1781282386;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9WWkF3u1yq5oxctLX3mC0x5uRggcBZEMmZ/xQSiWvuQ=;
        b=nMaKo7BazMXMkjeClepUWiRPNCSQPMSnh6S2BUFryUG4oGass/tr4JyqyRnACaztrg
         PWjylOB7kiJ9yLLljl0zDGucjAPlps1GDdlkH3nx2MfAJOnGbCUWcw7Krllkya5rVuOS
         I5uif+UEbSCq6V1ULsb1XAEePgvJU4RrXl46lMx/xx/TuTRABVKGja25xWjzICbXmXZF
         xgQj1YI/vTJ7clQ+R4LSKi81oC7VNQP4rtKAeJaoEXuQ/ZPw4905MC/m3m5H2Mpp2jKc
         CdfcdyIh+M9XBkxM6lryMt4NsRTtKcn7Ac+02NwfhORyVM8FOOngLxgiKZWBf8Bmp57/
         olnA==
X-Forwarded-Encrypted: i=1; AFNElJ9yp8Ifv+pmiYQFw02TEJO78Jbia/YmHhcOkBNaO3jTmEsNoOR3QvTesSe+gtqyZT5zvD/xEQIDunDyJEJpv838nNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc+n9mIC3q7XuPNa+amt811mld34M0PObYUJ11XXicF9fY5iiF
	wVPf9YO3mcxvwBJoyBWdPtokTSen0rnzYF9JU69vQxfUH7VjXukc1GLMb/nfLmMT9GnyqhQPgZF
	RFp4cn60cCVGw3BQ2q4s+hg==
X-Received: from wmxa14-n2.prod.google.com ([2002:a05:600d:644e:20b0:490:b1dd:1050])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3515:b0:490:b5d0:598e with SMTP id 5b1f17b1804b1-490c2604783mr73219795e9.21.1780677586207;
 Fri, 05 Jun 2026 09:39:46 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:38:17 +0100
In-Reply-To: <20260605163825.1762953-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605163825.1762953-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605163825.1762953-11-vdonnefort@google.com>
Subject: [PATCH v2 10/18] ring-buffer: Use panic-friendly locking in
 ring_buffer_iter interface
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for allowing trace_remote to dump the buffer on panic,
make the non-consuming iterator functions panic-friendly.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 183326633037..88ef44e2da53 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5444,6 +5444,9 @@ static void rb_iter_reset(struct ring_buffer_iter *iter)
 	}
 }
 
+static inline bool rb_reader_lock(struct ring_buffer_per_cpu *cpu_buffer);
+static inline void rb_reader_unlock(struct ring_buffer_per_cpu *cpu_buffer, bool locked);
+
 /**
  * ring_buffer_iter_reset - reset an iterator
  * @iter: The iterator to reset
@@ -5455,15 +5458,18 @@ void ring_buffer_iter_reset(struct ring_buffer_iter *iter)
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
 
@@ -6127,11 +6133,14 @@ ring_buffer_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
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
@@ -6269,12 +6278,15 @@ void ring_buffer_iter_advance(struct ring_buffer_iter *iter)
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
2.54.0.1032.g2f8565e1d1-goog

