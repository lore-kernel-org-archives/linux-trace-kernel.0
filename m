Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1543131B11A;
	Mon, 18 Aug 2025 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520107; cv=none; b=tPjbL1vPBjTwib4xkFH4g5W7QSVWJRqfbA5Cs5HTdnSgKip35r1cTELPYB17ZeEGyL2H/klW7aruG5N+UVDX+dcO9fwW1wiDy5Tz6dsxr3fx8a7BQmbSE/FINeqYTKVdih/soYOFR4QMZY6u8BxARHZI7f0xL1+zG5c1tuzjowM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520107; c=relaxed/simple;
	bh=y6IWdlQouEelFJjFd/WtaWh2hrS5cC/+0bF8R8VmQDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1Gpa4lQOKSxiyEJU7xo8hb+ssklUlomkK76qFTgYGxk9cQUkB093EAJNV8rRZ/MAh/5FGOISzIqDj859BlT82VockiEL5ccPmVBjt6omZDE1wUMZVZF54LhYBpJ6j6TyxIdA//lYpmxkVG/Nag/GOXdTPfs9TyE1iRrewCasmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFKiVw2e; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFKiVw2e"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24458317464so43820245ad.3;
        Mon, 18 Aug 2025 05:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755520105; x=1756124905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKDvPcpYKvhUCRu7u5ZD1MVAzzFCPS4KkCyAHcO/poY=;
        b=QFKiVw2e0gg+rOWmVsu3w4MJOGJbIOUwqsgBefS2SXEENXzk3OwNxuFtQoEOe0itMF
         oDIouUlAqJS6Uj5b4n9ZZJ4nrBGY2NwB8Dn/4AM6SZUAmuBeHL6Lxs0O0nZgVFKRNL/c
         J1otp0C/0/gu1ZAbSyGhrGi35vy+euOJ/akRTgsgyI5olwY7yYPUbXDTbQ1USsgcXx05
         qynsSKJ/ap5mT3u9qnN9ww1hL1Yah9/164tlekczVFSP5VVs1Scvoxaxe4mds0QbeBWf
         nTc+xsdPL/+Hs6/EKtjouZBa+tHs6XBYidk33FmkFxT/CBeQjUPGRnD1UurCpmM+Zmpr
         J6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520105; x=1756124905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKDvPcpYKvhUCRu7u5ZD1MVAzzFCPS4KkCyAHcO/poY=;
        b=XK4hYGkbnCp/wYqxA/7Aft7zX+o2IVQzM6tyJMDtdCapPI7hwdPC9PKCd2b/pmbmPr
         Vmu34pf8Ged3x0w2aXVWg2aakLCwID4X0GCK4W4YGpJpxfmDJbwJBfRJf1LX62wrP2dy
         a6XVwwmtv/syM2GdAPTzKYGqLWh7rs5kT1qas9z3h/O+FyxXhRkAuHQV443HHsp/AVGV
         TSB6HMOrbCPZPuH/qg/ChUFRhOhzpzjSJD97pdKxDDiiHQiJEVulisHFYy1S11Nv/BG3
         2hunKlehlSUm7TXruVNxYrqFm5TrNaWc+l4cLNdp6xfkYONQmN3vU2pmVSHF66w5xN6P
         GgSA==
X-Forwarded-Encrypted: i=1; AJvYcCXspjP06iwZgjBxCIZKVJY2sthQwR9JORNRGUh9L53bw6Eb/YnR1Z0xwuI1SIAgjH5dEZioZLUFPeLIG2hWMDPDVs0w@vger.kernel.org, AJvYcCXtUodLRAVjTLY9LXsJvNKyq+6PG/kqSibpJKipUOMtKLe9bcm8G7GXQBl6WZiSxfrMXQtsMX85ynZarOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeVICnSEokdsq7O4ZIiEMc3DH69uCK+faW+n5Y+CQ9OJGhYk9i
	N2NZvnkLNEUCuIxoYQbQbnmh51z4hKMKNYzE0QlQlzJDaPlolSAq289H
