Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AB449E5D0
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261922; cv=none; b=Cd88jjisUQradHMb/0bNrfN75JDGNPoAee7JHTQbXYHT/U0S4TUIst0fxsYSrAKen6Rr8bFQmg1oCZSFxsH3qc4mbNsa2Zh5SuAvO4NhMuA1NrwiWQzsTuBM0Z6nfEviKw/ACJXOMUe76Kxhw0zfLvJSJt4Q3Fb46X84Na75Wv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261922; c=relaxed/simple;
	bh=95PAoWhYs9fl55L20UPN13Q1UjKONr8ycP+35DM6Vz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LRmw92xPY+if7bb5h/5WUDiEBmP8+MPzSYxshnU9UN4xieyhUipjPFLnTAEu8oxQZ5PT52+lI8CTn3/qVxdOPvgoWc19FD5qpjoti3Fhkqcq9VBI4oJoxu7wP6861d6tAoa2tZ2dF6DHOzltTnyAQUKRttTd+nLRKNp1SGlLdEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ERjxKx7I; arc=none smtp.client-ip=209.85.208.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ERjxKx7I"
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6a91d818528so2600329a12.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 07:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790261917; x=1790866717; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BHfIQa3c5HGjai+QOtcEMEXeF4Yu9XjOtKwEKN+u8bI=;
        b=ERjxKx7IUXMRJFnazRMRTAmhmYasLvErje4O86LiVQhragrUKT2rRDuomHhl8rvs8H
         1JO4ynLejBJaUfqLd3SEscoNw+UyH3iVKxXLQrj+DUkKIUHRvnTw8/cOUEa0IODUufYq
         9gOSaL1Lb3bFPGp3xsHfM/Bql0KjM2Oa9+6LdFtPi68nGhlTfGIQyJlKWzrCSRXcVP1Q
         DR+uRa4uOLKdX2L1QW+kUJ5fRMJf/bMP/OqxPjqNyJio+BllRQa5A2RqUtLl3enBt7Cd
         So3EVcbPqunoi08Jhft5mHqynlSGzD5K1niLjizi00hKbmf2QHeVon+OeHNfv+7liUcv
         c+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261917; x=1790866717;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BHfIQa3c5HGjai+QOtcEMEXeF4Yu9XjOtKwEKN+u8bI=;
        b=aMfwq0i8kDFTCde0CMhLBCUfj1iz6vq4Ub/TTVKQAtrYfsN4IHeH6Wh9Mbf1RYYUPj
         Js55D2Huq4EYrflKWJege1Ofxp2Tir80dfF72Iw3WaKND7sx9F9W1pDx4RGJeK16aEHo
         LRUoNl2HmnO1Mg+/8NtQAHI8okhPbtX0JSuOQIfxzEixt0DWntNx/peJ+gufs52U2SUu
         AON6BBp5ixYwyHQDx+NhHo//iKnImr2SH6rtaJUX3TfOkmnguaKaiQkZQMonfTzrCz4n
         /hknIae6ypfSiDzjCK4tt0t58jm3B2Bg4ZJjxBxUWRZbQzoTzWOH1SMfql8KiicNk1KT
         cavQ==
X-Forwarded-Encrypted: i=1; AKwUvBxjm23UEOmrevzSXuumrQ1aEBy21MTzEPiYxRd48zvGAcXX5OIcDUQx9v7X9ebscKNaoprGXk0BKpe6X81kLGgHjhw=@vger.kernel.org
X-Gm-Message-State: AFuF++lUw8wGB78yfdTV/4k/a5iCxa/m+NLl7pufLGwr5Yo+sKQmRKTR
	KxheDsic1K9lnukYFM5sv5Tk0nVTSeSTK2MytsWQCTRDKeGLMJRzucs7wixavxS0td5bxsP3/+f
	2BJAL9T37fw2fTnjWhKpb9A==
X-Received: from edcpl8.prod.google.com ([2002:a05:6402:c148:b0:6a8:1d4c:399])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4390:b0:6a5:fbc6:cad1 with SMTP id 4fb4d7f45d1cf-6aac8f22fcemr2498337a12.7.1790261916925;
 Thu, 24 Sep 2026 07:58:36 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:57:46 +0100
In-Reply-To: <20260924145754.1285146-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924145754.1285146-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924145754.1285146-13-vdonnefort@google.com>
Subject: [PATCH v7 12/20] ring-buffer: Use panic-friendly locking in
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
index 507ab1fab0fd..f9533a97e2f4 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5687,6 +5687,9 @@ static void rb_iter_reset(struct ring_buffer_iter *iter)
 	}
 }
 
+static inline bool rb_reader_lock(struct ring_buffer_per_cpu *cpu_buffer);
+static inline void rb_reader_unlock(struct ring_buffer_per_cpu *cpu_buffer, bool locked);
+
 /**
  * ring_buffer_iter_reset - reset an iterator
  * @iter: The iterator to reset
@@ -5698,15 +5701,18 @@ void ring_buffer_iter_reset(struct ring_buffer_iter *iter)
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
 
@@ -6386,11 +6392,14 @@ ring_buffer_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
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
@@ -6536,12 +6545,15 @@ void ring_buffer_iter_advance(struct ring_buffer_iter *iter)
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
2.56.0.rc1.310.g51773c2048-goog

