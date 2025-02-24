Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF2D21931E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399331; cv=none; b=nCfG816wEBOsuuwLovLNAJkFnV3pA5rc4aT9ObsJ3tFMBYaFiwtkP6KF/4m8Q2vOFQjT2yy+JL9xE3TAMGARtExzk3z/q9Gf0HCCQioLJSYw0unkm1Yw3GF+4qHc2iIIS/6rFKfXs6ZW16pmyUrixdcoccdHp3xMo4BWIdhS88s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399331; c=relaxed/simple;
	bh=gOKOc8qU4yci0EBbwJI0GDOjXP0apsGjcg24lGurQ98=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rimHmcUyli7iAxK1cnIAR3O4Tq+5blDf7vfdg6DMwkJO8JATVfGRcOD545m1rawVFFE4eir+7/7ZDJyDr+S7gITL23qJuVwvy8LnfRgBOZ7S44+OEdvx9yth7lkw75EuajOgUSYxixzRguYPTcbsuMzHUP2c0vlqLeM6gTr+97c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CvN+0VKa; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CvN+0VKa"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-438da39bb69so32878575e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Feb 2025 04:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740399328; x=1741004128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OOWK+ThY516lMh047e8qidZAr1KsboApKQXs49+vyHs=;
        b=CvN+0VKavAlYpAl4UwS82qkluylUYGXhJhaybJ/qxeK5W724XIRz5+tcu2G+nOEjBu
         /IC3oVLd+LYB8TcXjLlgyPHXi4ByX8n5vWbNreBpf5UwyHhyuRHsCuw5WLkENxYmnChg
         P7oLWgus3/Ydtz6F+k7zvSnd/iI1pioOdJRGneZeVgSl6mbKKeL84i8+iCZue9d9Kaki
         MBZIVupzTDKx14BC7PG3HUoHrDX7lvOkbfs3jWcvv6usx69hxfq/8lnx4P4c7JGBSSei
         IYHnxPSnLM/8MPnNP5nOeK2OyssJy2nCqRYtYG5lIw8WUoYe/f+zCjVDH54u0o0gunOl
         o1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740399328; x=1741004128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOWK+ThY516lMh047e8qidZAr1KsboApKQXs49+vyHs=;
        b=rMS3bn8ZiKQAS+ida2SMsCD/sr4JSdL6zJZdDHz6ywmRnNP4hUz5Ajyg32ybeMDjZQ
         1x8Ah/RHbS+9ZHfIpSuHNHT/rjs4n0zAHXStBt4KKfF7p5eM9NzjU/BKiNiDT/Rzum70
         By5c7ILEuuhi1YnFv8oO0Jr1s6vrT5tynQ4YdgI7jWAUUgwyQjizUsXISVKjnHK2KeQW
         PiDNgYdo1mxIgB2SewOpCat+HnV+kURv4Fda7q6oa4pobZsxmexX5xyrEEZsszNvOXsM
         j6Meh5B8g7XCP9mgYHKDAvLhCRVib1lHHzhlfvJmxA7oHW7SRoYQGguZVi8KN/frjuSv
         ZqZA==
X-Forwarded-Encrypted: i=1; AJvYcCVnBRISKVnwxhi/o+b1x4dVODxK7ht8/aWwRI8ObjavpUts7EWnsT1kKIMKfSGkNVEEWsAXyL1MXGKi7KItZYhRlqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXUtcfG8E4cbTG3PDeO0Nj3MDAF88J++IH62cY2jLVRijE+WOJ
	7AWypOubAa4ehvyBhqJ+7K2S3W+JC/5Tf8rxM5Kh3vQH2mtxrfQVIzfflyXxa4hfHxDmtYhJDcE
	iy2pxtKLrR6FDdsQVuQ==
X-Google-Smtp-Source: AGHT+IFhLM25JrhF91PI/1xl0Ucx2pu2bGxwHFlKnZCcYx2J0q55kmjIHyBfWwosFL87FFfcYtOKkEve+OiYyvpF
X-Received: from wmbfk5.prod.google.com ([2002:a05:600c:cc5:b0:439:7c0b:a4c9])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b08:b0:439:5da7:8e0 with SMTP id 5b1f17b1804b1-439ae1f30dbmr129078825e9.16.1740399328153;
 Mon, 24 Feb 2025 04:15:28 -0800 (PST)
Date: Mon, 24 Feb 2025 12:13:44 +0000
In-Reply-To: <20250224121353.98697-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250224121353.98697-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250224121353.98697-3-vdonnefort@google.com>
Subject: [PATCH 02/11] ring-buffer: Expose buffer_data_page material
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
index 2a1330a65edb..75cd0cb46768 100644
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
index c27516a384a8..e70f39e0adb1 100644
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
2.48.1.601.g30ceb7b040-goog

