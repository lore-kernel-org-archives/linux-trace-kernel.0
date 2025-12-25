Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1827B17C220
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Dec 2025 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766682576; cv=none; b=UQpwUwWQd2XFx/cGLQJXEa63p4Wj+1pbN7DQ94Lx3ERWkktVOwYu+VcKsiRbwF4ydk6WpjiHfm+PSfWTJr+vdd+q1I7rEjIb2UAR9ZKEY6/GTcWK/sNDuyn1qZs/6tWLvLYI5GfBfYQG24Xv8TmaByHG5w4JWoWiKKTZwSsja/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766682576; c=relaxed/simple;
	bh=83f1PmfWzI1WjUX/Z+ePAovTV+WhzN6hT02XuFuHSRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZHd3RWx0PwbxyCZxrwgypzkJX6KX2f1b73mK1XaZw0mMAjTTdDFGWwlmC8j0RAsyMWRSIFnXnMKTmydBOmvE+f0OytaOz/5gZ/uUC3nS1qTo4/P1vBMaIY5xho1r1GkzHS8Yk3fjULOol6vnx5HYhooxOJ9fYgKhSO8n8yURaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXMUnk+v; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXMUnk+v"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-78f99901ed5so59511707b3.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Dec 2025 09:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766682574; x=1767287374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJnvW0A6SgbXQs1NHQABSopMa/fuZliTPpr4o45JmhI=;
        b=fXMUnk+vblykz5k/Qjx0Cv+TicrsEuewTAzLDmrrg6csQdZJJ3NmfAl/8FmTGUV5PU
         vCoi6sG1vV5qpe+/k1d1Pk8EgPFR6tkjfYBJ8Yv7mTa1EIPJTI07wiezdbJdZtukpAiV
         +aijoPhiA8XscSUWZg84Du1LCPTxjAvh6gCIUYcryxSWyivItAafL6EIlA0Sl2e2OP8S
         tLu56J71c2s/b2TpxI5CzdChUwqKCpeEs+WAmeTocnyVmLmi32sLrDfllaOFKtfIlt13
         YtU2MFpUY8aDVB8tFX3Tu6aZf3G4ASOWDTlIUon7wdwqcbOxBmoY9bjsJdIrzJhtOe5w
         XRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766682574; x=1767287374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qJnvW0A6SgbXQs1NHQABSopMa/fuZliTPpr4o45JmhI=;
        b=HJrxpfWBRaOcoIGr0JmkgJojJlO8UknVZFnksIXfehEfqEW5QqO6k6pf54fFNkj6sz
         AiFt7+sSaZkmNzCXApQ+7TFjWzNF4WgFVt0L/bri7+3ulT3ztNazGZdl9oE4agh05g11
         Hc5O2HS68pURRzd+XZd6SUmdjU4G/FFQ1d2+x6amqkk2oSD8nLp5Ljipm1FltK78VDrn
         bfhvbW2ZlDi/HwHuq3y3oO6vdCinIgu5JT0Y/6Q6SSQtkbzvbnLteIB4l916P+zrPv6p
         iwXpMcIJgIZ6Qm0oUP50KOaQDRx5Ndkrvg+pxksPgQNPymnoRqzbA7DV3yxBXYJ48TRK
         2yAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYLEnXQZXT7z8/c3dReSjZpbz5bujLyuZ3pMsKt8NuU5rq3Wlw8P25ByS8fkIB10Y3BUS9k41gPDA8gqemD5hR3J0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpFj4JTsqj7ML04sYvsKUU8hpTe9ddOauoeYBrdzf+B8HH4vA6
	MuMjMGz870nKVoCDZORuIaxNcoJxPHvuGxzG4D+f5km8gc+ZtlsYz6WR
X-Gm-Gg: AY/fxX6xAjnkoYAqPyW7KLCYpeTJrsWmSwGfLqG0Z3spiKy6bLYZN6kRi66P2SM41IU
	m/2s8Hr06r+wXVhAD8rChHTLdaEFiuWrMVYCFoAqeWJl2ZcHN3OEkWvbZCGouvxv8a/PRaqVK6y
	AAjQ/gT1xhwMgeq1aoPs5euxcso5Xnly4pP4NcphnpylXDRVHUyN2l+WTmJgn9vwn+L3ZCsMfY/
	4wE5cZPJDpwtaxB7Ovavc2FVJYEmvgW4dLF99X6fnhCBT4yeZ5YuAYWk44NGEut4vniSTxK1IAq
	3ZDBOGKeg8uwmgdpYDOLd8s0wb1dEop1q3yNwt2U2o8Mp6gMrdURJQITVbTCdTezC1CdVAJ9zZ4
	zRqVGFV2nxzH41iSd8ED5o9rbRsBcznloLPIBEdbFWbUoyzJQmA47Az21IE5inA6AcuHi2rYNbV
	+cq7MAUNo=
X-Google-Smtp-Source: AGHT+IEOI5N8F1QPJkwKkoNFoaHrbTb32hBNxWVW0/bhknzb+bHcnaSpekV7BEM78upWGjfs7XzINw==
X-Received: by 2002:a05:690c:670a:b0:78e:3dcf:7aaa with SMTP id 00721157ae682-78fb40294eemr168823547b3.39.1766682574047;
        Thu, 25 Dec 2025 09:09:34 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:5a70:118b:3656:4527])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb452c441sm76158037b3.46.2025.12.25.09.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 09:09:33 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v4 1/7] kernel.h: drop STACK_MAGIC macro
Date: Thu, 25 Dec 2025 12:09:23 -0500
Message-ID: <20251225170930.1151781-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251225170930.1151781-1-yury.norov@gmail.com>
References: <20251225170930.1151781-1-yury.norov@gmail.com>
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
Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
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

