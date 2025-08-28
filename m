Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DB02D7D30;
	Thu, 28 Aug 2025 07:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366459; cv=none; b=E8rJGXky/Ft7fTnWJdhZYl8JU6IZqSy7O+t7dZH6WWlFbsq3CFy72KMUM1r1aiUlJgojjSZ8Te3/XEWDxKaPSQI/WR4KbIi0azDQfvbzepk/baTz4yz6kHk2H+Dgrp5QBaFg6GUG0wUIeB+xtTLm7J16LWnXwyN5+5wQGMcPjtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366459; c=relaxed/simple;
	bh=f7oIGMu82h0EUyi+ciPNEzqBC4KP/xyBf4hESY7E3jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPGWMIlbprC02J0myLtuzmPgzFLF/oITXsRWDestFwthWvLqc4BNWox1akiG21kt8XlogaWNBuH8KqVeUcKSV4VfG5wWmeuWbypymFzVdXmxdScDFfHGqIPUxgP5Wan/xFBpza2z4wzMsU0kk8A9tBu/9T6oiTD+IL94dTrVOLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wj0Gd1vx; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj0Gd1vx"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7704799d798so528669b3a.3;
        Thu, 28 Aug 2025 00:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756366456; x=1756971256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oy0C0swglM9nhMs2jJeQr2J+ATypwXUQHvq+zmKtZ8o=;
        b=Wj0Gd1vx2mpEZ2lwmS69oiOPZuYscVCVAmSb+VcqFqo4tpXRHjDgSEDplCItoWqSqm
         haBJg005jaV5flcpnQP+K/mT5mDG0tmnmjZSW7qtbWuiUi/W7tKePDy62JwIByM01OP+
         +IXU7kC15qR/aC49g1ZW+Ff4TfhVzcCaWRvAodoFPzMNtJwXgg9dHpRESY/GFvq4g3iC
         aOSlRFV16nuYZXLq9bUpNxcAhhup9pEuPghfhcD7aEJO3MzCOCcY+W2FXjLnc3O9NkE2
         xZhCbQ/kd0Tfb1RfCWe5FDRxiQ5WeAWq0uirHVIuB8iIrwScdsqealZa1w+L/7ElRKzE
         9ZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366456; x=1756971256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oy0C0swglM9nhMs2jJeQr2J+ATypwXUQHvq+zmKtZ8o=;
        b=KD3gfkPZbvx6BcqZvtF6Caxha/FLi6Zk6a7EhhH86qRwe0lUuW1Y2JKP2e5dm3tfaL
         uBQbx+lRjZATYKMnNXkzEV2FYJ/92fD2D8C7R6h7Nco42FLjrCgu+le8BJO0y/S1vMoT
         QBSckCjE2jH4TmZYvZls3cq81X4a/lkuc0Z58+xczqOAHbeACvRzpeYMI9eLt3jSW/iy
         ob3oxtiDDelnwL7dqoMIQ9DdIl1qP+anOyYoKfUZsSxti5AfpsgPr6NXAyo768DnZQjM
         rZ7KRS2zcdM9SajtLa+Z0Xev9yBz16a5lK0JTmzsRwkXkTrUwoyz9X/zSu5JWdDql047
         nyqw==
X-Forwarded-Encrypted: i=1; AJvYcCV22WUbw8qJlPafwe7XUpc5VlUKhHuwhRaZW2KJeTAyK5lumncVVXNlRAvyzm5NDqAbGqq8Iw3k9aToVtXFWI3O1Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx13C8u6//l6wXEDbmyj37dS9T5JPONZj6Ie5sZLA2gPvbanVxe
	dfpeLyq8lkaZLshYbIZMS+VlYwd07b2gVY+XoCgVbsjP+NX8Ud9ESpc6
X-Gm-Gg: ASbGncto7Hh9Sw3iFbB2DsmaITEwVe3FV/X8hs8TqYbi6l2XNQ01d32n3PNRb84lNZK
	JrX5qBoPECB7CUF6mgADb8cUOS8IbpNtk94TlfZrYWKV7arkwOV9T619mxTHLdvMqEB6mwiyKoQ
	JczmEoEEicntR7AF2lzM9fv7jVArS8i1Sw8Hge79wZnvpplTJTA2HIn+TyoOxyP0kjPsy8R23Ve
	vhDdDIhjnr44eZ1MqBSafC2xgyOcTq4wNux7f60BXqcHKUIL9X+kNCqQKp85/iHT20hai4+qo3m
	lMWkVlHEnwADJxbG5J2oDTiwNDElVryziT+LID6SEE72O8VsFowbxEJpLl+mumO16Ar0BArDRZi
	fJ1cbblaVSkl+DPrjceCswS9W8kjy2PKcQd+G3LjarRyAhICs36XWIaKs0Sc5
X-Google-Smtp-Source: AGHT+IFHzBxQakuN1JXsJ42RsWWWZRkns+BK6Z0QAL9Y0L/arSVa3U2kDuosHVpFKM1rO0HaGrnViA==
X-Received: by 2002:a05:6a21:999f:b0:240:116b:cc41 with SMTP id adf61e73a8af0-24340b2757bmr32060790637.16.1756366455717;
        Thu, 28 Aug 2025 00:34:15 -0700 (PDT)
