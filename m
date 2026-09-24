Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C795E37FF46
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261921; cv=none; b=S+ZqxKfW9vU/JXi8WKgCWRO501pKtjEMm3vRZgVJSEi7WjxSxe9TWmaIiq6qYvYPwMD+okzKclRJHVWv7Njhps04F/lyNyQTIiByY5rN74Zh4i+kaoJTvOdp/P5BaKGO5Vw+4ub0DHIdebHy3rFImSIrTa0JSQV83liQ0enPdZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261921; c=relaxed/simple;
	bh=THyM3E7Fj3Vkv4BmRFd3L43wu4SNvkcXwFz4JsGaHaw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LvV9ZQRs02zWnbXXJp3St+iqBPUgy/ZnMyZZUUgAhPg3DXzyZU8BXSkb/UkD0QJbcwRVxJjIjDzoWGA2dE64yG7CBuP+F0s4nfV0U3rmlnBZ1cNCW1+GZ8Tx2eZo6MrfwNU2yALcjmCok0nHnXcoKiNkrVsrjw+2b5ZD7qLIw1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YMXG9QVT; arc=none smtp.client-ip=209.85.221.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YMXG9QVT"
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4843227cfcfso738955f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 07:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790261916; x=1790866716; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hzfHMglUF4C/2b0MksPPNroPt2DUwh1HTrH/0JRGEXU=;
        b=YMXG9QVT97zudihhCUdG22EOHgZGAqR5X1zVxLcja6X3DL529fICFC42LNgXX+TTIZ
         Rp5t7V5j/LPCO4ZAzftdct/O0HnghHb57OiZ2Ahan/bcn5uvUjlGASstJwDFKViB8kFj
         /yUxPFZmvAkI15L1FW4dPSmRwPcwIwxVq5ARrwFvXbgz8yc8YjdzJKQ5QyQrBvEvKBTu
         mL8ETm/mAjUSinsJ5WqMnpJ0F5CtkzFazQmFhqXfLmvLt44PV4d9F07zDwGNKgljQPNf
         7/c9w2Ke2uDOjWK5YfvNZjry+JTkUyzHF5eefTxiz1+0nzd8vixYGoKEV/vnmb6SP/8g
         9Eig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261916; x=1790866716;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hzfHMglUF4C/2b0MksPPNroPt2DUwh1HTrH/0JRGEXU=;
        b=QDlz8k+TaGI1beC3UMQOV9JPMe75oOFmhsafTsrybzFzdrHiwaLyRMSkVBHEGkGufQ
         VPckbXz85EmqIP4RF6QMDe+7bpbivt+8P05kMw1iJgWFVrEO/D1p+lKK/lQzbtu8j1iH
         kAOEEU67KDwK35XBvcd+XiNEMZkk5KZfdPrEJrms73Ovfsj8YroLD2cksJ2bic+NNGFq
         SIwW+y6DhH9V7pxhceaYN5nEUXHRPonb6gdahIENZhwhhdja8z6KJtY2jw90T+aCDtU7
         rUEvRlP4LskpV9DJVY03G+cMJ/7JVBENM8TmrrYcEPZDNEJ6uDE7TvP93G6MgwT9DI0Z
         c+kQ==
X-Forwarded-Encrypted: i=1; AKwUvByqxIdus2qjGoQlceQWQr/R1NwoZwOmfso8edbrDYreT8yWd/5rnHfiQrW3Mwg2JZ9kKggqK9ES5BAroC+oM5NGGx0=@vger.kernel.org
X-Gm-Message-State: AFuF++nrV0/j3hBd0CALrvuueIxU65e7lHu664VO5plgwk6KoKWRgs3Q
	y8Nya9r/DFuZoLtZ8pL06c4hmOeDhOwi5vZnne8sr98gALXobuqrF6JfWqf6zBBzxgn57gefaVx
	3GZOmIb7P6/6WsWJjve8+DA==
X-Received: from wraj27.prod.google.com ([2002:a5d:453b:0:b0:488:5480:74f9])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:468c:b0:488:76f5:c7d with SMTP id ffacd0b85a97d-48876f50d2bmr1281513f8f.6.1790261915989;
 Thu, 24 Sep 2026 07:58:35 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:57:45 +0100
In-Reply-To: <20260924145754.1285146-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924145754.1285146-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924145754.1285146-12-vdonnefort@google.com>
Subject: [PATCH v7 11/20] ring-buffer: Use irqsave for the reader lock in ring_buffer_poll_remote
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
---
 kernel/trace/ring_buffer.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 04bb94c29f58..507ab1fab0fd 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6895,13 +6895,17 @@ int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
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
@@ -6916,7 +6920,7 @@ int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
 	for_each_buffer_cpu(buffer, cpu) {
 		cpu_buffer = buffer->buffers[cpu];
 
-		guard(raw_spinlock)(&cpu_buffer->reader_lock);
+		guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
 		rb_read_remote_meta_page(cpu_buffer);
 	}
 
-- 
2.56.0.rc1.310.g51773c2048-goog

