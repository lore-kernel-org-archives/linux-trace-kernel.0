Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0195115C13D
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879230; cv=none; b=M+gPMWxsMTQ2WuS6T744Bb0koJ5AuKmYlOuOJTJymbzljZMmD4JotJTK7qZy/F5agNoWDByCdhyivG1gonmrbozzILRO309kvZqnq5z1xyk5LXl8dHowLVij7szYfXVSPhR48q0i7jz3LPcfjWi5+ZnPFOAyK4sv6U0/9f+Vruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879230; c=relaxed/simple;
	bh=WexZUCD5h4+a5hxgo97BOPEenycChGOHMaCru8WGxxY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YvRNwwgLhSyt3laLIBUzAUaVGYHbRSPsEHKrj/zsmHIFO1QQCO187rEefELQN6v3cpjlvVGvLfyBMaYtOqwC3F98wSlp8klUcdro/ngpHvjVz5Dsll+bKPk2AauFJVqW71TuUiGNar94ridS0Rp4kQTRfukIjgOPLyzW1nfwxk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vP5NPEAg; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vP5NPEAg"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-36875698d0dso5556000f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722879227; x=1723484027; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XBDitzAE8pLZLRwW6mAyYcaoga7Kz8ix4GFokYN/MNI=;
        b=vP5NPEAghnceEgNfI+6oidVsvRlAfEnDFrfH5r5IuFvv4d1qxu7rl3wf9JwIQn0mDe
         VNCKgwTakuOwY8uGNPOQbDMO7x54xJmwzv2qDzeDDMm+QkW2cV0wvxK2I7kBedSW7DjM
         FvL5WpLgnlK3Ly+88bEwhGrStHq44FuYfE6rl2axkDefkMm/ZhYuckwMKamPv7jCOqGz
         /qwh3I4UkWyRf5w0VRz0n9e5aov1rDsZ/jEQHZ7bFo1YKHT4I8/PyncowQDuHD2eero6
         3uIvdnF8CkmhAKDc/tS8NI1IHMC+y6DJtJY1jZrC+omyzlXjVXxEX28n7+Q0kdq4rD6v
         VfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722879227; x=1723484027;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XBDitzAE8pLZLRwW6mAyYcaoga7Kz8ix4GFokYN/MNI=;
        b=i87cYZH3N9MKdgog5jNpEzRM7mm1QOjKpDZLlIdJHtpA/9cV9OERMv8eRDRo7QdmrE
         GsI+aWY4PLc0gUMoJv2fD/p4NbfGn5atiP6+Wj0gzZhMmBhMfLu6KooX/e0wN25l6IOe
         /s7khc4iudtZjSsTBgWr5KFLO9Mhe5rtxUIMBSxc5tKkhRwG6wvhUzS0xdIq6zGnvPH+
         Wjui/JwUFzXHpEeNIExqyQK+iEYCAiYXI63FhKT38aTZR5e4P98rAZR+tZg9zwEKtlE3
         vy/PUOD1xkTT3UQ6w2aScT9Rm2FFK5axQxYAPD9YkqHKIiNuMESW6QlKEE6aFPRKhrVu
         SSvA==
X-Forwarded-Encrypted: i=1; AJvYcCWhb0VdL1sDtQy4AkONgmHkT4jOND4E4IoR1po6MC/sr2Jc/FbdV8MRGfhrn3bw3yihQprmpXtDoNL34t+Hy/5pHhTxGMg/z20JCF3sUaiFuY7l
X-Gm-Message-State: AOJu0YxVdzGAj6YszEBcWiXp+WLetPP3zaM7KkaYnJk7x1WxiMOjM2YT
	Qa1bEGJ9m/OD56CqXEAZwhGJ/nzOL4ZUfv0KMzdkUZX78XrCUnapt9bvVqpschIM+JILNQWKApS
	YAqRaYzPJh2xf1Ybl6A==
X-Google-Smtp-Source: AGHT+IEuN6WjQA2wUeMt1Jqzd2f6nhssLJ4LthUXqncoVGKvMWTA/H89U7gvtWs/ZPUsrAAWJzfSXtrYJP8gO9ev
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:adf:dd88:0:b0:367:916e:421f with SMTP
 id ffacd0b85a97d-36bbc187d6cmr16468f8f.11.1722879227386; Mon, 05 Aug 2024
 10:33:47 -0700 (PDT)
