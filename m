Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E609185B4A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047061; cv=none; b=c+QNIeOgCaWtsjAJil3NtznuGxHNEY5omLHmxSAyohmGYzQopY5s1xU11MJ7Z76Mr/98umuZI76JrVg0HFrdAepsm7NF2DIxqeNEcV7YfwikJj0maryX96FtKmFguqrJlMmAaV9U24QISr76j1WGrv7gVl0GHbohAYNCD/PsipQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047061; c=relaxed/simple;
	bh=ercdJaF3u/T3mJulQVQrQ+CziDme01YfrcmkWJ0mHnY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JC2zhs4T6IyNqU+1p0IUxtS8zJgWfE6VYfm1j719Vm76eqaR1UOTGspelovrPn6Tk26k6nL2/dMVXdV9j26oNNVml6L2SRluVap94iiyEEuDfDJuja581xgSocxbet+4muBtPh6hPz3PMgqbjQJcFCc7V1d/NKd4XYkQUXCDWqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f997Knzr; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f997Knzr"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d9353e1360so43212397b3.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726047058; x=1726651858; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cRuTUcBMWLC1zDDkXV5OT7FrBuwwjdnt5cv0szV7Wso=;
        b=f997KnzrTcXBczfqXScCq717lQ/XSuGG3CIKXra6+Uj2Ggz1I03Swkn8hPWzS9yAgE
         0/e2qMaO/OGFQKB1lGGKYzeJKKd1Iej5aeZRChiCwMohcdl+U+IW/Omvj8D0K227r2ic
         HFHS+K5J5KjzHZBdKT1SD1UBw8opESt9MMOf35hAe4weDf57QdY1/k5it0RpuCVPbHw1
         +h11u/cXMp9m85fBI3TnBtdXzBBfjx1qXmZv8PhM29NluWBhLaKwBf+PceHydQfRsGd6
         fxHEAAq3EaG1o0v+8iBU6G/tv7/b1lNbduI3YOYAt3szM9dGGHF1h/DYbcwdnaGEbKTX
         V1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726047058; x=1726651858;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRuTUcBMWLC1zDDkXV5OT7FrBuwwjdnt5cv0szV7Wso=;
        b=EYTC8TV/pi8mCL61JwPO0s20UTA0fXlkKJWhcEsznKnWgbFX4tUnwoRo9hRd+mOwu5
         IRGhFSRWN4J0VFkVKPYmLnV18Rmaw032r9w1KYrWEIoq6R/N0Xw/oUSx65iJxk83MZkR
         6mFIQ2xN8OAbwS3atOihwahJQqGFlEZ7aF0B76s3RnAkx54ONoWtFZd53A2baqQec70v
         rOJCklZGM98q8hiyxcw/BMj0WJYLjADzFX3xlZNmrzCQChx8YMMOOrvXs0w5Jeb2+S3b
         DfsVCQ0oiwPvdULikMGc8o18FsdXHMa+hcjtFcC+JKFsXebkqsuaRMWO4JTNq1Npl9dD
         A9jw==
X-Forwarded-Encrypted: i=1; AJvYcCUSypONXG9tcMxQ4ryoOzAN7Xhz0vuzPzgWEebp9JGS4ExUR+pLy9ki1qK/Xd+SwKRhWkSCaN22k8mYSwXsM93BTLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9jh1zVD/hp+9sFNVBFWLkOOKFYrZE/h3LeYy8j80dzMVeSVPs
	4n5Hh7BfjwxRHNnSodq0s2At9XTorvZsh3DUBQkk+CereNe9zvac6mbjWh+NZrOHkUsBYM/4bws
	5uCkYUrMXRGuXe8pETQ==
X-Google-Smtp-Source: AGHT+IHHGSLQ/I9Luq2ns4pz84GK3ZlHzaoiQmxweyshiJGssvJJAZ8RAzx7lLonh1t0WfuSRuHaXXVsKioBQ4E1
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:690c:2c12:b0:66a:764f:e57f with
 SMTP id 00721157ae682-6dba6e28b59mr343267b3.7.1726047058573; Wed, 11 Sep 2024
 02:30:58 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:30:22 +0100
In-Reply-To: <20240911093029.3279154-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240911093029.3279154-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240911093029.3279154-7-vdonnefort@google.com>
Subject: [PATCH 06/13] KVM: arm64: Add clock support in the nVHE hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev
Cc: kvmarm@lists.linux.dev, will@kernel.org, qperret@google.com, 
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
index 000000000000..0d1f74bc2e11
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/clock.c
@@ -0,0 +1,49 @@
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
+	} data[2];
+	u64 cur;
+} trace_clock_data;
+
+/* Does not guarantee no reader on the modified bank. */
+void trace_clock_update(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cyc)
+{
+	struct clock_data *clock = &trace_clock_data;
+	u64 bank = clock->cur ^ 1;
+
+	clock->data[bank].mult		= mult;
+	clock->data[bank].shift		= shift;
+	clock->data[bank].epoch_ns	= epoch_ns;
+	clock->data[bank].epoch_cyc	= epoch_cyc;
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
+	ns = cyc * clock->data[bank].mult;
+	ns >>= clock->data[bank].shift;
+
+	return (u64)ns + clock->data[bank].epoch_ns;
+}
-- 
2.46.0.598.g6f2099f65c-goog

