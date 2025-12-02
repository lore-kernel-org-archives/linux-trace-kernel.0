Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5EF313281
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Dec 2025 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764668215; cv=none; b=OrT8NNl3C7WWxS+iF/uO6oa/fA6JzeF7tytzUAjyRbamAsBN6gpmcn0MfLhHlgGFb6W6LVsM0m1fdE1TgYdEbFO8z9r8xn456nr0TQIVR60lB5ed7kZ0LakCx8tgKSHEtziZmGHSSDYg/fnmAkCqzXEZF4dMLHLoUA8zP2E42ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764668215; c=relaxed/simple;
	bh=A78S6v7BQPnmpLsH0ngbIfRTLjDC1AwOsWlasqsBA5g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XvcguUi73DnTQ49dOo9jIRrHSk/xoGx7IHaEcYZDRAkbNnuy3GJPghFDzE+kNF3Zfto9C3kqpKN3hnu3KE+WiA2UN5IDvCj2pgBI+uc2Hp14xWW/kWOqCHknO5NVCiGolRzI7UNt5R2Uswd/axHfVosxBI2xACeC/4GKgzLvk+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=27zSGu6+; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="27zSGu6+"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477a11d9f89so23236275e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Dec 2025 01:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764668211; x=1765273011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NElJUUivXewr9qr1zG4n3pnbZgrgkOxER+Z6nnzxCU0=;
        b=27zSGu6+BgHgkO9ZhxSPHWJuPetJ4/UO0KKtbEcoa+u7KWD7OnEG9eSR+UmTzHWAhm
         KLXwrYDVtQaNfbihUHcKDx0ySyOgAi3+WOH8nwZziELcXlS/64B35GgGclLVyqMFpJRV
         LDY9GngnwdA0MioyFsUuvPhpGojTvvnMPQEO/0x3nGVlXeqcrI7zC8J+9U0vvyqHVyKM
         TAr+BRXjF0jyndN2LyM0BU0M8PgDwluNYLCGgsvwwg882EtC2fT9sP+9rQBAlxMV7TYM
         8HwXNvA/8A/iFWvzihG/NVZgbAXY2Bud3anT9Gx+vMDG8dlKpZVopcpsLuO+ygvhP3V0
         Nikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764668211; x=1765273011;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NElJUUivXewr9qr1zG4n3pnbZgrgkOxER+Z6nnzxCU0=;
        b=c2O1FiORehvcOoYbabM+2AeSJSAeHsvvyMfftK4pZ2rS/j6jyajE062FSAVfhUfyUg
         0guhlc8JNJWwkT9n75mkvTU3zJ4N+cVyNszFMhdyieTgkHM6Ru7jAkJvIY4AENTBvEbI
         r6spjcTapauxtDyquhm0nxzqcsBQEOJ2f9dVi1ZNB32+qNW4NLzbSx36Yj7VD5C+yM5O
         f3ulQzJCv6zg1kdvdjN9vTIwo+YqKBzVAhrkbOE5IsXjEbySUJiOIRuRZj1PVd+3KLXK
         KfBxWeQWnFhXCx+58bE/UyPAfbqtDGlwaOWgka7ul4t9Mg3cCq/47WHLEXJ+bVJvNVSN
         hl0g==
X-Forwarded-Encrypted: i=1; AJvYcCXToLAbFGIBoR459I7iMW+88LGhqFmYV+MWAsRzKmFHe42zIm6ucjsBycuVrCDR2YrpG5RgF9voeoG/GHj9/0BKDHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoXtAQKJ4jwtylp9nxI9bevn6Lo+zj6jA/xtxacGDD5eyqsVCp
	hNOsLmhyeaduJRvoJD7Le14XULzmaeyhEFZLf1MXb0uVn7lleltIEhz7brdsCP4F+NlQsLRxGPB
	lkH2xFHxzjN9qlz18ltkTFg==
X-Google-Smtp-Source: AGHT+IGBBJ9ZKyVEXt6XGTNMrn5BtibPGIAljJk4FuV2zHz3VorRA+b/HT0CYv4OlfvdksSWqdGiSdjCCrfe5NcS
X-Received: from wmdd21.prod.google.com ([2002:a05:600c:a215:b0:477:14b8:19f6])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:45cf:b0:477:8ba7:fe0a with SMTP id 5b1f17b1804b1-477c01c001bmr470590905e9.24.1764668210877;
 Tue, 02 Dec 2025 01:36:50 -0800 (PST)
Date: Tue,  2 Dec 2025 09:36:13 +0000
In-Reply-To: <20251202093623.2337860-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202093623.2337860-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251202093623.2337860-21-vdonnefort@google.com>
Subject: [PATCH v9 20/30] KVM: arm64: Add clock support to nVHE/pKVM hyp
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
dependant on the upcoming CONFIG_NVHE_EL2_TRACING.

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
2.52.0.107.ga0afd4fd5b-goog

