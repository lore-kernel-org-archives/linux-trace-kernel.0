Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8545D388380
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777481841; cv=none; b=DQSvK1z3nep53BbotEm0BDo0BlcMau4+2QkIIuN+XNxtVIIcbeu3jYBpOeTP27r6L9LOMjTAxm9Odef8ozeJ9l5BFyvaZV56FioXq/F+3K+azI55P1sSTAgdrx062Yx4bsaOK6QwDil7mFmapVjH/myyTDVNYrf+zELhkSiSDxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777481841; c=relaxed/simple;
	bh=pQTKWyFqHk7kizHk/QF8u3ie/O9UkijKBv+OprJ0fRk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tMUUsLhFh27a8IOgnIIyPWPVxYIXReDnCNJqbr1TbK3OS2KuVY9bGxmlO0eHiNV3tRpaalvI9odACRGTr88LJv5Y70mGCk5YDBSjlT0hmJjy8H6LoG8gV9wb4pZ84ryu7IjYwaQYf6JoVZVXBN8XqM5iBs4fZFAXlQlhwQYBS3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLrfDSbK; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLrfDSbK"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so4536985a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 09:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777481840; x=1778086640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZW29s5vHD5K1Z2d6g9HIWooa15teRng94q2+n60qhrk=;
        b=XLrfDSbKNl85KcMJb5Uy0jp3nCC1MP5m7S3EtxPRIUFLXBKjluNcydJM2XsxR9/Q0j
         n8wg6TMwBFFCgdiuxUUeuoXm5/4U8GE/ho6LZFD+vGgjtLiAh0JrFAXpyZpPsUFJjT4Y
         36mMazowDWm/RsM7x+o4C6GPlsK7uU0jIIDM8BE9YUha3L8Y5SVq0t34BTPgxIOGQAM9
         Qv0Hs0HZRMZeUtHow0rh6qcCuj2mxQiX3m1oArkkfdKc4YLHf2JimVL1kFRjF9/5xtgx
         u+Q/w5Sm/34dn/ORXKrrzVtMwwjdN9F9tS5YHp7KOKSKSv+tyAvKH2B3ZKXpb73pWQK6
         KmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777481840; x=1778086640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZW29s5vHD5K1Z2d6g9HIWooa15teRng94q2+n60qhrk=;
        b=l0t1J6473VPHyfAaGM9EWLiXR0A1QyqdZKLJ63hzEUg73C0/CCfr9deban5Wt+5rAZ
         3utFF+AHzpFt2fdrfDSC3TfcTB2Rb4SkiV0lwFQ3xI47BHxl00tJ4t7KGbeMyyP+RdNz
         T7gEU+j3iCY49W/KfV6NOil0wBKKu/cakTexbyhSASXWm4yP4hLD8T3ldLIyZUALDl2S
         9fHscoQ1BMZcEBnFwgzA49uNM2jG1RFG0FyKLj7j1XBJ4CFnKMr3X7aSl+ll+6itUVGq
         oWRJyXrNwh+CDjxMAvZ6NE7Pn3eifUL9GB9BbNaqFD0pjAr+gOIpaHwxQsU3rem8jd0J
         OqRw==
X-Forwarded-Encrypted: i=1; AFNElJ+yT0PwVJZC8xpZwMaVz124/Y5oQEhh+xVNsswIr8GexFU8eJ72owlyS3epOS1nOwatWtvjxs8m5pyRw0UmUhA4Arc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoaR/4279KTaI7EB8uQWlMVTqGXgxCypm43xryHyDy8av+8eVN
	KGp7D2IDqAXMZxII442WW7vFDm7yXBzAdQekybncAu2Z/J1A9ROaa2ju
