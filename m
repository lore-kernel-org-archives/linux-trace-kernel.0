Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15ED3EF0C1
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Mar 2026 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073584; cv=none; b=TPpRsioQW9ZgztUO9zNa9/i06thFw8nKf7z0KuPfCvww0JBrDDoSdc75clrVjohHJgR52hF2WoNPWp86puj0mbGNskRn8p5sFAbZZHmGr63ha4uKemXa6fOClvg5f9KTv8FP56h9v8+g5dqyyRFJ/QDsRWJIfu35r8IqgEsghwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073584; c=relaxed/simple;
	bh=h2rVCYiv2RErJ8J/DPs4R6liat0vq1OWoPSAfx6DS2s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DD1KmwmCNK2lciOwq43K7Fpir1TQrExpfVGvvGILUTZnT+5Cu42yUmEWgEaPrD7VWHTTLylhU6JGgHxH537AXKzt7yRR1zY6PHcG/+u7T7aXKwWCHRR65KSsqRmIBIvuJEF/luhafZYBaPE/euQLRr8tyt+YJ2hebqghIZ54kww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qptiIU2D; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qptiIU2D"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-661838c9a33so3570196a12.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Mar 2026 09:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773073581; x=1773678381; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xnACahr8ULD6CcAQo9gjmAw66hUMbPmLgQ2wO/RqDz0=;
        b=qptiIU2Dp+LYVMwH85ToBRqDuarCGGS3PE6QnA3+Es0G5edRT2/5Ib7WeOfdJhngG6
         hjX1Cj+jvbE+2SX8JK1Hg1BEzhv6ZiSN40mDa2OCMqL5V2V+vbp81CyByxLq3FMpz6sE
         XmlPSXOS3Ui1iKhX46OyFa6ugk4YgLbx1lazVNB35A4Dvu2iNIiXKUE3IzGegwZgEkCK
         m6mPUPwuefQECm79TNBFzgTtdhTaOF7IYSr60ON9Ok+wKDcKAV6wVG4dgk9HQUugrVgn
         HJe/bn7wL4PBuGnnuWE36+sgNmTbeQ35pWDkWWsIuzRZbYH82x7qe/OtxpLDihlo206T
         w1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773073581; x=1773678381;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xnACahr8ULD6CcAQo9gjmAw66hUMbPmLgQ2wO/RqDz0=;
        b=CKPGTHjkiBy3Jhl4qfyJO86o3sCumfpGEaqNoXfEmTXYE7e89zMiCWdBVrpihgP8dw
         O3tH0n+l/p6cQE1GwnQw/wTa23kS5L5sSR4eqdDPZ6ghoQBFEqtDGnbCTNKkYYHoQT9j
         nY9DxApgDjpS+zIELlxxVnJ3Fmq8orS4eQ2s+eDuVKZCv4beD0YwVOIYfczlmW+HHDOa
         73yBlhu+TPwjufxeR6MhM1GUC/Ktw0MExMUzMWN9WxHDWWRiv8e58K3oZj/kRKKfSNx9
         yJNqHTtP7RFh5NVbCr/XH5pJD/veR4qAed6aSDli4vBlNEKl20cL1jmO6aXZxV8ZEsb5
         E3Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXE6MLX+cR55FKCd8x7d+B/N70dI+dPJbrdNz0/97QT4dBBQ6zw91xUaf9ojzG3Jl2k1UG/9kqvZ/N9CPENfbys4ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxr+uUzjoBiHevHcWtDo6nfoDhL5vxNIgkp4x8ejPs5nG3h95U
	5yLV34ErH4QWEzOCMY1UEM/MnaTnNxsG10XYCgAfyo2lYlSqbz1nfUGhebEPMtknmDWbd8JoDpk
	iw0tls26rWnvTwVS6GzgLKw==
X-Received: from edbdm18.prod.google.com ([2002:a05:6402:22d2:b0:662:8221:aa6c])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3643:b0:662:b884:d1c with SMTP id 4fb4d7f45d1cf-662b8840e10mr161656a12.10.1773073580808;
 Mon, 09 Mar 2026 09:26:20 -0700 (PDT)
Date: Mon,  9 Mar 2026 16:25:06 +0000
In-Reply-To: <20260309162516.2623589-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260309162516.2623589-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260309162516.2623589-21-vdonnefort@google.com>
Subject: [PATCH v14 20/30] KVM: arm64: Add clock support to nVHE/pKVM hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for supporting tracing from the nVHE hyp, add support to
generate timestamps with a clock fed by the CNTCVT counter. The clock
can be kept in sync with the kernel's by updating the slope values. This
will be done later.

As current we do only create a trace clock, make the whole support
dependent on the upcoming CONFIG_NVHE_EL2_TRACING.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/kvm/hyp/include/nvhe/clock.h b/arch/arm64/kvm/hyp/include/nvhe/clock.h
new file mode 100644
index 000000000000..9f429f5c0664
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
+#ifdef CONFIG_NVHE_EL2_TRACING
+void trace_clock_update(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cyc);
+u64 trace_clock(void);
+#else
+static inline void
+trace_clock_update(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cyc) { }
+static inline u64 trace_clock(void) { return 0; }
+#endif
+#endif
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index a244ec25f8c5..8dc95257c291 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -17,7 +17,7 @@ ccflags-y += -fno-stack-protector	\
 hostprogs := gen-hyprel
 HOST_EXTRACFLAGS += -I$(objtree)/include
 
-lib-objs := clear_page.o copy_page.o memcpy.o memset.o
+lib-objs := clear_page.o copy_page.o memcpy.o memset.o tishift.o
 lib-objs := $(addprefix ../../../lib/, $(lib-objs))
 
 CFLAGS_switch.nvhe.o += -Wno-override-init
@@ -29,6 +29,7 @@ hyp-obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
 hyp-obj-y += ../../../kernel/smccc-call.o
 hyp-obj-$(CONFIG_LIST_HARDENED) += list_debug.o
+hyp-obj-$(CONFIG_NVHE_EL2_TRACING) += clock.o
 hyp-obj-y += $(lib-objs)
 
 ##
diff --git a/arch/arm64/kvm/hyp/nvhe/clock.c b/arch/arm64/kvm/hyp/nvhe/clock.c
new file mode 100644
index 000000000000..32fc4313fe43
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/clock.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Google LLC
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
+/* Use untrusted host data */
+u64 trace_clock(void)
+{
+	struct clock_data *clock = &trace_clock_data;
+	u64 bank = smp_load_acquire(&clock->cur);
+	u64 cyc, ns;
+
+	cyc = __arch_counter_get_cntvct() - clock->data[bank].epoch_cyc;
+
+	if (likely(cyc < clock->data[bank].cyc_overflow64)) {
+		ns = cyc * clock->data[bank].mult;
+		ns >>= clock->data[bank].shift;
+	} else {
+		ns = __clock_mult_uint128(cyc, clock->data[bank].mult,
+					  clock->data[bank].shift);
+	}
+
+	return (u64)ns + clock->data[bank].epoch_ns;
+}
-- 
2.53.0.473.g4a7958ca14-goog

