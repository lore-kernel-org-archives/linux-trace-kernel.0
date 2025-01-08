Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C421F8AC5
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Jan 2025 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736336766; cv=none; b=bAAg18rF4YNk/DT+TNe8LuFaIpAYWp+rpX1gZv6Q9gEWmFAhL169ZzBf/FNmxQSon5TLyR4YTbFnro/awUsd3D8VY2AGh+gSVD9uFvNL/lBZoBrZ0Qk/6XGwb1j/XLnH8UnPQFpzogS5cuC9W7GdATg1AbOrjWT4PyKUmxKvwdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736336766; c=relaxed/simple;
	bh=4ZpzoNm/txc8kJpaD7zlRSFU5GxKzrlqqiRVN0+DWZw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jtW1418+YfvrVH54Nzl1lk34LKYlWo/SJswNXuqtu35KA92E38Fk1SrdsSnc0mS+INePhSXtmKT+UST0fM3/WAvp27J11Z65Ak7pwZ//Zipkf/W5jdq47BMGzJRUGXSUbEKEfzTgMusGekN761IyY08Se5KAcDprXLTmks6HmwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QFrz2bMk; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QFrz2bMk"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4361efc9dc6so91448855e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Jan 2025 03:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736336763; x=1736941563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GlQWGu8jmtIvOtRUmNoKfRUqkWu3tRvtK1Xuk9VMi2w=;
        b=QFrz2bMkdxuaKR5NpOvRIL2LtVpxeGjYPfjo4hYuAKvkpVuK75jCidcFYH+7EeNqY2
         vS3dpWUpb3JUHzP98ttY4mv6ktsLpWrPCUZSA0PdPmA0eTeYdhki0/v434jLMCpgO4HM
         /7rV+443Tue/nzonjKNmnkHTdQRnV6vgOu5W/HjNr8VWV/Cf4crqPiLGlwaLzrKg1g7t
         v7h/JBia6yuU65leU8+WSahLLHU5hT2RZyll8MMkEPSrZFUImmnWQn8l9bAeutiTsLPv
         VUJtXGuChwyKRambqx+h777gmRz8Syk1lMquJjpHESNIFZb6UF9M6j3BIqDyjeOUcQ7F
         kkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736336763; x=1736941563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GlQWGu8jmtIvOtRUmNoKfRUqkWu3tRvtK1Xuk9VMi2w=;
        b=k4BFe3wMt9AXEEFlmc995QZLtqbLIN1DLZwOAEw7c2YOpOkAvtN5R/OWInoHq5I9nk
         K9xEkBnlAydBoLvlxaH60a2yAXqvIXgqYNwaFgTTO3uKhr9P1TyoQ1pqa+CWKlS9XxGn
         QeaEvhpRb/vtHZJ/DFvqITK7bnbPU2BRu3Vj+bb0eD48zWyZZRoAIs6SQqe3a1AifdzS
         dJ7LkPGVv8Px4+UGhS+KgPHqvVaYr3OLxl9eJWeNrdITxpXOIXScX1WrdXoqN1q57JS7
         lEFSpTuUwC2LZh9nOolIJKV5oW8ubmZjPY0dHRKwd1Fz2VXnUzvmTLwmAJsll/YbCD8x
         uKBA==
X-Forwarded-Encrypted: i=1; AJvYcCUndjXE1yO0aG4U8pPpz9l4pWtwgZ61qWCSPi9eR24YlFwG3aTDKtbemI7McuSOTaWeEbmeiwbZeiFQVxCV5hVzWqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+yFdsGGQ3I50zV4TaZ6NUDBHDiDSSM6Nz5BbZmbJfqgqb7PbK
	gJpawvEO1Tjrfz0JB9WTJFsFA4nPzA4iElCYpWBXWdjihoI/shWz6FuruENlvTlRqfhAA2t4rEn
	wD6e9d6ZQAWBbVzwJJA==
