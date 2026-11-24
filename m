Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534170;
	b=UfUs3ANAaa8W3S4Y4bDVI9JCbwTTpZtapVxtoR52BLY0CwFlVtKQpLHf28K8IgX0LDgW
	 aUQw/il8UvzntEsFop3IRp7gknKOIp0oAXyAGz3vdYUh253sIXKUksw7VlNOURwTmkkJO
	 ui1+zMdB3w+BvE6+BOyrEDt3ovMjlZCLqKRzFKKHnDMXGVHeGWZ4YsPgXl8/sjU4RIEo/
	 IekCcfeqdY3D71wwpGrtxH72mvaPcptctWLWzbVHJs/9toS8q/oPLoovlb5FzHtIkneb7
	 EJrg0skLiG8d8jfcX59SLnUop+qSfdWpv98x5mxzIJKa7pVHahiwlOEhP7259+T7Hmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=CtGiWyJqdsDfW25/kKrYUtQQXV4c5pNEpPrlJDPGzlc=;
	b=z5Nv1bISynlOtVEGWgui3p8S8a43PofzgER1Lf2CMiucVpujb12FG4lfuWoPNZCZ+FnW
	 ilWqMcnKyI0QKbzegI5umqrMgXoUTZ2ZT8kCeDciHyltwkFE0csLwYo3JW5CiBKj/ileC
	 wj4cHy6Dy79I4dWT4xUpDHTwIagmJE4xBxXEPAnFFrPoL+/tE8vYx0G/pRDqs0Mc9rLyZ
	 6U+IAuCDWXi5HJAZCGeTvEIjtkmAXdfGiEtIEjYTug3/ABLvFso36kD+Soaf8lIgQRDZI
	 BisprAkNhgeKPGsI/2xynnr5ZTpkUQai0Gcp+XATy2U2WsNBL981ELxV7E8LtNqUrVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VdfCctRO;
	arc=none smtp.remote-ip=209.85.221.69
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E2360A260E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 15:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24E2360A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VdfCctRO
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e4d1e29f3so3922097f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 07:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795534169; x=1796138969; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CtGiWyJqdsDfW25/kKrYUtQQXV4c5pNEpPrlJDPGzlc=;
        b=VdfCctROFBof7wQDQIkz9UFLUBHf50vhZUezaBVpyjwertM6RA7INHAfO/+PY3xUJ3
         V7YBAZ5+22ibaSJXmf6laqRLI2XlSvBgT71h6LTCdPAcwNyn4T7aMgNFZN5WZjpheeiF
         Y3Ww79UL8XhKKHJKS5OaT3zQKeX5QlSkOpwF7HElatoz2LBciHw8yjXTqXDsoDAxytYj
         X5xjvF2nBE5ScsKTvKmi3X/HDpd8lX/yuhHvy5CySYNERyOAJbRfHjcJQe5Z1jFGE1vm
         6J/k7pkcI2VPJBCDBfXTBLixKjCJKdR6B3UWIoWpF1NPGuXa/FWIwHMiL1MovtIuw5Us
         m76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534169; x=1796138969;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CtGiWyJqdsDfW25/kKrYUtQQXV4c5pNEpPrlJDPGzlc=;
        b=zIcp5/9PvfReC+tg0g9HMBWwrzcwtJy27Uf8G+ZXrDWshIKIVmGhmtMWaSuDcI7mJM
         xaede28NF6ONyq1aerK1UaM/UzG7o3GAzbUjHvWDWcaj4ulvqwI5pGGw2fzwObYmvjre
         0wQPztkvb+yg4HWt7GEEW251CPHaBBfADxitxTskAjEnACAHJvtHR8bzJVqZ48+Sy0XK
         l6N+GUIna3N8JDsWESgxkW3OlqYxoPGvvyL8ezUPgNmJHEEGYh5Z5XXLCWRTu5TvSIZn
         X/pdpayny2RbKgEXxv9CqqL7iVm8PuHY73wioC5r0+okh/KfnDZ7/1uai4hot2VAS4qb
         b98w==
X-Forwarded-Encrypted: i=1; AL+hErHZh1HTzdVhDrI1b4VA1ghnUbTv0uX3PobYWtj95TRSf0HU+6/pNxwUqvlzzbrLQg9XV/pvKrY3Eqolb0qVUa0Hlxs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/7aZthgl1ew+YAKaBfvhoumt6aolReAj5lQjJCkOVtOK0/6tBS
	yQFrserwrqbPxtG5lPv8pWzdzHL9NZgp8EYC2HTbEpcM/REutTnAPoBkyBBQ04gdSG0TXh3CqWR
	928n5Qu10vBNqKuhlGeJVhg==
X-Received: from wmjy5.prod.google.com ([2002:a7b:cd85:0:b0:4bb:6476:9406])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:8449:b0:4bb:8e95:8ce1 with SMTP id 5b1f17b1804b1-4bb8e958ce4mr202525055e9.23.1795534168529;
 Tue, 24 Nov 2026 07:29:28 -0800 (PST)
Date: Tue, 24 Nov 2026 15:28:35 +0000
In-Reply-To: <20261124152845.2233401-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124152845.2233401-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124152845.2233401-12-vdonnefort@google.com>
Subject: [PATCH v9 11/21] ring-buffer: Use irqsave for the reader lock in ring_buffer_poll_remote
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
 kernel/trace/ring_buffer.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 554013a189b9..928fdd4718ea 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6928,14 +6928,19 @@ int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
 	struct ring_buffer_per_cpu *cpu_buffer;
 
 	if (cpu != RING_BUFFER_ALL_CPUS) {
+		bool wakeup;
+
 		if (!cpumask_test_cpu(cpu, buffer->cpumask))
 			return -EINVAL;
 
 		cpu_buffer = buffer->buffers[cpu];
 
-		guard(raw_spinlock)(&cpu_buffer->reader_lock);
-		rb_read_remote_meta_page(cpu_buffer);
-		if (rb_num_of_entries(cpu_buffer))
+		scoped_guard(raw_spinlock_irqsave, &cpu_buffer->reader_lock) {
+			rb_read_remote_meta_page(cpu_buffer);
+			wakeup = rb_num_of_entries(cpu_buffer);
+		}
+
+		if (wakeup)
 			rb_wakeups(buffer, cpu_buffer);
 
 		return 0;
@@ -6950,7 +6955,7 @@ int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
 	for_each_buffer_cpu(buffer, cpu) {
 		cpu_buffer = buffer->buffers[cpu];
 
-		guard(raw_spinlock)(&cpu_buffer->reader_lock);
+		guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
 		rb_read_remote_meta_page(cpu_buffer);
 	}
 
-- 
2.56.1.809.ga0b61035b5-goog

