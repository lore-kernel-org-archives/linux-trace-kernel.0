Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279D147044E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791886944; cv=none; b=JdYAdN6BkGAzFc2iRzOHD9D5GgEDPz6NoCuqjlft0ggHpcej/LXgLhS5vW7rfczDsk532VEdIwNBEwJywbrq0DBWSuCzu70Ru2dBrIzhgU138NhYFIjIbMmJQHpws9EukUsSyqtWJPVvcgu4/ImWm6GIutz91DPDpLe4Gvkxyiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791886944; c=relaxed/simple;
	bh=olhicpvOt14Nwc9o3SDhOxXeZRP16sKOC6IWuYk3las=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ib/Zd6wfpCrDqMQMnppEIjckJ2prdKfrI00ClTwdfxfXeEqSptKUD2ddJFw8M8IkOtoJ2Zw55Fz8vtI+9AbFHEBMLDKwR8kuI7UU9YW5tStSvhgbXen7dxFi65XEHVjp90N8Dm8XwQPj3nSkyRyoRh6VQzAx7Ib6QVX1nlYUw4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MeXPUslX; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MeXPUslX"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a022fee32fso21357845e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 03:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791886941; x=1792491741; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g4SCQI9o/8u3FMtDiIAJd5OIu+HNWJlgmVcS6U+8r+o=;
        b=MeXPUslXWZR1Z2FfFC9oPx53wWOpIs2iHtTKN3qec8NQc49efnGF5/WWYu3orinMIC
         nVpNaRxyVFCtnpJT4UK/Vd/sYkGKQibOmcyXsYqpxOKDhENP9mh0tUunlKVfmxWXmNgL
         05WBmSxsFUX0CBQLswOYSLRfMiRmS9nW8gHAOp1IvwIkWhfA9ktUiByhYAP0waiB58m3
         npvwVCjgAZxsWCciRMRTyt26puNflVeO39WyczGdX6RJyOEr5k+5/2rwypp6AmYdHv1q
         H5tsDZIubNO4Xgphc2GUo9DxtZlfuw/NsL608SP3jvTcvKsNnb//ZXvZl5d8JijxBSDt
         9IeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791886941; x=1792491741;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g4SCQI9o/8u3FMtDiIAJd5OIu+HNWJlgmVcS6U+8r+o=;
        b=x/c+VDhBcoI7VgSL7VFCDXs4JxwMLcw7U1F47JT+OqKP2BsJCbIoNjycx5Lmsaxa67
         0BDski2GZwxhICfO1GvqoDuz9GPCg99Y2doAlPhIpdvNMVBVY+5WmW2Ly8D62Vvfftsl
         V1KLzVtqVWTI+GkOYUsdwzt3k9AobEYWN9fW/k0roUaJt+w1/Lta3GDdx6OdBEw1tXQ+
         JC6WZDcNNYxd7DRmRA+Im+Qdkz54GpMJlU7+i3SQpBaNMjgLqX9d0Qc79We0ljJwTwpK
         s3Sc3u7v6EUNFsRHoH8iq/m63bJxLakqNwpemLE4CfuYeoDtkok8XmvkmNYAopC/O+sa
         PFvA==
X-Forwarded-Encrypted: i=1; AKwUvBxzkBITvfH4kYPavJka29aBCsvL6m92T1F7hg+YtzR8Lld5GVL+JXiZFHmKE83NqirUXCoW3/nhBHQQSqUKRtwaVNs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJeExpgabbS4J6i/v+ZEDgGo6BCr5AoxSJ/CB/jwRkGH6PTozhV
	9KrAeOu59yy2dvNKMXK1bypcwoAs4MsedAZH59mb+3TS8LrtZVJS/fIjRNlAZIxETGnu1xZcQeZ
	BekcMCNn4bnLqKqGBkguMCg==
X-Received: from wmcq10.prod.google.com ([2002:a05:600c:c10a:b0:4a1:7474:5804])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c113:b0:4a1:985b:83a9 with SMTP id 5b1f17b1804b1-4a1985b87f5mr114052965e9.4.1791886941328;
 Tue, 13 Oct 2026 03:22:21 -0700 (PDT)
Date: Tue, 13 Oct 2026 11:20:46 +0100
In-Reply-To: <20261013102047.1488347-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013102047.1488347-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013102047.1488347-2-vdonnefort@google.com>
Subject: [PATCH v2 1/2] ring-buffer: Skip si_mem_available() for persistent
 and remote buffers
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Persistent and remote buffer memory is pre-allocated by the time
__rb_allocate_pages() is called. Skip si_mem_available() to avoid
wrongly failing the allocation under memory pressure.

For the same reason, unset user_thread.

Fixes: be68d63a139b ("ring-buffer: Add ring_buffer_alloc_range()")
Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 41 +++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 04bb94c29f58..b3a30a0413a5 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2442,20 +2442,30 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 	struct trace_buffer *buffer = cpu_buffer->buffer;
 	struct ring_buffer_cpu_meta *meta = NULL;
 	struct buffer_page *bpage, *tmp;
-	bool user_thread = current->mm != NULL;
 	struct ring_buffer_desc *desc = NULL;
+	bool user_thread = false;
 	long i;
 
-	/*
-	 * Check if the available memory is there first.
-	 * Note, si_mem_available() only gives us a rough estimate of available
-	 * memory. It may not be accurate. But we don't care, we just want
-	 * to prevent doing any allocation when it is obvious that it is
-	 * not going to succeed.
-	 */
-	i = si_mem_available();
-	if (i < nr_pages)
-		return -ENOMEM;
+	if (buffer->range_addr_start) {
+		meta = rb_range_meta(buffer, nr_pages, cpu_buffer->cpu);
+	} else if (buffer->remote) {
+		desc = ring_buffer_desc(buffer->remote->desc, cpu_buffer->cpu);
+		if (!desc || WARN_ON(desc->nr_page_va != (nr_pages + 1)))
+			return -EINVAL;
+	} else {
+		/*
+		 * Check if the available memory is there first.
+		 * Note, si_mem_available() only gives us a rough estimate of available
+		 * memory. It may not be accurate. But we don't care, we just want
+		 * to prevent doing any allocation when it is obvious that it is
+		 * not going to succeed.
+		 */
+		i = si_mem_available();
+		if (i < nr_pages)
+			return -ENOMEM;
+
+		user_thread = current->mm != NULL;
+	}
 
 	/*
 	 * If a user thread allocates too much, and si_mem_available()
@@ -2469,15 +2479,6 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 	if (user_thread)
 		set_current_oom_origin();
 
-	if (buffer->range_addr_start)
-		meta = rb_range_meta(buffer, nr_pages, cpu_buffer->cpu);
-
-	if (buffer->remote) {
-		desc = ring_buffer_desc(buffer->remote->desc, cpu_buffer->cpu);
-		if (!desc || WARN_ON(desc->nr_page_va != (nr_pages + 1)))
-			return -EINVAL;
-	}
-
 	for (i = 0; i < nr_pages; i++) {
 
 		bpage = alloc_cpu_page(cpu_buffer->cpu);
-- 
2.56.0.385.gd3acb90ef8-goog