Received: from localhost.localdomain ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8afb7bsm13182613a12.16.2025.08.28.00.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:34:15 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 02/17] mm/ksw: add ksw_config struct and parser
Date: Thu, 28 Aug 2025 15:32:35 +0800
Message-ID: <20250828073311.1116593-3-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828073311.1116593-1-wangjinchao600@gmail.com>
References: <20250828073311.1116593-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add struct ksw_config and ksw_parse_config() to parse user string.

Update `Makefile` to pass compilation.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/Makefile      |  2 ++
 mm/kstackwatch/kernel.c      | 70 +++++++++++++++++++++++++++++++++++-
 mm/kstackwatch/kstackwatch.h | 34 ++++++++++++++++++
 3 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/Makefile b/mm/kstackwatch/Makefile
index 84a46cb9a766..d422f0e114dd 100644
--- a/mm/kstackwatch/Makefile
+++ b/mm/kstackwatch/Makefile
@@ -1,2 +1,4 @@
 obj-$(CONFIG_KSTACK_WATCH)	+= kstackwatch.o
 kstackwatch-y := kernel.o stack.o watch.o
+
+CFLAGS_kernel.o := -Wno-error=unused-function
diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
index 93379a0a0f7e..4a6dc49449fe 100644
--- a/mm/kstackwatch/kernel.c
+++ b/mm/kstackwatch/kernel.c
@@ -1,11 +1,79 @@
 // SPDX-License-Identifier: GPL-2.0
-
+#include <linux/kstrtox.h>
 #include <linux/module.h>
+#include <linux/string.h>
+
+#include "kstackwatch.h"
 
 MODULE_AUTHOR("Jinchao Wang");
 MODULE_DESCRIPTION("Kernel Stack Watch");
 MODULE_LICENSE("GPL");
 
+/*
+ * Format of the configuration string:
+ *    function+ip_offset[+depth] [local_var_offset:local_var_len]
+ *
+ * - function         : name of the target function
+ * - ip_offset        : instruction pointer offset within the function
+ * - depth            : recursion depth to watch
+ * - local_var_offset : offset from the stack pointer at function+ip_offset
+ * - local_var_len    : length of the local variable
+ */
+static int ksw_parse_config(char *buf, struct ksw_config *config)
+{
+	char *func_part, *local_var_part = NULL;
+	char *token;
+
+	/* Set the watch type to the default canary-based monitoring */
+	config->type = WATCH_CANARY;
+
+	func_part = strim(buf);
+	strscpy(config->config_str, func_part, MAX_CONFIG_STR_LEN);
+
+	local_var_part = strchr(func_part, ' ');
+	if (local_var_part) {
+		*local_var_part = '\0'; // Terminate the function part
+		local_var_part = strim(local_var_part + 1);
+	}
+
+	/* 1. Parse the function part: function+ip_offset[+depth] */
+	token = strsep(&func_part, "+");
+	if (!token)
+		return -EINVAL;
+
+	strscpy(config->function, token, MAX_FUNC_NAME_LEN - 1);
+
+	token = strsep(&func_part, "+");
+	if (!token || kstrtou16(token, 0, &config->ip_offset)) {
+		pr_err("KSW: failed to parse instruction offset\n");
+		return -EINVAL;
+	}
+
+	token = strsep(&func_part, "+");
+	if (token && kstrtou16(token, 0, &config->depth)) {
+		pr_err("KSW: failed to parse depth\n");
+		return -EINVAL;
+	}
+	if (!local_var_part || !(*local_var_part))
+		return 0;
+
+	/* 2. Parse the optional local var: offset:len */
+	config->type = WATCH_LOCAL_VAR;
+	token = strsep(&local_var_part, ":");
+	if (!token || kstrtou16(token, 0, &config->local_var_offset)) {
+		pr_err("KSW: failed to parse stack variable offset\n");
+		return -EINVAL;
+	}
+
+	if (!local_var_part ||
+	    kstrtou16(local_var_part, 0, &config->local_var_len)) {
+		pr_err("KSW: failed to parse stack variable length\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int __init kstackwatch_init(void)
 {
 	pr_info("KSW: module loaded\n");
diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 0273ef478a26..b5f1835586c1 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -2,4 +2,38 @@
 #ifndef _KSTACKWATCH_H
 #define _KSTACKWATCH_H
 
+#include <linux/types.h>
+
+#define MAX_FUNC_NAME_LEN 64
+#define MAX_CONFIG_STR_LEN 128
+#define MAX_FRAME_SEARCH 128
+
+enum watch_type {
+	WATCH_CANARY = 0,
+	WATCH_LOCAL_VAR,
+};
+
+struct ksw_config {
+	/* function part */
+	char function[MAX_FUNC_NAME_LEN];
+	u16 ip_offset;
+	u16 depth;
+
+	/* local var, useless for canary watch */
+	/* offset from rsp at function+ip_offset */
+	u16 local_var_offset;
+
+	/*
+	 * local var size (1,2,4,8 bytes)
+	 * it will be the watching len
+	 */
+	u16 local_var_len;
+
+	/* easy for understand*/
+	enum watch_type type;
+
+	/* save to show */
+	char config_str[MAX_CONFIG_STR_LEN];
+};
+
 #endif /* _KSTACKWATCH_H */
-- 
2.43.0

