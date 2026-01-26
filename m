Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6CF3328FA
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424288; cv=none; b=ecPnHN6QJMYcyNhSTXUFJZHmADthUFy6rvMX9tNgsltZqyyQvva5Hv8m7dmsGUiYHRuMWTVCwI45OR5SN/vdcjvlWlwIfxePyZtUELVEn0I1mdpMfBdU9GN7CERPMZBbpryoUbIwIJ8D75DLFyAlGtGfSRlotBVmPu2pcKNixM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424288; c=relaxed/simple;
	bh=nnTr5HL8Y/dQvuipzEumtvYWxP+I8ZzG7VGe+d+aJtA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sTvcx1ZkUsm7wUtTTgwTFYKQHlGYAuQVGGIHyLJt7Y6qhV3pVIV60Gt6XwBP+dxkvz6Kdxv6uu+ew3hbexIp9YDAErO4lC/OFKH/eUvtu2zTZTjH35ItEGUUusdfNJ7vizxUUYO1/O+WMRzdoMSAIXuCfs9Beeg5bd+5qQrW/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o4u26+Iv; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o4u26+Iv"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47edc79ff28so27462335e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 02:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769424284; x=1770029084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+meh5z0/4QwnO6LSl7j279PrriMLEbu2DSgtDyqQa7E=;
        b=o4u26+IvJYimne5MRWzBeW1wCPWjgeHLviOCq4bVz0Wc2chZqWOmc0eJHzcTedZ5Jp
         BrHVvOQ+q4qlxPusKoj+eurUBbLE4h3lWOGl0HeCRTIrWeXwRYt3rUZCF0ZXMC38pO76
         P0pP+GBWTKIB/uPI3am8oBNj942OV/rax52jDYObNmcMfLUvxbwQea2kJfJrN+JhPNke
         4UkcFZk+06IbU+jvQZHZJBd28LBA5lnd0BC8a5b5Scopz2tKq8HbNU3J7idbyzDwrSE/
         xX8ZZW8A7Dl3C7hGs4dV8v4HU/g8069Xhw2ux1QVOmIP80EgLyLNS4ruo3gPBuY9dLiM
         zz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424284; x=1770029084;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+meh5z0/4QwnO6LSl7j279PrriMLEbu2DSgtDyqQa7E=;
        b=tlulCn4YQdPYa8Z59mRdhApunWN/1e/VH7sYBzXIEAvkYPIRpHxS8vFH0aYY6B1sHO
         vIStSWM4hPLlP8/58MdVSvnlZaMkVh2pKnhRiXwic8pT3e7kwBoKVyP27/7pd7dCH50t
         45f6no9ZAewz1r54ATumjKers23TvjYUGSUPZed+4XBilerNC+XHB7w63ubrUokqRWO+
         ksv0hqAS9ObednGQ9AOTPnKodfGRxrsrgVWDF5IHXDYFKDxv8VswOc6XW9fOKCCqhBy7
         Xofc1H1s6row9H9OM7pEPwxR2EeKOh0WxKBPcQ1FDu3Mdu4AsDbBqYvX5oo2xajBM24K
         A/cA==
X-Forwarded-Encrypted: i=1; AJvYcCWAtKa3yVaiGRo505Fh8VJiPeOucbz7e4D0gp5GhDHwrg5MIU0NIiaYUXODxFF2+zH/zc17cR4k5+Ey+3QlSSjUFl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO37A1Jqeudv8eVF4AeItnOJPQguC2mu8FiXPTIO4DL25KTEZ9
	ZEcC7yMYjEckqVEzD8vETQIoPT4Mfdzjjimp6k395HwUeb2IgW13Cj5P4qbqsTBLjdGxHq5uE5v
	0U7DVGm+BvJ9sWCykG3uLuA==
X-Received: from wrbei6.prod.google.com ([2002:a05:6000:4186:b0:435:c02a:cdd4])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f44:0:b0:432:85eb:a3cc with SMTP id ffacd0b85a97d-435ca145617mr7262377f8f.19.1769424284248;
 Mon, 26 Jan 2026 02:44:44 -0800 (PST)
Date: Mon, 26 Jan 2026 10:44:09 +0000
In-Reply-To: <20260126104419.1649811-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126104419.1649811-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126104419.1649811-21-vdonnefort@google.com>
Subject: [PATCH v10 20/30] KVM: arm64: Add clock support to nVHE/pKVM hyp
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
2.52.0.457.g6b5491de43-goog

