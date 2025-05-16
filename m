Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06691D516A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 May 2025 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402863; cv=none; b=Gs1RmikeD0gn8ChEUWDyJSiRYYw8/ZwpCQOxQBctjz28HgxuAnsx2ndPWPfexZDqBgIM4fYaDwrfLpk0Or6daDtt+yO2KSc7TerjUjxRcMyY/RLLMCTdg71HXAB16k5y8drSIK2VykSeL/td/leoYMzBb89skACg+oVQ4iuYBcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402863; c=relaxed/simple;
	bh=mCkGhXQ9HdT6vaPKf9v0QJ96Q8g5D32UXPYyP/6Il5I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KmGlGEajfQf+cx1QdavIZ/iPGiInSjYCM0gREe+BOrXm0F5H5ufBLM0RZsnDHM2r7NxqHqkkkGb4awWWXFc064RKor0ADUmn4pUJ9eHthUEM7e7X9CK0hGoVarUth8Pvbl8VzD/zcKkY6LyzXKHqD7j29BgIO4uw06wHnvipXsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uQyhbJBP; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQyhbJBP"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-442cdf07ad9so12506535e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 May 2025 06:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747402860; x=1748007660; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/CZG/M9udoL/6ITBTvAzkp9kaJCKtk/wbKte22WkTiI=;
        b=uQyhbJBPjVXeJMAd3c/97G670s+lEQ0w43RsnzYQgolQXAP7pUn7QU3UnqayOdyAUn
         K5v+W0JJxiOPWUb7pr00O+IET/6UvaB6tEQjUkk46xjnsNXxs7F+v3o8vcdSfnTHHmUf
         +aFfUphoswp47zjjxyK+1WL5/JP3VBrW4S7Z3GqjBLeXxViyXI59ILBVAnVxwF6KHNIk
         r3oTsjBvCOwvbrvj98g8gP3NH2YHb39mqcu/E/4ZcTSKyUSpGZtOhDnhAB2vrEtvJXbA
         Of3fQ5tosC0XJx7GJCXzC+DPqmSg6iVkCe3j5dTk7nzlYQ9zsOoAer+BPa3wLIV1FGoZ
         i7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747402860; x=1748007660;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/CZG/M9udoL/6ITBTvAzkp9kaJCKtk/wbKte22WkTiI=;
        b=bRniCmDxAtbCtbj+q+NQrB3SQmFpJ5yZOEg8fI5d/U+0GQrzPBLnTxYFaHVzIDkatN
         kdnBVRtDZR+wYdOZJlIaPgh8TZtPwcM4QH86EDCLTSd2zBGHzU/pCRAdAI/IpdE4fHq+
         Cnz+sc3S8cgh0QSKekF5G3n2J7iO2G6CtW7gzbE0GSzGgOT05ZhOWo3QDk8UyTL8gM96
         HFe4+RJh+HzLzsYW52gs0gG6poE+uUgCDysBWa4ZjshwoCFnhKXuIcmK66I4vur/aT/b
         lm8PZyn1UNWs8XYehwgEGUiD3ibHAeLkDGqvn7/i1fvSheLCcojxoVsHwQ8tm0l78PVe
         b6nw==
X-Forwarded-Encrypted: i=1; AJvYcCXungziYllP4KdfDCpQvfbADonpE2x74HodaSb3BGrvkY+OiUiI29VpgpcC6r5f5RC2vyYmyYcsp/v8bcEOm8rjojQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNiAwP6/6RKd5jp8xI3ZvLzSTF4fsaJ3pQJuLjrxkmUGh8L3b1
	EJ/Pgbz2lDTg3RluKJ5dh4G0XsppndQBITkhFC6zZUtPNlE2wlxzxHfldss8lu8gZPNAlGfwxIE
	TvkFKPda3CkeCoYl1Z6vWwQ==
X-Google-Smtp-Source: AGHT+IFmCUr9TTt3q0ScKQbNlGA2kldElMEmGgUhWM5ki5iG13VQEOpV9idvmUymy+nrLiyBs1jUYWF7uKdlvNF9
X-Received: from wmbes7.prod.google.com ([2002:a05:600c:8107:b0:43d:9035:df36])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6296:b0:43d:46de:b0eb with SMTP id 5b1f17b1804b1-442fefee254mr27261565e9.12.1747402860332;
 Fri, 16 May 2025 06:41:00 -0700 (PDT)
Date: Fri, 16 May 2025 14:40:20 +0100
In-Reply-To: <20250516134031.661124-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250516134031.661124-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250516134031.661124-15-vdonnefort@google.com>
Subject: [PATCH v5 14/25] tracing: Check for undefined symbols in simple_ring_buffer
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The simple_ring_buffer implementation must remain simple enough to be
used by the pKVM hypervisor. Prevent the object build if unresolved
symbols are found.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 8f5e194eba71..eb7b70fd5ccd 100644
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
2.49.0.1101.gccaa498523-goog

