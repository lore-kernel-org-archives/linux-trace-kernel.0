Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55C435E545
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769866191; cv=none; b=G/apHmk06gJAtNVpUnxV9/6Tz6CAVvMoRWr9a+CUxk69XsVFx0u1WRQJoeHz/Yyq/UXklUqIDNsRtmXH/dAnrvRuDp4iSRLQyaAFWgpRmwiSgCv/IAdqq99Prqcfpk0f6IDD2C7UnzDxhHcZgl2F/kK08DajrtSVseHtFvI31+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769866191; c=relaxed/simple;
	bh=IhSG4TGpLvj4KcKLUhA38Fz2DZoMRpgjx7AZN4BBvrI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tzHP8HW5mrxojIYDouEwyz/sNztjBtZ9NWbfyV2ZvTOqge83KosLBzi3fGGXNWg32dOXkrTYsKHK57H1XMxxFdk7TnYKxBK5JS09DnnTZc9yZely54tZXuC4PnMnKYjNotLu+aslhRBSd33haOc5pCFD20zdZfreY2a5gepwoHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mIVDGLZa; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mIVDGLZa"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4806fc58fa5so27440635e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 05:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769866187; x=1770470987; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1KYcw22+QTCEg8xy+ARjFr7wE/gMF/1kiI0/m3iTF5Y=;
        b=mIVDGLZa1kowgYAz5ru2LktcIpy2mSegA1E3CuZlrwLMcL8uMDYXtXWOk7Dp812bsJ
         rAKjdJpPNIp1ZgvMFdOpBOxDd9KElDHq8gkJaZg55yYGfIm1uwzf4L/0lQ099rB3pLSe
         p5Sa24LtLYLL7/5dBW6OCYodvPolBx01jgAKtLHwyoBsa2KPDhTGxH0NVk5pnaJLWDJE
         qAS1uXW5AjQ3t8iP+o5yZ/tHCB64fRBQUWBj2vhioZjb2UpMZsZMDYUzaFb4d7s1xhhQ
         c1Ww1/lFWC2bn6nQUpuHEODVMadV+nRjuXYjx8FDxgwwdFXFhjkG0F6EHU2yx/FqNokG
         U4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769866187; x=1770470987;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1KYcw22+QTCEg8xy+ARjFr7wE/gMF/1kiI0/m3iTF5Y=;
        b=u8SmJXKtyo6nzkzpLOUQ8xt3YhXFJFjYD20DibwsOWBGDSH0RTmEUmzODe4dGhY8g6
         DykU86vJvjUjYT5KjjfUxg8/vpiWwiZdsvfDgCb7pWZCyCrV72NfunYzDITGDfncUYDs
         60bBq2zCOuENLVCx0hfM1pc6kdRL7lDL9UmDLnBrplQq8KlGorQChzbp/rw4rNhKh5Oe
         uC5T+u0BbTr8XOoLe5INHYLw4Wu14BCpI9aNI030SPy5VLXjpL5mGTShyofHmKYProxP
         PgfxKL7L0iqMCQvbgvw5xTYNgUZX5N4+goAufy27fD0rxA9geEmqU7yGG2DDFsDNg5St
         Wzng==
X-Forwarded-Encrypted: i=1; AJvYcCUagx1HhH7I1dzYj3SoX1pFqSaMQUt07NG5tslOI10Je9pGoaIrkPQDNv18XlY/02YJMM6gdecFSkKi0rWX6LJ+KLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS4DLhHTvPqM6xs7P7CiEgn0//pZdmpWWbtYRGeZV/tnvbQ/oP
	Q3lymA1K/eQEkspeRXCxy3AAlY7dWQ/EpCQ1skWgZkBjUwkEGpjz1L2VudWFSyuzfxGmownQJ4n
	RJY3MevCTwlW1EiIlQxLyIA==
X-Received: from wmqo20.prod.google.com ([2002:a05:600c:4fd4:b0:480:4a03:7b63])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3148:b0:47a:935f:618e with SMTP id 5b1f17b1804b1-482db45ce3amr71234105e9.15.1769866187206;
 Sat, 31 Jan 2026 05:29:47 -0800 (PST)
Date: Sat, 31 Jan 2026 13:28:45 +0000
In-Reply-To: <20260131132848.254084-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260131132848.254084-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260131132848.254084-28-vdonnefort@google.com>
Subject: [PATCH v11 27/30] KVM: arm64: Add event support to the nVHE/pKVM hyp
 and trace remote
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Allow the creation of hypervisor and trace remote events with a single
macro HYP_EVENT(). That macro expands in the kernel side to add all
the required declarations (based on REMOTE_EVENT()) as well as in the
hypervisor side to create the trace_<event>() function.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index c5cb2adde7ed..f8fa556ec3e1 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -95,6 +95,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___tracing_swap_reader,
 	__KVM_HOST_SMCCC_FUNC___tracing_update_clock,
 	__KVM_HOST_SMCCC_FUNC___tracing_reset,
