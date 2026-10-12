Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0AB4AAC74
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Oct 2026 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823021; cv=none; b=Pjl3G6xjImOKkREgdR3RORDdeALCFPa2bvZAf42N/kNgcYb88SCG+AIZKQNsSa7p6WJ0lYasOOrQE0cVx2Zn+H2aE3f+j0E2fD/WzfoyxFZN4Mhakv3ckIp5Tzb1Gh5wv6Oy1lXMiUvNxFOyIzGOzoG0Br3YSA3fLogMkArrmsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823021; c=relaxed/simple;
	bh=eLqIJFpZARpTKqSv51MdJJjuy28e6zXE9Kld4KRhU+I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Q/vccVhfy/pcpmVmjehYY5y4ooonqQqV2EDE9mw2sfr9JnfTQXBgitnfwciFlZswRsWZtU+2vt9MwVsugWiYasqcGobZXnwfKpX/WP6rezI+AgKuK0Fx1BhS9CfOKV64utOTeNkUSu77oRNo70MejzmMzDsfxD+nDZL25O19JdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q8So8cdv; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q8So8cdv"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a022fee32fso16013905e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Oct 2026 09:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791823018; x=1792427818; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LS4qpOUX8U+nhwzlLQ4pxh6uIS+fahSDIf6nSelya9k=;
        b=Q8So8cdvA7CRTgtxhdp+obpoHNh+KADwuHapkvDKgcL1BZfzoGQ/JT/ZTEsBWFXGAY
         xtwYfD2hw48LF+jFEJMW3U9CNIIlgqRg8z+Qd3CBihxTlNzWK1UPe48ECf8lU0xhqVMw
         P6jdLyoPs0jzDDP2OwCfqhgLSOFBVWFwpPvFzpPxaDUFIesktgwqyG8O3Y18O3xOzfGu
         n8/sYW/Iv3x+pc6Env76YSU3SDjn8R7uikSqCj1jUwx1pxFS+nBnL+IajoooqOcUtuCe
         SDp7i0JiqkNobYbz7pYCo5LkVPSHHHmuNm+J5uytVRjHtL0Vqxrts/Za1MoUUG+X57E7
         F/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791823018; x=1792427818;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LS4qpOUX8U+nhwzlLQ4pxh6uIS+fahSDIf6nSelya9k=;
        b=HkfHsG58lEDKCJSHK7Nsr9eKlHNhkpLxXc29ZWhRCdefJ/OuGhbfxptNDVuEjMIR6i
         QKVsRCo9/xvLPShin9mF5VU/ca3NHYVuSkFP4fCYGQLLrHjbWggldVWSv2PawpXZFpRq
         l7JHw7W2SV6KQp4iJHBB7glGtxXj3fM/o2L7711AMzO+cJ/Gv23pgwl628ag9aE7iH/b
         k1WxuFehhCBxQwn3e80P6zILhd6ndiM569sSjKZKRqmkheyaqOschMOK/v40u/rkiLVq
         +0mLhz7CX/XdmZkc1lHNl5gIsHmPcdw860CR8/k3PWn+E3Lv42hvWn5NrXrssRBiOT+i
         Q7ow==
X-Forwarded-Encrypted: i=1; AKwUvBx5xPG25TRBlvRQDeLIZDnaBc4S5WSt1+i30EOfuH8HNxnFlnC2n785MF03ey5XllohPGIZPYQEAe/csYSsg1oo100=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqPkwKZ8uTwmKzbhYf2VVxalWDUk7aRhCJF+cx+T7PC8d0Z9RC
	kMCMwoWdcANAUk+7Nw5qpPGCVdAhpBg1Ug8HVe0gFKnRrgCbjNgUARdqrhapUg4dkptvXotYbnO
	2Ujmf7g34Q38X7zCBnZ2nMw==
X-Received: from wmpl34.prod.google.com ([2002:a05:600c:8a2:b0:4a1:811f:6de2])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:810a:b0:4a0:2391:6533 with SMTP id 5b1f17b1804b1-4a18e4a954bmr170650545e9.21.1791823017685;
 Mon, 12 Oct 2026 09:36:57 -0700 (PDT)
Date: Mon, 12 Oct 2026 17:35:02 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261012163502.687061-1-vdonnefort@google.com>
Subject: [PATCH v1] ring-buffer: Skip si_mem_available() for persistent and
 remote buffers
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

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.56.0.385.gd3acb90ef8-goog

