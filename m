Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177736;
	b=v/tcJQWXObvuay/iL68alCNvp4Lfmytjpq4Y2+XjaQGYoEh2fs6ZYtu6xNHZP0osXDZV
	 t/qOvnbgnghBETLRDewOf2U2iMFjzJ93HIcU8alneO+9G3WwOmVNr0jR6yiIBHIlMCiiE
	 y3As5F3r0PusD+6C9u28GR/QdhHJnDUArl+u2svG6tW/tSyziZbbuNhYy78zbmUme/uqE
	 +zlJewOXHMErRiJtUoq83dpS89eHkkOyDmYKMbjsAzN3UiDQKcRoB4+r5kbU3SzfY3DUX
	 mGuIyxXcR0nv0B9XCWxKuQa5MO4WBLGRvRWGMK8T/4+qJNMhFmvo7tPHCI5Pj48iBRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+KA+YLla3am2sIk9vQD6p3FihKCddHdYMt501msSpC8=;
	b=T1p7b96w5mLedKSxFaeW1EROQ0yZGqLOguwVUh9rD7hh4n0Pi3FDiE1CbnB1bzNQpCld
	 x9kngdPj+8xyeiPk6KtJ0ro79SkamuswzuQzYeiv2nH4pAr5/yOnA/anYtgqFEw+ACc5L
	 BE2o5qhJRqiIvBkHDEFM77crJFaAdzHJ+M5ukgXaPS35hhVZyuFjGTNsEsi2Wfj7E+2+m
	 L3WsSL90kriDOmnFDQ7yLhRZQMKQTTdF++31e0RgahRy9KhT0ehoFbX7Zm8WG43E64N6B
	 Yc8Y3Nl5AAE1qXhQW2WuQfzwNjyRH3y0teltldBCAZVYecoiiMXPuogm74apoovH9gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=weOiSFkP;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C183606A320
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 12:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C183606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=weOiSFkP
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e09aa5264so416115f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 04:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795177734; x=1795782534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+KA+YLla3am2sIk9vQD6p3FihKCddHdYMt501msSpC8=;
        b=weOiSFkP5LHC25zLAuM95X9lbET+Pa1kwiWB7K2SAM1CrOOM3ye5/GwKqW8kQojbc7
         EbyaH1FLJB1xBSAetDIOwvcutl9a7QdA8pdLftMPnRJAkvjTQstW5afqsH3pLKQfU0RB
         8tZrJq1oUDUFJ38j3SR48oVlzkc1RVh16w0Osssxi55mDPFT9fFTv3nppfLM+znpkKFF
         eVwbJ5YhAA6BMRcNSUBcpW7Jy0T8GNcSNF+IYohDMK6YuWSZT4t8LTcwDE6ERMGMnFcP
         z1OS8xWrDALZSVj4NC59nxGdf4Dafcem/5QW7wCjMBrC0lRqEsk2cKHcu7z5e+uaVLSw
         mnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795177734; x=1795782534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+KA+YLla3am2sIk9vQD6p3FihKCddHdYMt501msSpC8=;
        b=F9+GHud1YF+4LDXWuQ1kCLH6f123jJPGHiwlWSk/cSpdjp7NS1uJSZ4Szy4oWnqiiE
         qj/v4vpHoQudYTyh00JAjKqH6NBrggFx7+lP9Wd6EBycHhwzfT5Z5rwnyanSjxV8Aru1
         vDxyPjjj7wREGQgo5ZPmnQ25Qn4r/onJGnzXHhGof00Vgjeaqg0GgB6Mvnr8iUFHKBr3
         qPdjE9jNctOdi/0Syk3rLs8eL8eA6s0NUeecm4ifAJ4Ggr99JFKbWba8ULwRDHXaYXt8
         NKaCQK4mqF3ftWcjmR9ZWuZtgbBAshlEItFIMyOMYM+1gixBTwAl8pWxkYRU+JjBBPEl
         v7hg==
