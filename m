Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629785C911
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008085; cv=none; b=ZkGaAv/4l2VcSeIww5D2xCVM8Jgf7+iG1kyp4VjzIYFgaczdoh7GUYMQp9LJkfp/TqdMn20JJwbXTI2h7zBXD5NQggr9o8a3Qr/pcmUYmYE84sfu0ARWFD7z9ib+urBPXQDS+6o/51aVo3uECrhvccBT5x6J5QR4Zot1TUFTt0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008085; c=relaxed/simple;
	bh=OvEEBWdcH3OKo6KDL1Af3FAQxWgGr/9147Iu28ODlPQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W3s9Q4FZGOPu11SnqgY0gyJTQy8d+S2BjxRYv3AEmSElqgTT64nUXxBLJCIYxhjuHXcbh88YfagGvmnsrshNcYP/qdAKK0qEs1TZBKJQsBG6NL3WxUWFiso7HKt6ADDtmZ46DSq13slIooogDi/hqz9HArGeZeS7MVSoDCEXXyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LlxyUMXp; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LlxyUMXp"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ffc7ce3343so34274467b3.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706008083; x=1706612883; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GTPmymlTxKhC1ZOw6521BjIEJCf876w90abWnygi6LA=;
        b=LlxyUMXpJBV3weDVRUHO7AXYO5YGYFA3Cw7Y2otFwa11ZNhurhFUq/RToCG050OWi5
         8Bku70Yy4k9DXTh5i3GIszH8PZaJgQm0teIVTVNu+CB6Jikyhq+ZfM1APqn0xT999UH+
         W8UW1CPIsZ+8yic7UvgQPDAJjXMFMsY1wA/wXcOT9E9xmyQGfDfCwyEXh++hT7Ucbiwk
         PiIertEywXOLd4cAFWA3bRhk+iWw99m+HM9JTydC838o88fRcSD+qv4P57T2mna1Dq2Y
         QhLguAydIYRmo/MhR+blY0mClbHHozAK22yOk6Dy+Ru3iCiE3akb5Kz6I1pMiT8Ffp6a
         l5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706008083; x=1706612883;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTPmymlTxKhC1ZOw6521BjIEJCf876w90abWnygi6LA=;
        b=F8zmW9wN3Cf596nBJIaAkysDFtTKteI2HeDB+yulsczG6w9r9E801c+4EHKsJpyDUt
         1628QfFwHXwydjS2w2noAbOadjpL141Bd27+/SHw8WfhQGNexqltSdVoY6WvYQ+AF6cx
         aq7pGvS1DFnk7MP8DaCqEtlXnnSmEnH7uUgQZMg19bHxffYnmvZU2cVzdyz6AYsEw6pv
         z1rbToLs4Nx9QVJ3yLH9brwJFXPaNeLvnsFYp+JBPBH2TEpW8CMPlQr1UHIm+fnK7YLc
         Htkv4EpZ05csLx6hmYCtMD/D1JrT0OoFphJM7w2aUGu9yxOVrnIgSTZCcpWnTvcEud+P
         hudg==
X-Gm-Message-State: AOJu0Yw5h/imuRPfD7XyCgLdZEMMFnz9Nk4UuN8hVEbQiyNDEA5WndrC
	6xu4ynewQm1em/NPEpnQ1SNogblY0Gguz6qzY+4Zxv4vwUQPQpFp499jWpq8ZgBaibkLHsa6G2J
	4ijzv0Ze4/8sJSugWuA==
X-Google-Smtp-Source: AGHT+IFntKP4XZZ43QuR+umsJroitll4qvgERUZmB0oEZ8AsB1XTKr3l5rGp56Z7TXjvTNRwaYCbKG38H3a/DY06
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:690c:24d:b0:5ff:b6cc:10e with SMTP
 id ba13-20020a05690c024d00b005ffb6cc010emr1505537ywb.10.1706008083460; Tue,
 23 Jan 2024 03:08:03 -0800 (PST)
Date: Tue, 23 Jan 2024 11:07:52 +0000
In-Reply-To: <20240123110757.3657908-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240123110757.3657908-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240123110757.3657908-2-vdonnefort@google.com>
Subject: [PATCH v12 1/6] ring-buffer: Zero ring-buffer sub-buffers
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for the ring-buffer memory mapping where each subbuf will
be accessible to user-space, zero all the page allocations.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 173d2595ce2d..db73e326fa04 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1466,7 +1466,8 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 
 		list_add(&bpage->list, pages);
 
-		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu), mflags,
+		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu),
+					mflags | __GFP_ZERO,
 					cpu_buffer->buffer->subbuf_order);
 		if (!page)
 			goto free_pages;
@@ -1551,7 +1552,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 
 	cpu_buffer->reader_page = bpage;
 
-	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, cpu_buffer->buffer->subbuf_order);
+	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_ZERO,
+				cpu_buffer->buffer->subbuf_order);
 	if (!page)
 		goto fail_free_reader;
 	bpage->page = page_address(page);
@@ -5525,7 +5527,8 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	if (bpage->data)
 		goto out;
 
-	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_NORETRY,
+	page = alloc_pages_node(cpu_to_node(cpu),
+				GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO,
 				cpu_buffer->buffer->subbuf_order);
 	if (!page) {
 		kfree(bpage);
-- 
2.43.0.429.g432eaa2c6b-goog

