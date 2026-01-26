Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3446033A70B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 10:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424296; cv=none; b=NkrLpC59v0dl5pXP7JdGXDsiMS0o/7KsRsBwCVPQyJSDatOkMmmXzw3YOqqXj46QEu3hI4DcyRwE0hEnyCYEy8+kz+Dcuow/oW2eaOVJY8oj6DcGw7hiddAiiwIRMORT7C9xNrm36PvsUsE1s6ShMLy+Rys2Z7BMItC+aPxqtV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424296; c=relaxed/simple;
	bh=7oIHjiRWSpO5dYLZvgTWL1y/DvoO6BqELjVBzAhC1Ng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fA7KTCEeNuFJvHpXiQnxjEQlQpPsf0I05YAzu5QYc+G47lZ41ujf2F0HjpyS5wV0xsadHtXjgS/xm7qLsaDkpq2J4ZD+yiY9CMZGgLJilPzwYpr8ZSyDA/hLjP927oJCVaKa94UWoUfqfykaz57VIPpIGdpPpJ3GGITRQjR87JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RTJK2lGp; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTJK2lGp"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43284f60a8aso3007189f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 02:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769424291; x=1770029091; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AEqvB1DEPUQRm82b56L0jom52EEhc5ZBQ2L02Xcueqo=;
        b=RTJK2lGpK9ulAW8zJTm11HB8Rp+b3zZP/A97g3uzWIgTjcg8UHsw7sROZJz5lY+YQ5
         sdQgpBYE9qqxhHkNjU1611d6dxcGkpb/SMQgjQF84KChCTOo2QR9I7tZo47C8hDJwvNx
         Vu6Rm4UnM1Sct7hX4CKn6K4uUiPeWMaUro+rHIfZ/XaurIXzY1+zdHmbjsfxPgZ8RAaD
         wrjT+YWGTea3lYuWn+HGUkOgY+N9Oye4KMgB74zQ/dunCYm0kXtS/+smlVVjtJlnwUi6
         76GBYY1xzvImXYL5b9+qBJ23hVHsnHHxtCL9NtL1nwxmmlYO5cjjQ7sItF7Rn4BibTe8
         vM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424291; x=1770029091;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEqvB1DEPUQRm82b56L0jom52EEhc5ZBQ2L02Xcueqo=;
        b=BV1Oc51/H17tVtN5r6mdo5+nuY2J+0tDmPLAIYqX65E1Bsettv3X40P3cjBBEYOneV
         Bh+h4YGTSdBEpUWbtdlaPwMKyKbH+aSwD0lAFQAJAmGeD6RXJ4OpayrSLBV+FETRmhtr
         /pWoAWAX8MZQee83dq8RqWWyVY8fsEmY/e2sK9HFqv1L8BAJ/tLqgaMZF8EE5WfUinMw
         gsR1k8eoO7saq7TUGdRICr/EPeCDiPMi9Xb64plka104u/6dN4R1FbdeMRYCxgWKE5uX
         +j50/Qud5wGwCx4XuGDcj07SX769aqjmzxF+31LMF47VlvHgD1E7JigNBBJD/j4y66lm
         Lhsg==
X-Forwarded-Encrypted: i=1; AJvYcCXUGq+aDKuUDfmnmUVSzs9Dte5FIEKtJREFHpr56Or52hfqLaUlXCEBU/gvHcKtzuvliRmRcnOmDRua+KqdK16afVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA02BLFYrXHLI+o3Px9JA4f9ECgAm1V60olErLXjW8y175mR8M
	Ku5Laomt5YiN4XFsxjsmY2lGXDH2/Nd/1/IrqdWaPs0+JQ3swsarYaETDn8n17tf/6hxyVE/XKn
	awoqQPkOe4xC4DBD/+3eP4w==
