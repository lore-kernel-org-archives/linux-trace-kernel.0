Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B154F3BBFDB
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787737537; cv=none; b=uXSY6sbO6GW72t+3Z7BfWTM5+81bq4k4Ka0SRyEcgkiE8ereZpPCLZMiN6/7AlpgU5hcGeeXNVpf6C3NzkQHJOoE3myHkOGc6nfG7h2kS/9/EchchbkAlI2O+P+/2g+jy5yaQOXx8VInlLm3yXS28f2w/SdW3dkPzS59yum9rMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787737537; c=relaxed/simple;
	bh=9GvMaws9PIuzDfM6Kx1/sGBDmvJF4DhLMYDax9a7XUY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u+qe3T/Zng36Z13O1guuG/Tv/OMlZVpUoAer6nYPQbe3n+wVV/XcWV7pcYEgXHZdgASy9P1lCe98cACU3mrHQVGf786dsSaRXyE2IrXuHtfJ6ZWK+0WxduuSvYsaTWwkW2N3RSk9IVTkmAUPfymp856JfOmpFM6v/yD66lQ7POM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tkdoQqWU; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tkdoQqWU"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49953abe51fso3444785e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787737534; x=1788342334; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3LWnSH1Ba+lR51/zFZG5VDYDvFp27k+/A/HbRVvfHQ8=;
        b=tkdoQqWUiU+8JnZ8gIdu3yb44WRxdjMPxuHAzIE4jimgprImYA4eYmQkG06jLFR8FK
         GFetwFKtdy9J45zst72kodbp9rFCoKyAMeUkOW1jSEIlqOFYDPOeOvp0R/aJ8XXVpt4N
         s6T1+3m1u4PboXbXC8TAUl+H59+h+3hjyPTHYgg9D/WYrVQJzhnV1F8A7SjUz7Cvfegq
         i2V1C3hemrOVAdL8gDEcJdC0GHKlS9CBrICmnfTONwNvKktLRLV9jVyAcM/FtFsJCLgf
         e7aV4I25JXx6ZJD5SzAHkNFuErPxlI7yKxNt9AyAd6P0foaAX9+ebRmEWBts3nHMKbOM
         ZFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787737534; x=1788342334;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3LWnSH1Ba+lR51/zFZG5VDYDvFp27k+/A/HbRVvfHQ8=;
        b=s9Rlikf+hsaISLDxIoiqv8/lSgjqNfwFB69tGkgbMGwcHonHHEmQOVZTH5j/bO1msV
         8q2kFPvrVQabJLpbQa+Y7r1s1Rz1f+jbtCYDWdTizQJfvoK9qbUAdAmhCzQGtrnqV4qp
         r0rg0qRc3o6sEKAx1tXWpG2dxUS2z2LYqtnsVmR9OzohW1kpPIg8ZchnaDKE+JddOsYd
         qEEbhNeeD04WJISbv2ZcQHT5PwpriGatYjKkHfoU6fSNl9hW4VBLjVtWRC9JQ95tPy5K
         X9G6nNd/LvV/Op7Xle2VBdlEiZhri2DyR1GE9TpbC0PppwiLizx/kyxSTvEkEqESd/6+
         YPeg==
X-Forwarded-Encrypted: i=1; AHgh+Roqd96zvCG42VONSPELx8qlwbwG/CGlhp/grhs3wtS2iM+4gWbapLXQe0uXS3oofViGXBBQt7rYrmdmbTVwLz1NEh4=@vger.kernel.org
X-Gm-Message-State: AFuF++kNXB/CcukcmGmGbtjP9TwPXknOFucFhAbqkOKOmFpcxDgzL/rO
	7fk3xB96t700Wz8R2ihRc8U2l2xv66DAuWiJdzM3OJ/Um8kl16qVERbuM5zoAb2+6iOXhDQnHSN
	fD9n5qVyhYqZjIaezZ7bNvw==
X-Received: from wmom18.prod.google.com ([2002:a05:600c:4612:b0:495:5422:15f2])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3155:b0:499:4892:d022 with SMTP id 5b1f17b1804b1-499dc6feffcmr39924575e9.8.1787737533424;
 Wed, 26 Aug 2026 02:45:33 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:45:27 +0100
In-Reply-To: <20260826094528.3738023-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826094528.3738023-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260826094528.3738023-3-vdonnefort@google.com>
Subject: [PATCH v8 2/3] ring-buffer: Cap static ring buffer nr_pages
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Static ring buffers (i.e. persistent, user-mapped and remote) rely on
the bpage::id field. The number of pages for those ring buffers must fit
into that variable. Enforce this limit on ring buffer creation or
user-mapping.

While at it, make buffer_page::id 31 bits. This does not change the
struct buffer_page size.

Fixes: be68d63a139b ("ring-buffer: Add ring_buffer_alloc_range()")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index b8e6bd309707..6089fcc67e2b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -350,7 +350,7 @@ struct buffer_page {
 	local_t		 entries;	/* entries on this page */
 	unsigned long	 real_end;	/* real end of data */
 	unsigned	 order;		/* order of the page */
-	u32		 id:30;		/* ID for external mapping */
+	u32		 id:31;		/* ID for external mapping */
 	u32		 range:1;	/* Mapped via a range */
 	struct buffer_data_page *page;	/* Actual data page */
 };
@@ -657,6 +657,15 @@ static bool rb_is_static(struct ring_buffer_per_cpu *cpu_buffer)
 	return cpu_buffer->user_mapped || cpu_buffer->remote || cpu_buffer->ring_meta;
 }
 
+static unsigned long rb_static_max_pages(void)
+{
+	/*
+	 * Static ring buffers are using bpage::id and must account for the
+	 * reader page.
+	 */
+	return (1UL << 31) - 1;
+}
+
 struct ring_buffer_iter {
 	struct ring_buffer_per_cpu	*cpu_buffer;
 	unsigned long			head;
@@ -2842,6 +2851,10 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 		 */
 		nr_pages = (size - sizeof(struct ring_buffer_cpu_meta)) /
 			(subbuf_size + sizeof(int));
+
+		if (nr_pages > rb_static_max_pages())
+			goto fail_free_buffers;
+
 		/* Need at least two pages plus the reader page */
 		if (nr_pages < 3)
 			goto fail_free_buffers;
@@ -2874,6 +2887,10 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 		/* The writer is remote. This ring-buffer is read-only */
 		atomic_inc(&buffer->record_disabled);
 		nr_pages = desc->nr_page_va - 1;
+
+		if (nr_pages > rb_static_max_pages())
+			goto fail_free_buffers;
+
 		if (nr_pages < 2)
 			goto fail_free_buffers;
 	} else {
@@ -7839,6 +7856,9 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	/* prevent another thread from changing buffer/sub-buffer sizes */
 	guard(mutex)(&buffer->mutex);
 
+	if (cpu_buffer->nr_pages > rb_static_max_pages())
+		return -E2BIG;
+
 	err = rb_alloc_meta_page(cpu_buffer);
 	if (err)
 		return err;
-- 
2.55.0.860.g4b6b3295ed-goog

