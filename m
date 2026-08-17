Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7503EC80D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974484; cv=none; b=SR5T7KKoRdNA8TY1OA9LbDBGLSVcfskmk/Fq8rW89ZdsNwemkYCXNp193LCXk86W/qJBL0JJjJC49yM3lFrRkg8Jo9KRN+c1CMuFXyCoVgVJcI1m7/FMKlZj4ez1lZ8AzPPBu8mIWa2G1dB1alcsPdhJ0WP577KpAHzUJBe/RxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974484; c=relaxed/simple;
	bh=f6Lr+9f9Id1FwqqsoKdinRQbLiMlAM7iaqh47MI317A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S1JOel1dlpmmv/xpe62RV9hp1HQpgYpJfLhgHBg9fggehp2wiwKA26e4NCF+q75ml3Kvlo9IYCuI/94XldC3gLXESrcBEIRPjmLlvGaM7T+PGB3xZ1A3ptN/E5JdR7hq9SMfgdwR7Fjlw5nrkHita+QtcTcXCjFL7NxcSMxFagI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fizfAiVC; arc=none smtp.client-ip=209.85.218.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fizfAiVC"
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15ddb61f13so278522466b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 06:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786974475; x=1787579275; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h6zl2/Cn6b+sl7JR+88H2OFGEC/2sm5gS6rh+DoXm9M=;
        b=fizfAiVCophJbl9IINHvd0RmCe5Exzba5WY70dXyzGN1UKlD+QvgbRXvAdop8Pvxaw
         KF2UpZT9e97kafuUlgPpfMA+knASS/Yk8N+BbTG7Y1y3kPoqbHAkmizZ/pD/TOC2aKC7
         Z/j7iQVGLziUo/+8PludMjxG9iVUNKPlwzxANyAXNtmHVRxvyZ+AP+FvFkJS97AP5rqV
         WczPoa7DCcU4orB58d+Dx/NCFSr571vGvz5Rx2Nw3vPrUH3xDu5WOTSiqe8KJOUtadgm
         f0lAJTKK+PJQ3GIDzjZVMm2zTz163EDnfVx7t4hWGzz2hzcTEUNyUc57I23sjeGV2dvj
         7ncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974475; x=1787579275;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h6zl2/Cn6b+sl7JR+88H2OFGEC/2sm5gS6rh+DoXm9M=;
        b=JqTrqxQvX80nxdUrjwy7MYGNmlIZ47XrBR62+U728w/Bpy+E4qtcKYsPCpSNGJmtLv
         V/Qm2qzZbOZCgPLshWSUf3oNS4iqol0CB3lIDDJy8gO2AiAY1cfa1FsnBFa/oHX1/Nf8
         HBB9gQmsqGPwRS5Ds5TAjEoPg6HRDAHm6qSgU7m+tD7cmw2mlIFPPeO0w056SqG2P9UC
         SumL8lA9vYPS/2T53G9d7KmG4eVxWmTqz2mJEA5Vna7yGuiGt58v5r3pWNP6FO6Ctw+J
         D5EYFziq90vSTuqq9ZdaaQOj7vjMEBJqNd8QvbvZZ80OVdL7cNy9AGtmfc1oiaFvDjAg
         /qMQ==
X-Forwarded-Encrypted: i=1; AHgh+RpQYtF2I1l41wlsoKmD6UZJhOAliQ1IZm1+o83IzoykeeHT+XSmz+0nSueUCmCAGknrNZFlTPxLESKocP0MGnNOVR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUheTg1mVi7V1qF2zetzz30CMQbF+YwZjornr5qQnWSi9LcNfo
	WVUQ5CmWjCBnoQA5hhxYYxXLRRbp/QrL5+be9Qw0w7en5QfmwTpA0dlo1IKjdx3EhqtrG8jddGs
	5J1n/Ah1FS+MJcIg2/ygzbA==
X-Received: from ejri7.prod.google.com ([2002:a17:906:6987:b0:c21:42a9:d139])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:960d:b0:c21:3fa7:5a6f with SMTP id a640c23a62f3a-c2188ac9511mr3583566b.24.1786974474946;
 Mon, 17 Aug 2026 06:47:54 -0700 (PDT)
Date: Mon, 17 Aug 2026 14:47:49 +0100
In-Reply-To: <20260817134750.3909384-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260817134750.3909384-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260817134750.3909384-3-vdonnefort@google.com>
Subject: [PATCH v7 2/3] ring-buffer: Cap static ring buffer nr_pages
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
index ec13779922ff..5e26eeff588f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -345,7 +345,7 @@ struct buffer_page {
 	local_t		 entries;	/* entries on this page */
 	unsigned long	 real_end;	/* real end of data */
 	unsigned	 order;		/* order of the page */
-	u32		 id:30;		/* ID for external mapping */
+	u32		 id:31;		/* ID for external mapping */
 	u32		 range:1;	/* Mapped via a range */
 	struct buffer_data_page *page;	/* Actual data page */
 };
@@ -652,6 +652,15 @@ static bool rb_is_static(struct ring_buffer_per_cpu *cpu_buffer)
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
@@ -2837,6 +2846,10 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
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
@@ -2869,6 +2882,10 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
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
@@ -7834,6 +7851,9 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	/* prevent another thread from changing buffer/sub-buffer sizes */
 	guard(mutex)(&buffer->mutex);
 
+	if (cpu_buffer->nr_pages > rb_static_max_pages())
+		return -E2BIG;
+
 	err = rb_alloc_meta_page(cpu_buffer);
 	if (err)
 		return err;
-- 
2.55.0.691.gc56d675ccc-goog

