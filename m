Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0095A31AF08;
	Mon, 18 Aug 2025 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520101; cv=none; b=Z2voz4lmi9ZNE07FKSzeSi1h1Ae9lo/90nvDTTb/xoKKcgJGIL7unOFRnOPObZusdviz8RyZ/QRDhM5jwId6yQr6gKtRm72B7aOmibn8o0AvWvZ7me1YQD/RQ536suDOzWzb52Whyhc2wPeZO/XBm6dQswnozPh9097nYpHlhKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520101; c=relaxed/simple;
	bh=XOMnlGnYrsniBEAn6F9/x5lzmDBO7vRqcQeNkdq4Vnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUyzH/HQTo7IQLcg7v1+qAk1VA/K2pbqUUlYfqTBDk/QWIKagitQxk8/fmolmKUl3ECTYsuAOjDoFaKALVRM6lgqBhLnPwXyTJwr+LHoEqvEWs6ir6vB48g4TVeUHZ1Ph3BieSOyloFRzr9DlWQKYnaHRDpw6Bf4IGUKqi5UKkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6XQ5VU5; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6XQ5VU5"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4717330f9eso2838646a12.1;
        Mon, 18 Aug 2025 05:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755520099; x=1756124899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d62UfjEuqJb2ik1nJ7zN7GvoCBki3/T0lP0cz4BBeFA=;
        b=i6XQ5VU5uK6+/Krd2JOV0GbhVddHR55S7V3kKlXbsirnOeObKwFZKgv22d//OhX3Yl
         6gRSb0lmyGr2YfhBPZhleiwroQPeV3ux05vcb++LwjLnke84pNsp2y0F9z9dMPR35DwO
         oi02lQLPTTJPy0nNFizEK1R94mh9nZF8lb24qiKGMV/RiDzz8UMtPOy3pUUoyNAMeT/2
         CLLylCyw0luuw5D7/ZZOSl4BSMkimg0/I0UXSigO/uACGpnz249Ec1KsI0s08Hn5+Uwk
         EQr6+0o7NDoaYbYOd2ZJN3Z4tLWOzQoGlbWlagmV32q4DWvDyewf30klKViLH3xcrEy4
         Gb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520099; x=1756124899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d62UfjEuqJb2ik1nJ7zN7GvoCBki3/T0lP0cz4BBeFA=;
        b=lifJlxpXGDqPzIGuzevd7KfimRzOip25cDc3LBAYocosCFlFdAyn90+3bN0HqFkDEx
         JtrtYIYS69MrXJKNqBCleBHZUZ6+A6VUhCdyhoCDiqDKpJMhxNHA2QFtIZ+AuunY4h8l
         yoSzPyKWeBdkD1I95m2zbFI7wVPPLPNpL64JZEmbceOf1DGRcHcKGCeHzT3zQSqs+pRZ
         Kz9J4ntHfSHTFyLEspTxY2WL4oYdi0MxRsiRwKM9oZPXLjhtT3+Euo7jy0/LSx1PLw2x
         Gg2qBey1YBX3fMkcJq6Bnh/Mrd9Df6z1u+f6vwhRc1GzzXY8oiZ/B+SlUUJ2QDJFcgaA
         STPw==
X-Forwarded-Encrypted: i=1; AJvYcCVxbnQu+u4+UFJL7Ty8RW0LolX/IijzE7qKjSvgmpifD3RJcgweXSAWp44QiokUUOY6ehAwMD2EnNmpxSbuiMru4lAM@vger.kernel.org, AJvYcCWSfl/b0z6W9b33DnX6V11tO/tOnwup50MywYg9nv+cbD9HM96mu3z4UsF74HNFfWy2sYMriLD5pCgxH6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMjtW8BMLZPnH3oDkG/YxsYEJumq4BSyMcCCkRafmAcmfrFLvc
	Ef9qgw2q8KqoG6PlPvzPiHWkMFNuJltGI6Nr22TiKgNeqC3xuOq8pRgs
