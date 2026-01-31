Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A793542E7
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769866184; cv=none; b=rzg/dKzFnAe6J2aT1h+y/2LV0/BBdZF5KvE4GPw3kxieS6VXByomr2uAVnwO7Pg/wiNm/BRfcRRpkdCEKgXEaSU0JSTM35Yf6fACyX3feqxNesUc2xfrnfW4fVs5RczlUsGt0nyBv4ga2Um3xqP1ISLbo83IZj7UrFqVHwiOouM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769866184; c=relaxed/simple;
	bh=ccyYmnlDu9EEGW1I0k4h1tVPmLHzSWBhCL7g2xyCtiY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iA9Dlm61sJRZ+jWK67m7sMREvii/WbTd07u6YQGpJrUDSSlTSpT2uaGDBh1mlK8BlOYVhZ+nmBgr8JYT0eusTj56b5hkNrRNXn76yZM27H0L487gbkJQo+A47FQxydfie3T+wQ9JcPrJlnG469xU7Gh8Ft+3y9VjuPZC6F0b0gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4UPHmMVc; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4UPHmMVc"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47ee056e5cfso27160185e9.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 05:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769866181; x=1770470981; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7nEWGCUeag+PoVLv9JhhY/ni1DDp7IYQQDqy/MX6oMM=;
        b=4UPHmMVc+H2M6nyI9DFV8lRk+ag7YaZj90fT291AYHzfnqMn5NjmMnQnhSfV+qmey4
         vhjTsELMKZti6EdhiX/hI42HOo+v2LZOtt807Q2QKPunB6Xax+q9Mk4J1OLYB4kkic3u
         LKT6k+CsNxZ/Q84QwBfNIjtwxu5A5LCQWiqPAJr6AUDPZFUV7YEC4FMG9bXRU88wys1X
         qMWduslGyWBcHrdpN5+oNEFibgqJedCrHJLh6ET5hZj2Bc3WzrnkQDB/x//duAcEE6BU
         KFdmisoHJ5AvjHvRU1yn/Crna893AVklVrfoRyCdziJtyJIf34nSgOAD4jCqK4FKpgV8
         2/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769866181; x=1770470981;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nEWGCUeag+PoVLv9JhhY/ni1DDp7IYQQDqy/MX6oMM=;
        b=RLspxnvzktRZTBAx70dXPlRBNPs7ee3A9OfwJ9IOelcoLoAkAmmueulyif5+OlbYXF
         ica0PusR8/47MllBKZX+g8an6DOFYBZYkeyDEPkLwcGBP5VRRW5/8GdsWZe1axhog1oI
         UNGpr6MsmyAtZM5X4SrTsBjm2I2zQIZSOyQJSiUr4bo/HBs9s4U4IB7y0fyBBp0/dVKV
         Af3k518w4jnAcmBrhYUpxNQrAtrdmpny8z+AHajd/lJyHual0Y8uvdUGuMOTlQxgZJ47
         cQPunPTf6a8RYb0EQWgS7JOt/HnQkDgez4Jb8OXLAQ836X5lfU7cNbFwohSFxIv7ZOfo
         +Hlg==
X-Forwarded-Encrypted: i=1; AJvYcCUlBZx0kSzh6PcBo1lI0y/zOKUpn12iNnWa8oq/8nQdsggVdV92r/KEkBM8oPhCv+IXd1w4MO40NDZdCe+F1lgXNpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyoUMyOGbTpwdShE2pBgrssqhUZvIgXsHHgCC7s7N3SYYU48p3
	nLY9rl1KKgiI9JBWYiwDsBHKRjkYwV+WBPbzvG4ry++LX5rOxD05ckiVpK/SjZI6cR5lFvCrxfe
	1iUsvEo/cMtJU3nBTYCESAQ==
X-Received: from wmqo22.prod.google.com ([2002:a05:600c:4fd6:b0:482:edb8:8b96])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8a17:20b0:480:25ae:9993 with SMTP id 5b1f17b1804b1-482db47ce2emr55130925e9.20.1769866181059;
 Sat, 31 Jan 2026 05:29:41 -0800 (PST)
Date: Sat, 31 Jan 2026 13:28:39 +0000
In-Reply-To: <20260131132848.254084-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260131132848.254084-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260131132848.254084-22-vdonnefort@google.com>
Subject: [PATCH v11 21/30] KVM: arm64: Initialise hyp_nr_cpus for nVHE hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Knowing the number of CPUs is necessary for determining the boundaries
of per-cpu variables, which will be used for upcoming hypervisor
tracing. hyp_nr_cpus which stores this value, is only initialised for
the pKVM hypervisor. Make it accessible for the nVHE hypervisor as well.

