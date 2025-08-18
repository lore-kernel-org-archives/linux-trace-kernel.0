Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E25031AF08;
	Mon, 18 Aug 2025 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520095; cv=none; b=c//TO9X52I6x6f6W850MXB/n0+rtqbJj9qU8DOYsnJRniEKgdYLc2frIiXsM3g/tcESG8wsVNmttL7Ror5Yhz6noGAHNpsN6shkrXfqYhwQ/8UJnjlBPMlsfjc/AXu1DYYzDh7twVEjiiPHa1FOMwcn3FcLLtNLvks145rkTDes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520095; c=relaxed/simple;
	bh=ASfq6C3K/rqqvNPKHiPjEXM2Xk/jxCJ5YCiFB6r7ORs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKTAebvK7TCqRH3yZx0evl5kjdDbpXphG3fJTokdr7ZdMMR2FCuOi0U7rfVyF54fLYfaMDTThbkpeMi0+04DwxLZ6cKvK/E5ZsyxDLV/ujrXJBF1dwyl7TIX4r4kJ4UTA1fEUnT8ozGOqx4wLbc1WXGq4e1DwSRDvKcnU+Ws0XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQvMnnWq; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQvMnnWq"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b47173a7e52so2520041a12.1;
        Mon, 18 Aug 2025 05:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755520093; x=1756124893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3whJbVs1RtzB6J09uoknRyw25Li/I301mnKhoaueOI=;
        b=IQvMnnWqi7Y0BnxJ7wPPk1FU1zH4d5RDNeGBs19X/ICTo8TkA4Y2wdnBaRRnpZkgu3
         EMO+rhVENU2/QXuoTqzThvTsYJfUJbmMtkqfsXa0r73EEO7S9sqTr0hysdopC77bdfRM
         0Pdux+FpXmgINM9E4ZLemHb8gv24Dh/P8/Q7zR8c2mHQ8nCEB6IuMlo1dGRt1/wujlqV
         jf+pGbZsM7RfICWGE96XkmTdb0ibHrGCx2u+VxWmxNUKYWCiZY5a/0a+nUeHEZ4hp8tj
         ODt7CMIqqRayVoTNexFFslPidZbSOMV2KUPgPy5QtoFLiaaOixgF6CACWqcsRRVihSil
         D8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520093; x=1756124893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3whJbVs1RtzB6J09uoknRyw25Li/I301mnKhoaueOI=;
        b=wcsWIBRafLlnhZEJRM9yTNn66umoa0gPxHt6Nrklrm/o1U8Ysd6DwZO8TvWjL5bC4W
         Ds4UWZWWggGdhhCYnFj+ffuPNHHNX8w5sqwetKE9Ujl6xWR2nD4R+TFBqwrb2J6kTDbK
         DwmtQEcFnBCpCcfDgzPBOxnJF9HzuPXgR0yHFHSGOlSwSzgAxkVL+M/ZAxXz4TaDjycy
         h+IygeIE/4/4RCGmDLETDAIgzylQq6bxtx2CrkqjmpS3czTNZby9LxkZPQtVH4D9YWQk
         m99IBcj7O2PgXytW4/5QB/h6BDO4E7tkV7ZTyWZFdJseXev36wZkOTEMp9ITniOgU+/L
         Jm/A==
X-Forwarded-Encrypted: i=1; AJvYcCU73WkXugb4Sv/PzmtI2YmHaQy/wzgcvVUV10SWSkV8qJRiAn+YoHRaqHJdZ8KKYDFAzYFjXGlWZ/7fD0O6LCIcPlxx@vger.kernel.org, AJvYcCVkY7IVB7QOZdh4mVC1htbAqkwa/eQVEQxxcG+dBurvQvJDKK5NAo7vPBGoJkN1KKI40twOqrYprgD9jQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyfbcirtNFFP9kMNhW7aLZ3SUopHByeEw6IRm3njTt6Zd5s5JD
	CfRS7V+zUyHdxTsrvZnHJXkx81TRyMR0WpRb6MNekfve50UvYpW+CwxHUYFVXLAofn2Wzw==
