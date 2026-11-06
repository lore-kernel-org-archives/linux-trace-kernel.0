Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988477;
	b=r6aqC/lotaFx3ZzeP03MPewmtKB1CSpTUFVdmJqOLy+BAQyHjs5jMWeA1TCX9tECxr4V
	 g4tsZkOR76TxqMTNYgMujNjFLNiLZCk+svLUiXOMpUF4PTz5s8GSBSjV/OPtbw6zsvjj1
	 vEBGc/Nein0FWlx8gJq9czd0i0O7kGcRHrZhzNhE5joBPRPQnDsdxs62KL6nYN8TEstkp
	 aQRpJKNLHtVvb+LlELMuaZiCdOMuuo/EwGt8q57F4RQrfchg6ABKZJb9ZniH/lZZuwJsA
	 gVusBGnrsC7al97DEYj+YjqgqaFopj69jfOYbgs9gMHbssaJ6mbmpjzWQqQ1gKOTU2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Mq52+ZwR7eTTvIHBXK4H6B5GMCr9hytQ2mtezFLcHK0=;
	b=diUi1rdYJC/BO3MSHHYWkPN03TGB2Dm/3EWwLBUP3vGJ3vnBy07qh247bhec9Tx19l+l
	 tg1zmthg2c/VhYcbNLHVsaGcSzSM6bc7GIQpmbIF0OUCRbNydvKFsh5hon5VqhpZuI+EV
	 QwvNfW87Sv93s9XxGM+rsk+BdUgpUpoomdw5KTNIpoRPn90CbqtKSw5rrX0vmJC1tTuwL
	 ElH1IScuRl3zk31uuq4hg/GXtgm3I0fzXTh+IIy1G3EBEO1TqXUwhNZ9aFqTSujm3EF+U
	 95zArw7pq9O0KYDF/UtVPsup1xHrGmwWVcpwYcQF8CJOeA2LmVzgiGUtuC4TjLpvQvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MPW0ndTN;
	arc=none smtp.remote-ip=209.85.221.70
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E3F606EE97
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 18:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59E3F606EE97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MPW0ndTN
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e0ef019a4so812959f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 10:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793988476; x=1794593276; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mq52+ZwR7eTTvIHBXK4H6B5GMCr9hytQ2mtezFLcHK0=;
        b=MPW0ndTNFtW7mh4pS9wjy6KqOYPtoSdJcYciPeUOUFUXdPtd2Nu6KTkiwJVmkqt4+a
         UJ7nRUEblhprRa5FwXeMzbg1QYkTNoDa6M2+AC3QBXQQBchL1a8LQ0LScrxE6/IiUJb6
         Jf3UVDKmWY7/7CBAonOFcJ2i1HUKT8Ff9qlEnCmQoxi5mHZU4adLaS4glIheO/YdGkEF
         CD5vytf5aqPYvyCIsP+kpWyVMipg8RWCk4XfXyHwUDuQD9OZCJUC+1jwuF91kVidqQLD
         OwPvxt76aWrPM6tLu0TnVe74J8uAxPLDfW8tVoW8Fu9C/VBwV+LQndFWSIj0/LUwNiCL
         NAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988476; x=1794593276;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mq52+ZwR7eTTvIHBXK4H6B5GMCr9hytQ2mtezFLcHK0=;
        b=0aL/ZGTFrKRzy1pvGmI8CyESrA6pxa4pyjJFIcLdZP/0eAZqM2ya6OtbpurPXD7WKe
         U/6khNdj3wOUeIgJ5hPHnTIzUglPOPfk573qk4/2XmDRx0/OMNqTBLlKV+l8TpRy2M25
         +XueQTlWBNFDzsZs5kZDsAym7qk2lE/UK3GIEvTGUTFQYV5UshSyW085V0fRz5rj5Lfa
         YxzO+0reA/UcroT/chuL4waZHFGyoYzj1Nj7RvKu8KtEDwVUtfdgtMo0XROCG8GQ9Dj9
         WcMjep+ejMxrGctPDuyTu1i8A0r0IfzhxQtGm6Wyydvi/1tksoftCoxrL7ETkUpLlssT
         Q1yw==
X-Forwarded-Encrypted: i=1; AL+hErHX7krFoTUJWcVA8y60T3PgLBm9nZUaOH2hlujHFUuMD9hzG9Vz3cSyN8Shho9Ke/4PJCWTuqNNQSgJVUuMkqkoblI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/dngRrFX7hP31cyIzPk20hnI/en+zYXmtxJHD19Qd7cqdODMGT
	kknoYrktJGkWgRik6/bbP0UQt0BtlE8t0Km1C/a6erAdXmBIMTN+RutkFA/bFOaN8p2AawgzN1k
	eJTqh6S02nhCdY3rM3dzg0Q==
X-Received: from wrwf7.prod.google.com ([2002:a5d:6647:0:b0:48e:d9d:8364])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:22c1:b0:48d:fbdd:4132 with SMTP id ffacd0b85a97d-492760dbbe7mr7141638f8f.18.1793988475275;
 Fri, 06 Nov 2026 10:07:55 -0800 (PST)
Date: Fri,  6 Nov 2026 18:06:47 +0000
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
Message-ID: <20261106180657.2460376-12-vdonnefort@google.com>
Subject: [PATCH v8 11/21] ring-buffer: Use irqsave for the reader lock in ring_buffer_poll_remote
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Calling rb_wakeups with the reader lock held but interrupts enabled can
lead to a deadlock: the irq_work might run on the same CPU, but will
block when acquiring that very same reader spinlock.

First, rb_wakeups does not even need to be called under the reader lock.
Move the function outside of the reader lock scope.

Second, the reader lock must be acquired with IRQs disabled anyway. Use
the irqsave variant of the spinlock.

Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260602171146.2238998-1-vdonnefort%40google.com # patch 8
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1fd28a72e6ee..4dab77883bd5 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6902,13 +6902,17 @@ int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
 	struct ring_buffer_per_cpu *cpu_buffer;
 
 	if (cpu != RING_BUFFER_ALL_CPUS) {
+		bool wakeup;
+
 		if (!cpumask_test_cpu(cpu, buffer->cpumask))
 			return -EINVAL;
 
 		cpu_buffer = buffer->buffers[cpu];
 
-		guard(raw_spinlock)(&cpu_buffer->reader_lock);
-		if (rb_read_remote_meta_page(cpu_buffer))
+		scoped_guard(raw_spinlock_irqsave, &cpu_buffer->reader_lock)
+			wakeup = rb_read_remote_meta_page(cpu_buffer);
+
+		if (wakeup)
 			rb_wakeups(buffer, cpu_buffer);
 
 		return 0;
@@ -6923,7 +6927,7 @@ int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
 	for_each_buffer_cpu(buffer, cpu) {
 		cpu_buffer = buffer->buffers[cpu];
 
-		guard(raw_spinlock)(&cpu_buffer->reader_lock);
+		guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
 		rb_read_remote_meta_page(cpu_buffer);
 	}
 
-- 
2.56.0.455.g6c5a503b38-goog

