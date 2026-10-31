Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793479161;
	b=nsXAOHBfmuk7nbg3JlBjFCF4NiXpjnHIz/WxR0nWAYgCSXJzyDG4vHqiMHhBzGrsFVUS
	 4eEkgY7kbrbg3uVTO2f59WSvdvej1C7CKVQFaj77QRQkGaBrl1nXI2XP40Q91BpKfdw2L
	 VU/Ojl6FTZkvUqmmVTBKFHjY0bWC1JxfQIFaH/6GS9dAY+S4CN5UMH5tltA6+mAp20jt0
	 AxEL8LooAipkdOwevj+sjNavHleNFEk1N1/aWdQ9MRwwcOVy0VCtYelSjyWkD6E+hL6r6
	 To6FNM1LLSuYIrJMjxGB8QlddSiy5FWKsF3MCXgs51HJ9dQ1tBL1HQu6FFmRwYKSGyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793479161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lw1QeIPbva61X8kOSwfRbW2IpFMSjR97yWrLghxbqQs=;
	b=v5dG0Gj22SnLVXtmhFTrWvE70HXvzG4XWPvDHwh48cZ5Z6uEmLEY4qFOFxE5S8ftHvjb
	 Fle0ZcVUEKLDA+aLkGp7K1XWV2nB0D6LG49pIDt+rHedEPi45+X8pq87J0MSNlX8/E9UU
	 /JRJWaHUlwglfki7r2En1Af7rdjXI0Ve0LPWndpbRCeh9y02lauoZI0cfJAicyOCL6s34
	 EuYhSc41rKrInb7aJu+u7k4NF9y7/DZNrIztI4J2ETaU2uSSaeO89WDUHDJ/su4jKdAX5
	 uqxcOle1l+Oz+sJ8YOeI9iJ4MR0XvlS5BUFgCgbWM1oMQVc0cjwfWENPhvFKhbUUQhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vnzncOL5;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95E4606A31A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 20:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A95E4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vnzncOL5
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso11593135e9.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 13:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793479159; x=1794083959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lw1QeIPbva61X8kOSwfRbW2IpFMSjR97yWrLghxbqQs=;
        b=vnzncOL56tJDqqOdKFxHy2ZiIzQGcH5TieMVIfutGfF47fn50E83iUFGfz63/dsONO
         pyZwMHwvQ5qQDsDf/5dsqMYoeiPPeyq/CfOZgdYBZenIAvf8LFjK8nqd8LcE8tr/N+Yl
         lfPURBQF7RFRTFhwY9iRsM/I0EhOh5OXJX2jdCdgGQLdmkyCn3DEOJ+EOGUZMIEPpA/d
         hbRipmVS1PneGisJlzprJwDG2AwcJLOcby9bqoByWJOyy8xpxOfQw9OYeCFoRlDZvtGE
         kr4JIPbc9bWdLtH30gOdpW3eecKnI5vYgvWOUWN8B6YDKaCp2G66IMaqyfuim85I4TvK
         hJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793479159; x=1794083959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lw1QeIPbva61X8kOSwfRbW2IpFMSjR97yWrLghxbqQs=;
        b=sN1JdN+mSHtKNbE2AOAJFELBjVJaqW1eWB5RDd6KX2gNyfJHP3ldw6rN/EU2/2u3ty
         PBjT/53czc/tHtQmpoMXGQGlM13a2jmw0Memg7ZL0Nrn5NKAkHsfO4pxbvKQqejtvBcI
         72LjVl4B629KDCHkJNY7A40r0D6ns3yJOljN7TvBNIvhZcE2KJaKIZ//vVpk0U3Jyqj1
         aruoisxgS/vhoTwDAYjJ+2cP7bjBy9sMySDMCav987tN0PB3uZo44o1kE2AbQilvyrjE
         ZZBR7cWv+JFThsEo42eYZgt+wmvOV8X+mKNkpSAAqyU36dpEcWkyHs6yFRRj6W6kk0fG
         mnfg==
