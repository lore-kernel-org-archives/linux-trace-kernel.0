Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053DF331A40
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424273; cv=none; b=PYG2qY/ez2R0S0qTx6XpN8ciR5ALWQ4I+V8hQWw/x5jNImRlqwcrYoC2EhTvtZEqkuZMbRtqJw/M2HbIK6GBpAdi6PlKoCH/PusuHOKSL5FfwUjVgmGDqHMUS5nGu/ZmqfAi9QBGYZOgVfMdpWbgUKRbWf+2xlE2dgEm8VJOFE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424273; c=relaxed/simple;
	bh=8F58iQMB4tBPv70sAm1v5E47V6FBgfk4KenF4H6rNnM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uCjGHwRq68HvS6IQdD4zGEWA9ytOg1cttqrZbMyfNjtQVK+0GAMxO0HppvXPzxGcejUBL7zcbAUgI7G9qagcKlGCn4wI0UidLaiBsGLr9UnvEg0odvkKvEXvAi/RBJRRZNzF1CmmNEvvq4nmMaBLusd2XK+9K4M5cuoTWNcr2L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zaxtsiXr; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zaxtsiXr"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b870d3327baso336325966b.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 02:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769424270; x=1770029070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7OmHJweSyCaZn58+xoi2Pzi5D+f/3kb8/kFIARNGu9Y=;
        b=zaxtsiXr0HRzTvSJvonXklV39wtpwzHMIN/trf9md3hm4wwADkPtfh6XebPM8ZQ+Xl
         RbtJw5KVElmPNcsgcWCX1UHM5M0F7tN/7yfwcnhD94C4FG94IvLm5vNfZDiPWw7h94Qe
         5wudYDTV2DN+Uqiv97Quj07m0Uj+iHYPkeQBBOQd0+R8KDQ0906d4cgXkMIANQJ/cCln
         2lDCEXjrNjAotmG3N/eR8xNFY4eQwhTUX94HN5Kl38T8Ei5WT3Kv/4SplDs3pH4PQTYA
         Llu+B7jjo0JdFS+syKUyZZctFAsLVF0J60sZeiW6YiUwG5F1feL35ZQ/zI0LfOMZV8rL
         yX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424270; x=1770029070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OmHJweSyCaZn58+xoi2Pzi5D+f/3kb8/kFIARNGu9Y=;
        b=dWAtOFy5gcgrt4+eQ2I1oTZYUBkUDPrFvOWDDEjL+ois4LNN1mnNcuHPaUgLpopg2v
         H/OpiZRKdSy+GXQpI84u+pnfKjupK128CjxzsYyrVKzE371jYrVVRbwd0/6mNswReGCR
         AUqTaozI4XkS5QYgermpSViU13pmmqIUmZS1wqkShwZzlWk+YV7hNmkTR0QfPdpS8abT
         5I1XEa6uapj/prRPnJAoisynkkyZYzGLEvJgITeXz3Odsqtv//ldnALxxC8JCj3VuY96
         tahIECjdptsSBCMNqPGhP7uZYJf0zs0S2OccmkXdZgZrO7ommIGd1ZHAIkHQKOeU9v5h
         vjVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVER4NsLbRTbjdngek5Ll0yZcuogHaBAstKYmUjtiS5+5xwqMPnRPpL8W077jZnasPtiF4SdpHxXPkJ4/1NXAXqjzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwumRRYg3MnaD2oO9rbJiA3j4YUZupT0WbiDBmdhe9a+ZHTyL5v
	ztiAV35isok/PPpJ1ysB7IKF+THIYsGCP0fGKiwEbcaZYolRU3TP4qVXPmt7pKHZadsItr84qh+
	+bKrM6B+lFTOJUiOihOGWPA==
X-Received: from ejbgc18.prod.google.com ([2002:a17:906:c8d2:b0:b88:4972:40aa])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:c10:b0:b73:4d06:bc8 with SMTP id a640c23a62f3a-b8d4f796f90mr289787966b.53.1769424270027;
 Mon, 26 Jan 2026 02:44:30 -0800 (PST)
Date: Mon, 26 Jan 2026 10:43:53 +0000
In-Reply-To: <20260126104419.1649811-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126104419.1649811-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126104419.1649811-5-vdonnefort@google.com>
Subject: [PATCH v10 04/30] ring-buffer: Add non-consuming read for ring-buffer remotes
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Hopefully, the remote will only swap pages on the kernel instruction (via
the swap_reader_page() callback). This means we know at what point the
ring-buffer geometry has changed. It is therefore possible to rearrange
the kernel view of that ring-buffer to allow non-consuming read.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 00754339733d..2d08dd326309 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5365,10 +5365,51 @@ static bool rb_read_remote_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 	return rb_num_of_entries(cpu_buffer);
 }
 
