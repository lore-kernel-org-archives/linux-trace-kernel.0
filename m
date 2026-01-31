Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A713542C1
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769866182; cv=none; b=JsDxCD72eEg3bRdSEG/EHU62+/KYZUYFeOSFROQSwFM1prhyh2cTjY+6inTnz7Nu12mq6+K+HplCpU+9bKuDZNWiaoRNm1jwPMJIvQqXUH8qKQNB97/xUymG3gjcA6ZdDfhUJHmAAoZq2qkcoKJcuPeW0z/BY1MEdF3/qWCvO2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769866182; c=relaxed/simple;
	bh=GbGuivigEnOxXZ6AzKbFEuI6H/bL1pwWbx0et86tPxQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pLmlBZ2qMgeFMVZap+iSErfHRZsEQ0u+nd8Pf+jiUxWDDRzyxs2bojkwImqphDOwsnIlKg6n/5RRnyqmNgY9m4IESgWrai0ND4do/yi2lzy4QuQEVjg7UnNqQLTF4yIBsndMMKW9ajKx6lyA9eN5dj7G1VFoPq8zThpSJPfmGTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NGs8el4u; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NGs8el4u"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477c49f273fso27863465e9.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 05:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769866178; x=1770470978; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TvedzD7+kJrfpkXnSgvR+lwDnj1DXH1BG+s75ebhGeM=;
        b=NGs8el4u5nUTFHUFMD1//Sa6CNGSNfuiqFxSWU3K5O0Ky3YONwrnZigs4+uSG923kY
         4zu0XYXB90l7/6NPARA1II0fWOfVtZw2kkz9bsP8DzRSxif7hA3K68qhWK+kfLp9SO3Q
         Qo3Vstn3NPUu2o0mT6+zJYAu19JaNPuFaBjGd/3VyjTrf9nYz0SCvTlFVD/LNiNCremQ
         O8sK00Lk3gH9lk/6EIbq3Ky1/1EP8lzrkfWxxHzRcfVZj9g6nMtz7uwUU1r6CmvWL0vl
         +LsBpsemF/O+SJao6TofugDyxDep8wlAso871+Ezvo1GVHi/JhCD93xH4uPXW3xuLSc9
         9HnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769866178; x=1770470978;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvedzD7+kJrfpkXnSgvR+lwDnj1DXH1BG+s75ebhGeM=;
        b=KVNpanc1UEnliCIZSG2+oHBGNpNZxwi17G5g7+HS+NO6Lg0WTL2r3SV3KMVDEOzvod
         GKGu7xYPw5EYRq1kuQv+nUs+oelLCdgbf5ZstV8nLWW38pjQSqbQbGwX4NpERWQKJTsi
         J0fRD0XGIeZkR8KhL3/L2bJhArUiqALsoyy0JtVVWC0acdbRNzwqbJWz3aj/i537u3hu
         j/m0XfRz1Zy3MsMogFxfAY02dXV7ePg6HhUiutF8aM3e4GdZ0N4w6809F6sn/nH92xvl
         RIG/pu5XodllXVYVCPAGf7HDcmAvjh09EZlQlxahHRZC7TDEuZDF6A1+lN3lCDtstWtv
         +pHA==
X-Forwarded-Encrypted: i=1; AJvYcCXGaz6BMiJFDQU/OZCCWz1xoMFeNJ9j0rXLXXnrfBZHqzpgTI0/EU5g6Pa6LNHTL2E9m4TEbx4x1aj6lfuQ4fDHh94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz1bne6iKOPyCjnbBW8CUDrz6uiUQPRiVmvdyksF8w/LE0lV9s
	a/ty111JtA42oqSKd4feaKJz5ynIKo6Ke49PfT5OYg0buQGuJRs3YawzxQkIw3AD88CNsZlFPMb
	oOAJlWP7Pviiu8IvgKCihfg==
X-Received: from wmpc35.prod.google.com ([2002:a05:600c:4a23:b0:47e:dc0c:276f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8289:b0:480:32da:f338 with SMTP id 5b1f17b1804b1-482db45cb90mr66590785e9.14.1769866178166;
 Sat, 31 Jan 2026 05:29:38 -0800 (PST)
Date: Sat, 31 Jan 2026 13:28:36 +0000
In-Reply-To: <20260131132848.254084-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260131132848.254084-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260131132848.254084-19-vdonnefort@google.com>
Subject: [PATCH v11 18/30] tracing: Check for undefined symbols in simple_ring_buffer
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

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 9e86c43bf320..9f675d5d27c7 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -131,4 +131,20 @@ obj-$(CONFIG_TRACE_REMOTE) += trace_remote.o
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
2.53.0.rc1.225.gd81095ad13-goog

