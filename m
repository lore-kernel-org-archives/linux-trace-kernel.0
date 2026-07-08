Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E2B3451A9
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Jul 2026 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517629; cv=none; b=gZRhis9E2+2UOeps3aM5zmNFvNEP0Q5BUBSaKtbbhhlJtuwudeLnQ/Ew2j+VPEk9kr8LqhwhR4DOYBbI0I7jAIK8RcMSwnNOa2vzP0e1AFT8cehMEAG9hn2Lf0WvuBxEsZetcrWe7Wh447L/3SwG5R95GxOB0K9ZSqx7LrHwBMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517629; c=relaxed/simple;
	bh=ZZxn6+P3naFPWzIiFjXNgs3TajLnL87OM3f6t6i3PXo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EzHthPjflF5mMNUgp9LkXKyvm0ZpDxWpX0fHCrIrpbrkBkBPEn71LNZ+nvvYgbiD8TnjDZvc7ShDDeWGn4McA7S+z5cfp23GRIT/jJMqStpJqirDcIug4cy9e6Bcd67n2ys4kzYK5DpRUcoFKy/7CBSClTKpISdpvCFDpUa8d5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UpewEoaw; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UpewEoaw"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-493bfc3b84aso4491665e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Jul 2026 06:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783517626; x=1784122426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lt1Cf+iXOwIxUQM7FLy8+/YvKCQ1U+qUcCAKQzo3lMU=;
        b=UpewEoaw8DbPo3vD8/gkP+ME8FhLM/InQcoPZQnh0swrZNMOTPaFiec85tg9PB8eS9
         MmHRD6Fc/f6BZbcDeGisHfqRd4in0Z/E4zLRQsDh4i6Q3CeU8nZUWiroXpeWYZA7GIQn
         Eb3Ol+A/Gx9Xv1E0dQw/IAQ6MOFwx5XD4wacaITQQE2cFsHhb38ZSmhPqzJnnpz45P/S
         hI6ctEDCS+XqZGVP0MxFZBnSOYEQXcdzBSV67ckf/YjOdMsXlaED37W9fHrWhOnpN2e/
         a44mzGUA38mmLr43BRZHaMgTHgIG5wU16OBuZfDPkQh+LXY3IvKQEY7mb3jWYvUZ4WSi
         FcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783517626; x=1784122426;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lt1Cf+iXOwIxUQM7FLy8+/YvKCQ1U+qUcCAKQzo3lMU=;
        b=TKooetKA0JEziC2nQvqgd+iEIc5BYEHzKmvoW58NVEtCq6f23gsODqWquOcPMiNSz2
         uodDEMN09FRHriayOsiydqMlgfxmLNqX/tBoKnJ0UzXxFrE4XIkraDL040OBme33wZU2
         Nq6A1K98ivP1EuiuihtUHU87uim8HL+ggcvNV2DJHHogCvc24lm6aoB90pC0+PGCSJz8
         OD6v/CSZiaWinuC1PznWOUxciUm5qi8ONInLxmQZxsdngmyMTpBlDLa3FVpPjJYHmPHV
         JSmNw5rCy4RK3DrRLiDX36rahwBkHNnn2mpdAqVu4+CHGiPtioU3LB/BSjbKBAHYxWa/
         7znA==
X-Forwarded-Encrypted: i=1; AHgh+RqvLKgONVngdyGlSitT75dfyPXl/or+hMbD9ntdtUer4EzKfDhTLhnOEr16UBYWJZasWyIoo0FwSLeIo5J+CuKSrR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJdpLRPjvBb1bMB9nppp/CAgCsqRcJ6q+X78j6vi2WA3reR2to
	hdCEMOh/kSNmEs5p+SdgDns/WJO2MPkJ3ZEuM4oWpei9yr0zHucSzd/0jmRqdi8GTDArmF/MJMV
	YbaJ9v+eiykoi7ahMgFBC3Q==
X-Received: from wmgf17.prod.google.com ([2002:a05:600c:1551:b0:492:31c7:4b3b])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:621b:b0:493:bc31:b2ae with SMTP id 5b1f17b1804b1-493e8dc7c75mr6440095e9.10.1783517625541;
 Wed, 08 Jul 2026 06:33:45 -0700 (PDT)
Date: Wed,  8 Jul 2026 14:32:01 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708133201.295072-1-vdonnefort@google.com>
Subject: [PATCH v1] tracing/remotes: Fix leak in trace_remote_alloc_buffer()
 error path
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

If page allocation fails in trace_remote_alloc_buffer(), desc->nr_cpus
is not yet incremented for the current CPU. As a consequence, on error,
half-allocated rb_desc will not be freed in trace_remote_free_buffer().

Include the failing CPU in desc->nr_cpus before going to the error path.

Fixes: 96e43537af54 ("tracing: Introduce trace remotes")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 2a6cc000ec98..62d3d431c309 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -1008,8 +1008,10 @@ int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t desc_size,
 
 		for (id = 0; id < nr_pages; id++) {
 			rb_desc->page_va[id] = (unsigned long)__get_free_page(GFP_KERNEL);
-			if (!rb_desc->page_va[id])
+			if (!rb_desc->page_va[id]) {
+				desc->nr_cpus++; /* Free this partially-allocated rb_desc */
 				goto err;
+			}
 
 			rb_desc->nr_page_va++;
 		}

base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
-- 
2.55.0.795.g602f6c329a-goog

