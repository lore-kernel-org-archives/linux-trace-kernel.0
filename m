Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF93D31B825
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508353; cv=none; b=annQszCoAMp2Ej7LqqyX+yr6/xTFO5iBIEzOFLiZvpiV0vqPzD5rGsxtY8mdtac9kwAILZ/wY9DVw4uV1gOIqXnEBs09Z2CD0lyJSVfWne6j6QBAwVV9HUfejC2jmBmC9STHLbPTY4SXiNBMqFYjE3r/0ECtxl2qZ2/I84j6Zf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508353; c=relaxed/simple;
	bh=28Jhe9XktHsqCS9rszidABTLhEJhlHDgcMP5XT/FkXc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bqhJ73Z0Xl6VOZpon/WVFUQeSre/nEbnkVGO15NkR3LcCj3zjIEP/JlWhfn7M1SgL37/TyydqnMtzxnvoZHaaihv9rUhic6zvStKXsKoZ/nk7zCHYTg23sgWDOnSsRDfiUzyMI/QdW9QCXdDvIc3Eavrc8udxLXwfVYs090qmk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YQwQWYvB; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YQwQWYvB"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4775e54a70aso5884875e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762508348; x=1763113148; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bl7j0sET84VO4j7rr5Jkc+rd2FvHnQOHrtTlHMuNO70=;
        b=YQwQWYvBlTNzQTaAQFR8JSd17x/Qf8ZOLuFfwy9OQALO70c3cWD9ZSC+X8PdfjTf3U
         fVt3uT7xnHbehXRlo0stxTkUdqYWaSGzVJUy9iFz9WXrupbeE7Hg61BoAMfJFs0SEUMe
         4zEj1He8nnMOyM/GrWG7VmiU9B0HHOXefvItONNHbD/hWS3yU12Ubs5/yLtL1ZtCpveV
         WXfuWAvLmipsffFMTY1lhCY0SPc8JpHCGxLjb3C4NRkm/SUxQ8cPjIrGH88gVL24euFz
         n2Zus19laTRmNTmxlKK9YL8TVLcDz83quKH5b3cAx041VYKsb58PolbKidxB1CXyGSVa
         pjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762508348; x=1763113148;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bl7j0sET84VO4j7rr5Jkc+rd2FvHnQOHrtTlHMuNO70=;
        b=HIPzSHlwV93ir6QcJdppnh9dmD8UFiTwIsrQv1jm6fMqhUN97sBMWDHhHtbt/PqP/K
         Wmp5454a4iLOV1nLZgbgiHQ/Kr/nrvokNe28EcwPHR1RSZ1iMYR1EB0HIefcQvv5PwSZ
         srLZOw7mp+M/Au4px88NhQNDRtQuYrrvX6xl76wuUqDl9u6D8d41N7ZDyxUWS8ca1uqG
         zQ4kkGRzdIE4cuBxzofadKMQAxT5R2+dQqy2tw6cUwzAq+uif6T/nkb5qHK0/Z2/q2E+
         3LzBP5qVqUfr0H5NACWNcu5jUY0I88ls2i3m1gk9kD4T6dwKagnYvKFhYXCiaiZZn6gE
         iknQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcaG6HJrSN1JwpVnS0wzQjGUb8ihP1c9nGyKujFYeu4JTzEbdIVKOedR+BgedfWSggjzRZcZ8dhAJYzkfz6Hxvnhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YysfHxR68Iopxi3MyZ7x6l01MBG/aQMDjyEuAgrk7w51u0nuHG/
	gLq/O/Lr4uuw5iwlirKyyWNN+bAvqgaWnYX4yo4drds0MUFbNq3INnDNHVgKm5JL6iSJ+8nMpy/
	RS+ZRWeUEcXQ1o7CI7meDGw==
X-Google-Smtp-Source: AGHT+IHrNsssU9+I/kWd3+cjJbKNu6Q6ox3bgMutB8pDQpcELjHWSBS28XyXF2v6l22apsxcMSDPQEcpHn/N3FXy
X-Received: from wmlz9.prod.google.com ([2002:a05:600c:2209:b0:477:11b7:17fc])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e88:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-4776bca7c13mr19197365e9.7.1762508348093;
 Fri, 07 Nov 2025 01:39:08 -0800 (PST)