+static void rb_update_remote_head(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	struct buffer_page *next, *orig;
+	int retry = 3;
+
+	orig = next = cpu_buffer->head_page;
+	rb_inc_page(&next);
+
+	/* Run after the writer */
+	while (cpu_buffer->head_page->page->time_stamp > next->page->time_stamp) {
+		rb_inc_page(&next);
+
+		rb_list_head_clear(cpu_buffer->head_page->list.prev);
+		rb_inc_page(&cpu_buffer->head_page);
+		rb_set_list_to_head(cpu_buffer->head_page->list.prev);
+
+		if (cpu_buffer->head_page == orig) {
+			if (WARN_ON_ONCE(!(--retry)))
+				return;
+		}
+	}
+
+	orig = cpu_buffer->commit_page = cpu_buffer->head_page;
+	retry = 3;
+
+	while (cpu_buffer->commit_page->page->time_stamp < next->page->time_stamp) {
+		rb_inc_page(&next);
+		rb_inc_page(&cpu_buffer->commit_page);
+
+		if (cpu_buffer->commit_page == orig) {
+			if (WARN_ON_ONCE(!(--retry)))
+				return;
+		}
+	}
+}
+
 static void rb_iter_reset(struct ring_buffer_iter *iter)
 {
 	struct ring_buffer_per_cpu *cpu_buffer = iter->cpu_buffer;
 
+	if (cpu_buffer->remote) {
+		rb_read_remote_meta_page(cpu_buffer);
+		rb_update_remote_head(cpu_buffer);
+	}
+
 	/* Iterator usage is expected to have record disabled */
 	iter->head_page = cpu_buffer->reader_page;
 	iter->head = cpu_buffer->reader_page->read;
@@ -5521,7 +5562,7 @@ rb_update_iter_read_stamp(struct ring_buffer_iter *iter,
 static struct buffer_page *
 __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	struct buffer_page *new_reader, *prev_reader;
+	struct buffer_page *new_reader, *prev_reader, *prev_head, *new_head, *last;
 
 	if (!rb_read_remote_meta_page(cpu_buffer))
 		return NULL;
@@ -5545,10 +5586,32 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
 
 	WARN_ON_ONCE(prev_reader == new_reader);
 
-	cpu_buffer->reader_page->page = new_reader->page;
-	cpu_buffer->reader_page->id = new_reader->id;
-	cpu_buffer->reader_page->read = 0;
-	cpu_buffer->read_stamp = cpu_buffer->reader_page->page->time_stamp;
+	prev_head = new_reader;  /* New reader was also the previous head */
+	new_head = prev_head;
+	rb_inc_page(&new_head);
+	last = prev_head;
+	rb_dec_page(&last);
+
+	/* Clear the old HEAD flag */
+	rb_list_head_clear(cpu_buffer->head_page->list.prev);
+
+	prev_reader->list.next = prev_head->list.next;
+	prev_reader->list.prev = prev_head->list.prev;
+
+	/* Swap prev_reader with new_reader */
+	last->list.next = &prev_reader->list;
+	new_head->list.prev = &prev_reader->list;
+
+	new_reader->list.prev = &new_reader->list;
+	new_reader->list.next = &new_head->list;
+
+	/* Reactivate the HEAD flag */
+	rb_set_list_to_head(&last->list);
+
+	cpu_buffer->head_page = new_head;
+	cpu_buffer->reader_page = new_reader;
+	cpu_buffer->pages = &new_head->list;
+	cpu_buffer->read_stamp = new_reader->page->time_stamp;
 	cpu_buffer->lost_events = cpu_buffer->meta_page->reader.lost_events;
 
 	return rb_page_size(cpu_buffer->reader_page) ? cpu_buffer->reader_page : NULL;
@@ -6132,7 +6195,7 @@ ring_buffer_read_start(struct trace_buffer *buffer, int cpu, gfp_t flags)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_iter *iter;
 
-	if (!cpumask_test_cpu(cpu, buffer->cpumask) || buffer->remote)
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return NULL;
 
 	iter = kzalloc(sizeof(*iter), flags);
-- 
2.52.0.457.g6b5491de43-goog

