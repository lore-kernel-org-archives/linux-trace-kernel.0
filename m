Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E54202C31
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446829; cv=none; b=twW5bu8uelXoG5JtS3ZinxNAkfbK+DhflHmZElCQnJSKtR2goDqO7eISzfz12bFCCJk4R2DyCUog2pClCmlSlHA7MPpIcdOLdet7duD1BZlooktHQ93R2Y85RSqYjGiO2g7LO/q1BsrnEekXAh3hKXmuJ3iN8tYgwWdPIxXhKpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446829; c=relaxed/simple;
	bh=IVLJaP7y85E4WtX5gToK00r9Vz21qTm//oF7hPUjSdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EvJo5h8WzEVARt5ajTsD2x9IK2RwjloJA1xbXlO9Z1KiPW2KzBOHGWcalc2WzTQq96rbTlcX3BNvIuKvIaJ2PqEcmxq4Oa7LkmVhjtAFJFYz/1r+GWFt0rKuj0qMTnIqSpqjD6A/nuMl5gb0Q8nCoj+dbAdczBUrZGVZplSrRDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJ/2y1P3; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJ/2y1P3"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so1545667a91.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Feb 2025 03:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739446827; x=1740051627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xvwypYd5sFaAmS541tFZjfvSCvH99VWUYE6W7BfyIOo=;
        b=kJ/2y1P3ZXE9gNfjA3O+2X0vpYQbrrKpzFIB91cCYY4HetU0z00APmrVOGvRj6F8xY
         TGAqneBNgjjatiIOlbMgl7x/j/UhWKJXt4u2b9If+E3JpMYylD5Iy0a1CQkUvQ8puBZn
         Xyj5Th1cQ0UaTuRYcWj2AjiJS5AEqSecVogH2DvK6fzYp8lOKGBa6XD3hxFzYvfSQs9O
         ZbVgwbDHOYuP0pd5KIpvxYQzEhAYmECViPd76GKWi6BSDJuvERxaOZ6Ln/2WZa/EZt/y
         TGkUgDr9vo+2MdsNArAxLsrlvrgR2+HOuD8CuXjUC41budIatFoASFyQ8k4MKZQuE5Qu
         m3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739446827; x=1740051627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvwypYd5sFaAmS541tFZjfvSCvH99VWUYE6W7BfyIOo=;
        b=Waq1GSraAFxmNyLh29zsbd1C/zU6hAiSjrUfNhZjKWntO6s78kaE4E3mlkcwDAXlHa
         x9cIEFTCWICIS/vuDnRFMnRqacPwWPwPWYoFaXjuoPS67lOsC/RGLsz2RGrgSPvAskTh
         e+guk0Q9jw/5GfPGyeWJnX1gY92yjNn7NuoFUZMH/z0pdMFFrVwU1vY5gcepAfGNV2S/
         qwLMG3zmfhWvrzFt/wBmkNK4fcfajt0inE7rM536R0Z7yRh8FKDGvsbXCdUTPGXKwBfs
         QzOp40mmfYKPrNTRP5MXZuO5cmQG2ekuQ4MwKcELO3RKoYPsg1ORm5novHHBVLA3I2AS
         0Nmg==
X-Forwarded-Encrypted: i=1; AJvYcCXSC1sMSFoTzAYKeG3nNkYgqdFrhyJy6ydYIF7JCCSEh9EyDZuMxI7bLrWjRGXbvw81pnkMBztnkkwMlY71kmzWNhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgb3roONm6bMTVPqGtpcbDFCJt0MYYQLUZO4i3BSZMaYhSEH+/
	OWzTW5tTM78eZeLdvvZVYHs/sdbupzYSTu3x6zno9VeKpAfURDbM28+Lqtxl
X-Gm-Gg: ASbGncvz77gMEKabW/dn72FDefEEhHA9ACyo3rfGPjJeDevPIlaV0x79Y5BGmYbr7kq
	xHeAzf5uU73j36aUa/e2lZJ47TB3YcTaLUczovDu2fYl4GgKGP7cuJvS8P3+oomtaBMkWXpewWb
	8SjKDhZ18aYzKUDHRMFytY4VRoNPEhkXFSA+5kNyYf8v87CTHbC3vFuXuKEH9Q7Wi6lBabTR+W5
	7FUxQKEizOWmoBxqA9ryYmqWsJB9ZQmZiRZbawpWmxW5A6xGXV8e8V6vqGPgN0K6DVqLCGiKxWn
	1DHceKHOqnA/OIo2TSP46x2TYByyEAjSOurKI/7bNSeNGrjJXGqU
X-Google-Smtp-Source: AGHT+IE8PuZkm/zH/rycajMXfQgZYwUrfwPJYf51Etbd6qLea4JdkloCwScNqLvyp7Nk4RjHBIy0ag==
X-Received: by 2002:a17:90b:2d44:b0:2ee:e945:5355 with SMTP id 98e67ed59e1d1-2fbf5c10415mr9776625a91.19.1739446827001;
        Thu, 13 Feb 2025 03:40:27 -0800 (PST)
Received: from localhost.localdomain ([14.116.239.33])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2fbf9aaf7c9sm3108004a91.46.2025.02.13.03.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 03:40:26 -0800 (PST)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org
Cc: hengqi.chen@gmail.com
Subject: [PATCH] tracing: Remove orphaned event_trace_printk
Date: Thu, 13 Feb 2025 11:39:51 +0000
Message-ID: <20250213113951.813258-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The event_trace_printk macro has no callers since commit
b8e65554d80b ("tracing: remove deprecated TRACE_FORMAT").
So drop it.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 include/linux/trace_events.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5caea596fef0..fa9cf4292dff 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -859,24 +859,6 @@ int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
 int trace_set_clr_event(const char *system, const char *event, int set);
 int trace_array_set_clr_event(struct trace_array *tr, const char *system,
 		const char *event, bool enable);
-/*
- * The double __builtin_constant_p is because gcc will give us an error
- * if we try to allocate the static variable to fmt if it is not a
- * constant. Even with the outer if statement optimizing out.
- */
-#define event_trace_printk(ip, fmt, args...)				\
-do {									\
-	__trace_printk_check_format(fmt, ##args);			\
-	tracing_record_cmdline(current);				\
-	if (__builtin_constant_p(fmt)) {				\
-		static const char *trace_printk_fmt			\
-		  __section("__trace_printk_fmt") =			\
-			__builtin_constant_p(fmt) ? fmt : NULL;		\
-									\
-		__trace_bprintk(ip, trace_printk_fmt, ##args);		\
-	} else								\
-		__trace_printk(ip, fmt, ##args);			\
-} while (0)
 
 #ifdef CONFIG_PERF_EVENTS
 struct perf_event;
-- 
2.43.5

