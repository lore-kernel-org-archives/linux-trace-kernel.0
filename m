Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468603563C9
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 13:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769866176; cv=none; b=ZArbBfoUfufyHGlSSqulXIy6H5WQuZ9YaCMONgHyLFhs3/GqLcGF0czp0OxN075tLGC09QT1Spyv/97p2WDMNb2FCMkjoWPqX7pQB8xpVUh++b3dlA+SU4sdmc1DDthvB7ELz+m1L6Zg+cjP4Pv0sk29ECij0nsW+1B3XnuiE0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769866176; c=relaxed/simple;
	bh=myEoHDo3MPvls1vMiU/YVxxWDnISAX7i+kXR3tGbZj4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g5zqWv9b31y136jFnWMsF1c6/Njgsn1MyPgMsN1Mo3LIppL+6nthMm2BZDOFnWVoM2wG4/ywlzDHrFF3efyf9mcPuwmoUr0v1Naq6+iVLLSQdhMxIX18PHh4ErhL/++S6VGjiKrz2mc8QzEotCVYrvYFG6+oUJPl8bbiNmvURCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hjm5GoRF; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hjm5GoRF"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4804157a3c9so36044815e9.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 05:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769866172; x=1770470972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pBD976xrFPJmXmNtnpgAPvl5e9LpDIznbYBPc6HUC2I=;
        b=hjm5GoRFG/5KTBiu1sDHMxJk2qnDaMkyxjFGQpzEDyI/qvdSOm4bsZoMy5B/o1T1u9
         IH0hk7/PlpF3n2D+OUvQ3edkgsHhqwMSymT85XCCGuMPFUXGu1qilkVX1iR2s5mU+WZT
         /cwhJ0Nz5DE10rxP6HkkV0EHDNnIu2OOBYI7BmBeNSN1wXRfrNUTvQ205qk62SKnx8pg
         +1geFyQkFbuZX/B0npFsh42K5TgFNF2tT9nkWh6LMDHIgJFrQDs8qvZbiG4nBMj6JOHi
         ykITY0G7qsT4TS8w8OLyLF9Pzx69moevUw6E8zhv38LhYfv3OifjzYr0hEmm/Wln0pYG
         G7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769866172; x=1770470972;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBD976xrFPJmXmNtnpgAPvl5e9LpDIznbYBPc6HUC2I=;
        b=MUSTbF6niDWuT7GZ8m+R5kwZfw7q3KEjlotdG/lFm4qAsxuY2BvZEAVgNDppjHGF4w
         KXRK/mv2XRSFKVRqyh5Qrt8emgE63nC9qjJAramnYFfm4EOEshOC+qZ0MKm6tLJc9yYu
         QYyNxiAI9TH9LQ2aKpYQYhcv2vowPBxkGJHYelrPZPeUrkWtyX1NHqj2ADCrVjm4TkiV
         EBt/loRZJ5xrJ4CiXm47i4mukwPTCh0cbuE+YHUjrf6T7dPIZySNJMSfYAWvCBuEYl/7
         lsm8UeUXxN1+sDIuM+3MavGfOp5h7j4o/mgHDtvHU4Ig5l63g4RgCTsx+3IEW7QLfs46
         0ghA==
X-Forwarded-Encrypted: i=1; AJvYcCVfMSQApnj89AuozK2vI9BnM+AwpzL4/WBqFOlliKUN9QBD9n/2U+aQDB8GtTCrITHJ4d3jE7X4yddUUnL3ED06sZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU2TykfCx0xBYRM3plBTBziI5JVeIrtr/mopA9VRhRP/0BQAJ4
	+V0gM0zTcRFTZkQjwbirQpeodtnKtbaQzNQz1/x7WKqmFnakmhOcS7b5CCGtI7KiHnRQO15URia
	VmOus94/w8ufqxjCNyp+yCA==
X-Received: from wmil13.prod.google.com ([2002:a7b:c44d:0:b0:480:4a03:7b60])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b1e:b0:477:58af:a91d with SMTP id 5b1f17b1804b1-482db4569b5mr71334045e9.5.1769866172683;
 Sat, 31 Jan 2026 05:29:32 -0800 (PST)
Date: Sat, 31 Jan 2026 13:28:30 +0000
In-Reply-To: <20260131132848.254084-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260131132848.254084-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260131132848.254084-13-vdonnefort@google.com>
Subject: [PATCH v11 12/30] ring-buffer: Export buffer_data_page and macros
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
index e28cc02d1a70..d604377f2184 100644
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
@@ -436,14 +410,6 @@ static struct buffer_data_page *alloc_cpu_data(int cpu, int order)
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
2.53.0.rc1.225.gd81095ad13-goog

