Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D8B382370
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653332; cv=none; b=W6efj5qg+KKgTdplotp5kzBjqG2X6xvd8EuHCECuwknxwG2Oyuqk6ywzEzdGtqQUize5dRNJ9fWaXT0baMrOnf+mpqDGqeQfeM6siQ+U8lCkJ1HyL1eBmsE4mYgmmP05xjG/HwlCToVUL3yrhrtFc9GjazhYwk5zUXLTO0eUTSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653332; c=relaxed/simple;
	bh=d9SlOdr+yuwtL457l0FPmZf+z68vKfPB7woQApK9XA0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cegQPhtufVPoWOhFOBkYjogtsyp/LwViKqRQlyqKndcY2oOTsQ6Wj+qZkCEIHkWpCfaik70ghmLgvCZIa8OCkJL0zZPO1/ratEU2BdleJS5vBm8bs1jz3OouJCBhmI1XUyezyXXiJKQnrZf9ZZ5b8P7Liw3vYlhZ5XeaUpJtam8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C32vmXi9; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C32vmXi9"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-662dc787d32so4005539a12.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 02:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773653328; x=1774258128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xL4r3k0b9XFrHQ5zaFvHH136zETo7UQFZ5XYSWnx7+E=;
        b=C32vmXi96ZQE1yMmG0fqWtTkD7Q8/MrGdQQKezchuWHMboLQHTa75AsPB4kLi+W0Ss
         i6BSlJkNNW8OmsTXwgElKQldQ/Sk9fZ4NafVSvoxegI4apAe2adKSA8Bbb0PJgj+F3mD
         I7zA3FkznVeA7E5Z7mgXL7q0K5UNefNPI9Ye2W8VjJb+36RHTlZf/4ZMxlGaGDLJlrer
         M2aVGndauiQM075Nd1xgymQowAJQZUc9cAj4acyQVIrEyLAHu9/DeiIwwy7s8tXrmqVV
         2I2gfCcBmq0dEDMbTnCZK7Dv9z7Mxj2fIE1DyY3oBrYvMbGN2Dfk/hC3Z172QFZMHfuk
         6n6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773653328; x=1774258128;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xL4r3k0b9XFrHQ5zaFvHH136zETo7UQFZ5XYSWnx7+E=;
        b=aaQGXah6QNCCY8Cn5lQqcEUYNFOwm1E2rx6InPYLftLVopIBIEtD521RlUjqwB4pDp
         GDT03/HWxEK/K+ZFgCxvr7wJjQyFM82mM88b3nqWIIMWbhgnc/vgs8xvqx97hiAToy6r
         JpMFwmQXw7Z3T1FucHthw/B+KdPlhWHrb4FfwGr5WIX85nnEYsxLTs82W/e3NTA5EdFf
         shUyT1FEygwyRhcOJr9yA0dTMqZ7J6dhdlxhk0JqdrEFHYG3jOzQG5o1aN+ehZJstAB9
         ZqssopzF3oHR4kAc8SyROwZA8NyFrOLrzilU1/WkAJXwfc6YvqNWtRnUoDNzCk7rpDU9
         5jlA==
X-Forwarded-Encrypted: i=1; AJvYcCV11TKDEl09jCL5MVJ6WS3pu9k+2xLpBekd2rdQss3x+RNnpxfVHOks5c5TVvkuTYRDEEKKUT8nEonBo0/t5M9bCvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpWsE/jkPweSmh6NSs8qiGbUS6npHBdSOqggp55K3tEQPsof7f
	xdyOF2GuBASchn/SQgZQnyh4Iuvynsc60zJzZzxSCmoXeTm7jurKvwJSej13a6u+jZ3Tz2N2SO6
	paQ3qiT/wc42bTyTVZTMIlw==
X-Received: from edtb21.prod.google.com ([2002:aa7:c915:0:b0:664:dc29:5652])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:34c3:b0:665:33eb:22fd with SMTP id 4fb4d7f45d1cf-66533eb2557mr2129585a12.4.1773653327890;
 Mon, 16 Mar 2026 02:28:47 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:28:45 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260316092845.3367411-1-vdonnefort@google.com>
Subject: [PATCH v3] tracing: Generate undef symbols allowlist for simple_ring_buffer
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org
Cc: rostedt@goodmis.org, arnd@arndb.de, nathan@kernel.org, 
	linux-trace-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Compiler and tooling-generated symbols are difficult to maintain
