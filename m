Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB143C0A1B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735904; cv=none; b=ZTlg+tlVisS+FK5XpGCDk2sfxbPeJagMKz5vI5hw5PhYHXN9KPpJIsqAhZXE7mc7x9SyOjbk5WecfWl/tWCEe78Pe7H+9uszod8GK2rQ6nazOzwFvxQCILt01K9qdvNqk7+t+UJavet+0raCzaijCLGbTjnD6FB9ZgAHxMsex3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735904; c=relaxed/simple;
	bh=adODHppsIc1wwdLxXXaubDfwAX6RazWFw20vgvX1ukU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KOCQlep9X0qj8JPYxK0TSZVdB607Fi5GMIMcBZtR5cUob7VFMIdCyp0lClNFC7B/brLw4Gu1Lcg0RnTSUpI/LEkTVy9USbPVwMNLqqIpFoyf8RiR8JWzNe5ukAXd/RVAb+n+mc2Q2CmUJBWRN9ACf04UbA8MMbdf0DGLp9ZOnbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CXXr6aFN; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CXXr6aFN"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84a67b16217so1335586b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735900; x=1788340700; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t8ccBHCM5YU+7L1JIoIBmJzcK+1OP4Tx7QbvPF9cByU=;
        b=CXXr6aFNQY6cimAxNlr3eCDyadWbaJg70FQ8eUYCAN1CjWZJjW0nQci4j+1ghbrHSF
         3VB2PnomVvjYlYJVazhkYE0gafXyLQjWWmh0jP81Yuh7s0Y/qdpB/NnWqarfWAK7/w6/
         GER4w7v2KO/5CxYdE5yQgBT6uwN+Ma0WPYvW7AqaO9KlnwGVmAyPaYkDnF0gUtLhApS9
         R+qGtYFo71S/QSyNmbFLG59hBtqnDgqLTMS4xMwYpZ2UZLcXugJJuVojXCMPcSuJuV8+
         qk2O5YDaFHRlmHWfZ7fYINGrUllHv4zaUvqs1FeGhFouqIsoH1KwY6yNXc39B7V7CSIi
         T7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735900; x=1788340700;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t8ccBHCM5YU+7L1JIoIBmJzcK+1OP4Tx7QbvPF9cByU=;
        b=iu7uG0Qea5MRkmaGVY/a/W2uuvk2T0ku27O2fjhFroqNpJay/ZTQSG5lFrwc7aWd0e
         wXqS3OvxOQSw1z+ZKkkcEwg7gv8Sgd06KFblVXTVWcQgzlIX9t7igLub/Bow0FMUvzrr
         Z9llg7SKWXRqWphJ+oQ/iHJksYD8Z7SsrtGaYOk/qKE7k5T9AO6zWjTgbRUFFpAst3Bw
         3szj4gyfjxyU+/MHQQx1pZsiX9OeWerPszsYME+i/JmIFbreCWFao9w2N67IuMSo1+rG
         t/SLeUSX0kTLtwi5gKzK3F/2jyMRXHM1cMgrQZ5PzxsHLePCWrsLE/oHrGEheWaTVrrs
         XD0A==
X-Forwarded-Encrypted: i=1; AHgh+RoSQgiTXSKx2MGxtohmEXH5ExMgXW/BPmGIVt/tgFFlGGI2AWFfcFl1zsWT3CEhowBy55DBKv+XfWOEItISAPpHoJY=@vger.kernel.org
X-Gm-Message-State: AFuF++kcGMToI2+8MDxxPy3XDFilxyPPrFthpKVNET29xEmYiOYppJKu
	HYzFIppI8Yk8fQ20aIKeHH19IDO2yPrQ2HQqiONM92u5L2JnJL7Y4qAOcXSsx1Qb0VCcIvWuc+w
	iab14rEtyqYF3NC4hMct6/DxUvA==
X-Received: from pgmc3.prod.google.com ([2002:a63:1c43:0:b0:c9e:a22d:15e8])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1392:b0:852:131f:b9d2 with SMTP id d2e1a72fcca58-853721a4ffamr9144251b3a.2.1787735899281;
 Wed, 26 Aug 2026 02:18:19 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:05 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=4963;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=adODHppsIc1wwdLxXXaubDfwAX6RazWFw20vgvX1ukU=; b=qAec0tsGFxGYk1SoSRFBiiuqAJZEJlc7qzpxmaWzfOGs28joKteKQEPT49Se3lIk9vstlpjPB
 7Av3Au/QmG8ApmYCsv64FqojNn5zmavT5iPhsNBkXGeY43AYhlcl7lG
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-7-0a15d8a799aa@google.com>
Subject: [PATCH v11 07/46] KVM: Rename kvm_mem_is_private() to kvm_is_private_gfn()
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Fuad Tabba <fuad.tabba@linux.dev>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

