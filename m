Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1B143F8D7
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789155612; cv=none; b=TtT24d7vZz18i5WhBb0+ilFOtuo6KMFMLbTktKpgkBAnukDgWL77OSLlgBSMulheRNFtP6NAxbqNNyAhWMKUhMC5sHV/1GZzZIB8cY/oC3ke+8ZDCW95hoG1f3KcER98zWkiW3WZAX3RM6NGY93oXIp0DfckK5mB1lYKdtHB0M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789155612; c=relaxed/simple;
	bh=hHw7yRoGhvN7MS5FpP2lX23LuKJXsj+eKlavKiGW0rA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jBV+SYmFhpr+66RierraipWDDgdPamgFJeqvI2FMfGyH4CFoloz6bCT5axPQT+fuJo5ZarzqqG0GyHz3Ps6Fzp0Nv4fUIBTZJO5mQAoqEykvUGHs9D/cf/hRy/ThAlhMCemNAkQJfp9fOJpRKCAUmgfm/17P8hUKu0cMfYZ4ohA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P/S3ST0L; arc=none smtp.client-ip=209.85.221.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P/S3ST0L"
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-486f18da958so549504f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 12:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789155595; x=1789760395; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y+HXnPMMIZpskweD6Y6dmHOP8zh8fc/lEgtzHbrvfOQ=;
        b=P/S3ST0LySyP8FyzSRxlCptHKzPuatNMp4Xx4QWQGxFlAAXFpnAX6gAUiyMzy61ZP0
         q7FG0R6MuXyQoJth7irrwG2j69KkR/jE/93JmPOmXF7RaNCPcLzoaLaon7lI4etV7kZ4
         t8UPhypeK7r2yDe6U4KW3/cC13KKxQV7xzasVmoioG1EG1fiFKHaZ6V2zAJoKmqChkf5
         UOQW/b5ixwoRDuUNxv7/Wd94zoZD4Hc7rQEpG5Upp4MjrWPXHxe4PQ9vpCexcX4xdtFT
         RroCrXIKTVQ797+3xpSqnFgCpairnxE763/fbG+bqA34KWpndzlAbbhDjGS4GqxOJHB9
         fXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789155595; x=1789760395;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y+HXnPMMIZpskweD6Y6dmHOP8zh8fc/lEgtzHbrvfOQ=;
        b=mxYFJKo30b7li4/Wvos5okw9pjCGiHEHp7HHSW9HSQJJBxUG+CfyZQm7BHY31pfJaU
         1Py1KFobJ24Q8YmIjHMbqsTtRWFMBUw9vRlMrYDWvLA3lYnmfENRN5kkJtPNA+B6+QbL
         5WTscM+4qTXbwsZXQsKWi0qZkqw4bBppx3xB614sE1HlQD/Y1Idl0tPphtLqCbQvFlsr
         jzoOSPWlOXIXEVGhbBh7QUm3yrBvP1A9cZNYq09vo+5hJMyy8hfMClQUbfnNm8QJ5Tyk
         iu1lOEgF8AglWOczbUmawyUuFWH/3T/f8Jw4wolfa78JpccCnNtcX3pHCY25a/giH3XI
         Iu2A==
X-Forwarded-Encrypted: i=1; AKwUvBwYa5a6vHB9r8PBwEJywy+VDl+xCGDAUXSL5PhvuKQudGAez94od6X1jukviFwC3DWc5UwsAVc4lgj/IPTwU/ZvQu8=@vger.kernel.org
X-Gm-Message-State: AFuF++lme5ig/7YtPVPBelcwEHKQmp2vREbYAHw8E8eT+pIZSYAWnVCa
	ML9wPsUc1reEzPyIGrASif1qCw2yr3v0msEBdlBBrdeU5vEUAr3xQPcKCYvyyEdtWjOG62Bca8w
	HgLqI4vsaiWUs6j1EKDHcBg==
X-Received: from wrtl11.prod.google.com ([2002:a5d:4bcb:0:b0:47f:472f:4e85])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1001:b0:485:8ea0:da8c with SMTP id ffacd0b85a97d-486e987d543mr5838331f8f.16.1789155595237;
 Fri, 11 Sep 2026 12:39:55 -0700 (PDT)
Date: Fri, 11 Sep 2026 20:39:37 +0100
In-Reply-To: <20260911193937.602202-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260911193937.602202-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260911193937.602202-4-vdonnefort@google.com>
Subject: [PATCH v2 3/3] ring-buffer: Unify ring buffer minimum page calculations
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The codebase scatters hardcoded minimum page limits across multiple
places. Introduce RING_BUFFER_MIN_NR_PAGES and rb_calculate_nr_pages()
to formalize the requirement of two pages in a ring buffer.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 include/linux/ring_buffer.h       |  9 ++++++++-
 kernel/trace/ring_buffer.c        | 32 +++++++++++++------------------
 kernel/trace/simple_ring_buffer.c |  4 ++--
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index eac3e9080c3c..e4370064273e 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -98,6 +98,13 @@ struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flag
 
 void *ring_buffer_meta_scratch(struct trace_buffer *buffer, unsigned int *size);
 
