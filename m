Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F699330D4C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424286; cv=none; b=kWolh0V4vp7yZgU/Njrojcidx6Vd0uV134B6CXgMyL8U+Z+vSXV8y63DjLbjoEukhr+mfRlSjQJznYVLsqq66spa3hUlHNckbx01DOtGXuIAx/84bBD33xLFei0Slm/DIOM8wo55nb4/duSn4imxp3//7D9XP4rcnsrm8DzxOtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424286; c=relaxed/simple;
	bh=+E83IqF+W5HGdaZV8YeGmeArEiV/GcB4OlenBzDOJBU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z3WkoIJaSlU1rVPj1ZN70nzA6SDxbuicen7nsFKksU2zxnsBQYeGm+UHf1qdBKbuioJ4TAGblSUpYTu4Tb0esLvDZcdii0k9w2mWJafpcgSaekHXcOI5ztSyQdJXAJwd2vDJSk2kUfN1Qf3nt+ny6PcYtQ+K45Z6ulDcCo1AFcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wlD6eP8C; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wlD6eP8C"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4801e3aab32so21231455e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 02:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769424282; x=1770029082; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YywhJHdQmzvLYqPf/VNWfmyvJv23Am2v8tnakAtmlS0=;
        b=wlD6eP8Cy5H9w/NYjunLT0egu+r60RIhx8pFPhL8jXDb1hXA9pCj0U4+PtsmEpAcR4
         8wCYX0ObA1dwZ8mSORYRDP4FGo7Zs8nJj3Qx9iL7dSrUmb5MVu+ej/2ibkVE9uEebAqB
         Uf/Zquzkkk2szkm/3AaBvkd3UWczEjJpkoOnWzveLZD8tK0GMfWn/bFtDN35Zbk0i2zE
         ahefMVgKQVZ1HhSiCF5urT1H1238vley0YRge5PhZIqDZjbotmfZQe7+4N3fdltcLsn4
         GFjxj7FH0FqFpz6kKaSNiMFdKEOfx1hruBsnjOMOsqqc87n7iZV+B8TnGofejV+hNuYE
         PM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424282; x=1770029082;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YywhJHdQmzvLYqPf/VNWfmyvJv23Am2v8tnakAtmlS0=;
        b=vhK+D0Oen/Tzi5EgfGtiPENAXeGiKOlEDaVeipocCHflNW7pAzlWzy9D7ryNl6aqS7
         j/hOV3UaEzuDf5QyNPX3pshN86kUjNHL+zwYLYIRoG3+i+sl/IATulZ/YnO8I9IbtD2N
         U1jvFS4ZkuOg1FZAm3kTN4+DKCRvp6ZXM6NFrQoMILSfbJshxbKkTJlRAPo9bjpUC9S7
         I8gUTV/DXzXPZoUwDP7qT3fpsqc5zAJevJnt+NwH6aWjaXkI2XCc7Jxjz91fnm6S1+5X
         A2a73vOSs7OHjWJx2fl7fnJvVXnALGH0s4miOmkJ4KHXZGD9cs0ycGQwca5e9eQTsBAP
         68AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHNPOLByUAAtWQp2FpXXfHFf5WoHvJ2Sor/wZ5sFCfWO9fOhSKV1qGpMSWkK8kaMJgiETsdXaXJvCy3yIAU0TZQzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq1i1kebz9aaf4S6rHXNWqaROtsbdQ6dVQmor6nuAJEMjYpFiK
	b98ZYPY1XFUd242KTI3PqbyIbM4ZEbakaZn0R6gLM8Flz0KExKW2JyqBMSe8mVK4FpVz6YHxuUh
	Lhn5o440AReFQz9zlgbfIcQ==
X-Received: from wmkg7.prod.google.com ([2002:a7b:c4c7:0:b0:477:5a4b:d57f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5395:b0:47e:e20e:bb9c with SMTP id 5b1f17b1804b1-4805cd40991mr56788285e9.8.1769424282193;
 Mon, 26 Jan 2026 02:44:42 -0800 (PST)
Date: Mon, 26 Jan 2026 10:44:07 +0000
In-Reply-To: <20260126104419.1649811-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126104419.1649811-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126104419.1649811-19-vdonnefort@google.com>
Subject: [PATCH v10 18/30] tracing: Check for undefined symbols in simple_ring_buffer
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
2.52.0.457.g6b5491de43-goog

