Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB53483BEA
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786722511; cv=none; b=DskFiTXaF5xlFtrZUacEVsoMckERSuKmvOBzSPBH9tAY2Fz6epTHHDDMJTOasaeiPxarmYbRYEZS2q7pRThEzdECdPA/3FNraScz4B2BOxmGPGSdiwdJt1luvlubpPvBvnWM4jfcIWe+mRhsdw8UxpJxd4K2tTU1GT4RP6l58+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786722511; c=relaxed/simple;
	bh=vQz6byzmMJzpQAWYZ5Vk3vVodifkgcRQQP/XzqERhuY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LZzA/cmt/4PaDGqFLbnyXMoXB56THB1rTqw5StgIlphdPL3QBdQ7MbbTrwyRMPNAdCXdeOm10CRDahfwwyOG2O+V63SGIlM5wOydbZN46FYpz0csiQ4I4wfRu7D0BF23olrdWZ2I9Xq2Zw9tz1ij9dHPKDxMPOVTIzX/0arhAZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kt+o5clM; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kt+o5clM"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493fa6e28a7so11930635e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 08:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786722508; x=1787327308; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J77n4YvjmDIOQaLmeeAERFnDXFw9L4MYNzDkoQbO2tk=;
        b=kt+o5clMHhVzM8MylLK6hahSTujcykJio7u7TlPQbumz9iUW3wdbpO5+K6Njgdc+OJ
         Ka6AbcvbUkepeQKXZolfduuE1Ea5cRGipnPeHeeAQtd1lLFXKzUF1dkQMtLxvBQrrG2S
         VZtcIjI5GuvvM66+zTW686kTHfaDj2zxrgr6Sylk2qtNYc/O7pyVvIoA6Lfe05JQCXDa
         HYzvH9cMDsoMtcGOemes8SpffYpPABBlXQyA93qKDKatEVxx2etnLV+8WxedyD3eTzE9
         gcN/55B8lRo8PIpws6TZriJyYFzR+374d9cJyqKQH7S493TXd7POYI9OtSnRhvrd3hcY
         lFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786722508; x=1787327308;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J77n4YvjmDIOQaLmeeAERFnDXFw9L4MYNzDkoQbO2tk=;
        b=ncIktwbQTRUOBIF6Ok63M+B3u2EyM61JKy54YOgvwH/wOBqHAOn+AbPrZQEt4I167d
         l+B6VIkFj6pRl6Q5xdj89xpVV72DYQqY9NtjNlkG6z7JgCIGz6CE26P+44vRH0eQN5Dg
         RcqKoiyEsAsMcpGsbimN9z48cfDoD76f3C13hQflbZbOdhK6a3B0e58VFuoi6Z+X1HDp
         IzdzDU5vma1pra4BhoDSSaUvYQ1UA+A3SKpPE6+Xq+1hOpdp1jD11UDmXE5C6syqM2hd
         aRfh+aKNiXPbD05c7yeObDxJPSlXwtCDeLlSFzdXm+ieTKl3GJG6/QZ/b6I6GHFGxZkP
         gMuQ==
X-Forwarded-Encrypted: i=1; AHgh+RpndTRJVkXfbzQqQ4AUT2lWJ5vK61De1Rw7l0CIIXU8KB5nU6G0Lom98+sLiD1qU3bDpCCCrT3+H6n2Mg35x3cfERE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz75GMWjdialC2aUpVgJT6O+Hft/7h21/B4FLfsYwAk1/LOLQn
	nq6I8DiBHKO2DI7HyT8Or121WPOv0wTP17vPo05Z7u/ZodMx7aX4aBAw58vRwOa8ip9ZYjHivyu
	h4Dxa3HWQ59BS+0Z2m8QX1g==
X-Received: from wmow7.prod.google.com ([2002:a05:600c:4747:b0:495:5b59:7a9c])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e15:b0:498:ee7:e407 with SMTP id 5b1f17b1804b1-49987999622mr100926375e9.17.1786722508134;
 Fri, 14 Aug 2026 08:48:28 -0700 (PDT)
Date: Fri, 14 Aug 2026 16:48:23 +0100
In-Reply-To: <20260814154823.755406-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814154823.755406-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814154823.755406-3-vdonnefort@google.com>
Subject: [PATCH v6 2/2] ring-buffer: Improve nr_pages type
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

If ring_buffer_per_cpu::nr_pages is defined as unsigned long, it is
capped to 32-bits in a few places, limiting the operations possible on a
very large buffer.

Make sure nr_pages is never capped to 32-bits (that includes nr_subbufs)
and reject a value over 32-bits for the user-mapped, persistent buffer
and remote buffer cases where the limiting factor is the shared
meta-data member for the number of pages/subbufs.

While at it, make sure subbuf_size is 'unsigned int'.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 46 ++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ec13779922ff..ec127e2ad052 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1669,7 +1669,7 @@ static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
  * This is used to help find the next per cpu subbuffer within a mapped range.
  */
 static unsigned long
