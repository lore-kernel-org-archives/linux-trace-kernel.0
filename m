Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988478;
	b=exk1dKWh8sW2JVKeiWomVmYCgVbOMSvOyMPwKO9mI9BakBvQKcjWyWdZF0MAAmqN2T6G
	 cuPWrCo6/UFC5FfGO+3C9rgNbFGWBPZVdL4sVBZ370g4W0TdDkYyKcWZnbxXUTU22nWjF
	 oH5hXq2oCTwEoOIRLqxqn+mHNCJetmjyJARPTdKE/LEU8Jdv7871ekGOaqhObMhq+LKYb
	 7YJBGEmVYcDpsIqELWJgc+8nKX9enPp9ehAjfwljcrPcn1ired0IwEZqsGLWdzy7dEAOS
	 dcmjoHDYpXqrSeQZDJLC5JyokFJn2LjsUlfMhqV88dr7KOrmYXiN7nOgtgpaMrDQQvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=a+vnCYGYc+PBRfLmTlrNfWBoZP13FMHC8hi1eX/JgHE=;
	b=ycIkljJiQ9e2d5Bax/+ZOXgOVRSNYR09wChTafavILE4cGfw8RJWUrn1bwiY/5zFHEQ9
	 jNl3AcgCq7aRIzAWm5rqlFSC4i+vUlTRa2bRxv8b3ar4unWH0ogPJq3/TLg7RuQkMbAFl
	 fR5/MsiZg3VHLJiEmR7e/MJJWtaUBX/RLqAdF7aUyD6BNwt4xXzg9xGmqoWq2dhlU/lYc
	 4LYnqKPDghkP8RfEJXSmkjMxs6946RZOCNIZMUK7DeD14tghxHxlGqzQ1UgYoWL6SXOxf
	 67hjJBb6lGbi7358/wIKHeSi6D9lveO3BftM8kug2rf+yuYgrUn1uJyehIz5Ox8yPzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LjXXdmbZ;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1C6606EEA7
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 18:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E1C6606EEA7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LjXXdmbZ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a16dc2323cso8633045e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 10:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793988476; x=1794593276; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a+vnCYGYc+PBRfLmTlrNfWBoZP13FMHC8hi1eX/JgHE=;
        b=LjXXdmbZJdcuup4MD0qT71ua+KuYrUkn51nSuCtoMSSQOOMmhkGgVq8p4dbh7QqzHR
         M/ET6+1ugphtyMrPnQDZAUx8k5EMDA7rjRDn0jtHsIigha62wTXD1KknWAvdFJJ8UJCF
         ZVqpFAJjA1s2IXNyJSsuhKVa/n/rvevJdyebS1dsvi9C+KGhIcG77tM7Ikza6Cq1O/wo
         pMdpKeEhsI/BVgfQGVuuNoNCDjjKesj68d8cN8obcTFIFHQN+qVbmMQCCvJv/NhHeEYr
         1zCO8KdlCX409oRzPSKamqXP4Su2kEDjakrWkkFM2diqEql3NOYBZARSa2DIKFKkB/0K
         2joQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988476; x=1794593276;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a+vnCYGYc+PBRfLmTlrNfWBoZP13FMHC8hi1eX/JgHE=;
        b=KgB5RG2htd+DA+igN5PlslkX82zF+xeTsWwlYn/b0/aLGTP+8EDZ8cXBMbmOLnvM5Z
         5bx5oqJQU+c++l6XaMTElm8agE3kfljqgqWpG8xhtWYE9caBTzVEVYqQxM0w3kqYCx7O
         xpst5IVziyJWPgQABzudekwBKROUhAaMO0u9V2gz1m1bWB9L8UrWQtS5f53YJBmmVs94
         rT1H5a14+I5oDO/jfVxOHaWqwFNpvM8GvRjyZ+a9TvE/cdswsmax0hrPcewBsuzaXIRi
         zUvyccw1lnBYH/+OUWcxjDlXiuuFfSgKk/9NEKKrL5re8beVGeMh8x5MQ5OBzAiua6EW
         mMaQ==
X-Forwarded-Encrypted: i=1; AKwUvBywe1EXdh9XmJadcU8lpe9bY1pf9cx/7O6dMXr1OS3aSnXNPSAgbHQew6B2hkhhjo8IHo7tM4DSSDyPDRBdpXx72+c=@vger.kernel.org
X-Gm-Message-State: APuU4Z8P/30UzxAkFAuRs8h56cgnGkKXaO5CiIEnQKQFZ/nhKHs130ig
	hdrRak1Jxy4lAj953T34pAW7U4TELWMOfhScv9J7ZSoFn+LuoyIwLxSnXNYHcBdBOnS4ya93pBE
	qSi4q965sos0lXjfhP9djyQ==
X-Received: from wmbh3.prod.google.com ([2002:a05:600c:a103:b0:4a1:d8be:ba51])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e05:b0:4a3:59c9:a750 with SMTP id 5b1f17b1804b1-4b6dea687fcmr48709625e9.9.1793988476456;
 Fri, 06 Nov 2026 10:07:56 -0800 (PST)
Date: Fri,  6 Nov 2026 18:06:48 +0000
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
Message-ID: <20261106180657.2460376-13-vdonnefort@google.com>
Subject: [PATCH v8 12/21] ring-buffer: Avoid reader_lock deadlock during panic
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
index 4dab77883bd5..0dc661a95d67 100644
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
@@ -6297,7 +6298,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_iter_peek);
 
 static inline bool rb_reader_lock(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	if (likely(!in_nmi())) {
+	if (likely(!in_nmi() && !panic_on_this_cpu())) {
 		raw_spin_lock(&cpu_buffer->reader_lock);
 		return true;
 	}
-- 
2.56.0.455.g6c5a503b38-goog

