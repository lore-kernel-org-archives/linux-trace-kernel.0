Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC21346D2B3
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852248; cv=none; b=dJngSyvbLDTaZJAp0ZOJAf5TWSuDzALrU06NjAqCT55T5K7E/o0G+AvGoyt2eQny2S1oJKCqiP3mEjCub9ax5SxHLgE5EWzF7l605idnQZg+NZSEwfyz6mAXzPawCquxsP1aqSCGrfOiSUTGxaCPQG9ulNo9VBX96H8dKsWky+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852248; c=relaxed/simple;
	bh=L7fu6V16MReg4IgfVOSUU8QwXPvE9eZDlTM8NEs3W/o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gkaVpAgjvn49j5sV/uTaXNE9zS3eSSbRVHDh9aTH93fxFdtCrcx4MjoFOqMleJJSSybylGyHeExxVc2aMQWZRIiqYNc9wM9wOZewJtsY6mBzB0e9SmkFz03PhCBwBpnZe5vEWs/Od5fzbWFBkKl2yb8NH8wg4PJ0m44dgqPj48M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JEIL/iy/; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JEIL/iy/"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-492488f8583so31234835e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Aug 2026 07:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785852244; x=1786457044; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P0FSO5VZ58di0y2Zmt1Ir7DeOVhXt456H8ln84HA3/g=;
        b=JEIL/iy/sHQzi+yv/41S7BhAjFou5mZG19MC7A3ONCws6DuudDEgH2wrlwptIAucz1
         TXIs/wzLpHoqZaP9nTv9h6ub4PGZTkOQWKJ6OVPYY00ixO+syAlIpfNgaGa/QWfboiGV
         ybnzUjGS0IoMHGtZSoKqPOw/0pQz+5GpYCQPNsVfWC/SMIMpsNo/ZO65IMYwi0sIf6vE
         8KrUm8voPR4UFtLB6O3f6W1Dg77qLyUtyQzviVmWBgzj7X42w8vByMIwIUpuUAFGTSv3
         47eJGVRp/y9vDnXAgavnUqux/XZo+FCcsddl0+MKbG25Qv4puc8cPAYXuXSWujNhEnRA
         ozfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852244; x=1786457044;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P0FSO5VZ58di0y2Zmt1Ir7DeOVhXt456H8ln84HA3/g=;
        b=feUOKws2YcDa0fdp5QQTTkh0UjSNBjZ9aLCMnMChI9CMbWw3Mh5+QmEsuIN/gmgTba
         mMGGtjW3THtZtaoA2bT+RvaqYPb2hiXA0UEnXaAOltfzFi4DvMdoDQNPZX66wEtRAuz6
         778CH3SjTrNusPOT5usliFwgzNbSJvp6LIagavRmMdwukcYZgdv5MF0+ozBkodPbTZxV
         /jAuEBPbyfB0/UN28Pp3sS91jfjitY5nB4wTBX5SnAQH0uMcKjDIydutSlzA7KtEKoj7
         1BDHJubIiBkwGgN2jzxHFhdttt3gK0/2SMrp6dXh6LnZP7hy6UK0zwlJ6zgFVU55oK6q
         BBQQ==
X-Forwarded-Encrypted: i=1; AHgh+RqR5XNVqz3Mddw4EhhokSf5pji+c0FVAm+NeNdxelC6ap47H7u1a5Ng1OMZp6gHtiu4H5l0ojsxMwbyIgbOWWVAfxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZBwPAOn8Lv6g/d4ItOW/zsVPkhUBj9A4qCxr3+lT1mlcVWbJZ
	2lLb44dK0V13qIZVDiRT013QJbvJdqejiCEmjYKsBbn+kYCdPse9UBP22KD/xhTDLxTI3eaStRu
	mqzrc68Wvt7KYep30giAfNA==
X-Received: from wmbez14.prod.google.com ([2002:a05:600c:83ce:b0:495:5b59:7a9c])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c8c:b0:495:5045:39e6 with SMTP id 5b1f17b1804b1-4980c664d68mr278510155e9.17.1785852243315;
 Tue, 04 Aug 2026 07:04:03 -0700 (PDT)
Date: Tue,  4 Aug 2026 15:03:25 +0100
In-Reply-To: <20260804140333.797210-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804140333.797210-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804140333.797210-11-vdonnefort@google.com>
Subject: [PATCH v4 10/18] ring-buffer: Use panic-friendly locking in
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
index 9cb72694bfda..239041704e4d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5602,6 +5602,9 @@ static void rb_iter_reset(struct ring_buffer_iter *iter)
 	}
 }
 
+static inline bool rb_reader_lock(struct ring_buffer_per_cpu *cpu_buffer);
+static inline void rb_reader_unlock(struct ring_buffer_per_cpu *cpu_buffer, bool locked);
+
 /**
  * ring_buffer_iter_reset - reset an iterator
  * @iter: The iterator to reset
@@ -5613,15 +5616,18 @@ void ring_buffer_iter_reset(struct ring_buffer_iter *iter)
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
 
@@ -6299,11 +6305,14 @@ ring_buffer_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
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
@@ -6441,12 +6450,15 @@ void ring_buffer_iter_advance(struct ring_buffer_iter *iter)
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
2.55.0.571.g244d577d93-goog

