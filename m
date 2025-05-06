Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD882857DF
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 May 2025 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550156; cv=none; b=PJ6vejFaRZtvU1KacJP5SorS1YHYqPrse9EkXTgNbBMOy1E2/QQ6tcLxzLVcPyGiNHeT2I9WRnARmDgjgodpwz2OLT/9bKAlwUDQOEQgv75IqM2hZLYgRcwqf8dPebbfPs+MiqwPTiKCFOBKHEYPOU2hrbJqteaNLQhXNC1dEyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550156; c=relaxed/simple;
	bh=4kpDY7VA9GH/QiTj9sZ30jiQCPNvr0OCO9mC2vYPvr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LXjLOC2/LYKHHpAd7lCaUVeD7Dz1djFtPFqvcXD67fADdrZLtcXsIQfVAARFmnzqS6JQqO1AK3tP8Ycc2+vigzir2TMtR/H4sTmXj/mDA6Hc1QGzOs83IrmDd2rG3CjmZskz5SIFNRwa4wRywK2dMuvV5z2sRmUmlDd16hKXh+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xGUERMGZ; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xGUERMGZ"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-39143311936so1611280f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 May 2025 09:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746550152; x=1747154952; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W9MwmVHyjbiE0UGKdOkG/nKnXhGzmuj5oAsbld+rHvs=;
        b=xGUERMGZS8GyGvIDuKjaRawe94idfMG7FcdbyQbKxRxrOvkg9p39lmZCKV9RHQO8xx
         482ILhTqL7WqsS5BkSXtN4/1jlfkfhGi1Spi4SVTk4a5M3d1EyWc8/Z4IbarN5BJJ0Ti
         /JabpZVW/SZsXzELt6w6918U3oz63HFI4597INuacFMvOCeirVo6li1XJqzvYVYNj+8/
         N16wz0VfYX8UEN0sR/wi6UyCn/Yd0oMBJPSWWUUU7stifhdn92H+MUBzg+kEOXZHLcZn
         t0F7TeWF0jrueMZnNhgibg7bvI4yQ8WJjwQ8J2we7XQzUky173XD3wAE8LihVzS0PhGB
         Ysyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746550152; x=1747154952;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W9MwmVHyjbiE0UGKdOkG/nKnXhGzmuj5oAsbld+rHvs=;
        b=MFpgbjuyohmWvZJqtIikQSikgljS/O2F+XZGQSKolpetkBs2fc1P8Yr0Ta/VtbUA/X
         yBAEe3kiIP1SGIzXhXqCnyhHOePfF2w0nR1s5K5OZYE0XtTIT3737HbtesFkGgb4K9rA
         uKteD6ROmVnRoD70U9+PfU2vFSnnIO1wLr0EZBL+uRxhekSgFSR3Bjzld07voNM/WmxA
         +ag/HU/sVUmmQ1NOLE7Byhn9Ip4Z13sdb3pw8vmCuAK2aUBCUFMqBvuZGnsvVS0EGQRF
         YN9h7K9wIhglNRkca+H7jJ2KAg58fkxEtafce+lySl/2fSKgTW6YTWmvWY51HjWBjCfu
         uK1g==
X-Forwarded-Encrypted: i=1; AJvYcCVG4rO7KT4Sh/j3G30ZMH1bdTXWVI/mUyw5jf3w0kEVdq7MdpuF4yPrSKHP7wdz8/nG8xER5zIJEV+L/fN6Xbowvfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7SE53ybRcsQ2MD+XyUHV+tdOKMEKOJ4EZxDpgMjYZ4+twHPGp
	DPVoemCzhAYUvWvAA3k162Huh2VL3if9PAYPcNfHAa+zWMeKsQDuoTXSqMcSIfrQmjHaqzq1B17
	KkAuz5xpfAuqH3DKR3Q==
X-Google-Smtp-Source: AGHT+IGiKCS8wdkD9tOBTL+nED1QNv0Onsf2jiW2FFXnwD+M/CDDw5lCerIFtYleGxjGbo8PT5lZ+cBBBAXTu/Zq
X-Received: from wrbfu20.prod.google.com ([2002:a05:6000:25f4:b0:39a:be99:a101])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2af:b0:391:3157:7717 with SMTP id ffacd0b85a97d-3a0b4a2369amr156953f8f.34.1746550152797;
 Tue, 06 May 2025 09:49:12 -0700 (PDT)
Date: Tue,  6 May 2025 17:48:14 +0100
In-Reply-To: <20250506164820.515876-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250506164820.515876-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250506164820.515876-19-vdonnefort@google.com>
Subject: [PATCH v4 18/24] KVM: arm64: Add trace remote for the pKVM hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

When running with KVM protected mode, the hypervisor is able to generate
events into tracefs compatible ring-buffers. Create a trace remote so
the kernel can read those buffers.

