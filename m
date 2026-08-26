Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EE83BE646
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735898; cv=none; b=mav44Kc1fl1eEl0eKPClWEZjHioMMQszQA5+xR6DfO/2edLG12mueGuePLkNtmkf2VSEa8OYTIuDFpTONiJ9T64QcKpzuMIj/3QB7FUED2Z8fcQmm7dxtrRzyY9GDuqIyXpbbRd2G62fZn7dGYZCjUOGVOJ6DOLAK6qIOqyzF2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735898; c=relaxed/simple;
	bh=PHg3HYJKZwblYL1XUgNEiIva+pGKLiIaEOzzYbN1rIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f3xqFrf83IrL7d6PNo53iB3j7u0fvrVGVguGEY52vxF8eCnF/EK8bTeDRoIOK8oFJy5Ogmr8Ob3h8tUKX0/BrzNdSNVd/HXNEf+b7BOZt7N5WowvLPmUpSh5OqCulta6VEW8wKfNbhlJJa/yGpFxMAorGX2Y21Oq8uA/+zAeCK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T+2v4Q1/; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T+2v4Q1/"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d02df2bf09so8161615ad.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735894; x=1788340694; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FBz9N4MFbqHkEOIZ4nKMBqouKjOi9Jg3kSfpTttXCxI=;
        b=T+2v4Q1/iW+vYuDqXqbdrKrxPIDJfR665b8a3AapLHooTA4WhBeWJalGq7Kvk8L7YU
         pSdc+qk08BSCPuxyotMrjBFYixbEeEH2yRmQAd2D7fAg04x0Tl11dkplejEl9As+Q+GK
         K1LEL04UsSgJpe6jjZuVDvpbpOM9o8ASpvD7K+hIkdAizrJdnxwnhF7oRbUlqdxAqZ4A
         sU3HN0GoeaJhKrjLNSzh2cFIxSbKgFtF5DyCywT/CRKq2tz8uhcJ7i5DrXni+Om6Jy/E
         pjhlm9Z6VQLwV0TyFFRpzSKrxmIRGVei1bJBn9bukVqzcAwhnTG/fsPrQTdVRXnnW3Ge
         G7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735894; x=1788340694;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FBz9N4MFbqHkEOIZ4nKMBqouKjOi9Jg3kSfpTttXCxI=;
        b=oDXQDJB2UZoeT3bpRJZRp9d5gpLi8A3WHApFERrVZUWpglwX1cTmk8mQPX8DVDcJTt
         e+BI/hVaRqkkx/nJPfSNipPBAZTPAT7z+ixTVN4jgw2qft7tCwJa9XIKuFyYyid77tyw
         f8FtmL56irfKSpw03Xtt3GYSH9lLuiMED6nYU+iK/3OffAxLcxp7E7QOvVv9eKgOhWOp
         aEQ8zW2C/DH+Lm5jHZ4gPpLut1ncGR9/uJUsiNQmZpGDcYQPcICd+H9g2tWvigSHv7gh
         EKszH/N2cxVQSSUMIA2gBKJcwcIdHfPzhYF+3F7OmMoraJh8DPgJhlZIwTg1rR4mkdWO
         BH1A==
X-Forwarded-Encrypted: i=1; AHgh+Rr3YlmmgFW6kKVlK8PNFtPwIgSkmCxHkz1zQaQO6sSSjL1ximhP+UsxD3SFGulAIShI0nZ9KHN3O1DfKLv+9B1T+ZI=@vger.kernel.org
X-Gm-Message-State: AFuF++lW2aBktctIHgtGmhHOQI02+2DYa3pBfWFdJng0OIkww1/nuSCB
	0i/Q5ZK4j8Ff6go4EF8WrEaPjyl2sHZx0FpeVXoITrNdHpzag3R7ThVU+AqacUlIedF715WSOtu
	6763dfgzmwjG0tAjvDVkgPrOMiQ==