Date: Fri,  7 Nov 2025 09:38:33 +0000
In-Reply-To: <20251107093840.3779150-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107093840.3779150-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107093840.3779150-22-vdonnefort@google.com>
Subject: [PATCH v8 21/28] KVM: arm64: Add tracing capability for the pKVM hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

When running with protected mode, the host has very little knowledge
about what is happening in the hypervisor. Of course this is an
essential feature for security but nonetheless, that piece of code
growing with more responsibilities, we need now a way to debug and
profile it. Tracefs by its reliability, versatility and support for
user-space is the perfect tool.

There's no way the hypervisor could log events directly into the host
tracefs ring-buffers. So instead let's use our own, where the hypervisor
is the writer and the host the reader.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 9da54d4ee49e..ad02dee140d3 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -89,6 +89,10 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___pkvm_vcpu_load,
 	__KVM_HOST_SMCCC_FUNC___pkvm_vcpu_put,
 	__KVM_HOST_SMCCC_FUNC___pkvm_tlb_flush_vmid,
+	__KVM_HOST_SMCCC_FUNC___pkvm_load_tracing,
+	__KVM_HOST_SMCCC_FUNC___pkvm_unload_tracing,
+	__KVM_HOST_SMCCC_FUNC___pkvm_enable_tracing,
+	__KVM_HOST_SMCCC_FUNC___pkvm_swap_reader_tracing,
 };
 
 #define DECLARE_KVM_VHE_SYM(sym)	extern char sym[]
diff --git a/arch/arm64/include/asm/kvm_hyptrace.h b/arch/arm64/include/asm/kvm_hyptrace.h
new file mode 100644
index 000000000000..9c30a479bc36
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_hyptrace.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ARM64_KVM_HYPTRACE_H_
+#define __ARM64_KVM_HYPTRACE_H_
+
+#include <linux/ring_buffer.h>
+
+struct hyp_trace_desc {
+	unsigned long			bpages_backing_start;
+	size_t				bpages_backing_size;
+	struct trace_buffer_desc	trace_buffer_desc;
+
+};
+#endif
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 4f803fd1c99a..580426cdbe77 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -83,4 +83,11 @@ config PTDUMP_STAGE2_DEBUGFS
 
 	  If in doubt, say N.
 
+config PKVM_TRACING
+	bool
+	depends on KVM
+	depends on TRACING
+	select SIMPLE_RING_BUFFER
+	default y
+
 endif # VIRTUALIZATION
diff --git a/arch/arm64/kvm/hyp/include/nvhe/trace.h b/arch/arm64/kvm/hyp/include/nvhe/trace.h
new file mode 100644
index 000000000000..996e90c0974f
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/nvhe/trace.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ARM64_KVM_HYP_NVHE_TRACE_H
+#define __ARM64_KVM_HYP_NVHE_TRACE_H
+#include <asm/kvm_hyptrace.h>
+
+#ifdef CONFIG_PKVM_TRACING
+void *tracing_reserve_entry(unsigned long length);
+void tracing_commit_entry(void);
+
+int __pkvm_load_tracing(unsigned long desc_va, size_t desc_size);
+void __pkvm_unload_tracing(void);
+int __pkvm_enable_tracing(bool enable);
+int __pkvm_swap_reader_tracing(unsigned int cpu);
+#else
+static inline void *tracing_reserve_entry(unsigned long length) { return NULL; }
+static inline void tracing_commit_entry(void) { }
+
+static inline int __pkvm_load_tracing(unsigned long desc_va, size_t desc_size) { return -ENODEV; }
+static inline void __pkvm_unload_tracing(void) { }
+static inline int __pkvm_enable_tracing(bool enable) { return -ENODEV; }
+static inline int __pkvm_swap_reader_tracing(unsigned int cpu) { return -ENODEV; }
+#endif
+#endif
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index f55a9a17d38f..504c3b9caef8 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -29,7 +29,7 @@ hyp-obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
 hyp-obj-y += ../../../kernel/smccc-call.o
 hyp-obj-$(CONFIG_LIST_HARDENED) += list_debug.o