X-Google-Smtp-Source: AGHT+IEsCuJFvJabPcJ0/q5MQuWzgchKOfMrLBtBvZQzD03qm3RdWOAWIvuvDxtaZjB1IDdZEPVC6IpmGkJZeMJs
X-Received: from wmbg16.prod.google.com ([2002:a05:600c:a410:b0:436:5887:e183])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4714:b0:374:c4e2:3ca7 with SMTP id ffacd0b85a97d-38a872f673cmr1877142f8f.5.1736336763167;
 Wed, 08 Jan 2025 03:46:03 -0800 (PST)
Date: Wed,  8 Jan 2025 11:45:25 +0000
In-Reply-To: <20250108114536.627715-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250108114536.627715-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108114536.627715-2-vdonnefort@google.com>
Subject: [PATCH v2 01/12] ring-buffer: Check for empty ring-buffer with rb_num_of_entries()
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently there are two ways of identifying an empty ring-buffer. One
relying on the current status of the commit / reader page
(rb_per_cpu_empty()) and the other on the write and read counters
(rb_num_of_entries() used in rb_get_reader_page()).

with rb_num_of_entries(). This intends to ease later
introduction of ring-buffer writers which are out of the kernel control
and with whom, the only information available is through the meta-page
counters.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 60210fb5b211..479bbbcbf61b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4682,40 +4682,22 @@ int ring_buffer_write(struct trace_buffer *buffer,
 }
 EXPORT_SYMBOL_GPL(ring_buffer_write);
 
-static bool rb_per_cpu_empty(struct ring_buffer_per_cpu *cpu_buffer)
+/*
+ * The total entries in the ring buffer is the running counter
+ * of entries entered into the ring buffer, minus the sum of
+ * the entries read from the ring buffer and the number of
+ * entries that were overwritten.
+ */
+static inline unsigned long
+rb_num_of_entries(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	struct buffer_page *reader = cpu_buffer->reader_page;
-	struct buffer_page *head = rb_set_head_page(cpu_buffer);
-	struct buffer_page *commit = cpu_buffer->commit_page;
-
-	/* In case of error, head will be NULL */
-	if (unlikely(!head))
-		return true;
-
-	/* Reader should exhaust content in reader page */
-	if (reader->read != rb_page_size(reader))
-		return false;
-
-	/*
-	 * If writers are committing on the reader page, knowing all
-	 * committed content has been read, the ring buffer is empty.
-	 */
-	if (commit == reader)
-		return true;
-
-	/*
-	 * If writers are committing on a page other than reader page
-	 * and head page, there should always be content to read.
-	 */
-	if (commit != head)
-		return false;
+	return local_read(&cpu_buffer->entries) -
+		(local_read(&cpu_buffer->overrun) + cpu_buffer->read);
+}
 
-	/*
-	 * Writers are committing on the head page, we just need
-	 * to care about there're committed data, and the reader will
-	 * swap reader page with head page when it is to read data.
-	 */
-	return rb_page_commit(commit) == 0;
+static bool rb_per_cpu_empty(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	return !rb_num_of_entries(cpu_buffer);
 }
 
 /**
@@ -4861,19 +4843,6 @@ void ring_buffer_record_enable_cpu(struct trace_buffer *buffer, int cpu)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_record_enable_cpu);
 
-/*
- * The total entries in the ring buffer is the running counter
- * of entries entered into the ring buffer, minus the sum of
- * the entries read from the ring buffer and the number of
- * entries that were overwritten.
- */
-static inline unsigned long
-rb_num_of_entries(struct ring_buffer_per_cpu *cpu_buffer)
-{
-	return local_read(&cpu_buffer->entries) -
-		(local_read(&cpu_buffer->overrun) + cpu_buffer->read);
-}
-
 /**
  * ring_buffer_oldest_event_ts - get the oldest event timestamp from the buffer
  * @buffer: The ring buffer
-- 
2.47.1.613.gc27f4b7a9f-goog

