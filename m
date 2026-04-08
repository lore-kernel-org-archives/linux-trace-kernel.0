Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1958B3624B0
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Apr 2026 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673371; cv=none; b=C/HLouHnWk10/XlbUpm+W4byWXuMLsBBWlI1hgZV2QRFv+LiaBdRd1+PtzOdAk9C6AXUFyWydRqzJAi6/ooBCIXvNDed720Dhg9VXSZe+LdXdypfa4PYsWuf7SYj1E/phaoQhm2+tyNIMJggePjwZXrkyJEmApfQ8UP79eIxt2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673371; c=relaxed/simple;
	bh=FoODtHK87ZLIsLT91VS2/t2ELTaMVveQekR6M37Rqe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2hm+IOvuM2yybq9jTsKWhKvzJkBmpjG2xU08HMf6HqZlsKDeBG3aVWsCMNSMmLw7bS+RKJucJGhRqhVcgoAGFCoNd8aLExqQyCZ/Dc6JiQiJsrxdZp8ryJX03CJrt7Hhu0KfXH4a4xXuXC0B7YYY1BOjj8r16DEzG0Ur/M0kjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSKXLrPy; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSKXLrPy"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82d0b68837aso47115b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Apr 2026 11:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775673369; x=1776278169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wzDfLfgSZvbjTVt4w0u1g9djtPuy1licBUfHTLjI5M=;
        b=BSKXLrPy31xj0ggNBDzR0btuBXq5De423O67MYBxm4mKugB07CFwwhRpmJfcGdFMiV
         NesuKIXP2m+BjHQmfGNiyr1HZvLLGJiOMO7gybhzBwFZv2AhdDAjb9VfdvzcFymMO0wQ
         yJGGF/oQfxI2fmNfT8p3pGvRX+njp/FX4J3pU8dVZ3BJZSgteTRL/84yRzzf4WobPeIq
         hrxzlFj/wSWYBw7yASxqOHGFu+5SGhsWGEFPB2biuDvIzKfGAG3RUnQ1bSbQDRDSPdF6
         0JQo599SczugsGyDI8+ZpAZIqkIaH02RyxticS3SszsfqUWeJl0DzuLNkYktzcOZHh1R
         Vhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775673369; x=1776278169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0wzDfLfgSZvbjTVt4w0u1g9djtPuy1licBUfHTLjI5M=;
        b=llfES08t5mH9B38Jy0pLSBIJP+01ADzV1s3S/ojLai+aVUl2nsxN5RXSQHEe9J+WFZ
         TFh7VDDmkPN1P4vs9i6hgEf1y+NnVFcc1QeYHOiN4HecGMAvbxk2ByjM7KoUHXf5eHWj
         zGI2ZUPaR9Un2BMXVdlAny7O8zmVWaeFq7ZxcnHFULBRNqK0Ow398OSM5Uep75IUn/jm
         eSzyQ7f98DTvDqPWxYQhIXVMA6OOKZSRQjJBtTntNIKYa/m5meZJsWxVvlYhdiGxa50m
         i+RlMndS+ku+Od+4a+Z8sj7NAh/cYxgkdyUoHQsnwTVAtGJarHMmQSCYLNah6ibQ/sJu
         mZlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcP6fo++ekZWF7imMX9deVebPpNlB90BzKWJN2Jm0+mh+pgszPgrXe2HUQ+GlTbxAqIqCMAh8IHf8XUicLKfF6REA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg102kWSNPpWdfifyfFQtiI89quFBKDVmtlOxgCd7/AOQVxoyu
	6pBDejIhfjzqlbEmx4cgaL3+oIDf3rbBHYhKEcJ7nDV+wIF3BBHQ04xO
X-Gm-Gg: AeBDieu0GF1G9WKJEPklmBID41kKtN3a1CQSnyuiYIntiz4F9EyTVJE3A88QCzNAfcu
	ulPsoYSsVPhXS82yUA558R03E2DgGdgGNKq63kqfns+lPBL8b6QuxL2oOYT217NNsE5YNvml2qF
	kFYtl/1sjAQ6N+pDpwf5V+uNKRxRX3mq7VlxEpakmKix/Eub7WPYwNnyVrgOLg8p9q0HsyxYI22
	wH4ySfFT5qreGn3xEYLr2UeBj6N7Sm75oJvT54Ry2MW6QlDunwtQP0PzwQCNLQd+UQArnmozdPv
	Ga9uKRh27XpIOe+CMfpYsR+v9fi3GjzlxXOnLfsW/45SRzumtXkHXFiKK7ipQnQ0u3NN2+cMAPk
	AHM0DNJ4Sw8NhetZRZr02swZ6eHe6m20Hbw8DSxwzvbnbF/4AKCCdbBuherlybpDVOTvaunrjNQ
	4ss8ATBm7nWcz9qLQj9IiuNO0kpt02iPf/oKyDvHA19oyKGWTWDbU/eQsXsOaXNgSmSkKj
X-Received: by 2002:a05:6a00:1304:b0:829:8942:2ca4 with SMTP id d2e1a72fcca58-82dd89aae52mr482081b3a.19.1775673369332;
        Wed, 08 Apr 2026 11:36:09 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:1a96::2a6:4e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b21c92sm23113251b3a.11.2026.04.08.11.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 11:36:09 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: bpf@vger.kernel.org,
	leon.hwang@linux.dev,
	memxor@gmail.com,
	jolsa@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	rostedt@goodmis.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	varunrmallya@gmail.com
Subject: [PATCH bpf-next v4 1/2] bpf: Reject sleepable kprobe_multi programs at attach time
Date: Thu,  9 Apr 2026 00:05:48 +0530
Message-ID: <20260408183549.92990-2-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408183549.92990-1-varunrmallya@gmail.com>
References: <20260408183549.92990-1-varunrmallya@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kprobe.multi programs run in atomic/RCU context and cannot sleep.
However, bpf_kprobe_multi_link_attach() did not validate whether the
program being attached had the sleepable flag set, allowing sleepable
helpers such as bpf_copy_from_user() to be invoked from a non-sleepable
context.

This causes a "sleeping function called from invalid context" splat:

  BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:169
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1787, name: sudo
  preempt_count: 1, expected: 0
  RCU nest depth: 2, expected: 0

Fix this by rejecting sleepable programs early in
bpf_kprobe_multi_link_attach(), before any further processing.

Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Leon Hwang <leon.hwang@linux.dev>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0b040a417442..af7079aa0f36 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2752,6 +2752,10 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (!is_kprobe_multi(prog))
 		return -EINVAL;
 
+	/* kprobe_multi is not allowed to be sleepable. */
+	if (prog->sleepable)
+		return -EINVAL;
+
 	/* Writing to context is not allowed for kprobes. */
 	if (prog->aux->kprobe_write_ctx)
 		return -EINVAL;
-- 
2.53.0

