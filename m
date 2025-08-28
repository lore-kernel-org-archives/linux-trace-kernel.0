Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6385A2E1C6B;
	Thu, 28 Aug 2025 07:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366472; cv=none; b=pLtyTcczhVwG0bp3aVx85PQnj09sS0gUAW0+VWzciGPjVk4HWcRDYR+7WzG8IBhZjuQAXacx18Lff7VGmbvdYW1FOQgn5DAhumT6P5Llg96dp5/MjuJhLQVnrvU4acUtBTV6J465wYWzGScCQ4pTAQ0OtUxhUlv0AxFl/cyfOUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366472; c=relaxed/simple;
	bh=G+A4eJnc065fB8b3BnxhobbmRRvCRJMPpENJLlV5vgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3LSGroShYhiajuLph8CLq+7jKKL9iIR0nGwTgvUcDTsN2XfFpaVgBNFGsyJz6TTOuN/yGDlj5llT+g2ttE81+pRWp9xf84+/+elumNx8lUP3yBzVO7D/vsub8FYpSYRAYC2h3pD7kIY7iDRPuY/ej6QF6MN01zjpfkLqhzsp+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewrAO3YU; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewrAO3YU"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-771ff6f117aso636896b3a.2;
        Thu, 28 Aug 2025 00:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756366470; x=1756971270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhYtCOUm6bvq4qZIRBPhvFj01jBGWvLGzlXSp/AiWds=;
        b=ewrAO3YU0v8IP0rz0CD67lcAjOg8lsRaNg2HjP/1DJaldEc/942JSsHHSfTa8EEyLN
         ZfkHIEAK4thnlsGGorjOTgPGwpekJYBcI4HSiM6wpNC2eoF/OZBdJeVO9KHk6B+LHKP2
         v5qBN113TX/eCC/G6/sNefoxWzBBhJMCH8t4DG0wzcv2F4nnTSpnNvIYQcg2RHzbK6L0
         A6IdxpM9Y3Fjaljg11Foh8KQMv8r6aP7kMIwaGw36v1EfofUjA3fvQ64qCYvlq80An9r
         wQiX6i98FP8bYYKTgIHIrgyG84qsMPSIxo7Trx3uqk1iWdeZewTUvPyCyL7b79/wlR2p
         /vJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366470; x=1756971270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhYtCOUm6bvq4qZIRBPhvFj01jBGWvLGzlXSp/AiWds=;
        b=PyvLRKb8rJ6HSmphRYz6Yb82pfaY2d2gOudny6xZijgnus0Nfm/GrqFhlfA0tjaFJ5
         XPuv7AvpTbc55yvjmArI1Q21mjHBwpZA9Kk33U29me169/HDLzjScVLBv9QYafh02luT
         gCMyw99+GMgvznO/Yf6efws+swS4zLvw28Rim0wvNpDXhuF1GB+6Uf9AwvIoFmtDKnAc
         1HvKcfAWcp/DGw1VR6/0zPS51214woShmFBMuxoPtp1mRjpzCYEce4WGvFJ0s68KNcfd
         d1yDZEkNfEAETGPJGffHu26b/rCDAEPpMYLycya6piKR192KMjd8GHUEJDW5HU5Ibvaz
         s2bA==
X-Forwarded-Encrypted: i=1; AJvYcCWKAw1aACgYei+dUbA1mgLev742CatGdDkYi1C0dfaYdCejlHDQ2uWSQYKQDN5a+EHY43nwFxxLjGFqnDms0lQgZkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvcEpR/IAy4m5M7esh8R5bhhidJI7XAJAFBc4NBxFq70ryjzLL
	YKbYJW5t0hKmqrUiBwBYJPwvCFpXLstCzlAoZlxg7r5hahqUJpFrLeqI
X-Gm-Gg: ASbGncvk8PTlm/oexWpqqJIO7pBwtpsDlwwGjx6HToVYvjZpFJI0VvYRU4eOJgsaa3F
	uuDoFdCQ2TqOeEfZs5/Ub4qqJyniMbU36F0uFcCPaMccK1w088SX/mFkwVHPbYdaM4s8FvSOx1H
	yrs0/7vkfKGq0VDEdbuylUQJCUavkdaRatz1mbOf61hdDkT5i1qmJ0m62AJEBJV7iMMtf9cCIqB
	uQJqeSmj4zYbTAtDwcVR4wQbPCaCXjQ43LbodSxCLab+1MC/ly3It0KSftfIDffLgBbAiVIw+8C
	1WhbkukZ8L025BRH6AW1BHOzIHIGTC9ZY8Ha20mXSmqo+lFTuPkvMXBw2DmhXtitrJ1lrmCMmL9
	vAnxSLQVn1mr79dg7AP28lINfqy1q6VDxNZNsvTiBMdEZcFaIcIMJ2ZCNSpUi
