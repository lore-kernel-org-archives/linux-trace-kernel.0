Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499883769E7
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165637; cv=none; b=YQQq6uBCJ1C1QJVfWGz3htes8vMwRmJz4egZeYQuttgmDO+Mz4sptTPaQuc70xU44eYFCKcf6zACN4nuXLg/edyQrbP/Xhp+u6Vzeva2ioZrUMTwDNHJknVMzjHNR+DV249/girGy5e33xriKw5xNN1V9DwHeIm1FPrCMndcQUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165637; c=relaxed/simple;
	bh=m/WWeFMJCrVGffwdMiKasd9xCWFIQH8QaNE4CBT7ZC0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Rlbl8if9iom1R8U2+6HKceaYNSO4h/Wbf758QEBTh8AMXDAyqAuqQcl4nAdTAfhTspwXFqIEMoO47sg0VvXQVmVd1pgbTg0+JydI6it7kK7FKAnF0++v9QwQ5XJTGltjhvf7iz3Xx6owc/9mScWUUtMc9ix0sBR3SEzh0c2+JvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ekhd9zlw; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ekhd9zlw"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1721559b4so941125e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 08:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792165632; x=1792770432; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tELJHcWYoIhgNUw8lDudD6kd7E8RuUtrVQulu2IZ7CY=;
        b=ekhd9zlwWXDP/sKPZ9kOhG5L93ZNzR27Elucsp90KDH7YIWX2pm9VdJUBLkrKigHTy
         kibM/RZHo5MdPAqnMZDinZAd24+i/5cWRjyZPSuyTvCLVUUEHgLo73EzUMHvSWdEEiBY
         BnKQVMCskjjJFvZ49uLVTVzzBjGD78KgTD49EzHOcE0tPORwruwg5eZRvZaYkUIj/vXL
         S4mR6lFoGssh+d/dz/eJapK0NEbJcnmHORlSlq3EuLR1UuXFsNxOOfZLBClVLmmmbviO
         fQNJhk7tpBSgCKFQ3/o2h9png0Aafm6S4oUa5EEKsHkHPNPBZjNPWyEOaChKRqCr4xAy
         4GfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792165632; x=1792770432;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tELJHcWYoIhgNUw8lDudD6kd7E8RuUtrVQulu2IZ7CY=;
        b=2UEy0hqOajXCxPv8Y7K4IGwXA2kU+mdXTziYynsE9pDcNIkSBPDK1ZUQrE2TkuSdSk
         z18x79SULMZDa2c+xpZqOEK0yluweKO4M7AL1LEkgm8gCvzhJHChskYuu4sNmiG4DGZ1
         aj4cVkqJwyQD1h+95chBUOtItEZmtncfXG9jweCHN+qfX/0mkbqijZMS1CN8L3FzmKuS
         +6XjkH1S4auFHvnA8DNMSWVA2i2Kf1x23FL/gEtPNHQRVrYWdky58l3+8IJbYV1uWI97
         9iC+HaoOv0FMri6UWyCb6mvRECnHTRU70DGXmPRgcQ1K03JLoNls2oXYxUc2WoOsQgiG
         6yiA==
X-Forwarded-Encrypted: i=1; AKwUvByRfRIAhmQ7k1Y08O9V4IFzY1GbOT+UBOFgqLQPpK+u7nlJixDAeJoj6JBZYuR0RTOuoST51dqyaz12389/LWBT0VY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTNTutbX7Mus8bfSHqyLMb1K/1ffkjaZz+4ThTyID/sU3qLJBR
	eTBVXBuS8P233UWT7NdR4lAROrNJMtUJoLY745Uc3vy2GPk+WlcBYSOZjU/2DqWxo/39LDztazf
	r4rSl8/PO3/Iyxh3naxTp7A==
X-Received: from wmee11.prod.google.com ([2002:a05:600c:218b:b0:4a1:950e:148b])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d10:b0:4a1:6992:f861 with SMTP id 5b1f17b1804b1-4a1d75ce2e7mr5304445e9.1.1792165632352;
 Fri, 16 Oct 2026 08:47:12 -0700 (PDT)
Date: Fri, 16 Oct 2026 16:47:07 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261016154707.2125747-1-vdonnefort@google.com>
Subject: [PATCH v1] ring-buffer: Use is_user_task() in __rb_allocate_pages()
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Before allocating ring buffer pages, __rb_allocate_pages() checks the
available memory with si_mem_available(). This is however only a rough
estimate and may report memory that can't be used for this allocation.
In the event of an OOM, we don't want to penalise another task with the
OOM killer, so the allocating thread is marked as the OOM origin when it
is a user task.

Checking current->mm is however not sufficient to distinguish user from
kernel tasks. Instead, use is_user_task().

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9c4e40847e43..bcc28d50c634 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2468,7 +2468,7 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 		if (i < (nr_pages << subbuf_order))
 			return -ENOMEM;
 
-		user_thread = current->mm != NULL;
+		user_thread = is_user_task(current);
 	}
 
 	/*

base-commit: c47a7b11bcb3d45e29723afcf6336866476b1d08
-- 
2.56.0.176.g3575e65682-goog

