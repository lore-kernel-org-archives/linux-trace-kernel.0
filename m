Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8DC47CA65
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786626726; cv=none; b=nNj31kv296jUfDcjMCngg+8p0VBfGavjkJ4KZJjY5BV8gdv7Ek4Jo+ACRG8YBCDZGqPrTpiZiSAfoyh34rCi4yUFzRzNlFkeCxYk0auV5uGYFhnYOSeGeWWdiHJsb3NfA/E1fQ/WBk+8PDSs4ny51wAcsWqXT1laNgvdhALNKII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786626726; c=relaxed/simple;
	bh=lKMK0MfkDIfSeWvC4wCnKzYYxJQHB+XsLd1+t3UjMIw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OKuBrrkAAGRxL7WEQoVRUB2or8ZZys4oH9F/xTsgAqE+M16yZrzFmlX/S+gWEii5yDnbPg8jxTmZDEIBfGxyc2n0M26IUIZQjQHlRGoyRpdk6/XwmLsbT6u/DS8ZDAeqkQKl8WcMGFnOgsFvwNPK6BYUT++sTX4h1cO7IORK7Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nBe93dNL; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nBe93dNL"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495529a93f9so8658845e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 06:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786626719; x=1787231519; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lGl2apXV5AfDfhGS4nKvuLOa4mDzXiM6MBzztIw4crA=;
        b=nBe93dNLmKC4MkCYH0jzf1JNJHc21nuXJdDAfvP6O+Q0BmulnyidLdq4qXk2ofcGja
         xuWTJKYEiiFgp0pmBNQm96rbiKIJjW2MJvhLyUVlMr8x/fSi3uIVI4x9nee7u5aQFEEv
         JVOAuV/aiD6uq4vQChgjNVWOtTsrxtZqkHRkYrBei3CX/0VxuPqsgQdL0YpTf67n5MZW
         H41OAOWk4NIaf1yN0t1GrntxFMjV3RtAht9In3LU5Cku3mkk4SBpR+9Tv6aXissZofek
         WAhFL6E8jJK6En7GxqNvIb9gFtsLVCHLgNvTDiY243lwwY78Fly7U0c1nqgbnX6SNIdV
         ElYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786626719; x=1787231519;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lGl2apXV5AfDfhGS4nKvuLOa4mDzXiM6MBzztIw4crA=;
        b=HP4mUk27I4TOUOfykNC9uO2V6qe47AR7UOtfYJb7eFDRSAM8Z/ED3hECsOSBLC1yi0
         tBTCgFSPe4sW6tD4n28obX4sYi3yOSbvZ+toGX1gEiQcSGjboiUtQWuCvcAyMwLPH68D
         skVSlJyGnlZU6ObGoT5bG3yA08nS1ctUJvdN/CmvhCjFvsIYVFvlKpVwBYR/zVvk7hov
         uPXf3MDcTdYx2ZwrSzpzUYGGomekv2cmwgR+5JK1CoFP7Q/92RrxUxuSu8I33oH1/Fx3
         TvoRHnOX5kRDpPPKJuH24GzIHXyyr6eK9QFlLwMhpCMFcnaDdaYFoxh6+uhumqFycJOt
         l/cQ==
X-Forwarded-Encrypted: i=1; AHgh+RrFdRyLa7G0xiK1cIyKV1z+fo65HlvKkb/Fheu7lQbL8RIOMgy1s8quI++CvzH/wfmeW0xP9Ay6J/2RkOn5S2yVEcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnVk3vKan6D6p0laMSGlYQyozf4k2TnvlXAOhzhUWg/ptPFiQF
	E2J0DoHFeSX3YVr86IGmEjq/2j71TWRKWs3cf6tNlJpsqrc1KcslRzNChxV6MTZBqFdQA2vNPr9
	HCAtIJL4zn0ZA1K7FtFkc0g==
