Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DEA23D7F8
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498759; cv=none; b=XRyLwZEhbxYbHE+JV5vnQY9Vwx0vHeKNJLzdY0wNlXVkVWPWBZVzZ7kj9WNdqycS0R2qvjRcsnEqL/w82MpSH39eeIoLt2yOgqGZcr3uzLU5Iaflhrl2rXmpGaBOHzh7/z6ffwLOj0KWRq6LnqLZaOt/p/gPfcdYwqX/QIDKFEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498759; c=relaxed/simple;
	bh=0GoKLpSdS6ldxQXPbUu3GD19jDi+5YDA57nA2CXdDXI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d4pDtpSjMdx+bt6pEr0i31DjzGvn88uPrfBD/D/9pD/87pTiNrv+nWmjtlvxeBeyAVc41I3JVgdpUjB1Mdr4XeV4rIsOam0yFvgYDWIwb+IaHjPb4kzKYfRGxLeRWnEptY9dr1kpizpC/xAoU9mD+MsOMGCPSwlgKRIiD2kvKcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NhCXOlXR; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NhCXOlXR"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3ecdf7b5c46so1081102f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759498754; x=1760103554; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QCcr65sPLORj627Lp0bpZGMol0uaDnoIgHQtYd2TdNg=;
        b=NhCXOlXRiizWQiOP5srFfv0kvtMw2WiUZcvdnDrlX+zi7Za1RHuu9ONcv7XWfuucVp
         oEdHWjb+Dew3pyuFRuDu5BD/7ZnwcKuUvBSO/qYJWQL01f3DIh3/WLEGVA690Tkvx1xG
         YvhHyNBI3EdRCU2k6YuORbgii30NcwshUHlLaTntF2mx454qY4pfYDbrAH/w8z1lz0hh
         zNA5a/VLfBaN5Pv/OkFEHzEu8IYCTwirQ/c5H8TR9afHK9bicQlZLbyU+ZYjcb0lPey+
         h1xaGcm/dpwkwvz4YhRKOsz6QzCBU7KwiCv7Y7+uNhZRoL1wwgx7uRtSoQ7im6xuTZHL
         +8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759498754; x=1760103554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCcr65sPLORj627Lp0bpZGMol0uaDnoIgHQtYd2TdNg=;
        b=eFyqApfTKqiUeBfyNHSrubaqejX4joMezGG4lQ+iAgg7LlAcd07bYnx1kKIt9qRrqd
         lHXl0+SL4cJhe4WK7YJvQBv7Qv+zBtV9SG37HrBZy+eqSf6EnkAXS8Hk68R5lTMdYuRw
         Mh9vHSQn1gcE3UC2nM6Ka5GfCYqMsZhd7p3U1cQFpbvIF8hO25MTOjdX51FDSHv6NC83
         XCjQrXDewNVOqUxuzELDiA4JAhywpRsla13ESwWAum9EIGR+5zp2kht4XPY+S6RpTH4K
         ysMtOd5GT0zl6Kug+2qSnrscRIfSqx/rWt9jyfkqZCz369vZM4yR8FpPfju5tTUI6zDr
         WIAg==
X-Forwarded-Encrypted: i=1; AJvYcCUvaf9XpRVgVp5lEWKsb8NXKxFlY5ZHbiVFLwYxDPZ2ztPrRlC9ipLZopDlfTBxsPrM3cEr8jBO101T2TO0kxSDW+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzscDXJ24ZZG7qBc+y8MZCUn9FnKjumJnYIJJeQ5GHgCVAvg1wf
	vV35LzGaHvD1UX4JgA8sn+MlBD8LuW3f7fhLD1Ayy+g8WUSI6f0BjiIuWheI7cHehPa9F9oiIuT
	zwzhLd3O3lrNX65Y+tO112A==
X-Google-Smtp-Source: AGHT+IHQ12IlCfmMAydiKBsHPD9Q4iJr8SeYEXmAn4PmVdl5+Rxkjar+IUCHmSelDg/tdXKzfnSMs19tRFdbpfxM
X-Received: from wmdd3.prod.google.com ([2002:a05:600c:a203:b0:45c:b62f:ca0d])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:18a9:b0:411:3c14:3aa1 with SMTP id ffacd0b85a97d-42567139debmr2038918f8f.3.1759498754083;
 Fri, 03 Oct 2025 06:39:14 -0700 (PDT)
Date: Fri,  3 Oct 2025 14:38:15 +0100
In-Reply-To: <20251003133825.2068970-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003133825.2068970-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003133825.2068970-19-vdonnefort@google.com>
Subject: [PATCH v7 18/28] tracing: Check for undefined symbols in simple_ring_buffer
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The simple_ring_buffer implementation must remain simple enough to be
used by the pKVM hypervisor. Prevent the object build if unresolved
symbols are found.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 53534447e70b..38523ea2e19b 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -114,4 +114,20 @@ obj-$(CONFIG_TRACE_REMOTE) += trace_remote.o
 obj-$(CONFIG_SIMPLE_RING_BUFFER) += simple_ring_buffer.o
 obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test.o
 
+#
+# simple_ring_buffer is used by the pKVM hypervisor which does not have access
+# to all kernel symbols. Fail the build if forbidden symbols are found.
+#
+UNDEFINED_ALLOWLIST := memset alt_cb_patch_nops __x86 __ubsan __asan __kasan __gcov __aeabi_unwind
+UNDEFINED_ALLOWLIST += __stack_chk_fail stackleak_track_stack __ref_stack __sanitizer
+UNDEFINED_ALLOWLIST := $(addprefix -e , $(UNDEFINED_ALLOWLIST))
+
+quiet_cmd_check_undefined = NM      $<
+      cmd_check_undefined = test -z "`$(NM) -u $< | grep -v $(UNDEFINED_ALLOWLIST)`"
+
+$(obj)/%.o.checked: $(obj)/%.o FORCE
+	$(call if_changed,check_undefined)
+
+always-$(CONFIG_SIMPLE_RING_BUFFER) += simple_ring_buffer.o.checked
+
 libftrace-y := ftrace.o
-- 
2.51.0.618.g983fd99d29-goog

