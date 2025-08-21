Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FCF2ECE83
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764082; cv=none; b=B5gQbAxnnzwoV85KuX9+nk9cTqKMvtgdFO/+ZqRDADQueoaAqWyrsm3IU3OxaVXMxyLqyk51AfJymWQa+TlGYyiVJw+8AHQ7reQMhsFMEsxWQUa4ZIfSBXxOStvoLgpiKdk5sgghxwc5lUWqyZLsV6fsK7A9W9ZgFq4wwXV1mVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764082; c=relaxed/simple;
	bh=QTf+X2xLBmpOy4zyRAuMjGmCvLxjicUtPQoHjzlz3nE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nx6x9VLQhYsLIWOXZSYrDGHSLZXxFAksfrc0GasfOBwsbE0T8Lz3geNkLHrHKuAXAUl8YEtlE4AGFzIspUXzsQ8p6U4LCnQIVCJmFaacKkEqWsChlnUuXjSzT3MxunBJF00keg+MyIpXZUbZDSCHqAneW8g6h94Kc0n1DyP8pVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zVi95W7z; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zVi95W7z"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b0cc989so4610455e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755764079; x=1756368879; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P1WnKbqGJMz5GKuhjASXO9eryfCuYBOVak1j8VKvvaQ=;
        b=zVi95W7z0N43mgJSkA4FexmhCNi0ROKa6/bG9br7PurabWZc+YLM7aFFJEqNATA1+4
         ACRkSS3iwMmsOAU691q4VUPuVKugD4epXNmEUdf4hJzfuGI1Q2a4QWqa22ZJ1GN5+fcT
         XsaHiOf9fpYh0AdggIe8VDhUJ0Q4zII2zRIxgy+bFaE5enEK1cJL0OFkMq5ttLaspDr3
         fMOCtn/5+WkzoZVvfafrRxCX3ygphBouZxN4S2itxKkVC4AdEAUtVb4rVUFJox3t5fKy
         UPzwvm22kBJltPtZEU2/rxbhU+iW9MW/a0Y0pxxehKOdANRD/HOk0VLVggE/G6IWogTj
         ccYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764079; x=1756368879;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1WnKbqGJMz5GKuhjASXO9eryfCuYBOVak1j8VKvvaQ=;
        b=f8ga4hXFDeV2LMS6Mv9p6jfeksHQkTBR+y066D3Rln28FxvGk761bZt+FXeSU3ngiw
         eDTvG1pd2v2tyNtGWTHnF0Idp+M/nvHjVkBs3HUy06Z0R8z3Gr/SMCKWpeVdJHV7kHnz
         ahhyNLf4L/XqvWn+NX1IrqEAtAZMjNC9EY04UC0X7JaI1inRs/jInbvCVFzmXDu5n4wr
         ybXPnKvB5yZ5nMrNkbK8fHf2IuSuYF97WCZvMRbkL0n44hOto14jKTPxISDLLYmWvYjm
         l3qZ7VBT0YEjsqlRTcacFcKoMDa+jcRj6U7R4DV3o/jpPB/6vUKGJ75qaM/vk5Okw71E
         KIWA==
X-Forwarded-Encrypted: i=1; AJvYcCV1E7t1LxyH0R6tj45JmyUQbOyAEzOYgFsUWKEq0ZWX/M4ZqFU/xYPPFCPdMNpv7zJLgvlpIbBAHF9kDl6//3ajTZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwgugEoJSsZ4ud16TAIshyIH8HAvG8gWHE3z03dP/VJZZj8usQ
	fPvM+UY51P0Sy+FrSnUGiC5/N7NCuc6Kg0Rms3UyRMto8iBEvjDEWlLsDgfUMOPCBb6ZuzXt/Mj
	TMNg8P8AJCV3f19JIDDBTXg==
X-Google-Smtp-Source: AGHT+IGDwbMV0G2Q6eX5Ty92Ruu8G0gWgsOI3nyPGZY41v04cwU8/dEgbGIM8RR7KNaNp8Qt7tiVh+uNmLBvDtT9
X-Received: from wmbep22.prod.google.com ([2002:a05:600c:8416:b0:459:d776:c35d])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e51:b0:459:d709:e5a1 with SMTP id 5b1f17b1804b1-45b4dc74ff9mr10294255e9.6.1755764079281;
 Thu, 21 Aug 2025 01:14:39 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:14:02 +0100
In-Reply-To: <20250821081412.1008261-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821081412.1008261-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821081412.1008261-15-vdonnefort@google.com>
Subject: [PATCH v6 14/24] tracing: Check for undefined symbols in simple_ring_buffer
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
2.51.0.rc2.233.g662b1ed5c5-goog

