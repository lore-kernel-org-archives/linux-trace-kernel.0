Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00372EAD13
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764076; cv=none; b=Puuzq2BtAYC49odRu8kUQ4DZlDP/FNqDlvEl2QET5mu6PXuYVnl/fJ+yd+Pjra2rpLO8i6Senzli99h1IXRvuQcVycF5HN3DWapI6BSVZ12R4LqMw+GxWqbGiEvKKYE/Xu2QaCXyqYzQbYERXGogw654FfGMtN2yIlFYLeWZsUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764076; c=relaxed/simple;
	bh=95klshcx1eA8ITSZ6yKOt6Et2Dsxed0eu/S+STTsgow=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L2U5r3mZJnsTeiyd2zdDWVmGNaY0LfN9JAFYp0SGeB68mOZmhRwvrebBgJiyVf52ZvuXM5reDkvbAQ2UkRL4BgO8cvLNW4ZxU5brZdGi8ix3TwpVo7fIyjuDouoqLjrdpz2oE+IeAGSADQTd1hqLLuFlmyC6qQd0CaSgS3srubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wZP/TNEV; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZP/TNEV"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b04f817so2964115e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755764073; x=1756368873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lidjLhay00eIJzNqp9y3fdvOXQROgJQ6gBPaAYL/6So=;
        b=wZP/TNEVBIqQU7fgQSXKk5miggJAkPKteXSYCgBxGXFkXqU8P09f7fUk0CUkwXJVZp
         wufwX/vZ3gG5FowOnIA2Bo3EyatEsSIhwO8wZ+7AoJTYf9X+4vuHO4JCUZstE+UCd8vH
         X0neEmQT01dblMB7SVk9DnBo1VCAOK/yGWzsvH951A6Hf+97HHuDdzLCLuOlFU3dewhr
         x78dbKh5k+RTnB/2wDho/eWUdTFEqQScjVKbm0dmrN6fJhXrle5U1Ugge5cxLUyAMtAO
         iN2D0ar/ALXIaDnlZHRyogifLtuvknvIiu3jzZ/SmBrregMI8ZJb2QJISrukfd2A5USm
         6Pqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764073; x=1756368873;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lidjLhay00eIJzNqp9y3fdvOXQROgJQ6gBPaAYL/6So=;
        b=d/0BEUdliTEm/n78AAQSiEc0vta4Nvx5WVI+fRU2w2Mm/tn2xT8pN1y0VUibWFOlRA
         jmVzUXzzkO9anouE+Ex/kM58/Qn3Ti/yGovE7r9ceKQAANR2xItShFLWhFp/6rkWjtUC
         YWAeRBdEGOLey2ZnTuLLeUrQs8gbmbIJWAsAw9oExu7n6yrz7BWr8sYUepz5Gc38nqQN
         2qruLKJfTCH3T+4Y6/c7fBTwe9CJkBkVSFTvqI0GP3dXxD0ubg6P1J9gqvOQLCYjy/lm
         ktj3wz+0/8GFs3XJJFtb8aqOlKtgMIIBs+NWXDrw2TBn3C8bUTWHceatqIpzj0axgig2
         GqBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBtzr2IvNlXgkANb6Q9P43+6R7vfGMP5QXO2c4lE7KHAlPqcaZ5m7XdfKfeiq2WSlEIq0TNv41GbM/oRf4QTQHTZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMeuWcylK5g8kmR13eV3+HT+dY/P7hxiOuJ0FS1lOh/COiJBlM
	ygEN2NJk2jbaCRY0XRk2vgTMIcM3T7+yuKpB+MG22LTEwGoxYAC7h7Ojt/7EPpXmHFTvH2S2W5w
	Z6+LrqeJOkKGseQMh2XBQ/g==
X-Google-Smtp-Source: AGHT+IGUYeZjzebzCwGkqmxmIs4OLf1N4Wtv2KCQU5S608mV1VSpQPSnOJrtt34tlE8F6oeRRBN+N84WhKQvWceN
X-Received: from wmbex21.prod.google.com ([2002:a05:600c:8315:b0:458:c0b7:b936])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b56:b0:453:5c30:a1fd with SMTP id 5b1f17b1804b1-45b4e4f5719mr10261825e9.8.1755764073268;
 Thu, 21 Aug 2025 01:14:33 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:13:57 +0100
In-Reply-To: <20250821081412.1008261-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821081412.1008261-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821081412.1008261-10-vdonnefort@google.com>
Subject: [PATCH v6 09/24] ring-buffer: Export buffer_data_page and macros
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
index 17f77653b926..c7405b5e55a7 100644
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
2.51.0.rc2.233.g662b1ed5c5-goog

