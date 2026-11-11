Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366832;
	b=zIQNTPjRvdZTz2zgGWKQoR6p7vyM4O8XF/k6E4d8PaJVf1YMSIpFOYxy1Ip7pIq5nOd2
	 8BS/1bRt8Xqq+0vvzDH3pyIyztS9mYNOs+sXB92sSOxLnvRcyQYXpfPL8ZCR3NhTaSAWz
	 UwximA6mXUZHOa+yuKDG2czS7fc7QaBfbFR7lnZ/6Z7GbFOPqLwaXVeCt3TlfFUuFd4+U
	 dP5fjs5WqVGCAJI03z3x8ODynh9anrEMkBnOkD3Dk1ad+tjC/67g53yVXFjOao9ZBbGpD
	 ejUFrSH6LiP+2j923Bl/2AQvwqqvrmw3niV27HALpTc9n+VT7AI7B3FhvzD8uoOD9Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G+ckLtpXnouNmS0+eGz1d3M3aH311DkqhG6zVtoehMI=;
	b=5JNFje742bGr1Gx/kcdBjxR4kEUf0g9oBpQC2aJTnimaYYG14mZiUxHs5rGpWXTpc1iR
	 BR8/37Q1o/5yoWbm7l3QYzoDq5vH4Dmqv2krJPhmUNH3X/A7h0zj7iCA52n4pnSOD4cNV
	 TyXKRFJRuCUs5iHI5qq2LtV+dWPttubTD+V/i7yjXTLaotNcjl+71lAQOl00jnUfzkHmn
	 TznVQeNxLGmUTSpHuKMpbrOyu/JcGKINw9oD77FvAZ/QfGfVgMeY0KKa9DI8o+8W0Fz97
	 j++7kZHR48YSmJrG1RfmrPXnqvCcG3Ti3YxHO0VvBswFZm+QdGhzA96R+Vpawf9ZmXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EBYhTxGp;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E6C606A324
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 03:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75E6C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EBYhTxGp
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1abaaf33a56so5256c88.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 19:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794366830; x=1794971630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G+ckLtpXnouNmS0+eGz1d3M3aH311DkqhG6zVtoehMI=;
        b=EBYhTxGpNuq/Dvi6xARbRbdOkxkTcUCjPII0f3YI1NfPJAlkRrTcSM9rSKlV7UMmKr
         y5fDADDweQNkE3ko+GC3f3FmSa7mGw4Oa9mE0oOTjNA0FGcOfu2VPVx5OCfbHmhm4jxj
         Uqu3MvI8zZU6HkQ4oaKuFDCAadGMupOHlGiNjXWlPBdy3OJVpU3fnhoWWRpB+msBTVOr
         WXXmU3BpavFgcysc0CJEZdW6R7Xp0bVb7lwTEtXWZD2yEVUWYepXVOfQRk9YPuOY5weW
         R9p8rCECVl0AHuDhUFq9Vro4bbTt3119H0J0RZ/R4aiyALFs3lbs8bTRDKiD+2pDfki3
         9PJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794366830; x=1794971630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G+ckLtpXnouNmS0+eGz1d3M3aH311DkqhG6zVtoehMI=;
        b=ibTSvRaplSOrW0DqvTWG4kA2KffZkj4Q8M/tty6ubxDRRzJLLk+ddlfCkiHlJRswpP
         CMMU23WtLKUcdQXrwXlYdMf8OLEvZ8a4Xxwpm9TVI2TyyjdQVo6M0pnQmMzz28NJT+A0
         Ux1D8z8XeBomcsci+H2x/EtzBuRcnSVL5+yot1SBSA506AxDDOLcbp+LRVe3SXZpoHBe
         Q7FhknVoBvNZ8OLf6KsWqf/NsiGJ7r8BxCtHMw+3g1ULw1myKj2VXuc2y6OjexCE/YJx
         42u02ka4YuByZ75w1hdnOVsV5SMK8mUBGAJGiKthB1AcqbY5+aaX4omPAC06tl1I9ME1
         O8iQ==
