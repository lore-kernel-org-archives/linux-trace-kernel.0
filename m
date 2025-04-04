Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8838D1F152A;
	Fri,  4 Apr 2025 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743775139; cv=none; b=PSElgdbSEoeCgc56osHE2dVHCRivYYruAWEFp6Itlfdj7gElWkrzH17s1Ie5AJH51KuF3RlC1ea4zLaTcMMz4fcFNy2pIYoG9YZFYsZKBkU/bmZfAVKDxWKI2C3Gvl/RYt+wONBaQDr7ZSoZf0uE72fNSYoUiBbWgG9Jznu78fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743775139; c=relaxed/simple;
	bh=wY7QFYszUZqAqrffU5tFA/55H4+x7FwsNaqOaEv5AQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GxNTc9m0zXNfhCqQc3jZxb8y1/5Cv4lTyLmaQL2VTsXMGqL9Cd4Z5E/cJUoHvjNuRsaoCabvXd+Ut/P55hbGVKzxyYpWc/85fJZrNzXzwHvhzDouu3bEtL/VcsSmngh2awOe6bZcaFO0pZZtUpCOOKqqbx8WDVaThriRkXXmwUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+2x1Syf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+2x1Syf"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-227c7e57da2so18794395ad.0;
        Fri, 04 Apr 2025 06:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743775137; x=1744379937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i+22pb/5kX4VZbzUzM3FZvO9kkRimVVfJb44Id6IWBA=;
        b=k+2x1SyfnhfDyVjJSwEC/eOstR/6F4qnffRMRhRea8KdfQXb76fazUWEiQKzgATI6Y
         OgwXPay9oCc7iO1/QP6tB7qzmDwzpDYzBnoD1o8Y8T153NknS8g0/Mml8OISF/uRjQhI
         ZHSOwMspagQ6aVqEowoHINuCgE2fp0AHiPBxgc0poZgACKF0gTQuMBTpVro8gqbI8uWD
         iy9vh82Z1uOULqaTSaPJ1tgz4X7H4ekE+2+sUAuh3RWj3kpNM8OkJ6jAvyVBsorpaAyH
         ZJLXasU//x5naLx3PU4RLU7YiXhrlMOirzOvC8Cfen/A8xocubn2qr/1RplgOLh1umQm
         2jkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743775137; x=1744379937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+22pb/5kX4VZbzUzM3FZvO9kkRimVVfJb44Id6IWBA=;
        b=Ksd4rJyCjo8lub9swFZfeGc/2fbgsse+UNVzGtlGCR3whn0U1kQpGSyEsSKMf683GP
         iY2bGfpqr5U+wyMurMuv28fdpjvcVCeiI7szMumrU0RNdm4C6xcxT6WiLaxccaOpOlUY
         X3HTxiYPEZGfAM64WhX0isE9RSZF/7subjhe4uuUkl66gqHGEj96WtYRtTL9NG6/YskD
         nhJEu/NDlsskaneJPilquE/kGqartqjy18jUSV3eXuLqORVMjFh+h5YPetVR8taoOG/Y
         TCbhVBsTs5ao6RB7zhtBTInsOthtit+lbdGKurGf6emwSKpGFI2kvKNM8jCZFn5BLDvh
         n+5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUZzHFHbR1JnEwHL9cpgI/PBAIFvnl7cjITg4mC+WhES96SkxLzeQpd0jJFpUS9HxAbEo6ajebJhNE4L4=@vger.kernel.org, AJvYcCVioJLFXnOfG+fWNScJN65CPliffq9rl1dSmQEimL38MwqcmKeFmk5450giu8KwGrYz3SJgMUFvMZ294TOJJEvO+OVq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+lg9MWnsh+w0To9y/q/qbbqKoJ64M0s43OzUT8OcuXJttE7pM
	BINlfybPP8H7DJhxxWzrphcqyfVo6Z3XoJHoeo9bHA9dLcQDlHshmL/hY5/ewF0=
X-Gm-Gg: ASbGncsQlvaJG2OsPNmU/pwmuMTegrvo7V38L5OiErkftV7mFVmJzEDal4N9sX0js2D
	CnbtN9cmsVaYJ99r+xLHnya8b9mQFTCN6a+RhLw5KexZCZtp4w42VciQjzlZmfUS1eIWhC8MTj6
	3H+WPXtdenQag3sVBNPh0ItI2bx8R4XNl9Ly46ZpUgiYZcfnm9ECGihNRIEAGralHBC6KQqXItR
	ZoT8wR0/fb2I+Tbzteg1MbVP8F/mSYrQ/5GFG2pYAlchP7P5rHoiupn82jf1+CRCi6P13H34R5D
	F6aI2Vfr4vtBctCC9/VhREFX4pt0sI+FhwPYoeai3+qC
X-Google-Smtp-Source: AGHT+IE+VkMoP417Cvfg7Y9+D6iW+RnfAkURu6MIGusQ25BUD9Tb8oyyLz5nyG2gKp66aokvYXVQZQ==
X-Received: by 2002:a17:903:230f:b0:224:d72:920d with SMTP id d9443c01a7336-22a8a0a3622mr45507425ad.37.1743775136825;
        Fri, 04 Apr 2025 06:58:56 -0700 (PDT)
Received: from fedora.nitk.ac.in ([2a09:bac5:3d57:1a46::29e:13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785c01cdsm32386895ad.99.2025.04.04.06.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 06:58:56 -0700 (PDT)
From: Devaansh Kumar <devaanshk840@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: Devaansh Kumar <devaanshk840@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3] tracing: Replace deprecated strncpy() with strscpy() for stack_trace_filter_buf
Date: Fri,  4 Apr 2025 19:28:48 +0530
Message-ID: <20250404135850.2695211-1-devaanshk840@gmail.com>
X-Mailer: git-send-email 2.47.1
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
 kernel/trace/trace_stack.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 5a48dba912ea..91ed2b76fa4c 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -543,8 +543,10 @@ static __init int enable_stacktrace(char *str)
 {
 	int len;
 
-	if ((len = str_has_prefix(str, "_filter=")))
-		strncpy(stack_trace_filter_buf, str + len, COMMAND_LINE_SIZE);
+	len = str_has_prefix(str, "_filter=");
+
+	if (len)
+		strscpy(stack_trace_filter_buf, str + len, sizeof(stack_trace_filter_buf));
 
 	stack_tracer_enabled = 1;
 	return 1;
-- 
2.47.1