Date: Mon,  5 Aug 2024 18:32:29 +0100
In-Reply-To: <20240805173234.3542917-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240805173234.3542917-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805173234.3542917-7-vdonnefort@google.com>
Subject: [RFC PATCH 06/11] KVM: arm64: Add clock support in the nVHE hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev
Cc: kvmarm@lists.linux.dev, will@kernel.org, qperret@google.com, 
	kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

By default, the arm64 host kernel is using the arch timer as a source
for sched_clock. Conveniently, EL2 has access to that same counter,
allowing to generate clock values that are synchronized.

The clock needs nonetheless to be setup with the same slope values as
the kernel. Introducing at the same time trace_clock() which is expected
to be later configured by the hypervisor tracing.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index c838309e4ec4..9105aba0ad00 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -145,4 +145,10 @@ extern unsigned long kvm_nvhe_sym(__icache_flags);
 extern unsigned int kvm_nvhe_sym(kvm_arm_vmid_bits);
 extern unsigned int kvm_nvhe_sym(kvm_host_sve_max_vl);
 
+struct kvm_nvhe_clock_data {
+	u32 mult;
+	u32 shift;
+	u64 epoch_ns;
+	u64 epoch_cyc;
+};
 #endif /* __ARM64_KVM_HYP_H__ */
diff --git a/arch/arm64/kvm/hyp/include/nvhe/clock.h b/arch/arm64/kvm/hyp/include/nvhe/clock.h
new file mode 100644
index 000000000000..7e5c2d2b1886
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/nvhe/clock.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ARM64_KVM_HYP_NVHE_CLOCK_H
+#define __ARM64_KVM_HYP_NVHE_CLOCK_H
+#include <linux/types.h>
+
+#include <asm/kvm_hyp.h>
+
+#ifdef CONFIG_TRACING
+void trace_clock_update(struct kvm_nvhe_clock_data *data);
+u64 trace_clock(void);
+#else
+static inline void trace_clock_update(struct kvm_nvhe_clock_data *data) { }
+static inline u64 trace_clock(void) { return 0; }
+#endif
+#endif
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 782b34b004be..fde8ac1abe7b 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -26,6 +26,7 @@ hyp-obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o
 hyp-obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
 hyp-obj-$(CONFIG_LIST_HARDENED) += list_debug.o
+hyp-obj-$(CONFIG_TRACING) += clock.o
 hyp-obj-y += $(lib-objs)
 
 ##
diff --git a/arch/arm64/kvm/hyp/nvhe/clock.c b/arch/arm64/kvm/hyp/nvhe/clock.c
new file mode 100644
index 000000000000..4ff87e86787c
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/clock.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <nvhe/clock.h>
+
+#include <asm/arch_timer.h>
+#include <asm/div64.h>
+
+static struct kvm_nvhe_clock_data trace_clock_data;
+
+/*
+ * Update without any locks! This is fine because tracing, the sole user of this
+ * clock is ordering the memory and protects from races between read and
+ * updates.
+ */
+void trace_clock_update(struct kvm_nvhe_clock_data *data)
+{
+	trace_clock_data.mult = data->mult;
+	trace_clock_data.shift = data->shift;
+	trace_clock_data.epoch_ns = data->epoch_ns;
+	trace_clock_data.epoch_cyc = data->epoch_cyc;
+}
+
+/*
+ * This clock is relying on host provided slope and epoch values to return
+ * something synchronized with the host. The downside is we can't trust the
+ * output which must not be used for anything else than debugging.
+ */
+u64 trace_clock(void)
+{
+	u64 cyc = __arch_counter_get_cntpct() - trace_clock_data.epoch_cyc;
+	__uint128_t ns;
+
+	/*
+	 * The host kernel can avoid the 64-bits overflow of the multiplication
+	 * by updating the epoch value with a timer (see
+	 * kernel/time/clocksource.c). The hypervisor doesn't have that option,
+	 * so let's do a more costly 128-bits mult here.
+	 */
+	ns = (__uint128_t)cyc * trace_clock_data.mult;
+	ns >>= trace_clock_data.shift;
+
+	return (u64)ns + trace_clock_data.epoch_ns;
+}
-- 
2.46.0.rc2.264.g509ed76dc8-goog