X-Forwarded-Encrypted: i=1; AL+hErEqeBA+97f5DUgpqEIH1d1DDQEMRV7wAiA4H43f6OBlRxNpB4PKEzN66S86z093/Tc3ba1qcYdDgbykMWHK1obF1WM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dNN+mh6rI7ciWexetmozdcdb0O8Q9e3hpR72vST9bjlsnToMB
	9+lXYq40tNfT+mh8u1z2r0LinZOe9UBNwWzKkERXZfNMVZRWbe5uHrfd
X-Gm-Gg: AYBFou3WtJZdDXLcFPenBwF7VAFhDumWq0OLrwi6gQOgLLpLlOF2SV0Z+/gtJYF8hY4
	po/Tj6aUjWOI+O/WE+OjSP1OI++z7FWKPSgcoaakoBj4FapZl061XrgOuBvaC7hZeAfwrOlS12E
	Ne2eVjUMiDXz73ef1HRB+Rnmu/OhZV+hhDa18niKtXFN4yzW+olVuquLY54p0RiYqfkSJUEc+2E
	MrP9/wFQjdB0q/RG6yX+gq2g8VZSbLJyuI86MzYfEI+Zt02SUMaAKVzk3R5s9DiY9iNoz5BgI7I
	S/rWo7nFv6SCqeW+HNi7shDNew8uKs1+i9Wbb7mIfW0fb212+rAM/7GlZ1qvaz6FJl3sVkqR59t
	mSKAWsDTaFHAsQin7IR0BixGyDwUDQq41i6LPMhrdGx+o5BvXk5G5U7AOp1mCxPaLLE21YqPM1u
	roRMfsLHjmZMmvSuOrOl9rPwffBmLFECGjCx6MiGDMBHrWO1WKZHu+uiNZ82CaHud4KgYnuhB7d
	Q/WnG/S4vxwtr3MJeA+NKDNXCqOaLDaQ0PL7CfPZq6dKXlBcWNKIEhbP6xC3XGXd42nOkPAzcO4
	75Vz9uUu6tWfrnCZV9tSePFyLWBHr1pM7FkjiuygPTMaNVRbDAghBJQ=
X-Received: by 2002:a05:701b:42c7:20b0:16b:4f52:a08 with SMTP id a92af1059eb24-1b3c016cf6emr1879186c88.0.1794366830410;
        Tue, 10 Nov 2026 19:13:50 -0800 (PST)
Received: from mi-ThinkCentre-M760t.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2fc14sm10960507c88.12.2026.11.10.19.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:13:49 -0800 (PST)
From: Wenwu Hou <hwenwur@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wenwu Hou <hwenwur@gmail.com>
Subject: [PATCH] tracing/hwlat: Store the maximum latency in nanoseconds
Date: Wed, 11 Nov 2026 11:13:04 +0800
Message-ID: <20261111031304.1442318-1-hwenwur@gmail.com>
X-Mailer: git-send-email 2.43.0
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

tr->max_latency is expected to hold nanoseconds: tracing_max_lat_read()
converts it with nsecs_to_usecs() to print the usecs documented in
hwlat_detector.rst, and the other latency tracers store nanoseconds there
too.

Fixes: e7c15cd8a1133 ("tracing: Added hardware latency tracer")
Signed-off-by: Wenwu Hou <hwenwur@gmail.com>
---
 kernel/trace/trace_hwlat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 65e184d800ff1..701b6a542e51a 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -293,7 +293,7 @@ static int get_sample(void)
 		s.count = count;
 		trace_hwlat_sample(&s);
 
-		latency = max(sample, outer_sample);
+		latency = max(sample, outer_sample) * NSEC_PER_USEC;
 
 		/* Keep a running maximum ever recorded hardware latency */
 		if (latency > tr->max_latency) {
-- 
2.43.0

