Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351AD38A713
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773399515; cv=none; b=Hq37SEL+4V6tHD2lVVRh3NVkylMaTH9R46Rp380cPP95+uT6N40GwUwEGWv18viiLE3XT7P7w5/OXaw5MccPglK/H4MFO30GImsUM816+fO/wD/kD5DT/ceaPtt/Irr4FtOu73a1a9Pj5iqDRYPyzJE2vmdUly66vNqgtaRovD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773399515; c=relaxed/simple;
	bh=0gg+BXwTZs8y0vwcB8E2pQg8BCz8Cb+Fa+086MaSqfs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bYddSeAzdRZKuknxBsVF/V1CxMqEB4ZAnixcWrdxEV0zZWo0tzONpqazlNbEKkqJHKrhGvWHge3dTPFMEtikfTmIjnIL5BaU32uLa7iIjhU5uyNYJry5N5G7W4tJqgoYdFoGMDaECCmspRpFkWtkv1FJdlFuUe0ukexC0g3MboY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rYGjkEcD; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rYGjkEcD"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48535f4d5e1so16572775e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 03:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773399511; x=1774004311; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mrymzRMwHOpggoI9a5WaW3RvaXQ2tcgefwApaR5IFTc=;
        b=rYGjkEcDMudIuN3AmQxQHIyW5t9W2qf7LIcB9LwPn6OEsUSwRwHIoNpQKcnjiruYO2
         FoVnO/awtcZOcERSaSF6yw5M52TBbCguq4fUwjc4xZh82Mv/oyzt9767RBq+MlaJd2Fm
         x3LrZpsoE2mClD1DdhZohfh8bNdFI0hzaibZWVe6U7AhziAY08Ymmhj4Y/sda8cEkE6A
         79v/0FhznxsYlv7pkxOYlLG0Frcsp61nlNAyu0V2uIqZ0OSAN1DVnA3d6QD21njQJmQM
         DlwfIMVDY9bMGCeO3je6vIUGS/Q677EA+61xfUMgooGEmPxSDdOezwKlp6kU+YAAieN/
         65Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773399511; x=1774004311;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mrymzRMwHOpggoI9a5WaW3RvaXQ2tcgefwApaR5IFTc=;
        b=DFvs7pONC2OticYe25yQipRntxxFKw4NNkTKzybMZDF/iGuNmsJwqQAuOqm3lxdaPO
         1fw/Fi3p0Nnv+RL/oOL1NWAxJguv6LEuP+4YSHiIPkfb89wKfycnzx5eX1HaVaVNTQw1
         AeCMCQ3k1t0wbdldmi43P2FcoLfsf/x3ej62bWuBE0m9jo7whdtc/sCktKAjRcfMMnz9
         NpW+FZy82cy99Afd95jYqVoBlCPkmdCEJL0AqM9xtt4eHT1NMttrngFGaMNG7mse5Orp
         lPwWaHEnqUwlUSDgfGRT0r2D1RsLyhpKi5O99LORG+S/5iG5yTZFXHnGt3D0+9euZ+59
         grSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiWfaSQWlhVsmmrzrgTtym4Z0Mgrcg2WKALDXYFteUlmk8/qdNviZLp0s01JrMwv4wFsssYbxBJ01kIIexvZ8E7BE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPwQRwiBuSWFXL1AiIXWIqp9GmwPpuS+szkaPriq1K7MUQzkBm
	I2zELxau5FIfGVJVQE0UEywK46RozOm3pdS03+6fX6UEsrn++WHgTUD1OwBFgzg1p5HHobUcCcc
	S8NrOq/SVvRKgnZxUfqelUg==
X-Received: from wmsk23-n1.prod.google.com ([2002:a05:600d:8497:10b0:485:3ee6:2d4])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d24:b0:485:379b:57bb with SMTP id 5b1f17b1804b1-485566c69a5mr39972655e9.3.1773399511375;
 Fri, 13 Mar 2026 03:58:31 -0700 (PDT)
Date: Fri, 13 Mar 2026 10:58:29 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260313105829.1214123-1-vdonnefort@google.com>
Subject: [PATCH v2] tracing: Generate undef symbols allowlist for simple_ring_buffer
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

---

Changes in v2:

  - Use filechk (Nathan)
  - Removed deprecated extra-y (Nathan)
  - Added simple_ring_buffer in allowlist (Nathan)
  - Added memcpy() to generate more symbols (Nathan)
  - Added __sancov 

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index beb15936829d..96627a909ecc 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -136,17 +136,42 @@ obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test.o
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

