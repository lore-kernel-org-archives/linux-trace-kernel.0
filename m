Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A20298CBE;
	Wed, 14 May 2025 20:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747254011; cv=none; b=EQZVT+fo8rMPQyfx71jixVdCmwY8bmGIjCaFMtI7LNhBLZCHxcfoqxGTi1hs1gHAtgzuL+cxjn+HCaYmH23EhEXbAC+wr9pUJK0XF87AmOwV0ufr3u0EgNujYo6v+shbPblBsdql1jMSiRPCTcQrlKohCB4nSeSD2vS+j2A3fDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747254011; c=relaxed/simple;
	bh=CsdJeUYinGwWXrVNydnhJE3qs3CHaEYRG19ZLRppBXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TA61PXMFAmkrSMG6ePDpdczwttEdDab8oinaIS+kI9miUORx6XhJw/2QDmEznZ4mqc7Dw5IG9L26NmL1NqZloXKmZr5ItkWP9Jx9RGsXW1IXutGC+3aQKhSgvnfd1m38UcPqK/ZSHNNdVhFvAiso+7O5YUNsB2bNAr/QTMu+Zx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHrQMgOU; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHrQMgOU"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30db1bd3bebso1882201fa.2;
        Wed, 14 May 2025 13:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747254007; x=1747858807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lLsWz+t/NB6tQUSG8q5QMGeVvtWzCR49SOwrB3oJMYU=;
        b=KHrQMgOUwx+uO6utMC+EM7NGgdSvcp6CuTWdOK5SKn/f7o7AUpy1hvZg/IGPBi2Wp9
         NeFzGjItcERRUW76QW01kin3KnFutQYXtnzLVQDr14+tKMA6eAhjyeK7+bWZFoOhU71/
         Bxx8TAY5+KN3ozj3bD/dlSs/tFdW1PFn8S4K5Q4JYpxYAqaxP/XWuF89cW5WQtjMywDs
         kfymPQVtk0wyY4ONZIlWLihzsHptdG/jhJd/C7Nv1dc+fsRw0K4+M9uuUylorkefh1rY
         WcfnC+WxFpjfG9Luv+zXGVlmiwFQOZ+xEz3v2TQVLin3CQ82p15b+L3ZhpzRNvJJrvS3
         T2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747254007; x=1747858807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLsWz+t/NB6tQUSG8q5QMGeVvtWzCR49SOwrB3oJMYU=;
        b=cKUF0O5Kpj7F50l5Tu0qC4M1TBlQc/x1Ay5TS7qi5WnE6fvJLOcy7XNnTmrobRGdlL
         4TES3KGGKWPwOruGIQuIbX1o+h/8Zkbl/wx9ZmIuNWJa+dvpZ0Gr+BFumrExYp/ieIH+
         brZYLqgtK5VHKfj08GOyk22560q7FCxVuZYJjmpdUfn5lHsw9CK8vHYKU6i5vVN3gT0V
         kj6hXQGtzXHTOflEZpxCXgon5nogMXB6WFDgx+V3VuWZKz/RAoKOA3+TmxXF1Ni2ibkD
         YDooziEhaolpc0wBW8ZL3WeYlSZooCuVT56kCPdHFg+FLkEoEjwkEDZBO9QJuxGFDyyu
         TYsg==
X-Forwarded-Encrypted: i=1; AJvYcCVGRLPqZXeIj9jOe6iXnKBEfZykRbgfPe9JYqX8TDi66ACdqH9lpSAUIxtHiPOjejkuP6ZO2Ja7LTFnYjc=@vger.kernel.org, AJvYcCVekj9q1JOw+b6r6TlDD9INKqmy6NET9Z2EEPFt6oRJNihW+PCI4dZttsJ0y6fWFxtMYY2Rg+H1SPSNFFR6S+fiyDld@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3tfEOFfeXn91ZxF+t2xg1h7lywUmEakdlyUj7F7FW4kOCNCWw
	e5O8mLJrAYaC4wekFg4n4Z2hk5kqdckCpXmBDy6VjfdQzUwQhK6Mv9q+VllLhBA=
X-Gm-Gg: ASbGncs7a69NKMKfiPI+T4takm4DXbPaQsBxpwGXa5ctk2OUfFGHcsZ7Kq+EcjHlCmQ
	2sWd5VWkKPL9HNThx1EppLcnlPqsYYIsTCxl7Q0GmHJs5QAsxCRCRbFKCntmgZD3pGWn8lE7N19
	9ussK1SsTzJu8wLJLMgbQCNH70ql2g5LiBLoKbMpW3Ak2SWK29ENHP/575PQrjxszatyS0dqIK2
	kzx3/nGAfbES9AZbTtuTUKEydMmIqhV7tZ/3bGqgnhceDO8upDOSZfv0f3jPh0SsFk21MK7U4la
	kYrU2YjH9IX7+cz8lqEdUdkFhDw+vy5Pdh+q6kxz1fG4riadaw==
X-Google-Smtp-Source: AGHT+IF/QkZffiFhaKm+a/zd4DO70fd0mZ4eTmBpn5QTqiYlb4drtaIlD/EyTywT/l9GUCLY603MUQ==
X-Received: by 2002:a2e:ad92:0:b0:30b:9813:b010 with SMTP id 38308e7fff4ca-327ed1ef046mr20224831fa.31.1747254006735;
        Wed, 14 May 2025 13:20:06 -0700 (PDT)
Received: from fedora.. ([37.131.106.85])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-326c33c1256sm20767971fa.48.2025.05.14.13.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 13:20:06 -0700 (PDT)
From: Devaansh Kumar <devaanshk840@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: Devaansh Kumar <devaanshk840@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] tracing: Replace deprecated strncpy() with strscpy() for string keys in hist triggers
Date: Thu, 15 May 2025 01:49:55 +0530
Message-ID: <20250514201956.1447439-1-devaanshk840@gmail.com>
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
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1260c23cfa5f..90a4e486fba8 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5225,7 +5225,7 @@ static inline void add_to_key(char *compound_key, void *key,
 		if (size > key_field->size - 1)
 			size = key_field->size - 1;
 
-		strncpy(compound_key + key_field->offset, (char *)key, size);
+		strscpy(compound_key + key_field->offset, (char *)key, size);
 	} else
 		memcpy(compound_key + key_field->offset, key, size);
 }
-- 
2.49.0

