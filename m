Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14D83B4E8D
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Mar 2026 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807759; cv=none; b=HjhGUoQugDJZay4yw4Tk+ZKrCcV/JsMLiVs/lCwViODpQsS0UmOrDiHNfpljbCok4KFdPo6gh7k6MDsrCawkgSmdA6hRlIzp8FK5B5vdsEkfEP8SN7bJcLG45+b+mfevMOsNNYoNX7TOXMtq1dVW3sr57nHSNDVepQn/LjRJ3tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807759; c=relaxed/simple;
	bh=D4gaKwLVIIsxcpxTwTQ6S3QUNIVaidgJpeYUAPhqmYU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MtTzValgT6wMM0y3qbNfr+bnD4YVP22eS4PQe269Ac9JLl8icUwtYRYm1wGszzclkmmeGd4iqbwlBnQLA5OUqTJQqbaMXO4A80BFf1A6O8+rx5YR5U9l9fw9J99p42yk1ILPfni9nM1R6Afg8dC3HcI3gUgEz0V2L8BsuY6sKXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ch2LI+Y+; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ch2LI+Y+"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48071615686so79867245e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Mar 2026 06:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772807756; x=1773412556; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ScN1NtxqIf/BVWk6GfS8Edcv4lujSSl4suwU/Na612k=;
        b=Ch2LI+Y+HnP3z88K6jlBj9CLljZwbW0A9De3o0S0mWinLq3HaPyDd5HGVh1EqkKKVv
         22BJy0TQCLcIUiyNrpHmuU4TAG+t5aqwcYmCfRP35wNA3ZuSjNxKp5MWJdCG+jGJ+YN7
         HOIflqy2oCUzFUMB5vSwSIEo8SQrB0UMNpY6/1E+EO95relzR/wGNjGDfZZ7pOf55Uq3
         zDCHQiUWZUUsLBA802pOKemyxWM5C3UJNTQD3d/T5aGoAMV7yjS5ZLd3oEHQzEfBqwvK
         TBzgEud2NDeKptmr/EKYfsmXc2ghvQ6M7a35BBDopW/o1uSMxPBwqzmPE6oUDbgh9KGu
         A5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807756; x=1773412556;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScN1NtxqIf/BVWk6GfS8Edcv4lujSSl4suwU/Na612k=;
        b=ZXQXdiHBUGpc71kVrUjRGe2OESjHys6q2p9VJuOKIVGL+UTWN2brojZ5TZ4OmvR8Mt
         5KfQtBOOBL0Cbps9swKcN+6wJSLDpX2rvBszmRfHeHrjbEpF0pjtaYIXDysiiaLjo3gs
         NT5ab4+oBRou7SY9Ub/ISBrO29os+20YYQz5/kj2PhAF7Za382oxXaQlpWj17GwFIeac
         zKaZQuy5/7AcYkDQloqErMeLM2kwkNg/06VV0RwVuUTs+m4kYalKG78hWKdnxVBBDJXb
         sd4AZSW6eVP8/+MjBqE6hlCNaKc/J1y0BevAbePZgEt3ZZwmxPP4ahRYaJUhwFU3trmt
         P6rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBqTLdh7dftLXvaeQyNxWYt15mvHf9nRaoLu9s8cB3a94EvsumKlfqbrzNReOLvicVBqcXH37xA7WBsRNZPl2nJB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydM6aiyFMh/PGOsntBFrYBbIRXuomG2BPcTgaEs2aK/mpnutU4
	IPAGMF3tkllth5NSmUHfzVU7q9v2YhPw0nE89dQqPnXK06N2BPpXRVpib3qfK5wOO7FhAs6tveO
	15iExX24V33IYyM3K8miBgQ==
X-Received: from wmcu23.prod.google.com ([2002:a7b:c057:0:b0:483:2758:404d])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b5b:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-48526927a4dmr39013355e9.15.1772807756248;
 Fri, 06 Mar 2026 06:35:56 -0800 (PST)
Date: Fri,  6 Mar 2026 14:35:08 +0000
In-Reply-To: <20260306143536.339777-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306143536.339777-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306143536.339777-5-vdonnefort@google.com>
Subject: [PATCH v13 04/32] ring-buffer: Add non-consuming read for ring-buffer remotes
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

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index da0cd8e82105..115435f2e8b9 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5388,10 +5388,51 @@ static bool rb_read_remote_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
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
@@ -5544,7 +5585,7 @@ rb_update_iter_read_stamp(struct ring_buffer_iter *iter,
 static struct buffer_page *
 __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	struct buffer_page *new_reader, *prev_reader;
+	struct buffer_page *new_reader, *prev_reader, *prev_head, *new_head, *last;
 
 	if (!rb_read_remote_meta_page(cpu_buffer))
 		return NULL;
@@ -5568,10 +5609,32 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
 
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
@@ -6155,7 +6218,7 @@ ring_buffer_read_start(struct trace_buffer *buffer, int cpu, gfp_t flags)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_iter *iter;
 
-	if (!cpumask_test_cpu(cpu, buffer->cpumask) || buffer->remote)
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return NULL;
 
 	iter = kzalloc_obj(*iter, flags);
-- 
2.53.0.473.g4a7958ca14-goog

