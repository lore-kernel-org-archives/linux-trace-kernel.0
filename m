Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC5213B590
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 May 2025 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402854; cv=none; b=cfGL+tkismO1TP48PrU0kx+IfWR6YByi+HHUOZ7FG67FCO1Jk4r4EJYjaG5SMucvoVY+6YudWOpS7MmbCKcbrzdw5rlQ5AIGcqHNqYZha/G2YZf0IRkGqRqthQ/qcLzSsreQ7INsTvxzP+cQNhoCBu1fEuUzZUwyLFD1qDaT02U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402854; c=relaxed/simple;
	bh=wsH31ydPHtGC8nSyG5aiDWiL3F7qWOKzsCXUCTUDMoY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BYCekHiXourYZNTviErm1CxxLxaiViaWa+NAvLjYYrXjFTIzg7Z7E4M70KxhWlUfiSDZTWTY1P57iNlc71Qh45kbdaVU3pH0QY9TydIb161dJBM6LVPhBkDeHkrer2NEHQgmUI9aLqTLyM6FdFelblO0cKwKV4iM08ZH+l43qXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jqIGPTGR; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jqIGPTGR"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a205227595so1134949f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 May 2025 06:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747402851; x=1748007651; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sts3k8S/JL66rJ24fFiDhVPJbMR9OVDJbVTiN/eWqHU=;
        b=jqIGPTGREraT77mRO3UD7pEHw0dc+v5qRGlmou5W9QPxSFQnJ75KXxFScmduLwfSu4
         /DndFrEQhMwWbVaOXN6RR3/vGgcUOnM40+t4/XmSeTb7e3k2V4fKZmlBQKtB7uSGAYTF
         U4ol9HWWgD7kxbdBnEhebQODQYoCFGJF+VatmFK1mdoBeX8klHmUc6+jXTnhPt4udFCi
         oXmn1GU+kYjI+mPrQjrAPnxZINXQ+vYY7tlhcdwmwnBMTyitQh9XcUNyYlo997Pu9sDn
         Qhtm1CU0HoEiYcfhe0fu2/ga7bJ1OIlaDB1n7vPip0plWztTVxoUn0J3nzQFT9NgwNab
         xTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747402851; x=1748007651;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sts3k8S/JL66rJ24fFiDhVPJbMR9OVDJbVTiN/eWqHU=;
        b=WIk/TO5CVuaGDY8vjZzYgSZX/JT8u5/DjA30wGcuFv2+tnoNEsJ6LHWx64E0Suyu8T
         oheBOFOtnrPvfDnqBRX9UBoJff7lfes+2udCP9foE++pZEVxlFOhj3SnOBBKLx76KuAE
         Wr4po0HgQqRkooP87JeZtjRTKOw4HNNmlvOBui4OamDNSmnlFIhcrNQaY47ybaxTxOIQ
         Rl8aBLZcrYZPil+xSlkCGW2/Y216b2oGE/kKhVyeIiwyB3FGMRxHNqMMCkh9RlKAF5rN
         +QhMgI0AfnoKFT1Z5yIqFt9SqqxAc5K66MtD7hlIHgkxX/TQak6fCYRHdaB7pldFZmLo
         FwvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGazYhK1Ye+JCLvmH7QwiwK+qqG/imXmBZn3apO8ILWGBbY2ZZwQsF5XdbDkQgea/3XNMll4W/5C6HhgITukYTpa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7TFSg37Gi4NoDlOplqq6+kpHw0TpesFd1GRzDbqmp5KGuic9Q
	Uv70ZHtM7aug1R3x4fpGuxjfIBLHE5/rE0EqXGfO6EPxQJdodkOiPiMUHFPCRksRfeNyb3OlFqA
	Nm63fMh/TDjCRg6Zmzw3iOQ==
X-Google-Smtp-Source: AGHT+IGnqfA97BVbR/Mi8Ve40w0dtCeOsw/hPCYSNZEP3cEaZDO8G74lb40v8p70u0x6PTZ1uUBUClqeLpxaBluT
X-Received: from wrf23.prod.google.com ([2002:a05:6000:43d7:b0:3a2:78c:3f3c])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f53:0:b0:39a:c467:a095 with SMTP id ffacd0b85a97d-3a35fe6777dmr2300705f8f.24.1747402851035;
 Fri, 16 May 2025 06:40:51 -0700 (PDT)
Date: Fri, 16 May 2025 14:40:15 +0100
In-Reply-To: <20250516134031.661124-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250516134031.661124-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250516134031.661124-10-vdonnefort@google.com>
Subject: [PATCH v5 09/25] ring-buffer: Export buffer_data_page and macros
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
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
index 8f94ccf3f55e..91c69945a0fa 100644
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
2.49.0.1101.gccaa498523-goog

