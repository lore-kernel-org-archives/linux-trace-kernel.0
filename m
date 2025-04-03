Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A737294168;
	Thu,  3 Apr 2025 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707667; cv=none; b=E0+dYmKRTcNNbJO31urjn/tDi4VvGpOaIMUsLFZtp9JnATbOIvD9EyAXYNoWJU7yp87pkaRA7Ta71qr2+YYvwpa0H6h99agD0useR3kLz6S7GzAnSjG3ZzbaDPk1l9faWdTEZPbjz27Fozj4GQ4S1dSxbYaT5fXHc2MLq4t3RUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707667; c=relaxed/simple;
	bh=+pVrgwwEflxcv+fXpPVFmGLi+zNgmw2gau0oY0qWYyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IgbziKmLgyFb8NR90iR00qoUcvVTuGMuMugx5JSzkcc/+vs1ko+5oCzzG+CGMSbf/OMAPWWXqAc7SSEffphA/QKluPNvPwcIlyrVub/eGcdivM9JfCSDnCZUL3qgiNA+kVdaIjjFhiZqbFla5sGysGHkYNwRwspiCr4Q+FCGaRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+HmK8oH; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+HmK8oH"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7376dd56f60so977213b3a.3;
        Thu, 03 Apr 2025 12:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743707665; x=1744312465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gRKzwJn+fllmtT/MCA+wLN8UzmoZF5DrIH265Xusm4A=;
        b=E+HmK8oHmZhU0Al9+c1XLpA7NTsovJ9BNGfHzZpp1aajaZJtIgsMLGBpKYETo9r00y
         0BRHc3AcOwzid1+mQnr49l/9k2bLEVaC+oMT4Mt7sUGj5FU0nqRI8EfMo6zpozRUvK61
         +5uE0wxzEiptUStSCB3fttO4Y4b3lvrcjgAUd5cNE4SUQJqCxlzy9VeTO1X6aZsAczqv
         Kt/wUJShDGTCnhQ/Iimj1Wx/7PdSIobvitwgvvoOYvIB9lcfEk2VcUwDKA1O4yp8fB5t
         yqPQSyNC6apMGt2R5KQADa7+KzwDVUhuSmvvmU/rdE5gluc8HrUSJgfs13zNTPDXPTvu
         fXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743707665; x=1744312465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRKzwJn+fllmtT/MCA+wLN8UzmoZF5DrIH265Xusm4A=;
        b=KySKLg8TUzDSC5J32kRioprG3eYLjw2AZ51YdN1nYd5JgttYj1sABvosOU8X/pRbmT
         TIk085l43jh9ywkkukD2rm0bLzIWtxF04cp0DlUpVXCBfxaaTiw0y0uoKGf7x5QDd/Cz
         0r6oJfQONWNM537F/O9hXjlCR56gWOkeHwxKfkue5XiL+go1OCsyh3SvsFHOq5OmTSNH
         wgnnUUp+GfILtacZ8tXN5nnYBN+6LO9Ytcc2HQVDrFAgEvcu9DLxGgM31bTMG9UOcMJ8
         CePT8kyeM7TJUr0tEjZCxpQ1NJPXjz5615/byRf9sgiL+NSJ+Gy7vc4yWGQx2VR9dwPj
         wZ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIDH5ibWZwkHUNjVx3L+sOU8V3BNwAyfpw88nQgJ01MIsf9xuBUIjSUc8iXrwZPeepBV+zoazTdcL92vmbNkyCTsSC@vger.kernel.org, AJvYcCWU5ehUWqc98iSYcPkLgJ9xci9KfUKgrTnUdN4IhERbWTrg14pfQMOKwOf6vD8sc4UTBeZLgO1wHvPu79o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfybiGQaSS+jtlhlONlhv+ITDrmICdrhNefubF+LY8OyzdO3AT
	OhcFijE8jXxjeXL2EjbkxJMxCpVmV8f0543Uee0gBV+TxkG+fhlI
X-Gm-Gg: ASbGnctmOBgrRTHHzRu5GZkHA7akQDTQdbcZ9lKMfBu6B3HgrkEzIgcHYYtyh/jldg4
	hPm1t8bPuOKlhnKrtES5eGtlLgqzEsnFLT6YBKC43CtcQRun0YY+LJmBz52Xxy3fhMXTFgfgY6p
	TLbGfo76GND2ydn8QVoIaIFA2ZU91RSU+QcMatoBYsnGzuf8cp//30rSK4MOdLHmCPXRa68Nfqj
	KxI+f8WxqFsU0//DC+Q/f/pWV2fm9yJtjhD05ogjnQG49WTt4SHFPDtnMDzmIKf8K9sAHRHZA3s
	sW4VIOxnKIwXmV0zaSExSu2GVSg2hDNYRzbOnJsaDQ5b+iYaOhWjgqlHHg==
X-Google-Smtp-Source: AGHT+IFr6ysq7gCQ8c6HOaSVn89IPRNEU7Nny10SY01fQus6+wqmBy1OpmOciwDWpGwWzJg/CoTjJg==
X-Received: by 2002:a05:6a20:4312:b0:1fe:5921:44f2 with SMTP id adf61e73a8af0-2010462869cmr733614637.20.1743707665493;
        Thu, 03 Apr 2025 12:14:25 -0700 (PDT)
Received: from fedora.nitk.ac.in ([223.186.209.127])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc351371sm1583046a12.40.2025.04.03.12.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 12:14:24 -0700 (PDT)
From: Devaansh Kumar <devaanshk840@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: Devaansh Kumar <devaanshk840@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] tracing: Replace deprecated strncpy() with memcpy() for stack_trace_filter_buf
Date: Fri,  4 Apr 2025 00:43:40 +0530
Message-ID: <20250403191342.1244863-1-devaanshk840@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strncpy() is deprecated for NUL-terminated destination buffers and must
be replaced by memcpy() for length bounded buffers.

See issue: https://github.com/KSPP/linux/issues/90

Signed-off-by: Devaansh Kumar <devaanshk840@gmail.com>
---
 kernel/trace/trace_stack.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 5a48dba912ea..427526fd2afd 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2008 Steven Rostedt <srostedt@redhat.com>
  *
  */
+#include <linux/compiler_attributes.h>
 #include <linux/sched/task_stack.h>
 #include <linux/stacktrace.h>
 #include <linux/security.h>
@@ -537,14 +538,16 @@ stack_trace_sysctl(struct ctl_table *table, int write, void *buffer,
 	return ret;
 }
 
-static char stack_trace_filter_buf[COMMAND_LINE_SIZE+1] __initdata;
+static char stack_trace_filter_buf[COMMAND_LINE_SIZE+1] __initdata __nonstring;
 
 static __init int enable_stacktrace(char *str)
 {
 	int len;
 
-	if ((len = str_has_prefix(str, "_filter=")))
-		strncpy(stack_trace_filter_buf, str + len, COMMAND_LINE_SIZE);
+	len = str_has_prefix(str, "_filter=");
+
+	if (len)
+		memcpy(stack_trace_filter_buf, str + len, sizeof(stack_trace_filter_buf));
 
 	stack_tracer_enabled = 1;
 	return 1;
-- 
2.47.1

