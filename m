Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8403C51123B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572518; cv=none; b=d3/uO3KhERulWlWAP6e4lQuOeDpDdwsvOFwQv/2SLl5WDCwGaLp2BZqrGE/mJXUywxngdYAQ8tkt/+5OxCJPCQVzX6PcuwF2IKoAMv8NaYVXx9wp2rEOkhIOjyVpC3fA6/7S+qPGH/7CNPDqfnEoDYKYNwCBKVg6QNOBu74V2Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572518; c=relaxed/simple;
	bh=TXteeCRtix+xVHTlNUBmPxcBgoC0nsHNPU9LRC6hnbk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rLgpKdDN5uJO4mVtoHvuqoX9z6SVv5KXObuMUjgqDWdYiAhbIeUx7fg69jGLZC2D7gIYHfYkipgYwJV+Eyrp9KJv/Ovpwv/AYFOodHIjpc4jBIiTl55whTLsEeVEt78g8NRtoOr8yQNayoorvilb1b12CXKIiFPO04CCehhC5j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bX5D34qQ; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bX5D34qQ"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49e6683d48fso51246115e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 08:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789572507; x=1790177307; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rSH0k2F7aL4twNq/bkwjKNFeVoAS1hGzVzxlltkMSZU=;
        b=bX5D34qQs8qZZ6UbwCCvYRRFvXFu6GhJ0WDxXjbJxjht+GB0OEEmtXN8hOnIXXyoof
         GKVldWK3HJ7M7nKwzLfmvHq0Q6vNlC39JrCXJb0MRUpj8D9kV9pxoSnFE07JyQxLjwNM
         NpiLnOKky0OC3JitzidKHExWa5LAb/TAsaG1z5l1bb7ktXiL0rzJ0s5s2h6v660DsFk+
         37KYSxjHFd/+8aKpmFfGIOs95H1AYdUzFveIQt3D9T7BuG/aLjfWPbonfhBTX0AdilXS
         RMxPl9N48yFz05DbtenRcZoY4/bGgUTYefqkzegRVOzEKiO7JHZmNWtyyXN/lwtQ57qJ
         v+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789572507; x=1790177307;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rSH0k2F7aL4twNq/bkwjKNFeVoAS1hGzVzxlltkMSZU=;
        b=kFZadeyJq7PNDr0K1lo+iAa3Ev+czYOyHQNAgGKHDZ63osXGCLndg3h4EFHtUCBKo9
         KTx4Nvlp+tyndvkimq6jn/MgkIlJClUHayOyOttZpKjExTA5+j9SNgX1/gnPwijC6dXB
         8WItYTbh3BNsUONSYXbM2h9IYK0cfPrXq2tl08x1ejeseVFl1iXOcEG21HM1+6dMp43Q
         Bqd6+/OLslZuR7ncllY0p/1vcaAGgD+hLLqjnrpjHQetGx6YQo8Fb98Ck8WlsMh/VvqW
         Or5r2550hUYkhY6blhrMkoC1GSaIfaUYoXYAn1upjBZBAODMdu+7e0lbPD208EtFH6lx
         a/bQ==
X-Forwarded-Encrypted: i=1; AKwUvBya4sySLPmQdaNNAUiC2iEBZyLx1RqU0TPRtjmqUnqDkBYswqZBkwrpnkVBC/xNf2Nf8GHkXVNY473kgyvQynM51EA=@vger.kernel.org
X-Gm-Message-State: AFuF++kRYtvQXGW/lIxL5GGyjuIg3qqZiMyl6QKKCmn8i8xajNP0yVdT
	sSoJk9fxx/z96yZ7Y8nvBLyeB/DTWRRsJYHT8CtBs3CF4z3Ciw/+ATdh7I2aHjcChXa0gSRh1lK
	ZBDocff0KBQvetMFDKGFQDA==
X-Received: from wmsk7-n2.prod.google.com ([2002:a05:600d:8487:20b0:49d:f3f:1e8b])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:548f:b0:49c:fc6e:8cbb with SMTP id 5b1f17b1804b1-49ec0543ce6mr39073525e9.31.1789572507438;
 Wed, 16 Sep 2026 08:28:27 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:28:12 +0100
In-Reply-To: <20260916152813.105082-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916152813.105082-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916152813.105082-2-vdonnefort@google.com>
Subject: [PATCH v2 1/2] ring-buffer: Clean up resize_disabled checks
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

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 63 +++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 35 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 04bb94c29f58..73311c4fc556 100644
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
 
@@ -7496,11 +7494,6 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 		cpu_buffer = buffer->buffers[cpu];
 
-		if (atomic_read(&cpu_buffer->resize_disabled)) {
-			err = -EBUSY;
-			goto error;
-		}
-
 		/* Update the number of pages to match the new size */
 		nr_pages = old_capacity * buffer->buffers[cpu]->nr_pages;
 		nr_pages = DIV_ROUND_UP(nr_pages, rb_subbuf_capacity(buffer));
-- 
2.55.0.1082.g2b9226bbc0-goog