X-Received: from wrbcp6.prod.google.com ([2002:a05:6000:4006:b0:435:a3c2:4195])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:64c4:0:b0:435:9f41:d54 with SMTP id ffacd0b85a97d-435ca1aeca7mr6603755f8f.60.1769424291423;
 Mon, 26 Jan 2026 02:44:51 -0800 (PST)
Date: Mon, 26 Jan 2026 10:44:17 +0000
In-Reply-To: <20260126104419.1649811-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126104419.1649811-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126104419.1649811-29-vdonnefort@google.com>
Subject: [PATCH v10 28/30] KVM: arm64: Add hyp_enter/hyp_exit events to
 nVHE/pKVM hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The hyp_enter and hyp_exit events are logged by the hypervisor any time
it is entered and exited.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index ac7f970c7883..58f7fe685150 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -896,6 +896,9 @@ struct kvm_vcpu_arch {
 
 	/* Per-vcpu TLB for VNCR_EL2 -- NULL when !NV */
 	struct vncr_tlb	*vncr_tlb;
+
+	/* Hyp-readable copy of kvm_vcpu::pid */
+	pid_t pid;
 };
 
 /*
diff --git a/arch/arm64/include/asm/kvm_hypevents.h b/arch/arm64/include/asm/kvm_hypevents.h
index d6e033c96c52..221a1dacb2f0 100644
--- a/arch/arm64/include/asm/kvm_hypevents.h
+++ b/arch/arm64/include/asm/kvm_hypevents.h
@@ -7,4 +7,43 @@
 #include <nvhe/trace.h>
 #endif
 
+#ifndef __HYP_ENTER_EXIT_REASON
+#define __HYP_ENTER_EXIT_REASON
+enum hyp_enter_exit_reason {
+	HYP_REASON_SMC,
+	HYP_REASON_HVC,
+	HYP_REASON_PSCI,
+	HYP_REASON_HOST_ABORT,
+	HYP_REASON_GUEST_EXIT,
+	HYP_REASON_ERET_HOST,
+	HYP_REASON_ERET_GUEST,
+	HYP_REASON_UNKNOWN	/* Must be last */
+};
+#endif
+
+HYP_EVENT(hyp_enter,
+	HE_PROTO(struct kvm_cpu_context *host_ctxt, u8 reason),
+	HE_STRUCT(
+		he_field(u8, reason)
+		he_field(pid_t, vcpu)
+	),
+	HE_ASSIGN(
+		__entry->reason = reason;
+		__entry->vcpu = __tracing_get_vcpu_pid(host_ctxt);
+	),
+	HE_PRINTK("reason=%s vcpu=%d", __hyp_enter_exit_reason_str(__entry->reason), __entry->vcpu)
+);
+
+HYP_EVENT(hyp_exit,
+	HE_PROTO(struct kvm_cpu_context *host_ctxt, u8 reason),
+	HE_STRUCT(
+		he_field(u8, reason)
+		he_field(pid_t, vcpu)
+	),
+	HE_ASSIGN(
+		__entry->reason = reason;
+		__entry->vcpu = __tracing_get_vcpu_pid(host_ctxt);
+	),
+	HE_PRINTK("reason=%s vcpu=%d", __hyp_enter_exit_reason_str(__entry->reason), __entry->vcpu)
+);
 #endif
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index f7f222ecaf88..5b7c728c69ca 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -662,6 +662,8 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	if (!cpumask_test_cpu(cpu, vcpu->kvm->arch.supported_cpus))
 		vcpu_set_on_unsupported_cpu(vcpu);