X-Gm-Gg: ASbGnctUeZohpApH7MRHXJ9/GI6ZiYMp7KcZSJdp6gNN7V+IcZt5/x0HoK1jMTSkARC
	pG8tt6u0hWdeNk9X5QGBy0sOO3JF5hCT5+apc2kb7yNxEZ7seKlbrIVbl7lnpbWkDSPO1LWnBvO
	yb8ueTDfv423u5BDjCQGB4yQ1AtkD/evlRZU098H/uA7JAkYAwAyRO4ZTScRvt8fynZPzN3w7zT
	UZIZwS4u8Wbs0O/sw6JByuDoQqESJ+2lxRfRM3FWsXiWBcjdhLPwyBWsDfm/ecguSOdfT1qCF1A
	SKyESDHh98jUhA+uLmyCR+WxP+8Tm6pLhbRJEj2ZbpxbzJN7v5RB6yHaGO2ziLKbh2fLzQ3d5TK
	HIv0uaFfk7sEffwkqFu3gySSWnMuBwi0Xxw==
X-Google-Smtp-Source: AGHT+IGxA0E5xL2osqL27bjm0GUQZLO/NaRbdp5NYm8Z6D4qUp3F2l3VtGBaNY4j32I343W5VA3Y3w==
X-Received: by 2002:a17:903:1ce:b0:240:79ef:ae80 with SMTP id d9443c01a7336-24478ed7625mr116941915ad.8.1755520093352;
        Mon, 18 Aug 2025 05:28:13 -0700 (PDT)
Received: from localhost.localdomain ([2604:a840:3::3008])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d57f12esm79236705ad.157.2025.08.18.05.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:28:12 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: akpm@linux-foundation.org
Cc: mhiramat@kernel.org,
	naveen@kernel.org,
	davem@davemloft.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 05/13] mm/kstackwatch: Add atomic HWBP arm/disarm operations
Date: Mon, 18 Aug 2025 20:26:10 +0800
Message-ID: <20250818122720.434981-6-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818122720.434981-5-wangjinchao600@gmail.com>
References: <20250818122720.434981-1-wangjinchao600@gmail.com>
 <20250818122720.434981-2-wangjinchao600@gmail.com>
 <20250818122720.434981-3-wangjinchao600@gmail.com>
 <20250818122720.434981-4-wangjinchao600@gmail.com>
 <20250818122720.434981-5-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the critical atomic operations for dynamically arming and
disarming hardware breakpoints across all CPUs without allocation
overhead.

This patch adds the core functionality that enables kstackwatch to
operate in atomic contexts (such as kprobe handlers):

Key features:
1. ksw_watch_on() - Atomically arm breakpoints on all CPUs with
   specified address and length
2. ksw_watch_off() - Disarm all breakpoints by resetting to dummy marker
3. HWBP updates using arch_reinstall_hw_breakpoint()
4. SMP-safe coordination using work queues and async function calls

The implementation uses a hybrid approach for SMP coordination:
- Current CPU: Direct function call for immediate effect
- Other CPUs: Asynchronous smp_call_function_single_async() for
  non-blocking operation in queue worker

This enables the kprobe handlers (added in subsequent patches) to
instantly arm breakpoints on function entry and disarm on exit,
providing real-time stack corruption detection without the performance
penalties or atomic context limitations of traditional approaches.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |   2 +
 mm/kstackwatch/watch.c       | 118 +++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 256574cd9cb2..910f49014715 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -41,5 +41,7 @@ extern bool panic_on_catch;
 /* watch management */
 int ksw_watch_init(struct ksw_config *config);
 void ksw_watch_exit(void);
+int ksw_watch_on(u64 watch_addr, u64 watch_len);
+void ksw_watch_off(void);
 
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index 5cc2dfef140b..7ab247531961 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+
+#include "linux/printk.h"
 #include <linux/kprobes.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/perf_event.h>
@@ -11,11 +13,24 @@
 
 #include "kstackwatch.h"
 
+#define MAX_STACK_ENTRIES 64
+
 struct perf_event *__percpu *watch_events;
 struct ksw_config *watch_config;
+static DEFINE_SPINLOCK(watch_lock);
 
 static unsigned long long marker;
 
