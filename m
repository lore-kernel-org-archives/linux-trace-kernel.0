Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FED3C77B7A
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 26 May 2023 23:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbjEZXpD (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 26 May 2023 19:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237985AbjEZXo4 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 26 May 2023 19:44:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151671BB
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 May 2023 16:44:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba69d93a6b5so2830850276.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 May 2023 16:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685144691; x=1687736691;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SAnqMQmXLaJfeZI+VeXqIwvB0doaLL+gp8U5/HUId5I=;
        b=k8BERP9A+6Uiw+Uaig20mMncTvjKAsRCKq+HC63zo5f14BiSqxPWFPVFrxvd4dUkfQ
         bKRY2Xn6Sj5cpDeqFqXaOaTxVBSBg6TnHG9z0eetRbywYU3ie/H8/CJOp1+Ez2wWWiIG
         CY1cPbCWNOAs/19D6iZC6kEHwAF0m7RMLVET0mpluU6zBeVTNhcDLR1hhBJpslaBZ/Nm
         0fQXpAKGqnmpqrKCUVaNiYpgSsJF+6ODE5plgt1dvul/aWCITvYKB/5mkPp/iio/HINg
         59adq2fXr8dYaO8RPmc4VSfW2nQVaqhTR9xX4O6C0F0j/4E6MdCu9N0KSqKFRTup9DJ6
         82/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685144691; x=1687736691;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAnqMQmXLaJfeZI+VeXqIwvB0doaLL+gp8U5/HUId5I=;
        b=WUiQxiEdOCIkJwwyDpwYrlXqqsa4pMWjAJZQfs08qKoIpCmtpXTAGejyXflfHGRPwo
         4lnv96QK6T0RrCfBfzC3NG0wUjEfe8sCu7QT/AnEBhIJnszcUUnglyJEI+QEo8AAZqec
         G6XiPoroVdLm7LV30Y9H06b1iXjvfefD5mmocBQMWDPuRWkjLhrRJjGD6HHukWKywViW
         8+e7cZuFDcKHmLeTdAmwtYStJbB3n8melicsZ9y3G+mVbPXqVxnmaf3v+40fCVe19Sj2
         Kk/UDp/utH3lODHNuHg9timYe9oeNa7cBOAIBlBJfz4yfADoRIFOn7GWDNiK/9ka3i/2
         IpEg==
X-Gm-Message-State: AC+VfDztcMB2ERUgdfzwU9kf5YchQg16BtezwBjNtuSqaJivjx830qkj
        uFKmSUaAoBbImMFKJNP3Gzn4hwkvULY=
X-Google-Smtp-Source: ACHHUZ56f5xRS5UFm0fGZF6KKL2sEC5mGRlgoj/Qp341qhbzjJy6m3cfCKx+HZdIQ3EgPejfKdLHbTHVxEI=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:910f:8a15:592b:2087])
 (user=yuzhao job=sendgmr) by 2002:a25:8211:0:b0:ba6:e7ee:bb99 with SMTP id
 q17-20020a258211000000b00ba6e7eebb99mr1850590ybk.12.1685144690927; Fri, 26
 May 2023 16:44:50 -0700 (PDT)
Date:   Fri, 26 May 2023 17:44:32 -0600
In-Reply-To: <20230526234435.662652-1-yuzhao@google.com>
Message-Id: <20230526234435.662652-8-yuzhao@google.com>
Mime-Version: 1.0
References: <20230526234435.662652-1-yuzhao@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH mm-unstable v2 07/10] kvm/powerpc: add kvm_arch_test_clear_young()
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Anup Patel <anup@brainfault.org>,
        Ben Gardon <bgardon@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Gavin Shan <gshan@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Larabel <michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Paul Mackerras <paulus@ozlabs.org>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Huth <thuth@redhat.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-trace-kernel@vger.kernel.org, x86@kernel.org,
        linux-mm@google.com, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Implement kvm_arch_test_clear_young() to support the fast path in
mmu_notifier_ops->test_clear_young().

It focuses on a simple case, i.e., radix MMU sets the accessed bit in
KVM PTEs and VMs are not nested, where it can rely on RCU and
pte_xchg() to safely clear the accessed bit without taking
kvm->mmu_lock. Complex cases fall back to the existing slow path
where kvm->mmu_lock is then taken.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 arch/powerpc/include/asm/kvm_host.h    |  8 ++++
 arch/powerpc/include/asm/kvm_ppc.h     |  1 +
 arch/powerpc/kvm/book3s.c              |  6 +++
 arch/powerpc/kvm/book3s.h              |  1 +
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 59 ++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv.c           |  5 +++
 6 files changed, 80 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 14ee0dece853..75c260ea8a9e 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -883,4 +883,12 @@ static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
 static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
 
+#define kvm_arch_has_test_clear_young kvm_arch_has_test_clear_young
+static inline bool kvm_arch_has_test_clear_young(void)
+{
+	return IS_ENABLED(CONFIG_KVM_BOOK3S_HV_POSSIBLE) &&
+	       cpu_has_feature(CPU_FTR_HVMODE) && cpu_has_feature(CPU_FTR_ARCH_300) &&
+	       radix_enabled();
+}
+
 #endif /* __POWERPC_KVM_HOST_H__ */
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 79a9c0bb8bba..ff1af6a7b44f 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -287,6 +287,7 @@ struct kvmppc_ops {
 	bool (*unmap_gfn_range)(struct kvm *kvm, struct kvm_gfn_range *range);
 	bool (*age_gfn)(struct kvm *kvm, struct kvm_gfn_range *range);
 	bool (*test_age_gfn)(struct kvm *kvm, struct kvm_gfn_range *range);
+	bool (*test_clear_young)(struct kvm *kvm, struct kvm_gfn_range *range);
 	bool (*set_spte_gfn)(struct kvm *kvm, struct kvm_gfn_range *range);
 	void (*free_memslot)(struct kvm_memory_slot *slot);
 	int (*init_vm)(struct kvm *kvm);
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 686d8d9eda3e..37bf40b0c4ff 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -899,6 +899,12 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 	return kvm->arch.kvm_ops->test_age_gfn(kvm, range);
 }
 
