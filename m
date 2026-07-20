Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F6C4398E4;
	Mon, 20 Jul 2026 16:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564088; cv=none; b=Ta3ict17tm84CnFzkaQVNLxLi94IDVy3ge7InN3nbVhyDxctgW88VSwpS3mt9XAHOBrvFLWRichinJ/C/lQM+DzUaB7v8EiSm9EeDf1Cnjrt9uRZu9km1chRlOsyDTJQMtZFRORIM/QGHrNwjFmYa8O1QLgJ8+DiUxpgqpuVVuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564088; c=relaxed/simple;
	bh=eWPvosX4xmUOLdHLHklwkbWwVFF7a9X4ZRTfU1WpQp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ANFj38MbPP/7brgOrCnHbhYRN/a0wjddiJ0rxxoAeSr+icg4t3WMuRP65+q1Xz91kLEk/3jNNXsFNQPqbqV87IA4rBk3LmXhv6RY/CA9HQ9n96XPHeXExqcNqHAlN7L6C7kjDu1MXZB8mGz8jomlkQ02BpC+a5XCPxiHvJHK4+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ubj1K9bp; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ubj1K9bp"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784564059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8449deZzWWvUrdWZNQWJEv7MjXt9tctoupcrsbbFYlI=;
	b=Ubj1K9bpySLDrLCCcSATWtPBcRW3bX5FhYlxZxTtKq0EP1f+HF1hq2tPSbuLvnkwzhYnAB
	O6yYYtCZJCOMWcHzkZz8csYz6nqpb6DKtDu3SpHBJxPnRPosC3gm9cSD3y9te8qutzqucM
	73tdWWqn4fFD3lr3KwCFQ6tdX0e2zTU=
From: Fuad Tabba <fuad.tabba@linux.dev>
To: maz@kernel.org,
	oupton@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	alexandru.elisei@arm.com,
	vdonnefort@google.com,
	joey.gouly@arm.com,
	seiden@linux.ibm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	qperret@google.com,
	ardb@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	tabba@google.com,
	fuad.tabba@linux.dev
Subject: [PATCH v1 08/11] KVM: arm64: Move the host hypercall interface to its own header
Date: Mon, 20 Jul 2026 17:13:40 +0100
Message-Id: <20260720161343.1367007-9-fuad.tabba@linux.dev>
In-Reply-To: <20260720161343.1367007-1-fuad.tabba@linux.dev>
References: <20260720161343.1367007-1-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Move the kvm_call_hyp() dispatch macros and pkvm_handle_t out of
kvm_host.h into a new kvm_hcall.h, giving the host<->hyp hypercall
interface a single home that subsequent patches build on to restore
type-checking across the boundary. The only adjustment to the moved
code is the checkpatch-mandated space in "while (0)".

No functional change intended.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/include/asm/kvm_hcall.h | 68 ++++++++++++++++++++++++++++++
 arch/arm64/include/asm/kvm_host.h  | 48 +--------------------
 2 files changed, 69 insertions(+), 47 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_hcall.h

