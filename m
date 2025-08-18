Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E923218A0;
	Mon, 18 Aug 2025 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520138; cv=none; b=GWzVrNtpsDgaoO6x7nkg3owfPF0jti52bH8mixEEXuNRPY1CrWmg7HVeCiiZdP4ByP8NH0px6JtqJN6Zug3NFYfRzC4XrqAMm1JG9smPWLCNlIFqzBWXVhMHrY5NSsP2x2FbkH/v7IOXpchWFDp9xSDhSL2/4pld6wbWZIiYcBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520138; c=relaxed/simple;
	bh=Pj0Tjj+ChQQtUHnWbQWDBxgqXCg/uukvG+zOJA018Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUQgBuUOynqpXJwej+xK1p8F5zAeOWqqfnYaMaXmp4Gf1jK2JHPb1xg2ECQWvYjXD7lGxDf12eT6fq2fHARw/c6sqafIKy/6ND/zO/ayW9zgC0CmHcYzaT8iEqAhSHYvKJlcFX+3kDs1jH7Bapou3Zr/gqNamjaL98deDs7o6AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZJGLy3M; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZJGLy3M"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b47475cf8eeso519934a12.3;
        Mon, 18 Aug 2025 05:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755520136; x=1756124936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nxh86RQjx8x9Y8+TdxwdmIa/RJOrFh+0RUsbopHZ3sQ=;
        b=YZJGLy3M8zCw94DDPjEdOO2f7nj0O6WP126teJqqtwaLK7HYDwYYpUsRqqkZJZkWyT
         YME2Ekp9I2xE3fbvA5azGG1Eog7S+X0UbK62uxkolx/r7nIC9873sN2n6JodheLTGymX
         AOmCR+hgy+8JTC/tRtJ/4q4pqe0kdknYWCnPcW7Iwcst3eOHbNbfXXh8Lfy0RSkChScW
         aM++mhBfEdoCMKPQXoHaKrNNCFJAGIb3kuAp53K+Q/zjuJhCLzkbNz6vTpMosilgLqqF
         iRHOPKq0qYI+xXkEnbaCrsOV8ArNSlXXK7vu8Zj460bLY89+L1YALm/wgcQO6L6ZzvhL
         +DXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520136; x=1756124936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nxh86RQjx8x9Y8+TdxwdmIa/RJOrFh+0RUsbopHZ3sQ=;
        b=LH3bcodi7822yXr1AeGKI7JL5ptJ87FGB82BM+JrPf40XRTI7Fc0KkOehdUqK6JRwk
         HAyK92tBuvyC2X9AOiUmzfNhZTlzN1AXgZKpGQNoZZmPnztcqCY4/W9vZHvoBAv2yadQ
         SKp6BkD3nLx3mthOu0we54OJ1eRrJsEGl3tmQ+/RiH8aZvngcbuAOWqJmdsXxy1H8rx5
         R9+zStfzOAKNLQ5KV8fjaDRLxMShamNzZdsdwI7mJa7TJY5K2xDruGjA/LX19XCkQnv5
         2HoVxUuAWoBfDzjNMkr9IA9FZCU5m0NGNqhvT3A4p9cR2YYyhYDQdfaUs7PiRy8pyarT
         RW+g==
X-Forwarded-Encrypted: i=1; AJvYcCUXrdsRalQUmyY8N4jdRvEp7D+zeCNHMFqZa06ZCo5MpzXJlFsWPjGJzovmToSilSv/FwOE/BBdRbtl7Q47M/qoEJPx@vger.kernel.org, AJvYcCVi3An+L/9uZC1h/Qr1m7p7LHfuDCW8bNRj6oYdGxmqCJag1UW5oUN/bFjlhOjE8SAcigPW/Fgv15YOu6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH1dep6qpsjBRznkYq11FaWobseqFaZvpretx5EEugpnQtRH3a
	5NZKi2+rVjkGDPCTcQQUeR/BOeaqQHo8DaCqIXZDOf80NlPOeSH1Jojp
