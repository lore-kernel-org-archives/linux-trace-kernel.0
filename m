Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9692320CCD;
	Mon, 18 Aug 2025 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520089; cv=none; b=RjrJ+OFde11QWC7GOLVnogY3n0nC9F531LNqrl2OIBqGSYCgr87WbZRe33wLgQntfxTO/uIu49FEDjwsuq8d+b9FQbimL3XAt0EsMgQQfDVNZCN/g3gkBM5vyrGnH+H4WyRbdhLmu136DGMewBjsc8XnIc3gDXNbBH0Mt44lhYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520089; c=relaxed/simple;
	bh=YCYtLfiF4WdBpCuqB8n3l/QuYgACvtuG9Byn22/FOxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTOi+VPvvu8hcub/kxfzR8bq6CenpiclEuwbIXNOWPd22oi6Z0J31F1i7QTMxxNDLjhmcd4+HqiB1Ks1KcFRUWQ3GOwdQKHMlo5eL+2Z4PsGXu253A+/t1L3EfxOXVT9/2bBuR/P3Ax6MfrjHaGxFYRjDtVwfBiCCrIsWpFi+3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNQyTBEy; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNQyTBEy"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24457f53d2eso48088125ad.0;
        Mon, 18 Aug 2025 05:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755520087; x=1756124887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5r/rBnlrAz2JUShBcJhJko8UNnWxU7/GIOhEksecdws=;
        b=fNQyTBEyl3mHcYXmA0L3e+aU3XtQLHYpn3MULKDUxv9FnPcvn5ziEQ3jNCf/+A9hJB
         ivCISRN2DQqJMD9KuIcuQYvAxqEGlovkeiKhfjAle0LxP3N5+W3qJIDgRL201FLoKDwA
         xSEuO3+TcBsv/41eJgQFfV100bfXFGS89J+gzxgYhrCmMO678xNdsYT9H7VMvh1hK1eM
         0oOPrCovr1RA+xUo1AjviacdMdc+D1xdhF8QrLONt0skhA+KErcs+SBA2x1RC7xFW+Fz
         sD6cROk4aqY5RLkyDQwLDtxfQQVs+qvVbBTRmr/FUqwtXKugyqTd6UoZ9nKYyoXS5ygs
         n62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520087; x=1756124887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5r/rBnlrAz2JUShBcJhJko8UNnWxU7/GIOhEksecdws=;
        b=vXuhaesFM8jWyHNIBRmscDkKlu/09gxWA1JTDmwKKIpFsOa8qTtjaniVK1PZ18kyf4
         f+UftTMLBauTVrpHgfJZcpkpoFW/DgXYRMFJQzrNPEXX333+QfsHiTTknNc6TpbcXMrt
         jHR2QxAPjjRQ1ogrEoozYs+nIwC2inHHAmazKjEdVy5xMB9Tcnchm6F0hLs/j8msQpV6
         qx5yAZmIDbq6EDTCB2PhCXLt+J/bRSmSJ4XkMBz7G9dM6Iwz6PlAbL4U+kkjIjgVRQvm
         /wtqJhP2Q8GPAvoFucsUlCW8+Lkju+qB1nvqYV9RxAv53t70s4o03Da+wyyeaMX01e4y
         KOvg==
X-Forwarded-Encrypted: i=1; AJvYcCVOopGyZCOeQCjLo65fGXirQl89+NKKGTyqKZGxaP7MF1f1ZXmrhrpRERrGoc5BtWKJ/lXxVsbCPSNqCDo=@vger.kernel.org, AJvYcCVwqB+mUCHqATuzlSmiq5QRdRm08upqfp9/dU9T3I2Qs7W4D/zJGSjy2eb+d+//Rzg8rB0iBxAIiL31XdlCfI40cXz2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+UgvRdDt0RkihdR39FhQGtE1OZ8pJ5fZVOpkwI/HU8v4zRV3a
	RilW4d6VZsUbmyfjWefCpsKD675074EjztWkwjSqcpUptNUskxz9ETD9
X-Gm-Gg: ASbGncsGv8QoMx3jFmYBsFXqMF4EknbukrHXADeWEYrqIauW4MliBhGCJQHOEV4cCVp
	7008f4nnb9wP8FR9JmzBkmqANAD3zXozWYcIFDMkAnQmeqik4wcDMIpkJ5lfxp9du8mX3jzsOzR
	e0uEe59qYu5YaNqzyxaVbTfbPXQ3F50F3boVuk60N9JmPF+kO7ZlAuRGRB6RcxW7wa3AX4vtdD2
	3uQhmqsXQxxwlpgvn1Nj3/8m8kbVzfloiz3lpKP19557cDVjnytndfB8ZfhtNrK4a/XdAvICIPu
	14WE28EOCbpYy9nsWkNdqsa6qlL7DLETgqZv9k1s0lQqOY0we+9ZK/4H/T4wImt/cXHVa8Hu2RP
	Gg+/RaJ2GnvMWJ59FWICcvsHHd0v7WeXoaw==