X-Forwarded-Encrypted: i=1; AKwUvBwNnFzRvdXG4LnZGIka5o+4GCOTdKNHnyAIEhrphOB+24pFOLkMqOMpBV5oVP/AZ6vl2vjCt0XlqgAdwY/RvPYT6Ko=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2hyrDPNtnYinSrRYZM7bzG8ZQoCDsu2NDBomM7WWRXcToctsh
	JwBsonEIis4l37LDKgMgKMnjgh7v4x7WwZ75eoNsZD1WReQU7s/Xhcff/gyfiA==
X-Gm-Gg: AYBFou1HHOHWHmzwY3pkfLiF+CC2JC4m3aCJQ7l5qSa2JnsNRU7PoTUIJ4p33wtRDcW
	3AbrDFqgSpycOoAksEMWPepWL23w85c/uylfXZg4IKwzy25/W7ARqaSxYAIyrecWV3SYcQxQPoz
	ZtLMGNfF5Sa7pI+4KjKMJVW38v5v6MdYEI3jFY/Y9SbM9RaM0SEOYsIqjB9WVcwX/0uUqAL50px
	kiZZcWygbwXHvB0f7EzkT6A+rETuvAPg0mUY2kK56WxIvbVMmQgbf32ulUGnYeeGC/38/f0Ca1X
	zt1VfDnpLdjjfIEIKwuOXlRc3Hn4Fxh2aLYqbZQkrIYW6Al+H8T71P8siEqw3OQO3AbKmv89Ooj
	4Yp2NBJVgVTYJo9FNXeuzkjuCvQ6bNCwol2MKv4Z+GrU8xl5HqQ92/ziRwivpLhIRWqM5P4pJK0
	+zGyTCtzNhAatyhsdlv/VjWNJOeUZHqfeSNb/VOX1hVlGKjuwJrTSJxvg3H5vUyEwGUI13zsHWq
	nO61XykTwWc8nhq3tiJqyAdKObNTKi8TNrUQ4lZpaxTeUw7IkZ4vcH9lDHpy+RcxdfLsFLvazts
	blsFh/bvoHpfuSv6FjXFX3/l5M82JGiDHzLiKXCzpBqJH1tU+k5KZLY9LavN8NKrzpIFo1Idt/f
	vXnDNMvQL1XJ1dQ==
X-Received: by 2002:a05:600c:870f:b0:4a2:1196:db0e with SMTP id 5b1f17b1804b1-4ac1899348bmr125929225e9.30.1793479158956;
        Sat, 31 Oct 2026 13:39:18 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8a84esm11386624f8f.39.2026.10.31.13.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 13:39:18 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracing/eprobe: Install the trigger for every instance that enables the eprobe
Date: Sat, 31 Oct 2026 20:39:15 +0000
Message-ID: <20261031203915.491866-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The eprobe trigger lives in the instance of the enabling file, but it is
only added when the eprobe is first enabled and only removed when the
last file goes away. A second instance then records nothing, and the
first instance's trigger is left behind once the eprobe is disabled
there, so the eprobe can be deleted while that trigger still uses it.

Add and remove the trigger for each file.

Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/trace_eprobe.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 998e6390937a..a0bc6fa1fc69 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -661,20 +661,20 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 	} else
 		trace_probe_set_flag(tp, TP_FLAG_PROFILE);
 
-	if (enabled)
+	/* The trigger lives in the instance of the file, add it for each file */
+	if (!file && enabled)
 		return 0;
 
 	for_each_trace_eprobe_tp(ep, tp) {
 		ret = enable_eprobe(ep, file);
 		if (ret)
 			break;
-		enabled = true;
 		cnt++;
 	}
 
 	if (ret) {
 		/* Failed to enable one of them. Roll back all */
-		if (enabled) {
+		if (cnt) {
 			/*
 			 * It's a bug if one failed for something other than memory
 			 * not being available but another eprobe succeeded.
@@ -709,18 +709,11 @@ static int disable_trace_eprobe(struct trace_event_call *call,
 	if (file) {
 		if (!trace_probe_get_file_link(tp, file))
 			return -ENOENT;
-		if (!trace_probe_has_single_file(tp))
-			goto out;
-		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
-	} else
-		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
-
-	if (!trace_probe_is_enabled(tp)) {
 		for_each_trace_eprobe_tp(ep, tp)
 			disable_eprobe(ep, file->tr);
-	}
+	} else
+		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
 
- out:
 	if (file)
 		/*
 		 * Synchronization is done in below function. For perf event,
-- 
2.55.0

