Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABA73191C6
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508343; cv=none; b=bshVCLQh3mSb9opw4VrAUh2Eltvgw1Frr4UfV4KFxK5nW3RVDoNM08V5dwPNgNUDfKg6PCurx2NoH/MIbTkntUAQFenS04jnvBCMXDcAXxPks2VihThZVvgvHAw1CvT110xVWhn0B9cPJzbMZAF0VWZnDjuQEMkSvIm+u61ALWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508343; c=relaxed/simple;
	bh=/vy5uLDK+8QdZFVLntYf/T3M7mD3MPzgFZDgNJQ3D/Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mfXel7g+aIFm25Qektpv9Z/uQXk11Y8qgCBP3C/m4/6T0miHiBAC/s+JHMwk8eDnPrmHULE358b5AAcICcFqz6dE2pHgEWZTNnt1u/KjEfsTdzog4ZR4gZxK3D6PlNm5L3fcMcsn7/Ghd9aZXvhGgOdreTudTOIkZTIEhFk4Ess=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mrfti16h; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mrfti16h"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4773e108333so3069265e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762508340; x=1763113140; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rgw5xcElE8xbfMxk4XfNC90+k3Bbs57tvUPtv7wwrm4=;
        b=mrfti16hPgKE4oTm6hxM+yEnbPyL8FWo/R33EKQSqSoU8RbPe5RYlBOg2OjkhdxQBG
         ADzIi9dR17s/eIpfCauThIDUIZ2JY6wdZk2KOX4lrD06Y3zLLRD8bKwOYulxwDEV83Nc
         w0q4BC8C23M+thnKwh0/JfGj/PI7ZxqrM1bm00BCSzPfoNkh3xqwDwoDa6nvV9D9t5Fp
         EdXvoaz+HcvifuUoGd68K1vszFy5D8Lx1P0mrIJzYPOY+ZPDiLsfpMq9DI5ZCII0v3P6
         jrlsQ9foNOpdJpYqK1WG2Am8wcoUrRIO13maBqRPYzgqMYXMcMyYWvR6u83sBnj35dHP
         iHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762508340; x=1763113140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rgw5xcElE8xbfMxk4XfNC90+k3Bbs57tvUPtv7wwrm4=;
        b=dL4BiX5PQWz65+TusCN0iyqQvKaZE+sF+t76Ujd3OfBqDUkYuqJ1It54N4koXSlME1
         sIsST/JY+YzgNBI4gif3lo7y2OtHHbGv/Ul3ZODb85rFjIKNZKrhBVMjoEzoikWxPXmY
         fwfnsWJZ8ifffWc8o3QqBdIeeGol9MbYbiPO2dF4V3Drs9Vg/QgfMExLjK5QgRl0mUW9
         7BmUi47dPOJ2tb1GJHD4Ia5aERGufE21bc8Qv7toPDGhahrr+8JrK2rH3TMqiZ2ftTfF
         BR9ViM2Qt3h/5H2ufaEZLD3rHNzKS/jSOrwEs7vM/+EjFrv3WyJBMthD2g3EySuKX5Bs
         s27Q==
X-Forwarded-Encrypted: i=1; AJvYcCW016j8UBDAD+p1LY0IGS/KN5vE3nOJGQfd0SOXE95p05MqL/skHFZ0IsHYqBHQAbe1AWRT133o8RGv2cuTrXTiSuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUf39bZWutFY1FTszz0UR0blbWyyXU8q0GzUbb1Vfs8NWhJmgF
	6GRM67kGmX94/6lrrTfx8QJkV4fd1tUnJEgcgyRIHifBZUq+EqeQTGcinQwyQ85OZKb4KogWy6T
	5Fo3Ju36jjBU8L2cAVVXoqg==
X-Google-Smtp-Source: AGHT+IGzpEKGlvdqnVA4OQ2DzHhBl+PUvu9fL2YcqmScAvttQ6S+PEAeuUHE8+kan3CeRRr5cSqqjY/5fBkD1tZM
X-Received: from wmjq17.prod.google.com ([2002:a7b:ce91:0:b0:477:122d:f740])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6289:b0:477:3543:3a3b with SMTP id 5b1f17b1804b1-4776bcb20a4mr20810655e9.6.1762508339806;
 Fri, 07 Nov 2025 01:38:59 -0800 (PST)