diff --git a/arch/arm64/include/asm/kvm_hcall.h b/arch/arm64/include/asm/kvm_hcall.h
new file mode 100644
index 0000000000000..d925b2c28a3d8
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_hcall.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * The host<->hyp hypercall interface.
+ *
+ * Copyright (C) 2026 Google LLC
+ * Author: Fuad Tabba <fuad.tabba@linux.dev>
+ */
+
+#ifndef __ARM64_KVM_HCALL_H__
+#define __ARM64_KVM_HCALL_H__
+
+#include <linux/arm-smccc.h>
+#include <linux/bug.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+
+#include <asm/barrier.h>
+#include <asm/kvm_asm.h>
+#include <asm/virt.h>
+
+typedef u16 pkvm_handle_t;
+
+#ifndef __KVM_NVHE_HYPERVISOR__
+#define kvm_call_hyp_nvhe(f, ...)					\
+	({								\
+		struct arm_smccc_res res;				\
+									\
+		arm_smccc_1_1_hvc(KVM_HOST_SMCCC_FUNC(f),		\
+				  ##__VA_ARGS__, &res);			\
+		if (WARN_ON(res.a0 != SMCCC_RET_SUCCESS))		\
+			res.a1 = -EOPNOTSUPP;				\
+									\
+		res.a1;							\
+	})
+
+/*
+ * The isb() below is there to guarantee the same behaviour on VHE as on !VHE,
+ * where the eret to EL1 acts as a context synchronization event.
+ */
+#define kvm_call_hyp(f, ...)						\
+	do {								\
+		if (has_vhe()) {					\
+			f(__VA_ARGS__);					\
+			isb();						\
+		} else {						\
+			kvm_call_hyp_nvhe(f, ##__VA_ARGS__);		\
+		}							\
+	} while (0)
+
+#define kvm_call_hyp_ret(f, ...)					\
+	({								\
+		typeof(f(__VA_ARGS__)) ret;				\
+									\
+		if (has_vhe()) {					\
+			ret = f(__VA_ARGS__);				\
+		} else {						\
+			ret = kvm_call_hyp_nvhe(f, ##__VA_ARGS__);	\
+		}							\
+									\
+		ret;							\
+	})
+#else /* __KVM_NVHE_HYPERVISOR__ */
+#define kvm_call_hyp(f, ...) f(__VA_ARGS__)
+#define kvm_call_hyp_ret(f, ...) f(__VA_ARGS__)
+#define kvm_call_hyp_nvhe(f, ...) f(__VA_ARGS__)
+#endif /* __KVM_NVHE_HYPERVISOR__ */
+
+#endif /* __ARM64_KVM_HCALL_H__ */
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index bae2c4f92ef5c..81d359ac7af14 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -27,6 +27,7 @@
 #include <asm/fpsimd.h>
 #include <asm/kvm.h>
 #include <asm/kvm_asm.h>
+#include <asm/kvm_hcall.h>
 #include <asm/vncr_mapping.h>
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
@@ -251,8 +252,6 @@ struct kvm_smccc_features {
 	unsigned long vendor_hyp_bmap_2; /* Function numbers 64-127 */
 };
 
-typedef u16 pkvm_handle_t;
-
 struct kvm_protected_vm {
 	pkvm_handle_t handle;
 	struct kvm_hyp_memcache teardown_mc;
@@ -1252,51 +1251,6 @@ void kvm_arm_resume_guest(struct kvm *kvm);
 
 #define vcpu_has_run_once(vcpu)	(!!READ_ONCE((vcpu)->pid))
 
-#ifndef __KVM_NVHE_HYPERVISOR__
-#define kvm_call_hyp_nvhe(f, ...)					\
-	({								\
-		struct arm_smccc_res res;				\
-									\
-		arm_smccc_1_1_hvc(KVM_HOST_SMCCC_FUNC(f),		\
-				  ##__VA_ARGS__, &res);			\
-		if (WARN_ON(res.a0 != SMCCC_RET_SUCCESS))		\
-			res.a1 = -EOPNOTSUPP;				\
-									\
-		res.a1;							\
-	})
-
-/*
- * The isb() below is there to guarantee the same behaviour on VHE as on !VHE,
- * where the eret to EL1 acts as a context synchronization event.
- */
-#define kvm_call_hyp(f, ...)						\
-	do {								\
-		if (has_vhe()) {					\
-			f(__VA_ARGS__);					\
-			isb();						\
-		} else {						\
-			kvm_call_hyp_nvhe(f, ##__VA_ARGS__);		\
-		}							\
-	} while(0)
-
-#define kvm_call_hyp_ret(f, ...)					\
-	({								\
-		typeof(f(__VA_ARGS__)) ret;				\
-									\
-		if (has_vhe()) {					\
-			ret = f(__VA_ARGS__);				\
-		} else {						\
-			ret = kvm_call_hyp_nvhe(f, ##__VA_ARGS__);	\
-		}							\
-									\
-		ret;							\
-	})
-#else /* __KVM_NVHE_HYPERVISOR__ */
-#define kvm_call_hyp(f, ...) f(__VA_ARGS__)
-#define kvm_call_hyp_ret(f, ...) f(__VA_ARGS__)
-#define kvm_call_hyp_nvhe(f, ...) f(__VA_ARGS__)
-#endif /* __KVM_NVHE_HYPERVISOR__ */
-
 int handle_exit(struct kvm_vcpu *vcpu, int exception_index);
 void handle_exit_early(struct kvm_vcpu *vcpu, int exception_index);
 
-- 
2.39.5

