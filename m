Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A873D388899
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Jun 2026 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677588; cv=none; b=E4VUABLPrShtH6wBAkY1nYbPUhQLC3LQY2/oRT5p7hul6xMOjGiH/VwKwY2D/tSHmK6M0709ltGlHjM56654SiOHxOxvbzr/MXwKpv8ouwmPuE8Fp3RLscCU8cIy+ltvcxSc9NplSr5NcVOZEz/HpGn2Zrsk5mQCSLGS9AXCcxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677588; c=relaxed/simple;
	bh=QQqGQWrOiTN6tJUYD8Ks/yvsJpBvG79paq9gA1JDZgE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mDpcnw2vuFz4fBvtZJljjqNuXZrAVzu3PUGdFlQliCChGyswi8BWgJeUW2lnjSWGDml8o7zs4kA3kBtce3FQmKXRP+o+K7heV9w0oZzzWBFSxm3sQz5rORcm/vSSGQl5LH5ndsS8PBYLwkvdq/ybOBzitX4pnaO5TSV4zdTjMko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HyBl3/o6; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HyBl3/o6"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso18353295e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Jun 2026 09:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780677585; x=1781282385; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wHx/s/sE0MdcCGYnHcF+egYEWuveKhXMbrdXrCcSr44=;
        b=HyBl3/o6NK/ke4viiG8sWBOzYVX/s3AikzcO6XdyfAHIjySK7DWPF0Gi/LfVdkXe0L
         i51rrNIxfaB+7j6yxfJ9D5e8louZ9DZ79zZBkDpO4tCtA0Nx7PHjsgonzpRwF3IiaTjE
         QP9zQLb44goQ15oovohQ7m3O9grB/IGcRw2f6NIT24ISAdEyoNXcN4ett4hqQ4KoiCyp
         jbtGLpGcNXVcbrjKNhrfOx/6ZVye2OK5YrUw0Pt91FDdVzOXCLfrup9iX3/GKBtj614j
         SU60E7c0zPr71/8y0GZxv2cinmFgI4kn0t6cftPucydgOy95XHMUry+kCMZUWvQK7OLN
         IMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780677585; x=1781282385;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wHx/s/sE0MdcCGYnHcF+egYEWuveKhXMbrdXrCcSr44=;
        b=D3JUolRSQjVBwqVduVTei/hdchcckCKe+wVSkjbDF4JtSjRs+aVrggV654lOcX6P2t
         jNJh6opefMAMfDJ5dXj7wSgmN7Furb9EAPSwuYYztyJUn3IkAXTmOpDq1vnhwZLHA136
         SGRSG2B5tJyXq3gBGAdIfOFwD6XOwvbyp3Pt07FtwQyN/luMp3dlBY6BMckGF2L99DfA
         iBkn3Vma6KLLkhEQ7R8kfHzuJ1LkK3o8RtDDdXv7ZNTTEu70uuvFp47a87CP24/NEy5K
         ejwKdDIk6mrw1WVvA6TVZV5c6EkEUSK3F+Tys16wpTl2FB6Z3ZyEiGnISrDbKdK5i4qz
         PBhg==
X-Forwarded-Encrypted: i=1; AFNElJ/WI1g6nBCjkoVJOIHwJmtYQEzHi0nLRxMtHWCZAhhQDEOlQICOLfM8xnilE98vRk2dspqc7nWrI3dE7YXtD0q8LBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE2b2qnLoK/tiTlulCfMGipwPBJc+cmy6lZ1WpevXzCFDYhveI
	9bz1yZkKoL4clE1CpqtwWqZB9owXxLg11bRicIuCV07W3Na2aIwU306Pdj8OIc0T+llewObNmQd
	IOeyBlpF5+LCK2gOceBUUIw==
X-Received: from wmsk10.prod.google.com ([2002:a05:600d:848a:b0:490:acbb:67d7])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c493:b0:490:bb3e:30c2 with SMTP id 5b1f17b1804b1-490c25f1682mr80296455e9.18.1780677584848;
 Fri, 05 Jun 2026 09:39:44 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:38:16 +0100
In-Reply-To: <20260605163825.1762953-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605163825.1762953-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605163825.1762953-10-vdonnefort@google.com>
Subject: [PATCH v2 09/18] ring-buffer: Use irqsave for the reader lock in ring_buffer_poll_remote
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Calling rb_wakeups with the reader lock but interrupts enabled can lead
to a deadlock: the irq_work might run on the same CPU, but will
block when acquiring that very same reader spinlock.

First, rb_wakeups doesn't even need to be called under the reader lock.
Move the function outside of the reader lock scope.

Second, the reader lock must be called with IRQs disabled anyway. Use
the irqsave variant of the spinlock.

Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7b07d2004cc6..183326633037 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6628,13 +6628,17 @@ int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
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
@@ -6649,7 +6653,7 @@ int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
 	for_each_buffer_cpu(buffer, cpu) {
 		cpu_buffer = buffer->buffers[cpu];
 
-		guard(raw_spinlock)(&cpu_buffer->reader_lock);
+		guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
 		rb_read_remote_meta_page(cpu_buffer);
 	}
 
-- 
2.54.0.1032.g2f8565e1d1-goog

