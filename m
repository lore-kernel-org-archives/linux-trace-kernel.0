Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA2D233128;
	Fri, 18 Apr 2025 22:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745014514; cv=none; b=c5oXpBcWooGsgvRAaVvwR3hz8QL1/ApnpAl9xkla/GeXRDQhShGOw7dj6CO4gTof/KYq5VHLFoJxptxqASb8u1SEjiPF7peAsExijovGEMlGtNPPSFX2SDtAYgWtEaLLLz5EToQS53waSI6ZPRuv9+YoyOBtPbeDmBvkeoKBPns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745014514; c=relaxed/simple;
	bh=MDBxHsJCkRfwaYkN4xwKGOxP9+1Gn8TJMJCH3XDi0T0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MO56RV7XUNZeeT3okJdGnrZjrasB+IR4LewPjRzbSjuQge+EI2XC8bSLCgcdVvxPC/NygnOXUp6H8UnweB0H1Y3mNq5CiLKVYXtVeSIC8aajeKARe/Q4IzFt/RkzRrgQUPExY9IfV671ioVAetBT9UWI6zsVX0eRa+P15VcwOsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZ0UBZDh; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZ0UBZDh"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-73972a54919so1983253b3a.3;
        Fri, 18 Apr 2025 15:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745014512; x=1745619312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SvuW99/2oNvthIJgT8GkH4cc6GT8kdWdVq16cR06I+0=;
        b=WZ0UBZDhRfkD1b0YZZ0iU5Zby8LJqad4nEVEBbny49lShzzTM/hgGqeOX51oyWcQIx
         iOFJwFsTOiSGKwaFLblL6IMifURrms05X8UQFZ97w49a3ZIO2yUCdsCuHElu5Dcb8dxZ
         SSc1OYZXav1/HYdkV3x7ePUuYGO8/3f1ZXJ2waYW+TUq2y/7Ujr7bUrLfg/gZYfxJetv
         nxG7GR1Vos77F8K1KAhN5sa3bz9XIkx5ty3CnClIxLfwOY9J3rYSNrlgaQUVK35kRRYH
         /1v92Ix9zGWgfZzFkiLWxRFmtCGmcjQaMR8Dn66tB1ILUjIxqK0asITm816eThsicrkr
         pnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745014512; x=1745619312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SvuW99/2oNvthIJgT8GkH4cc6GT8kdWdVq16cR06I+0=;
        b=iAfx7qVIn4fBwyVeDWBvG48BxaIQwRJXSunv7d+v2hmKYL0P3omTpUXLvFiT1TFKuR
         Jpu9EH8bGWHUG87Y8FWll3a84dZPVfIjaYw69HQXexJhc+Y1Cgj8+aJwGVCuzUr9UoYd
         83wY6w7fQVYbYqZAeqkl5jijGqY+ChdFSPWsxwiatQ9CY+EQPt6bEb+8YEhUCoGcuKRa
         0at9o9pV961OqhqKl7k/1bnfQpg9XIM4k11fKBZkB6ygyhszKWQfO5mTizz+AbgWKDM8
         gKiz/+RUfa/5N5t13qoss/s8RPqtmNXdC0o5ziAH8BPorJlsnraCN9x++DKrt4oco34Y
         k3Og==
X-Forwarded-Encrypted: i=1; AJvYcCWi1T8IKfuhhZJhvMx6d0132pFce9aIakyHIAsRJh1x/7skWCBf6A29+ptcJ1K+hroYuaa5hAiEmIPto3fiM82Y1th9@vger.kernel.org, AJvYcCXQCn33pp1kTaCNfkFe1fkLi0ygmkPhSg00pJ6j7yl4ADEiE3ya78n+dKM2RtAHVVLYWDsMraphNTf0Ah0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCokuiYg1uJuH2X3cHpW0Q/27dDY4Uw39CBdnr+iK+5gT3DWiR
	4evkkBtGf8arSznlwfsGtH3GYBdPtLBzaLZMf2RiVAFI5IFic2ic1CoT9SK/C+8=
X-Gm-Gg: ASbGnct65sMGX/fChbWMSQ0x9WLqxprBaEBTw/I6LtYfHpRxSwZRpjNTaU923iV8+Hh
	t9Jscd5l+CZpo3PSdunmQPHxFrjB4Mtvf9Mtk01LwP8l0z9p4HCLOeWDJmwiY+5KC0b+ThfrupP
	gHCwrFK8ZWJ5XiJ137qs3DFCW5OmiMlU/p9bJ8b+nngzqW9a56bnuCqlyyJ8PChym3YVqyKG0Lc
	agl0/9o1KgdqcBMudZzBtiaQqCW2mKcOtdndVqPQBGVoTXCseJCFRkbDcQfUkoUU+fQsxy4T8Nn
	Sj8McUmfnFvNEumChTz1m8JNBcWDtjWSsok67/UB
X-Google-Smtp-Source: AGHT+IGJ4CYpI2OHYR0RVZJ8yOR76RsDFeBV5X07FEPK/XxIkWSq2ein7aEwe5oJolKQY3P1d1Q9Eg==
X-Received: by 2002:a05:6a20:9e48:b0:1f5:7007:9eb8 with SMTP id adf61e73a8af0-203cbc55934mr5974149637.16.1745014511665;
        Fri, 18 Apr 2025 15:15:11 -0700 (PDT)
Received: from fedora.nitk.ac.in ([2a09:bac5:3d50:1a46::29e:5f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db13a3396sm1873880a12.28.2025.04.18.15.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 15:15:11 -0700 (PDT)
From: Devaansh Kumar <devaanshk840@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: Devaansh Kumar <devaanshk840@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v4] tracing: Replace deprecated strncpy() with strscpy() for stack_trace_filter_buf
Date: Sat, 19 Apr 2025 03:44:41 +0530
Message-ID: <20250418221443.1067938-1-devaanshk840@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strncpy() is deprecated for NUL-terminated destination buffers and must
be replaced by strscpy().

See issue: https://github.com/KSPP/linux/issues/90

Signed-off-by: Devaansh Kumar <devaanshk840@gmail.com>
---
 kernel/trace/trace_stack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 14c6f272c4d8..0f2253f3bc8c 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -542,7 +542,7 @@ static __init int enable_stacktrace(char *str)
 	int len;
 
 	if ((len = str_has_prefix(str, "_filter=")))
-		strncpy(stack_trace_filter_buf, str + len, COMMAND_LINE_SIZE);
+		strscpy(stack_trace_filter_buf, str + len, sizeof(stack_trace_filter_buf));
 
 	stack_tracer_enabled = 1;
 	return 1;
-- 
2.49.0

