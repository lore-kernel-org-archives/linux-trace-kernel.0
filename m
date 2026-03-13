Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEDD34751C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382372; cv=none; b=uuVxlEAl0uoH8Dz3oj7vdIl/pdKu6VzZt/vnmfLrI/Uk4aQ1+mflposdCQrtegp6ZEg31vlOlZz8NRoGc2s5baKko2Qelnm5r3mIK/hJz/Ztfz5TgMP6TQbZ6JEwELxYYLWYLV6Iz3GxH2e8ezSbPO7o6kgQzJHcyQc/B8Fpv38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382372; c=relaxed/simple;
	bh=6/72ofsvwRK4bb8us6hhCR6Dyob4ABX7lV3kNcDt+oo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=heEGh5RkZBAu9FKBIJjXqz5+gOH1ROEoBaydCz3pEIt4sU4IY2jN9dPMeH1gMJI5nUCsE1nmRakYHk7lf9WtCIo3jmcP+yeG+Y8PUSylmIM/27TNieNROsiel5mXGDXNXk+DFZfw3A/WQyK5BzZhSkBLUYIajvSK2YGAvDRBpr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=USVuUHl7; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="USVuUHl7"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35a019abd6aso1959752a91.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382370; x=1773987170; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wqyxAZkPbXKIsoN/7qS/+e4J2x78nPCOIZjEbaOcSBk=;
        b=USVuUHl7CJJ9jJfoJAukscmxYQnMHhUP0r+2hpIbblKFnV4AaAWBep7VUgrDGKGVsN
         cUjMGRn4wloFqwiNmZNNfdY9q1slirJ7p3VFeurnynJXTT3cG8MSjMjOBScsejFALusm
         4edXnvvuLlJscRBk/TObiICfZH4qA4JNOJQo0zE6oaV98wWIm8BhWHOVpG44nyhlc3gC
         Mnj7cOavzscUmwMg62U6lsXk2+DyMHGjJfMFRasU3IjQbJIMgeACCLKfuNwfI+ASVe++
         YYcAEhNsA7oFkyipHYjS8QaDGXCl2qitoGLgFrTSFY3XQ0dKunw2KAQkqhpMwxz2Iflm
         7nwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382370; x=1773987170;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqyxAZkPbXKIsoN/7qS/+e4J2x78nPCOIZjEbaOcSBk=;
        b=T16MFLNuuc8zBh31nRgrGQDo54xRlFDGim1X/wHXGvPMFYP+zcFaX9yqH8M+68XThG
         C35LwGBnwg8tgtfap5Drk8wyhHzFlvGdPlE+2TOLhdZoasEIQwup/iA8INe+8GkI4Xwt
         haGblZ9TWXHy3AtrQAYp4zAjoSMBrhNf2Y/TVw27W14CzeqvS41PUC6PR+tRYi+gU4xe
         ZblWWKnRJRoWwzuMPqXC7AAEn5+NsKmDHGdjh33dufs3R99+APfrLuKY9Npd1cwnjHKR
         xN1aoRUztE4VFuYeLH8kmkaic3nQ6lqJPtOolAWFiVbgRUQmX5Bd0uGjVKv53k+Ql/LR
         L88A==
X-Forwarded-Encrypted: i=1; AJvYcCVl2g/Qpau0vgc8xT8GVoI38T1mH3bIeqWPOktEB28Om1LagGvmKABiOc1h8zb5POv/ptpWn7P579OMqmyhUrYyeyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm1AbA4Vb8yJARauQYJTAOfo3tMRaU54suCkj4phQlCKmcwunn
	l4zlIzNt2owHgI9JyplOJp0LrJV6Kkzuz+cOlCf3GSTh/ANaCkl7a8tmDZSP25vUgFTpsa29IP3
	YwqGo1Oqtu1Gz0B7Rj+7jvQRT0g==
X-Received: from pgac7.prod.google.com ([2002:a05:6a02:2947:b0:c73:7d8e:b5dc])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1e43:b0:35a:10b6:1208 with SMTP id 98e67ed59e1d1-35a11ad03e8mr5360834a91.14.1773382369651;
 Thu, 12 Mar 2026 23:12:49 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:12:41 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=8589;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=HOZ0tBJg5vK53vB9iEjp9H9Ek9+9wY3gtxNmuGlqJEs=; b=l2Tg+QZ8MkzGgkOfBhw9QInbF/jxR127g1P+lufbRCPD5D69+6F8oHEOLF10RsLGlpJQrYscS
 muNBtOXT9VDA/gy0Lx1JP1uakSR7j4s6KWA7GhBnp1nqt8MCVhCgP9f
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-2-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 02/43] KVM: Rename KVM_GENERIC_MEMORY_ATTRIBUTES to KVM_VM_MEMORY_ATTRIBUTES
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sean Christopherson <seanjc@google.com>

