Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAC21514D1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720687488; cv=none; b=FEqSezqXC10m0Bt/Fgw2CE+XAb86AaD2Aaf3E0jVXA2JErhEs7YjtmMVZdbX5E0/F1KuSL2/xHhR6M/iAzAcF3Kyi2ZWAKcCy474xY8E/iuMKEE0JDgNIFc02dq/BlubFMVU6EsL85Ok/T/PpCRUMOlOxrMd9XnoiTPp38qla6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720687488; c=relaxed/simple;
	bh=f7TRHfNvwagNjQn0+Bm9Bf2LxyKqZlmh+fsFQb0vzrw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s0zEV6Mj1dd53rZHsc6xgfZmwIYM4/YcFa7843Y9Gp+Fq246Bk/XXdWfy80cOXtg7JTN1bxOsrPCMfJbovF8aJ79cmGJCqyHG+o+6c6y2/2tnPFvXXZwHo0jGu0ckkBdCCGhR78NNrhOWc4Cj8ClQDuQFLGEqcqD8TGzHiztXTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=ILQLNCf9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="ILQLNCf9"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42795086628so4011635e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720687485; x=1721292285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w84xl8Y3F0+wt7yk4xgIfVPoRjH+R3/bz+ZyGkK2r0A=;
        b=ILQLNCf9/6nea/52t0SJ29HeWQwCUluCsqKd/Frrb5mTjpmay2MMGuK+uJUhSZixHe
         rjyQ7TYiL5jyITV81dkFja2pY97dDvHg4N2hY9Xi3B4fiXTuv+0be/dyJG2+ivqB2KwY
         2rKChyh6lUwHW4E98/x2ZnwxW4PDz4A8ndbGof8XKYzXHYjmdvIivZq+/qV6F8qbyO1p
         T76CIOixUjLaMksq01BrZGdT4nB9SwjL0b42/VyCNAbLeVV+YPFKZVH9G17Z8XM73Qrx
         HwkTpDTeWuYFDQLfI7r+lhPuapeqnXvPrLJhAbyzZzyhHTyMHdL06aNLH7zld/OIOKQp
         iIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720687485; x=1721292285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w84xl8Y3F0+wt7yk4xgIfVPoRjH+R3/bz+ZyGkK2r0A=;
        b=v0c72XeYbJUKw+jPpHZvIBdGqesbmgImLrrdDtMFHZPK3V4l/6BJEwNyNkXHX/cNrP
         3/nyCkLzOHoC0XSR6SRRXGHTmItXSlHKJmy8IIsy7ZUKtpHmGMuZrlvZfQGU+sBJejW3
         0gcY712714f7/xCCAupqBEmQLz7lr12nXyytctoNifNRANELjKXdy3XwDIB8YbkPoMCf
         YUMVTGOKjcrI2Aw0csvKcaRKjrhv6MYy0XrXVARg02nHbbOnLmHWuXdhM2yL+hGmirV4
         kpYv5R8uOkpC/cPlEtbTZpIvkaCwd3+DqAD87Hy2PMWyDn/wsjVMb/qlK7ALhy/K4tg5
         fCHg==
X-Forwarded-Encrypted: i=1; AJvYcCVM0/QsGU3fVqkG9NwRrna3uU98Eld7r9oADuRCxXzZAeDBoJ8ess30/liY50e8MamB22hj/k5b0cItosGSalYQhu6PAT74VDl0/3cMaMEykH9e
X-Gm-Message-State: AOJu0Yx1+xGER909adlz46ETkiNPzsvie/JsuYpADZX/z2UqREpW02tI
	EdL3LleNCxoBqFyvTXef6Oy/HwNuVKsS55TlsvYcqxoMOjQkq7JOZ8sKBC7naPM=
X-Google-Smtp-Source: AGHT+IHcsX/3ApNweLCTUuqlWjawC95PiiJXDRaEgg1sHRt80HO87mQkMY3yMCRJPOsQAy/2J/uo2Q==
X-Received: by 2002:a5d:58fb:0:b0:367:8875:dd4c with SMTP id ffacd0b85a97d-367cea7368dmr4449606f8f.23.1720687484600;
        Thu, 11 Jul 2024 01:44:44 -0700 (PDT)
Received: from debian.fritz.box. (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa06desm7221511f8f.76.2024.07.11.01.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 01:44:44 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: akpm@linux-foundation.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH v2] bootconfig: Remove duplicate included header file linux/bootconfig.h
Date: Thu, 11 Jul 2024 10:43:16 +0200
Message-Id: <20240711084315.1507-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
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

Move the comment to the top and delete the now empty #else block.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Move comment and delete #else as suggested by Masami Hiramatsu
- Link to v1: https://lore.kernel.org/linux-kernel/20240711002152.800028-2-thorsten.blum@toblux.com/
---
 lib/bootconfig.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 97f8911ea339..81f29c29f47b 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -4,8 +4,16 @@
  * Masami Hiramatsu <mhiramat@kernel.org>
  */
 
-#ifdef __KERNEL__
+/*
+ * NOTE: This is only for tools/bootconfig, because tools/bootconfig will
+ * run the parser sanity test.
+ * This does NOT mean lib/bootconfig.c is available in the user space.
+ * However, if you change this file, please make sure the tools/bootconfig
+ * has no issue on building and running.
+ */
 #include <linux/bootconfig.h>
+
+#ifdef __KERNEL__
 #include <linux/bug.h>
 #include <linux/ctype.h>
 #include <linux/errno.h>
@@ -24,16 +32,6 @@ const char * __init xbc_get_embedded_bootconfig(size_t *size)
 	return (*size) ? embedded_bootconfig_data : NULL;
 }
 #endif
-
-#else /* !__KERNEL__ */
-/*
- * NOTE: This is only for tools/bootconfig, because tools/bootconfig will
- * run the parser sanity test.
- * This does NOT mean lib/bootconfig.c is available in the user space.
- * However, if you change this file, please make sure the tools/bootconfig
- * has no issue on building and running.
- */
-#include <linux/bootconfig.h>
 #endif
 
 /*
-- 
2.39.2