X-Received: from plv18.prod.google.com ([2002:a17:903:bd2:b0:2ca:b907:d842])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:4b24:b0:2c9:9a2e:dab0 with SMTP id d9443c01a7336-2d707954e7amr92794715ad.3.1787735893912;
 Wed, 26 Aug 2026 02:18:13 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:02 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=8898;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=hQPdfbzAcJ80Cu7pf4GOOlMLi8LkOym9DUQ6K7ygW88=; b=Mj2w5CpRm6N4W+MCTHfhjQSjmqnutb7zrhZNzMCgBzqdxU6jlb5t809lCBh5WWIiVPZvXZulc
 zV9OM+FTWayDcblR2qgsxFMI9EpxlNVZazn/9exm5KXRmu2JWMmhuBg
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-4-0a15d8a799aa@google.com>
Subject: [PATCH v11 04/46] KVM: Rename KVM_GENERIC_MEMORY_ATTRIBUTES to KVM_VM_MEMORY_ATTRIBUTES
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
	linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="utf-8"

From: Sean Christopherson <seanjc@google.com>

Rename the per-VM memory attributes Kconfig to make it explicitly about
per-VM attributes in anticipation of adding memory attributes support to
guest_memfd, at which point it will be possible (and desirable) to have
memory attributes without the per-VM support, even in x86.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/Kconfig            |  6 +++---
 arch/x86/kvm/mmu/mmu.c          |  2 +-
 arch/x86/kvm/x86.c              |  2 +-
 include/linux/kvm_host.h        |  8 ++++----
 include/trace/events/kvm.h      |  4 ++--
 virt/kvm/Kconfig                |  2 +-
 virt/kvm/kvm_main.c             | 14 +++++++-------
 8 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6beddd8a0c749..744c1f6ff03ed 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1851,7 +1851,7 @@ enum kvm_intr_type {
 	((vcpu) && (vcpu)->arch.handling_intr_from_guest && \
 	 (!!in_nmi() == ((vcpu)->arch.handling_intr_from_guest == KVM_HANDLING_NMI)))
 
-#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 #define kvm_arch_has_private_mem(kvm) ((kvm)->arch.has_private_mem)
 #endif
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 538ed1e803326..2f8e1b5a8a72c 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -84,7 +84,7 @@ config KVM_SW_PROTECTED_VM
 	bool "Enable support for KVM software-protected VMs"
 	depends on EXPERT
 	depends on KVM_X86 && X86_64
-	select KVM_GENERIC_MEMORY_ATTRIBUTES
+	select KVM_VM_MEMORY_ATTRIBUTES
 	help
 	  Enable support for KVM software-protected VMs.  Currently, software-
 	  protected VMs are purely a development and testing vehicle for
@@ -135,7 +135,7 @@ config KVM_INTEL_TDX
 	bool "Intel Trust Domain Extensions (TDX) support"
 	default y
 	depends on INTEL_TDX_HOST
-	select KVM_GENERIC_MEMORY_ATTRIBUTES
+	select KVM_VM_MEMORY_ATTRIBUTES
 	select HAVE_KVM_ARCH_GMEM_POPULATE
 	help
 	  Provides support for launching Intel Trust Domain Extensions (TDX)
@@ -159,7 +159,7 @@ config KVM_AMD_SEV
 	depends on KVM_AMD && X86_64
 	depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
 	select ARCH_HAS_CC_PLATFORM
-	select KVM_GENERIC_MEMORY_ATTRIBUTES
+	select KVM_VM_MEMORY_ATTRIBUTES
 	select HAVE_KVM_ARCH_GMEM_CONVERT
 	select HAVE_KVM_ARCH_GMEM_RECLAIM
 	select HAVE_KVM_ARCH_GMEM_INVALIDATE
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 947c9cd843450..b88c00e11854a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -8097,7 +8097,7 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
 		vhost_task_stop(kvm->arch.nx_huge_page_recovery_thread);
 }
 
-#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 static bool hugepage_test_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
 				int level)
 {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4b3681796c752..29e41d334cedf 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10140,7 +10140,7 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
 		}
 	}
 
-#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 	kvm_mmu_init_memslot_memory_attributes(kvm, slot);
 #endif
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index b7516e19ef419..cffa16647f2ab 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -722,7 +722,7 @@ static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
 }
 #endif
 
