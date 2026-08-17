Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2453C3442
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974939; cv=none; b=IP3CgLO7cRLnVwMnamHXiw5cwEVlQd9UO2mHGmwB6d9zyC7mbyPIJLkgYWP5mcbGFPQnqIJ8t+OtMkSBC/590pgsxLPecxhbU+lyBUXVgxBsPMMvkKcwpRogP2PtE5Sfm5k0Cd3aPGD7tkyfmsFwRJqhbGG8Z0qvJoL2LpbwATo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974939; c=relaxed/simple;
	bh=0M9O34Bfn50KXPp1sBQdxY5eZUJ2wQes7/cvZipOkvI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UwxxL1oYrIusCe7SyGUb+QIu1MfOLATsE/O9Ms0jfT/haNoeNETT7rp6bMyJcWGXHjl6cQILcWRbQz58s7IzDlci3DSvBcyiJImiPqY8ikrtJWE8KHL7vPcOIA1N0hXU2LOX+K8QYtkjHhrrBJLVxKnII1rmfnooVt1O0sRlHEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=msRxQjN4; arc=none smtp.client-ip=209.85.208.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="msRxQjN4"
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6a178080182so3827573a12.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 06:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786974931; x=1787579731; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bg9/bmvqjVw8QcEaoOrv810Auclb8Q2b1RfjVRg8lfs=;
        b=msRxQjN4YqT91Ckc+Eaj7gyv46/5Oyr0sjxQlTp8vwq3+adNP/k/uIaUldBA9NjooE
         KkVgTfgFl6MBzHVI3k44o1OyWB7kSo9P9OACsChSWTEBHm+TftjiXtaJC3NCft8U8rIe
         qdbYrZm3347Xzp17IZpuZOsmHMyP8dPl/Wt3vQt9h4uNIwHTvDArHmQiMH3isve4Vo3y
         bnUYVlP6vg+5pv9jcA8pJm604OoGZXH9znoY9N2AFL2sTN0+5iaykgY6Idv7wEJGPVV9
         DC230RW2l3v+N+GsqowEK2YoLwMfmENgV5P3jANHMcn6IZJsk5grHu6PY4u7kkIfh8hY
         bSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974931; x=1787579731;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bg9/bmvqjVw8QcEaoOrv810Auclb8Q2b1RfjVRg8lfs=;
        b=JsV5yJc8jvxp7vSBSX6kqFETmdrabplwJF/Cie6jjGKioaUG6nWBLNQa8wiNe+uUE/
         uFdOOe7nxt1sgT5J/LuxNk9dYGJJKwkC4VLjhwpyGAJgx93BlAWk0XBoIa5Wg0Xn44ik
         ikhc0AJGvP3RLjr9TAu1NRhmuhzB6SDlJPz0CbAVQDOCxSE2RHO+dqvUMJjcEZD9wSKw
         RXY+iXJ1U03/XzEFeIHjIxo35IXQ2EFEJIHvJi3MfMQaSyxvn+yKAFCaaUdJUd36ZrOA
         4ribgxighBpcUcLCuqgWGHg55mGE9j64DwtpyX0vF7OOWFTSkRvnTEf7QBCWfV6puGUB
         PnYg==
X-Forwarded-Encrypted: i=1; AHgh+RrpjaL4xseLT1L5UPynDhhJX5vV4Mqw1Xo3EDaKIzZ/mQBopPXUATBiDjDdRhxCe1iDOqOK84Gr74h0Cba0SGjwWUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSiNxgWC/NbiRYebU6oy9Kh1wiyIJwjoqc+CzSkXWZ2vym8lJM
	P24KeA/QNPthztEDt+QtJOUuibN8zxN8Z2aJ28ScJNTtYpQGlR2Iyhen41K/tQI1MqRuetyQ9wl
	hG8TMTCJwslX0S+iWslvnjA==
X-Received: from edwt24.prod.google.com ([2002:a05:6402:3d8:b0:698:b7b9:6c65])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:24a4:b0:6a3:7483:150e with SMTP id 4fb4d7f45d1cf-6a38a912869mr11474385a12.1.1786974931267;
 Mon, 17 Aug 2026 06:55:31 -0700 (PDT)
Date: Mon, 17 Aug 2026 14:55:09 +0100
In-Reply-To: <20260817135517.3919534-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260817135517.3919534-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260817135517.3919534-11-vdonnefort@google.com>
Subject: [PATCH v6 10/18] ring-buffer: Use panic-friendly locking in
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