-rb_range_align_subbuf(unsigned long addr, int subbuf_size, int nr_subbufs)
+rb_range_align_subbuf(unsigned long addr, unsigned int subbuf_size, unsigned long nr_subbufs)
 {
 	addr += sizeof(struct ring_buffer_cpu_meta) +
 		sizeof(int) * nr_subbufs;
@@ -1679,13 +1679,12 @@ rb_range_align_subbuf(unsigned long addr, int subbuf_size, int nr_subbufs)
 /*
  * Return the ring_buffer_meta for a given @cpu.
  */
-static void *rb_range_meta(struct trace_buffer *buffer, int nr_pages, int cpu)
+static void *rb_range_meta(struct trace_buffer *buffer, unsigned long nr_pages, int cpu)
 {
-	int subbuf_size = rb_subbuf_size(buffer);
+	unsigned int subbuf_size = rb_subbuf_size(buffer);
 	struct ring_buffer_cpu_meta *meta;
 	struct ring_buffer_meta *bmeta;
-	unsigned long ptr;
-	int nr_subbufs;
+	unsigned long ptr, nr_subbufs;
 
 	bmeta = buffer->meta;
 	if (!bmeta)
@@ -1731,7 +1730,7 @@ static void *rb_range_meta(struct trace_buffer *buffer, int nr_pages, int cpu)
 /* Return the start of subbufs given the meta pointer */
 static void *rb_subbufs_from_meta(struct ring_buffer_cpu_meta *meta)
 {
-	int subbuf_size = meta->subbuf_size;
+	unsigned int subbuf_size = meta->subbuf_size;
 	unsigned long ptr;
 
 	ptr = (unsigned long)meta;
@@ -1746,8 +1745,8 @@ static void *rb_subbufs_from_meta(struct ring_buffer_cpu_meta *meta)
 static void *rb_range_buffer(struct ring_buffer_per_cpu *cpu_buffer, int idx)
 {
 	struct ring_buffer_cpu_meta *meta;
+	unsigned int subbuf_size;
 	unsigned long ptr;
-	int subbuf_size;
 
 	meta = rb_range_meta(cpu_buffer->buffer, 0, cpu_buffer->cpu);
 	if (!meta)
@@ -1840,10 +1839,10 @@ static bool rb_meta_init(struct trace_buffer *buffer, int scratch_size)
  * must be the same.
  */
 static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
-			      struct trace_buffer *buffer, int nr_pages,
+			      struct trace_buffer *buffer, unsigned long nr_pages,
 			      unsigned long *subbuf_mask)
 {
-	int subbuf_size = PAGE_SIZE;
+	unsigned int subbuf_size = PAGE_SIZE;
 	unsigned long buffers_start;
 	unsigned long buffers_end;
 	int i;
@@ -2231,7 +2230,8 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	}
 }
 
-static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages, int scratch_size)
+static void rb_range_meta_init(struct trace_buffer *buffer,
+			       unsigned long nr_pages, int scratch_size)
 {
 	struct ring_buffer_cpu_meta *meta;
 	unsigned long *subbuf_mask;
@@ -2417,7 +2417,7 @@ static void *ring_buffer_desc_page(struct ring_buffer_desc *desc, unsigned int p
 }
 
 static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
-		long nr_pages, struct list_head *pages)
+			       unsigned long nr_pages, struct list_head *pages)
 {
 	struct trace_buffer *buffer = cpu_buffer->buffer;
 	struct ring_buffer_cpu_meta *meta = NULL;
@@ -2545,7 +2545,7 @@ static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 }
 
 static struct ring_buffer_per_cpu *
-rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
+rb_allocate_cpu_buffer(struct trace_buffer *buffer, unsigned long nr_pages, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer __free(kfree) =
 		alloc_cpu_buffer(cpu);
@@ -2702,8 +2702,8 @@ static void rb_test_inject_invalid_pages(struct trace_buffer *buffer)
 	struct ring_buffer_cpu_meta *meta;
 	struct buffer_data_page *dpage;
 	unsigned long entry_bytes = 0;
+	unsigned int subbuf_size;
 	unsigned long ptr;
-	int subbuf_size;
 	int invalid = 0;
 	int cpu;
 	int i;
@@ -2773,8 +2773,8 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 					 struct ring_buffer_remote *remote)
 {
 	struct trace_buffer *buffer __free(kfree) = NULL;
-	long nr_pages;
-	int subbuf_size;
+	unsigned int subbuf_size;
+	unsigned long nr_pages;
 	int bsize;
 	int cpu;
 	int ret;
@@ -2837,6 +2837,10 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 		 */
 		nr_pages = (size - sizeof(struct ring_buffer_cpu_meta)) /
 			(subbuf_size + sizeof(int));
+
+		/* limited by ring_buffer_cpu_meta::nr_subbufs */
+		if (nr_pages > U32_MAX - 1)
+			goto fail_free_buffers;
 		/* Need at least two pages plus the reader page */
 		if (nr_pages < 3)
 			goto fail_free_buffers;
@@ -2869,6 +2873,10 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 		/* The writer is remote. This ring-buffer is read-only */
 		atomic_inc(&buffer->record_disabled);
 		nr_pages = desc->nr_page_va - 1;
+
+		/* limited by ring_buffer_desc::nr_page_va */
+		if (nr_pages > U32_MAX - 1)
+			goto fail_free_buffers;
 		if (nr_pages < 2)
 			goto fail_free_buffers;
 	} else {
@@ -7421,8 +7429,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct buffer_page *bpage, *tmp;
 	unsigned int old_capacity;
+	unsigned long nr_pages;
 	int old_order;
-	int nr_pages;
 	int psize;
 	int err;
 	int cpu;
@@ -7604,7 +7612,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 				   struct buffer_page **subbuf_ids)
 {
 	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
-	unsigned int nr_subbufs = cpu_buffer->nr_pages + 1;
+	unsigned long nr_subbufs = cpu_buffer->nr_pages + 1;
 	struct buffer_page *first_subbuf, *subbuf;
 	int cnt = 0;
 	int id = 0;
@@ -7834,6 +7842,10 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	/* prevent another thread from changing buffer/sub-buffer sizes */
 	guard(mutex)(&buffer->mutex);
 
+	/* limited by trace_buffer_meta::nr_subbufs */
+	if (cpu_buffer->nr_pages > U32_MAX - 1)
+		return -E2BIG;
+
 	err = rb_alloc_meta_page(cpu_buffer);
 	if (err)
 		return err;
-- 
2.55.0.691.gc56d675ccc-goog