+struct watch_worker {
+	struct work_struct work;
+	int original_cpu;
+} myworker;
+
+static void ksw_watch_on_local_cpu(void *useless);
+
+static DEFINE_PER_CPU(call_single_data_t,
+		      hwbp_csd) = CSD_INIT(ksw_watch_on_local_cpu, NULL);
+
 /* Enhanced breakpoint handler with watch identification */
 static void ksw_watch_handler(struct perf_event *bp,
 			      struct perf_sample_data *data,
@@ -31,6 +46,59 @@ static void ksw_watch_handler(struct perf_event *bp,
 		panic("KSW: Stack corruption detected");
 }
 
+/* Setup single hardware breakpoint on current CPU */
+static void ksw_watch_on_local_cpu(void *useless)
+{
+	struct perf_event *bp;
+	int cpu = smp_processor_id();
+	int ret;
+
+	bp = *per_cpu_ptr(watch_events, cpu);
+	if (!bp)
+		return;
+
+	/* Update breakpoint address */
+	ret = hw_breakpoint_arch_parse(bp, &bp->attr, counter_arch_bp(bp));
+	if (ret) {
+		pr_err("KSW: Failed to parse HWBP for CPU %d ret %d\n", cpu,
+		       ret);
+		return;
+	}
+	ret = arch_reinstall_hw_breakpoint(bp);
+	if (ret) {
+		pr_err("KSW: Failed to install HWBP on CPU %d ret %d\n", cpu,
+		       ret);
+		return;
+	}
+
+	if (bp->attr.bp_addr == (unsigned long)&marker) {
+		pr_info("KSW: HWBP disarmed on CPU %d\n", cpu);
+	} else {
+		pr_info("KSW: HWBP armed on CPU %d at 0x%px (len %llu)\n", cpu,
+			(void *)bp->attr.bp_addr, bp->attr.bp_len);
+	}
+}
+
+static void ksw_watch_on_work_fn(struct work_struct *work)
+{
+	struct watch_worker *worker =
+		container_of(work, struct watch_worker, work);
+	int original_cpu = READ_ONCE(worker->original_cpu);
+	int local_cpu = smp_processor_id();
+	call_single_data_t *csd;
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		if (cpu == original_cpu)
+			continue;
+		if (cpu == local_cpu)
+			continue;
+		csd = &per_cpu(hwbp_csd, cpu);
+		smp_call_function_single_async(cpu, csd);
+	}
+	ksw_watch_on_local_cpu(NULL);
+}
+
 /* Initialize hardware breakpoint  */
 int ksw_watch_init(struct ksw_config *config)
 {
@@ -50,6 +118,8 @@ int ksw_watch_init(struct ksw_config *config)
 		return ret;
 	}
 
+	/* Initialize work structure */
+	INIT_WORK(&myworker.work, ksw_watch_on_work_fn);
 	watch_config = config;
 	pr_info("KSW: HWBP  initialized\n");
 	return 0;
@@ -63,3 +133,51 @@ void ksw_watch_exit(void)
 
 	pr_info("KSW: HWBP  cleaned up\n");
 }
+
+/* Legacy API: Arm single hardware breakpoint (backward compatibility) */
+int ksw_watch_on(u64 watch_addr, u64 watch_len)
+{
+	struct perf_event *bp;
+	unsigned long flags;
+	int cpu;
+
+	if (!watch_addr) {
+		pr_err("KSW: Invalid address for arming HWBP\n");
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&watch_lock, flags);
+
+	/* Check if already armed - only need to check one CPU since all share same addr */
+	bp = *this_cpu_ptr(watch_events);
+	if (bp->attr.bp_addr != 0 &&
+	    bp->attr.bp_addr != (unsigned long)&marker && // installted
+	    watch_addr != (unsigned long)&marker) { //restore
+		spin_unlock_irqrestore(&watch_lock, flags);
+		return -EBUSY;
+	}
+
+	/* Update address in all minimal breakpoint structures */
+	for_each_possible_cpu(cpu) {
+		bp = *per_cpu_ptr(watch_events, cpu);
+		WRITE_ONCE(bp->attr.bp_addr, watch_addr);
+		WRITE_ONCE(bp->attr.bp_len, watch_len);
+	}
+
+	WRITE_ONCE(myworker.original_cpu, smp_processor_id());
+
+	spin_unlock_irqrestore(&watch_lock, flags);
+
+	/* Then install on all CPUs */
+	/* Run on current CPU directly */
+	queue_work(system_highpri_wq, &myworker.work);
+	ksw_watch_on_local_cpu(NULL);
+	return 0;
+}
+
+void ksw_watch_off(void)
+{
+	pr_info("KSW: Disarming all HWBPs\n");
+	ksw_watch_on((unsigned long)&marker, sizeof(marker));
+	pr_info("KSW: All HWBPs disarmed\n");
+}
-- 
2.43.0