Rename the per-VM memory attributes Kconfig to make it explicitly about
per-VM attributes in anticipation of adding memory attributes support to
guest_memfd, at which point it will be possible (and desirable) to have
memory attributes without the per-VM support, even in x86.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
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
index 6e4e3ef9b8c72..cf3d2bdababc7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2329,7 +2329,7 @@ void kvm_configure_mmu(bool enable_tdp, int tdp_forced_root_level,
 		       int tdp_max_root_level, int tdp_huge_page_level);
 
 
-#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 #define kvm_arch_has_private_mem(kvm) ((kvm)->arch.has_private_mem)
 #endif
 
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 801bf9e520db3..26f6afd51bbdc 100644
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
 	select HAVE_KVM_ARCH_GMEM_PREPARE
 	select HAVE_KVM_ARCH_GMEM_INVALIDATE
 	select HAVE_KVM_ARCH_GMEM_POPULATE
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b922a8b000577..792701b093234 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7889,7 +7889,7 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
 		vhost_task_stop(kvm->arch.nx_huge_page_recovery_thread);
 }
 
-#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 static bool hugepage_test_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
 				int level)
 {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fd1c4a36b5936..7e133a9da11f0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13509,7 +13509,7 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
 		}
 	}
 
-#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 	kvm_mmu_init_memslot_memory_attributes(kvm, slot);
 #endif
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6b76e7a6f4c22..e75f7295af5d0 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -721,7 +721,7 @@ static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
 }
 #endif
 
-#ifndef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#ifndef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
 {
 	return false;
@@ -870,7 +870,7 @@ struct kvm {
 #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
 	struct notifier_block pm_notifier;
 #endif
-#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 	/* Protected by slots_lock (for writes) and RCU (for reads) */
 	struct xarray mem_attr_array;
 #endif
@@ -2513,7 +2513,7 @@ static inline bool kvm_memslot_is_gmem_only(const struct kvm_memory_slot *slot)
 	return slot->flags & KVM_MEMSLOT_GMEM_ONLY;
 }
 
-#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
 {
 	return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
@@ -2535,7 +2535,7 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
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
index 794976b88c6f9..5119cb37145fc 100644
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
index 9093251beb398..301d7ddac6ba6 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1122,7 +1122,7 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 	spin_lock_init(&kvm->mn_invalidate_lock);
 	rcuwait_init(&kvm->mn_memslots_update_rcuwait);
 	xa_init(&kvm->vcpu_array);
-#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 	xa_init(&kvm->mem_attr_array);
 #endif
 
@@ -1307,7 +1307,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	cleanup_srcu_struct(&kvm->irq_srcu);
 	srcu_barrier(&kvm->srcu);
 	cleanup_srcu_struct(&kvm->srcu);
-#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 	xa_destroy(&kvm->mem_attr_array);
 #endif
 	kvm_arch_free_vm(kvm);
@@ -2425,7 +2425,7 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
 }
 #endif /* CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT */
 
-#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 static u64 kvm_supported_mem_attributes(struct kvm *kvm)
 {
 	if (!kvm || kvm_arch_has_private_mem(kvm))
@@ -2630,7 +2630,7 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
 
 	return kvm_vm_set_mem_attributes(kvm, start, end, attrs->attributes);
 }
-#endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
+#endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 
 struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn)
 {
@@ -4928,7 +4928,7 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 	case KVM_CAP_SYSTEM_EVENT_DATA:
 	case KVM_CAP_DEVICE_CTRL:
 		return 1;
-#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 	case KVM_CAP_MEMORY_ATTRIBUTES:
 		return kvm_supported_mem_attributes(kvm);
 #endif
@@ -5332,7 +5332,7 @@ static long kvm_vm_ioctl(struct file *filp,
 		break;
 	}
 #endif /* CONFIG_HAVE_KVM_IRQ_ROUTING */
-#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 	case KVM_SET_MEMORY_ATTRIBUTES: {
 		struct kvm_memory_attributes attrs;
 
@@ -5343,7 +5343,7 @@ static long kvm_vm_ioctl(struct file *filp,
 		r = kvm_vm_ioctl_set_mem_attributes(kvm, &attrs);
 		break;
 	}
-#endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
+#endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 	case KVM_CREATE_DEVICE: {
 		struct kvm_create_device cd;
 

-- 
2.53.0.851.ga537e3e6e9-goog

