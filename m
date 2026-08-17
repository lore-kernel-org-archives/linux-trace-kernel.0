Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C225D439F77
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974937; cv=none; b=joc6DoMcPbhGWo0qNZ/CBOwD47/ZJQwphRaLPbusjVpa0guthadWqNYysE15Y2tme3Au3wb4SSRbCnm8GKgWcC7VLF3ztzjXjjlNqSf63J6mGWpgfSKn0USuiHmx/3+G8aQhLl1y1KjFusAWAfKNT5aByXiBKrrnC6n0yS4vkTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974937; c=relaxed/simple;
	bh=Ij0/Es9+4te/KwVQ1N+75RLZuTvdiz+4yaWz+y+TlOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OGZ6G7V1G8yy0c5etM13LjV3TO+1KowLdxvocgMn2nuHuQKI0s5U3x1O1LytyIWhRiAtCHt/aWmWaCZ0Hpjahv1Wl+8TFYeny12Ycr/+KpExnQ3AXspOO8io0GYBk9UznIBLuDzbToCtVgZCAuamDeGC1JxnfPlZdN+M8mTFajo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YnJ5zdVp; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YnJ5zdVp"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493fa6e28a7so43268455e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 06:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786974930; x=1787579730; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E/Jn04ZHbFQHu2H1IrcUkCeCDI6su83V34hXmcxPL4o=;
        b=YnJ5zdVpFSEo7qYFMxCyPC9rQeIa6ioIKtp+kSLw75GCTu8Uenzq1cKXO80GMkMqMf
         9QcASwQBeeD7Aykm21BEYqgqZcMCqjIif8UKoqUGaeUwxyGzmiuZOPPAQPYV6v4lOB8Y
         v0BWarx0aZxB5z/L3BmT5Gi9/EsE+I9S3adVBorh7B4ocIb8yLSGkfowDBjQWh832Rls
         891KB94uVpTKycETl7vmO40zdww0PxdcDeJUQlXfBXtB9PzjVdpIrlfo7EQXqLdGvm0X
         7lr630EKbk8Ltuuux6MjZtAP7zKrmA3M69nSP/3Kdn9gMlv0tXgMrqWqLdbZhWrI62hb
         InCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974930; x=1787579730;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E/Jn04ZHbFQHu2H1IrcUkCeCDI6su83V34hXmcxPL4o=;
        b=UwkpbmMxO51gUnpmHyOZnialVi1wStJ6E6iif+54RRmwoD64hdrVOs4HvoI8GHe6Qg
         +fEnxeHwpXc7fjuzDzY0ULoj3PJvzJPOKzEbOLhoNTW4Yx1IhGEDTl1UQpmi5gfz6G2Z
         NiQltrFYnQR7Fk3M8VCFa1J0s1TfXxX/X/MV/OLppBz9RDHe97qYddr/wqtJpWSW7Z9D
         vcO/rP9stdD5boK9Ednk15dG6Pe/XgRkdWMNJl7xVPLAAHyrzolun5M6OV4KixFyl4c+
         lIwJRUKTLYGNFqtxHKqAV37HUlskaumVSysimd5a0qj7wNt5Z9E4+Jv7cl/k2DrWXLpb
         ofiw==
X-Forwarded-Encrypted: i=1; AHgh+Rp9nEN5Ip79wWX8tvjjcV5zkKdvPBxAY6tJa9EilCz3DoFWsD4lJzHgvL1JrgxusUuHkIgMvbl0qo99bxIb9OQJcdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhy/VdQItqXkhHqrXIyoc7juKOw9LumOuRPR8CExT8AtuP3OwP
	T9hXDE2eysHWtqVzhikj9IeRYaQKWyG3VbJdfDJP+k6DmofWtHmQFqxGHbL+yVfWydGZFs0xVXH
	q6A01qHRCdLQBBDGgwzXGiw==
X-Received: from wmbds12.prod.google.com ([2002:a05:600c:628c:b0:493:bccc:32b3])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5687:b0:499:6a92:fff1 with SMTP id 5b1f17b1804b1-4998799dea3mr321430515e9.18.1786974929959;
 Mon, 17 Aug 2026 06:55:29 -0700 (PDT)
Date: Mon, 17 Aug 2026 14:55:08 +0100
In-Reply-To: <20260817135517.3919534-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260817135517.3919534-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260817135517.3919534-10-vdonnefort@google.com>
Subject: [PATCH v6 09/18] ring-buffer: Use irqsave for the reader lock in ring_buffer_poll_remote
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

