Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA2F28DD1
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Feb 2024 16:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150862; cv=none; b=dWtZDhoN+BYS3oLNvEFJ2jVyCO6Y6q6Bzx0i2Xqzp2vpk7BuwIwsq6C6QbER1PZFQusl1fi/r+RRUxLKOald1aOuyYe9R/q/ZeESatAY74JDMel0GAxeHYquhZWY4jbvi6g/1LsGMsjQUUKG3bw4+eE6SS4/6Ri5+egM0YOISKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150862; c=relaxed/simple;
	bh=1fJD7FqdEtsCCOZb17HnRU5d9h5a6C+oEF9lp8cXViE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ubji0zUnDcd7oVERpJGIUYzKrYhWOkC6mGjKVWdJvZWWXl48+ErceMrtu88+//KywoWsvJcxIs2J6sBS2hQGGke3fDl29OXXIetWY1fu4YLedcQlhgJGLfhwM+ogyfOlLsaVBkAlxiqnmA29VEwM4FoL2roLFLnrerYd8yB+o8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GkW9fd/V; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GkW9fd/V"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso6459451276.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 Feb 2024 08:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707150859; x=1707755659; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=80zEqO4cAfaVKiES2NvcSNlY10tKCHIehQe+RxguKbw=;
        b=GkW9fd/V6hxg852IQfJ1wDYoyBYECO+DM/8+k70qEs8E1EDe4c3kVTFiaC+V7IMFq8
         h2IuN9gW1WJFKSpRBnX8b8Yd+pHqgO5XexOjsSuh6F0xr5IsQ3MguKBY9bkN9ypI73pm
         NBsCv8TWZqeJlN/oFhByC4aDI3y/4JbYK64PJbDuJPtHOzFU+ksWbx0ty2g1BnfUSGDm
         /cUK9TQNaLvVquo4Vfot2X085loqKBMLYNXfztmGmoY7rgO0lh13t5GQl1bjyJaUVB/A
         58BNYWxswdfWtsf30cWNk3e+CCjGw8onB8TLJ8DDaMIpu70fmT8Jofab0dGp1M31BbjI
         L2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707150859; x=1707755659;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=80zEqO4cAfaVKiES2NvcSNlY10tKCHIehQe+RxguKbw=;
        b=whTl5x7p88FG0h+fuwU5j26UN0UGm4rMSyVpOmRuwvZC5YsZGNkuvQkCdzR0x2bOKL
         TFRYTu3lg2ZQCpaS8zi+APq8sU82gO0YVNlKzMUnINroHwmFW3ApriOFwznnAtzv7s6x
         Ld6yR60xetZ0EAuHBhALVW+hmYEMDAPED0d2o4/pfIvcEySTdKIU7zT+p1EHTc6sThKQ
         PNOuHrU8kBQfCYbrsE8RzATJbQeBH2LTZDXsfD87RneIFZq5tIs+eY83+LfIsmq2SBpq
         yfqDe2ZNYk8vBZ3IpQz/oYoVJH/6CilOjVUMAOD7ASQd38vK09UkGatkP6wxoz80OvxM
         Is9w==
X-Gm-Message-State: AOJu0YzTxO8hwEqI7mtgZpXTeSZddXikyE47hMkl+jmBbwY6V0ZeJJF0
	VkDYbbBCfBK/VGbt4nZM7li8vSpE9QKwJLVecGpNWK6FR8U5XKWtRxz5pQofJiymw+QGC6N64TJ
	BYZsnFhdOYOttQHAjaQ==
X-Google-Smtp-Source: AGHT+IHxE+8iCcFK7aHEZWuYfa6eWltyxtzL9XgJYNz1cjl55sIQzgd1NgUgozX6hmBIwZDfhzkuWF3fJ2byZkWV
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6902:138f:b0:dc6:dd74:de68 with
 SMTP id x15-20020a056902138f00b00dc6dd74de68mr457659ybu.12.1707150859536;
 Mon, 05 Feb 2024 08:34:19 -0800 (PST)
Date: Mon,  5 Feb 2024 16:34:05 +0000
In-Reply-To: <20240205163410.2296552-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205163410.2296552-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240205163410.2296552-2-vdonnefort@google.com>
Subject: [PATCH v14 1/6] ring-buffer: Zero ring-buffer sub-buffers
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
index fd4bfe3ecf01..ca796675c0a1 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1472,7 +1472,8 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 
 		list_add(&bpage->list, pages);
 
-		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu), mflags,
+		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu),
+					mflags | __GFP_ZERO,
 					cpu_buffer->buffer->subbuf_order);
 		if (!page)
 			goto free_pages;
@@ -1557,7 +1558,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 
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
2.43.0.594.gd9cf4e227d-goog

