Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793173648;
	b=Thfb8Lt0pNPoUTMpJjelvlkhnMXhMWZTvodnvDoWvPmoFGd+Ul+kpP9edjxEUfyhypsK
	 CK3z3vzDM+nMwXqnjsB0Tzzw8xVEPiCWjQfdWUE8eZFW4o0yVhC+8zVOdjVEvEzYsSpDt
	 Y+M0OGgB9YakxVa+Gcx2r7lu+v4ZVVv4mKC152uG0fKFNbhckazkr7guazELFQ5c2A4bs
	 9PA5C5bZ4ooQ9TH7g5DWjCwTJjgGsODUZuZ16HQhTVxDNN//TEVUyC5fQzfsYpueNPMCd
	 R3IHhrVSotdSuHJfeJeggOVCMT1x9Bg6GpkbitOOTmpU4XQVawSg/IDR1dcTCjUEqFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793173648;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8idl/HtLxFU4RXc5SRlZ1K4xdbzJi8/5nFcYdaBFYqU=;
	b=jnF0QQlu/aFjrT8wc5SNdxl4zOFL3Dw3v3sN5Xoc5PYJbAeQoCWWF5XPIrdHJrk2h4Wu
	 G/dIe+XK07Zp/JfI+PA7okgZjXH5TGl4h8lIrHL9bOlG/yu1VZIPNl6vfZbAdYcj8KW/u
	 q59wTUwI8ZdOQxhVi334YW+S8Db/WK1slyXf5hiUATZbM+hv409rGLfQyPgnuBxMDvWs5
	 GOZFJnY0//p5ey3mhzsg4tsh7ys/SDWiTAPw4oYvzHVFRH0T13dU8SGL4b7T2oGmW6V7N
	 QGF3klFjZ2LhZyYmd5XmkRMJTklObmjY42QR6VvbICjkpbF31SQw37hmaVjuZFytg5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fvuj5PzM;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBE6606A31D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 07:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EBE6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fvuj5PzM
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so328032a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 00:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793173648; x=1793778448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8idl/HtLxFU4RXc5SRlZ1K4xdbzJi8/5nFcYdaBFYqU=;
        b=Fvuj5PzMLnp511zUOuXtW31L3gHSh9Oxmyc4svNtGfRUcaoB9SyzBMYNXrIyReUD8R
         Whghg1MpP6ft4GuJiOnRvlfr6lvlXmDN9YG6M4RcQva1FVa07hw2SJ7cAYVMOwUNMeq3
         kh5rreu+mGVhbp4ng8GL/xeiP0UdZT4oBVoJyV66/46Cgxxy3YR/EPb4yrULEfa1DwX5
         +bwlDpN6ntqqPY9dV6ceqJMrW/uGjUyvpA/w5Dy5PFaJKtQQ0GNPrZBjoF5/yIuLBqeD
         pJ1AGvboT+IMFxKUjVJE66tLc4mO3VSbzw3IRtfIOHFwYRYek9V6l+RJ6YnZ52pj7iBI
         7hmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793173648; x=1793778448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8idl/HtLxFU4RXc5SRlZ1K4xdbzJi8/5nFcYdaBFYqU=;
        b=RR9g0qlnPAKvOSDm8ZfIKxwXzcKHucNXBK1CNWex6WKJpu9OcgzPdlBOUcivItuxzv
         GkLGD6zP7gS4v0wBEhlj4qnhDFf8oND2JHIdBqKCteDPgoFIBHMEREjFyh3Fy7TCGwha
         mS7T8msPRpRmeg381zXGK3c+2Xk9R5b0SdA1S+Ds2EoDL7N3TQYXMIw+SgQHtrU3/mAD
         +wSlJrk97UI89kasqrICXo6XKnw512rClBpoIxwslbwqH27GT1rK1gWXuEFhShFWkq5m
         pGHJE83jv40cFmv9GlpsL71Qr0bHLCI7zMO3+5PM1zyo9ePwvLtm8dy3tMfnUim8Whtn
         B3Ow==