Rename kvm_mem_is_private() to kvm_is_private_gfn() to prepare for in-place
conversion, where there will be two lookup functions,
kvm_vm_is_private_gfn() and kvm_gmem_is_private_gfn().

This renaming allows consistent prefixing of "vm" vs "gmem" for
kvm_*_is_private_gfn(), as opposed to kvm_gmem_mem_is_private(), which
looks like a typo.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/mmu/mmu.c   | 12 ++++++------
 arch/x86/kvm/svm/sev.c   |  2 +-
 include/linux/kvm_host.h |  4 ++--
 virt/kvm/guest_memfd.c   |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 10e59507d252f..62f751952ad8a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3421,7 +3421,7 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm, struct kvm_page_fault *fault,
 		is_private = fault->is_private;
 	} else {
 		max_level = PG_LEVEL_NUM;
-		is_private = kvm_mem_is_private(kvm, gfn);
+		is_private = kvm_is_private_gfn(kvm, gfn);
 	}
 
 	max_level = min(max_level, max_huge_page_level);
@@ -3634,13 +3634,13 @@ static bool page_fault_can_be_fast(struct kvm *kvm, struct kvm_page_fault *fault
 	 * guest spinning on a #PF indefinitely, so don't attempt the fast path
 	 * in this case.
 	 *
-	 * Note that the kvm_mem_is_private() check might race with an
+	 * Note that the kvm_is_private_gfn() check might race with an
 	 * attribute update, but this will either result in the guest spinning
 	 * on RET_PF_SPURIOUS until the update completes, or an actual spurious
 	 * case might go down the slow path. Either case will resolve itself.
 	 */
 	if (kvm->arch.has_private_mem &&
-	    fault->is_private != kvm_mem_is_private(kvm, fault->gfn))
+	    fault->is_private != kvm_is_private_gfn(kvm, fault->gfn))
 		return false;
 
 	/*
@@ -4708,7 +4708,7 @@ static int kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
 	 * Now that we have a snapshot of mmu_invalidate_seq we can check for a
 	 * private vs. shared mismatch.
 	 */
-	if (fault->is_private != kvm_mem_is_private(kvm, fault->gfn)) {
+	if (fault->is_private != kvm_is_private_gfn(kvm, fault->gfn)) {
 		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
 		return -EFAULT;
 	}
@@ -5111,7 +5111,7 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 
 	direct_bits = 0;
 	if (kvm_arch_has_private_mem(vcpu->kvm) &&
-	    kvm_mem_is_private(vcpu->kvm, gpa_to_gfn(range->gpa)))
+	    kvm_is_private_gfn(vcpu->kvm, gpa_to_gfn(range->gpa)))
 		error_code |= PFERR_PRIVATE_ACCESS;
 	else
 		direct_bits = gfn_to_gpa(kvm_gfn_direct_bits(vcpu->kvm));
@@ -6584,7 +6584,7 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 	if (IS_ENABLED(CONFIG_KVM_SW_PROTECTED_VM) &&
 	    !(error_code & PFERR_RSVD_MASK) &&
 	    vcpu->kvm->arch.vm_type == KVM_X86_SW_PROTECTED_VM &&
-	    kvm_mem_is_private(vcpu->kvm, gpa_to_gfn(cr2_or_gpa)))
+	    kvm_is_private_gfn(vcpu->kvm, gpa_to_gfn(cr2_or_gpa)))
 		error_code |= PFERR_PRIVATE_ACCESS;
 
 	r = RET_PF_INVALID;
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 0a887f8e05d3a..dff684b88f153 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5030,7 +5030,7 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
 	 * userspace via KVM_EXIT_MEMORY_FAULT events, however, so RMP faults
 	 * for shared pages should not end up here.
 	 */
-	if (!kvm_mem_is_private(kvm, gfn)) {
+	if (!kvm_is_private_gfn(kvm, gfn)) {
 		pr_warn_ratelimited("SEV: Unexpected RMP fault for non-private GPA 0x%llx\n",
 				    gpa);
 		return;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6ca81f5349db8..9b97266f61ec8 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2573,12 +2573,12 @@ bool kvm_arch_pre_set_vm_memory_attributes(struct kvm *kvm,
 bool kvm_arch_post_set_vm_memory_attributes(struct kvm *kvm,
 					    struct kvm_gfn_range *range);
 
-static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
+static inline bool kvm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
 {
 	return kvm_get_vm_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
 }
 #else
-static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
+static inline bool kvm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
 {
 	return false;
 }
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 154fc9622640d..b9fee68c90311 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -879,7 +879,7 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
 
 	folio_unlock(folio);
 
-	if (!kvm_mem_is_private(kvm, gfn)) {
+	if (!kvm_is_private_gfn(kvm, gfn)) {
 		ret = -EINVAL;
 		goto out_put_folio;
 	}

-- 
2.55.0.887.g758fc8c411-goog

