Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAC7494A18
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789408765; cv=none; b=Z7s0v3d0mKcK07KAc/3ptfERYlu6s+qpGDJKWppjjoSUEUyQlSZKJb23+vwAw9Ck5RgDYv60uhV/tgwtbP1VxJbKeHhPHPzIuz/lTh0uNWlsHqN3d8VUwbvdLMd7850h2agfeIgRw9TVq3fWZJLRz1Xw2LjII/urd+8ObSLraYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789408765; c=relaxed/simple;
	bh=Hi3KF1rFSlwOgvsXa0YKg6banHYZooWVqpRPGNChmak=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CB7Rz4hlY+Xg59JI/iZZHZjLYoGe0aw2F4H68j1DHw1JbeX0E+saNZ0CkAf/y2DbQDcHEQF5D4N6gqm4P+FcwhO/g8lt2QxeKkk4n5enDjcezxAMkflecTfd6EtBT8RuTaXgIYidZ2o2Y7XfnSxxUljeD7+mJa+auSfkiVNog08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YERxAAA8; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YERxAAA8"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e661c6440so19744165e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789408761; x=1790013561; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KAmPM9lg8P4nRxDL5AHK8i1KVL3bJ1XhAL6W+r2RlSI=;
        b=YERxAAA8mGEP+0eHolShXC9DTmdF+gizKwe0RAcoRnJ+2s7BbM4v/w6xnzUzE/WELA
         4Xo7p0dIZRa55QikcZRScZ3eLi/jn8SFKrinKjcml92PHXsdm1NzQUOvepyJbWLWbX4J
         scmLpcuOWjBz68eAqiSCwE03SnLKXPflmRwKANb3xR2qvxssXD+wdjw6ZNdmkCI6fXCe
         2wO7xLywPBpuNnRB/owSV3CQ5LD5uwU7Zau8U5d5kC1YkSpL5I9jSNMJOqGi5kSSeUfj
         bF2zvGgj3QGMDpIjn5xZW0N6HNIWKwrNJBfH2O223WywvXTCyb1X+m2vkGEBmtR2KECN
         DTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789408761; x=1790013561;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KAmPM9lg8P4nRxDL5AHK8i1KVL3bJ1XhAL6W+r2RlSI=;
        b=hgPEwTODcy/WYHVgnfCc5s/YOzybB3Sj2FhKBGbTU9zAL9l2hOhxYaocKmoIBHE9Xk
         wSNmB7Ol9+0zaTdSmWIx9eamB5DuBW/BXptVh8/yRygsfHnPCHginko6mml3Hxxbh+sh
         YgOAxb2iXVJK80YR45cu/t+Jq6nQwWGZf9vacBdpzvTYlkMEtFs8eDy5d8cJFuAmr8co
         ojPTXTXAJLnJJQaWniP2lAd/AO+3Vi0/evraKujwsJIhZZudVDVPM2hoOlUw0DTCp0pQ
         SayCitSNZE7+GCHLsPHALJK2bZOHhTGVggW32pQ1tDdIVgdKCYLFYpyOxHFxnw6fNP8K
         NpDQ==
X-Forwarded-Encrypted: i=1; AKwUvBzj3h4zKV/XajEAhU93UA3DshmgewP0XugarCKAxj8+yzHOHQbHPSlEjTX5WWkeugtYWb1vpiwIxnWzjPL3U4kjKxs=@vger.kernel.org
X-Gm-Message-State: AFuF++mFoDZv4gtoxOkGpRnFfy0fStVMWq9GVfAeAi7JNrXWerrk2rBQ
	gvxGhQ+DP3MpHiCuHjHr2J2BkUh/ehEP5GXxlZXddGnXPTI29RHTMSKu0bx3E1s23gfiqd0fhER
	yjahhg6R+luA0PLl2qo3DYQ==
X-Received: from wmcu10.prod.google.com ([2002:a7b:c04a:0:b0:49e:6b63:7e98])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3484:b0:49c:fa21:e742 with SMTP id 5b1f17b1804b1-49e7a68c148mr51819185e9.24.1789408761238;
 Mon, 14 Sep 2026 10:59:21 -0700 (PDT)
Date: Mon, 14 Sep 2026 18:59:07 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260914175907.1027349-1-vdonnefort@google.com>
Subject: [PATCH v1] ring-buffer: Clean up resize_disabled checks
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, devnexen@gmail.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

