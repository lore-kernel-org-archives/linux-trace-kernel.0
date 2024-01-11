Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD754F8BC
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K0lnm9+/"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-40e5980dfdfso11769375e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704989842; x=1705594642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=urOae5rhFO+lmkwawv/vVpYhVX+PQ6+XyZK8aXYOwuU=;
        b=K0lnm9+/Oin3Bl9s7WIjjMeZoohAvkHXeGcXPjXRRpLtmbSdpKMlCPUIrdLen9q1tx
         Xok7zLWfWGECmITMmsZlH2RWJU4phaXF/mXq+sni2IqMbNUwpF8y0glmojJ0a39PMyjo
         X+Zja6GZVrRdxVF2mvB7l1rzdR4ESOjt0+gC4vGq5MeCl6BMTAOEn2nVmOyLQWllmOQ7
         /Z+N2snbfFtgqwanuC0akjvAI2Y1kKI7cLAfTXgCWZyuCXTJIQag+XVUHQqqUphjG1Dv
         msliKn0Zsth/LnMX+yD/AwpocbbOjY98yixE+nVnZy5gkkPEKuMt1fsCaQ/r2jUhpFVx
         rMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704989842; x=1705594642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=urOae5rhFO+lmkwawv/vVpYhVX+PQ6+XyZK8aXYOwuU=;
        b=UjAvt/21jkySrcoA/5ds+PT6vAsk6natrvh33++kAv/I4UMD0UueWjom39ReEvwjCQ
         kR4aFfXWIycAtrSEqEJD/cvTIMeOOCTHo0a5A4zr6JAN/u11WKc/4yzSrosQUJVKD6RS
         AC+fWTTb4zfwBaJSlTqpakIaNOOFxdM9AZIkotB745pN1BMVQICLJrtkIpEOcf2noP2X
         vVHkudrIkED/iIoa8su695WqxY4vznPVsJGb9spNa3jCi37wwGvQus90NrZKT//jzJ0A
         MvAaQUj4qcNTP+1gOJowMCrXSFZVYM3bS/0NeVtafE6q03pKu9GuabKNjkoZaNDbdjE5
         5SoA==
X-Gm-Message-State: AOJu0YzmIvtSv6CyTtctxt3Vzan99hirZXh1ifqA1M2yYu5N/24ta8td
	M72awFjdRrs5Dlkn27WdDz9KqQTzWNJFz3TXjLO9Avw=
X-Google-Smtp-Source: AGHT+IF8MR6r7u8iVUmbLI+HZyZdBccm+AfUiHjUHEq6uy/4UgamnrMeV91I6Wy9kPk+wBVGPHmAI0cvbRiu9ePG
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:3b0c:b0:40d:5e86:fe9e with
 SMTP id m12-20020a05600c3b0c00b0040d5e86fe9emr173wms.5.1704989841944; Thu, 11
 Jan 2024 08:17:21 -0800 (PST)
Date: Thu, 11 Jan 2024 16:17:08 +0000
In-Reply-To: <20240111161712.1480333-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240111161712.1480333-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240111161712.1480333-2-vdonnefort@google.com>
Subject: [PATCH v11 1/5] ring-buffer: Zero ring-buffer sub-buffers
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for the ring-buffer memory mapping where each subbuf will
be accessible to user-space, zero all the page allocations.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

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
2.43.0.275.g3460e3d667-goog

