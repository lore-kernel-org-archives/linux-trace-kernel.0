Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E7547A88B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392917; cv=none; b=Rfz7qMNbSGWMzzRn3FGRXIT/PbApnA8Jr+mGLZ/8Y7SLBVRCOGuV3t3cpgTjX4QOSHtFC1Mj5xkAhl6XPkuNZgAXtRYIAars7188DB68ooIJCGJaNCirphO/2wJ9T6BhFGO1OnDlUhJBoiC06FtZAmJkddg6EIIokaqna7ykUCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392917; c=relaxed/simple;
	bh=rob29vuMJiM6unglL8riKgmWKOv8j0OKpd04pbbohkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chshS3JfRkzzD7f/Wefg1OU0LhmyN+6S0E4C7rll0UMwfoq4L+xMmZZZmMSeV9j2SPCPzSSEbGVC+nc0QUqhFp9Ihino1SlSe1+2dJAEZn9uIyQdq+YCUl99D65VIBE/ow78KSHj+hPXiEyfugVB6LNAx+WNigKxHN12hihU1So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZAT7/a3; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZAT7/a3"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c29667ed561so405162766b.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 06:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789392912; x=1789997712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7u5qVr4y53yodZo8gWGizbwm6BRp6jZIIKbBtggqr88=;
        b=kZAT7/a3mbujJosWxfKTCqT05ZSrRD39fxUF+69ap/lY2cHDGuhz90ofIQJUrYehE0
         +Xe90th42rikLASkxM7qCuidIGtuzIf2CR0jy1x5UM5SEq912DiWgw45ml2Cv1AgYkQj
         yUl9PznwmGvwu7RkgeE5ObJweqps9tZ66u0kj7TCsfs9mjB8Rlj1UFU2FX67+cg+cIFc
         +ehIitYjJcyFcvDy+tgUPuqZPsBXWOt6/lBKp6vt2yCIQOpAHYBS4QcQrW33xk60f5/l
         6DZSHwMqRcMN9jGrHrT3AioIuexDBhok7pbeCcjf5HVbmkGyhTzp7rBhOtjyHMH/aWz9
         2Vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789392912; x=1789997712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7u5qVr4y53yodZo8gWGizbwm6BRp6jZIIKbBtggqr88=;
        b=bK/83okAaOCYhwKoYz7lMj7CW8EysVAK5y1tBmvR9ti/eoRybsgT2jgsNTs/qol6fN
         Zwyvsl+sf4USh/dR0tgXLZd/M+XVdMyR7mHo1yVJyLoUgyew5Zf8TA7wgAgzc0ZCx09z
         h2LlKqiD6f22roV9yKdgOcxpUZz73TAw0BDZNzOV8xA17acFE4lfbs1lPg4+1Fyy/Wki
         GHs3fw5yfLFdhIyvjej9ZhjSHerJbP8GccexyaruKVhq/Yeptc1byu70VKXx4KUBpO9Z
         KGlWYN3i1Yx1bNYd98QHN2R0RUR34UH3lUcRHwevPy0L0IlcoOyULnzXhQnyUhBxmot8
         6gyA==
X-Forwarded-Encrypted: i=1; AKwUvBzi9i1RMjzJJhMY2w94JCzCqiUPnm1j6wUVAGXlPwkwr+wMgSVaIF4/h5ie9Sgj+EyEAhRNAIY/IGflotnvt1EnIRk=@vger.kernel.org
X-Gm-Message-State: AFuF++nEXIA7ZjBxd3yvQQ3aCAcej4iEw4OA/RZAMuwmLHjAH7KE9QHj
	1CwqPkl30l/DijTXiB81xWLoL/80mCZMsd9gad90N6PWrn2irKOSBvpu
X-Gm-Gg: AYBFou2/zJxeGOrZC48FJp4iQNthduJpBsjh3ilonayMZhQ8Z3n6NzMZ4ZsTJUpPXiF
	Vr7fnRLTz2ZQrBvSfaRSHVg9t1nrADvUJBLUS7NMuLsYz8cCxiQ1/J7jkS2Z9EcDtVIShkgGJgp
	Nd/YBd0k62bV3RaGfdH8ewiBtrikGFG1DfaEQpqX3R9JpxPagfxdYNvlC6OA8uApVn+z9+7Zbl6
	AQ07eMQO9WwOSOJDJQwLZFI6qT1kaZRVjGFhU+q0d6Bf8qINAFiqlkdI+XW2J8fcevoszPqUM52
	aywJT7OHzVph0gXWVp7jFWApfwQ3mrobAK9fDXaIUXf2ipOZF/8NS3gNlQG4cHEQO+RsfdEKYWY
	SMRm18g7lBW3khjG3lIKpv2m9dEU3kWlwmf1sGiFHJW6ai90HQEZbSSqBxBK0K4c+70c6L1zzzJ
	IIN1r0MtyPK2tASaw2L3vQbh7IGYs3Zw301GB62iNpk2UZvNhyBEpkADX5SA2NFBke9RrygIim3
	7bm5gZCvimvYNtl3W2S4sWJ657+dWGEziNe8sCiFvX8AAnJ1EJJIFbhc8U=
X-Received: by 2002:a17:907:1c2a:b0:c26:2fc8:4e91 with SMTP id a640c23a62f3a-c29b87055ffmr157187366b.29.1789392911608;
        Mon, 14 Sep 2026 06:35:11 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2966159c07sm441454566b.63.2026.09.14.06.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:35:11 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 2/2] ring-buffer: Do not show buffer_meta for CPUs without a buffer
Date: Mon, 14 Sep 2026 14:35:05 +0100
Message-ID: <20260914133506.4865-3-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914133506.4865-1-devnexen@gmail.com>
References: <20260914133506.4865-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The per_cpu/cpuN/buffer_meta files are created for every possible CPU,
but buffer->buffers[cpu] is only allocated once that CPU comes online.
Reading the file of a CPU that never came online dereferences a NULL
cpu_buffer in rbm_start().

Fail the open with -ENODEV when the CPU has no buffer, as the other
per CPU ring buffer interfaces do.

Cc: stable@vger.kernel.org
Fixes: 950032ffcee7 ("ring-buffer: Add output of ring buffer meta page")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260913134906.6E8A01F000FF@smtp.kernel.org/
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/ring_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9c03a555a6ba..8833d04b9fee 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2381,6 +2381,9 @@ int ring_buffer_meta_seq_init(struct file *file, struct trace_buffer *buffer, in
 	struct seq_file *m;
 	int ret;
 
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+		return -ENODEV;
+
 	ret = seq_open(file, &rb_meta_seq_ops);
 	if (ret)
 		return ret;
-- 
2.55.0