+
+	vcpu->arch.pid = pid_nr(vcpu->pid);
 }
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/hyp/include/nvhe/arm-smccc.h b/arch/arm64/kvm/hyp/include/nvhe/arm-smccc.h
new file mode 100644
index 000000000000..1258bc84477f
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/nvhe/arm-smccc.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ARM64_KVM_HYP_NVHE_ARM_SMCCC_H__
+#define __ARM64_KVM_HYP_NVHE_ARM_SMCCC_H__
+
+#include <asm/kvm_hypevents.h>
+
+#include <linux/arm-smccc.h>
+
+#define hyp_smccc_1_1_smc(...)					\
+	do {							\
+		trace_hyp_exit(NULL, HYP_REASON_SMC);		\
+		arm_smccc_1_1_smc(__VA_ARGS__);			\
+		trace_hyp_enter(NULL, HYP_REASON_SMC);		\
+	} while (0)
+
+#define hyp_smccc_1_2_smc(...)					\
+	do {							\
+		trace_hyp_exit(NULL, HYP_REASON_SMC);		\
+		arm_smccc_1_2_smc(__VA_ARGS__);			\
+		trace_hyp_enter(NULL, HYP_REASON_SMC);		\
+	} while (0)
+
+#endif /* __ARM64_KVM_HYP_NVHE_ARM_SMCCC_H__ */
diff --git a/arch/arm64/kvm/hyp/include/nvhe/trace.h b/arch/arm64/kvm/hyp/include/nvhe/trace.h
index 802a18b77c56..8813ff250f8e 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/trace.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/trace.h
@@ -6,6 +6,18 @@
 
 #include <asm/kvm_hyptrace.h>
 
+static inline pid_t __tracing_get_vcpu_pid(struct kvm_cpu_context *host_ctxt)
+{
+	struct kvm_vcpu *vcpu;
+
+	if (!host_ctxt)
+		host_ctxt = host_data_ptr(host_ctxt);
+
+	vcpu = host_ctxt->__hyp_running_vcpu;
+
+	return vcpu ? vcpu->arch.pid : 0;
+}
+
 #define HE_PROTO(__args...)	__args
 #define HE_ASSIGN(__args...)	__args
 #define HE_STRUCT		RE_STRUCT
diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index f731cc4c3f28..ee5d49e733c0 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -26,10 +26,10 @@
  * the duration and are therefore serialised.
  */
 
-#include <linux/arm-smccc.h>
 #include <linux/arm_ffa.h>
 #include <asm/kvm_pkvm.h>
 
+#include <nvhe/arm-smccc.h>
 #include <nvhe/ffa.h>
 #include <nvhe/mem_protect.h>
 #include <nvhe/memory.h>
