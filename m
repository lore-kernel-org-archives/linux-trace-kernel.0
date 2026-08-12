Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CACB4582CC
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786548826; cv=none; b=J6SWwsRpo1nBYW9gBWPyAYptiM+gKCEev/s1beuEbvAhMrJ74j30E61EX1Tck14+iTvlMWD4ilhHkdLXOfiJgsxaKP7MW7LKWe3QpWHtYeBa1B4LQIlDxFDqqVYRrww/RU6hYvku5wqjWhPOsdslFj2XotwV//A2Hl1FuNTtHAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786548826; c=relaxed/simple;
	bh=s1m9DAmSLCrK4/8z9sVzr3RER4/TQ+xkHgkY6e97XCo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D7qU0GnRKJFhHFVYuRdlQFjuGFZ5BirgVbUf4WS1nsWHLgXC75/t1rEyPkAS5ZoueZ61EaTw1wwhTHXavtsq/35wDNx0BZBoCDzIo2nhpM5zvl9EQGPugNcs0Qlwyxa98FxqT0nX3HRkW1D/6Xlq21qOW4r841zVjPlq8TK0VYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WQbcFuAk; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WQbcFuAk"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-496b6f97676so11581085e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 08:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786548815; x=1787153615; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QI3UvYLuPuA+hRm1RW90Kgyz8hvQU/zqrTzCV3AJA6U=;
        b=WQbcFuAkZ2tEljF+FTSX89F7+qeXeJQvTNUETsLThyajdnNFLEN/fxS4qeN7zJctIM
         cONFApkc2GjrFqGrmvg5cVbJDsgbeCg651VNKjIKbQicNKJtj1s70MoV3W1aYne8LAr1
         Yz3+ZQ2TBPBdAs1xWZetBRpT0iM7IvLLEf0FgMdJ4AcSKU0WrgemcXq2fn64FCAJzSr/
         OhahhtDU0jPo/vXXsSVSg/qNwqTkO3mhn6FYcAjd1xPbCQ9IjcgniO67plR+KYTVOOcF
         sIFQeuRvDnl0AFjWlsHn8ew3x7X4R+7xn0Dg0bflNs0tjlKtqNpg0fazJCLCykB0tmkV
         e5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786548815; x=1787153615;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QI3UvYLuPuA+hRm1RW90Kgyz8hvQU/zqrTzCV3AJA6U=;
        b=W6r4zOQKaYvFNJOsu6/Ykv0wMpoozvak655tCOGSxfsX6ngRKoGRqO4thf3d2fcoTi
         DrRqh1vZWROL3k5ifBBa65iCwi0a3U6ha/43eG45D8AIDNQhBa05uD1qnO6Wjin6fzij
         sLYxGjSUy2IjAOIs7dqRjWe15VAWYlGaQP13YPMEBZylVN/i9ZMTX+FK9MKfYGjgOj8a
         8ScmTy0WZJdxQdKt/utSHGAVSIwRW8B1JiVs0LXRfBtHBhpj0WzfoGuUkxEz9UGHRGpE
         1LgAzXc78XQof81tRi1W445uEGxPEidbAUYaWVrevd5pnx/uYGodojayOGxYjnqGjc/b
         2tSg==
X-Forwarded-Encrypted: i=1; AHgh+RrvLMMjaiJX35VemhbA/e+DYDe+dDUvToq2JvF8zN4JTnLbfYteJIA6Xx82L2Pbw90tGhZ9zjMdimotmAweD6Ynp+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLpT1pxeEz98zKeqzMdZUlFuUhJQn1mi+brPylO0qfNruX+inx
	qEqeWCt5hLpFgF1BlQMXOav03Ag/U3DM+NAorBoFNJFEWNJSlddgIPb1AKGWYthEz0BJXmySdsI
	n5CT166IuBeSAIf+inQZRlw==
X-Received: from wmga21.prod.google.com ([2002:a05:600c:2d55:b0:499:7e24:a8c2])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:628d:b0:499:726c:d658 with SMTP id 5b1f17b1804b1-4997c170c80mr92302515e9.19.1786548814925;
 Wed, 12 Aug 2026 08:33:34 -0700 (PDT)
Date: Wed, 12 Aug 2026 16:33:08 +0100
In-Reply-To: <20260812153311.2328812-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812153311.2328812-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812153311.2328812-8-vdonnefort@google.com>
Subject: [PATCH v4 7/9] ring-buffer: Remove trace_buffer::cpus
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The 'cpus' field in struct trace_buffer became useless in commit
8e7b58c27b3c ("ring-buffer: Just update the subbuffers when changing their
allocation order"). Remove it

Fixes: 8e7b58c27b3c ("ring-buffer: Just update the subbuffers when changing their allocation order")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 64bf4ac853f5..45aa10f0b17e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -572,7 +572,6 @@ struct ring_buffer_per_cpu {
 
 struct trace_buffer {
 	unsigned			flags;
-	int				cpus;
 	atomic_t			record_disabled;
 	atomic_t			resizing;
 	cpumask_var_t			cpumask;
@@ -2796,7 +2795,6 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 	init_irq_work(&buffer->irq_work.work, rb_wake_up_waiters);
 	init_waitqueue_head(&buffer->irq_work.waiters);
 
-	buffer->cpus = nr_cpu_ids;
 
 	bsize = sizeof(void *) * nr_cpu_ids;
 	buffer->buffers = kzalloc(ALIGN(bsize, cache_line_size()),
-- 
2.55.0.691.gc56d675ccc-goog

