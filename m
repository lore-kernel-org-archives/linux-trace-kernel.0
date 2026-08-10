Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7973DB655
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366635; cv=none; b=WBpd5zqTeK86zvHcug0oWGOuJPc42RUwJf9OWa4ktZ8Fnv0nFzZvukuhtNHASnNDt71tdgSEwkXP4hsTmDOxLknDdnuEM7zIZH2wegrAgXiOc5JqvsSU7F2MvXHfkaM5PaNJ9zdG+GfdNAdtd8EdziFZgn+h10+Z9S0KH/FEakM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366635; c=relaxed/simple;
	bh=jRx7FUxQCaRzyA6Q6NNBtT1C/3AjpZAuS49buYtI2Vc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sWfrofspadwpHWoJUeUCGLJ/RzoIvpIpbZNeRweLac4Vh97KW9AWf2mLoJ336r1DGvXPGh9YdIyLMN62QtdiQkq2xDkBCIiw4+GP6ZVYiKpslzEo8XOYGTftnGYnpwcEJUrWT2mGK3ccIfetsNiSz7nBvleUwULlAVMVryy8DLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SqTM5Z2v; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SqTM5Z2v"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495569acf8dso11307005e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 05:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786366632; x=1786971432; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AGN3xBFNrfMXyZfTcIj6JyUQyIsdFi2od4FC/Au3R/I=;
        b=SqTM5Z2vMPedJzzngk8CRjU7CKTiag/7tKoxvlcc8kRjy7xu0BwXpBALnInUnAOP0S
         qZ44s8nrA9aye8llc5NWNSUM4yvEA3sj8VNr5QxUrOOyINFogH5xJroYR8rVXqL1jmmh
         fe0wnvYFGOtq/UhtNp0e0//qB/H2x6kpmeABkBBun8cAaDA5aQHnVHho3JQ1CiTPMNBC
         dMPCt9bBMNzqEtyMQrGfubkYLV0XKUi6HWfI3dvAy33E57xrBvZU8RfChqK5Opa6522c
         GxMm1nZ00nhOoLLMo2UVhBW1l11YDF0YiUhx3ESpbr2Ny5EHdab3LtQo7jga8U7k9sDm
         x1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786366632; x=1786971432;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AGN3xBFNrfMXyZfTcIj6JyUQyIsdFi2od4FC/Au3R/I=;
        b=RdZioCygjTyshqXSPd6iS+M+q4BCfas9jTMLt/k5hqiUvbRAMLzHSm6euY1WPy2ygB
         7jQr39eDpVD/KjRtVFlOgmAk4rCQiRHE7EgB2t4zauGcQM/+ZNwDYaHRjlREwl6pk1nj
         uQyMI1dbBQRD6e88JEfyeoiWCT6No8jJFX1w6DhHDIc2lZcmSuIv5v8L9W0FFNsKwjRo
         bYpNFS2MhibLB09zH6aIE0AO0IOY4HzaZ9FJf1a4Wr3FKkamF186FzDl/vmk+AgZem2h
         9m/hGStosOQhRkLTBUe8W8zWehH6xmSNVPlcwk9l6JSvZBU0RBZ9fJy8bn2g1hP5IC8P
         yYKQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp1bNjW7jYbfF8Jh+2NpkHdL4UXbIhoym4X1vc+gF91dfsC6FYTNbgq+P34a2OVudPwA+kRhCQozMsvTZJf4eBe7YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzElVLGifu96Y+aJFqH27GH5GCXDuWD7GGWMhoj2dGb/4oyZj0A
	bQ07e8/JtkFumS3eL+P2cQwnWtFiyUgluoh+3/gE0KGamRybW3WZUqGMqIopidFJOFwEjfzETRc
	FKdyRb7LRDupQJ+e8HwXtew==
X-Received: from wmg18.prod.google.com ([2002:a05:600c:22d2:b0:493:e006:3161])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:474a:b0:496:c361:fb96 with SMTP id 5b1f17b1804b1-4994e6db5aemr508989395e9.0.1786366631742;
 Mon, 10 Aug 2026 05:57:11 -0700 (PDT)
Date: Mon, 10 Aug 2026 13:56:31 +0100
In-Reply-To: <20260810125633.3344684-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810125633.3344684-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260810125633.3344684-5-vdonnefort@google.com>
Subject: [PATCH 4/6] ring-buffer: Remove trace_buffer::cpus
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
index ac5f5d9502dd..d128bda5b661 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -566,7 +566,6 @@ struct ring_buffer_per_cpu {
 
 struct trace_buffer {
 	unsigned			flags;
-	int				cpus;
 	atomic_t			record_disabled;
 	atomic_t			resizing;
 	cpumask_var_t			cpumask;
@@ -2762,7 +2761,6 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 	init_irq_work(&buffer->irq_work.work, rb_wake_up_waiters);
 	init_waitqueue_head(&buffer->irq_work.waiters);
 
-	buffer->cpus = nr_cpu_ids;
 
 	bsize = sizeof(void *) * nr_cpu_ids;
 	buffer->buffers = kzalloc(ALIGN(bsize, cache_line_size()),
-- 
2.55.0.654.g21b8a5bc05-goog

