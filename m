Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A2C1B6D06
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498744; cv=none; b=fNBv2xw4T8fpARugA8mjVsk6iW1BpgTBvZofvH41H1DSFeegkAHAJ/CgiGCZ157uk6SFiH0Ekcc5mNOMkoe4vcyy26LosL170emedtPh6DPIS2CSecFn71z4CSHwjwAhGM3vdX5ckTxIfKaAm1nvftLp+uYjh1Z7HZz/KsYYIIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498744; c=relaxed/simple;
	bh=XRylxRegtzNDYd9BgfEEjeSNPLRLZezIsWEeEyVhZYg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p66+ZvsebQOs3b0PS6B02fIuU5zzYNKeHinPh6ioseCBvjq8gKQU+IjAe8/TdGjiYvxUjTW9xcdp9PBjvFNl8GMwBPdSlpcye/YZ6EVIgLMsQaL/pnK9RgD5R0FBZPz2Wq22okq2HBCK6AWEBuNo9XE1k8BhWdjb/IST1a89HRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OzRVq+fH; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OzRVq+fH"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e47d14dceso8885345e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759498741; x=1760103541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OeES3oT5PyEYk0S7oFEzISO9wFmxktxYre//FfeIR3c=;
        b=OzRVq+fHgEuV84avK3GDEKiIiSubtogaHErZzR6PiQKHGw+fa7LyMG+Cm42i/o8M0A
         Ak6FDMm2Zq58RXvzHdLceLhuxbsMsqYf/44lhrumuDKDU/GMQV5TuF2z87y6XwulQ7at
         siRBv0DZr0Zi7zouHyoYCjZfGGVO0F0bzJ7kW3SvDYmJupZ6JIwomrUkkkwtVtmIREqb
         ON69Axq3ydq9fp7CodK+FIX+3Aq50nqVwVo4yPifbRHnWstMvxB2urc5jZNQ/COq+EMl
         INSiuDBdnB7NECyd6SeZMYc+kFLgHSF6/cgUH9sgsLYvgmmp5ZympnT6zs0SFMeNVnj3
         RG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759498741; x=1760103541;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OeES3oT5PyEYk0S7oFEzISO9wFmxktxYre//FfeIR3c=;
        b=Ho14h6gCr7wuMIJnI/PVXUymfs7n6MTYEHHyTdhneT90o/SUHcHieraoT9wcqRB2LB
         MkqwPBdAoT5JFePLRrCPHLNoc68MZ2r6Fxroobvr6m5MIu9m+POFwjFIyYAWj8SLnsj6
         iJDYbNzsbGwrk+aJLLOExyEM9uASG2fZeeoo8UyMlnBvyTuWQKzDZjnszPO4z6LrhgOE
         N8R9UxhhdjWLbcE+D3ubMI0MxJCG61NkNl2yEakdU0Pxfdi/bpj14WtWp6sOMILvc18p
         S80U0bUQR9duKNE3ERJrp6dGlOoRTw3l7nQQYEKjap3JkemP70CmBD/f9792NdarFkWy
         ucIg==
X-Forwarded-Encrypted: i=1; AJvYcCVgUY1hAnUXk9V5cADnhsWhFk1D5xJMOPwfKQZbLsxlUL8SA78FWqwA+FubCsQtPxWdxqfIiSEay09HZZbvzLVEl9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXEZ2lRXC7zr01je2BDqow2qDTkyKXCHa1KI6ynY4cX8ycDnwS
	g0Mc7JuS2di6yZ8CxtN4+Lv3+CsDEddQTuQtS+k7ZQZ7UptiXpe8/nH9E+YP8/FfRgJWM996hsF
	7uv1kWzUkCHXkyl4YiUgZZA==
X-Google-Smtp-Source: AGHT+IGobet5rQpznC+XIhmKIJiRNYXHbeaHBHQTmrC1zAJ4pbkMbv8NZ8mLtntgHPeO+O/7sVs17qI0/PPoX2Bh
X-Received: from wmoo17.prod.google.com ([2002:a05:600d:111:b0:46e:1bcf:3f8])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8185:b0:468:7a5a:1494 with SMTP id 5b1f17b1804b1-46e710f6c7amr19128115e9.1.1759498740786;
 Fri, 03 Oct 2025 06:39:00 -0700 (PDT)
Date: Fri,  3 Oct 2025 14:38:01 +0100
In-Reply-To: <20251003133825.2068970-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003133825.2068970-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003133825.2068970-5-vdonnefort@google.com>
Subject: [PATCH v7 04/28] ring-buffer: Add non-consuming read for ring-buffer remotes
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
index 54f3f47b392b..eb556e691b5e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5347,10 +5347,51 @@ static bool rb_read_remote_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
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
@@ -5503,7 +5544,7 @@ rb_update_iter_read_stamp(struct ring_buffer_iter *iter,
 static struct buffer_page *
 __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	struct buffer_page *new_reader, *prev_reader;
+	struct buffer_page *new_reader, *prev_reader, *prev_head, *new_head, *last;
 
 	if (!rb_read_remote_meta_page(cpu_buffer))
 		return NULL;
@@ -5527,10 +5568,32 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
 
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
@@ -6114,7 +6177,7 @@ ring_buffer_read_start(struct trace_buffer *buffer, int cpu, gfp_t flags)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_iter *iter;
 
-	if (!cpumask_test_cpu(cpu, buffer->cpumask) || buffer->remote)
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return NULL;
 
 	iter = kzalloc(sizeof(*iter), flags);
-- 
2.51.0.618.g983fd99d29-goog

