Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0604D30DEAA
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Dec 2025 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764668199; cv=none; b=JJ6wxp0FXyevT3Qxwb87VpFRjNFcj7A6Y4FNBVCEFkzAbAq/r8uvTVeqtnlFH0YuYYUAMo7idXlbFrKWxHvn/uWFSySm+E3xqP4Uhs5lOA+KOcc04rra6oEz6ROJO6O+KUd0ZMSHQlvsTUFG9hZpFla0UDlyPROLJEU1aj3G1F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764668199; c=relaxed/simple;
	bh=+eDwcR/MyK6osxWUTRUN9JKU08z2QxE7z4o2fObuxeQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WnI0Q/Iix/NJ9Qy6pLBk8Qg9czPyZWlI2cSuSCMlQBB1Y8vd/HaZJ3b+VCwxoo95QkAxjVR7l9/gpxLAxhmYPj0nfuqVIegeuy4T1L0V6o6alBKUiZWxx6W8Xz3M8cMWaZCpJhIE4nkIZEQrFiAI49OaUm6pHmbo1XeYIBNi7cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FIYCThBg; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FIYCThBg"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4779edba8f3so35930895e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Dec 2025 01:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764668195; x=1765272995; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mmnmPnoKS58rysqE29lUfzlQEDVMTKJ+Y24/6OpLVn4=;
        b=FIYCThBgmYkz5Hk4zCBEpV6fJO9uyFUITCnSSfOZP10b/8Wf82+deAsFIouSMHtIRL
         vWnMS7ozQe2GZJjXhhBF1Ig/Ee+v+DC2nMmKC2rCtUtPrdzYh3uCPjQiVUn3qer3a+qx
         Jvv+jcXUFTc+zlDeX7bc9bR2KY3BZ3U6m+JN9h4TQ398PUs0gilx0Za7hxmInWo+Qdfz
         +sotiHCxeM7I8lQJvUn+y9Edew27H3ZrqAc7fnCVGTIl+l28Cmz2jiybhlKKOQ2HDiDt
         yS9s74BouzfbcfTpVJGjYzOCBt9ddQ+SUZhq1FQnykCAvnk3fuiV2Kr0i7eK2+Z5uvyq
         6fYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764668195; x=1765272995;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmnmPnoKS58rysqE29lUfzlQEDVMTKJ+Y24/6OpLVn4=;
        b=MlYUtQk+HR57q20N5BpZ8IhQlYytkWt4HY+DyvU0pGGZM+i6cjd9Ut5oeMXSzEjP8a
         RX8ovFjIVp+sbGl5z1WBXulyXaRoIPEEiLnLPWQXFWzHaGJ8KuYvVtKDsgAfQTF1jLvH
         1G1AaWBGjSoqaX2hK49OIlZeJHd2UPLfH7dHEJVXnIko9x04h+iQpRhpuwwVoWoE4e6X
         fx1YVEgij5u9q6PA5/uccgzj+YSGE0larqfNJ/3LFdZuIHrBIA02jQ9eLe0K9m3udHur
         X99BabYV5b6rdnH3mc9JASJJYO6Mnl5Eyr/xCRyIjF9Jz4qKSi5sNLQmIE1/D80tmSrw
         P0Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXF0zZuQsxIf30Mp7+yhKoDrxf8gqm/ciyTKk3nZhKMVxRV9Dqi8IHxexiEn6kCVw/YMnvSxfWbY9+nEddqsV+gaXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwdTkwfdiWwpZ/wXcWvvEc3MpjdOAUKe0xzi4SmD+ghWvhV6mB
	/2l4wQWhxAwXl4sqgGsmpQsl2053wa6WOdA8h0Iv1q5xhkNqvQc4y8z6s/DaIt09Bw4tkefy4qw
	r2zatab6Oly9rGe6dB9aM2Q==
X-Google-Smtp-Source: AGHT+IHxpU2RjXgPE3dFyHp+bs/wQ2ZJ3c3K0tGZhcA9ODepkf14EOjrYCgHkcicrP7QgAeOjeYJEOgEjUddT/jk
X-Received: from wmdn1.prod.google.com ([2002:a05:600c:2941:b0:477:103e:8e30])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f0f:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-477c0165bb8mr406176625e9.3.1764668195451;
 Tue, 02 Dec 2025 01:36:35 -0800 (PST)
Date: Tue,  2 Dec 2025 09:35:57 +0000
In-Reply-To: <20251202093623.2337860-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202093623.2337860-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251202093623.2337860-5-vdonnefort@google.com>
Subject: [PATCH v9 04/30] ring-buffer: Add non-consuming read for ring-buffer remotes
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
index 9c6c8e206e04..cb674a9fc359 100644
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
2.52.0.107.ga0afd4fd5b-goog