-hyp-obj-$(CONFIG_PKVM_TRACING) += clock.o
+hyp-obj-$(CONFIG_PKVM_TRACING) += clock.o trace.o ../../../../../kernel/trace/simple_ring_buffer.o
 hyp-obj-y += $(lib-objs)
 
 ##
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 29430c031095..6381e50ff531 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -18,6 +18,7 @@
 #include <nvhe/mem_protect.h>
 #include <nvhe/mm.h>
 #include <nvhe/pkvm.h>
+#include <nvhe/trace.h>
 #include <nvhe/trap_handler.h>
 
 DEFINE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
@@ -585,6 +586,35 @@ static void handle___pkvm_teardown_vm(struct kvm_cpu_context *host_ctxt)
 	cpu_reg(host_ctxt, 1) = __pkvm_teardown_vm(handle);
 }
 
+static void handle___pkvm_load_tracing(struct kvm_cpu_context *host_ctxt)
+{
+	 DECLARE_REG(unsigned long, desc_hva, host_ctxt, 1);
+	 DECLARE_REG(size_t, desc_size, host_ctxt, 2);
+
+	 cpu_reg(host_ctxt, 1) = __pkvm_load_tracing(desc_hva, desc_size);
+}
+
+static void handle___pkvm_unload_tracing(struct kvm_cpu_context *host_ctxt)
+{
+	__pkvm_unload_tracing();
+
+	cpu_reg(host_ctxt, 1) = 0;
+}
+
+static void handle___pkvm_enable_tracing(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(bool, enable, host_ctxt, 1);
+
+	cpu_reg(host_ctxt, 1) = __pkvm_enable_tracing(enable);
+}
+
+static void handle___pkvm_swap_reader_tracing(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(unsigned int, cpu, host_ctxt, 1);
+
+	cpu_reg(host_ctxt, 1) = __pkvm_swap_reader_tracing(cpu);
+}
+
 typedef void (*hcall_t)(struct kvm_cpu_context *);
 
 #define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = (hcall_t)handle_##x
@@ -626,6 +656,10 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_vcpu_load),
 	HANDLE_FUNC(__pkvm_vcpu_put),
 	HANDLE_FUNC(__pkvm_tlb_flush_vmid),
