Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587402;
	b=1p25581KwFO563MqmtFNGYpgUCk3z3umXE8pI6PR7yHXDg28heWExIxqdwvFjKP+/mj7
	 6Dt6AjHhZJ/Lg9Hze/cc86pnOpyqWjq1g6xtjDlxPsuEpXGN9e2QMeV0+ShwmLeQVWrfH
	 +j+As2PKcfZNKouTBfQvAvyEZTuBDscqGCkC7tJA7jUYMk2PKN9QPCX6kISs+rHUFSWex
	 P+IADg/ckhWzyvgiqqXUohFv9oGKKJ3s4iZY30hsra9zBoMZ0OcjAcizXkHIxoOmvfIlE
	 x5/PY2llrLJxdL8fkYQ7pqV+29NGWqkx+iNBXy+IBrtJzF4+hjNvhYRMjaBtTqCz1qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587402;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=WUUeXjjWyK6qjX9x82xlteWuEad8XsxvDUnphU7EmH0=;
	b=Ig9gYgtS866mSWotLubZe30sHkGFF8INzoDxVBOJUi27fYSIES0s7uCFieMYow+n4Krf
	 rQKqalt/daWvtvfpEg84iG7SF8u7Dq6FJef+fn3KG0wzUsWcwM6kY0lchmDvpJ1SNNX78
	 Qkzri1mN6qijmmJr+TPrv07hhnKcY8lDYJ+J3L4v3bwMfRN9tNxIByFopMJpfu9bQIw1b
	 COSCiDRu+tLtp3PWlKE5BNHB/DqkjmZNLKYlGsfiOSfjj+J6RdUv+O2xSc2MbeHU0Efnx
	 cdgmPGi6nmNkffeH36goKExW2Xbtk9EZPXbwaRhZK+YowEuox0/7zyxrz67gfGfgtnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="P/6VrMLd";
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2974B6077BDD
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 06:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2974B6077BDD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P/6VrMLd
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-383ec96a7deso6021722eec.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 22:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795587401; x=1796192201; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WUUeXjjWyK6qjX9x82xlteWuEad8XsxvDUnphU7EmH0=;
        b=P/6VrMLdYfYArUFioPhit1ABBARFXOClMQPYcGsbvhHdv2QeNNh/sMQHXeRTMCNdcy
         p+6CG2SwLhTyZzIOw0w2Svezd4KyjfG/3CDdRku/dPEl00xb92xvQcjsnMD4XgCMobmX
         yO9Ev1AsIKKR6npY5APykjzGGkpe52YcZFScWTGzvU0h5DVmGweEIGwpR7vUxRXl8byL
         UOycmUKuTyEBn10qn14UipKGoH7yQSpWgkcHrpabH9WbJVi3T0Vl+VHIfZkb/IrnXGIf
         lZS1Yro7jVASiZRUc3aVH2w7DhgqKKDynxAUE6F2xsL7XSOSDEh0qcMfORhh4RcgzfLI
         D/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587401; x=1796192201;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WUUeXjjWyK6qjX9x82xlteWuEad8XsxvDUnphU7EmH0=;
        b=LkLyXx+3SSMfZxqb3qjF7pOr8vSYynrIn+2s4sRGEuq4XfquxOOt82PzUZzPRUEuTb
         UhVyNk136K+AOj1AXDujgLinf8XK9D0OUA5y8A8CatK1+xo/uBmM610zOoEM2Ao4T2EC
         Jvs8Fa96luKjiMA/adwOCib1hEqf0tJ+Z6qwUaaG2biSoqVrFdNy049PJEEwsU74LKv2
         5qJS0gRCJ725MmxQFYrovw1gWbqPbg3TlqXM3Tman0oX9CwIS+s4vjKbkNStUdD0525b
         Y86mm/byEbLgS8i28xj+yXO1wW/KMS/QrDQ9Fu6P/a458ho9dLMQBrkgL6aqKYXyS7G2
         ldGw==
X-Forwarded-Encrypted: i=1; AL+hErHRWiqZE89Lkny2qnFW3c0AKys5TQEJBjshxRXhte/XuVGomtpwIek39/e+b3bLI4/48kfAUu8U0nM7TSvwikzzqmE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1WiaD9MA7xhMW9+7SXu/duSoEzElCO8j+2dD97E6sRhSP++dR
	OI/Tj2Mlnlc5IYC1D5Z0i20Nhjv6KDYWajAk5Yx8Rj+04ktQG3MDzU5F2zvoErJ3uPKyeeABRxa
	XnqSVuadEMw==
X-Received: from dycnn7.prod.google.com ([2002:a05:7301:1407:b0:384:71f1:1227])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:5093:b0:36a:31b2:8643
 with SMTP id 5a478bee46e88-386992b3f3bmr14119799eec.38.1795587400863; Tue, 24
 Nov 2026 22:16:40 -0800 (PST)
Date: Tue, 24 Nov 2026 22:15:15 -0800
In-Reply-To: <20261125061523.1540234-1-irogers@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125061523.1540234-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125061523.1540234-23-irogers@google.com>
Subject: [RFC PATCH v2 22/30] tools headers: Add linux/kmsan-checks.h copy
 from the kernel sources