X-Google-Smtp-Source: AGHT+IGHyYvjw3/xjKEbFWxvWOpN+yD20ay733SJj1UymheSVFiMUKAid/csXjqcmpErxiXXOowrqw==
X-Received: by 2002:a17:902:e5cc:b0:235:15f5:cc30 with SMTP id d9443c01a7336-2446d738d05mr145756665ad.16.1755520086807;
        Mon, 18 Aug 2025 05:28:06 -0700 (PDT)
Received: from localhost.localdomain ([2604:a840:3::3008])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d57f12esm79236705ad.157.2025.08.18.05.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:28:06 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: akpm@linux-foundation.org
Cc: mhiramat@kernel.org,
	naveen@kernel.org,
	davem@davemloft.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 04/13] mm/kstackwatch: Add HWBP pre-allocation infrastructure
Date: Mon, 18 Aug 2025 20:26:09 +0800
Message-ID: <20250818122720.434981-5-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818122720.434981-4-wangjinchao600@gmail.com>
References: <20250818122720.434981-1-wangjinchao600@gmail.com>
 <20250818122720.434981-2-wangjinchao600@gmail.com>
 <20250818122720.434981-3-wangjinchao600@gmail.com>
 <20250818122720.434981-4-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the core HWBP management for kstackwatch with
pre-allocation strategy to enable atomic context operation.

This patch introduces the fundamental breakthrough that allows kstackwatch
to work in atomic contexts: pre-allocating hardware breakpoints across
all CPUs during initialization, then using arch_reinstall_hw_breakpoint()
to atomically update breakpoint targets without allocation overhead.

Key features:
- Pre-allocate per-CPU hardware breakpoints using register_wide_hw_breakpoint()
- Initialize with a dummy marker address that will be dynamically updated
- Comprehensive corruption detection handler with register dumps and
  optional panic trigger
- Clean resource management on module exit

The pre-allocation approach is critical because:
1. Hardware breakpoint allocation can fail or sleep in atomic contexts
2. kprobes run in atomic context where allocation is not permitted
3. Pre-allocated breakpoints can be instantly retargeted using
   arch_reinstall_hw_breakpoint() without any blocking operations

This foundation enables the subsequent kprobe integration to atomically
arm/disarm breakpoints on function entry/exit, providing real-time
stack corruption detection without the limitations of traditional
allocation-based approaches.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |  6 ++++
 mm/kstackwatch/watch.c       | 65 ++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index f58af36e64a7..256574cd9cb2 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -36,4 +36,10 @@ struct ksw_config {
 	char config_str[MAX_CONFIG_STR_LEN];
 };
 
+extern bool panic_on_catch;
+
+/* watch management */
+int ksw_watch_init(struct ksw_config *config);
+void ksw_watch_exit(void);
+
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index e69de29bb2d1..5cc2dfef140b 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kprobes.h>
+#include <linux/hw_breakpoint.h>
+#include <linux/perf_event.h>
+#include <linux/sched/debug.h>
+#include <linux/smp.h>
+#include <linux/slab.h>
+#include <asm/hw_breakpoint.h>
+#include <linux/stacktrace.h>
+#include <linux/delay.h>
+
+#include "kstackwatch.h"
+
+struct perf_event *__percpu *watch_events;
+struct ksw_config *watch_config;
+
+static unsigned long long marker;
+
+/* Enhanced breakpoint handler with watch identification */
+static void ksw_watch_handler(struct perf_event *bp,
+			      struct perf_sample_data *data,
+			      struct pt_regs *regs)
+{
+	pr_emerg("========== KStackWatch: Caught stack corruption =======\n");
+	pr_emerg("KSW: config %s\n", watch_config->config_str);
+	show_regs(regs);
+	pr_emerg("========== KStackWatch End ==========\n");
+	mdelay(100);
+
+	if (panic_on_catch)
+		panic("KSW: Stack corruption detected");
+}
+
+/* Initialize hardware breakpoint  */
+int ksw_watch_init(struct ksw_config *config)
+{
+	struct perf_event_attr attr;
+
+	/* Initialize default breakpoint attributes */
+	hw_breakpoint_init(&attr);
+	attr.bp_addr = (unsigned long)&marker;
+	attr.bp_len = HW_BREAKPOINT_LEN_8;
+	attr.bp_type = HW_BREAKPOINT_W;
+	watch_events =
+		register_wide_hw_breakpoint(&attr, ksw_watch_handler, NULL);
+	if (IS_ERR((void *)watch_events)) {
+		int ret = PTR_ERR((void *)watch_events);
+
+		pr_err("KSW: Failed to register wide hw breakpoint: %d\n", ret);
+		return ret;
+	}
+
+	watch_config = config;
+	pr_info("KSW: HWBP  initialized\n");
+	return 0;
+}
+
+/* Cleanup hardware breakpoint  */
+void ksw_watch_exit(void)
+{
+	unregister_wide_hw_breakpoint(watch_events);
+	watch_events = NULL;
+
+	pr_info("KSW: HWBP  cleaned up\n");
+}
-- 
2.43.0

