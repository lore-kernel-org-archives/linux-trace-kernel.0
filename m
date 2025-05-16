Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BA61FCFFB
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 May 2025 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402880; cv=none; b=N7Q5qLzPhQbBccqZTipQde3qpYMmLJeJcEdeHKi78bbgHp4dSKxIyYKycaaUaz4cpfs8cm+Lyn9wPEr/wAZe31CgSpmwSC0e7aUsLVfAtjZsiE7jkjPUYjRmzFoM2BOuOzMt1QFmRqBCYI4JtXERsYfa8oKaY/2X6/w9FuCI0E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402880; c=relaxed/simple;
	bh=0tMb5guI8BRYmCyMxkGr+tJ8tfIUXxTxWXSU8vl1fGc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dbNMBV/OPdJKIqphuCE1v2zZ9x+zOwzBXqPxnbWMmP3r13dtx+meh0OGspvWIarlFxbj9Y4rPHwRMrDQbrfkbpx/KXp0SE018jipNBCYoxMUgWRva9FeMcOosgx3uu5xtdyOOOL2db3sPFF0VXMO1TK5V0/sRUYszt89C/dUPH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BbvdHerz; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BbvdHerz"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a0b6cb5606so1282939f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 May 2025 06:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747402876; x=1748007676; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=asDlKQ9E+la+n26hQE+squU207qOzJQOobxdS9CUsWI=;
        b=BbvdHerz4MQMGaPQnBlEpPYw5W8GYQQLAGE8KhUZxojsdIsxuqjaEt/1+3W0BnbJ57
         /k6THfvFg5uP9YXvtnoqTs64QbdYx5/9IdUIQb5eCqToSPjXG/uscc4i6Qed7PZQ72xs
         hFPriSt8FG8EJSGMEhsGSxg20vg8IT/H7uKH6MhLg2uPl0nvNR0eGMeDz5OQOMG6dU3a
         tazevWr21Aa8oeK3CrZONAic3PbwhfC2qWNbPyQmIqF9QZN+bIlo7c+Rr73wr8Y9F868
         8waAx1oDmQFBolfyTaw2E7Nu6LUKerMvrSWvXcqcqpVYd+P86BdRuQCgfyI47iOGFPtq
         Txpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747402876; x=1748007676;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=asDlKQ9E+la+n26hQE+squU207qOzJQOobxdS9CUsWI=;
        b=ba5KjxUUObhXjmAjxpIbQStUIReaZgqjl4nKHOLych+8KepRDVLY0INCRqUacpc34o
         2Az0+XbYILXSDWlJUTyb5ZfEHpAaQII+MeGAfwsKeDNnWjd+RBi74e6vpoe0+CPQBNQy
         qxVtD9+PwQVgafqnZzdgZ8ts5j2sVamGaQW81EzGVScri+7xJXFv28jWEokkTv7wgunT
         UBrIdRGFva+NlVpkLI9ymCxvCvwniLG/dD6Ntc91XWQRzMJi298NHlOaCgMB8h5ZkSjl
         UG8lWv10Fd/w4JP/Jq14Br2AScfEyjiXogD80w5Jx9eVfFzIPETXRlwuYWUJVfLyd+qf
         Ts/g==
X-Forwarded-Encrypted: i=1; AJvYcCWWeFSVhC8RFqjOE27Mewao5Vsr7rCHqnjIFc3IGPV/tOUVv6OMUChEe+F8Rc2yrnISXczD9nGsfB7bxEvPAUkRteA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyr1bwaud2B7ZtDLf4oEuhfF3C6ZRbapB34Zhvx7C1WhZTAmgY
	JVRMLcql7+fCiHIbe4d1U2Njv6R69o/Y+ruiDEvR/m5b8AOy8nYluSamptS8LB5xZ3TjAWM+qEM
	18XIH3IBAFuBl9/ZLkOn0Lg==
X-Google-Smtp-Source: AGHT+IFei5SuK/XSvd2dO7gTtddX/zauOZ3QOdGjng/CQdo5eah1XB8aGcL5dvfcE+0rYMkjAM2MafjZJsEqb5eh
X-Received: from wmqc20.prod.google.com ([2002:a05:600c:a54:b0:43b:b74b:9350])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:400f:b0:39c:1f04:bb4a with SMTP id ffacd0b85a97d-3a35c808b27mr3503421f8f.10.1747402876636;
 Fri, 16 May 2025 06:41:16 -0700 (PDT)