+	HANDLE_FUNC(__pkvm_load_tracing),
+	HANDLE_FUNC(__pkvm_unload_tracing),
+	HANDLE_FUNC(__pkvm_enable_tracing),
+	HANDLE_FUNC(__pkvm_swap_reader_tracing),
 };
 
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
diff --git a/arch/arm64/kvm/hyp/nvhe/trace.c b/arch/arm64/kvm/hyp/nvhe/trace.c
new file mode 100644
index 000000000000..def5cbc75722
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/trace.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Google LLC
+ * Author: Vincent Donnefort <vdonnefort@google.com>
+ */
+
+#include <nvhe/clock.h>
+#include <nvhe/mem_protect.h>
+#include <nvhe/mm.h>
+#include <nvhe/trace.h>
+
+#include <asm/percpu.h>
+#include <asm/kvm_mmu.h>
+#include <asm/local.h>
+
+#include <linux/simple_ring_buffer.h>
+
+static DEFINE_PER_CPU(struct simple_rb_per_cpu, __simple_rbs);
+
+static struct hyp_trace_buffer {
+	struct simple_rb_per_cpu __percpu	*simple_rbs;
+	unsigned long				bpages_backing_start;
+	size_t					bpages_backing_size;
+	hyp_spinlock_t				lock;
+} trace_buffer = {
+	.simple_rbs = &__simple_rbs,
+	.lock = __HYP_SPIN_LOCK_UNLOCKED,
+};
+
+static bool hyp_trace_buffer_loaded(struct hyp_trace_buffer *trace_buffer)
+{
+	return trace_buffer->bpages_backing_size > 0;
+}
+
+void *tracing_reserve_entry(unsigned long length)
+{
+	return simple_ring_buffer_reserve(this_cpu_ptr(trace_buffer.simple_rbs), length,
+					  trace_clock());
+}
+
+void tracing_commit_entry(void)
+{
+	simple_ring_buffer_commit(this_cpu_ptr(trace_buffer.simple_rbs));
+}
+
+static int hyp_trace_buffer_load_bpage_backing(struct hyp_trace_buffer *trace_buffer,
+					       struct hyp_trace_desc *desc)
+{
+	unsigned long start = kern_hyp_va(desc->bpages_backing_start);
+	size_t size = desc->bpages_backing_size;
+	int ret;
+
+	if (!PAGE_ALIGNED(start) || !PAGE_ALIGNED(size))
+		return -EINVAL;
+
+	ret = __pkvm_host_donate_hyp(hyp_virt_to_pfn((void *)start), size >> PAGE_SHIFT);
+	if (ret)
+		return ret;
+
+	memset((void *)start, 0, size);
+
+	trace_buffer->bpages_backing_start = start;
+	trace_buffer->bpages_backing_size = size;
+
+	return 0;
+}
+
+static void hyp_trace_buffer_unload_bpage_backing(struct hyp_trace_buffer *trace_buffer)
+{
+	unsigned long start = trace_buffer->bpages_backing_start;
+	size_t size = trace_buffer->bpages_backing_size;
+
+	if (!size)
+		return;
+
+	memset((void *)start, 0, size);
+
+	WARN_ON(__pkvm_hyp_donate_host(hyp_virt_to_pfn(start), size >> PAGE_SHIFT));
+
+	trace_buffer->bpages_backing_start = 0;
+	trace_buffer->bpages_backing_size = 0;
+}
+
+static void *__pin_shared_page(unsigned long kern_va)
+{
+	void *va = kern_hyp_va((void *)kern_va);
+
+	return hyp_pin_shared_mem(va, va + PAGE_SIZE) ? NULL : va;
+}
+
+static void __unpin_shared_page(void *va)
+{
+	hyp_unpin_shared_mem(va, va + PAGE_SIZE);
+}
+
+static void hyp_trace_buffer_unload(struct hyp_trace_buffer *trace_buffer)
+{
+	int cpu;
+
+	hyp_assert_lock_held(&trace_buffer->lock);
+
+	if (!hyp_trace_buffer_loaded(trace_buffer))
+		return;
+
+	for (cpu = 0; cpu < hyp_nr_cpus; cpu++)
+		__simple_ring_buffer_unload(per_cpu_ptr(trace_buffer->simple_rbs, cpu),
+					    __unpin_shared_page);
+
+	hyp_trace_buffer_unload_bpage_backing(trace_buffer);
+}
+
+static int hyp_trace_buffer_load(struct hyp_trace_buffer *trace_buffer,
+				 struct hyp_trace_desc *desc)
+{
+	struct simple_buffer_page *bpages;
+	struct ring_buffer_desc *rb_desc;
+	int ret, cpu;
+
+	hyp_assert_lock_held(&trace_buffer->lock);
+
+	if (hyp_trace_buffer_loaded(trace_buffer))
+		return -EINVAL;
+
+	ret = hyp_trace_buffer_load_bpage_backing(trace_buffer, desc);
+	if (ret)
+		return ret;
+
+	bpages = (struct simple_buffer_page *)trace_buffer->bpages_backing_start;
+	for_each_ring_buffer_desc(rb_desc, cpu, &desc->trace_buffer_desc) {
+		ret = __simple_ring_buffer_init(per_cpu_ptr(trace_buffer->simple_rbs, cpu),
+						bpages, rb_desc, __pin_shared_page,
+						__unpin_shared_page);
+		if (ret)
+			break;
+
+		bpages += rb_desc->nr_page_va;
+	}
+
+	if (ret)
+		hyp_trace_buffer_unload(trace_buffer);
+
+	return ret;
+}
+
+static bool hyp_trace_desc_validate(struct hyp_trace_desc *desc, size_t desc_size)
+{
+	struct simple_buffer_page *bpages = (struct simple_buffer_page *)desc->bpages_backing_start;
+	struct ring_buffer_desc *rb_desc;
+	void *bpages_end, *desc_end;
+	unsigned int cpu;
+
+	desc_end = (void *)desc + desc_size; /* __pkvm_host_donate_hyp validates desc_size */
+
+	bpages_end = (void *)desc->bpages_backing_start + desc->bpages_backing_size;
+	if (bpages_end < (void *)desc->bpages_backing_start)
+		return false;
+
+	for_each_ring_buffer_desc(rb_desc, cpu, &desc->trace_buffer_desc) {
+		/* Can we read nr_page_va? */
+		if ((void *)rb_desc + struct_size(rb_desc, page_va, 0) > desc_end)
+			return false;
+
+		/* Overflow desc? */
+		if ((void *)rb_desc + struct_size(rb_desc, page_va, rb_desc->nr_page_va) > desc_end)
+			return false;
+
+		/* Overflow bpages backing memory? */
+		if ((void *)(bpages + rb_desc->nr_page_va) > bpages_end)
+			return false;
+
+		if (cpu >= hyp_nr_cpus)
+			return false;
+
+		if (cpu != rb_desc->cpu)
+			return false;
+
+		bpages += rb_desc->nr_page_va;
+	}
+
+	return true;
+}
+
+int __pkvm_load_tracing(unsigned long desc_hva, size_t desc_size)
+{
+	struct hyp_trace_desc *desc = (struct hyp_trace_desc *)kern_hyp_va(desc_hva);
+	int ret;
+
+	if (!desc_size || !PAGE_ALIGNED(desc_hva) || !PAGE_ALIGNED(desc_size))
+		return -EINVAL;
+
+	ret = __pkvm_host_donate_hyp(hyp_virt_to_pfn((void *)desc),
+				     desc_size >> PAGE_SHIFT);
+	if (ret)
+		return ret;
+
+	if (!hyp_trace_desc_validate(desc, desc_size))
+		goto err_donate_desc;
+
+	hyp_spin_lock(&trace_buffer.lock);
+
+	ret = hyp_trace_buffer_load(&trace_buffer, desc);
+
+	hyp_spin_unlock(&trace_buffer.lock);
+
+err_donate_desc:
+	WARN_ON(__pkvm_hyp_donate_host(hyp_virt_to_pfn((void *)desc),
+				       desc_size >> PAGE_SHIFT));
+	return ret;
+}
+
+void __pkvm_unload_tracing(void)
+{
+	hyp_spin_lock(&trace_buffer.lock);
+	hyp_trace_buffer_unload(&trace_buffer);
+	hyp_spin_unlock(&trace_buffer.lock);
+}
+
+int __pkvm_enable_tracing(bool enable)
+{
+	int cpu, ret = enable ? -EINVAL : 0;
+
+	hyp_spin_lock(&trace_buffer.lock);
+
+	if (!hyp_trace_buffer_loaded(&trace_buffer))
+		goto unlock;
+
+	for (cpu = 0; cpu < hyp_nr_cpus; cpu++)
+		simple_ring_buffer_enable_tracing(per_cpu_ptr(trace_buffer.simple_rbs, cpu),
+						  enable);
+
+	ret = 0;
+
+unlock:
+	hyp_spin_unlock(&trace_buffer.lock);
+
+	return ret;
+}
+
+int __pkvm_swap_reader_tracing(unsigned int cpu)
+{
+	int ret;
+
+	if (cpu >= hyp_nr_cpus)
+		return -EINVAL;
+
+	hyp_spin_lock(&trace_buffer.lock);
+
+	if (hyp_trace_buffer_loaded(&trace_buffer))
+		ret = simple_ring_buffer_swap_reader_page(
+				per_cpu_ptr(trace_buffer.simple_rbs, cpu));
+	else
+		ret = -ENODEV;
+
+	hyp_spin_unlock(&trace_buffer.lock);
+
+	return ret;
+}
-- 
2.51.2.1041.gc1ab5b90ca-goog

