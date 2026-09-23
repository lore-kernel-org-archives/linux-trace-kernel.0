Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE20543DEDA
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Sep 2026 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149349; cv=none; b=fJXNRHhvYZmUgtJ4VHos4rpWvrc/3DOu0u/5se9XfOA7pCLGS4BWwfaxBXB6sZOVU1m4r0VcC7Ccc5FSqUbsqDm3GHo/TDqD6yWKotJmkZdk8NAFjOgO26R96qV8+TMlvRXFqP0D2e3bzSzAqoKdsyyIMakv/ylyo/nQf+NxL8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149349; c=relaxed/simple;
	bh=wCib6KE4dngNiDuCwF4sJCSEDWwsjhpFRS/au6SmFBs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aIShOhQPoE29gR9z0QL8+niyJTDSCkk3peHF9MOSzPKr7Q1kadWPF2D4VcQSPL3/r0SqezP1JQeFABnMYTSPD6emwgzKDg5TJpSiAUNZ69R0+Ib2db5tgi6y0zrVt/cLPlFLW7yzaes60GzdGe54bCebenFtj3qUbHuAs0RPLQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aj5u/BT/; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aj5u/BT/"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-495689bfcc8so3586045e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Sep 2026 00:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790149343; x=1790754143; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GgukdaogGpd1Caq0HK3UN84DQotWk3nLZ54dv12cOPM=;
        b=aj5u/BT/u4ZDEtewW3HV2foVDvv1c//1FNvloHRj7WvDU1INJL+g7DDbPsZxQEJrfs
         GmbLlmD/d/4rg+sp3QOiBaXU9cgvOJWAAVHSsabP0CRwMqoPE5+LZZFf7ZRa0j3jC0+w
         0eIfl8yuNqSBiBVo9EwqCOZ5OWEZ4nyPsxugG8ZI96KNWmNX//9nAfHFHxAJcBl+e1b5
         vmD6hmHdf/kIZcd4iOZxE9pwUSSaGftHhExU8Vkyfbh5dQwkjEpCDff1AGUIMwNjmN3p
         DSgYfNHrkaPfbH+sjkiV3b5RUthq4halPRYJ101Pd0B7ej0cUFPD74zajVXHqxK9YFRO
         6mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790149343; x=1790754143;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GgukdaogGpd1Caq0HK3UN84DQotWk3nLZ54dv12cOPM=;
        b=bZPAYWP9W7GVxcn4VmGdVBd/eRb69VKQbyTQbhVndzHrCEqxzYbO3lXOCYQwHGx6ym
         DCZW8VpYl+M95f0wCiYTqJf8u2NxJqBDNMR5B2pvCLiFED4ENc+uC7Au/R6UkVwEXCKT
         43pkmtcZyMa1jU0iZxDdt69GCgi9tbxWDiHlqgaK1Vh0q2X6Ty90JMAXxfAIklVe54XV
         xKRSdd+jLPChkH/HDVMVI+4eoWBPwwHDE7SYG7Xf2SfkQH6+RRdyjrCFshp9W2p3Q2MR
         9N4W782hzLRv567sb7tQK5NuFdawaibuTOxJ8XQzv4dc+vdRvHfCnyCnq/cIPc5+WTmy
         9jkw==
X-Forwarded-Encrypted: i=1; AKwUvBzj1Q5V5qs6PSo+D7EHpEifE07Zt90isJfTGMGrIy1fUZ/hmwwQqUKPqalFfYWGN/g0Cn+bu1YNEeFLxqA4J/Ijjy0=@vger.kernel.org
X-Gm-Message-State: AFuF++kxweaYhFsC8kwM618tFkBjtzDfBFV9cj/2DmieXOYdZcxsiMzv
	ym5S2qJxF0scLv6SIhnRc/0A8FagIMSqy13N/DwFlcNaSKFz4KNfayPEESTuKAcaNu3VXsneq+n
	bMg9NqDHUjJh62LSLjLRHMw==
X-Received: from wmbjr15.prod.google.com ([2002:a05:600c:560f:b0:49e:73c6:38ad])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1553:b0:49e:81a7:9fbc with SMTP id 5b1f17b1804b1-49fdf13a117mr17551095e9.24.1790149342977;
 Wed, 23 Sep 2026 00:42:22 -0700 (PDT)
Date: Wed, 23 Sep 2026 08:42:11 +0100
In-Reply-To: <20260923074213.3077182-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923074213.3077182-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923074213.3077182-2-vdonnefort@google.com>
Subject: [PATCH 1/3] tracing: Fix empty symbol names in simple_ring_buffer
 undef check
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"

Sparc64 emits empty symmbol names. Skips them when establishing the
allowlist and when extracing undefined symbols.

Fixes: 1211907ac0b5 ("tracing: Generate undef symbols allowlist for simple_ring_buffer")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/all/5574c9e6-9ed2-4ee6-a2b2-fb6ee81e83a1@roeck-us.net/
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index f934ff586bd4..0e1846f7dda3 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -146,11 +146,11 @@ KASAN_SANITIZE_undefsyms_base.o := y
 
 UNDEFINED_ALLOWLIST = __asan __gcov __kasan __kcsan __hwasan __sancov __sanitizer __tsan __ubsan __msan \
 		      __aeabi_unwind_cpp __s390_indirect_jump __x86_indirect_thunk simple_ring_buffer \
-		      $(shell $(NM) -u $(obj)/undefsyms_base.o 2>/dev/null | awk '{print $$2}')
+		      $(shell $(NM) -u $(obj)/undefsyms_base.o 2>/dev/null | awk '$$2 {print $$2}')
 
 quiet_cmd_check_undefined = NM      $<
       cmd_check_undefined = \
-          undefsyms=$$($(NM) -u $< | grep -v $(addprefix -e , $(UNDEFINED_ALLOWLIST)) || true); \
+          undefsyms=$$($(NM) -u $< | awk '$$2 {print $$2}' | grep -v $(addprefix -e , $(UNDEFINED_ALLOWLIST)) || true); \
           if [ -n "$$undefsyms" ]; then \
               echo "Unexpected symbols in $<:" >&2; \
               echo "$$undefsyms" >&2; \
-- 
2.55.0.1082.g2b9226bbc0-goog