This currently doesn't provide any event support which will come later.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index f65eba00c1c9..f7d1d8987cce 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -87,6 +87,7 @@ config PKVM_TRACING
 	bool
 	depends on KVM
 	depends on TRACING
+	select TRACE_REMOTE
 	select SIMPLE_RING_BUFFER
 	default y
 
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 209bc76263f1..fffbbc172bcc 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -29,6 +29,8 @@ kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
 kvm-$(CONFIG_ARM64_PTR_AUTH)  += pauth.o
 kvm-$(CONFIG_PTDUMP_STAGE2_DEBUGFS) += ptdump.o
 
+kvm-$(CONFIG_PKVM_TRACING) += hyp_trace.o
+
 always-y := hyp_constants.h hyp-constants.s
 
 define rule_gen_hyp_constants
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 58e8119f66bd..bb800cf55cfd 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -25,6 +25,7 @@
 
 #define CREATE_TRACE_POINTS
 #include "trace_arm.h"
+#include "hyp_trace.h"
 
 #include <linux/uaccess.h>
 #include <asm/ptrace.h>
@@ -2355,6 +2356,9 @@ static int __init init_subsystems(void)
 
 	kvm_register_perf_callbacks(NULL);
 
+	err = hyp_trace_init();
+	if (err)
+		kvm_err("Failed to initialize Hyp tracing\n");
 out:
 	if (err)
 		hyp_cpu_pm_exit();
