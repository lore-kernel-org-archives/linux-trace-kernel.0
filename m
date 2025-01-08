Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5901F942F
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Jan 2025 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736336772; cv=none; b=ZRPaUiFjEJrH0RpbkHFWrDhZWbgQyCpc7unbAgQGbxS5SpzyEkrRGITb8465r3RcrQN7Zlj+DQ3gG8sQeuyZyggewnHhlGEroYZ1om0u+cbARbdCgwmdFC98u5iQ9oU0VtEizqCgjnbMWOleLfXIg0JpFiFMNY6HGgYce/ZoYm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736336772; c=relaxed/simple;
	bh=2zGrh6Bb4n7JJV94xdpbEofaJlW8JBXkmFVpd7d6OaY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sNyYlvDmabdkResgfZoty3jsO2Vn9gznWZXuEUdM9YO+xaIgrfLY8gbbCmkTQjsNui76MSKQ4iepBqWjo9bYA3Y2ydpKMJDEPg2CdGDSToP+DyNEt6ryIEpkF80eUpH0j0motp5UlrMbHi5HzIadASrQihQky6/NFOEAvTOvkzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N59nt5Pe; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N59nt5Pe"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-385e49efd59so3590023f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Jan 2025 03:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736336767; x=1736941567; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1lQEJoOrOtFhLM0V6NW85dekf5jRkM+x/j5FFakF4z0=;
        b=N59nt5Pe/9X89Y7uK/lfdExFCLaVxny4f9LLiby/5cybFPoZ21rNttBEiAQau1K0Lc
         WLJC5h0dB21Z2kYm9+P+Inu5KSuaHcDdSm02QLtpzXxOUDEJWln5n27B7nMk1fvbOCWo
         iB1Ig0Auz3BwnnxN26rQthg7Ge5NF279LZvH3mpPfEroEZxv5kFQZpjc+ky7h75FCOru
         s0aPxYsqkRpEmcYEe3vxmXpYqF8rvXgTxJlK+oPWhpLLOM+o06x8omaUbUlLjz65OA6i
         mgkjjX256OP8mj7F1Z2pmvhcosTo9MCV42JmLyUWYYb4DPia2MBJEo7gmqE92Q+5OsKE
         5G8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736336767; x=1736941567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1lQEJoOrOtFhLM0V6NW85dekf5jRkM+x/j5FFakF4z0=;
        b=GcQi4Nh5rPbKjaOwB96s4Br+5K1I+k0h0lu2IIu9g7F/CE3jwSNIBrkyNhwt7FOIcW
         l34MPwEIbwlYxZPU9luDzJdaakIlES/Xm/Ye5sN6143XiBszilxI3P01ApIh6x86JNbt
         4hggl9D8HBC2KrENkdBp7qcx0eF44FFMSMlzxNREUfKP7NAZXOlsN7iXZKU84BZORjrS
         6ctBRiv4lAteuvamU7vh4VNOqGx3K8zjVatlwq0esJGsYFCU5w4dk4wOvNeUb+JfFdPg
         BKJI6HIHoBLt3h20fM8BIcJkPLxehzJJkp/AFao4achFo8mXqs4WKUgiMI1NMcwCPtyb
         BFwg==
X-Forwarded-Encrypted: i=1; AJvYcCUTjFe2PZirfHoFl198rRbYvRoRgav/bMD5842dbYztf2KN7n5hcHweSeE1IpGgWitqtDexoFFdieuwIsRCqlMNg7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1L+3xeYD9pbESUb+c09qESBeoj4JCj3MRFPRz0hE5zbl5WY/V
	T0vWfRM58/Dmh89yTmb0Xy8Zc8LftbJPr1gQjOQH9JmcKEDdVIcSnZKHIvwAjQa2WgtuiHwG8OX
	VIQm577enJPVacTQ3NA==
X-Google-Smtp-Source: AGHT+IH9nVUXukGdhao/KGMQEQ2ZZRu7hj12bJxObkGyvYkwyEhx99i/TvuPbWjySunFSoVAevMNDD+4C2F0t7to
X-Received: from wmbez12.prod.google.com ([2002:a05:600c:83cc:b0:436:7123:f80a])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:47c5:0:b0:386:1cd3:8a09 with SMTP id ffacd0b85a97d-38a872d2addmr1799776f8f.1.1736336767575;
 Wed, 08 Jan 2025 03:46:07 -0800 (PST)
Date: Wed,  8 Jan 2025 11:45:27 +0000
In-Reply-To: <20250108114536.627715-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250108114536.627715-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108114536.627715-4-vdonnefort@google.com>
Subject: [PATCH v2 03/12] ring-buffer: Expose buffer_data_page material
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for allowing the write of ring-buffer compliant pages
outside of ring_buffer.c, move to the header, struct buffer_data_page and
timestamp encoding functions into the publicly available ring_buffer.h.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 61e785adc011..a80057371da4 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -3,8 +3,10 @@
 #define _LINUX_RING_BUFFER_H
 
 #include <linux/mm.h>
-#include <linux/seq_file.h>
 #include <linux/poll.h>
+#include <linux/seq_file.h>
+
+#include <asm/local.h>
 
 #include <uapi/linux/trace_mmap.h>
 
@@ -20,6 +22,8 @@ struct ring_buffer_event {
 	u32		array[];
 };
 
+#define RB_EVNT_HDR_SIZE (offsetof(struct ring_buffer_event, array))
+
 /**
  * enum ring_buffer_type - internal ring buffer types
  *
@@ -61,11 +65,50 @@ enum ring_buffer_type {
 	RINGBUF_TYPE_TIME_STAMP,
 };
 
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
 unsigned ring_buffer_event_length(struct ring_buffer_event *event);
 void *ring_buffer_event_data(struct ring_buffer_event *event);
 u64 ring_buffer_event_time_stamp(struct trace_buffer *buffer,
 				 struct ring_buffer_event *event);
 
+#define BUF_PAGE_HDR_SIZE offsetof(struct buffer_data_page, data)
+
+/* Max payload is BUF_PAGE_SIZE - header (8bytes) */
+#define BUF_MAX_DATA_SIZE (BUF_PAGE_SIZE - (sizeof(u32) * 2))
+
+#define BUF_PAGE_SIZE (PAGE_SIZE - BUF_PAGE_HDR_SIZE)
+
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
+
 /*
  * ring_buffer_discard_commit will remove an event that has not
  *   been committed yet. If this is used, then ring_buffer_unlock_commit
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 3d5d32ecd3fa..0e5e9272debf 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -152,23 +152,6 @@ int ring_buffer_print_entry_header(struct trace_seq *s)
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
 
@@ -311,10 +294,6 @@ EXPORT_SYMBOL_GPL(ring_buffer_event_data);
 #define for_each_online_buffer_cpu(buffer, cpu)		\
 	for_each_cpu_and(cpu, buffer->cpumask, cpu_online_mask)
 
-#define TS_SHIFT	27
-#define TS_MASK		((1ULL << TS_SHIFT) - 1)
-#define TS_DELTA_TEST	(~TS_MASK)
-
 static u64 rb_event_time_stamp(struct ring_buffer_event *event)
 {
 	u64 ts;
@@ -333,12 +312,6 @@ static u64 rb_event_time_stamp(struct ring_buffer_event *event)
 
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
@@ -397,14 +370,6 @@ static void free_buffer_page(struct buffer_page *bpage)
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
2.47.1.613.gc27f4b7a9f-goog

