Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C9334751C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563874; cv=none; b=S04hs0wL4dUGtsv3R1E/zCs4x3c58CJjPcR641YAyXOzbx42pWvpeHrQH0e6OCSZAcR1aO/4KDaN7ICFtmP0T8CE9s6c3Kqm2A9KxePj4p02hjkJ9Spd9L6Mj/WJx+d1CzV+wULigA4tWsoEbHEx06QB/pXLbrD9gTPoi1fkErA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563874; c=relaxed/simple;
	bh=U9TZUlSXcsS1k9uKx4EGIT2HPjNCFjAb/HAJK8DDjW4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t/xrirhTNV56zln/4OSPAOGSifX1yGOCUMmExjig1T9uZ9sMzuZaD8ppTIqquh60J9d/OiNSf3FyXNuSIQPFcIh/t/XbD/U+rJcs3rGkxtywnIeeb4FbqHJfVdP+zcKQjwiKcN4UrSYjMRHZYx2mBh2kGRn5SIVmad6etcbRWnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J/aGu15T; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J/aGu15T"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b07bd30b5eso34491755ad.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563872; x=1775168672; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uuod0qNsBqG0ybFgd9PBXDc0yAcGuU/GT8QI9Nhe6Gw=;
        b=J/aGu15TGuHt+h4rp2ZYWipuAJ6+7/F655AlmszZteqrG5JIPB24Zu2zTZtMPewMhH
         I5fsEu9YxcMy4BKeN/V6sq7/sVZZ3nWVakCc376sYiUZskgDpT0eJ4HIQBG0omhdH7U6
         asSWb35D4xx6oUfGWb78lpEE8a7E+Vw3rymW5sq80yqJj3cSeUIrjflMgyqUKXNLV9y3
         Wvo64KIA+11Di5tGhB9lBLWsL92fZqgWY76+ItLod6uUxoCeOgcY2Ci+neqYGKAvLQK8
         Sg3nhR/Sk7we52/qALMNFurnypkZlFHK7fqe0OA1i93Kao7fiJcGxBLygNh7yCPWUsvc
         TOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563872; x=1775168672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uuod0qNsBqG0ybFgd9PBXDc0yAcGuU/GT8QI9Nhe6Gw=;
        b=OTy6YJIteCbcgtbEgqC2FJENHgWyIZEEXYRrmnvHdXKpaHfg0Bp6RTsddnrAnBll1P
         zppVs60aYHmIYYRV5frDKRdyuGD+Kv9EC5NU0jGufVB2Eb3C1RDBJ4yoDco3Qj6EKO55
         k0FPp4sHATzvR55vz5777kB01fWEJUcv09iEVbANFA9E+hnXZSwmTW8zvDJNNPF7lNaS
         K51A2oe2uTrdHrxZrlzaf+RxFOyGWt9CcmXBNWTbN2Oa5kxXd8dNz9WrbOMeHC+8m/qz
         rJ7uqvOjM5dWR/2Egb2RIo25osXkbUW8NG0+y7Xl1CPLoxakTpBtscwCJg7VPS97i0jX
         CVGg==
X-Forwarded-Encrypted: i=1; AJvYcCV+mZoMFArZ80ZWkf2QXZHnMmpkC19A8VwfGKVfpYChI0snUFe/AmPZFijXr564gHK3hLX1LlZtiOo2jSKOHlDta9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgf+J1p7FrGxOK3AFKYBsZhX7czJnKC+xU56WFoBZcwTRlYMZc
	pN1QHFFKY8O2VjcB/9vdebTG+D+ECk1Og0UDbuQqKrDF5SAiRkebZgAcVlK68FGSqEQIbk269Lx
	j4hJkPVDf2G/NYMgzMXuJrvamsg==
X-Received: from pfwy40.prod.google.com ([2002:a05:6a00:1ca8:b0:824:b498:b016])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:734c:b0:398:7796:7823 with SMTP id adf61e73a8af0-39c8a6c2c3dmr53801637.6.1774563871440;
 Thu, 26 Mar 2026 15:24:31 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:13 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=7205;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=/JytenNZfjjNb9hRJUQg500AB0c4FxxGLQWAYRKsn0w=; b=4r4+flO7ttXNdQ93SWrdcLKha6lQNoz8f2QPBrxTfNAA72iRfUoeW262p0DxOmnmH5JuJg7+G
 HNG+G6sGKY1BRkJ5Tm/HoIP7Ry3hoOe95oqZJa1ynzR3czBKZW15qf6
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-4-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 04/44] KVM: Stub in ability to disable per-VM memory
 attribute tracking
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
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sean Christopherson <seanjc@google.com>

Introduce the basic infrastructure to allow per-VM memory attribute
tracking to be disabled. This will be built-upon in a later patch, where a
module param can disable per-VM memory attribute tracking.

Split the Kconfig option into a base KVM_MEMORY_ATTRIBUTES and the
existing KVM_VM_MEMORY_ATTRIBUTES. The base option provides the core
plumbing, while the latter enables the full per-VM tracking via an xarray
and the associated ioctls.

kvm_get_memory_attributes() now performs a static call that either looks up
kvm->mem_attr_array with CONFIG_KVM_VM_MEMORY_ATTRIBUTES is enabled, or
just returns 0 otherwise. The static call can be patched depending on
whether per-VM tracking is enabled by the CONFIG.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 include/linux/kvm_host.h        | 23 ++++++++++++---------
 virt/kvm/Kconfig                |  4 ++++
 virt/kvm/kvm_main.c             | 44 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index cf3d2bdababc7..537f25121e345 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2329,7 +2329,7 @@ void kvm_configure_mmu(bool enable_tdp, int tdp_forced_root_level,
 		       int tdp_max_root_level, int tdp_huge_page_level);
 
 
