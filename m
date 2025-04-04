Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE7E1F03CD;
	Fri,  4 Apr 2025 13:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743773491; cv=none; b=WUvc8t+ZpNG02kA8TbitDCcT1FxFRct/dC2S1yCjlWDM9+yXnd7tgocapajTNjWIgxUQA9fIpTfkxdh2PkNYcZ9dlXe6wXH3tuI2+6nd/zhPdYPD64pXVZGrYYBnDkKULmGq/xK6CK143zRHa2gER70nEhJxSwtBqSzS27GNlWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743773491; c=relaxed/simple;
	bh=Mrb3uEmlv4xl8tkAfjJDSVDkM8xtCLnQRyTNFJMkSWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eMeAucbhUKmXtkzC2Nn2xo/xszbfDq8LuyE3DK17p15+KXaxEyJnxCAdrXOBhP7vSrhjqc2CfP8itUCDbgd0tnT7XxEPfyR9FdsYcPZye7jSJ7NejwS+swJCtEyu9tJcXnFISbEf8vH0SXgWD7+rK7gYGvocNSxADhJLCzv4i/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3tinM7N; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3tinM7N"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2295d78b433so20177825ad.2;
        Fri, 04 Apr 2025 06:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743773489; x=1744378289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zmk7AQJnJtbdOsTE+xjJik8mWDejJLeip88wYD329cw=;
        b=S3tinM7NJZ72mV6OlM2B7Bko6aiwa/lmCwQor5GsHO4d66VYJizQB+63KPl6Ujq486
         KO0ANR3nd98zW1G+pWM/rzWJ+X4zC6yzxy9BjjaOpY82Aa+xgN+pRwlJBkgCE8LU7Asp
         0BjRS6ZMy5nceNZb7nSI/xRVU5COouvQhSn3qtDDXAXq47sX8eC+uWthqi9gbjr57FFc
         GH9mlAz5aooY/vvIPmDt3exDLlLcUakWW8U0uOkzK4T5+MbonWas+meiqJoKw7GewKze
         4wPtAH82MHRpgrsbKiGEbPab5BP1Q8/kMxNjgQTNQeTOQzBBK9eq2lvitLOGU6dGQvm2
         CMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743773489; x=1744378289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmk7AQJnJtbdOsTE+xjJik8mWDejJLeip88wYD329cw=;
        b=RHPeVRouLxkEd8p2tXkuJMjr2zrUpzMjDtcyoDBrncZF/9ZR6ecYvMVohJEPhEMp0L
         BCS5MMqCnCIwK/pWKKbxzyjkLT5sOjjDxisBcHG6ATf763yzvFoGtCWKVkw6bLI61f/r
         kq8+M8d0TT38exUORVMkRFRfrqgGIMfHubSOTki9G4phApux7AQrH3H+/S2RxJ+gWwdU
         X2xZybX9SaRbtxGjHhGJeBJaqYCwz7aioBPBPUGL/ZBjyprcM1nzXOQh9qEayxheKpjm
         diLBxaXlFqx6FynacvluhblRksQvuOa6JYellglEZeVqtEB+B1m9W3jNrWnzqklSPuMi
         tGPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2N029mTvsUZOqezGby1CNP7VrX9n3BFK52ysuLMRXgB7kkGQNUru57I4izTphgK/rDZumCa6z86FEtsE=@vger.kernel.org, AJvYcCV45sEiAW8R+8KS4ZHJFo+UpHlWGhXCQREsm6XVLKS4yMo3O1jRrh9/MH6cCH7C3nY4fQinviLpCgk7X2/No3hWKfu6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0giN3L2wE/dc4oKJHXAT8r05SQ3oH2cZ3xErZX79tzXaCqtlN
	CD354Osk0SAroJIAGn4W1DX6x6fYIF4Ff/jvzumct/BG11SESqh9
X-Gm-Gg: ASbGnctan3+yHszcez7AcuX6CppI0AxrI/7+EX10mR3esXEKIvm5wxhsSU6wxl5dLvf
	MQ9wGITXfZ9VjEn7GExzQKn9uZJ3VLrgXdc1L8S7YJclqeiZVVCEE87dgc4Dh1gV1E9SFuRKaYU
	X7Fhhzq+/rTAfVobjF7IHRVt9/AizHAaroFdeMaHHo+neQcgAK+ynNgJxqKgI3icVp2q12jmqLh
	ZNM9B2vwst8OTgbhLFAW3T10eru7JwPtGeAXVsRtdE1Y2KzsekIjBgICfa1LmatyH00bauFLb4f
	5lMlb4Rqb7HSkSv540ERYbwZR9uSel7KVbDkSlVlq6yq
X-Google-Smtp-Source: AGHT+IHHjJCFcl1Uoof7R+Oq2QP1pTkGPta9Ksu7QNpbZo2s53FaqTO/vWbI7tuL49zRDu2mYg/0dw==
X-Received: by 2002:a17:902:f70d:b0:224:1221:1ab4 with SMTP id d9443c01a7336-22a8a05866cmr51137215ad.22.1743773489062;
        Fri, 04 Apr 2025 06:31:29 -0700 (PDT)
Received: from fedora.nitk.ac.in ([2a09:bac5:3d57:1a46::29e:13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22978772746sm31684035ad.223.2025.04.04.06.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 06:31:28 -0700 (PDT)
From: Devaansh Kumar <devaanshk840@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: Devaansh Kumar <devaanshk840@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] tracing: Replace deprecated strncpy() with strscpy() for stack_trace_filter_buf
Date: Fri,  4 Apr 2025 19:01:03 +0530
Message-ID: <20250404133105.2660762-1-devaanshk840@gmail.com>
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
 kernel/trace/trace_stack.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 5a48dba912ea..982b1c88fce2 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2008 Steven Rostedt <srostedt@redhat.com>
  *
  */
+#include <linux/string.h>
 #include <linux/sched/task_stack.h>
 #include <linux/stacktrace.h>
 #include <linux/security.h>
@@ -543,8 +544,10 @@ static __init int enable_stacktrace(char *str)
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