ring_buffer_subbuf_order_set() checks for resize_disabled twice under
the same buffer->mutex hold. Moreover, this check duplicates the logic
in ring_buffer_resize(). Create a common helper rb_resize_disabled() to
factor out this code.

Additionally, remove the unnecessary cpumask_test_cpu in
ring_buffer_subbuf_order_set().
for_each_buffer_cpu() already iterates over buffer->cpumask.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 67 ++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 39 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 04bb94c29f58..37801ac5e92e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3280,6 +3280,21 @@ static void update_pages_handler(struct work_struct *work)
 	complete(&cpu_buffer->update_done);
 }
 
+static bool rb_resize_disabled(struct trace_buffer *buffer, int cpu)
+{
+	lockdep_assert_held(&buffer->mutex);
+
+	if (cpu != RING_BUFFER_ALL_CPUS)
+		return atomic_read(&buffer->buffers[cpu]->resize_disabled);
+
+	for_each_buffer_cpu(buffer, cpu) {
+		if (atomic_read(&buffer->buffers[cpu]->resize_disabled))
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * ring_buffer_resize - resize the ring buffer
  * @buffer: the buffer to resize.
@@ -3324,20 +3339,17 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 	if (nr_pages < 2)
 		nr_pages = 2;
 
-	if (cpu_id == RING_BUFFER_ALL_CPUS) {
-		/*
-		 * Don't succeed if resizing is disabled, as a reader might be
-		 * manipulating the ring buffer and is expecting a sane state while
-		 * this is true.
-		 */
-		for_each_buffer_cpu(buffer, cpu) {
-			cpu_buffer = buffer->buffers[cpu];
-			if (atomic_read(&cpu_buffer->resize_disabled)) {
-				err = -EBUSY;
-				goto out_err_unlock;
-			}
-		}
+	/*
+	 * Don't succeed if resizing is disabled, as a reader might be
+	 * manipulating the ring buffer and is expecting a sane state while
+	 * this is true.
+	 */
+	if (rb_resize_disabled(buffer, cpu_id)) {
+		err = -EBUSY;
+		goto out_err_unlock;
+	}
 
+	if (cpu_id == RING_BUFFER_ALL_CPUS) {
 		/* calculate the pages to update */
 		for_each_buffer_cpu(buffer, cpu) {
 			cpu_buffer = buffer->buffers[cpu];
@@ -3409,16 +3421,6 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 		if (nr_pages == cpu_buffer->nr_pages)
 			goto out;
 
-		/*
-		 * Don't succeed if resizing is disabled, as a reader might be
-		 * manipulating the ring buffer and is expecting a sane state while
-		 * this is true.
-		 */
-		if (atomic_read(&cpu_buffer->resize_disabled)) {
-			err = -EBUSY;
-			goto out_err_unlock;
-		}
-
 		cpu_buffer->nr_pages_to_update = nr_pages -
 						cpu_buffer->nr_pages;
 
@@ -7473,13 +7475,9 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 	old_capacity = rb_subbuf_capacity(buffer);
 
-	/* The mmap fast path reads subbuf_order without buffer->mutex. */
-	for_each_buffer_cpu(buffer, cpu) {
-		if (!cpumask_test_cpu(cpu, buffer->cpumask))
-			continue;
-		if (atomic_read(&buffer->buffers[cpu]->resize_disabled))
-			return -EBUSY;
-	}
+	/* Check it is resizable before we touch subbuf_order */
+	if (rb_resize_disabled(buffer, RING_BUFFER_ALL_CPUS))
+		return -EBUSY;
 
 	atomic_inc(&buffer->record_disabled);
 
@@ -7490,17 +7488,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 	/* Make sure all new buffers are allocated, before deleting the old ones */
 	for_each_buffer_cpu(buffer, cpu) {
-
-		if (!cpumask_test_cpu(cpu, buffer->cpumask))
-			continue;
-
 		cpu_buffer = buffer->buffers[cpu];
 
-		if (atomic_read(&cpu_buffer->resize_disabled)) {
-			err = -EBUSY;
-			goto error;
-		}
-
 		/* Update the number of pages to match the new size */
 		nr_pages = old_capacity * buffer->buffers[cpu]->nr_pages;
 		nr_pages = DIV_ROUND_UP(nr_pages, rb_subbuf_capacity(buffer));

base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.55.0.1032.g73a4cd73de-goog