X-Gm-Gg: ASbGncs2cFyRv82HA5xnxTUkVnpyZyVEbUgAJVFgr1JtIex6ozgOIT7NLTSp6v8/Bnr
	yrxjJVRlbgEVgwZ5W0bVj8qCyeAT56oMyfvEUqorRB/MYpKh1Vxcn0SiHZb0Xsr4TLr30YwTTVV
	XXNe1XdsnCGd5eS/FRRPV2t3O4orbeFaYVLBC0dTEWHPKm6rcX4SS8BSmlJBsSYNfpOMM2ZKcAX
	aegEMvJQOporwG6s/GiQWmXWJpWkBegR5eNRiMF6bphA69ayS/RvA2is5EKKyXru4HRWU6U1Bk4
	Va47BHX+skuK/OoLucZCemRuHpviFTKhNNNPfuKNcpb4O8wX29gehMBmi2e5R4PgCliUVhNcmfD
	RprlKSonk+EA9vlM9Pg40xJ3ALEOo/5grKzySDd4kGUhB
X-Google-Smtp-Source: AGHT+IFVgokmbj7zixrUmyr6mqgFdp5fTKIbG8uIlrtvE5aDwip+8gjtzYlDymfl75UapvezAXvMfw==
X-Received: by 2002:a17:903:2f4d:b0:240:640a:c57b with SMTP id d9443c01a7336-2446d8b4127mr172220415ad.37.1755520099208;
        Mon, 18 Aug 2025 05:28:19 -0700 (PDT)
Received: from localhost.localdomain ([2604:a840:3::3008])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d57f12esm79236705ad.157.2025.08.18.05.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:28:18 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: akpm@linux-foundation.org
Cc: mhiramat@kernel.org,
	naveen@kernel.org,
	davem@davemloft.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 06/13] mm/kstackwatch: Add stack address resolution functions
Date: Mon, 18 Aug 2025 20:26:11 +0800
Message-ID: <20250818122720.434981-7-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818122720.434981-6-wangjinchao600@gmail.com>
References: <20250818122720.434981-1-wangjinchao600@gmail.com>
 <20250818122720.434981-2-wangjinchao600@gmail.com>
 <20250818122720.434981-3-wangjinchao600@gmail.com>
 <20250818122720.434981-4-wangjinchao600@gmail.com>
 <20250818122720.434981-5-wangjinchao600@gmail.com>
 <20250818122720.434981-6-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement core stack analysis functionality for locating and validating
watch targets within kernel stack frames.

This patch provides the essential stack manipulation functions needed
to translate watch configurations into actual memory addresses:

Key functions:
1. ksw_stack_find_canary() - Locates compiler-generated stack canaries
   by scanning stack frames for the current task's canary value
2. ksw_stack_resolve_offset() - Converts relative stack offsets into
   absolute memory addresses using register state
3. ksw_stack_validate_addr() - Ensures target addresses fall within
   valid stack boundaries to prevent invalid memory access
4. ksw_stack_prepare_watch() - Unified interface that resolves watch
   configurations into concrete addresses and lengths for HWBP setup

Local variable resolution:
- Uses register state (pt_regs) to determine current stack pointer
- Calculates target addresses using SP + configured offset
- Validates addresses against THREAD_SIZE stack boundaries

All functions are marked __maybe_unused to avoid compiler warnings
during incremental development, as they will be integrated with
kprobe handlers in subsequent patches.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |   5 ++
 mm/kstackwatch/stack.c       | 112 +++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 910f49014715..c24a651977c0 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -6,6 +6,7 @@
 
 #define MAX_FUNC_NAME_LEN 64
 #define MAX_CONFIG_STR_LEN 128