+	__KVM_HOST_SMCCC_FUNC___tracing_enable_event,
 };
 
 #define DECLARE_KVM_VHE_SYM(sym)	extern char sym[]
diff --git a/arch/arm64/include/asm/kvm_define_hypevents.h b/arch/arm64/include/asm/kvm_define_hypevents.h
new file mode 100644
index 000000000000..77d6790252a6
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_define_hypevents.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define REMOTE_EVENT_INCLUDE_FILE arch/arm64/include/asm/kvm_hypevents.h
+
+#define REMOTE_EVENT_SECTION "_hyp_events"
+
+#define HE_STRUCT(__args)		__args
+#define HE_PRINTK(__args...)		__args
+#define he_field			re_field
+
+#define HYP_EVENT(__name, __proto, __struct, __assign, __printk) \
+	REMOTE_EVENT(__name, 0, RE_STRUCT(__struct), RE_PRINTK(__printk))
+
+#define HYP_EVENT_MULTI_READ
+#include <trace/define_remote_events.h>
+#undef HYP_EVENT_MULTI_READ
diff --git a/arch/arm64/include/asm/kvm_hypevents.h b/arch/arm64/include/asm/kvm_hypevents.h
new file mode 100644
index 000000000000..d6e033c96c52
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_hypevents.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#if !defined(__ARM64_KVM_HYPEVENTS_H_) || defined(HYP_EVENT_MULTI_READ)
+#define __ARM64_KVM_HYPEVENTS_H_
+
+#ifdef __KVM_NVHE_HYPERVISOR__
+#include <nvhe/trace.h>
+#endif
+
+#endif
diff --git a/arch/arm64/include/asm/kvm_hyptrace.h b/arch/arm64/include/asm/kvm_hyptrace.h
index 9c30a479bc36..de133b735f72 100644
--- a/arch/arm64/include/asm/kvm_hyptrace.h
+++ b/arch/arm64/include/asm/kvm_hyptrace.h
@@ -10,4 +10,17 @@ struct hyp_trace_desc {
 	struct trace_buffer_desc	trace_buffer_desc;
 
 };
+
+struct hyp_event_id {
+	unsigned short	id;
+	atomic_t	enabled;
+};
+
+extern struct remote_event __hyp_events_start[];
+extern struct remote_event __hyp_events_end[];
+
+/* hyp_event section used by the hypervisor */
+extern struct hyp_event_id __hyp_event_ids_start[];
+extern struct hyp_event_id __hyp_event_ids_end[];
+
 #endif
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 211f0e2e55e2..4639f92685cb 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -139,6 +139,10 @@ KVM_NVHE_ALIAS(__hyp_data_start);
 KVM_NVHE_ALIAS(__hyp_data_end);
 KVM_NVHE_ALIAS(__hyp_rodata_start);
 KVM_NVHE_ALIAS(__hyp_rodata_end);
+#ifdef CONFIG_NVHE_EL2_TRACING
+KVM_NVHE_ALIAS(__hyp_event_ids_start);
+KVM_NVHE_ALIAS(__hyp_event_ids_end);
+#endif
 
 /* pKVM static key */
 KVM_NVHE_ALIAS(kvm_protected_mode_initialized);
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index ad6133b89e7a..273a461c6076 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -13,12 +13,23 @@
 	*(__kvm_ex_table)					\
 	__stop___kvm_ex_table = .;
 
+#ifdef CONFIG_NVHE_EL2_TRACING
+#define HYPERVISOR_EVENT_IDS 					\
+	. = ALIGN(PAGE_SIZE);					\
+	__hyp_event_ids_start = .;				\
+	*(HYP_SECTION_NAME(.event_ids))				\
+	__hyp_event_ids_end = .;
+#else
+#define HYPERVISOR_EVENT_IDS
+#endif
+
 #define HYPERVISOR_RODATA_SECTIONS				\
 	HYP_SECTION_NAME(.rodata) : {				\
 		. = ALIGN(PAGE_SIZE);				\
 		__hyp_rodata_start = .;				\
 		*(HYP_SECTION_NAME(.data..ro_after_init))	\
 		*(HYP_SECTION_NAME(.rodata))			\
+		HYPERVISOR_EVENT_IDS				\
 		. = ALIGN(PAGE_SIZE);				\
 		__hyp_rodata_end = .;				\
 	}
@@ -307,6 +318,13 @@ SECTIONS
 
 	HYPERVISOR_DATA_SECTION
 
