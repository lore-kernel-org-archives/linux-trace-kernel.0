Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF0E3BE14C
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Mar 2026 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807774; cv=none; b=pxsHes3cz0g653Jf81R/RYHrEMORVGMOuPcpSgOJk57JLFK571TDA/AdSDSFKLn9aStOAUs+qtshllX+floq5LYrFnf0rxQ7znQ/im+dmKuj+0gU6cOBQzCDyLbTZgH6VyMr7lznRt3bL1WyM+EdW6I7DmYk6OXaGdCCcaZSPeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807774; c=relaxed/simple;
	bh=nvJVMgivk0n7tnxwYIskJ85licES15A0ESfOQLBBACk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ovrnf/OgVuunsMZoSpwqvA+/ohwDkE/5FQaP0Tws+eoOAuLv2Ysgt0ZTQ69VIWKVjYNaJK4Orup4Pu95HQAipCgTZxCW5XLxOtzq9bkc17hkoZ9szDlZYFDA9tMX5pbAOWPS9vHSk1taHKx7gXYyjhscPsGSofOZqMp1A4tKTrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2LhAlu1/; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2LhAlu1/"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so72041605e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Mar 2026 06:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772807771; x=1773412571; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ISTtnZxQZml/VUbaQMgN/rAKYfhBuJPSGaUgT7FyeoU=;
        b=2LhAlu1/5hgEy78QDmfqwTRIoP+cRlXaips4nkNgzEqaEF6B/9Ymj35VV8CN21JeAJ
         0zV955lcz1O/gI7h0Kio30v2iwoxb9XIUtMyZute+kc6nmcNNGqmlaSWGyGnIGu2uhQJ
         2A4FjQqNsgIW5soPxOzDBuUnQYMXUjANztEn6bdCZOD0AGLPGDEH0I9ximzlxBqwOtR+
         2efgCZyjI3hndl+78Hkw6esH4K4WUweCC1AwzPAbK2Jss+BTURoCfPg0TREHAwmL/iij
         l4YeNrxgV/JYvz9KfI2r2Qt/a8v9XGn/qdocdoNmEXhbA/Uw3QNMt7qZtoNxWQveLZNI
         3OVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807771; x=1773412571;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ISTtnZxQZml/VUbaQMgN/rAKYfhBuJPSGaUgT7FyeoU=;
        b=cayu3GCC3SH4OQnv2wBwYXSk7+Te0l2mMQIIcl/rn0XrxacFUF244ymDNf32Bm3rPx
         bT7XLtJgflW1z4PSo/k/jH1cmOO0/pQ8LGjKbApJRZBZ7k/tHWWSFGr0GFyiKZfPuC4W
         V+snEbg1OQhdT406y+CZoK3bdcsmRQWGd8x4sKBIJKcZo6EJP6o80OvbFjLhay+hrv4q
         N/A0TfHFXeETbOTv9Yi4mpar9ha44arGGDfIlCtWDVTFMwZB1bcQE46tE6/pLbHAkyrL
         oTAd9JpIVNN9LGaFx9kP5O0cUCdVFSHMtfTKkso+uj0gyhEUNvEz0E1zA3C38W3RYBa+
         0U0A==
X-Forwarded-Encrypted: i=1; AJvYcCUzhMJ8BVMG9Us2EY3DDKNSY+JXkHKTpvFEx5sh20/7SkV78LN7crKiBnS2AH9diDI7ZoEh4aINO8r54hx0vTxMjzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvIQtJCNWcNYIOIW/g5W+yWyeFSA3JRk0y2yqCmgviHV6Q6ACD
	OoHGK5HIfNmjyDb4510bF5X4CrCyY4XS2jxvGPuBH3+/GQdCQRjCV/d7yCjwBn5lSeCKv9xTz3P
	CSoebpAPK2ve9KtbFHvB0IQ==
X-Received: from wmbfl21.prod.google.com ([2002:a05:600c:b95:b0:483:6ff0:11a0])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1e88:b0:483:1403:c47f with SMTP id 5b1f17b1804b1-485269182b5mr44060185e9.6.1772807770415;
 Fri, 06 Mar 2026 06:36:10 -0800 (PST)
Date: Fri,  6 Mar 2026 14:35:22 +0000
In-Reply-To: <20260306143536.339777-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306143536.339777-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306143536.339777-19-vdonnefort@google.com>
Subject: [PATCH v13 18/32] tracing: Check for undefined symbols in simple_ring_buffer
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
index d106beca8d7f..3182e1bc1cf7 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -132,4 +132,20 @@ obj-$(CONFIG_TRACE_REMOTE) += trace_remote.o
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
2.53.0.473.g4a7958ca14-goog