diff --git a/arch/arm64/kvm/hyp_trace.c b/arch/arm64/kvm/hyp_trace.c
new file mode 100644
index 000000000000..6a2f02cd6c7f
--- /dev/null
+++ b/arch/arm64/kvm/hyp_trace.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Google LLC
+ * Author: Vincent Donnefort <vdonnefort@google.com>
+ */
+
+#include <linux/trace_remote.h>
+#include <linux/simple_ring_buffer.h>
+
+#include <asm/kvm_host.h>
+#include <asm/kvm_hyptrace.h>
+
+#include "hyp_trace.h"
+
+/* Access to this struct within the trace_remote_callbacks are protected by the trace_remote lock */
+struct hyp_trace_buffer {
+	struct hyp_trace_desc	*desc;
+	size_t			desc_size;
+} trace_buffer;
+
+static int hyp_trace_buffer_alloc_bpages_backing(struct hyp_trace_buffer *trace_buffer, size_t size)
+{
+	int nr_bpages = (PAGE_ALIGN(size) / PAGE_SIZE) + 1;
+	size_t backing_size;
+	void *start;
+
+	backing_size = PAGE_ALIGN(sizeof(struct simple_buffer_page) * nr_bpages *
+				  num_possible_cpus());
+
+	start = alloc_pages_exact(backing_size, GFP_KERNEL_ACCOUNT);
+	if (!start)
+		return -ENOMEM;
+
+	trace_buffer->desc->bpages_backing_start = (unsigned long)start;
+	trace_buffer->desc->bpages_backing_size = backing_size;
+
+	return 0;
+}
+
+static void hyp_trace_buffer_free_bpages_backing(struct hyp_trace_buffer *trace_buffer)
+{
+	free_pages_exact((void *)trace_buffer->desc->bpages_backing_start,
+			 trace_buffer->desc->bpages_backing_size);
+}
+
+static int __load_page(unsigned long va)
+{
+	return kvm_call_hyp_nvhe(__pkvm_host_share_hyp, virt_to_pfn((void *)va), 1);
+}
+
+static void __unload_page(unsigned long va)
+{
+	WARN_ON(kvm_call_hyp_nvhe(__pkvm_host_unshare_hyp, virt_to_pfn((void *)va), 1));
+}
+
+static void hyp_trace_buffer_unload_pages(struct hyp_trace_buffer *trace_buffer, int last_cpu)
+{
+	struct ring_buffer_desc *rb_desc;
+	int cpu, p;
+
+	for_each_ring_buffer_desc(rb_desc, cpu, &trace_buffer->desc->trace_buffer_desc) {
+		if (cpu > last_cpu)
+			break;
+
+		__unload_page(rb_desc->meta_va);
+		for (p = 0; p < rb_desc->nr_page_va; p++)
+			__unload_page(rb_desc->page_va[p]);
+	}
+}
+
+static int hyp_trace_buffer_load_pages(struct hyp_trace_buffer *trace_buffer)
+{
+	struct ring_buffer_desc *rb_desc;
+	int cpu, p, ret = 0;
+
+	for_each_ring_buffer_desc(rb_desc, cpu, &trace_buffer->desc->trace_buffer_desc) {
+		ret = __load_page(rb_desc->meta_va);
+		if (ret)
+			break;
+
+		for (p = 0; p < rb_desc->nr_page_va; p++) {
+			ret = __load_page(rb_desc->page_va[p]);
+			if (ret)
+				break;
+		}
+
+		if (ret) {
+			for (p--; p >= 0; p--)
+				__unload_page(rb_desc->page_va[p]);
+			break;
+		}
+	}
+
+	if (ret)
+		hyp_trace_buffer_unload_pages(trace_buffer, cpu--);
+
+	return ret;
+}
+
+static struct trace_buffer_desc *hyp_trace_load(unsigned long size, void *priv)
+{
+	struct hyp_trace_buffer *trace_buffer = priv;
+	struct hyp_trace_desc *desc;
+	size_t desc_size;
+	int ret;
+
+	if (WARN_ON(trace_buffer->desc))
+		return NULL;
+
+	desc_size = trace_buffer_desc_size(size, num_possible_cpus());
+	if (desc_size == SIZE_MAX)
+		return NULL;
+
+	/*
+	 * The hypervisor will unmap the descriptor from the host to protect the reading. Page
+	 * granularity for the allocation ensures no other useful data will be unmapped.
+	 */
+	desc_size = PAGE_ALIGN(desc_size);
+	desc = (struct hyp_trace_desc *)alloc_pages_exact(desc_size, GFP_KERNEL);
+	if (!desc)
+		return NULL;
+
+	trace_buffer->desc = desc;
+
+	ret = hyp_trace_buffer_alloc_bpages_backing(trace_buffer, size);
+	if (ret)
+		goto err_free_desc;
+
+	ret = trace_remote_alloc_buffer(&desc->trace_buffer_desc, size, cpu_possible_mask);
+	if (ret)
+		goto err_free_backing;
+
+	ret = hyp_trace_buffer_load_pages(trace_buffer);
+	if (ret)
+		goto err_free_buffer;
+
+	ret = kvm_call_hyp_nvhe(__pkvm_load_tracing, (unsigned long)desc, desc_size);
+	if (ret)
+		goto err_unload_pages;
+
+	return &desc->trace_buffer_desc;
+
+err_unload_pages:
+	hyp_trace_buffer_unload_pages(trace_buffer, INT_MAX);
+
+err_free_buffer:
+	trace_remote_free_buffer(&desc->trace_buffer_desc);
+
+err_free_backing:
+	hyp_trace_buffer_free_bpages_backing(trace_buffer);
+
+err_free_desc:
+	free_pages_exact(desc, desc_size);
+	trace_buffer->desc = NULL;
+
+	return NULL;
+}
+
+static void hyp_trace_unload(struct trace_buffer_desc *desc, void *priv)
+{
+	struct hyp_trace_buffer *trace_buffer = priv;
+
+	if (WARN_ON(desc != &trace_buffer->desc->trace_buffer_desc))
+		return;
+
+	kvm_call_hyp_nvhe(__pkvm_unload_tracing);
+	hyp_trace_buffer_unload_pages(trace_buffer, INT_MAX);
+	trace_remote_free_buffer(desc);
+	hyp_trace_buffer_free_bpages_backing(trace_buffer);
+	free_pages_exact(trace_buffer->desc, trace_buffer->desc_size);
+	trace_buffer->desc = NULL;
+}
+
+static int hyp_trace_enable_tracing(bool enable, void *priv)
+{
+	return kvm_call_hyp_nvhe(__pkvm_enable_tracing, enable);
+}
+
+static int hyp_trace_swap_reader_page(unsigned int cpu, void *priv)
+{
+	return kvm_call_hyp_nvhe(__pkvm_swap_reader_tracing, cpu);
+}
+
+static int hyp_trace_reset(unsigned int cpu, void *priv)
+{
+	return 0;
+}
+
+static int hyp_trace_enable_event(unsigned short id, bool enable, void *priv)
+{
+	return 0;
+}
+
+static struct trace_remote_callbacks trace_remote_callbacks = {
+	.load_trace_buffer	= hyp_trace_load,
+	.unload_trace_buffer	= hyp_trace_unload,
+	.enable_tracing		= hyp_trace_enable_tracing,
+	.swap_reader_page	= hyp_trace_swap_reader_page,
+	.reset			= hyp_trace_reset,
+	.enable_event		= hyp_trace_enable_event,
+};
+
+int hyp_trace_init(void)
+{
+	if (!is_protected_kvm_enabled())
+		return 0;
+
+	return trace_remote_register("hypervisor", &trace_remote_callbacks, &trace_buffer, NULL, 0);
+}
diff --git a/arch/arm64/kvm/hyp_trace.h b/arch/arm64/kvm/hyp_trace.h
new file mode 100644
index 000000000000..54d8b1f44ca5
--- /dev/null
+++ b/arch/arm64/kvm/hyp_trace.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ARM64_KVM_HYP_TRACE_H__
+#define __ARM64_KVM_HYP_TRACE_H__
+
+#ifdef CONFIG_PKVM_TRACING
+int hyp_trace_init(void);
+#else
+static inline int hyp_trace_init(void) { return 0; }
+#endif
+#endif
-- 
2.49.0.967.g6a0df3ecc3-goog