+#ifdef CONFIG_NVHE_EL2_TRACING
+	.data.hyp_events : {
+		__hyp_events_start = .;
+		*(SORT(_hyp_events.*))
+		__hyp_events_end = .;
+	}
+#endif
 	/*
 	 * Data written with the MMU off but read with the MMU on requires
 	 * cache lines to be invalidated, discarding up to a Cache Writeback
diff --git a/arch/arm64/kvm/hyp/include/nvhe/define_events.h b/arch/arm64/kvm/hyp/include/nvhe/define_events.h
new file mode 100644
index 000000000000..776d4c6cb702
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/nvhe/define_events.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#undef HYP_EVENT
+#define HYP_EVENT(__name, __proto, __struct, __assign, __printk)	\
+	struct hyp_event_id hyp_event_id_##__name			\
+	__section(".hyp.event_ids."#__name) = {				\
+		.enabled = ATOMIC_INIT(0),				\
+	}
+
+#define HYP_EVENT_MULTI_READ
+#include <asm/kvm_hypevents.h>
+#undef HYP_EVENT_MULTI_READ
+
+#undef HYP_EVENT
diff --git a/arch/arm64/kvm/hyp/include/nvhe/trace.h b/arch/arm64/kvm/hyp/include/nvhe/trace.h
index 44912869d184..802a18b77c56 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/trace.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/trace.h
@@ -1,9 +1,36 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 #ifndef __ARM64_KVM_HYP_NVHE_TRACE_H
 #define __ARM64_KVM_HYP_NVHE_TRACE_H
+
+#include <linux/trace_remote_event.h>
+
 #include <asm/kvm_hyptrace.h>
 
+#define HE_PROTO(__args...)	__args
+#define HE_ASSIGN(__args...)	__args
+#define HE_STRUCT		RE_STRUCT
+#define he_field		re_field
+
 #ifdef CONFIG_NVHE_EL2_TRACING
+
+#define HYP_EVENT(__name, __proto, __struct, __assign, __printk)		\
+	REMOTE_EVENT_FORMAT(__name, __struct);					\
+	extern struct hyp_event_id hyp_event_id_##__name;			\
+	static __always_inline void trace_##__name(__proto)			\
+	{									\
+		struct remote_event_format_##__name *__entry;			\
+		size_t length = sizeof(*__entry);				\
+										\
+		if (!atomic_read(&hyp_event_id_##__name.enabled))		\
+			return;							\
+		__entry = tracing_reserve_entry(length);			\
+		if (!__entry)							\
+			return;							\
+		__entry->hdr.id = hyp_event_id_##__name.id;			\
+		__assign							\
+		tracing_commit_entry();						\
+	}
+
 void *tracing_reserve_entry(unsigned long length);
 void tracing_commit_entry(void);
 
@@ -13,9 +40,12 @@ int __tracing_enable(bool enable);
 int __tracing_swap_reader(unsigned int cpu);
 void __tracing_update_clock(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cyc);
 int __tracing_reset(unsigned int cpu);
+int __tracing_enable_event(unsigned short id, bool enable);
 #else
 static inline void *tracing_reserve_entry(unsigned long length) { return NULL; }
 static inline void tracing_commit_entry(void) { }
+#define HYP_EVENT(__name, __proto, __struct, __assign, __printk)      \
+	static inline void trace_##__name(__proto) {}
 
 static inline int __tracing_load(unsigned long desc_va, size_t desc_size) { return -ENODEV; }
 static inline void __tracing_unload(void) { }
@@ -23,5 +53,6 @@ static inline int __tracing_enable(bool enable) { return -ENODEV; }
 static inline int __tracing_swap_reader(unsigned int cpu) { return -ENODEV; }
 static inline void __tracing_update_clock(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cyc) { }
 static inline int __tracing_reset(unsigned int cpu) { return -ENODEV; }
+static inline int __tracing_enable_event(unsigned short id, bool enable)  { return -ENODEV; }
 #endif
 #endif
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index f1840628d2d6..143d55ec7298 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -29,7 +29,7 @@ hyp-obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
 hyp-obj-y += ../../../kernel/smccc-call.o
 hyp-obj-$(CONFIG_LIST_HARDENED) += list_debug.o
-hyp-obj-$(CONFIG_NVHE_EL2_TRACING) += clock.o trace.o
+hyp-obj-$(CONFIG_NVHE_EL2_TRACING) += clock.o trace.o events.o
 hyp-obj-y += $(lib-objs)
 
 # Path to simple_ring_buffer.c
diff --git a/arch/arm64/kvm/hyp/nvhe/events.c b/arch/arm64/kvm/hyp/nvhe/events.c
new file mode 100644
index 000000000000..add9383aadb5
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/events.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Google LLC
+ * Author: Vincent Donnefort <vdonnefort@google.com>
+ */
+
+#include <nvhe/mm.h>
+#include <nvhe/trace.h>
+
+#include <nvhe/define_events.h>
+
+int __tracing_enable_event(unsigned short id, bool enable)
+{
+	struct hyp_event_id *event_id = &__hyp_event_ids_start[id];
+	atomic_t *enabled;
+
+	if (event_id >= __hyp_event_ids_end)
+		return -EINVAL;
+
+	enabled = hyp_fixmap_map(__hyp_pa(&event_id->enabled));
+	atomic_set(enabled, enable);
+	hyp_fixmap_unmap();
+
+	return 0;
+}
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 5acbd451efbd..7f5b9807c42d 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -632,6 +632,14 @@ static void handle___tracing_reset(struct kvm_cpu_context *host_ctxt)
 	cpu_reg(host_ctxt, 1) = __tracing_reset(cpu);
 }
 
