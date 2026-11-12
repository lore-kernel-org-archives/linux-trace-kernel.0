Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492895;
	b=eWyMwp3Wd+H3E/5EI3dtYJIJ+q9fACSiu6D2cWF2pDRoTEpiiV5il7csLm7ceKJuf2ob
	 aeCUvI4fAWZHmX4E0E0oxIIo9VQODYuq9SfqlTyPNv1U+KIk9fVO5NoJ6G+l7oelATQis
	 DSNUcsX87sDRIn5F/otKh8XdNvjnhBl2dSmDQ2V3oBBoaAcQi9WKG/K/PMoBilvm0u1rR
	 XGJbwnWhkpnU+XsU9nODt6JIjnX8pBF4NotdVuzIV/ebQao9iqg5PClJ0BVrfFMd3fCBv
	 tTBi91yy1eprU18eUwo/UsFgjFF5TLesN/rRqLc67zvCk9wRqQkG1PWMs6ItL2tvwjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492895;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=nOnTfPlOL03qOmHIzh6thEjDQQkJdnopMg7V/l7FapQ=;
	b=GtVIwQ/rIosOBKTf9NyGIbvyvxYBQkVmXt3OBMnKymMopxjlsgVQFKoloQlapFkjQ2la
	 wX2HX0aJ5KWYkOh20CG0q8P567JG5mf0t8Wb+gfw55TQxdnhVvXD4gHEUGk8Rb1ZbTbQS
	 ysYI9lDF3tfeBDG+1WE/qn5/sQroMHvq0pO1YoA88gkK+enQEy78f+BpHAbxoW5hQLG9a
	 LD0nKaUGNDLV/l1DlWilbbQ5J6ELTw3ok8o0uqAjfudHGTabXopQW5kBJQrQmP3k8GamV
	 IplCrj3DepDAaK5P18GeDUqp5Yb+BLxhc5ncIM6lK+B0KLFduRSHxCDvIBti/T6RA1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZyzCL0KH;
	arc=none smtp.remote-ip=209.85.221.70
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51357606A8AD
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 14:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51357606A8AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZyzCL0KH
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4931c89d228so2918210f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 06:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794492894; x=1795097694; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nOnTfPlOL03qOmHIzh6thEjDQQkJdnopMg7V/l7FapQ=;
        b=ZyzCL0KHYmPmV1rv1fa56vVy/dEPis6EwEF3uqKSca8RkkiNnLxY/Bm8eOY9ffwQm4
         RxveEMoq/wkjeLR54UtRoKMH0gWCcAekuoOgrnxktjWaiLA+VRFG8vLUEd4HI2lDzIVS
         W+XBNOPvaodQFvLnKmVurVBYRokWifVamJQAxqWClUCRWEwnEk4jTET10wuhaEs1kPL9
         neDxH5kkBLNu9YJyBIQCFAe9UreEnXQER996j1HFSNaCZeN+mHAm4KwDxePgWbg9SIML
         b+ymMn6cfQ8JhAzVvpUivJt6CTU8pb/BzyID1StdA2ofRKtbhlNoal3bn1AZOLxpPF9f
         Gi/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794492894; x=1795097694;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nOnTfPlOL03qOmHIzh6thEjDQQkJdnopMg7V/l7FapQ=;
        b=ssFhodMudrf5FJ9CxFbSpxfk8yUyUHAmAzyXOrJX08fS9i0QzZTh9NpYLkDIz56U0U
         AIgpAflYcSO4fTziQQaDpb3Kv3j0ccQfTP20/9p8+CBd2lHpb1sL6so4SaKmNIyAYEub
         EwFR9ZEUK9zLJ+nXNNLyc9Cp+Gk6qZt/M8JSYp2yzmVwSzZPxe+C/YVn/ufi5O/s+c9K
         lBl4lxXZiPwiRn9bNkihOAMivokUkmJeicPlFfKXniWmd0tlNb5sqKM9o590lw8QFCk7
         Xv4L6E5HS2jGlqPQN/vEkVtM+EKN+4H81Echugk9Q30HmGxdZ6+KabdS702uzZxHzsMV
         wyEg==
X-Forwarded-Encrypted: i=1; AL+hErGmGZuPzT5hSp7hXra9fqdZdU0KnPA5uo7ggy4Gd9kUrSFrjinboGaQUu0Cm9dCi2Orcx5xyhpUfN+bhjUERy6jisI=@vger.kernel.org
X-Gm-Message-State: APuU4Z90OZMk+lsXHnofidaAhx7gcJ+eQjxDLZdQ47bZaLw93fh5H7nW
	wfoT9+vwtqmE6bF9YkJtjfvTZq6VRmRtal7BdbZAwJNwYbUtQ2e2OIaDYvFwH7NvPjifiNvn1pW
	ylzsCZAIZEoJ2dS77fTiJew==
X-Received: from wrpb11.prod.google.com ([2002:adf:f24b:0:b0:48e:1312:61f9])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:25c6:b0:491:6c24:65f5 with SMTP id ffacd0b85a97d-499c5e3c13dmr10477013f8f.17.1794492893477;
 Thu, 12 Nov 2026 06:14:53 -0800 (PST)
Date: Thu, 12 Nov 2026 14:14:35 +0000
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
Message-ID: <20261112141440.3050124-5-vdonnefort@google.com>
Subject: [PATCH v1 4/9] tracing: Cache ring_buffer_max_event_size() for trace_marker
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

write_marker_to_buffer() calls ring_buffer_max_event_size() twice
without synchronisation against ring_buffer_subbuf_order_set(). If
subbuf_order grows between the two calls, cnt may expand past
TRACE_MARKER_MAX_SIZE. Read the maximum event size once so cnt can only
shrink, and drop the now-unreachable WARN_ON_ONCE().

Fixes: 2808e31ec12e ("ring-buffer: Add interface for configuring trace sub buffer size")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/trace.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e8c4efa8107b..f44bde7c51b7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5962,15 +5962,14 @@ static ssize_t write_marker_to_buffer(struct trace_array *tr, const char *buf,
 	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
 					    tracing_gen_ctx());
 	if (unlikely(!event)) {
+		size_t max_event_size = ring_buffer_max_event_size(buffer);
+
 		/*
 		 * If the size was greater than what was allowed, then
 		 * make it smaller and try again.
 		 */
-		if (size > ring_buffer_max_event_size(buffer)) {
-			cnt = ring_buffer_max_event_size(buffer) - meta_size;
-			/* The above should only happen once */
-			if (WARN_ON_ONCE(cnt + meta_size == size))
-				return -EBADF;
+		if (size > max_event_size) {
+			cnt = max_event_size - meta_size;
 			goto again;
 		}
 
-- 
2.56.0.567.gdb80ae8cd5-goog

