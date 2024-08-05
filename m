Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D22E17C64
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879217; cv=none; b=ZF9gKLm3R0bxqPdKPojoElfCaQDupIdRU8termDeDi/SDFxvHuM3W+UqDo4vnVnDon9N6fOh/VNuYahoYdqqwLLCX3cIvRMzO49kbTdJ6ISR+PWcdmsIOTZp6FF7qVy63VDKl6k3/3wL4x4mxDqUmh4UkD5cSdwvOdtrUk94vEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879217; c=relaxed/simple;
	bh=1NrPIOiaFcWy1pA7SeZO58DyGP+moHdFsjNSYGiQovs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vf3xt6j19T26zca8Uv8a6EFNfo78u3ZHPEj/WtsVXEXy6eTnXWeE1DKnEhFZh5eeOcU/6vOQ29pzYYxLznQsWSmtzMusWZkVLTsOpSPJj58WiZxBfjrOQwPcyGWWR+5s18iqnfDikKFj3Mt+zXq3AT+yqdr9OKJk3j5iLM48PmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YAbJek7w; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YAbJek7w"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-690404fd230so36745787b3.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722879215; x=1723484015; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A2jd+nZ7zCydcSHS9qkv11rRGweV2pR3YmHjm/L+b6o=;
        b=YAbJek7w1Ac2c6R3Aec/vYHwy7XdrzFjdeG34BjXKtfzpNlQKnNnAquvNxPAOugfmY
         qa0ehWrnZ1Bl5JVahBakgzOww6Bw8WjGR5gHnruPcow1suLHIlGzzP0GMNtrCi5BCvrX
         phL389qvg3vbT3isQsGD4j/EhjMtMFh4tX9gKH87hHkynHnOsgHRelX0NsYlaempm61s
         4UiPOb7NpyzFkUYGVoz9ibuEk3g0MeBb2ZCNU7h9uQY3LyDeqcJX6KVAZ+fc5J2TMAdw
         lgfTsu0jMvsuZ5dH83iW5cjxyYu9LJlcjm9X3srH9yXDtk3IJ6fCINjrdtZaMIRvHo70
         i/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722879215; x=1723484015;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2jd+nZ7zCydcSHS9qkv11rRGweV2pR3YmHjm/L+b6o=;
        b=ksU9PdFzgqSfCKFfsFj+XO8mgUJ2Bgb6Cgv4zy659nkAeyc0Z+FpoI3++NyGqOX4Y6
         P1rEuL+fJRFl419xi4gUZAYaM4k7Nhzlr3MVqNyZrC66i5Y4bWhQU6hssK49OR1sC5+/
         mX5xPvwGJC/KvpdpdO9ANRoCzG8LNKmZxygv8C7a5F9V/m3CviimTDThRicfCgGOGxXO
         lzkpD4Px6cRBOeJHnQ/mZ3trwlcRIoNi7T1axnpI4zdWM5vKQXimeEO2I1w67MtUK2ra
         SQTmnAgutCN3ydLG3rufQRgYFrhY+Iaf8gll+IdrcEl9RLaeYPaVfzGw3QuzpRFVoGi9
         PMrA==
X-Forwarded-Encrypted: i=1; AJvYcCU/LEl60fYZEbbSXjnXdOrzLgnP6ByLePgM65ZuzgMtLUSMGJdEDsLCIiEVzEO8H8NkOzR10sxdN0GRDDS9bZOo2Jzc1KmFF8GZfofSf5ElZFp8
X-Gm-Message-State: AOJu0Yxbwvb+mCKbjIVHBlQsngPnYBdY4qbqXnc0GZkLe9c1uYJdW1Nf
	5Xhp1lF9qfmrLE0sMTwVTjNVlBSFTc8EkrIUDFUKJjmgyCPpV2WIF97gU3/mSDDMKp485YFTy1q
	Ywt4h7ugJ0hUU3V9VQA==
X-Google-Smtp-Source: AGHT+IH9rlAJCZiANrVd4cygC2GlEEarzxxTnrIG5AU1Lx9lNgnvYh5Ez2oOozI3CIzKmGFUVsO/YBSH0IL4yed+
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:690c:113:b0:61b:e103:804d with SMTP
 id 00721157ae682-68959c192bfmr3553157b3.0.1722879215017; Mon, 05 Aug 2024
 10:33:35 -0700 (PDT)
Date: Mon,  5 Aug 2024 18:32:24 +0100
In-Reply-To: <20240805173234.3542917-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240805173234.3542917-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805173234.3542917-2-vdonnefort@google.com>
Subject: [RFC PATCH 01/11] ring-buffer: Check for empty ring-buffer with rb_num_of_entries()
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev
Cc: kvmarm@lists.linux.dev, will@kernel.org, qperret@google.com, 
	kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
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
index 28853966aa9a..f4f4dda28077 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3953,40 +3953,22 @@ int ring_buffer_write(struct trace_buffer *buffer,
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
@@ -4132,19 +4114,6 @@ void ring_buffer_record_enable_cpu(struct trace_buffer *buffer, int cpu)
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
2.46.0.rc2.264.g509ed76dc8-goog