X-Gm-Gg: ASbGncuM+O6cA0LuyfHvjA5/P+pY8dauBtuVOCXTKht4j16SuKmdezPFK3RBJT+Otmp
	z3ovPrzSjETXWAC55VeFTfu8Gk+6jtYJBygW6L1Eith9tvbpmv/ir01yeWq8+MQ7BNzo/uIQ3EV
	B9s+aySxyYKGSzo+lSRWkSZa9aNjYpFrNdOtdzC8TOPYdJFpV9a5p2fOKnfevil8v/oAY1qrO19
	ZegVhThhqme4p+UyD0xYoU7BY3b3Wrz01aIMJLw+Y4p0om+CBghzW6QH0ospdJ/rLslANtN/O5A
	j3MwOI5vk8pjmqYg5+lEEAvYgL3OiY/zV9mF3Dulx1Cgxc4FW7g19LLYMMunDEEo0OSE0HWrPyD
	VIihU9Vhdd6qFg7A8OMNIVmmr6jw2
X-Google-Smtp-Source: AGHT+IHqxDjVWhE3iAZ1X67hYb9HOz1KKkxasAVNPhwxJzmSbHWpUcT79VGyxRMFfFsWEKif1OddXg==
X-Received: by 2002:a17:903:2f82:b0:244:6c39:3383 with SMTP id d9443c01a7336-2446d709449mr143610625ad.21.1755520105347;
        Mon, 18 Aug 2025 05:28:25 -0700 (PDT)
Received: from localhost.localdomain ([2604:a840:3::3008])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d57f12esm79236705ad.157.2025.08.18.05.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:28:24 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: akpm@linux-foundation.org
Cc: mhiramat@kernel.org,
	naveen@kernel.org,
	davem@davemloft.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 07/13] mm/kstackwatch: Add kprobe and stack watch control
Date: Mon, 18 Aug 2025 20:26:12 +0800
Message-ID: <20250818122720.434981-8-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818122720.434981-7-wangjinchao600@gmail.com>
References: <20250818122720.434981-1-wangjinchao600@gmail.com>
 <20250818122720.434981-2-wangjinchao600@gmail.com>
 <20250818122720.434981-3-wangjinchao600@gmail.com>
 <20250818122720.434981-4-wangjinchao600@gmail.com>
 <20250818122720.434981-5-wangjinchao600@gmail.com>
 <20250818122720.434981-6-wangjinchao600@gmail.com>
 <20250818122720.434981-7-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the core logic for controlling the kernel
stack watch mechanism using a combination of kprobes and kretprobes.

A kprobe is registered at function + ip_offset to turn on
the hardware breakpoint that monitors the stack. This allows
the tool to begin watching from a specific instruction within
the function. At the same time, a kretprobe is registered to be
triggered when the function returns. Its handler is responsible
for turning off the hardware breakpoint.

By using these two probes, the tool can precisely watch a function's
stack frame for its entire duration. This makes sure the HWBP is active
only when needed, which reduces overhead and avoids accidental triggers.
This also provides a clear and reliable way to manage the HWBP.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/stack.c | 86 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 4 deletions(-)

diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
index 8b558cdbda97..ba5280787e8f 100644
--- a/mm/kstackwatch/stack.c
+++ b/mm/kstackwatch/stack.c
@@ -6,8 +6,10 @@
 
 #include "kstackwatch.h"
 
+struct ksw_config *probe_config;
+
 /* Find canary address in current stack frame */
-static unsigned long __maybe_unused ksw_stack_find_canary(struct pt_regs *regs)
+static unsigned long ksw_stack_find_canary(struct pt_regs *regs)
 {
 	unsigned long *stack_ptr, *stack_end;
 	unsigned long expected_canary;
@@ -33,7 +35,7 @@ static unsigned long __maybe_unused ksw_stack_find_canary(struct pt_regs *regs)
 }
 
 /* Resolve stack offset to actual address */