X-Gm-Gg: ASbGncuiq78m4H4XpPuLqezgZfB5qZbuUE4zBr24PkOKPKkVMkrTpCgvYjrFIYEPiKV
	Ml+IkpFu64stmLBA0FErOIzyleJY24t88BQfD1+O8+8kpzkFN5w+iH8DvWgWoMlhS7UUIAYbyug
	JjGkpbG9FwbLkVBcQg4e1/vtgHmG6K6R5fQr9OSiDVD9lazNn3KLjMtFgOWVy8J/PKdpBBHj9Wy
	ROr6rNcwQoTiBIkFLiuo55pkpf0pyQK5V0oMmGLSg+JnHJ2VcuipibwQsgcYGdQtlhltXvyqkNt
	HnAvIeTO688aTOS0QRbP7GaMXFifK5+18FQBS0BnVTXh3tHvSjeTTjy02NSwFnCWsQWTIm5OGgU
	8jV3Ihga+ptUWK9Do5naL7Zqry8hM
X-Google-Smtp-Source: AGHT+IGaSWeKYBv3gFakrVGYfHWtsjon//FUbcLW3c3fM5l7j3n889K+m8tBE3IoQkxw8ZsbZ6mXEw==
X-Received: by 2002:a17:903:3c67:b0:240:6fd0:25b7 with SMTP id d9443c01a7336-2446d8f9568mr203579095ad.38.1755520136340;
        Mon, 18 Aug 2025 05:28:56 -0700 (PDT)
Received: from localhost.localdomain ([2604:a840:3::3008])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d57f12esm79236705ad.157.2025.08.18.05.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:28:55 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: akpm@linux-foundation.org
Cc: mhiramat@kernel.org,
	naveen@kernel.org,
	davem@davemloft.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 12/13] mm/kstackwatch: Add debug and test functions
Date: Mon, 18 Aug 2025 20:26:17 +0800
Message-ID: <20250818122720.434981-13-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818122720.434981-12-wangjinchao600@gmail.com>
References: <20250818122720.434981-1-wangjinchao600@gmail.com>
 <20250818122720.434981-2-wangjinchao600@gmail.com>
 <20250818122720.434981-3-wangjinchao600@gmail.com>
 <20250818122720.434981-4-wangjinchao600@gmail.com>
 <20250818122720.434981-5-wangjinchao600@gmail.com>
 <20250818122720.434981-6-wangjinchao600@gmail.com>
 <20250818122720.434981-7-wangjinchao600@gmail.com>
 <20250818122720.434981-8-wangjinchao600@gmail.com>
 <20250818122720.434981-9-wangjinchao600@gmail.com>
 <20250818122720.434981-10-wangjinchao600@gmail.com>
 <20250818122720.434981-11-wangjinchao600@gmail.com>
 <20250818122720.434981-12-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds new helper functions to the kstackwatch module to aid in
debugging and testing.

- `ksw_watch_show()`: Displays information about the currently active hardware
  breakpoint, such as its address and length. This is useful for verifying
  that a breakpoint has been correctly installed.
- `ksw_watch_fire()`: Manually triggers the active hardware breakpoint. This
  function is for testing the breakpoint handler to ensure it correctly
  identifies and reports the stack corruption.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |  4 ++++
 mm/kstackwatch/watch.c       | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index c24a651977c0..27c71a9391ac 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -2,6 +2,8 @@
 #ifndef _KSTACKWATCH_H
 #define _KSTACKWATCH_H
 
+#include <linux/kprobes.h>
+#include <linux/perf_event.h>
 #include <linux/types.h>
 
 #define MAX_FUNC_NAME_LEN 64
@@ -48,5 +50,7 @@ int ksw_watch_init(struct ksw_config *config);
 void ksw_watch_exit(void);
 int ksw_watch_on(u64 watch_addr, u64 watch_len);
 void ksw_watch_off(void);
+void ksw_watch_show(void);
+void ksw_watch_fire(void);
 
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index 1b4cf5d42db9..28ea24e4ae3a 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -218,3 +218,23 @@ void ksw_watch_off(void)
 	ksw_watch_on((unsigned long)&marker, sizeof(marker));
 	pr_info("KSW: All HWBPs disarmed\n");
 }
+
+/* Debug functions */
+void ksw_watch_show(void)
+{
+	struct perf_event *bp;
+
+	bp = *this_cpu_ptr(watch_events);
+	pr_info("KSW: HWBP info test - bp_addr: 0x%px len:%llu\n",
+		(void *)bp->attr.bp_addr, bp->attr.bp_len);
+}
+
+void ksw_watch_fire(void)
+{
+	struct perf_event *bp;
+	char *ptr;
+
+	bp = *this_cpu_ptr(watch_events);
+	ptr = (char *)READ_ONCE(bp->attr.bp_addr);
+	*ptr = 0x42; // This should trigger immediately
+}
-- 
2.43.0