+#define MAX_FRAME_SEARCH 128
 
 /* Watch target types */
 enum watch_type {
@@ -38,6 +39,10 @@ struct ksw_config {
 
 extern bool panic_on_catch;
 
+/* stack management */
+int ksw_stack_init(struct ksw_config *config);
+void ksw_stack_exit(void);
+
 /* watch management */
 int ksw_watch_init(struct ksw_config *config);
 void ksw_watch_exit(void);
diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
index e69de29bb2d1..8b558cdbda97 100644
--- a/mm/kstackwatch/stack.c
+++ b/mm/kstackwatch/stack.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/stackprotector.h>
+#include <linux/kprobes.h>
+#include <asm/stacktrace.h>
+
+#include "kstackwatch.h"
+
+/* Find canary address in current stack frame */
+static unsigned long __maybe_unused ksw_stack_find_canary(struct pt_regs *regs)
+{
+	unsigned long *stack_ptr, *stack_end;
+	unsigned long expected_canary;
+	unsigned int i;
+
+	if (!regs || !regs->sp)
+		return 0;
+
+	stack_ptr = (unsigned long *)regs->sp;
+	stack_end =
+		(unsigned long *)current->stack + THREAD_SIZE / sizeof(long);
+	expected_canary = current->stack_canary;
+
+	for (i = 0; i < MAX_FRAME_SEARCH && &stack_ptr[i] < stack_end; i++) {
+		if (stack_ptr[i] == expected_canary) {
+			pr_info("KSW: Canary found i:%d 0x%px\n", i,
+				&stack_ptr[i]);
+			return (unsigned long)&stack_ptr[i];
+		}
+	}
+
+	return 0;
+}
+
+/* Resolve stack offset to actual address */
+static unsigned long __maybe_unused ksw_stack_resolve_offset(struct pt_regs *regs,
+					      s64 local_var_offset)
+{
+	unsigned long stack_base;
+	unsigned long target_addr;
+
+	if (!regs)
+		return 0;
+
+	/* Use stack pointer as base for offset calculation */
+	stack_base = regs->sp;
+	target_addr = stack_base + local_var_offset;
+
+	pr_info("KSW: %s sp:0x%lx offset: %llx, target: 0x%lx\n", __func__,
+		stack_base, local_var_offset, target_addr);
+
+	return target_addr;
+}
+
+/* Validate that address is within current stack bounds */
+static int __maybe_unused ksw_stack_validate_addr(unsigned long addr, size_t size)
+{
+	unsigned long stack_start, stack_end;
+
+	if (!addr || !size)
+		return -EINVAL;
+
+	stack_start = (unsigned long)current->stack;
+	stack_end = stack_start + THREAD_SIZE;
+
+	if (addr < stack_start || (addr + size) > stack_end) {
+		pr_warn("KSW: Address 0x%lx (size %zu) outside stack bounds [0x%lx-0x%lx]\n",
+			addr, size, stack_start, stack_end);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/* Setup hardware breakpoints for active watches */
+static int __maybe_unused ksw_stack_prepare_watch(struct pt_regs *regs,
+				   struct ksw_config *config, u64 *watch_addr,
+				   u64 *watch_len)
+{
+	u64 addr;
+	u64 len;
+
+	/* Resolve addresses for all active watches */
+	switch (config->type) {
+	case WATCH_CANARY:
+		addr = ksw_stack_find_canary(regs);
+		len = 8;
+		break;
+
+	case WATCH_LOCAL_VAR:
+		addr = ksw_stack_resolve_offset(regs, config->local_var_offset);
+		if (!addr) {
+			pr_err("KSW: Invalid stack var offset %u\n",
+			       config->local_var_offset);
+			return -EINVAL;
+		}
+		if (ksw_stack_validate_addr(addr, config->local_var_len)) {
+			pr_err("KSW: Invalid stack var len %u\n",
+			       config->local_var_len);
+		}
+		len = config->local_var_len;
+		break;
+
+	default:
+		pr_warn("KSW: Unknown watch type %d\n", config->type);
+		return -EINVAL;
+	}
+
+	*watch_addr = addr;
+	*watch_len = len;
+	return 0;
+}
-- 
2.43.0