X-Gm-Gg: AeBDietj7I9W53NiUxruyTZZ13lm68PtksA6fRH1WnEQ7Vl/Nk/0LZHkntSSWCtWvV8
	D/RAdODSa2TWZNeGhHK4J5iVrkDkJPEeVVfku8Xt5yEFybHPzUfcDsi5EuFx/GgYbCQ0HoLzXWO
	6g4nIRcn2P3/sGOz3Z3Efo/Ahoa7jEgxLcAgxVfdH4lyxjYpn43d1GnI2dvUFnip8ryefThQ9xy
	cmCMYWtkUIW8oHIqJEpgQiCkyo8bEQzw30HpmhpVgyvq5bcoozHQlrECtI8p6MmL9SiAZzD0oL5
	fZam8Sjqg5Qvhe5r+sB8IO4/pvGrgHCDmwxzfAakHmOwfM5cPXlKJB9v+myh+tMlU7DrhKuC0OF
	2sh/8wnNDK9jXu+gA44MtyFlqeh+zAB2XbHiwbBYX+j3KWtZ30tQ/03Z+rw2iznH9UOQA+ers4R
	v1/hUyfn2dVfquADm7RGXJ2qZt7HRiusU6FVF6k/G2JigSh9m1zGXP0KaohTo=
X-Received: by 2002:a05:6a21:6da9:b0:3a2:f05a:7964 with SMTP id adf61e73a8af0-3a3af3f71c9mr5220864637.21.1777481839672;
        Wed, 29 Apr 2026 09:57:19 -0700 (PDT)
Received: from LAPTOP-DFRI2QR0.localdomain ([134.208.63.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd64f09e5sm2389850a12.16.2026.04.29.09.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 09:57:19 -0700 (PDT)
From: Qian-Yu Lin <tiffany019230@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Qian-Yu Lin <tiffany019230@gmail.com>
Subject: [PATCH] trace_printk: replace _______STR with __UNIQUE_ID(STR)
Date: Thu, 30 Apr 2026 00:57:07 +0800
Message-Id: <20260429165707.7020-1-tiffany019230@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macro trace_printk() uses a hardcoded identifier _______STR
within a statement expression, which can lead to variable name
shadowing if a caller happens to use the same name in its scope.

Following the pattern in commit 24ba53017e18 ("rcu: Replace ________p1
and _________p1 with __UNIQUE_ID(rcu)") and commit 589a9785ee3a
 ("min/max: remove sparse warnings when they're nested"), replace the
 hardcoded identifier with __UNIQUE_ID(STR).

Since __UNIQUE_ID() must be expanded once to remain consistent across
declaration and sizeof() within the statement expression, introduce a
nested helper macro ___trace_printk.

Signed-off-by: Qian-Yu Lin <tiffany019230@gmail.com>
---
 include/linux/trace_printk.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/trace_printk.h b/include/linux/trace_printk.h
index 2670ec7f4262..060eccb40838 100644
--- a/include/linux/trace_printk.h
+++ b/include/linux/trace_printk.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_TRACE_PRINTK_H
 #define _LINUX_TRACE_PRINTK_H
 
+#include <linux/compiler.h>
 #include <linux/compiler_attributes.h>
 #include <linux/instruction_pointer.h>
 #include <linux/stddef.h>
@@ -84,15 +85,18 @@ do {									\
  * let gcc optimize the rest.
  */
 
-#define trace_printk(fmt, ...)				\
+#define ___trace_printk(fmt, str, ...)				\
 do {							\
-	char _______STR[] = __stringify((__VA_ARGS__));	\
-	if (sizeof(_______STR) > 3)			\
+	char str[] = __stringify((__VA_ARGS__));	\
+	if (sizeof(str) > 3)			\
 		do_trace_printk(fmt, ##__VA_ARGS__);	\
 	else						\
 		trace_puts(fmt);			\
 } while (0)
 
+#define trace_printk(fmt, ...) \
+	___trace_printk(fmt, __UNIQUE_ID(str), ##__VA_ARGS__)
+
 #define do_trace_printk(fmt, args...)					\
 do {									\
 	static const char *trace_printk_fmt __used			\
-- 
2.25.1

