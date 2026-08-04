Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1B746D0AB
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852246; cv=none; b=rEeyOIVqVtq+QiEYf0cE/JVYbYMOd/kXQBasiDFR7IuaRpYnl8z3rHIqqcFfoopu5YIUUapHMa60s56C8uCIIASriW7/thBiLAOG4JGnaJOCqv0zy9wymCwz5W1a8Pg2c+zMXNRAZgxphrWFGuzeokkXb6uBmyQEVPVLBO2BZtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852246; c=relaxed/simple;
	bh=PgyjPKv89cYDWxRVDBZ9T8EjQ7eNrYSfpNnidX9ObWg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=de4Rb21sdMTMDOUoMufX/YgMbrZ8KsVIIGlDh3yo+8hCGJVaA2IsgAP+7w6YCwkBzeAg6g15PXBPT4Wnogy2hHZwiqL3N40kpabSusEFvCp6WLT+NzPfISXcftiiaaViYIeCY4qnQkLWYIaJ7JPlm3L6O+fhH+3TCHqa+Gyl0ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ara7NA2L; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ara7NA2L"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49554715277so30341935e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Aug 2026 07:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785852242; x=1786457042; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tZ8hbfpKYL0TXNWWVnEYWRS4CSMgmdh3mY5rGkVM9ow=;
        b=ara7NA2LXXDBSTOsYbshfwE8H8O0Nd1ZqWvoODQa7XPtQuxDTtyUHAhyP164x1oGeu
         nlz8a87z0ZT3tUT3pcoEhnqpmkTJYefWJh0gsIyhmV1lGj0LOW7nEsD5mJcsrztC2ZIZ
         J0fQGifKgKzaNaCxGB0V3kkeMblW4XPWXsSKntFT1Wr4/25UqfgDt+Wh1DXIoGsVI5uN
         jB0baIk8UmhIf3l3jeNXEjtBN4KlVIilm26FNxaiE0PLCCgkgprjYBBHbgVbqesxIWOe
         SyEUzlCgcA1OnUEnoWvoTQJ/kwmtpBl0EyyYBlcQ6BN07nBMA+OpRNztmFlJisY0A53i
         EcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852242; x=1786457042;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tZ8hbfpKYL0TXNWWVnEYWRS4CSMgmdh3mY5rGkVM9ow=;
        b=ofNxA7jQsYmx4EwT+NfL7WJHw/Dvxfxwy8+o/Cx8syR+VA5TDhRPoFTeHhtcoOZh8k
         Vdf3111gOJDulY3psfdIj7EHk729UyaW8+gcxJJCSLg+ROj9aoKTg3MEYtFkhANJJjf6
         6fVBQ7FyvRSdGA0ofpT/lgp7YYEB+NYTJao3+tKhc+Fatdp4gFS8yf8v+8wUCN/DApzl
         FTTLuPHU+s73/pPRd7MGzX+UlEECTGfr6hJJdfgNmtFq92Yjc0AMp5OgT75hBVKXLWjy
         VofIdIZk/JKbDfdVXD0aUAzDuVtctPtiuykPUuh4upulMpPKJyJO/FMK7SvkxaF+P1WX
         4E1A==
X-Forwarded-Encrypted: i=1; AHgh+RqOBoiqBTbKd4E92ShYEpVG8BfMmxwVfYPl18bDrK80zZGQOhphC0cXVbBH3tJYRIcWWe34O3FJDN63/Tt2WSHW7qI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTncVct5GnwB8Nvc95gJ9DEfn+5g3ngXWh1Bh+aO3PBxupbvzJ
	a6JQWEWqYnzI8ydHiL3wWv1kW8F8cfHvjYyuDVsHu4yddwu8xdLTcjzSEITf6EBU3bEYm3oQuC5
	iESatDdK7BBo/D7Yjh4MZcA==
X-Received: from wmbez14.prod.google.com ([2002:a05:600c:83ce:b0:495:5b59:7a9c])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4689:b0:498:162a:dbda with SMTP id 5b1f17b1804b1-498162adbdfmr218128225e9.5.1785852241815;
 Tue, 04 Aug 2026 07:04:01 -0700 (PDT)
Date: Tue,  4 Aug 2026 15:03:24 +0100
In-Reply-To: <20260804140333.797210-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804140333.797210-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804140333.797210-10-vdonnefort@google.com>
Subject: [PATCH v4 09/18] ring-buffer: Use irqsave for the reader lock in ring_buffer_poll_remote
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
index 8e2485bb3aa8..9cb72694bfda 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6800,13 +6800,17 @@ int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
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
@@ -6821,7 +6825,7 @@ int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
 	for_each_buffer_cpu(buffer, cpu) {
 		cpu_buffer = buffer->buffers[cpu];
 
-		guard(raw_spinlock)(&cpu_buffer->reader_lock);
+		guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
 		rb_read_remote_meta_page(cpu_buffer);
 	}
 
-- 
2.55.0.571.g244d577d93-goog

