Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0445231E0F6;
	Mon, 18 Aug 2025 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520126; cv=none; b=j2Lh687hz3j7m/xrwU7SOw9OcpBF/DuvyQSe7deWNQfdk1wbnjhBwcFdj1284EuOH6e1sPZovd0s2wvXygwiJ7o3hBMwxBJtv/fKtbEZAUL10oR3nMudsmLf4RTntw1OHDa1v0S/nb2Jhqv2Ih9Qu/YZxqiH7/inseOPeIBeJZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520126; c=relaxed/simple;
	bh=G4kpPYTGRayibFcHrwX81uQajJqUyCB2Dx27m4ElQy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/8hx0fWlmZSSQ+xRNPfjrECYYSnU/csjdJEBYliXn/St540qX6IOnx2Hc6KYQQ/io1tFPSesl4PCoWPyx98liPd2416RplGxe6XDVuCVyLLKaiaBjdfv5aunldoD/3hDX45iOWTzADFpO1Ybcdv4U7E9I9kyYmfK4NS+Qdbvfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coi6QRmk; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coi6QRmk"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b47173a7e52so2520265a12.1;
        Mon, 18 Aug 2025 05:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755520124; x=1756124924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIPvLPw4y/uoDDSUMecOSmbUAqRxHZwIYoUWaeWEArc=;
        b=coi6QRmkRtHiDJq26ONfh1oo5/7f7nBImqvl+XE3BINlVc0h60H92nOeHMX2+DoRlW
         cXUgh8vTPGCnocy7ZM3LHZclH4ofqlTBzLozGn/MRZRIj4/iR4L8DHZlwTYiyBe3XcMW
         I4y9fipWKAasvXB2xlkK5jYFGY7LTb3+TP7ZwpuEmAl0NaporG0GnayOmtYEJPtqWWvS
         9sMeC884I+GX7LGzhzUtTNF2r7P9JI1fQN6FQGIneknlVZ7n33GzwAQ7rChgxjhb0lrF
         CGNiuFX/RAYiS8EI3gUKIvjBiXFCgS7Wq1pictjzeUr6LdMlBseBxbb0ASgxjQhLjwly
         K/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520124; x=1756124924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIPvLPw4y/uoDDSUMecOSmbUAqRxHZwIYoUWaeWEArc=;
        b=fKqH6zFAqtsFOXlixD/UuHfzE3+AO3JVwU5lY/Wk2YdOezTqzlbudqw/LSs3qSwklW
         iiFankHb19iX3R5+HwQ+SHHRygdrFB/pNZhNiqnJHVdw0V86PCiuzWl+/DI6yhuRhbjF
         ufymoC47cxPhAc7pEbX44dXLhybMXaohTJLTW2Tnfyc1DhNJwQ4HHeyLD9Rl1UnsNyd1
         cqjhAC1tPFcJvELPQdX8PLPMnpjH0GxvKNZ+TAH5NAkF3x5POk7hNF4tCnc5VrN1peOu
         UG+UjHiD39AnELbsGIU/CkJ3cZ/XF7dTugFNS/VyqoyHfZ42FEhOFPgU6Du6iAUU1Cwc
         xbVA==
X-Forwarded-Encrypted: i=1; AJvYcCVOL6p1FvMXNUOz7lJZfSi70GKlIGg3Vuuysz1fh1umqMw+ilVdtZP5sTBqHkq3RNDqk1puQXNOpgh9YHk=@vger.kernel.org, AJvYcCXJOXr6pfWzK7wiUnZGegtTrOgvMtWfd1W74vFG16KO4XOpIbW+lr/btRy5Onbi12nTbTVY+ORLMJj+SDseLqnlkHaJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi/1oSoX9eBrOkZuBOl14L0jQanbfVOtLV1c8s2XdCTAquy4gK
	Qv0Z2iMRzqswm6laQmQ/xzW7gs21mDf4zgtXp6cYGmIgLZ+pPkdv0ui8
X-Gm-Gg: ASbGncvXpUX++FMQi8+t9to2Q+qybKbkRHf+57xaHULpuQnSkkEYsylbjik4Nsqx7wU
	J5PzUvFpTMy3E2RK3SNikHDum18il59rndAXi1XvQ5PHTJdEHLolov6nOwunpUYKNP5CrSVn5KN
	Tv5bbWOxnj9FF5Hw7N0+vkxc6GZdrXRH1bngKPOxF6OwUcVixHnC9C/W3ZpC5fpiZciPurne5Aa
	kAn8PiQZh4DzcO0119yfYiQdQ0i/1VOBnUg6zYFCv0PUyyCz/s8Qp3dqV48vK9qDN8WxtmD5vlW
	DtEoo+pNhbl4Iz5+Qrov3PUr4fd92g8V62HW5yr0Tb/TepKyR443my+Zb2Vu4kCFSyb3rhhQHqn
	oeTDJLRijKhlA8Xm43pqaBxpxJIQjBptWaE0K4Rs=