Date: Fri, 16 May 2025 14:40:29 +0100
In-Reply-To: <20250516134031.661124-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250516134031.661124-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250516134031.661124-24-vdonnefort@google.com>
Subject: [PATCH v5 23/25] KVM: arm64: Add hyp_enter/hyp_exit events to pKVM hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The hyp_enter and hyp_exit events are logged by the hypervisor any time
it is entered and exited.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_hypevents.h b/arch/arm64/include/asm/kvm_hypevents.h
index d6e033c96c52..ce3953bc884a 100644
--- a/arch/arm64/include/asm/kvm_hypevents.h
+++ b/arch/arm64/include/asm/kvm_hypevents.h
@@ -7,4 +7,21 @@
 #include <nvhe/trace.h>
 #endif
 
+HYP_EVENT(hyp_enter,
+	HE_PROTO(void),
+	HE_STRUCT(
+	),
+	HE_ASSIGN(
+	),
+	HE_PRINTK()
+);
+
+HYP_EVENT(hyp_exit,
+	HE_PROTO(void),
+	HE_STRUCT(
+	),
+	HE_ASSIGN(
+	),
+	HE_PRINTK()
+);
 #endif
diff --git a/arch/arm64/kvm/hyp/include/nvhe/arm-smccc.h b/arch/arm64/kvm/hyp/include/nvhe/arm-smccc.h
new file mode 100644
index 000000000000..4b69d33e4f2d
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/nvhe/arm-smccc.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <asm/kvm_hypevents.h>
+
+#include <linux/arm-smccc.h>
+
+#undef arm_smccc_1_1_smc
+#define arm_smccc_1_1_smc(...)					\
+	do {							\
+		trace_hyp_exit();				\
+		__arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__);	\
+		trace_hyp_enter();				\
+	} while (0)
diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 3369dd0c4009..e00931fd194f 100644
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
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 3d36be6d94ca..7d7d0c07a6d4 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -12,6 +12,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_host.h>
 #include <asm/kvm_hyp.h>
+#include <asm/kvm_hypevents.h>
 #include <asm/kvm_mmu.h>
 
 #include <nvhe/ffa.h>
@@ -713,7 +714,9 @@ static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
 
 static void default_host_smc_handler(struct kvm_cpu_context *host_ctxt)
 {
+	trace_hyp_exit();
 	__kvm_hyp_host_forward_smc(host_ctxt);
+	trace_hyp_enter();
 }
 
 static void handle_host_smc(struct kvm_cpu_context *host_ctxt)
@@ -737,6 +740,8 @@ void handle_trap(struct kvm_cpu_context *host_ctxt)
 {
 	u64 esr = read_sysreg_el2(SYS_ESR);
 
+	trace_hyp_enter();
+
 	switch (ESR_ELx_EC(esr)) {
 	case ESR_ELx_EC_HVC64:
 		handle_host_hcall(host_ctxt);
@@ -751,4 +756,6 @@ void handle_trap(struct kvm_cpu_context *host_ctxt)
 	default:
 		BUG();
 	}
+
+	trace_hyp_exit();
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
index c3e196fb8b18..64d1d418df1d 100644
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
 
@@ -205,6 +206,7 @@ asmlinkage void __noreturn __kvm_host_psci_cpu_entry(bool is_cpu_on)
 	struct psci_boot_args *boot_args;
 	struct kvm_cpu_context *host_ctxt;
 
+	trace_hyp_enter();
 	host_ctxt = host_data_ptr(host_ctxt);
 
 	if (is_cpu_on)
@@ -221,6 +223,7 @@ asmlinkage void __noreturn __kvm_host_psci_cpu_entry(bool is_cpu_on)
 	write_sysreg_el1(INIT_SCTLR_EL1_MMU_OFF, SYS_SCTLR);
 	write_sysreg(INIT_PSTATE_EL1, SPSR_EL2);
 
+	trace_hyp_exit();
 	__host_enter(host_ctxt);
 }
 
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 7d2ba6ef0261..bbe035acda89 100644
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
@@ -349,10 +349,13 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 	__debug_switch_to_guest(vcpu);
 
 	do {
+		trace_hyp_exit();
+
 		/* Jump in the fire! */
 		exit_code = __guest_enter(vcpu);
 
 		/* And we're baaack! */
+		trace_hyp_enter();
 	} while (fixup_guest_exit(vcpu, &exit_code));
 
 	__sysreg_save_state_nvhe(guest_ctxt);
-- 
2.49.0.1101.gccaa498523-goog