X-Forwarded-Encrypted: i=1; AL+hErH9K0xXCmzkCKkX5+pS7H5wIvMQIOQrytme6UJ+YJragdwf5EtcGu/Qe18QtrW2Ug6k0h2ue5Cnhl3lstHLGcHNQQ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9QCdRLiFU1JqAUbTcFNlfsS59N+zfl+3jYgYoI5CSvdpoeTHxM
	H7H9ctTWaQviUVwLmqxvfmD+NeWnSocJQfcp31OjleJ4Ba1b1a0ED7vy
X-Gm-Gg: AZFdTZc+hf185b5wsvemGsK30hFJ7t2e9h+3mJK4EKueMDGQ2/OG0HHctm1HsxRm634
	HdRlmhDnTbp3+egaW96GzXZM1rTZNLt726YxlmUwpInjOQ70wMkE0anNIaeBIY0ZyOdZryNAjGU
	aodxmBL/f6i0vo8+px9pWeomAK688z22Z938lWZpdKrkDulW3Vry1/LOhswHqOoomBx7K2m9UNw
	/F8eXpZ1rB3S4tao8H7wjSOp6mqY1qGZKbLmp6fQrmkiHXjwvUd4u2PEePh8SXDa+BVSi1qKjZx
	b+ogC7yqm9XEtnvl7hOSoMhLql8ye6fQkdOKdBKEr8G5tRAsJjILaJD567wMztHEM7wLUHnfABE
	yqZT5/GfbWjwakBnGwo1HWt+igdJ+OQ1ZTdfB+41x7oJ0LziGgpbJPFTiRxU+84YPCOu7L9QM6S
	gTxOgleSehR65T47M1Ga4HCbexLimZsL9Zp2yrz89IBmy7c8ZEUmOWXDIxLEr+VfNg25WKLS0yC
	7bZ432f/BF0m5cLK6L/03dU9GRW1r3WpoIMarRsbsh9IpdtX0s3JFynP/GT9JtLNjlGKCQe/cMH
	MzCanST5416l8GJF0/j4oehwZfcT6D9ZXA==
X-Received: by 2002:a05:6000:258a:b0:4a6:4f35:1bdb with SMTP id ffacd0b85a97d-4abb44d3448mr6020046f8f.39.1795177733737;
        Fri, 20 Nov 2026 04:28:53 -0800 (PST)
Received: from LAPTOP-AVI.lan ([2a06:c701:477f:ff00:c12b:38c5:81:f768])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a680483sm5312438f8f.28.2026.11.20.04.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 04:28:53 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] tracing: Restore custom event creation selector
Date: Fri, 20 Nov 2026 14:28:38 +0200
Message-ID: <20261120122837.1597798-2-thnkslprpt@gmail.com>
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

The custom event generator undefines CREATE_CUSTOM_TRACE_EVENTS to avoid
recursion, but restores a different macro - CREATE_CUSTOM_TRACE_POINTS
when processing is complete. A second custom event header included under
the same selector is then skipped, leaving its generated update helper
undefined.

Likely a simple copy-paste error.

Restore CREATE_CUSTOM_TRACE_EVENTS after processing so subsequent custom
event headers can generate their definitions.

Fixes: 3a73333fb370f ("tracing: Add TRACE_CUSTOM_EVENT() macro")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 include/trace/define_custom_trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/define_custom_trace.h b/include/trace/define_custom_trace.h
index 5827a4c92c744..177c628f2d567 100644
--- a/include/trace/define_custom_trace.h
+++ b/include/trace/define_custom_trace.h
@@ -72,6 +72,6 @@
 #endif
 
 /* We may be processing more files */
-#define CREATE_CUSTOM_TRACE_POINTS
+#define CREATE_CUSTOM_TRACE_EVENTS
 
-#endif /* CREATE_CUSTOM_TRACE_POINTS */
+#endif /* CREATE_CUSTOM_TRACE_EVENTS */

base-commit: 65e4fd942f72a9dba0e4e257290c4fa1aa756854
-- 
2.43.0