X-Google-Smtp-Source: AGHT+IHXzJWZrBcfPUQBTA8CFaDhfN1gN+ubTm3VPS35j5MVL7+7/Ca6H/QcEcvKVgWMeEKXBh02eQ==
X-Received: by 2002:a17:902:e88b:b0:243:a16:18f2 with SMTP id d9443c01a7336-24478ed53d7mr115333695ad.11.1755520124305;
        Mon, 18 Aug 2025 05:28:44 -0700 (PDT)
Received: from localhost.localdomain ([2604:a840:3::3008])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d57f12esm79236705ad.157.2025.08.18.05.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:28:43 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: akpm@linux-foundation.org
Cc: mhiramat@kernel.org,
	naveen@kernel.org,
	davem@davemloft.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 10/13] mm/kstackwatch: Handle nested function calls
Date: Mon, 18 Aug 2025 20:26:15 +0800
Message-ID: <20250818122720.434981-11-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818122720.434981-10-wangjinchao600@gmail.com>
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
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for watching specific depths of nested function calls.
The Kernel Stack Watch tool currently watchs the first entry of a probed
function, but this is insufficient for functions that are called recursively or
that call themselves indirectly.

To address this, a per-CPU variable `monitor_depth` is introduced to track
the nesting level of the function being watched. When a function's entry
handler is triggered, the depth is incremented, and the tool only arms the
hardware breakpoint if the current depth matches the configured `depth`.
The exit handler decrements the depth, disarming the breakpoint on the
correct return.

This ensures the watch mechanism only activates at the desired nesting level,
making the tool more precise and versatile for debugging complex stack issues.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/stack.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
index ba5280787e8f..86847c2e4506 100644
--- a/mm/kstackwatch/stack.c
+++ b/mm/kstackwatch/stack.c
@@ -6,6 +6,8 @@
 
 #include "kstackwatch.h"
 
+/* Per-CPU watching state */
+static DEFINE_PER_CPU(int, monitor_depth);
 struct ksw_config *probe_config;
 
 /* Find canary address in current stack frame */
@@ -120,10 +122,22 @@ static struct kretprobe exit_probe;
 static void ksw_stack_entry_handler(struct kprobe *p, struct pt_regs *regs,
 				    unsigned long flags)
 {
+	int *depth, cur_depth;
 	int ret;
 	u64 watch_addr;
 	u64 watch_len;
 
+	/* Handle nested calls - only monitor outermost */
+	depth = this_cpu_ptr(&monitor_depth);
+	cur_depth = (*depth)++;
+
+	if (cur_depth != probe_config->depth) {
+		/* depth start from 0 */
+		pr_info("KSW: config_depth:%u cur_depth:%d skipping %s\n",
+			probe_config->depth, cur_depth, __func__);
+		return;
+	}
+
 	/* Setup breakpoints for all active watches */
 	ret = ksw_stack_prepare_watch(regs, probe_config, &watch_addr,
 				      &watch_len);
@@ -136,14 +150,25 @@ static void ksw_stack_entry_handler(struct kprobe *p, struct pt_regs *regs,
 		pr_err("KSW: Failed to arm hwbp: %d\n", ret);
 		return;
 	}
-	pr_info("KSW: Armed for %s at addr:0x%llx len:%llu\n",
-		probe_config->function, watch_addr, watch_len);
+	pr_info("KSW: Armed for %s at depth %d addr:0x%llx len:%llu\n",
+		probe_config->function, cur_depth, watch_addr, watch_len);
 }
 
 /* Function exit handler */
 static int ksw_stack_exit_handler(struct kretprobe_instance *ri,
 				  struct pt_regs *regs)
 {
+	int *depth, cur_depth;
+
+	depth = this_cpu_ptr(&monitor_depth);
+	cur_depth = --(*depth);
+	if (cur_depth != probe_config->depth) {
+		/* depth start from 0 */
+		pr_info("KSW: %s config depth:%u cur_depth:%d skipping\n",
+			__func__, probe_config->depth, cur_depth);
+		return 0;
+	}
+
 	ksw_watch_off();
 	pr_info("KSW: Disarmed for %s\n", probe_config->function);
 
@@ -153,6 +178,13 @@ static int ksw_stack_exit_handler(struct kretprobe_instance *ri,
 int ksw_stack_init(struct ksw_config *config)
 {
 	int ret;
+	int cpu;
+	int *depth;
+
+	for_each_possible_cpu(cpu) {
+		depth = per_cpu_ptr(&monitor_depth, cpu);
+		WRITE_ONCE(*depth, 0);
+	}
 
 	/* Setup entry probe */
 	memset(&entry_probe, 0, sizeof(entry_probe));
-- 
2.43.0

