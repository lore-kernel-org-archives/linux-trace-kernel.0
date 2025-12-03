Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A913B35BDCA
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Dec 2025 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779016; cv=none; b=ibSEcbUI/iLoZqfwK5UvAVuys1iwLvUz4pSpMzbN4Ebs1JUYvuKwtVk8jgNJt3Yq7reYQlSn9MYlwIp6sKfc8qb1n9Ok+uWB9VLCiHHMULxILvSF2JSk+TtcmCWhZoinr5oX7EwDynTa0Qt0WloSZD8gq9fbx1WZ/TU7eYiMfZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779016; c=relaxed/simple;
	bh=XIwl+QOA198wftZNvu9IO4FLzrxnhpjs1uVff2B+sOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o8lGqUC6nPZnMdGWD5lPm7SxuvCgJv0z/6mcJ4qdgg+opyZksYkwQe6nSCUIFHFQHQvmjQdNKwW6cG73HVuePSa9H77FD8VDdjbvSzWqG/R44/TvnqdyG95k4SThlNOMl6ZlRzhgSGbH3dVSf1vz7ymVUwPUZRPRm9kobasnBCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfOAE2NJ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfOAE2NJ"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78a6c7ac38fso75378527b3.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Dec 2025 08:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764779012; x=1765383812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuNgNlcfjsZ+Qe/j+fC/RN/pSpI7MUBa9s9mWM6ZH0E=;
        b=HfOAE2NJepvcF3KQas+gk2xFSOkwKNFBrwETBnYtUiGrCsYEJsETi35VT2KAP1OFHk
         xxgEOn8Vk2oLwtI3LjvxaywokyuxnzLC7WwHqcxJoU6niSdQQ2gunR1kw4mR5k5QQ959
         O+Wt3vvSKs9eDHBUwZt0lW3wBAS56rM5XZsK6k1aQSvKLBjMsLAC9a4xCVDl8bc+Bpa0
         xYcKwcQqSEXto+j7V2H1oiyM+SZjlO4TU/YFYSzOjPjS7EnudARg1rnzYArjRI3AVMTF
         f7zErhCqiyALiyVe7RHdZq59JTqCDLpLLHBjG69J+pu/qsMBbt/IDWaUXiVE7rLnBlx5
         F1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764779012; x=1765383812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UuNgNlcfjsZ+Qe/j+fC/RN/pSpI7MUBa9s9mWM6ZH0E=;
        b=nzTA0Sq/QtGzN/e45bOzgoxu6ymAz253qpfxA1PK48T/Gjr+JOwGjOvpKhesB+MT+/
         YJyadalfbJ1coluI98IH+xabrCAoFfm5jn2opZIXSFeZPxNqBXb4LshhiJ7wJI45U7YO
         rl70Vn6zh7lNKkW1YjqcrHGt8S0LUerWdSKTE4W7Fjxz2yLyp9TxAh1z7ICmCmd9Mcq8
         lyk+E6dtOOwx8aZ8moRFvL7+zAwWEYy8z09LmcL1E1lraWGeflK1WrBzcFVss9EnsnfO
         i5GIOwSpDU41OZICJHpe+FnT3CaHMEgDgta2KaRRZeohG2N7jOhGFVTM4kMFlLCZ6QgT
         NqiA==
X-Forwarded-Encrypted: i=1; AJvYcCWQIGT9hUA13LSOLwk7qiOjGIdGL6e4UzRIQxJL/OA86Ep1t3gGk0gxPAs9gaunJpTiCMKFED4VCIBuowiX5uzG8MA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCVp4WSDFafsyZGjeHBIOgghCs/KbMNIIjoEr8UpwDpJ1+Vj1k
	+2U486I3/5vu0vHjnt5oggOuC+SaWHh8ZOc6HB4QAFMk0BrFK3tMJ630
X-Gm-Gg: ASbGncsjrEm1vWOeowr7mQsvHJm6G0NLC18t64hi/eEVlND5smLQYkVEPWMbwlQShsN
	0V5rkew52OljrbT66rF/knv4DmiWJcaWsXZCLrsdz+spn/0YdLd79vEzJ4w93PwkZSbQop3P/6V
	oAHkSu+4yqPUtQRpJvSqfJdiBhqiJMwrxUi/iXEyIBp9rkfL3fFHSqWxA2u3AXHSZf9WlG6i0Km
	HntEmOyE18ej4dnPjg2CnHAa3UVZu+fL0JEmh1K9zKOsja63ZN3EXxL8bOfz2SjlNiVAQNBXOuL
	lfQuRxfDpNqjCiBhsodg6HPLrcZLHW0cRDZIg9md7No9QKfjXdyNAFPHnFAKaEW+3F83ngkLMpE
	gM5jAn0okEkktMUX4BC0oL6VWPciiOFbCnvy9OxjLrg+8gJNbbXomaoOsBYtmhBFwp6t9EbLNcl
	wSsX3Cav8=
X-Google-Smtp-Source: AGHT+IGgPWDFUFvsoh4Eu3h95/Sh/XNQIQM+FfTSI/plOCqZ3lQCrUg2djPKk5L/jEKtossHKw/vRg==
X-Received: by 2002:a05:690c:23c4:b0:77f:9dae:34f0 with SMTP id 00721157ae682-78c0c2627a5mr21697617b3.46.1764779011881;
        Wed, 03 Dec 2025 08:23:31 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:3422:8bf9:97bc:b085])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad0d5fe1bsm74921787b3.15.2025.12.03.08.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 08:23:31 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	David Laight <david.laight@runbox.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v2 1/4] kernel.h: drop STACK_MAGIC macro
Date: Wed,  3 Dec 2025 11:23:22 -0500
Message-ID: <20251203162329.280182-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203162329.280182-1-yury.norov@gmail.com>
References: <20251203162329.280182-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The macro was introduced in 1994, v1.0.4, for stacks protection. Since
that, people found better ways to protect stacks, and now the macro is
only used by i915 selftests. Move it to a local header and drop from
the kernel.h.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/gpu/drm/i915/gt/selftest_ring_submission.c | 1 +
 drivers/gpu/drm/i915/i915_selftest.h               | 2 ++
 include/linux/kernel.h                             | 2 --
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_ring_submission.c b/drivers/gpu/drm/i915/gt/selftest_ring_submission.c
index 87ceb0f374b6..600333ae6c8c 100644
--- a/drivers/gpu/drm/i915/gt/selftest_ring_submission.c
+++ b/drivers/gpu/drm/i915/gt/selftest_ring_submission.c
@@ -3,6 +3,7 @@
  * Copyright © 2020 Intel Corporation
  */
 
+#include "i915_selftest.h"
 #include "intel_engine_pm.h"
 #include "selftests/igt_flush_test.h"
 
diff --git a/drivers/gpu/drm/i915/i915_selftest.h b/drivers/gpu/drm/i915/i915_selftest.h
index bdf3e22c0a34..72922028f4ba 100644
--- a/drivers/gpu/drm/i915/i915_selftest.h
+++ b/drivers/gpu/drm/i915/i915_selftest.h
@@ -26,6 +26,8 @@
 
 #include <linux/types.h>
 
+#define STACK_MAGIC	0xdeadbeef
+
 struct pci_dev;
 struct drm_i915_private;
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 5b46924fdff5..61d63c57bc2d 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -40,8 +40,6 @@
 
 #include <uapi/linux/kernel.h>
 
-#define STACK_MAGIC	0xdeadbeef
-
 struct completion;
 struct user;
 
-- 
2.43.0

