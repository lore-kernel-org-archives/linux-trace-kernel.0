Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F196336EFE
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Dec 2025 17:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764957164; cv=none; b=dbrMDB3M098ZZuWu/z9fiZQMNRYnJH9w2mO0A+lQ767O7PGkwd1bJAkYVBkLfGlpau4Mad9ItfdruhGqUHXHuXbZ/W49rEtZYDICunn+aVDKGKc8fBkChwDvT8F5osBSWfd00Q0KTmQd9ZmEVnL4VkzE8XDaIDHH4DYymm9ej2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764957164; c=relaxed/simple;
	bh=/OtVIm0Tic2jaMDmVwxI6p1VsRr2RMHqItaakWV63oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNXy4aWSlblKOfaLf/Gw7hfl2eYboOvTCnkXmL3m7bj5xg6JI39/i5gtLUZlM8vD9MXYdCKQTDhjAm/GadwDdv9JiXpnYSxdRf+kR4QjDlu+AgHBpPcIBjmmUcEDqR6JAsqToh1NnGkz1G1eDDAYgqx8xXyFXyJgQttIxKa2NMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYm9IiCh; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYm9IiCh"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-642fcb9c16aso2107160d50.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Dec 2025 09:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764957160; x=1765561960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIMsjwiJg4RqJtb77Sd/3hjNTplhvG97vleKrEOTwfY=;
        b=NYm9IiChSv/tk8xyCZC6OCWSX0mOSamUGFmH0vPGGG8++Zpa3B3zL7LNdB5HrLISNP
         lTTFhr9MRVubJdymuqV1atpRDTQVAb8KmdkQJ+VvrP2x2hbqVcIw6uG3FWY2hX1rHR/L
         eGqqSGeDn2+aHdhK0zQkfsTX42ZzZ5d/yYLoU2MDku96CVvgu/n1FHIVrvb/a2Ai2aPo
         zuYzuwFpHwlJRmAyl7AqVrlqyoprUCveJCkS+p79IubOnqOytKONdD/F9LL4onX4O4D4
         Ol9rYgKTDQeoSMv9Lgrwfvk0Yd8vw1KhOSgBgiBTVWf7WoaP0EaC+cp/YkXq5cXO5kU1
         Bqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764957160; x=1765561960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AIMsjwiJg4RqJtb77Sd/3hjNTplhvG97vleKrEOTwfY=;
        b=AxuJuZ2vUJzMYEdHrHgB6d1ML/JZ5BP/Jwrvegu65GdFtB9SUCHQcntd9NCPdWuMWD
         IiYqe03MeOswuEryjmXMvB83Mi6u+p0Rm95cqXPvOikUJvdg5QoLSmLZD4aLz94SqZCY
         VnczEDPrsgaQQBa1TOaCHLHftLVWCUOwELJ+h0lI+TI6DHXfRYFz061JXjLajWgz5dh+
         c5+0MIqvqwBPWHS/zFhoLrdIG0lTOpUgsTPlkI0UhTcygl2Zv5gj/KKHDQ5yNrW3Ir+3
         Ug476r+/GQSBnPx831qrhOWFbnYYg9RvSNm8CAW2hwLSZQ1/oPSs+yiFAePjZC7dNuts
         rkbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDM1GemAPuXWnAhOr8jTvsGJBM+a3H2LBAn7kiwXCuOk2SKuzawJxJZtxfDKeU0X4Pc+z+W35++1KMGLDjMDB13ws=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywand8nOyGlsIdVRAtPAIUnmlTFo9DBDLKvEm8ZB3GPmakrcHf9
	Y0NE2MoXrYjWv+l5GE7+/6yV7gkdxZlutpwy1+Pe2KUo43F2m8HWqFwM
X-Gm-Gg: ASbGncsG+wPYEnzPfJ8Z6o6ClnEh53rMclfLhPk3ispno20c2avpEBqiTre5PEsmWy9
	YE2+4ialLcE2PQw2gXzs643FTYtf6FWCnzViSC48OmIWktgaaJS4SlXHa8TQI6Py+UAtsCx9IEm
	tbiNUN1vl8XcKVS2YTKgG9tcaDNkXJBPB/hp8mD+As+qkBoBS0lJL1NOcmLH3gDnrXfXb3caapN
	XITq2E566c6gEVpliN5LSY65xfTe4vzvcS3IOWANh9uiPexVVpIP7VJwhYNpjlG+WAbAP6dWrJk
	+IVA88K5chheIW0JBNKYzjNGFcbaxc3UwcDUSLN3rgQg+S5Bt2Hqj9wCwlEazN7EXN1MtIeIK39
	zIVoflJGyxMtvB0IblLSI7O8URm1Gy8hZGBCSVG4EXad8HhaND9rkzhLIN/hCw+XzWyBNfFWG5V
	185U5SNg==
X-Google-Smtp-Source: AGHT+IEj0tKsgnYq0A9mSlKiTaWZ9dj9I4yKU0s/KO7Y2wAesrkqKoyujesKH3ZFEOTbGXg0vUaC6A==
X-Received: by 2002:a05:690c:6f83:b0:788:e74:b267 with SMTP id 00721157ae682-78c1893c4e9mr110130367b3.65.1764957159703;
        Fri, 05 Dec 2025 09:52:39 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:be2a:7e4d:3bf:3fbc])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6443f5a3e81sm2042888d50.16.2025.12.05.09.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:52:39 -0800 (PST)
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
Subject: [PATCH v3 1/4] kernel.h: drop STACK_MAGIC macro
Date: Fri,  5 Dec 2025 12:52:32 -0500
Message-ID: <20251205175237.242022-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205175237.242022-1-yury.norov@gmail.com>
References: <20251205175237.242022-1-yury.norov@gmail.com>
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