With the kernel now responsible for initialising hyp_nr_cpus, the
nr_cpus parameter is no longer needed in __pkvm_init.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 76ce2b94bd97..4bf63025061e 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -129,8 +129,7 @@ void __noreturn __hyp_do_panic(struct kvm_cpu_context *host_ctxt, u64 spsr,
 #ifdef __KVM_NVHE_HYPERVISOR__
 void __pkvm_init_switch_pgd(phys_addr_t pgd, unsigned long sp,
 		void (*fn)(void));
-int __pkvm_init(phys_addr_t phys, unsigned long size, unsigned long nr_cpus,
-		unsigned long *per_cpu_base, u32 hyp_va_bits);
+int __pkvm_init(phys_addr_t phys, unsigned long size, unsigned long *per_cpu_base, u32 hyp_va_bits);
 void __noreturn __host_enter(struct kvm_cpu_context *host_ctxt);
 #endif
 
@@ -147,5 +146,6 @@ extern u64 kvm_nvhe_sym(id_aa64smfr0_el1_sys_val);
 extern unsigned long kvm_nvhe_sym(__icache_flags);
 extern unsigned int kvm_nvhe_sym(kvm_arm_vmid_bits);
 extern unsigned int kvm_nvhe_sym(kvm_host_sve_max_vl);
+extern unsigned long kvm_nvhe_sym(hyp_nr_cpus);
 
 #endif /* __ARM64_KVM_HYP_H__ */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 620a465248d1..be1fd6c5f74c 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -35,6 +35,7 @@
 #include <asm/kvm_arm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
+#include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_nested.h>
 #include <asm/kvm_pkvm.h>
@@ -2411,7 +2412,7 @@ static int __init do_pkvm_init(u32 hyp_va_bits)
 	preempt_disable();
 	cpu_hyp_init_context();
 	ret = kvm_call_hyp_nvhe(__pkvm_init, hyp_mem_base, hyp_mem_size,
-				num_possible_cpus(), kern_hyp_va(per_cpu_base),
+				kern_hyp_va(per_cpu_base),
 				hyp_va_bits);
 	cpu_hyp_init_features();
 
@@ -2620,6 +2621,8 @@ static int __init init_hyp_mode(void)
 		kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] = (unsigned long)page_addr;
 	}
 
+	kvm_nvhe_sym(hyp_nr_cpus) = num_possible_cpus();
+
 	/*
 	 * Map the Hyp-code called directly from the host
 	 */
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 5f9d56754e39..f8a7b8c04c49 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -30,8 +30,6 @@ enum pkvm_component_id {
 	PKVM_ID_FFA,
 };
 
-extern unsigned long hyp_nr_cpus;
-
 int __pkvm_prot_finalize(void);
 int __pkvm_host_share_hyp(u64 pfn);
 int __pkvm_host_unshare_hyp(u64 pfn);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 8ffbbce5e2ed..5559b622ea57 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -486,17 +486,15 @@ static void handle___pkvm_init(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(phys_addr_t, phys, host_ctxt, 1);
 	DECLARE_REG(unsigned long, size, host_ctxt, 2);
-	DECLARE_REG(unsigned long, nr_cpus, host_ctxt, 3);
-	DECLARE_REG(unsigned long *, per_cpu_base, host_ctxt, 4);
-	DECLARE_REG(u32, hyp_va_bits, host_ctxt, 5);
+	DECLARE_REG(unsigned long *, per_cpu_base, host_ctxt, 3);
+	DECLARE_REG(u32, hyp_va_bits, host_ctxt, 4);
 
 	/*
 	 * __pkvm_init() will return only if an error occurred, otherwise it
 	 * will tail-call in __pkvm_init_finalise() which will have to deal
 	 * with the host context directly.
 	 */
-	cpu_reg(host_ctxt, 1) = __pkvm_init(phys, size, nr_cpus, per_cpu_base,
-					    hyp_va_bits);
+	cpu_reg(host_ctxt, 1) = __pkvm_init(phys, size, per_cpu_base, hyp_va_bits);
 }
 
 static void handle___pkvm_cpu_set_vector(struct kvm_cpu_context *host_ctxt)
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 90bd014e952f..d8e5b563fd3d 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -341,8 +341,7 @@ void __noreturn __pkvm_init_finalise(void)
 	__host_enter(host_ctxt);
 }
 
-int __pkvm_init(phys_addr_t phys, unsigned long size, unsigned long nr_cpus,
-		unsigned long *per_cpu_base, u32 hyp_va_bits)
+int __pkvm_init(phys_addr_t phys, unsigned long size, unsigned long *per_cpu_base, u32 hyp_va_bits)
 {
 	struct kvm_nvhe_init_params *params;
 	void *virt = hyp_phys_to_virt(phys);
@@ -355,7 +354,6 @@ int __pkvm_init(phys_addr_t phys, unsigned long size, unsigned long nr_cpus,
 		return -EINVAL;
 
 	hyp_spin_lock_init(&pkvm_pgd_lock);
-	hyp_nr_cpus = nr_cpus;
 
 	ret = divide_memory_pool(virt, size);
 	if (ret)
-- 
2.53.0.rc1.225.gd81095ad13-goog