+/*
+ * A minimum of 2 pages ensures we can always swap a page out of the ring
+ * buffer. This does not account for the reader page or any other page
+ * containing meta data used by static ring buffers.
+ */
+#define RING_BUFFER_MIN_NR_PAGES 2UL
+
 /*
  * Because the ring buffer is generic, if other users of the ring buffer get
  * traced by ftrace, it can produce lockdep warnings. We need to keep each
@@ -287,7 +294,7 @@ static inline struct ring_buffer_desc *__first_ring_buffer_desc(struct trace_buf
 static inline unsigned long __calc_nr_pages_ring_buffer_desc(size_t size)
 {
 	/* Takes into account the reader page */
-	return max(DIV_ROUND_UP(size, PAGE_SIZE - BUF_PAGE_HDR_SIZE), 2UL) + 1;
+	return max(DIV_ROUND_UP(size, PAGE_SIZE - BUF_PAGE_HDR_SIZE), RING_BUFFER_MIN_NR_PAGES) + 1;
 }
 
 static inline size_t trace_buffer_desc_size(size_t buffer_size, unsigned int nr_cpus)
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9c03a555a6ba..7137781ab0b8 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -642,6 +642,11 @@ static __always_inline unsigned int rb_subbuf_max_data_size(struct trace_buffer
 	return rb_subbuf_capacity(buffer) - RB_EVNT_HDR_SIZE - sizeof(event->array[0]);
 }
 
+static unsigned long rb_calculate_nr_pages(struct trace_buffer *buffer, unsigned long size)
+{
+	return max(DIV_ROUND_UP(size, rb_subbuf_capacity(buffer)), RING_BUFFER_MIN_NR_PAGES);
+}
+
 /**
  * rb_subbuf_start - Get the start address of a subbuffer
  * @buffer:	A trace buffer
@@ -2865,7 +2870,7 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 			goto fail_free_buffers;
 
 		/* Need at least two pages plus the reader page */
-		if (nr_pages < 3)
+		if (nr_pages < RING_BUFFER_MIN_NR_PAGES + 1)
 			goto fail_free_buffers;
 
  again:
@@ -2877,7 +2882,7 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 			ptr += subbuf_size * nr_pages;
 		}
 		if (ptr > end) {
-			if (nr_pages <= 3)
+			if (nr_pages <= RING_BUFFER_MIN_NR_PAGES + 1)
 				goto fail_free_buffers;
 			nr_pages--;
 			goto again;
@@ -2900,13 +2905,10 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 		if (nr_pages > rb_static_max_pages())
 			goto fail_free_buffers;
 
-		if (nr_pages < 2)
+		if (nr_pages < RING_BUFFER_MIN_NR_PAGES)
 			goto fail_free_buffers;
 	} else {
-		/* need at least two pages */
-		nr_pages = DIV_ROUND_UP(size, rb_subbuf_capacity(buffer));
-		if (nr_pages < 2)
-			nr_pages = 2;
+		nr_pages = rb_calculate_nr_pages(buffer, size);
 	}
 
 	cpumask_set_cpu(cpu, buffer->cpumask);
@@ -3319,11 +3321,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 	mutex_lock(&buffer->mutex);
 	atomic_inc(&buffer->resizing);
 
-	nr_pages = DIV_ROUND_UP(size, rb_subbuf_capacity(buffer));
-
-	/* we need a minimum of two pages */
-	if (nr_pages < 2)
-		nr_pages = 2;
+	nr_pages = rb_calculate_nr_pages(buffer, size);
 
 	if (cpu_id == RING_BUFFER_ALL_CPUS) {
 		/*
@@ -7495,12 +7493,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		}
 
 		/* Update the number of pages to match the new size */
-		nr_pages = old_capacity * buffer->buffers[cpu]->nr_pages;
-		nr_pages = DIV_ROUND_UP(nr_pages, rb_subbuf_capacity(buffer));
-
-		/* we need a minimum of two pages */
-		if (nr_pages < 2)
-			nr_pages = 2;
+		nr_pages = rb_calculate_nr_pages(buffer,
+						 old_capacity * buffer->buffers[cpu]->nr_pages);
 
 		cpu_buffer->nr_pages_to_update = nr_pages;
 
@@ -8095,7 +8089,7 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node)
 	}
 	/* allocate minimum pages, user can later expand it */
 	if (!nr_pages_same)
-		nr_pages = 2;
+		nr_pages = RING_BUFFER_MIN_NR_PAGES;
 	buffer->buffers[cpu] =
 		rb_allocate_cpu_buffer(buffer, nr_pages, cpu);
 	if (!buffer->buffers[cpu]) {
diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring_buffer.c
index 49913bb0057a..abfaf9bee12e 100644
--- a/kernel/trace/simple_ring_buffer.c
+++ b/kernel/trace/simple_ring_buffer.c
@@ -383,8 +383,8 @@ int simple_ring_buffer_init_mm(struct simple_rb_per_cpu *cpu_buffer,
 	void *page;
 	int i;
 
-	/* At least 1 reader page and two pages in the ring-buffer */
-	if (desc->nr_page_va < 3)
+	/* At least RING_BUFFER_MIN_NR_PAGES and 1 reader page */
+	if (desc->nr_page_va < RING_BUFFER_MIN_NR_PAGES + 1)
 		return -EINVAL;
 
 	memset(cpu_buffer, 0, sizeof(*cpu_buffer));
-- 
2.55.0.1007.g17ff1f9808-goog

