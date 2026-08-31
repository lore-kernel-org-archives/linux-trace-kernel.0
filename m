Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7E32D238F;
	Mon, 31 Aug 2026 00:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788135920; cv=none; b=N7wpsruehEiPCpZG9yoJBI5oZqk+SMX3PNRQkScUVWvo9T7OVpILagvQdwlunmK5BLR8eHYjdMbcER8iV1ZV4e4HVA3dAVm2UwiOJU1JHO9YjS1JrbFhsdf0MMbr/72nnpKCRwydDFNTc87ZY9mRCEiUdhlfT85/g9CmktX2ENU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788135920; c=relaxed/simple;
	bh=KrGDcS6cy/AkD2yrXWcr9bAXsvRzIR53iwDweGRLZFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HlFWim/qhbcwFrk74nEmcgrw16zOqPvBArlSG7TWplFnBFCnwqEc1177chI/nZ/kTBqMjps13cd7lIs5VD35SdgNyq+OnkQBiIvLn7qZV0I2M7StgfxvhN9Y5tGP0gEoGOqHRmc+qXqYhK6dIEpPBZz1ei7xLGZld/ZNUsL3uSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKbQ1hSV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKbQ1hSV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C195C4AF14;
	Mon, 31 Aug 2026 00:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788135920;
	bh=KrGDcS6cy/AkD2yrXWcr9bAXsvRzIR53iwDweGRLZFc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XKbQ1hSVBXleF7yR17zPg82ohUAEiIS46Q0ZlPicqWp1yRIB6Z9cJq/VgdnjI88th
	 XpAshl6srDv4EWR/vuHEIHeCL6UdcCwkZiFPvzS4nghBFASKfrgA2iDNQRp0vcOYSR
	 MDeyAu4662sg8SjWhMyULET+EDh3TQsk34YxyBHMoxD8ESoboVqcVpNjftMQjWarrN
	 sl2d86SpRTYeg3I/QGHwwSSgLtqfb8FfqtpJ1g7TWIwSdxeccjEvI47BONF2obyMeC
	 K4C2610qBhHIU2XQfm/9KgeMN9qAMgYDR56XQJyOnXntujcB01zp3L99T2T08gjk4f
	 eDQ+bpVLqSCng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08564C61DF1;
	Mon, 31 Aug 2026 00:25:20 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Sun, 30 Aug 2026 17:25:08 -0700
Subject: [PATCH v12 07/45] KVM: Rename kvm_mem_is_private() to
 kvm_is_private_gfn()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-gmem-inplace-conversion-v12-7-85e5fd25252a@google.com>
References: <20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com>
In-Reply-To: <20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
 brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
 jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
 oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
 rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
 steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
 yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
 suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
 Randy Dunlap <rdunlap@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Fuad Tabba <fuad.tabba@linux.dev>, 
 Vlastimil Babka <vbabka@kernel.org>, Baoquan He <baoquan.he@linux.dev>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788135915; l=4963;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=S5RCe4TQDZm3nHFvcXoNSPDbyF0DJXsRh4I6ecZKWnA=;
 b=8QOHgDh+p+0BDtEfm9STQE+bY0kNr2gTTBgbFMNHSzegw2N+ibVWgWMTF9CwpV50TAvoJ8ISN
 enLTjDrdcz9ByffglEZQ7oQcBo8ZjVcRqMu4mx1BIJ44peRDH7MnQlf
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

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
index e32ac2c28cbef..ce5efcacda36e 100644
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
2.55.0.897.gb25b4bd76c-goog


