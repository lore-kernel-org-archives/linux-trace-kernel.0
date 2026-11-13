Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583656;
	b=bUm8evxo8AYr1AnsjOmgifRSwqmbcmPm/PEU9+TGG5Uhr5igBTw9RLkNE24BkFOIA/8t
	 LsFSp8gfU1Q9PN75Vxqyi9FFpXH1Hpb3AYXnEuMvfmRjK6M5rCu9jNkPozBOLWhX7gxEY
	 8K3FGL8XlNKiiy0daKcYgZYQRPDu/EIx6bCfeGPOVPPZN5E+xBocGRepeMsOws/0DPyTe
	 KPw1FQ7bVog2nYHiDyrrdgMo7PKFMwmDAqBRVyj715qIS5Ozbsel3tPVQ9Y+DFlb0RnqO
	 6UbDWsHefnC5gq/zpPYtD56GCvE2PEtwFAN8/oZi0h926/hTTK9GclxOyuNsYBc2Qkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583656;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=J8tODDDg+oRlJgSbcauN+OLw9+JoOimiRLTslZN/5/Q=;
	b=T/lb1Qx+nzVxz+R+1ivKC9Kjwby8xNABoFUh/ygkQZOxLJJX0nSiynaeimTgBCK5srZI
	 A46k21sShBKw7IEuM434Ft/BAf/Gg3XaQe5mZwKMfjwsLPQS8dahNtl+3zEWXBtJOzOlP
	 ao9WJpK0JgNR/m+JS7rKoo3onMF5miTTzZ1F1hNnx/+QASPXRtkYd2CYUYcycySkWez/L
	 2gSa/4C69kppX0e9Jel5H/H84SnUzoD2AETTKfCPmzzvdNByF/N+vaB0HSOPH9MALPp22
	 Bfg9eD0edUVTQlncBokpocdn1cJXdv7n74SoL3aQXhiruG0dAGd676WRetg0NNNNXUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MUY0ag+3;
	arc=none smtp.remote-ip=209.85.128.69
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F42606A881
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 15:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24F42606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MUY0ag+3
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a009f82bedso6256385e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 07:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794583653; x=1795188453; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J8tODDDg+oRlJgSbcauN+OLw9+JoOimiRLTslZN/5/Q=;
        b=MUY0ag+3drApR0/owjvS5DlYawrTQidRx/vwIEe7rC2cl1HxL+hCLtJztLHLG7rJNC
         JOjkvEZeLPmDU9S0ZOMaEbOfevdkejYozVx0eP8/nnQzYF15JoRW9kS6+gk5hOw0jp3j
         dxl9am6aZVGOy3NQX3Js3IArjsgDmmfwoKzAdfYfEsQ3+U6z176rAbl4MH0svxtv1scV
         fXLOJ98Aa/6niA+D2pOohutNyk3khgl6q3qjvO3FTDPONnqkTPfYEvHmbIX4K1KAPJ3b
         cPo8kju1ADYQM6dxyTJt6AdGzi5VZfY114cku3Yh+GG0iquWtKnxs2RYECNvn0zvV5WL
         Erxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794583653; x=1795188453;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J8tODDDg+oRlJgSbcauN+OLw9+JoOimiRLTslZN/5/Q=;
        b=sC21IAu+Os2lB10hRvosallBdr/GKx8ktKiueq3QkqFtNTZzcMQDE6KxLaP7MFGJfE
         KeKertSGg+0Q0GuXIrUP9ZUEyzrqWIPScp0rE0SzgvxEKZQ/Ie5N4CU6Hw6Rdfqhx+Zq
         qAAIZueGgP0eRkm7ehGyQRpCKauyFEGZY7EkJYefK7BFVfJMeaM7J3nmcGnCbI7dMJMt
         wcbppOGyMxgxjoa+NsuNgJ5IQ+r2QICyRytTuK5cltTJ5FMtJrUEPO5y0QRTqvpoVCjA
         0l9QKB5DJ4PQY38e/eGc8FT9UMZHyE5x3g5FwWaQVdw4Ui0dZsEacwdkntdgJ1aburR/
         7Oxw==
X-Forwarded-Encrypted: i=1; AL+hErG6exFoIX+JFBw9MPE0IAPRiG8/8qFjlqQ9aczBskOgZFkJjcbR1EB3uL+qcUWJpz45MOFVCc7GzLpi6/lSMf+4pHE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/psSZ+Lc5hKSN51plQ9OCa1/kRgpA13c3bej2RepgAut1u1GR4
	8eAY2YretXKGyMG0tBulLZx0QBfnuz+GKMhleWmo1NxzJd5VXPo0doRwO3Dojm4yq9ep3Wf5KGk
	hsXzRs+JW6ee4bDiDc3FDTQ==
X-Received: from wrpe2.prod.google.com ([2002:adf:f342:0:b0:48d:f857:4141])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e13:b0:4ba:38a9:85e3 with SMTP id 5b1f17b1804b1-4bb55a47fabmr58539355e9.12.1794583653324;
 Fri, 13 Nov 2026 07:27:33 -0800 (PST)