X-Received: from wmbje11.prod.google.com ([2002:a05:600c:1f8b:b0:495:779a:eb54])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:470d:b0:499:484a:81d0 with SMTP id 5b1f17b1804b1-499821f1ebbmr58742035e9.9.1786626718832;
 Thu, 13 Aug 2026 06:11:58 -0700 (PDT)
Date: Thu, 13 Aug 2026 14:11:45 +0100
In-Reply-To: <20260813131152.3589632-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813131152.3589632-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813131152.3589632-4-vdonnefort@google.com>
Subject: [PATCH v5 03/10] ring-buffer: Make cpu_buffer::free_page a buffer_data_read_page
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Discarding a cached reader page after a concurrent ring buffer resize
uses the new global subbuf_order for the free_pages() call. This
mismatched order may crashes the kernel or leaks memory because the cached
page was allocated under the old size.

Save the actual free_page order alongside the page address to ensure we
always refer to the correct value and do not rely on the potentially
stalled cpu_buffer->subbuf_order value. The simplest is to make
free_page a buffer_data_read_page which already covers exactly what we
need: a page address and a page order.

Fixes: 8e7b58c27b3c ("ring-buffer: Just update the subbuffers when changing their allocation order")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ec4f5a0c93e8..b6fa258aafe2 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -507,7 +507,7 @@ struct ring_buffer_per_cpu {
 	raw_spinlock_t			reader_lock;	/* serialize readers */
 	arch_spinlock_t			lock;
 	struct lock_class_key		lock_key;
-	struct buffer_data_page		*free_page;
+	struct buffer_data_read_page	free_page;
 	unsigned long			nr_pages;
 	unsigned int			current_context;
 	struct list_head		*pages;
@@ -2631,7 +2631,7 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 		free_buffer_page(bpage);
 	}
 
-	free_pages((unsigned long)cpu_buffer->free_page, cpu_buffer->buffer->subbuf_order);
+	free_pages((unsigned long)cpu_buffer->free_page.data, cpu_buffer->free_page.order);
 
 	kfree(cpu_buffer);
 }
@@ -6962,9 +6962,9 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	local_irq_save(flags);
 	arch_spin_lock(&cpu_buffer->lock);
 
-	if (cpu_buffer->free_page) {
-		bpage->data = cpu_buffer->free_page;
-		cpu_buffer->free_page = NULL;
+	if (cpu_buffer->free_page.data) {
+		*bpage = cpu_buffer->free_page;
+		cpu_buffer->free_page.data = NULL;
 	}
 
 	arch_spin_unlock(&cpu_buffer->lock);
@@ -7016,8 +7016,8 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
 	local_irq_save(flags);
 	arch_spin_lock(&cpu_buffer->lock);
 
-	if (!cpu_buffer->free_page) {
-		cpu_buffer->free_page = dpage;
+	if (!cpu_buffer->free_page.data) {
+		cpu_buffer->free_page = *data_page;
 		dpage = NULL;
 	}
 
@@ -7390,7 +7390,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	}
 
 	for_each_buffer_cpu(buffer, cpu) {
-		struct buffer_data_page *old_free_data_page;
+		struct buffer_data_read_page old_free_data_page;
 		struct list_head old_pages;
 		unsigned long flags;
 
@@ -7433,7 +7433,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 		arch_spin_lock(&cpu_buffer->lock);
 		old_free_data_page = cpu_buffer->free_page;
-		cpu_buffer->free_page = NULL;
+		cpu_buffer->free_page.data = NULL;
 		arch_spin_unlock(&cpu_buffer->lock);
 
 		rb_head_page_activate(cpu_buffer);
@@ -7445,7 +7445,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 			list_del_init(&bpage->list);
 			free_buffer_page(bpage);
 		}
-		free_pages((unsigned long)old_free_data_page, old_order);
+		free_pages((unsigned long)old_free_data_page.data, old_free_data_page.order);
 
 		rb_check_pages(cpu_buffer);
 	}
-- 
2.55.0.691.gc56d675ccc-goog