-static unsigned long __maybe_unused ksw_stack_resolve_offset(struct pt_regs *regs,
+static unsigned long ksw_stack_resolve_offset(struct pt_regs *regs,
 					      s64 local_var_offset)
 {
 	unsigned long stack_base;
@@ -53,7 +55,7 @@ static unsigned long __maybe_unused ksw_stack_resolve_offset(struct pt_regs *reg
 }
 
 /* Validate that address is within current stack bounds */
-static int __maybe_unused ksw_stack_validate_addr(unsigned long addr, size_t size)
+static int ksw_stack_validate_addr(unsigned long addr, size_t size)
 {
 	unsigned long stack_start, stack_end;
 
@@ -73,7 +75,7 @@ static int __maybe_unused ksw_stack_validate_addr(unsigned long addr, size_t siz
 }
 
 /* Setup hardware breakpoints for active watches */
-static int __maybe_unused ksw_stack_prepare_watch(struct pt_regs *regs,
+static int ksw_stack_prepare_watch(struct pt_regs *regs,
 				   struct ksw_config *config, u64 *watch_addr,
 				   u64 *watch_len)
 {
@@ -110,3 +112,79 @@ static int __maybe_unused ksw_stack_prepare_watch(struct pt_regs *regs,
 	*watch_len = len;
 	return 0;
 }
+
+/* Kprobe handlers */
+static struct kprobe entry_probe;
+static struct kretprobe exit_probe;
+
+static void ksw_stack_entry_handler(struct kprobe *p, struct pt_regs *regs,
+				    unsigned long flags)
+{
+	int ret;
+	u64 watch_addr;
+	u64 watch_len;
+
+	/* Setup breakpoints for all active watches */
+	ret = ksw_stack_prepare_watch(regs, probe_config, &watch_addr,
+				      &watch_len);
+	if (ret) {
+		pr_err("KSW: Failed to parse watch info: %d\n", ret);
+		return;
+	}
+	ret = ksw_watch_on(watch_addr, watch_len);
+	if (ret) {
+		pr_err("KSW: Failed to arm hwbp: %d\n", ret);
+		return;
+	}
+	pr_info("KSW: Armed for %s at addr:0x%llx len:%llu\n",
+		probe_config->function, watch_addr, watch_len);
+}
+
+/* Function exit handler */
+static int ksw_stack_exit_handler(struct kretprobe_instance *ri,
+				  struct pt_regs *regs)
+{
+	ksw_watch_off();
+	pr_info("KSW: Disarmed for %s\n", probe_config->function);
+
+	return 0;
+}
+
+int ksw_stack_init(struct ksw_config *config)
+{
+	int ret;
+
+	/* Setup entry probe */
+	memset(&entry_probe, 0, sizeof(entry_probe));
+	entry_probe.symbol_name = config->function;
+	entry_probe.offset = config->ip_offset;
+	entry_probe.post_handler = ksw_stack_entry_handler;
+	probe_config = config;
+	ret = register_kprobe(&entry_probe);
+	if (ret < 0) {
+		pr_err("KSW: Failed to register kprobe ret %d\n", ret);
+		return ret;
+	}
+
+	/* Setup exit probe */
+	memset(&exit_probe, 0, sizeof(exit_probe));
+	exit_probe.kp.symbol_name = config->function;
+	exit_probe.handler = ksw_stack_exit_handler;
+	exit_probe.maxactive = 20;
+
+	ret = register_kretprobe(&exit_probe);
+	if (ret < 0) {
+		pr_err("KSW: Failed to register exit probe for %s: %d\n",
+		       probe_config->function, ret);
+		unregister_kprobe(&entry_probe);
+		return ret;
+	}
+
+	return 0;
+}
+
+void ksw_stack_exit(void)
+{
+	unregister_kretprobe(&exit_probe);
+	unregister_kprobe(&entry_probe);
+}
-- 
2.43.0