X-Google-Smtp-Source: AGHT+IGixiCEjVcYHcne/aHNIr1QDzxbqM5oGrgRGi2xpynpf2i3z8+aAxOQ92IXbm+/nHFvDKB7rA==
X-Received: by 2002:a05:6a21:33a8:b0:243:b0fb:7086 with SMTP id adf61e73a8af0-243b0fb711fmr1251757637.4.1756366470529;
        Thu, 28 Aug 2025 00:34:30 -0700 (PDT)
Received: from localhost.localdomain ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8afb7bsm13182613a12.16.2025.08.28.00.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:34:30 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 06/17] mm/ksw: add atomic watch on/off operations
Date: Thu, 28 Aug 2025 15:32:39 +0800
Message-ID: <20250828073311.1116593-7-wangjinchao600@gmail.com>
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

Add support to atomically turn the hardware watch on and off without
allocation overhead.

The watch is pre-allocated and later retargeted using
arch_reinstall_hw_breakpoint(). The current CPU is updated directly, while
other CPUs are updated asynchronously via smp_call_function_single_async().

This allows KStackWatch to switch the watch in kprobe/fprobe handlers.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |  2 +
 mm/kstackwatch/watch.c       | 99 ++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 2318779bde70..13ef8c79f855 100644
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
index e7ed88700b49..284facaac8fc 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -16,9 +16,21 @@
 
 struct perf_event *__percpu *watch_events;
 struct ksw_config *watch_config;
+static DEFINE_SPINLOCK(watch_lock);
 
 static unsigned long long watch_holder;
 
+static struct watch_info {
+	u64 addr;
+	u64 len;
+} watch_info;
+
+static void ksw_watch_on_local_cpu(void *info);
+
+static DEFINE_PER_CPU(call_single_data_t,
+		      watch_csd) = CSD_INIT(ksw_watch_on_local_cpu,
+					    &watch_info);
+
 static void ksw_watch_handler(struct perf_event *bp,
 			      struct perf_sample_data *data,
 			      struct pt_regs *regs)
@@ -32,6 +44,93 @@ static void ksw_watch_handler(struct perf_event *bp,
 		panic("KSW: Stack corruption detected");
 }
 
+/*
+ * set up watchon current CPU
+ * addr and len updated by ksw_watch_on() already
+ */
+static void ksw_watch_on_local_cpu(void *data)
+{
+	struct perf_event *bp;
+	struct watch_info *watch_info = data;
+	int cpu = smp_processor_id();
+	int ret;
+
+	bp = *per_cpu_ptr(watch_events, cpu);
+	if (!bp)
+		return;
+	bp->attr.bp_addr = watch_info->addr;
+	bp->attr.bp_len = watch_info->len;
+	ret = hw_breakpoint_arch_parse(bp, &bp->attr, counter_arch_bp(bp));
+	if (ret) {
+		pr_err("KSW: failed to validate HWBP for CPU %d ret %d\n", cpu,
+		       ret);
+		return;
+	}
+	ret = arch_reinstall_hw_breakpoint(bp);
+	if (ret) {
+		pr_err("KSW: failed to reinstall HWBP on CPU %d ret %d\n", cpu,
+		       ret);
+		return;
+	}
+
+	if (bp->attr.bp_addr == (unsigned long)&watch_holder) {
+		pr_debug("KSW: watch off CPU %d\n", cpu);
+	} else {
+		pr_debug("KSW: watch on CPU %d at 0x%px (len %llu)\n", cpu,
+			 (void *)bp->attr.bp_addr, bp->attr.bp_len);
+	}
+}
+
+int ksw_watch_on(u64 watch_addr, u64 watch_len)
+{
+	unsigned long flags;
+	int cpu;
+
+	if (!watch_addr) {
+		pr_err("KSW: watch with invalid address\n");
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&watch_lock, flags);
+
+	/*
+	 * check if already watched
+	 */
+	if (watch_info.addr != 0 && // not uninit
+	    watch_info.addr != (unsigned long)&watch_holder && // installed
+	    watch_addr != (unsigned long)&watch_holder) { //not restore
+		spin_unlock_irqrestore(&watch_lock, flags);
+		return -EBUSY;
+	}
+
+	watch_info.addr = watch_addr;
+	watch_info.len = watch_len;
+
+	spin_unlock_irqrestore(&watch_lock, flags);
+
+	if (watch_addr == (unsigned long)&watch_holder)
+		pr_debug("KSW: watch off starting\n");
+	else
+		pr_debug("KSW: watch on starting\n");
+
+	for_each_online_cpu(cpu) {
+		if (cpu == raw_smp_processor_id()) {
+			ksw_watch_on_local_cpu(&watch_info);
+		} else {
+			call_single_data_t *csd = &per_cpu(watch_csd, cpu);
+
+			smp_call_function_single_async(cpu, csd);
+		}
+	}
+
+	return 0;
+}
+
+void ksw_watch_off(void)
+{
+	ksw_watch_on((unsigned long)&watch_holder, sizeof(watch_holder));
+}
+
 int ksw_watch_init(struct ksw_config *config)
 {
 	struct perf_event_attr attr;
-- 
2.43.0

