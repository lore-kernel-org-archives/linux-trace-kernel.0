Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19223372671
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Mar 2026 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807768; cv=none; b=PbUPhxMJTADPgps99DOJPn+EVZ3U93B458WCD7m149W+qxX3Ns36BSoP0TzhNFGSvfMCuG5LXP++zqiYODBAUEd9d2m0RXfQ/hJIZe0C4fzzoJBA+Qmn6CMT9VnTYPa8lsNuyewH1gv9WmqCQMKbL9phutTRaSR/7F+fcXHueSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807768; c=relaxed/simple;
	bh=bRMPRQ6NDGKO/79oRcKvy6u1F4kH2tLwljEjHcAin/A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r0MOSHK//gAwlvKTP+tsjRcwMMQDbh9Vp4Z1L0H7InYVCm9OaE2qrxAi30UjhN5I7Qu+mn/WEz6XEHm9ke8f/CQUOsHV9t388hVjtx/RwvvRpFyPJuxpFaNzpTp8NcFlB884mngTmTs30o13QRQdiUpSfoAI8wodd2kUbdXCYUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CyTDd9Ix; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CyTDd9Ix"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4836c819456so71431175e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Mar 2026 06:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772807764; x=1773412564; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A0wMQ/1n9X5j3XgVqCp+O5b7W1hHbkcpIUXjLxrGdB0=;
        b=CyTDd9Ix5XsPZNRDxCHWFt22iFa4oDgT1ifRqa/qOUTq2ASLkSnbpd9TD8OsPN6hMU
         UkqUXSriIPDiLzFHlwolyUMJSz8G31ZVg1fL7EynVVM2Bk+nJrh0BzI80VKR/yVpRxRi
         M8dC+O9u6PAUhkyA+0X21WyXzHghSCu18KP6NbsVY1NDqhjiEd3Y5+vXI619rHWX8DS3
         5M7xefK+vyjCsKVX4Mr7Vrhxt4jWdpL+gXrDhuO/N90dwPFmRLxiC5IzSUDbbycamoKz
         V++lyITp295P7DQ/UgOPR0F1e3yaywz8BLfNfYyO7XvoWqJFUlqFpj7ToWZQuDL9ExnG
         qCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807764; x=1773412564;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A0wMQ/1n9X5j3XgVqCp+O5b7W1hHbkcpIUXjLxrGdB0=;
        b=LXvPhVVFpVdghX5mvMvceW7h7EvIN5vIwhgC2JBmZ75I9QXAna4Lb6kXp9hhlzqNmQ
         5jrmPgEq5gOvBmOjlljIDwDIO79xx97L3dye1uReAYZurMqdP9IxJb8PZm9rYIybnFs/
         6PP3oht+3DRjEZD3oy9NCIt3pDHON7Jutoe7Rl/H2F8R/3iqnTIEaaZj7y7BphypPoL/
         o0+egMYJVIz8EHKx4Hz+Q7QhzwabVcSkJxG3JSAdz9HNl7KJvs91cgP0OjbKamVECntC
         0IiecLnZVaMzQ80PUmMEvdJPnIMzKBrtcgDggk7raaO/lZ54+JnFIg/WTAp0K4XY0pve
         uIcw==
X-Forwarded-Encrypted: i=1; AJvYcCUZipRfmwut7nW/0GbZjYo5ir21zRNkIugb6w8hrFn+svsllFWFxBG4Gve6fhz95why0TNRcBSgSNeNxjAS2wlaGa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk+8WaySatk10kgEWjlkJn/pFsyjUfUaPNrpXXTaM50Ki83bvQ
	grSeD3KYhy+7OJEeV24WfpKbpA5tlXmKEr4Itb7Ti6jWAwBVFCZoCYRlePVyl9BaNri4uEourZb
	3oRC4mh0zRN7Nlw9FXkbXJA==
X-Received: from wmbjw5.prod.google.com ([2002:a05:600c:5745:b0:483:6c98:3d2f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1991:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-48526977699mr37901595e9.30.1772807764177;
 Fri, 06 Mar 2026 06:36:04 -0800 (PST)
Date: Fri,  6 Mar 2026 14:35:16 +0000
In-Reply-To: <20260306143536.339777-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306143536.339777-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306143536.339777-13-vdonnefort@google.com>
Subject: [PATCH v13 12/32] ring-buffer: Export buffer_data_page and macros
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
index 60492e66a679..d92b615e9246 100644
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

