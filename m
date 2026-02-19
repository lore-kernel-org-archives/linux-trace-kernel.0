Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6726534252C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771513429; cv=none; b=hY7ubFmTOKfro4xuwdAgBJaQEyUrVjqurFoUimfzz123S7Of4UNd8zhgTaej3CEfkI/+WLKhcaAdxEiQmRpCEf/1ysovqqxexBo0SeujK8HBLvQ8syc1zay36AfipzNIIpcy4OCZIi6aHq9CnIPPA86WqVYyr1qRh9KPbkXERiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771513429; c=relaxed/simple;
	bh=RKbQOpKLzyAI1YMOMrFprtXk9TGxMOVYooJ2mkz5y7A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YEY1tKh+g45oSLsSdZSat3r/nGuLP0lzc7RL/90WPP2/xP4EbVhracTz8mM53oCHXhzPd37w0JQUJZObcWri5HKe16oPQOcFJH9aqUyF04bW4+BC5se4Ckp+ebSfW45EMXVN9LJ2sTJ20QzquCqPyH43zJjgm0BZTDp7uwAasl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SiymNKxL; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SiymNKxL"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4836abfc742so7361045e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 07:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771513427; x=1772118227; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4+WeYCHm29WX1Oz+Ipz9cvL1JwZd5S77G6D55KrRRUU=;
        b=SiymNKxLo3sFOR6Umz0F8Cx+fPdnxBZs3qPwrYVJIyKxyUy8ukDlvNisiSDSBBiCml
         3JfTw92lj9Z1f+fbfNXswp47lRibXb3jFtC8O4u2/SdE/iymsHc146/CMqJamoZ7dob1
         BdAh9ffq7FPrhuW/4j68XgulLy9vp6BDiNaadslcsTo+ULxko+IZcVv/PC2BDfim6vMw
         aXThUqz8H8iZsKu4+hSJAdwYuT2np9VY1AdjHuPtS5pD1CHR860UdKYWBnIsH0vVdzLR
         OsNpZ05mLongWByTSi8PYjB4k276yRynFlq6pOS3Vo4aeYi9eOOHfilAuCSu6bLkXEhF
         MYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771513427; x=1772118227;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+WeYCHm29WX1Oz+Ipz9cvL1JwZd5S77G6D55KrRRUU=;
        b=H+piJQyNkIQC3iv3J0Q/06F0y6r1lVPqGfEy0Sjr2gvxTCyDx8tSDNlOuNcX/bjLEt
         QFhnso9DqDetrgsh6sht+NYjbtGvkWIuV5RTH005Dn8ciXSFN3UZho5mCjaBUF/9Bnwp
         zygslYmLl+FhgWL7x0K7HsODseJV7PzU8ztNHVWTnzTFdSEz9Kzm6maiAVV5BhGuduan
         dZOl+jGMcUOCCGzfCYjdcs3+WXaeRlqswGp66Ej8cTyZ88Xnm++r3cJ+Tb+hYXh85TAt
         qt1Y4hLB7uDb4dYbPpoGMtqzfd2UBZApDDRFSGDwv2+d6DdMPUHz+ppzfOLeTjhFxFvv
         iABA==
X-Forwarded-Encrypted: i=1; AJvYcCXFwidaTeiqKYiUyuxesrEbvWI+nTnVjkkZUSB6jvbHgpghfdJGSoGrrhdLcEI1rn6dfVgJx72gYRzQAlLJE0uMkqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp+SnIkTeoCY8pBQQ/JgaMQdCX1esj6ntvrtDuFlo78fAnL6nB
	42tSKD3iAie0TYpUez7ETY6zTh0nPPBDFgWs+H/n9WUvLnrLZ5Nde24XVFuv39Jt7yUPqNJWNBA
	NgrxBPecKn2VGX+GT/ug9og==
X-Received: from wmep7.prod.google.com ([2002:a05:600c:4307:b0:47f:941a:613d])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e8f:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-4838f15c50dmr167483695e9.18.1771513426701;
 Thu, 19 Feb 2026 07:03:46 -0800 (PST)
Date: Thu, 19 Feb 2026 15:02:57 +0000
In-Reply-To: <20260219150307.14538-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260219150307.14538-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.335.g19a08e0c02-goog
Message-ID: <20260219150307.14538-21-vdonnefort@google.com>
Subject: [PATCH v12 20/30] KVM: arm64: Add clock support to nVHE/pKVM hyp
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
2.53.0.335.g19a08e0c02-goog