across all supported architectures. Make the allowlist more robust by
replacing the harcoded list with a mechanism that automatically detects
these symbols.

This mechanism generates a C function designed to trigger common
compiler-inserted symbols.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

---

Changes in v3:

  - Enforce KASAN to ensure FORTIFY_SOURCE isn't disabled on some arch (Nathan) 

Changes in v2:

  - Use filechk (Nathan)
  - Removed deprecated extra-y (Nathan)
  - Added simple_ring_buffer in allowlist (Nathan)
  - Added memcpy() to generate more symbols (Nathan)
  - Added __sancov 

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index beb15936829d..f4503a001d4c 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -136,17 +136,47 @@ obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test.o
 # simple_ring_buffer is used by the pKVM hypervisor which does not have access
 # to all kernel symbols. Fail the build if forbidden symbols are found.
 #
-UNDEFINED_ALLOWLIST := memset alt_cb_patch_nops __x86 __ubsan __asan __kasan __gcov __aeabi_unwind
-UNDEFINED_ALLOWLIST += __stack_chk_fail stackleak_track_stack __ref_stack __sanitizer llvm_gcda llvm_gcov
-UNDEFINED_ALLOWLIST += .TOC\. __clear_pages_unrolled __memmove copy_page warn_slowpath_fmt
-UNDEFINED_ALLOWLIST += ftrace_likely_update __hwasan_load __hwasan_store __hwasan_tag_memory
-UNDEFINED_ALLOWLIST += warn_bogus_irq_restore __stack_chk_guard
-UNDEFINED_ALLOWLIST := $(addprefix -e , $(UNDEFINED_ALLOWLIST))
+# undefsyms_base generates a set of compiler and tooling-generated symbols that can
+# safely be ignored for simple_ring_buffer.
+#
+filechk_undefsyms_base = \
+	echo '$(pound)include <linux/atomic.h>'; \
+	echo '$(pound)include <linux/string.h>'; \
+	echo '$(pound)include <asm/page.h>'; \
+	echo 'static char page[PAGE_SIZE] __aligned(PAGE_SIZE);'; \
+	echo 'void undefsyms_base(void *p, int n);'; \
+	echo 'void undefsyms_base(void *p, int n) {'; \
+	echo '	char buffer[256] = { 0 };'; \
+	echo '	u32 u = 0;'; \
+	echo '	memset((char * volatile)page, 8, PAGE_SIZE);'; \
+	echo '	memset((char * volatile)buffer, 8, sizeof(buffer));'; \
+	echo '	memcpy((void * volatile)p, buffer, sizeof(buffer));'; \
+	echo '	cmpxchg((u32 * volatile)&u, 0, 8);'; \
+	echo '	WARN_ON(n == 0xdeadbeef);'; \
+	echo '}'
+
+$(obj)/undefsyms_base.c: FORCE
+	$(call filechk,undefsyms_base)
+
+clean-files += undefsyms_base.c
+
+$(obj)/undefsyms_base.o: $(obj)/undefsyms_base.c
+
+targets += undefsyms_base.o
+
+# Ensure KASAN is enabled to avoid logic that may disable FORTIFY_SOURCE when
+# KASAN is not enabled. undefsyms_base.o does not automatically get KASAN flags
+# because it is not linked into vmlinux.
+KASAN_SANITIZE_undefsyms_base.o := y
+
+UNDEFINED_ALLOWLIST = __asan __gcov __kasan __kcsan __hwasan __sancov __sanitizer __tsan __ubsan __x86_indirect_thunk \
+		      simple_ring_buffer \
+		      $(shell $(NM) -u $(obj)/undefsyms_base.o 2>/dev/null | awk '{print $$2}')
 
 quiet_cmd_check_undefined = NM      $<
-      cmd_check_undefined = test -z "`$(NM) -u $< | grep -v $(UNDEFINED_ALLOWLIST)`"
+      cmd_check_undefined = test -z "`$(NM) -u $< | grep -v $(addprefix -e , $(UNDEFINED_ALLOWLIST))`"
 
-$(obj)/%.o.checked: $(obj)/%.o FORCE
+$(obj)/%.o.checked: $(obj)/%.o $(obj)/undefsyms_base.o FORCE
 	$(call if_changed,check_undefined)
 
 always-$(CONFIG_SIMPLE_RING_BUFFER) += simple_ring_buffer.o.checked

base-commit: 33f2e266515717c4b2df585dadefa0525557726c
-- 
2.53.0.851.ga537e3e6e9-goog

