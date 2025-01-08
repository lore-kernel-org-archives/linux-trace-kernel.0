Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34AD1FA15F
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Jan 2025 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736336774; cv=none; b=H8VEupQhwnnQnrHKrEnU2gPANi4UIz6aoDxplwH3g7tw6AMfhE7OhUSdqbkEIuF+Hhf1oSlDNFxUZeoFUPGsest2v/XdOsRXkjcO6euwopWKdjKFlE/jfrj8tYcvVYuzCSi60fXRnItYZxi4YPVrx93J12ShnW4HLRdoaogWKZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736336774; c=relaxed/simple;
	bh=IqKjHCSATEA/BoNvUWZdc966aM4MGuakMg+amVnMkhI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GkLeuYD513LSgRpEAoOja9L2RSLUrzh7T9IQu3YsTMIDY6ZjWfymiRVsx1GQASkrcXLbzul2nm1V1HRD4zrZRsWlO/5m0mB4q1n2qIvr0Qby9mnOlbqZdnVPDNRJcdsz/1mUJc8K2lzpdk9kCBkBvR3b57BqeEtt+YqYGHcEetE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ger075Ij; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ger075Ij"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4361fc2b2d6so53253105e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Jan 2025 03:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736336771; x=1736941571; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lFoDVO2sboF9A596nrExr9aJp/lO52iU9r4yQmzzS9o=;
        b=Ger075Ijdf0pkvH7Ag3/+MzvImAv6awl07cCu3mJAiVBHr5Yg5sq7w9TkLZqo3Q26K
         bRZEVoIj/BtJ9Zqy3uJOyfJJnbc+Sr7RoVgI5tDLNPbIs4mHos29Ne5hTHsA5CCPXlv5
         AjfFb3O1BvLFbpkO9cVeGZpUiuwDOkXFB15YZT03GfxKkNtHFWsTjMcx4WoD6KcX4Yyp
         dMRPay4EcYBtv3RSKiHqjioFDhCzN7yldbuWqidBNITqBc4kNn+5zqaiZPV4Sk8CUB3A
         aiNPNFZckHXhBUqwdSMmZLZoeDnpIyUk1LshBlOLqF2s+xO+PkiGMvVFfjGIhUa/gxU0
         4K/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736336771; x=1736941571;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lFoDVO2sboF9A596nrExr9aJp/lO52iU9r4yQmzzS9o=;
        b=hxJDf10jKdWog9nHB/oDpqk+PetykvIkpW1voZVxop5l+yQbrePEEFWNx8IjVo2L0p
         Wvn9vB5cKKFpE/ZlrVKRqxm3ihYB4ep8MOS1yDIWu+jHaux3qCkbcOMu4GwhsESg5ZTQ
         UjgwwwxlgpaByDT9N+bc4Q/WJimZuZnI5C68/Zo3Zizp5TUf7bH88or91EcnhGJq9k/2
         1W6FY5FbrMuf2Q0soUk9/xFOm8nI6MB+WiPdRKg0tQXkaV4nSZC8SxX1xa//NLz5MMXb
         sW4RxbqmTjFL7/BQV0KiWhZNBnm1cFuO9Q4iY2IpDFbSvEdCyoIxXrhCrccYuxJ7XYj1
         yqrA==
X-Forwarded-Encrypted: i=1; AJvYcCUmv2nfg6VCm+U4ThZY/x9GPUc1HT+PoMFpbmvgrstg/E3r7XK6sT7W8p4fACaCcOSnggl0WNczoRMDbsNYU+TTD/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNfYJOYAQgqcjpgz5ckKnh+k3N6XWUMqV/GYx8zr9ny2wd7Ybr
	kcZeCFOnpGd+bgJZyV3CcOI3K5Q/HvNQMDOGBzzMSUzCWGX7PMyGxc7NiguVK8NKNuHvWKklyRj
	uy/MqlVcEjd7HnRAqSg==
X-Google-Smtp-Source: AGHT+IEjSqSCT6S4wJl/5AvcxkxahzrQOCMS5JRwX1yiSxDeFUJuQmOVNRQv8CYBXied1Fm8HU++hGMx8KCrSkFu
X-Received: from wmsd9.prod.google.com ([2002:a05:600c:3ac9:b0:434:9e7b:42c1])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f09:b0:434:f82b:c5e6 with SMTP id 5b1f17b1804b1-436e266ee5bmr18589025e9.1.1736336771623;
 Wed, 08 Jan 2025 03:46:11 -0800 (PST)
