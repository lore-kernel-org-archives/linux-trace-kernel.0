Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626A64749F3
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551238; cv=none; b=l7NoGnG+J41tvpjJ0iflYh4LSJ+GzpeAISi8V5c4ROKoIZfWjBOfBn0m3d2km8c/h4MGl8GCy2xL+iir3S5VmgaZ2xkg/2DvUOCGKu+r5gBZkauYMqkXoydMxcIzO74iWlX5iOLN7x/qne4nLD+EDj19epWq37FODfmKoWU+IDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551238; c=relaxed/simple;
	bh=Ij0/Es9+4te/KwVQ1N+75RLZuTvdiz+4yaWz+y+TlOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j3b7ip/0wq5cZ/S25AlUvOIr9MGv7NdE4ZGRf9PRyYzXRTlnifGADmlPICjFTeyArTgnsK2CvNGU7AWdDxBf7GuRoq0bkjQmDg7xSg4d5cSs8toRuJTHxjvlUBGIN74VGMw2huc0FCvC6IFMFizgJB7qRKxDZ04tFechxG+HyHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TfCIWrj7; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TfCIWrj7"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a767b782so9754205e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 09:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786551234; x=1787156034; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E/Jn04ZHbFQHu2H1IrcUkCeCDI6su83V34hXmcxPL4o=;
        b=TfCIWrj7dfD9hLmG4Iwftyo0kjE+WIAL+IfrAjli3d4HmB8AVk54JRdlypmBzsSO/z
         5QgEqJI7xZMmhwWKWtCGkaoxBhm6K2UffwEKeGfVgWLMiWAKp/kP14ZzEgkPpvX2jAWe
         h/3KHMpOPp+7OBhAStNTtymhC3lz0oFayFAdbYhsfoS2+LUk87I+a8M48fgEQEqqPqmx
         BHEGmYD7IJfkVz+FTYtDAwHkB1Keane9AlrLZrtbpGrRuJvFxmF2kbJui+12oulTLm5f
         yvJBjAz/lfZ7h8O+JuRHL9ZggMLOtd/BphkLgHhOkIaszwGFCUDxFk4Mo64rjTCi2akP
         BZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551234; x=1787156034;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E/Jn04ZHbFQHu2H1IrcUkCeCDI6su83V34hXmcxPL4o=;
        b=E4CotxZQ+j2qZZa7VivsfcLKrow300Wtyl080DlKhr3cJD/4v/GghJ3ujZMirLhos+
         QrzuKsU2R0rD8r6aOQgAP7oRZYC3JXUC25doVHgEmyUHLluLi10QBmnGPQ/H0SeFIuy7
         UmLBDW+pC7XKOT51bysyluUoK8+IimlIamIKN2KR9XoAGe80Slhf1CwraWcsG23Sbf3k
         4nGQC6LoOrO+3ClBC7KnBp8V5wkuaQO6dFJZIouJ3ypnN4hhaoNxmDoQyIYAQcEBRFCg
         /eqiAGNqSFhXWyZQgE7aAzXr9fkSUZg8GAwyYDeTZDz9p/cxk3OYvKQPr1Sth2XsDftC
         MzvA==
X-Forwarded-Encrypted: i=1; AHgh+RpLknWzOh5z4b9Fmp2nVa+KJLQ0qf3dyup3iVZJx398Yf5GjkT5rhkvzGRCHrjCJAXbEgR9sbGf+7ypEuz1PExENKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIpbjlQO3NXNjbyT1klhx0kvs5xPSm7NVSqvnPwB1QP9MyZgPe
	NsEW7T+TSePyTlOCetgagjho0mNJ0dcl3H5uW1QoB6NMznpSrrH6UgFGCx/mBDG4hVWLeGWPB4A
	Yxn+g7YI1xldfEvV54g3h8A==
X-Received: from wmma14.prod.google.com ([2002:a05:600c:224e:b0:495:5422:15f2])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:620b:b0:499:80d0:8b73 with SMTP id 5b1f17b1804b1-49980d08bbdmr36236905e9.4.1786551234328;
 Wed, 12 Aug 2026 09:13:54 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:13:31 +0100
In-Reply-To: <20260812161340.2417322-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812161340.2417322-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812161340.2417322-10-vdonnefort@google.com>
Subject: [PATCH v5 09/18] ring-buffer: Use irqsave for the reader lock in ring_buffer_poll_remote
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
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2667992f0aa2..a7d9936b4c83 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6803,13 +6803,17 @@ int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
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
@@ -6824,7 +6828,7 @@ int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
 	for_each_buffer_cpu(buffer, cpu) {
 		cpu_buffer = buffer->buffers[cpu];
 
-		guard(raw_spinlock)(&cpu_buffer->reader_lock);
+		guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
 		rb_read_remote_meta_page(cpu_buffer);
 	}
 
-- 
2.55.0.691.gc56d675ccc-goog

