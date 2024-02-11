Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CA93C2C
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Feb 2024 22:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707691404; cv=none; b=mAyShmxonNUlR2TH4H3cw2QGh/XlbUIJt0L3aoQ9DVeUc9fbewK7HVSZfZ0ugLQ1PmSnoTyTX+/CnCqRIdnKCBZ12CqkF7Lt4QNr1DRRKembawNK4z/3+eNBvq5A6aaJNvhAqAxm32PF8mC+Eyr3QJfNAnWLygTgalSaRUOedf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707691404; c=relaxed/simple;
	bh=vH5zUWq2bx6dQW4vfZYSuRe8aVXk2pfKniPKqPuO358=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qT3n+r6c29hDfCf3/xxB/tpbaMF0uIThu9W6IbRLrSY9bcOQiS1kIA1YPsYL+6Pj69ZV8ndOEGnf8iY/PUOWY9Xrub0JUFAnc7ocT4jgIBcSETcEtFp/ZMt52XTy2+LrzcuvXY+UdEDHAUdskC7FrTUxSQgJUhKqsi+NtgAGLDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XzwGrRYB; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XzwGrRYB"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a28a6cef709so350140966b.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Feb 2024 14:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707691400; x=1708296200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bjFoTus7aHlrnOcOuTAWCgZWdvA6SJu+L7BLRl44mJ4=;
        b=XzwGrRYB4wgrdtQVHY5xX1gmGzqgxYdBbYfbzqQhvXkCm0J/eiDscC0FQdiLMEcoyN
         xf3f7ffeMf42ZBRCIzQGhFrIqNFJriSP8DTRjRKvgS+j8N0qblrGp6360bNHCpeo8Gmc
         MSqV7wvSAVwNGBQBlS/Y1ipmz9/E/o+l7gA4ozerlUh4mTNE1dGKh28pnGeaIog3ngyu
         2fTAI5Oo1pGDmW5jecWj3oi+r1uvzKjEoB8C+mz6+CRQmFWm1ITT7NWPey7nBKM//TgF
         n8l3ckrZfMqa3L8lWOch0M++KM0cYDLo+QFXj7TSvchlQRMvZxNoCf592pG0KnBaHVoV
         nFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707691400; x=1708296200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjFoTus7aHlrnOcOuTAWCgZWdvA6SJu+L7BLRl44mJ4=;
        b=e9hFj5deZ6CSv9uKzvzndM18itIcw8dpQV+1dPellaFsKtWVVz59FAi/2p6c50WRbl
         ysFbwE1kvdPSo3B8AmrZmlJzO8h5ATlx6JTqC8byYqyS9ea2cNNbt/0Wvw89imxBurIG
         kdiyPFnPM8pl3yWlVQSi/GrJjbD1v5cgNKOcSS2VVr8p/7iDaWIt3uLwCfGFFdZqIfiu
         0Hk2xLKdlH2xLzrpU5UAYCNMcEN64CioLf2lqICYbTc8/wr5KHNIVGWdhf+qx82+nBhm
         QaM31W8bbpNGkh13VqTvzBNQsXRQR8OgSg1B8tMmQi+zs5MoUh08JEHYuluvfxyImn8h
         g7EQ==
X-Gm-Message-State: AOJu0YwBfuwHLxYuNYKYjn8Y27KmthYE081zGhnYNkAlj0Yu2aOVMfVJ
	W600ycdlRIOtY7Jk8U/3nklvZB7pW6+F+QxKOdVBX3KZV0qFbferNrUq5Cx3S4o=
X-Google-Smtp-Source: AGHT+IF/LQAiygCy1X2jwyJTPhn1e+uYExYY761RJQwyXq1F0mNIQlwA82dukr6G4OSCdbXkY491HQ==
X-Received: by 2002:a17:906:7f8a:b0:a38:4879:72f9 with SMTP id f10-20020a1709067f8a00b00a38487972f9mr3948919ejr.24.1707691400547;
        Sun, 11 Feb 2024 14:43:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtkTht4pynUiAjFuubCUmY6w2q1SDAomrzS74tMB+us6WxH+jvbhOHWUNcrWMoEl5L6T55EfIgeLoXTWNKIlhYxr9Azsf4uiaYvVR0jG2UYSJFwNC53+sU4Mb9JCe/fX5SgZ0iM9y9BJX3hSLh6HTvEqrXDhnZY6lExzdV7s8jIHcuvCCKuG67bCDx3nmBH3OuRXj8OUpxJzEKKWMdgfkfHIGL+kY6VJS2t6LOasRut1XGmG8ZWm/H9pdGeBNsH2C0ZWGQZm8dOABjP7/+vv/lSJAW2MSWurvNReMFQoeTJ1fUgn9eVo4ou7kQKvt8tQ==
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id g25-20020a1709061c9900b00a3bb2156f7asm3252608ejh.185.2024.02.11.14.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 14:43:20 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	linux-trace-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] parisc/ftrace: add missing CONFIG_DYNAMIC_FTRACE check
Date: Sun, 11 Feb 2024 23:43:14 +0100
Message-Id: <20240211224314.169314-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes a bug revealed by -Wmissing-prototypes when
CONFIG_FUNCTION_GRAPH_TRACER is enabled but not CONFIG_DYNAMIC_FTRACE:

 arch/parisc/kernel/ftrace.c:82:5: error: no previous prototype for 'ftrace_enable_ftrace_graph_caller' [-Werror=missing-prototypes]
    82 | int ftrace_enable_ftrace_graph_caller(void)
       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 arch/parisc/kernel/ftrace.c:88:5: error: no previous prototype for 'ftrace_disable_ftrace_graph_caller' [-Werror=missing-prototypes]
    88 | int ftrace_disable_ftrace_graph_caller(void)
       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/parisc/kernel/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
index d1defb9ede70..621a4b386ae4 100644
--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -78,7 +78,7 @@ asmlinkage void notrace __hot ftrace_function_trampoline(unsigned long parent,
 #endif
 }
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#if defined(CONFIG_DYNAMIC_FTRACE) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
 int ftrace_enable_ftrace_graph_caller(void)
 {
 	static_key_enable(&ftrace_graph_enable.key);
-- 
2.39.2

