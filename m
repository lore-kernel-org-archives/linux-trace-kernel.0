Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534172;
	b=rhEYlXhmx8nkwRqmsoWefvZXEr/WYk+97lMsv+MrsXJzjx0Ijoqw6aOodIi+ygcFDES4
	 HEyITujTbDz2sZsIAlN/P4AothUWd5pOGLqEk+ZHm4RFOAgJu5wgNE6qU/OKnpqREzd2k
	 dW5oLUU6sGmX9V68k40J0j0WLKoSd5pLBeazgXQg8LqVXMVBJoibrbvgYsXUavb2lD0XW
	 y6EHBlVypPQaxvaI9zgGBs2R0RzCck78lgKs8BTc2IgHk751E2oKRSbji1tLUSYCfbXOa
	 UlxA16O0VKcabVM/yHCqmyCfoa7fedFIqyPcGju/w+Yc9xXJC2Szo4LaCoYA1ftgKFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534172;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=pIZqHCS9uMGA/JN3ND+wWAQA7pc+psBTl5VMPUonuyw=;
	b=McfJtxnThWhJIRh/+TevHIOyrLH249pfFnnlI5AyO4Zb53S6JIbbXVJAUTomRsgMxMWI
	 veJ+Rimro0OBh1HQD4odIMKWG9fgWh18HxQeaDzv9i0qF/qi9gx0srx+7FF9mYzCevp9o
	 xLU/uDfzj2Js3n1jqeSK9caJWCqYZ1ggIiIlDWVnknsVkszzLO/uijTCtOQ8cDaqEwO3b
	 Q6oJavDnTFeVC+rxCsDvVd4ETX+Lt9+lMQ/oSS9xexi46x9ZgsrXufQeI4OpiVoH9v37P
	 LxixR42nscrzWCYUDkwCoXJTu4IJQxaDO0DcLb4RHQZaIbg0vypE8vF7ucd8oDmFIMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cTQKgVGh;
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0422606A6A7
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 15:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0422606A6A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cTQKgVGh
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4bb66fc3aa6so41281895e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 07:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795534170; x=1796138970; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pIZqHCS9uMGA/JN3ND+wWAQA7pc+psBTl5VMPUonuyw=;
        b=cTQKgVGhtoXxnPlZ/YExWGY0uWxQfuIvF9e/WL9/yFg8ZNF8rhxZf6dLD/oJs3e+fU
         g7QTQbdht5LGFTT+MoMom498LzipJ2ZipT8Sb/ZltPcMORc7r2Ql5izvmiSnoy7UGiE6
         mcY89wBKlsquROfRW6wTHaAxmgekN0gHZcrvqNHr05otd2LnIDPZxK5b822d+k+Au0pR
         vSzhn9fGIGpvYVdDNQKXMmFUdFWfvKE0h/IkBDboKugpsQLnYrPLIYaqKVaz7wzJMv1l
         ImkKik59G74c+ubuNXNcognhAdutupbuyL2OFBDXlTXShj7NxVuNfOAdzX/upwwGYvyW
         YyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534170; x=1796138970;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pIZqHCS9uMGA/JN3ND+wWAQA7pc+psBTl5VMPUonuyw=;
        b=1A06BpbdX0tcXnKGqbUv7YdHE83VZzfDb+ivQKbKC9M6MqoDBFyz3G9GTgHysucf3j
         VEqZqNpQ6H21bc5NKn4iBgG0o5gPGNLE7lT0qlnhQE0JFWdujy5/wNIWqProLP5BX0ZU
         4YFzCKH/aAlVvkI/LVqonyTP08IgP1jL4mlzTlBpZhhbTUpuXdf+GLIReyRi0w42j21L
         44wr0kN2p05A3eaAlZsVzfTQZMYzPCH1jZ/t+xCYIBmJ/QMjzCi/9GknsIC+hsybHuMt
         KMgM7F7Skj83ezNt75Kgu1ym6pr+a4kF27bWmvYTgFeOfhqlYQ6aZ7HiDY8CeZ6hPNHg
         FZsg==
X-Forwarded-Encrypted: i=1; AL+hErH+NstSbk23NZgmnAdCHI2JZWzF/jpu+T/O4AXiWnPnxkQK4pKMOPyEUp9MLyz85j7E5jvXeBnQf0iL4XdZSjzPFJE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9z3oQOhKcOBGVctqHIty62mB9cQRHyikz96Xs7+3n9oyt8efxh
	0vBVx0JhfolT7o/NP8IOP0ZifIlEBFkQ2hpSiV7H94/0wpjWwiTKeRfNUyCT1ap9t+CLn+Cg46v
	4zMORHr3SlDEE1W6601wL5A==
X-Received: from wmlc16.prod.google.com ([2002:a7b:c850:0:b0:4b6:b851:c655])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8287:b0:4a1:6992:f861 with SMTP id 5b1f17b1804b1-4bb887e064dmr315561905e9.1.1795534169555;
 Tue, 24 Nov 2026 07:29:29 -0800 (PST)
Date: Tue, 24 Nov 2026 15:28:36 +0000
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
Message-ID: <20261124152845.2233401-13-vdonnefort@google.com>
Subject: [PATCH v9 12/21] ring-buffer: Avoid reader_lock deadlock during panic
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Although reader_lock is taken with IRQs disabled, panic shutdown can
stop CPUs with NMIs (most likely if the first attempt with maskable
interrupts failed). Those NMIs may stop a CPU while it holds the
reader_lock. Use trylock when panic_on_this_cpu() just like in_nmi().

Fixes: 289a5a25c5d0 ("ring-buffer: Give NMIs a chance to lock the reader_lock")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-trace-kernel/20260924151509.23AEE1F000FF@smtp.kernel.org/
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 928fdd4718ea..42507e97291f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -22,6 +22,7 @@
 #include <linux/kthread.h>	/* for self test */
 #include <linux/module.h>
 #include <linux/percpu.h>
+#include <linux/panic.h>
 #include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
@@ -6323,7 +6324,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_iter_peek);
 
 static inline bool rb_reader_lock(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	if (likely(!in_nmi())) {
+	if (likely(!in_nmi() && !panic_on_this_cpu())) {
 		raw_spin_lock(&cpu_buffer->reader_lock);
 		return true;
 	}
-- 
2.56.1.809.ga0b61035b5-goog

