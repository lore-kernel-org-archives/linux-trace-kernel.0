Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492892;
	b=H84HD1nE++h9E8kej0roF+kFF1P5d0qA/pBGD2TjXOEDfmY7ZloRC+53B6UCCk2i0/RD
	 xPTVi2LM17eMOaTS4WuW4xOBOVbYoMbVf1gynuh5occmpYqF2N/Sfio9THnCK8XS2udpq
	 1UmPEG8MK5N43u6dR/b2hhsnFTUUp4MvzrpQ/ehu8s+BAb6c93ZsSrYiNyt9OLn6SuRop
	 R5CU1WSfdK31djnHA3OgVSMZUgwBWFb79SWEb05H/GrSHkHf8kji0z9GEsFQSZQ1aUq/4
	 v/Kro/7k6n6/+AkBVern3EuTIRXSU2SbICEwVmhhd0NGpZPfoFqFmEZkVhMDr46nwrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=qPYxO8yb9cFKKsz6ALKUIcminvOwQueZf2m4pspgC6M=;
	b=sFAxoJPYMrfo6zijIQM3Juy8CVb4FS5qQEEe1xuHzfAqAQ+NDPkYOlybne3Pqo7Htx2T
	 QsxOVqIYINAkkeR1v8P91j+upvXCVrJbQgndtjN8aY7h26NvHdG7CBVx9vFjlJa0NHFbr
	 +iyx3E2Bv38SCMH7w2P+7VootpE4Aaf0tdRnabw9uif25b/OSSs4eMztz4KNkOFcT1s8H
	 rnB7LgDdeXCw+dSlY8wJU+zMY0Cz0JfmawVQlY3NmEKtHDRClVkIIB64cs6ahKn+ewh3T
	 971MwYTt2b12xhTWsz4Nv/n+IUffJGDJwzbaONnms/aCcomhgy0aRtHg9MQxynq4keg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j+VoHntu;
	arc=none smtp.remote-ip=209.85.221.71
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9716606A321
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 14:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9716606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j+VoHntu
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-49166c8a60dso3115512f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 06:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794492890; x=1795097690; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qPYxO8yb9cFKKsz6ALKUIcminvOwQueZf2m4pspgC6M=;
        b=j+VoHntuU4igrsmP6TE1OXCUM1JRlm8fXK456qTbFwNlDde40bQ21lOzivIdAbyVzS
         Y0L44Xp0XPVQI1+XwKk83yluGoJmW0sLUeMQcKcPRd1b98j1c2ApsrZb/5h3I2MEdfjL
         gGceVSYiKQLYZBraUJFUyyXoFdVFUgbqhriymQeyPBI4XgR2D9uStqt8DGW/VjuM0K3t
         cNVNlmLme/bcw98AqojzrVAhWyhwqQpggTQlB6P1nTRgEjOpeCHuhGu3KOEG7p8wJy/x
         rCvilkjR0J8RWe3WNo6Or1viY5v3MJbuA74gwTLIR214sEtRZK1AhNe5tlnEfMpSedSY
         Yeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794492890; x=1795097690;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qPYxO8yb9cFKKsz6ALKUIcminvOwQueZf2m4pspgC6M=;
        b=Hip1Ez5Ix72DcWst5T02WX7BQOpxJa3MglilFLfdb+78xqMQ0HzNBeH8LLHhRXJdZo
         in9s9mtOb6mHQxszLfInC4Lowt+J9hIS6U4s+7P1tQvoF79Kz+pXzFD80hOXagvjzIU1
         pxbLQmaLB+gfK8r7eUlafaRkMLRUbYNP6wk6X9kX5qRYn+QivLteqxKwK5IaDjB9IamW
         jDG/welh2jlluYlC6d4dvu+ES04RhFyMfMiHEmj92YG4KWkfWY9DPO5Wnb9bS1MT66fz
         Nw32NqKvvYmhdxDKglvVP0B+ZsXRLaHGaKqD4LCBNidv5RaF3cgk8GkGfAMjssg9e74+
         6upg==
X-Forwarded-Encrypted: i=1; AL+hErH7lpJX/D/OuNWLetua0Ez/UANvkq+3xStEQSdAINH9CD2T0zhPwuqm8HQqZvB8xN8kSXzGPaS2fcJQ/CZEtsf1NVc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nA/QpSY9C3PSanlLoOshIJfMRyBirN/VFF1S0MOM70HdZvAWJ
	YSiyw/n+JWeY9QK7Zr1w8nsjannonl5zEnYu6cOTofp4ELb8o7noFNFIi3w/Kgm85k6G8MXSDWI
	E8nMRIHh5EmWlVxK8vcDFWg==
X-Received: from wrnw1.prod.google.com ([2002:adf:ec41:0:b0:48d:efe0:5ddd])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:250a:b0:48b:db7:86a7 with SMTP id ffacd0b85a97d-499c8c6703cmr11900707f8f.50.1794492890294;
 Thu, 12 Nov 2026 06:14:50 -0800 (PST)
Date: Thu, 12 Nov 2026 14:14:32 +0000
In-Reply-To: <20261112141440.3050124-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261112141440.3050124-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112141440.3050124-2-vdonnefort@google.com>
Subject: [PATCH v1 1/9] ring-buffer: Always read buffer->buffers after testing
 the cpumask
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

ring_buffer_reset_cpu() reads buffer->buffers[cpu] before testing the
cpumask. If trace_rb_cpu_prepare() sets the bit in between, the cpumask
check passes while cpu_buffer contains a stale value. Read
buffer->buffers[cpu] after the cpumask test passes.

While ring_buffer_peek() and ring_buffer_read_page() cannot hit this
race because callers already check the cpumask, apply the same pattern
for consistency.

Fixes: 554f786e284a ("ring-buffer: only allocate buffers for online cpus")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1fd28a72e6ee..bd8126f6353b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6340,7 +6340,7 @@ struct ring_buffer_event *
 ring_buffer_peek(struct trace_buffer *buffer, int cpu, u64 *ts,
 		 unsigned long *lost_events)
 {
-	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
+	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_event *event;
 	unsigned long flags;
 	bool dolock;
@@ -6348,6 +6348,8 @@ ring_buffer_peek(struct trace_buffer *buffer, int cpu, u64 *ts,
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return NULL;
 
+	cpu_buffer = buffer->buffers[cpu];
+
  again:
 	local_irq_save(flags);
 	dolock = rb_reader_lock(cpu_buffer);
@@ -6740,11 +6742,13 @@ static void reset_disabled_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
  */
 void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu)
 {
-	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
+	struct ring_buffer_per_cpu *cpu_buffer;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return;
 
+	cpu_buffer = buffer->buffers[cpu];
+
 	/* prevent another thread from changing buffer sizes */
 	mutex_lock(&buffer->mutex);
 
@@ -7198,7 +7202,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 			  struct buffer_data_read_page *data_page,
 			  size_t len, int cpu, int full)
 {
-	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
+	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_event *event;
 	struct buffer_data_page *dpage;
 	struct buffer_page *reader;
@@ -7211,6 +7215,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return -1;
 
+	cpu_buffer = buffer->buffers[cpu];
+
 	/*
 	 * If len is not big enough to hold the page header, then
 	 * we can not copy anything.
-- 
2.56.0.567.gdb80ae8cd5-goog