-#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
 #define kvm_arch_has_private_mem(kvm) ((kvm)->arch.has_private_mem)
 #endif
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4ba42a1278d5f..5393854ca5966 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2513,19 +2513,15 @@ static inline bool kvm_memslot_is_gmem_only(const struct kvm_memory_slot *slot)
 	return slot->flags & KVM_MEMSLOT_GMEM_ONLY;
 }
 
-#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
+typedef unsigned long (kvm_get_memory_attributes_t)(struct kvm *kvm, gfn_t gfn);
+DECLARE_STATIC_CALL(__kvm_get_memory_attributes, kvm_get_memory_attributes_t);
+
 static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
 {
-	return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
+	return static_call(__kvm_get_memory_attributes)(kvm, gfn);
 }
 
-bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
-				     unsigned long mask, unsigned long attrs);
-bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
-					struct kvm_gfn_range *range);
-bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
-					 struct kvm_gfn_range *range);
-
 static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 {
 	return kvm_get_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
@@ -2535,6 +2531,15 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 {
 	return false;
 }
+#endif
+
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
+				     unsigned long mask, unsigned long attrs);
+bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
+					struct kvm_gfn_range *range);
+bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
+					 struct kvm_gfn_range *range);
 #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 
 #ifdef CONFIG_KVM_GUEST_MEMFD
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 5119cb37145fc..3fea89c45cfb4 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -100,7 +100,11 @@ config KVM_ELIDE_TLB_FLUSH_IF_YOUNG
 config KVM_MMU_LOCKLESS_AGING
        bool
 
+config KVM_MEMORY_ATTRIBUTES
+       bool
+
 config KVM_VM_MEMORY_ATTRIBUTES
+       select KVM_MEMORY_ATTRIBUTES
        bool
 
 config KVM_GUEST_MEMFD
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 793a2c8476b09..dbdcef90a4950 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -102,6 +102,17 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(halt_poll_ns_shrink);
 static bool allow_unsafe_mappings;
 module_param(allow_unsafe_mappings, bool, 0444);
 
+#ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+static bool vm_memory_attributes = true;
+#else
+#define vm_memory_attributes false
+#endif
+DEFINE_STATIC_CALL_RET0(__kvm_get_memory_attributes, kvm_get_memory_attributes_t);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(STATIC_CALL_KEY(__kvm_get_memory_attributes));
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(STATIC_CALL_TRAMP(__kvm_get_memory_attributes));
+#endif
+
 /*
  * Ordering of locks:
  *
@@ -2425,7 +2436,7 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
 }
 #endif /* CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT */
 
-#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
 static u64 kvm_supported_mem_attributes(struct kvm *kvm)
 {
 #ifdef kvm_arch_has_private_mem
@@ -2436,6 +2447,12 @@ static u64 kvm_supported_mem_attributes(struct kvm *kvm)
 	return 0;
 }
 
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+static unsigned long kvm_get_vm_memory_attributes(struct kvm *kvm, gfn_t gfn)
+{
+	return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
+}
+
 /*
  * Returns true if _all_ gfns in the range [@start, @end) have attributes
  * such that the bits in @mask match @attrs.
@@ -2632,7 +2649,24 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
 
 	return kvm_vm_set_mem_attributes(kvm, start, end, attrs->attributes);
 }
+#else  /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
+static unsigned long kvm_get_vm_memory_attributes(struct kvm *kvm, gfn_t gfn)
+{
+	BUILD_BUG_ON(1);
+}
 #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
+static void kvm_init_memory_attributes(void)
+{
+	if (vm_memory_attributes)
+		static_call_update(__kvm_get_memory_attributes,
+				   kvm_get_vm_memory_attributes);
+	else
+		static_call_update(__kvm_get_memory_attributes,
+				   (void *)__static_call_return0);
+}
+#else  /* CONFIG_KVM_MEMORY_ATTRIBUTES */
+static void kvm_init_memory_attributes(void) { }
+#endif /* CONFIG_KVM_MEMORY_ATTRIBUTES */
 
 struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn)
 {
@@ -4932,6 +4966,9 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 		return 1;
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 	case KVM_CAP_MEMORY_ATTRIBUTES:
+		if (!vm_memory_attributes)
+			return 0;
+
 		return kvm_supported_mem_attributes(kvm);
 #endif
 #ifdef CONFIG_KVM_GUEST_MEMFD
@@ -5338,6 +5375,10 @@ static long kvm_vm_ioctl(struct file *filp,
 	case KVM_SET_MEMORY_ATTRIBUTES: {
 		struct kvm_memory_attributes attrs;
 
+		r = -ENOTTY;
+		if (!vm_memory_attributes)
+			goto out;
+
 		r = -EFAULT;
 		if (copy_from_user(&attrs, argp, sizeof(attrs)))
 			goto out;
@@ -6528,6 +6569,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	kvm_preempt_ops.sched_in = kvm_sched_in;
 	kvm_preempt_ops.sched_out = kvm_sched_out;
 
+	kvm_init_memory_attributes();
 	kvm_init_debug();
 
 	r = kvm_vfio_ops_init();

-- 
2.53.0.1018.g2bb0e51243-goog