-#ifndef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#ifndef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
 {
 	return false;
@@ -872,7 +872,7 @@ struct kvm {
 #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
 	struct notifier_block pm_notifier;
 #endif
-#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 	/* Protected by slots_lock (for writes) and RCU (for reads) */
 	struct xarray mem_attr_array;
 #endif
@@ -2560,7 +2560,7 @@ static inline bool kvm_memslot_is_gmem_only(const struct kvm_memory_slot *slot)
 	return slot->flags & KVM_MEMSLOT_GMEM_ONLY;
 }
 
-#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
 {
 	return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
@@ -2582,7 +2582,7 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 {
 	return false;
 }
-#endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
+#endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 
 #ifdef CONFIG_KVM_GUEST_MEMFD
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
diff --git a/include/trace/events/kvm.h b/include/trace/events/kvm.h
index b282e3a867696..1ba72bd73ea2f 100644
--- a/include/trace/events/kvm.h
+++ b/include/trace/events/kvm.h
@@ -358,7 +358,7 @@ TRACE_EVENT(kvm_dirty_ring_exit,
 	TP_printk("vcpu %d", __entry->vcpu_id)
 );
 
-#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 /*
  * @start:	Starting address of guest memory range
  * @end:	End address of guest memory range
@@ -383,7 +383,7 @@ TRACE_EVENT(kvm_vm_set_mem_attributes,
 	TP_printk("%#016llx -- %#016llx [0x%lx]",
 		  __entry->start, __entry->end, __entry->attr)
 );
-#endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
+#endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 
 TRACE_EVENT(kvm_unmap_hva_range,
 	TP_PROTO(unsigned long start, unsigned long end),
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index c3c0ee253fc77..df575449d97b5 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -100,7 +100,7 @@ config KVM_ELIDE_TLB_FLUSH_IF_YOUNG
 config KVM_MMU_LOCKLESS_AGING
        bool
 
-config KVM_GENERIC_MEMORY_ATTRIBUTES
+config KVM_VM_MEMORY_ATTRIBUTES
        bool
 
 config KVM_GUEST_MEMFD
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65eb26a0520d8..7d5325e3cb44b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1116,7 +1116,7 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 	spin_lock_init(&kvm->mn_invalidate_lock);
 	rcuwait_init(&kvm->mn_memslots_update_rcuwait);
 	xa_init(&kvm->vcpu_array);
-#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 	xa_init(&kvm->mem_attr_array);
 #endif
 
@@ -1301,7 +1301,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	cleanup_srcu_struct(&kvm->irq_srcu);
 	srcu_barrier(&kvm->srcu);
 	cleanup_srcu_struct(&kvm->srcu);
-#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 	xa_destroy(&kvm->mem_attr_array);
 #endif
 	kvm_arch_free_vm(kvm);
@@ -2419,7 +2419,7 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
 }
 #endif /* CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT */
 
-#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 static u64 kvm_supported_mem_attributes(struct kvm *kvm)
 {
 	if (!kvm || kvm_arch_has_private_mem(kvm))
@@ -2624,7 +2624,7 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
 
 	return kvm_vm_set_mem_attributes(kvm, start, end, attrs->attributes);
 }
-#endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
+#endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 
 struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn)
 {
@@ -4941,7 +4941,7 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 	case KVM_CAP_SYSTEM_EVENT_DATA:
 	case KVM_CAP_DEVICE_CTRL:
 		return 1;
-#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 	case KVM_CAP_MEMORY_ATTRIBUTES:
 		return kvm_supported_mem_attributes(kvm);
 #endif
@@ -5345,7 +5345,7 @@ static long kvm_vm_ioctl(struct file *filp,
 		break;
 	}
 #endif /* CONFIG_HAVE_KVM_IRQ_ROUTING */
-#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 	case KVM_SET_MEMORY_ATTRIBUTES: {
 		struct kvm_memory_attributes attrs;
 
@@ -5356,7 +5356,7 @@ static long kvm_vm_ioctl(struct file *filp,
 		r = kvm_vm_ioctl_set_mem_attributes(kvm, &attrs);
 		break;
 	}
-#endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
+#endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 	case KVM_CREATE_DEVICE: {
 		struct kvm_create_device cd;
 

-- 
2.55.0.887.g758fc8c411-goog