@@ -147,7 +147,7 @@ static int ffa_map_hyp_buffers(u64 ffa_page_count)
 {
 	struct arm_smccc_1_2_regs res;
 
-	arm_smccc_1_2_smc(&(struct arm_smccc_1_2_regs) {
+	hyp_smccc_1_2_smc(&(struct arm_smccc_1_2_regs) {
 		.a0 = FFA_FN64_RXTX_MAP,
 		.a1 = hyp_virt_to_phys(hyp_buffers.tx),
 		.a2 = hyp_virt_to_phys(hyp_buffers.rx),
@@ -161,7 +161,7 @@ static int ffa_unmap_hyp_buffers(void)
 {
 	struct arm_smccc_1_2_regs res;
 
-	arm_smccc_1_2_smc(&(struct arm_smccc_1_2_regs) {
+	hyp_smccc_1_2_smc(&(struct arm_smccc_1_2_regs) {
 		.a0 = FFA_RXTX_UNMAP,
 		.a1 = HOST_FFA_ID,
 	}, &res);
@@ -172,7 +172,7 @@ static int ffa_unmap_hyp_buffers(void)
 static void ffa_mem_frag_tx(struct arm_smccc_1_2_regs *res, u32 handle_lo,
 			     u32 handle_hi, u32 fraglen, u32 endpoint_id)
 {
-	arm_smccc_1_2_smc(&(struct arm_smccc_1_2_regs) {
+	hyp_smccc_1_2_smc(&(struct arm_smccc_1_2_regs) {
 		.a0 = FFA_MEM_FRAG_TX,
 		.a1 = handle_lo,
 		.a2 = handle_hi,
@@ -184,7 +184,7 @@ static void ffa_mem_frag_tx(struct arm_smccc_1_2_regs *res, u32 handle_lo,
 static void ffa_mem_frag_rx(struct arm_smccc_1_2_regs *res, u32 handle_lo,
 			     u32 handle_hi, u32 fragoff)
 {
-	arm_smccc_1_2_smc(&(struct arm_smccc_1_2_regs) {
+	hyp_smccc_1_2_smc(&(struct arm_smccc_1_2_regs) {
 		.a0 = FFA_MEM_FRAG_RX,
 		.a1 = handle_lo,
 		.a2 = handle_hi,
@@ -196,7 +196,7 @@ static void ffa_mem_frag_rx(struct arm_smccc_1_2_regs *res, u32 handle_lo,
 static void ffa_mem_xfer(struct arm_smccc_1_2_regs *res, u64 func_id, u32 len,
 			  u32 fraglen)
 {
-	arm_smccc_1_2_smc(&(struct arm_smccc_1_2_regs) {
+	hyp_smccc_1_2_smc(&(struct arm_smccc_1_2_regs) {
 		.a0 = func_id,
 		.a1 = len,
 		.a2 = fraglen,
@@ -206,7 +206,7 @@ static void ffa_mem_xfer(struct arm_smccc_1_2_regs *res, u64 func_id, u32 len,
 static void ffa_mem_reclaim(struct arm_smccc_1_2_regs *res, u32 handle_lo,
 			     u32 handle_hi, u32 flags)
 {
-	arm_smccc_1_2_smc(&(struct arm_smccc_1_2_regs) {
+	hyp_smccc_1_2_smc(&(struct arm_smccc_1_2_regs) {
 		.a0 = FFA_MEM_RECLAIM,
 		.a1 = handle_lo,
 		.a2 = handle_hi,
@@ -216,7 +216,7 @@ static void ffa_mem_reclaim(struct arm_smccc_1_2_regs *res, u32 handle_lo,
 
 static void ffa_retrieve_req(struct arm_smccc_1_2_regs *res, u32 len)
 {
-	arm_smccc_1_2_smc(&(struct arm_smccc_1_2_regs) {
+	hyp_smccc_1_2_smc(&(struct arm_smccc_1_2_regs) {
 		.a0 = FFA_FN64_MEM_RETRIEVE_REQ,
 		.a1 = len,
 		.a2 = len,
@@ -225,7 +225,7 @@ static void ffa_retrieve_req(struct arm_smccc_1_2_regs *res, u32 len)
 
 static void ffa_rx_release(struct arm_smccc_1_2_regs *res)
 {
-	arm_smccc_1_2_smc(&(struct arm_smccc_1_2_regs) {
+	hyp_smccc_1_2_smc(&(struct arm_smccc_1_2_regs) {
 		.a0 = FFA_RX_RELEASE,
 	}, res);
 }
@@ -728,7 +728,7 @@ static int hyp_ffa_post_init(void)
 	size_t min_rxtx_sz;
 	struct arm_smccc_1_2_regs res;
 
-	arm_smccc_1_2_smc(&(struct arm_smccc_1_2_regs){
+	hyp_smccc_1_2_smc(&(struct arm_smccc_1_2_regs){
 		.a0 = FFA_ID_GET,
 	}, &res);
 	if (res.a0 != FFA_SUCCESS)
@@ -737,7 +737,7 @@ static int hyp_ffa_post_init(void)
 	if (res.a2 != HOST_FFA_ID)
 		return -EINVAL;
 
-	arm_smccc_1_2_smc(&(struct arm_smccc_1_2_regs){
+	hyp_smccc_1_2_smc(&(struct arm_smccc_1_2_regs){
 		.a0 = FFA_FEATURES,
 		.a1 = FFA_FN64_RXTX_MAP,
 	}, &res);
@@ -788,7 +788,7 @@ static void do_ffa_version(struct arm_smccc_1_2_regs *res,
 	 * first if TEE supports it.
 	 */
 	if (FFA_MINOR_VERSION(ffa_req_version) < FFA_MINOR_VERSION(hyp_ffa_version)) {
-		arm_smccc_1_2_smc(&(struct arm_smccc_1_2_regs) {
+		hyp_smccc_1_2_smc(&(struct arm_smccc_1_2_regs) {
 			.a0 = FFA_VERSION,
 			.a1 = ffa_req_version,
 		}, res);
@@ -824,7 +824,7 @@ static void do_ffa_part_get(struct arm_smccc_1_2_regs *res,
 		goto out_unlock;
 	}
 
-	arm_smccc_1_2_smc(&(struct arm_smccc_1_2_regs) {
+	hyp_smccc_1_2_smc(&(struct arm_smccc_1_2_regs) {
 		.a0 = FFA_PARTITION_INFO_GET,
 		.a1 = uuid0,
 		.a2 = uuid1,
@@ -939,7 +939,7 @@ int hyp_ffa_init(void *pages)
 	if (kvm_host_psci_config.smccc_version < ARM_SMCCC_VERSION_1_2)
 		return 0;
 
-	arm_smccc_1_2_smc(&(struct arm_smccc_1_2_regs) {
+	hyp_smccc_1_2_smc(&(struct arm_smccc_1_2_regs) {
 		.a0 = FFA_VERSION,
 		.a1 = FFA_VERSION_1_2,
 	}, &res);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 7f5b9807c42d..e1d4a53260ff 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -12,6 +12,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_host.h>
 #include <asm/kvm_hyp.h>
+#include <asm/kvm_hypevents.h>
 #include <asm/kvm_mmu.h>
 
 #include <nvhe/ffa.h>
@@ -137,6 +138,8 @@ static void flush_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 	hyp_vcpu->vcpu.arch.vsesr_el2	= host_vcpu->arch.vsesr_el2;
 
 	hyp_vcpu->vcpu.arch.vgic_cpu.vgic_v3 = host_vcpu->arch.vgic_cpu.vgic_v3;
+
+	hyp_vcpu->vcpu.arch.pid = host_vcpu->arch.pid;
 }
 
 static void sync_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
@@ -728,7 +731,9 @@ static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
 
 static void default_host_smc_handler(struct kvm_cpu_context *host_ctxt)
 {
+	trace_hyp_exit(host_ctxt, HYP_REASON_SMC);
 	__kvm_hyp_host_forward_smc(host_ctxt);
+	trace_hyp_enter(host_ctxt, HYP_REASON_SMC);
 }
 
 static void handle_host_smc(struct kvm_cpu_context *host_ctxt)
@@ -752,18 +757,24 @@ void handle_trap(struct kvm_cpu_context *host_ctxt)
 {
 	u64 esr = read_sysreg_el2(SYS_ESR);
 
+
 	switch (ESR_ELx_EC(esr)) {
 	case ESR_ELx_EC_HVC64:
+		trace_hyp_enter(host_ctxt, HYP_REASON_HVC);
 		handle_host_hcall(host_ctxt);
 		break;
 	case ESR_ELx_EC_SMC64:
+		trace_hyp_enter(host_ctxt, HYP_REASON_SMC);
 		handle_host_smc(host_ctxt);
 		break;
 	case ESR_ELx_EC_IABT_LOW:
 	case ESR_ELx_EC_DABT_LOW:
+		trace_hyp_enter(host_ctxt, HYP_REASON_HOST_ABORT);
 		handle_host_mem_abort(host_ctxt);
 		break;
 	default:
 		BUG();
 	}
+
+	trace_hyp_exit(host_ctxt, HYP_REASON_ERET_HOST);
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
index c3e196fb8b18..ab4c7bddb163 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
@@ -6,11 +6,12 @@
 
 #include <asm/kvm_asm.h>
 #include <asm/kvm_hyp.h>
+#include <asm/kvm_hypevents.h>
 #include <asm/kvm_mmu.h>
-#include <linux/arm-smccc.h>
 #include <linux/kvm_host.h>
 #include <uapi/linux/psci.h>
 
+#include <nvhe/arm-smccc.h>
 #include <nvhe/memory.h>
 #include <nvhe/trap_handler.h>
 
@@ -65,7 +66,7 @@ static unsigned long psci_call(unsigned long fn, unsigned long arg0,
 {
 	struct arm_smccc_res res;
 
-	arm_smccc_1_1_smc(fn, arg0, arg1, arg2, &res);
+	hyp_smccc_1_1_smc(fn, arg0, arg1, arg2, &res);
 	return res.a0;
 }
 
@@ -206,6 +207,7 @@ asmlinkage void __noreturn __kvm_host_psci_cpu_entry(bool is_cpu_on)
 	struct kvm_cpu_context *host_ctxt;
 
 	host_ctxt = host_data_ptr(host_ctxt);
+	trace_hyp_enter(host_ctxt, HYP_REASON_PSCI);
 
 	if (is_cpu_on)
 		boot_args = this_cpu_ptr(&cpu_on_args);
@@ -221,6 +223,7 @@ asmlinkage void __noreturn __kvm_host_psci_cpu_entry(bool is_cpu_on)
 	write_sysreg_el1(INIT_SCTLR_EL1_MMU_OFF, SYS_SCTLR);
 	write_sysreg(INIT_PSTATE_EL1, SPSR_EL2);
 
+	trace_hyp_exit(host_ctxt, HYP_REASON_PSCI);
 	__host_enter(host_ctxt);
 }
 
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 779089e42681..ca60721501d1 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -7,7 +7,6 @@
 #include <hyp/switch.h>
 #include <hyp/sysreg-sr.h>
 
-#include <linux/arm-smccc.h>
 #include <linux/kvm_host.h>
 #include <linux/types.h>
 #include <linux/jump_label.h>
@@ -21,6 +20,7 @@
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_hyp.h>
+#include <asm/kvm_hypevents.h>
 #include <asm/kvm_mmu.h>
 #include <asm/fpsimd.h>
 #include <asm/debug-monitors.h>
@@ -308,10 +308,13 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 	__debug_switch_to_guest(vcpu);
 
 	do {
+		trace_hyp_exit(host_ctxt, HYP_REASON_ERET_GUEST);
+
 		/* Jump in the fire! */
 		exit_code = __guest_enter(vcpu);
 
 		/* And we're baaack! */
+		trace_hyp_enter(host_ctxt, HYP_REASON_GUEST_EXIT);
 	} while (fixup_guest_exit(vcpu, &exit_code));
 
 	__sysreg_save_state_nvhe(guest_ctxt);
diff --git a/arch/arm64/kvm/hyp_trace.c b/arch/arm64/kvm/hyp_trace.c
index 0144cd26703e..1ad6a55ba95c 100644
--- a/arch/arm64/kvm/hyp_trace.c
+++ b/arch/arm64/kvm/hyp_trace.c
@@ -364,8 +364,26 @@ static struct trace_remote_callbacks trace_remote_callbacks = {
 	.enable_event		= hyp_trace_enable_event,
 };
 
+static const char *__hyp_enter_exit_reason_str(u8 reason);
+
 #include <asm/kvm_define_hypevents.h>
 
+static const char *__hyp_enter_exit_reason_str(u8 reason)
+{
+	static const char strs[][12] = {
+		"smc",
+		"hvc",
+		"psci",
+		"host_abort",
+		"guest_exit",
+		"eret_host",
+		"eret_guest",
+		"unknown",
+	};
+
+	return strs[min(reason, HYP_REASON_UNKNOWN)];
+}
+
 static void __init hyp_trace_init_events(void)
 {
 	struct hyp_event_id *hyp_event_id = __hyp_event_ids_start;
-- 
2.52.0.457.g6b5491de43-goog

