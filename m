Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492893;
	b=W0Rt/OOaIOGygMS4fOMmnABthpQpWmRrqg8PkNzcE3zmRIYZCqeBW+X/a5mD2tqsxEIJ
	 RyJBWzCQl+KDDt7CCt2QsafWE+54kQ5uTUrVkiERq7ZD2PdzdQL4yQv3WNBlUkB7w/aH4
	 98NYkFB+cVdIXCwIafQMqBp45rvt4V22O/3kMl09i78yEW+u1ijvGfAvcMsyMkc/aS+MZ
	 ddIpxFPpQ8M5nIr0UMbUlL2k19YDQu/dRZDGWppY6IDcMGn91Msi3TPc6LRgLSUwOVCo1
	 ZSIgfK1npt3E4UGj3DsCCboXc3MafkpPiWSyc/ADYQjJXgvQRRLt2PLTpCaY6M+4REw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492893;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=2NgZMcm3YV115P090O2Igc1vnRf4lJME9jTWUl8BAcE=;
	b=sk0itfrJUPYhWbL5sF892AvVBiULurjACJbm58Bb0LJn5BLamldYYgfJcJhvxfUEiW6p
	 BpW8gCbG1F/AypizQuODnUKTbC+fvxxM5lGBb6gOLTsmKV8yWa9rXJaNazvMZnyL17Y4z
	 NdnDhIVodROTEboQTCrI5KU04Y8O80DX/cuPF9qk9sZKe1i4Ir4d1xR4IQx8BuZotYZA+
	 Gox7+m0lAW4Paf11f+aRGwiUjLoOVrLLcgAcv9gB0iforisG2Yge/q0nuVFMGyMVRiDNm
	 /L8PI16MwcB6o/UHK6E2Vr9OLKyylrx7OAsdlte1z/PYvycOfdE0zf8Qhit+pTRKSNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CFGycgj1;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A424606A33E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 14:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A424606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CFGycgj1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4ba078f26f4so18903785e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 06:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794492891; x=1795097691; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2NgZMcm3YV115P090O2Igc1vnRf4lJME9jTWUl8BAcE=;
        b=CFGycgj1IlceAOceUkm/uCnMak8xVjCBECi5ig8nzuIpJ7Kxg89dym7GLamo3sQQjE
         kXWv8IDd71nqlZLChW0eAlRYbJxki+9XPscO7c2v5fhO90L/zU86OcTWO/k4KOSNwvgC
         9YXmYS1OUsjA4x0Ikj7SOigocjL2kuZ2piXI2QFDqia7fo8/h/6XOjgQYCFmWfXxPXz/
         AlCFmCOg9lDkcpSdMZrh8tFvCZoNjBxyrpOcaBTXOQKDvNfOSyut9IcXcG2zDSauHeIY
         QH2IpPjt0+kzIeZNZV6tiUhq4MUZYq4XQ1B+jQcaOVYPHAEyflqIveT/3p7/5/VFmXx0
         PDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794492891; x=1795097691;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2NgZMcm3YV115P090O2Igc1vnRf4lJME9jTWUl8BAcE=;
        b=xCefJm3bCDkh6VecBcJjRMBtZkbSDssUMEGf0419g8mJVrAKLJjc3lgon+YX2a0sNN
         aQLIOgf3Jlc47usKJdOSO+VLEskCyzzxTuHUZ2FhjKz4rQx6FjOQLFNFfEkpHP4IHdg2
         qh+nUY7VQ1srW3v1I5FgI2h3um5n1PbpOc1HaEcR+w17qeZA7aHFpKm7BLdQpBelTpDI
         O1yGwnns5HR92Yd8eE7hJVGGaFJZ5zZMsUuJ+qo73zv0fgrFaCqMNpTKHaStbQ3K/Kj7
         f8KJCbtKt+uZXFOgFX6N14DYOt/BeqYaUxOhH5Czs6yA4WmdgqLzQv0NBz5RcU9eTfxm
         8FdA==
X-Forwarded-Encrypted: i=1; AL+hErHaDbOP+Vc+qd6E3LyGJ7vMMFItWNxqY3vxPzuepPPlvIlE7A+xw34UO4MSpA3jidx0DljqFbwuJZl8l0i6Q/4WAhU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9S2Jpgi7/FKQtf3bCJSIExXPcZYWMCDky96s/WXXxySeh+q8ZM
	ZT2JGCQZSbemmMe3dkE6N98SqxvyDg72zwVfT0oaFMWBrmc68waFI16OoWE4pTrKTJH/WbjwIoZ
	9FYmGblzbrQvRigmryPYrfg==
X-Received: from wmmr7.prod.google.com ([2002:a05:600c:4247:b0:4a2:e03:1f55])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e92:b0:4bb:53d5:8263 with SMTP id 5b1f17b1804b1-4bb53d582b3mr17227095e9.8.1794492891300;
 Thu, 12 Nov 2026 06:14:51 -0800 (PST)
Date: Thu, 12 Nov 2026 14:14:33 +0000
In-Reply-To: <20261112141440.3050124-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261112141440.3050124-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112141440.3050124-3-vdonnefort@google.com>
Subject: [PATCH v1 2/9] ring-buffer: Drop cpus_read_lock() from ring_buffer_poll_remote()
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

ring_buffer_poll_remote() holds cpus_read_lock() while walking
buffer->cpumask. Ring buffers are never freed on CPU hotunplug, and
trace_rb_cpu_prepare() already orders buffer->buffers with the cpumask
update (with rb_cpu_sync()). Drop cpus_read_lock() as it is
unnecessary.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index bd8126f6353b..32d3c47dbdf0 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6918,8 +6918,6 @@ int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
 		return 0;
 	}
 
-	guard(cpus_read_lock)();
-
 	/*
 	 * Make sure all the ring buffers are up to date before we start reading
 	 * them.
-- 
2.56.0.567.gdb80ae8cd5-goog

