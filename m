Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20BC3E95AB
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Mar 2026 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073576; cv=none; b=fPjT59U3AmjWE4RaQ8I667gsuV16uFRiK8spPNj2c7dfQTGXl4L2OV37e5WZHjUkA97cMqjHDCvKsC9GsoxCCGpvwFnBFbVAMsIpySoMNBN9/mFyc2BXKYJ9UBeez5TN/h06bafIowZjsQSWQEinNLSp+fUTJB3Gv+Bcu2jWAKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073576; c=relaxed/simple;
	bh=PpmBmgCJfZkVBfypiOAwLPXCe9QfGQ9/OuiNIWcfWGI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LjfFGvTLSsxAiMZWHbn4f3dT0bKAJwyzv4DcdltTjEWFQGLswwFG5Sqv6kwJ4QIeAhJE6BntX7xRzZFuU3wbjNnBxdC+HRdx/uLcCqRtu/sw6K//tc21p0H2YWHME7M8uezoCeEvcla4wqUBbc0IoUuUHm53bAmFv9fIcL2+210=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nEVQzIf7; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nEVQzIf7"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b94a1fee936so187476766b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Mar 2026 09:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773073572; x=1773678372; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F1WvucEqcVYrADrijLBtCoRpo6zZxMCkzMNXu+AcfQA=;
        b=nEVQzIf7op6u183bFI1NtIBD/s4P59patAvsGuOfFTFelSkF+VDDkujdCWtKNlcear
         CdzDRD5YB3i766TFuYgr9Tgk57U/eKDQONccpm7HTonXw7316IBqfhEiN7b53syjTXju
         GJwwH79IzqdjgZXfgTXPDybgpD+NR979/N4vDGPJz/WvQT73ooRyQBB+iOu418InrB/j
         zjCqBWt0oQdjYr+9ZRktpTXMms6l/TnahZ5AEFgiVPVZ0M79Jg38oTDVYvjYgYjPd+CU
         TjD2BG1nQvdOCKTCV8jdKO9u1WFtJ8owWb5Y1rCRd5HBCLpN3vapR9+3QYpofmTCmDYG
         PThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773073572; x=1773678372;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F1WvucEqcVYrADrijLBtCoRpo6zZxMCkzMNXu+AcfQA=;
        b=ZyrMB2HVZDAOuZ4Hj562fL6a6d0y/RYm2IKuZzHFfRN4V6ZXT+Ao9UBYdXLV4hGcnl
         L3f0ml6MTUFjrG/W68ztjprejpRN2wRCYue+e9DihXR8Adp0JU4q3caslNHRXqn9Epl8
         CTB9ZTHxNnKu7pGhO86G5bKDwmLGisPAOEjvwAb3pqS7ZXOVlzS4WBLvmPnn5KBkaUpI
         d4xbc+yj2fLlAAYU2/bK2Eh5UAmKZkTqBND1qeVl4WZRZJHJYEqPQey6bQqxx9GRFEG4
         7aWVHOBVRO+6bktzGsu/H8sA9pdCGf1hOo31tETaTeuVLF4QVB9X57klGTl4bw5+8hlO
         iW8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8WE5UxnuOGWHC3uVMrtPcJft+Ei/5hf0vGGyWRoIUMbhMPpUwbP+GyhjRDA4PRGKevo2CiVvlgslf+nRSeOdQ8BM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpi8WJsR18JykQSO6cNLIpMIA6rD87BUWcMCsUZG/tv+R7z6EJ
	37Ltb+aS3davd0HbLWeZr6z2gdegLRH4Tvc6G/cxqjYXJQeszjTK5imt1NCCTvevCeCFJt+XvKb
	NyuQDvEY9uc/z8JaRCi7b7g==
X-Received: from edsa2.prod.google.com ([2002:aa7:d742:0:b0:660:9db7:cfda])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1d48:b0:65b:f20d:763d with SMTP id 4fb4d7f45d1cf-6619d485125mr6333847a12.9.1773073571936;
 Mon, 09 Mar 2026 09:26:11 -0700 (PDT)
Date: Mon,  9 Mar 2026 16:24:58 +0000
In-Reply-To: <20260309162516.2623589-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260309162516.2623589-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260309162516.2623589-13-vdonnefort@google.com>
Subject: [PATCH v14 12/30] ring-buffer: Export buffer_data_page and macros
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

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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
index 605142e06863..96e0d80d492b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2008 Steven Rostedt <srostedt@redhat.com>
  */
+#include <linux/ring_buffer_types.h>
 #include <linux/sched/isolation.h>
 #include <linux/trace_recursion.h>
 #include <linux/trace_events.h>
@@ -157,23 +158,6 @@ int ring_buffer_print_entry_header(struct trace_seq *s)
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
 
@@ -316,10 +300,6 @@ EXPORT_SYMBOL_GPL(ring_buffer_event_data);
 #define for_each_online_buffer_cpu(buffer, cpu)		\
 	for_each_cpu_and(cpu, buffer->cpumask, cpu_online_mask)
 
-#define TS_SHIFT	27
-#define TS_MASK		((1ULL << TS_SHIFT) - 1)
-#define TS_DELTA_TEST	(~TS_MASK)
-
 static u64 rb_event_time_stamp(struct ring_buffer_event *event)
 {
 	u64 ts;
@@ -338,12 +318,6 @@ static u64 rb_event_time_stamp(struct ring_buffer_event *event)
 
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
@@ -437,14 +411,6 @@ static struct buffer_data_page *alloc_cpu_data(int cpu, int order)
 	return dpage;
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
2.53.0.473.g4a7958ca14-goog