Date: Wed,  8 Jan 2025 11:45:29 +0000
In-Reply-To: <20250108114536.627715-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250108114536.627715-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108114536.627715-6-vdonnefort@google.com>
Subject: [PATCH v2 05/12] KVM: arm64: Add clock support in the nVHE hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

By default, the arm64 host kernel is using the arch timer as a source
for sched_clock. Conveniently, EL2 has access to that same counter,
allowing to generate clock values that are synchronized.

The clock needs nonetheless to be setup with the same slope values as
the kernel. Introducing at the same time trace_clock() which is expected
to be later configured by the hypervisor tracing.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index c838309e4ec4..355bae0056f0 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -144,5 +144,4 @@ extern u64 kvm_nvhe_sym(id_aa64smfr0_el1_sys_val);
 extern unsigned long kvm_nvhe_sym(__icache_flags);
 extern unsigned int kvm_nvhe_sym(kvm_arm_vmid_bits);
 extern unsigned int kvm_nvhe_sym(kvm_host_sve_max_vl);
-
 #endif /* __ARM64_KVM_HYP_H__ */
diff --git a/arch/arm64/kvm/hyp/include/nvhe/clock.h b/arch/arm64/kvm/hyp/include/nvhe/clock.h
new file mode 100644
index 000000000000..2bd05b3b89f9
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/nvhe/clock.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ARM64_KVM_HYP_NVHE_CLOCK_H
+#define __ARM64_KVM_HYP_NVHE_CLOCK_H
+#include <linux/types.h>
+
+#include <asm/kvm_hyp.h>
+
+#ifdef CONFIG_TRACING
+void trace_clock_update(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cyc);
+u64 trace_clock(void);
+#else
+static inline void
+trace_clock_update(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cyc) { }
+static inline u64 trace_clock(void) { return 0; }
+#endif
+#endif
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index b43426a493df..323e992089bd 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -28,6 +28,7 @@ hyp-obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o
 hyp-obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
 hyp-obj-$(CONFIG_LIST_HARDENED) += list_debug.o
+hyp-obj-$(CONFIG_TRACING) += clock.o
 hyp-obj-y += $(lib-objs)
 
 ##
diff --git a/arch/arm64/kvm/hyp/nvhe/clock.c b/arch/arm64/kvm/hyp/nvhe/clock.c
new file mode 100644
index 000000000000..c0d3784386ed
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/clock.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Google LLC
+ * Author: Vincent Donnefort <vdonnefort@google.com>
+ */
+
+#include <nvhe/clock.h>
+
+#include <asm/arch_timer.h>
+#include <asm/div64.h>
+
+static struct clock_data {
+	struct {
+		u32 mult;
+		u32 shift;
+		u64 epoch_ns;
+		u64 epoch_cyc;
+		u64 cyc_overflow64;
+	} data[2];
+	u64 cur;
+} trace_clock_data;
+
+static u64 __clock_mult_uint128(u64 cyc, u32 mult, u32 shift)
+{
+	__uint128_t ns = (__uint128_t)cyc * mult;
+
+	ns >>= shift;
+
+	return (u64)ns;
+}
+
+/* Does not guarantee no reader on the modified bank. */
+void trace_clock_update(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cyc)
+{
+	struct clock_data *clock = &trace_clock_data;
+	u64 bank = clock->cur ^ 1;
+
+	clock->data[bank].mult			= mult;
+	clock->data[bank].shift			= shift;
+	clock->data[bank].epoch_ns		= epoch_ns;
+	clock->data[bank].epoch_cyc		= epoch_cyc;
+	clock->data[bank].cyc_overflow64	= ULONG_MAX / mult;
+
+	smp_store_release(&clock->cur, bank);
+}
+
+/* Using host provided data. Do not use for anything else than debugging. */
+u64 trace_clock(void)
+{
+	struct clock_data *clock = &trace_clock_data;
+	u64 bank = smp_load_acquire(&clock->cur);
+	u64 cyc, ns;
+
+	cyc = __arch_counter_get_cntpct() - clock->data[bank].epoch_cyc;
+
+	if (likely(cyc < clock->data[bank].cyc_overflow64)) {
+		ns = cyc * clock->data[bank].mult;
+		ns >>= clock->data[bank].shift;
+	} else {
+		ns = __clock_mult_uint128(cyc, clock->data[bank].mult,
+					   clock->data[bank].shift);
+	}
+
+	return (u64)ns + clock->data[bank].epoch_ns;
+}
-- 
2.47.1.613.gc27f4b7a9f-goog