Date: Fri,  7 Nov 2025 09:38:24 +0000
In-Reply-To: <20251107093840.3779150-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107093840.3779150-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107093840.3779150-13-vdonnefort@google.com>
Subject: [PATCH v8 12/28] ring-buffer: Export buffer_data_page and macros
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for allowing the writing of ring-buffer compliant pages
outside of ring_buffer.c, move buffer_data_page and timestamps encoding
macros into the publicly available ring_buffer_types.h.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/ring_buffer_types.h b/include/linux/ring_buffer_types.h
new file mode 100644
index 000000000000..54577021a49d
--- /dev/null
+++ b/include/linux/ring_buffer_types.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_RING_BUFFER_TYPES_H
+#define _LINUX_RING_BUFFER_TYPES_H
+
+#include <asm/local.h>
+
+#define TS_SHIFT        27
+#define TS_MASK         ((1ULL << TS_SHIFT) - 1)
+#define TS_DELTA_TEST   (~TS_MASK)
+
+/*
+ * We need to fit the time_stamp delta into 27 bits.
+ */
+static inline bool test_time_stamp(u64 delta)
+{
+	return !!(delta & TS_DELTA_TEST);
+}
+
+#define BUF_PAGE_HDR_SIZE offsetof(struct buffer_data_page, data)
+
+#define RB_EVNT_HDR_SIZE (offsetof(struct ring_buffer_event, array))
+#define RB_ALIGNMENT		4U
+#define RB_MAX_SMALL_DATA	(RB_ALIGNMENT * RINGBUF_TYPE_DATA_TYPE_LEN_MAX)
+#define RB_EVNT_MIN_SIZE	8U	/* two 32bit words */
+
+#ifndef CONFIG_HAVE_64BIT_ALIGNED_ACCESS
+# define RB_FORCE_8BYTE_ALIGNMENT	0
+# define RB_ARCH_ALIGNMENT		RB_ALIGNMENT
+#else
+# define RB_FORCE_8BYTE_ALIGNMENT	1
+# define RB_ARCH_ALIGNMENT		8U
+#endif
+
+#define RB_ALIGN_DATA		__aligned(RB_ARCH_ALIGNMENT)
+
+struct buffer_data_page {
+	u64		 time_stamp;	/* page time stamp */
+	local_t		 commit;	/* write committed index */
+	unsigned char	 data[] RB_ALIGN_DATA;	/* data of buffer page */
+};
+#endif
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 41975b92a960..f823d51b7b98 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2008 Steven Rostedt <srostedt@redhat.com>
  */
+#include <linux/ring_buffer_types.h>
 #include <linux/trace_recursion.h>
 #include <linux/trace_events.h>
 #include <linux/ring_buffer.h>
@@ -156,23 +157,6 @@ int ring_buffer_print_entry_header(struct trace_seq *s)
 /* Used for individual buffers (after the counter) */
 #define RB_BUFFER_OFF		(1 << 20)
 
-#define BUF_PAGE_HDR_SIZE offsetof(struct buffer_data_page, data)
-
-#define RB_EVNT_HDR_SIZE (offsetof(struct ring_buffer_event, array))
-#define RB_ALIGNMENT		4U
-#define RB_MAX_SMALL_DATA	(RB_ALIGNMENT * RINGBUF_TYPE_DATA_TYPE_LEN_MAX)
-#define RB_EVNT_MIN_SIZE	8U	/* two 32bit words */
-
-#ifndef CONFIG_HAVE_64BIT_ALIGNED_ACCESS
-# define RB_FORCE_8BYTE_ALIGNMENT	0
-# define RB_ARCH_ALIGNMENT		RB_ALIGNMENT
-#else
-# define RB_FORCE_8BYTE_ALIGNMENT	1
-# define RB_ARCH_ALIGNMENT		8U
-#endif
-
-#define RB_ALIGN_DATA		__aligned(RB_ARCH_ALIGNMENT)
-
 /* define RINGBUF_TYPE_DATA for 'case RINGBUF_TYPE_DATA:' */
 #define RINGBUF_TYPE_DATA 0 ... RINGBUF_TYPE_DATA_TYPE_LEN_MAX
 
@@ -315,10 +299,6 @@ EXPORT_SYMBOL_GPL(ring_buffer_event_data);
 #define for_each_online_buffer_cpu(buffer, cpu)		\
 	for_each_cpu_and(cpu, buffer->cpumask, cpu_online_mask)
 
-#define TS_SHIFT	27
-#define TS_MASK		((1ULL << TS_SHIFT) - 1)
-#define TS_DELTA_TEST	(~TS_MASK)
-
 static u64 rb_event_time_stamp(struct ring_buffer_event *event)
 {
 	u64 ts;
@@ -337,12 +317,6 @@ static u64 rb_event_time_stamp(struct ring_buffer_event *event)
 
 #define RB_MISSED_MASK		(3 << 30)
 
-struct buffer_data_page {
-	u64		 time_stamp;	/* page time stamp */
-	local_t		 commit;	/* write committed index */
-	unsigned char	 data[] RB_ALIGN_DATA;	/* data of buffer page */
-};
-
 struct buffer_data_read_page {
 	unsigned		order;	/* order of the page */
 	struct buffer_data_page	*data;	/* actual data, stored in this page */
@@ -401,14 +375,6 @@ static void free_buffer_page(struct buffer_page *bpage)
 	kfree(bpage);
 }
 
-/*
- * We need to fit the time_stamp delta into 27 bits.
- */
-static inline bool test_time_stamp(u64 delta)
-{
-	return !!(delta & TS_DELTA_TEST);
-}
-
 struct rb_irq_work {
 	struct irq_work			work;
 	wait_queue_head_t		waiters;
-- 
2.51.2.1041.gc1ab5b90ca-goog

