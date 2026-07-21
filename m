Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A0F480DCB
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630194; cv=none; b=QVMNDvLRmrQYjs1DAaMquSw5RndyG0IIWvPgIBmFzt9XHMWYquIgWMqbXF3S76Jzw1z0+qoXdpVzM9x11zdr0Oh/NeM7b31nFwFrzDJyP/aV0x0cPNsibD1+kWavULBTTqYhQ4e0RyG4VhmUixLX7obHtCkFXTYSEzlMR0QDSPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630194; c=relaxed/simple;
	bh=Q16L+lQyMmoxLUQC5efW6ctiVhaWRGKqXVo7a8jHYVA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dPy3IwyMzi6I1amMlS+vD4aZ4GetZ2GQvOQgmDGQGLEMrabS5OEv7iRdrIV7pFkiWP/5SPv6lHTGNgFmWdZhWX7DSNICB511kQIwp3sjOgwMzcJZ4qNOFfz9c2nhl7uKg+NfIJYHwUSP7vIlgjal03JuanxJ3SIpjtwZacx8gaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O6Au4F+5; arc=none smtp.client-ip=209.85.218.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O6Au4F+5"
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c15e57a7f8cso1120525666b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 03:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784630191; x=1785234991; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H5x68meO3KzBmhTNpm0LaksfbP1dVcIMD3apSumOoFw=;
        b=O6Au4F+52EoJW9ezizGbzSjEdnZrxUgHmmjyU3qjBeaa7WEXUBleIc/M2IZ5c5d+Br
         L4uTVFSOg0tNR+BfTewH2vo9J2mKbJgWyam1zAzRm0RIpvTH8J3Cy8ZE2xgxCU2DefWH
         C3pAH/FtY6VOH8KnHE0X0oAVozGy7uF/z0WA+QWo87iaJaxTBW7zmoaMsZSXhHl12ZJv
         r7+KHE7jHnVceLJ17Ow6oXGYM2/z8lrVNy2l4xDcLBlqGtdw1WD/K3tm/NrhhLVGt7Ha
         +XJgFh/xKPz96/lAskqmY1xcZPfHyyb5xmQU552d6KX9djWlzR7OAqI6Rv7bvzbD83wE
         xQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784630191; x=1785234991;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H5x68meO3KzBmhTNpm0LaksfbP1dVcIMD3apSumOoFw=;
        b=BGBQ4U+xkSnOLJt9+CJXB4Iy5V0AIaTsUUfQddsYZQIJhtlkYuK8XdpjpfkZlYx6Ge
         KQ3Krt3b59sG2dpmomEhd7jdvG5ht1sGeDk7EK9pXwoRHu5bFWt3bedBSz019ou2bhYy
         raWM1rgdi5uFtmh+Pwbn+UgdglmXfjCGdCDp7uQ59l8h+7BGwbBYu+5DlYlMtCcPV3gs
         N8mvWnruNOuLtvKeFceCUnwscsNYiNIqQFs2LIHRxzhPU29NFAW0vmnHtAq530Grh3lx
         l1RyVIklH8q7Qx3J9YKZnRcKuXOUALZlWsqa4QYrOxlmknPV6ZTTabjaKyRxPTX/DSSa
         5XBQ==
X-Forwarded-Encrypted: i=1; AHgh+RqCT+s5cIdnI9WHfjyekOjwsTGIYEPpHBFeSd34HPsTLI+m9zoHKlwQNcSjmdHCExIzWBpX5RsFsUw9UMplqb/rDW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy104YucAGd2ztfXMt7h0AplNdlSgJKH31SL2Wc9wLsyREMFB7q
	ylQayM+EKOhnnBHLnlObx3xv0bwIUrV+Xt+FsWkFhJFvqgMKppx0962WAwG5AEkfFQ6+NvERp4n
	bCkKucqYQjMvoUdmd5FmNAQ==
X-Received: from ejsq19.prod.google.com ([2002:a17:906:6ad3:b0:c16:44c1:59c2])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:f5a1:b0:c16:1227:e3d8 with SMTP id a640c23a62f3a-c16b46c4b33mr895340766b.13.1784630190592;
 Tue, 21 Jul 2026 03:36:30 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:35:54 +0100
In-Reply-To: <20260721103603.342266-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721103603.342266-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721103603.342266-10-vdonnefort@google.com>
Subject: [PATCH v3 09/18] ring-buffer: Use irqsave for the reader lock in ring_buffer_poll_remote
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	Sashiko <sashiko-bot@kernel.org>
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
index 804ccae694d2..f970d461b2ba 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6798,13 +6798,17 @@ int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
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
@@ -6819,7 +6823,7 @@ int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
 	for_each_buffer_cpu(buffer, cpu) {
 		cpu_buffer = buffer->buffers[cpu];
 
-		guard(raw_spinlock)(&cpu_buffer->reader_lock);
+		guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
 		rb_read_remote_meta_page(cpu_buffer);
 	}
 
-- 
2.55.0.229.g6434b31f56-goog

