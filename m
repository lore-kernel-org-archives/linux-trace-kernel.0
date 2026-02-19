Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444D1342C8C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771513414; cv=none; b=mPP7BGelXexkacHkXJ62qFYj50WUZkJIu56qHcmESB2+RivWdYJm8NOPYEMrI8yRTCKRLiO7LGYnkSK8e422yiqTa1C4QnyvgvR80rJ6q2CIRI0mXVi15IGT5ewMeDUXix/uXoHUcdNawxy9qYoPg4Ij5Bd2UCb6jJwhwMARwr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771513414; c=relaxed/simple;
	bh=PXpJDqJ0XKLx8AEYlCoqKcNyiX2KW5l+gr+E3jTZCo8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sxG7VWZcFjGocjFb6HvnMfUhfjFQpcBDzLZrEu7Z6B71bTOW8UD2h57bg6JPsMuHPM7Q+Pqm0b6n3MZigxXBwY7jPlKIeLdfRO6SK4u9foMFujmeczu2YDdAZv/GJZ+5E+75LLUhMnHTm5GAzUiN2/lqcfqmlXw44BKrTiK0WZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a7QObd0q; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a7QObd0q"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4837c597cd5so6921225e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 07:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771513411; x=1772118211; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o0tMse5C0cVtD+YfhWwQcdctiKYpi7dPFiIDpWgHDos=;
        b=a7QObd0qUQoHc9ELxdNNoqDTbhATJYFBWQqEDss+l8O4odYXB/SEUAFAJ/Rs2KrSvX
         A3OdwLCC64kX4XOWBkp263bAFElspd1sM6ZvolIuI09QOUVYo1yEpoGTRci6UmJj0Ty7
         Mt1oJP6frP5X0gCvlP67ZWxiOexUZ9W9+EgM4pPUVvAuFNUZz+wRp7fBTuH+nvzpxRF7
         UfQOTC8CfJl7prNwbDxWO10C06FzGFnYO+YzwxDY5OCW3jMEuNZZEMA022je3KLGulVx
         97gskvdPmmOZt9jVlFuZ//EFvDXF8UJnpq1z+BuAULPF3LBgtK2b2YwnpxRpnEWLeUtT
         dHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771513411; x=1772118211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0tMse5C0cVtD+YfhWwQcdctiKYpi7dPFiIDpWgHDos=;
        b=NfOyGuMQMtqzn8+BobBsI0gMqp1H1X74Dmb1xMdPTQLyBjmy0LqY2UaIs/dMHXlPZI
         +JUJKsPycRAW294h6dEplqzfUtz7JmrK1u8RPyLcYRJrRa9C1tGYLO6gWhpLv0opNnCm
         zEcxI6ysh/LYatq3JA0Y2gLSwUP2flHKF4TXngMQ7iKgD4uE0zxSQJEtC60d5tgCpdbh
         0NDCcMwmE4mLJY91J75ShpNaEIVCro2ZcI3XSEpsslZaQkkU2PL+W1hjWErbnGuKBD37
         23rrUWRB73IURXak9Ri2KJv4j8DP4FUHp3RXK5bcXWGVQwNOTZ6fIDe0/5UCXexzEOIx
         EoWg==
X-Forwarded-Encrypted: i=1; AJvYcCUZE2BaAcGoT0yXYPAvIoyvycc++pLTTuHKa+664mw6abzKi4JE9U0U1TJMgL8T5wdxzNFBRaxQDECZl1yMaK23SFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAbtGSoDo1sNJD8KeDqWVMRdMe7UMP28bp4ftrwyMk9LyHzg7g
	4sgHm9AatFV1CKNpZYUSHWRJZdOns1AFNlFiYRVecpAFPfhRMGPAwgI+XMaD7YRzPT8GZhCp4Jl
	NNETl+DXx6mn+T7RdHy2tcQ==
X-Received: from wmg8.prod.google.com ([2002:a05:600c:22c8:b0:47e:dc0c:276f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6290:b0:47e:e952:86ca with SMTP id 5b1f17b1804b1-48398a4287fmr89687085e9.2.1771513411495;
 Thu, 19 Feb 2026 07:03:31 -0800 (PST)
Date: Thu, 19 Feb 2026 15:02:49 +0000
In-Reply-To: <20260219150307.14538-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260219150307.14538-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.335.g19a08e0c02-goog
Message-ID: <20260219150307.14538-13-vdonnefort@google.com>
Subject: [PATCH v12 12/30] ring-buffer: Export buffer_data_page and macros
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
index 190a90816f02..e0cdf53fa643 100644
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
2.53.0.335.g19a08e0c02-goog