+static void handle___tracing_enable_event(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(unsigned short, id, host_ctxt, 1);
+	DECLARE_REG(bool, enable, host_ctxt, 2);
+
+	cpu_reg(host_ctxt, 1) = __tracing_enable_event(id, enable);
+}
+
 typedef void (*hcall_t)(struct kvm_cpu_context *);
 
 #define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = (hcall_t)handle_##x
@@ -679,6 +687,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__tracing_swap_reader),
 	HANDLE_FUNC(__tracing_update_clock),
 	HANDLE_FUNC(__tracing_reset),
+	HANDLE_FUNC(__tracing_enable_event),
 };
 
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
index d724f6d69302..7a02837203d1 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
@@ -16,6 +16,12 @@ SECTIONS {
 	HYP_SECTION(.text)
 	HYP_SECTION(.data..ro_after_init)
 	HYP_SECTION(.rodata)
+#ifdef CONFIG_NVHE_EL2_TRACING
+	. = ALIGN(PAGE_SIZE);
+	BEGIN_HYP_SECTION(.event_ids)
+		*(SORT(.hyp.event_ids.*))
+	END_HYP_SECTION
+#endif
 
 	/*
 	 * .hyp..data..percpu needs to be page aligned to maintain the same
diff --git a/arch/arm64/kvm/hyp_trace.c b/arch/arm64/kvm/hyp_trace.c
index 09bc192e3514..0144cd26703e 100644
--- a/arch/arm64/kvm/hyp_trace.c
+++ b/arch/arm64/kvm/hyp_trace.c
@@ -318,6 +318,25 @@ static int hyp_trace_reset(unsigned int cpu, void *priv)
 
 static int hyp_trace_enable_event(unsigned short id, bool enable, void *priv)
 {
+	struct hyp_event_id *event_id = lm_alias(&__hyp_event_ids_start[id]);
+	struct page *page;
+	atomic_t *enabled;
+	void *map;
+
+	if (is_protected_kvm_enabled())
+		return kvm_call_hyp_nvhe(__tracing_enable_event, id, enable);
+
+	enabled = &event_id->enabled;
+	page = virt_to_page(enabled);
+	map = vmap(&page, 1, VM_MAP, PAGE_KERNEL);
+	if (!map)
+		return -ENOMEM;
+
+	enabled = map + offset_in_page(enabled);
+	atomic_set(enabled, enable);
+
+	vunmap(map);
+
 	return 0;
 }
 
@@ -345,6 +364,19 @@ static struct trace_remote_callbacks trace_remote_callbacks = {
 	.enable_event		= hyp_trace_enable_event,
 };
 
+#include <asm/kvm_define_hypevents.h>
+
+static void __init hyp_trace_init_events(void)
+{
+	struct hyp_event_id *hyp_event_id = __hyp_event_ids_start;
+	struct remote_event *event = __hyp_events_start;
+	int id = 0;
+
+	/* Events on both sides hypervisor are sorted */
+	for (; event < __hyp_events_end; event++, hyp_event_id++, id++)
+		event->id = hyp_event_id->id = id;
+}
+
 int __init kvm_hyp_trace_init(void)
 {
 	int cpu;
@@ -364,5 +396,8 @@ int __init kvm_hyp_trace_init(void)
 	}
 #endif
 
-	return trace_remote_register("hypervisor", &trace_remote_callbacks, &trace_buffer, NULL, 0);
+	hyp_trace_init_events();
+
+	return trace_remote_register("hypervisor", &trace_remote_callbacks, &trace_buffer,
+				     __hyp_events_start, __hyp_events_end - __hyp_events_start);
 }
-- 
2.53.0.rc1.225.gd81095ad13-goog

