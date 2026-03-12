Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E720A358383
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773339628; cv=none; b=tt3S+GzheOzk9fYdzNeaMt2+eGBeKwA+lTXWccXTCvf2r/n+7GL6AXDXC67MuQSYSVYyC6gXDuf1H8zz184G9OOQX8ljBEGnAt06iCLZQdNBrlqypP6QneyUhgzJy+kloMhmUzokq6BFZcLVI5IGj9o9uxLGCvVl6bulamJZG08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773339628; c=relaxed/simple;
	bh=A+A+tratlevD3a3rMI2wmVXp/n07E7eNLHxYMsuqPio=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PtmZl+x7FvmLwtIb4mTrYGstXS69iX1qDTTlmlb7TW5Y/1RRGgVqNH3youQvWXAX902qpRCXsc/Jgzvyl0bU5iHaLbwYSLZtCFyrbfRVuZKjN/jSqgq88ydVnvMzRk03mE4O4aUXXa3stnaNqrAcEQfQwF7Kk1WwIyK5uOaiDOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ifNmJSim; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ifNmJSim"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4852cf0318dso14173135e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 11:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773339623; x=1773944423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dK9k5DTKgk7wxx2+4cg6YZWZrym/c7pdTbONfQY+9AY=;
        b=ifNmJSimEe6j+RUMA9aOJsI+nsNfceRjlUCi13TX23Bh534+nRkC98dk5woVDms9qa
         TqRo+KmojBZOjBgQl1SFfmd5MtT6cc/MjzLSH+cEVEKwtHhe5Ti1H3hPAYgt7WhE8Nav
         Tkdi34Sr1U41nWaLcjG4RjfMpoK1QjMzbAAAR9ANSpO8ekAkVvohuM7sk6ulX2H07W43
         aFRovYnfjipKQ6Ocw1L8t/vDzGeGYuQ8XsNm618qPAfZTyppryMooCRPl6j1JKrL0Xy3
         LwLeI/FEq4Mzn2NXir5Wxa9ITKvnOklalKKlI9nUfXl/5jpf60xEPZQTMXaYazZ2J6qd
         UdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773339623; x=1773944423;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dK9k5DTKgk7wxx2+4cg6YZWZrym/c7pdTbONfQY+9AY=;
        b=qKZZno4Nd2o+XmWIOJNf+0lWHWclNo5cGWuH5QxLjsUq7TY/1TBLQOGdY464UqPTK/
         9UIG0EeK0G+fTpqqGI/r9Li0Lxx+BQnpfLSD0WQYgXYzEQ0n8TfTZzgKyGzVTD0P30R7
         VAUhlkjdI8OM6xz1a2pCjAa6RLYbztPKXjtGOY6s1/x58QcS6Xe2VFMmpcHGTnx7N5dq
         ehqYMAZNo6uRq7emf8agR1qz0z9ZiSptbfVzJ4Xmht41q6jiwq/bU8nLLZ2ZznJ1Na0X
         1pL4cWLB74oxgLpIoJxlW5aorvmK9oezFDEnKjZPAksKFIdFU8r8x2Q9HvYnIILRdCQW
         hs/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUazmy+6F4z80ZzjL3CL7WSlz4ejIzDSEnM6FKBOhwdOFWTRvF4yE6sU4pgQ8jBnjjctYDceinA01czKwEX7oxcEj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8fh0X0deX1VRfIoM4C7ZnMbbLWxgRrfjqS4jEfM2ShbMoCF8N
	kfCw+QxWQbQrf6JozbXxU59nqnTnbuQ/EQihDgo96pxywxtvleIh7ilRNvi2K8j7fEcooIyCn3L
	r7fndN73V9pUrPOOVScHfEw==
X-Received: from wmcu23.prod.google.com ([2002:a7b:c057:0:b0:485:385e:a8c1])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:644a:20b0:485:3bb0:194 with SMTP id 5b1f17b1804b1-48556714b41mr3819805e9.35.1773339622932;
 Thu, 12 Mar 2026 11:20:22 -0700 (PDT)
Date: Thu, 12 Mar 2026 18:20:10 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312182010.111013-1-vdonnefort@google.com>
Subject: [PATCH] tracing: Generate undef symbols allowlist for simple_ring_buffer
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

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index beb15936829d..3b427b76434a 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -136,17 +136,37 @@ obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test.o
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
+$(obj)/undefsyms_base.c: FORCE
+	$(Q)echo '#include <asm/page.h>' > $@
+	$(Q)echo '#include <asm/local.h>' >> $@
+	$(Q)echo 'static char page[PAGE_SIZE] __aligned(PAGE_SIZE);' >> $@
+	$(Q)echo 'void undefsyms_base(int n);' >> $@
+	$(Q)echo 'void undefsyms_base(int n) {' >> $@
+	$(Q)echo '	char buffer[256] = { 0 };' >> $@
+	$(Q)echo '	u32 u = 0;' >> $@
+	$(Q)echo '	memset((char * volatile)page, 8, PAGE_SIZE);' >> $@
+	$(Q)echo '	memset((char * volatile)buffer, 8, sizeof(buffer));' >> $@
+	$(Q)echo '	cmpxchg((u32 * volatile)&u, 0, 8);' >> $@
+	$(Q)echo '	WARN_ON(n == 0xdeadbeef);' >> $@
+	$(Q)echo '}' >> $@
+
+clean-files += undefsyms_base.c
+targets += undefsyms_base.c
+
+$(obj)/undefsyms_base.o: $(obj)/undefsyms_base.c
+
+extra-y += undefsyms_base.o
+
+UNDEFINED_ALLOWLIST = __asan __gcov __kasan __kcsan __hwasan __sanitizer __tsan __ubsan __x86_indirect_thunk \
+		       $(shell $(NM) -u $(obj)/undefsyms_base.o 2>/dev/null | awk '{print $$2}')
 
 quiet_cmd_check_undefined = NM      $<
-      cmd_check_undefined = test -z "`$(NM) -u $< | grep -v $(UNDEFINED_ALLOWLIST)`"
+      cmd_check_undefined = test -z "`$(NM) -u $< | grep -v $(addprefix -e ,$(UNDEFINED_ALLOWLIST))`"
 
-$(obj)/%.o.checked: $(obj)/%.o FORCE
+$(obj)/%.o.checked: $(obj)/%.o $(obj)/undefsyms_base.o FORCE
 	$(call if_changed,check_undefined)
 
 always-$(CONFIG_SIMPLE_RING_BUFFER) += simple_ring_buffer.o.checked

base-commit: 33f2e266515717c4b2df585dadefa0525557726c
-- 
2.53.0.851.ga537e3e6e9-goog