X-Forwarded-Encrypted: i=1; AKwUvBwNHeXnrQWVyR3c91sUGVSjkqk1NP6cCP6hO7M8vPHuIZeht5f4AHotPy6wbjGayVA3utwJYcT+0KT/ZSkGgj0WC8U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3fwm6WPPFPskrJAWRvpN62vaKQNDUow+5wl/8xJjp3AUuvdvE
	NfFKeT0e28SoN/sYjbqCDNEMXLtZwEsDKoa/ZXWgF9rOJdaIpUE15woH
X-Gm-Gg: AYBFou21gB7U9U2yqWp7hSi9YFh7c3mSmaQzau283vHPIPi342UlNrRaA0Psdc1IGIR
	Lw9mVrmB9S4Eqq71NgjsN7Jrl/YGWsctMZIBcdLf6SuCRrPEOhzWUD/VIxz5TGXlRjZQTN+P8DZ
	BDRkefAWuxI6rZ92lsDPhoU0hb6uVz6dnf4LjZIepxZEMEKADXnP4/zhTdQdZuXp2JpWpI7fJXM
	9OJ4qn9plpzkgj1GrHui7m10z5NBXE4Zg6oW2BSomWgkznziDgys/NTSFEViUE7NBZhMiZBs0hL
	EolJ86qOX40NvLnUAx9cd3PvQmD8gyslXZ4a8QoEUAtlNJgOjWGmhrSV0CN+RHzjJkG5Yf8Hyr+
	2rvLhLS84ovwjESFpRi0oGizGAWVg9rOBdPeh5bEfPXh3DzMnAdjAHN8CIFgLhcokLh2lrORhUv
	DXO5UIHvV81beO4tyjfJWp3A7Hn1JUu59DbeRUkNPApl01TLQNc69hC/yQU7jkKNgcFEa3gBZFk
	3QbGiXHQUXoL8elRsRgCTQlObL1SLTBoGoRiaRCluLG5Pcsm7If23zJf8tsJ47MkZOnu3quDFKK
	9qT7CcZqnNadA2P1rxT1ryMQ0DSX
X-Received: by 2002:a17:90b:510f:b0:3ac:adce:60b5 with SMTP id 98e67ed59e1d1-3ae580ae38emr1000839a91.14.1793173647649;
        Wed, 28 Oct 2026 00:47:27 -0700 (PDT)
Received: from localhost ([182.216.53.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a27f7c7sm1941127a91.2.2026.10.28.00.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 00:47:27 -0700 (PDT)
From: Jaewon Jung <jaewon8868@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: Avoid undefined shifts for zero histogram map size
Date: Wed, 28 Oct 2026 16:44:54 +0900
Message-ID: <20261028074610.2212374-1-jaewon8868@gmail.com>
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

Reject size=0 before calling roundup_pow_of_two().

include/linux/log2.h documents roundup_pow_of_two() as:

  - the result is undefined when n == 0

With CONFIG_UBSAN_SHIFT=y, a size=0 histogram trigger reports:

  UBSAN: shift-out-of-bounds in include/linux/log2.h
  shift exponent 64 is too large for 64-bit type 'long unsigned int'

Tested on x86_64 QEMU: size=0 is rejected without UBSAN warnings,
and the histogram modifier and parser tests pass.

Fixes: 7ef224d1d0e3 ("tracing: Add 'hist' event trigger command")
Cc: stable@vger.kernel.org
Signed-off-by: Jaewon Jung <jaewon8868@gmail.com>
---
 kernel/trace/trace_events_hist.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index f39fa8942673..3de794c7f5b2 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1430,6 +1430,11 @@ static int parse_map_size(char *str)
 	if (ret)
 		goto out;
 
+	if (!size) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	map_bits = ilog2(roundup_pow_of_two(size));
 	if (map_bits < TRACING_MAP_BITS_MIN ||
 	    map_bits > TRACING_MAP_BITS_MAX)
-- 
2.43.0

