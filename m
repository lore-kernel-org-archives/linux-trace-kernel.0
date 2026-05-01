Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7983E9F71
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 May 2026 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777653018; cv=none; b=AiTPJht1MYALSQLNUk8+sjUNRMwerZYxrgsWZX/hfdDMjyoQU1EQg4jYKRXxeBQNRqKGm0UtOu1jVGguiejw5rST5Es+IRRFTxvOgj7fbLjRj26mctHKEfX0RVik4FFWEw7uPf9Knx1uG0goqG6jvjonrDUBYqtokcH9F4G0Cpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777653018; c=relaxed/simple;
	bh=mii2xt/r6uMRkyDpEVDnU0K4TAs6DhwjT6m+GI+gkHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAWUJXWUru0K1A4eOUTOrxGQYGMsFNhnzdUU5FhC7x0RWzaXCIjQRaOMqBdKHDmtmeRbokRx4uc4dKg6N958HJ0kTs5r0MmVkabyYDoHoJ2u6mxmGWbBZ10FEY6RqGB/6cPrbqpFcwzNSTYFuDacaOiKEiKrt4DBPo4Y7aknNEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTSVoLQV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTSVoLQV"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b45cb89f7eso14045685ad.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 01 May 2026 09:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777653006; x=1778257806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgxaTB1e21kEX2UVzrZkXobnRe6UUTQFRRbaftYvuNk=;
        b=kTSVoLQVkv2mHgi0AWVdiMuaGWULMAHD5W4EpfGBh9rxco9C3eYDKKLqmcUhPHYDEC
         Du6nfsHaXMZ/UmjN1AjjINt0Pa00OM4xzSPwVVnGM0biFZ4aBBWARYfUOFTwasfA0mrz
         D6aZSIOpoojrVs6kvy3qTL5ZPDaIfNRSiApLU9yiQpbHtq8m42yA/ohFgDJqduWqeJYh
         VythLwAuaTGEGNvDKq3aFSt11ssK9FHDCMM44B1X6dLAzIwOQY50fWJSyV0VyA29G30x
         d5LWMJyctj33tGupt5y/MMrime15o4ceDUuoMraH6vuzYxbLxbEVtAaj6UXDtPhJIkGg
         yRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777653006; x=1778257806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vgxaTB1e21kEX2UVzrZkXobnRe6UUTQFRRbaftYvuNk=;
        b=KkmquZQ5loZxs9d3vSQEO+1Maf6rrFOkmJ3mfqOTTK1qw+1X0T8rQkufuhQaNy/mKj
         3fFPIb5E7N1SGRuUxg7oVVG7vjlHNM2R6EGpbdOZn73alhXci+bthPPaQP7O2h0MabZY
         xsiu4LO4/9SBBKdWvqX8Jk0E//F5pDfpBCeaSnIJFFHuH6AMELb6viahFZSRslrqMgNy
         bDmmHPfe1/kgHWEKgzowxnDLcFH8djTuwUI4Z83FXZzcaUfrqCJE1KBeYerFOsUlA9Ak
         IpQMmYAF1Ia6xx1NyH3+WgfvXImQpMBGUm+Jl/pQbaL1q1RJqxxYur4wrIlWqWRmTiWk
         k1DA==
X-Forwarded-Encrypted: i=1; AFNElJ9v8odtwgqfORxUxuRRtVvYSqtkYkhtEMXxEhr/DwGRP+NUdhfZ3BSr3D/G+qE9jsCA7tibxUGyv7cmeGIkT1YGkwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNlLw9Udx989A93V4vFzpNOVn8ujHS8uOOp68Kxx4PpjMKK12Q
	8P4qAFbpb9Upk4ZXAv+6M90mQ/I2u5OONeETYldI6Y9qljES3MCGTjTN
X-Gm-Gg: AeBDieurkTimthFdxbhOZMthdc3bLjEbB5eU+iSppm91zatgXWzRapTLWZTlKFKKujO
	0hMe2y/KQTuuzPcyNQP7ej5Ic5ZiN/ZsJkluFvvadGhaQ+A5aI3Pea/DNyt9PJKeontbL9tUgJr
	0h40fgZ4VwNCRREys2ZZAWKxO5r29dv8ZXcHIIGpz8dzZEpCbNTClWBD3vCe0eYwUA6Vr0z0GWg
	qR582lDdm3jNynVQ4C0oojpOcjBNrj30h7/7AJI6IF5mRzqMHFsI26QGfJvCkVsFjl6AKovJy6G
	NkOyx/IAUZn+lEo+jikEnH4S6XaviZjFlp/+oxzFrgkmPBrQyjKD3a2yqLIAqir8YxnPS+Kd4NF
	7LNk8mFEVS6ZAfFRj/1p/3D5RbucvS5ELST3RNm6J0hFxJWxB0+ZRlCCA7h0BGZ/MKtx10akOff
	pRLC//+VaXDNXomxIxkdqYbPX47k2Y4sbt
X-Received: by 2002:a17:903:298b:b0:2b4:678c:5f1f with SMTP id d9443c01a7336-2b9f222bc7bmr272905ad.0.1777653006516;
        Fri, 01 May 2026 09:30:06 -0700 (PDT)
Received: from nova.. ([134.208.63.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caad2833sm26783875ad.35.2026.05.01.09.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 09:30:05 -0700 (PDT)
From: Qian-Yu Lin <tiffany019230@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	david.laight.linux@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Qian-Yu Lin <tiffany019230@gmail.com>
Subject: [PATCH v2] trace_printk: replace ___STR with compound literal
Date: Sat,  2 May 2026 00:28:26 +0800
Message-ID: <20260501162826.20582-1-tiffany019230@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429165707.7020-1-tiffany019230@gmail.com>
References: <20260429165707.7020-1-tiffany019230@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macro trace_printk() uses a hardcoded identifier ___STR
within a statement expression, which can lead to variable name
shadowing if a caller happens to use the same name in its scope.

Replace the hardcoded identifier with a compound literal, which
eliminates the local variable entirely and removes any shadowing
risk without requiring an extra include or helper macro.

Since trace_printk() is never nested, __UNIQUE_ID() provides no
practical benefit here. The compound literal approach is simpler
and has no compile time overhead, unlike the v1 approach which
added #include <linux/compiler.h>.

Signed-off-by: Qian-Yu Lin <tiffany019230@gmail.com>
---
 include/linux/trace_printk.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/trace_printk.h b/include/linux/trace_printk.h
index 2670ec7f4262..7a4f6711834f 100644
--- a/include/linux/trace_printk.h
+++ b/include/linux/trace_printk.h
@@ -86,8 +86,7 @@ do {									\
 
 #define trace_printk(fmt, ...)				\
 do {							\
-	char _______STR[] = __stringify((__VA_ARGS__));	\
-	if (sizeof(_______STR) > 3)			\
+	if (sizeof((char[]){__stringify((__VA_ARGS__))}) > 3)			\
 		do_trace_printk(fmt, ##__VA_ARGS__);	\
 	else						\
 		trace_puts(fmt);			\
-- 
2.43.0