+bool kvm_arch_test_clear_young(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	return !kvm->arch.kvm_ops->test_clear_young ||
+	       kvm->arch.kvm_ops->test_clear_young(kvm, range);
+}
+
 bool kvm_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 {
 	return kvm->arch.kvm_ops->set_spte_gfn(kvm, range);
diff --git a/arch/powerpc/kvm/book3s.h b/arch/powerpc/kvm/book3s.h
index 58391b4b32ed..fa2659e21ccc 100644
--- a/arch/powerpc/kvm/book3s.h
+++ b/arch/powerpc/kvm/book3s.h
@@ -12,6 +12,7 @@ extern void kvmppc_core_flush_memslot_hv(struct kvm *kvm,
 extern bool kvm_unmap_gfn_range_hv(struct kvm *kvm, struct kvm_gfn_range *range);
 extern bool kvm_age_gfn_hv(struct kvm *kvm, struct kvm_gfn_range *range);
 extern bool kvm_test_age_gfn_hv(struct kvm *kvm, struct kvm_gfn_range *range);
+extern bool kvm_test_clear_young_hv(struct kvm *kvm, struct kvm_gfn_range *range);
 extern bool kvm_set_spte_gfn_hv(struct kvm *kvm, struct kvm_gfn_range *range);
 
 extern int kvmppc_mmu_init_pr(struct kvm_vcpu *vcpu);
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 3b65b3b11041..0a392e9a100a 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -1088,6 +1088,65 @@ bool kvm_test_age_radix(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	return ref;
 }
 
+bool kvm_test_clear_young_hv(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	bool err;
+	gfn_t gfn = range->start;
+
+	rcu_read_lock();
+
+	err = !kvm_is_radix(kvm);
+	if (err)
+		goto unlock;
+
+	/*
+	 * Case 1:  This function          kvmppc_switch_mmu_to_hpt()
+	 *
+	 *          rcu_read_lock()
+	 *          Test kvm_is_radix()    kvm->arch.radix = 0
+	 *          Use kvm->arch.pgtable  synchronize_rcu()
+	 *          rcu_read_unlock()
+	 *                                 kvmppc_free_radix()
+	 *
+	 *
+	 * Case 2:  This function          kvmppc_switch_mmu_to_radix()
+	 *
+	 *                                 kvmppc_init_vm_radix()
+	 *                                 smp_wmb()
+	 *          Test kvm_is_radix()    kvm->arch.radix = 1
+	 *          smp_rmb()
+	 *          Use kvm->arch.pgtable
+	 */
+	smp_rmb();
+
+	while (gfn < range->end) {
+		pte_t *ptep;
+		pte_t old, new;
+		unsigned int shift;
+
+		ptep = find_kvm_secondary_pte_unlocked(kvm, gfn * PAGE_SIZE, &shift);
+		if (!ptep)
+			goto next;
+
+		VM_WARN_ON_ONCE(!page_count(virt_to_page(ptep)));
+
+		old = READ_ONCE(*ptep);
+		if (!pte_present(old) || !pte_young(old))
+			goto next;
+
+		new = pte_mkold(old);
+
+		if (kvm_should_clear_young(range, gfn))
+			pte_xchg(ptep, old, new);
+next:
+		gfn += shift ? BIT(shift - PAGE_SHIFT) : 1;
+	}
+unlock:
+	rcu_read_unlock();
+
+	return err;
+}
+
 /* Returns the number of PAGE_SIZE pages that are dirty */
 static int kvm_radix_test_clear_dirty(struct kvm *kvm,
 				struct kvm_memory_slot *memslot, int pagenum)
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 130bafdb1430..20a81ec9fde8 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -5262,6 +5262,8 @@ int kvmppc_switch_mmu_to_hpt(struct kvm *kvm)
 	spin_lock(&kvm->mmu_lock);
 	kvm->arch.radix = 0;
 	spin_unlock(&kvm->mmu_lock);
+	/* see the comments in kvm_test_clear_young_hv() */
+	synchronize_rcu();
 	kvmppc_free_radix(kvm);
 
 	lpcr = LPCR_VPM1;
@@ -5286,6 +5288,8 @@ int kvmppc_switch_mmu_to_radix(struct kvm *kvm)
 	if (err)
 		return err;
 	kvmppc_rmap_reset(kvm);
+	/* see the comments in kvm_test_clear_young_hv() */
+	smp_wmb();
 	/* Mutual exclusion with kvm_unmap_gfn_range etc. */
 	spin_lock(&kvm->mmu_lock);
 	kvm->arch.radix = 1;
@@ -6185,6 +6189,7 @@ static struct kvmppc_ops kvm_ops_hv = {
 	.unmap_gfn_range = kvm_unmap_gfn_range_hv,
 	.age_gfn = kvm_age_gfn_hv,
 	.test_age_gfn = kvm_test_age_gfn_hv,
+	.test_clear_young = kvm_test_clear_young_hv,
 	.set_spte_gfn = kvm_set_spte_gfn_hv,
 	.free_memslot = kvmppc_core_free_memslot_hv,
 	.init_vm =  kvmppc_core_init_vm_hv,
-- 
2.41.0.rc0.172.g3f132b7071-goog