Date: Fri, 13 Nov 2026 15:27:11 +0000
In-Reply-To: <20261113152729.837429-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113152729.837429-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261113152729.837429-3-vdonnefort@google.com>
Subject: [PATCH v1 2/4] ring-buffer: Check remote reader page commit before
 meta entries
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, bgrzesik@google.com, 
	Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

__rb_get_reader_page_from_remote() bails out when rb_num_of_entries() is
zero before verifying if there is more data committed on the current
reader_page (rb_page_size()), while simple_ring_buffer updates
page::commit before meta::entries. As a consequence, a race between the
writer and reader could lead to __rb_get_reader_page_from_remote()
returning NULL, while more data is available for reading on the ring
buffer.

  CPU0 (writer)                       CPU1 (reader)
  -------------                       -------------
  local_set(&page->commit, write);
                                      __rb_get_reader_page_from_remote()
                                        !rb_read_remote_meta_page()
                                          return NULL;
  simple_rb_meta_inc(meta->entries, 1);

This is an issue for rb_advance_reader() which always expects
rb_get_reader_page() to return a page.

Fix this issue by swapping the checks in
__rb_get_reader_page_from_remote(): first it verifies if there is more
to read in the current reader page, then it verifies if there's anything
at all in the ring buffer.

Also, if the reader observes the meta::entries update before
page::commit while the writer moves tail_page, it could swap reader_page
out and drop unread events. Order page::commit before meta::entries on
the writer and rb_read_remote_meta_page() before rb_page_size() on the
reader size.

Cc: stable@vger.kernel.org
Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
Fixes: 34e5b958bdad ("tracing: Introduce simple_ring_buffer")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c        | 19 +++++++++++++------
 kernel/trace/simple_ring_buffer.c |  6 ++++++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 3c7aa982d43e..f70010e2ede7 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5615,14 +5615,12 @@ unsigned long ring_buffer_overruns(struct trace_buffer *buffer)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_overruns);
 
-static bool rb_read_remote_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+static void rb_read_remote_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	local_set(&cpu_buffer->entries, READ_ONCE(cpu_buffer->meta_page->entries));
 	local_set(&cpu_buffer->overrun, READ_ONCE(cpu_buffer->meta_page->overrun));
 	local_set(&cpu_buffer->pages_touched, READ_ONCE(cpu_buffer->meta_page->pages_touched));
 	local_set(&cpu_buffer->pages_lost, READ_ONCE(cpu_buffer->meta_page->pages_lost));
-
-	return rb_num_of_entries(cpu_buffer);
 }
 
 static void rb_update_remote_head(struct ring_buffer_per_cpu *cpu_buffer)
@@ -5825,8 +5823,13 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct buffer_page *new_reader, *prev_reader, *prev_head, *new_head, *last;
 
-	if (!rb_read_remote_meta_page(cpu_buffer))
-		return NULL;
+	rb_read_remote_meta_page(cpu_buffer);
+
+	/*
+	 * Order meta::entries read before page::commit, most likely paired with
+	 * simple_ring_buffer_commit().
+	 */
+	smp_rmb();
 
 	/* More to read on the reader page */
 	if (cpu_buffer->reader_page->read < rb_page_size(cpu_buffer->reader_page)) {
@@ -5835,6 +5838,9 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
 		return cpu_buffer->reader_page;
 	}
 
+	if (!rb_num_of_entries(cpu_buffer))
+		return NULL;
+
 	prev_reader = cpu_buffer->subbuf_ids[cpu_buffer->meta_page->reader.id];
 
 	if (cpu_buffer->remote->swap_reader_page(cpu_buffer->cpu,
@@ -6909,7 +6915,8 @@ int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
 		cpu_buffer = buffer->buffers[cpu];
 
 		guard(raw_spinlock)(&cpu_buffer->reader_lock);
-		if (rb_read_remote_meta_page(cpu_buffer))
+		rb_read_remote_meta_page(cpu_buffer);
+		if (rb_num_of_entries(cpu_buffer))
 			rb_wakeups(buffer, cpu_buffer);
 
 		return 0;
diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring_buffer.c
index d5c84af01925..5f14ba152fba 100644
--- a/kernel/trace/simple_ring_buffer.c
+++ b/kernel/trace/simple_ring_buffer.c
@@ -309,6 +309,12 @@ void simple_ring_buffer_commit(struct simple_rb_per_cpu *cpu_buffer)
 {
 	local_set(&cpu_buffer->tail_page->page->commit,
 		  cpu_buffer->tail_page->write);
+
+	/*
+	 * Order page::commit before meta::entries. Paired with
+	 * __rb_get_reader_page_from_remote().
+	 */
+	smp_wmb();
 	simple_rb_meta_inc(cpu_buffer->meta->entries, 1);
 
 	/*
-- 
2.56.0.611.g1030f0b940-goog

