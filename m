Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6123F1C14
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jul 2024 00:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720657346; cv=none; b=ATEq2s6OiMfqBiWWQ3P9RHTnuKIXWW32S+hRjrPgcgb1kpZzxGXLxPVtMDyAeBw+Yk2c7WDiir1ouwLDJRx5uLUFrb+5PMpnuOqBReQipiyXQ0xc8WSB9thofLjtLU7vELukZpL5X8jCagM31/M/aol+BuUlrtoTCcRyejCZjOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720657346; c=relaxed/simple;
	bh=uM7smPu8AfGRj92cmn1JT/2eh3d2v25xWfIq0PU7kic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=idSX30O2XK2TTKJ0kew48LKbnrOEKi9LPbzlEh9jz2wp5PZ8upmaJYlQ6+D9ciu23+PkNG39ZD+gB34UUvwrqnpD66SF9o/MYlVRmN3AFTILAq47Z2/XiULKdORYpKWzAAJalXgaSnkxOMys/w5KF2PU1rluV5KB1Z+x7nbcXRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=ZK7DQ3Cr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="ZK7DQ3Cr"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4266b1f1b21so2044445e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720657343; x=1721262143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bywnTVppmfzQzszhkit49QhinE78akXE7sjmxioQWq4=;
        b=ZK7DQ3Cr2dG9Z75MnAUeZTt5RLBzqbxi9VtK0fna3RxHpnrN12DmgEdB0DFvHWNcv+
         lqwUy56JG/FrrpNPIEYKTxyU7CEtGykQdlHs0xpOrOTRza3JJ4nJVfu8+3Lu/hVRGLjA
         MgXbZpsJsIeuz2ilou174k6PaAHhzozAh1qcoYdmCG3vIt2hX9PCyxeogjVZxIQzp67q
         msXaHNMv9rIqE5uFYD6IIY34J4VwQcZqhIdj6J5L44CuIg3GQJ2gZjpNviEpj0Q+Meej
         4AyZ2Bq2FUDl+RMJElspDLp6xxcRAT/EQEgRqePOZlldKghReHMZPsQhDeMq4uv0DbjK
         QTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720657343; x=1721262143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bywnTVppmfzQzszhkit49QhinE78akXE7sjmxioQWq4=;
        b=hxpim+7m7nMKMY+THWCpQmBkd0M5YwnUe9oGd0K2GjQQx4T1LJNOJ4po4shruq3roE
         EFB2IJsZfNOSCqXdYkBMdx184GGw+pOCcF6hdugBANjin69Xtn8+GrBbwC77MNyfJyPY
         bVP5DzZIdLGr0zDIIJJCkZ9h/oK1I6lGoz2BxLfWP1k5uk3DzWjpB6J+Igj8ofr9fDtS
         tbRnIPMLZy1KzqQ6KXP5jVtbEa0l9t4UtXDSq/DlwOkz2uHK+UjMVAjiXYexi0J7j862
         ruWKvt82BVShU2lPhBHjvvcPn3+qMH3B6Hcx+iIIw46e+uqXXkyqKycXw+yB2VEJ76Ie
         f/lw==
X-Forwarded-Encrypted: i=1; AJvYcCWzrDUhIYwKE+66p/TLOG7z3KdzU4PgmoSj1Yy3CbAQyGuRadXQZScApjIEiPV+/y9K2ykvyQvIEVxP437qNoO5MHwgD7nMe3nxd8bgEDNLBYV3
X-Gm-Message-State: AOJu0YwW2TljQlbnrS2N04HMWVoIrEzrizRd0wcfoyrYXhUe1Noy3Nmz
	xFS3q5ooW17mKVzfqYn3Kt9Lp59/UOS0oDHdU0buyFtFjtSbEaQ1R5zAqgSgrk8=
X-Google-Smtp-Source: AGHT+IHqxrvLUW2J/54k8gQvzCID5HUCiDcf8dmMNnBG0HTWZkK2wt/V7dSoO2/ZLFTHC7bNTNgVAw==
X-Received: by 2002:a05:600c:11c8:b0:426:607c:1863 with SMTP id 5b1f17b1804b1-426707e365fmr43997305e9.21.1720657342591;
        Wed, 10 Jul 2024 17:22:22 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fca8bsm263977855e9.47.2024.07.10.17.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 17:22:22 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: akpm@linux-foundation.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] bootconfig: Remove duplicate included header file linux/bootconfig.h
Date: Thu, 11 Jul 2024 02:21:53 +0200
Message-ID: <20240711002152.800028-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header file linux/bootconfig.h is included whether __KERNEL__ is
defined or not.

Include it only once before the #ifdef/#else/#endif preprocessor
directives and remove the following make includecheck warning:

  linux/bootconfig.h is included more than once

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 lib/bootconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 97f8911ea339..297871455db5 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -4,8 +4,9 @@
  * Masami Hiramatsu <mhiramat@kernel.org>
  */
 
-#ifdef __KERNEL__
 #include <linux/bootconfig.h>
+
+#ifdef __KERNEL__
 #include <linux/bug.h>
 #include <linux/ctype.h>
 #include <linux/errno.h>
@@ -33,7 +34,6 @@ const char * __init xbc_get_embedded_bootconfig(size_t *size)
  * However, if you change this file, please make sure the tools/bootconfig
  * has no issue on building and running.
  */
-#include <linux/bootconfig.h>
 #endif
 
 /*
-- 
2.45.2