From: Ian Rogers <irogers@google.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org
Cc: jpoimboe@kernel.org, rostedt@goodmis.org, peterz@infradead.org, 
	mingo@redhat.com, tglx@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, mhiramat@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	nathan@kernel.org, llvm@lists.linux.dev, nsc@kernel.org, 
	linux-kbuild@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, ardb@kernel.org, linux-efi@vger.kernel.org, 
	maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, indu.bhagat@oracle.com, jremus@linux.ibm.com, 
	wnliu@google.com, dylanbhatch@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Copy include/linux/kmsan-checks.h to tools/include/linux/kmsan-checks.h
so host tools in tools/ can compile kernel sources using
kmsan_unpoison_memory() without referencing ../../include/linux
directly, and register it in tools/perf/check-headers.sh.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/linux/kmsan-checks.h | 98 ++++++++++++++++++++++++++++++
 tools/perf/check-headers.sh        |  1 +
 2 files changed, 99 insertions(+)
 create mode 100644 tools/include/linux/kmsan-checks.h

diff --git a/tools/include/linux/kmsan-checks.h b/tools/include/linux/kmsan-checks.h
new file mode 100644
index 000000000000..e1082dc40abc
--- /dev/null
+++ b/tools/include/linux/kmsan-checks.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KMSAN checks to be used for one-off annotations in subsystems.
+ *
+ * Copyright (C) 2017-2022 Google LLC
+ * Author: Alexander Potapenko <glider@google.com>
+ *
+ */
+
+#ifndef _LINUX_KMSAN_CHECKS_H
+#define _LINUX_KMSAN_CHECKS_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_KMSAN
+
+/**
+ * kmsan_poison_memory() - Mark the memory range as uninitialized.
+ * @address: address to start with.
+ * @size:    size of buffer to poison.
+ * @flags:   GFP flags for allocations done by this function.
+ *
+ * Until other data is written to this range, KMSAN will treat it as
+ * uninitialized. Error reports for this memory will reference the call site of
+ * kmsan_poison_memory() as origin.
+ */
+void kmsan_poison_memory(const void *address, size_t size, gfp_t flags);
+
+/**
+ * kmsan_unpoison_memory() -  Mark the memory range as initialized.
+ * @address: address to start with.
+ * @size:    size of buffer to unpoison.
+ *
+ * Until other data is written to this range, KMSAN will treat it as
+ * initialized.
+ */
+void kmsan_unpoison_memory(const void *address, size_t size);
+
+/**
+ * kmsan_check_memory() - Check the memory range for being initialized.
+ * @address: address to start with.
+ * @size:    size of buffer to check.
+ *
+ * If any piece of the given range is marked as uninitialized, KMSAN will report
+ * an error.
+ */
+void kmsan_check_memory(const void *address, size_t size);
+
+/**
+ * kmsan_copy_to_user() - Notify KMSAN about a data transfer to userspace.
+ * @to:      destination address in the userspace.
+ * @from:    source address in the kernel.
+ * @to_copy: number of bytes to copy.
+ * @left:    number of bytes not copied.
+ *
+ * If this is a real userspace data transfer, KMSAN checks the bytes that were
+ * actually copied to ensure there was no information leak. If @to belongs to
+ * the kernel space (which is possible for compat syscalls), KMSAN just copies
+ * the metadata.
+ */
+void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
+			size_t left);
+
+/**
+ * kmsan_memmove() - Notify KMSAN about a data copy within kernel.
+ * @to:   destination address in the kernel.
+ * @from: source address in the kernel.
+ * @size: number of bytes to copy.
+ *
+ * Invoked after non-instrumented version (e.g. implemented using assembly
+ * code) of memmove()/memcpy() is called, in order to copy KMSAN's metadata.
+ */
+void kmsan_memmove(void *to, const void *from, size_t to_copy);
+
+#else
+
+static inline void kmsan_poison_memory(const void *address, size_t size,
+				       gfp_t flags)
+{
+}
+static inline void kmsan_unpoison_memory(const void *address, size_t size)
+{
+}
+static inline void kmsan_check_memory(const void *address, size_t size)
+{
+}
+static inline void kmsan_copy_to_user(void __user *to, const void *from,
+				      size_t to_copy, size_t left)
+{
+}
+
+static inline void kmsan_memmove(void *to, const void *from, size_t to_copy)
+{
+}
+
+#endif
+
+#endif /* _LINUX_KMSAN_CHECKS_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 531c0e0e84df..76fc6e20096c 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -28,6 +28,7 @@ declare -a FILES=(
   "include/vdso/unaligned.h"
   "include/linux/gfp_types.h"
   "include/linux/hash.h"
+  "include/linux/kmsan-checks.h"
   "include/linux/list-sort.h"
   "include/uapi/linux/hw_breakpoint.h"
   "arch/x86/include/asm/cpufeatures.h"
-- 
2.56.1.831.g720f3f5937-goog

