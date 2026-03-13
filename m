Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC19F3659F7
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382379; cv=none; b=nz8xWQJwziqi/i+P/2EbvAMEc8HfDpaP6LxVtk9FND7RDFFqlxAWajBobCGoSIhmd3adEnIRc3Z4sjMazW6RIkW+tQX+u7T+aXaeLQCNpwAI6zYqnGlxEPfMauF1kNeQsrFN6wL6FZCQKY9RDj6Q1bWUdRcMAoMQKPRcHlfUsnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382379; c=relaxed/simple;
	bh=6l4gROx7jzaHEpW5EeWmylCHb6Dln97vDEPH0vMevUU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oLQ0l4KhE62jERZuS+ZseEeh5bHBEQvIYNcPwyjGBA7RF4mR31hB8FxHx4BTvXcJqfeQVEODaZbH8u475q410jXaFjF62OjwxwF3nAQMsOAQ5sqNyIaTRz6vhkYj+LC3iweexbAavJnQSPUenSGTbXlNi6x46PobmPtAteztGxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s6X+udTa; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s6X+udTa"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3595485abbbso1929423a91.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382377; x=1773987177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gcDmUTz+2QJCEjrFt10fJ/5y22/0S6e6j1N3ESHDYEw=;
        b=s6X+udTaeHfaxforCrc3BHP2tH7KdreFjHz1dC5tqs/S6B+uTHNFBAHF/oTDjE2DCK
         mWnJBtCoouS0Yb8eVC/xGe2A34vFbalVuoCiYuLX6oAxHSvBsCCsBlQfibNc0GlM+w+l
         Dz8kqQk8Y+IlvkUJabkb+GakANKo32WhaFlzHMzJ+G9oNb+sl6orclxZ/pHX8CJe6s7G
         E/NQXrwRtjHbp4A8EW9wmRpk/m0+TnuHfqNNH+OlLvkjkw2HJ9BP6mQiwv1Eh8ATknmh
         93a/7yF938mvtkoZCQoKRY1U+PW82PVCP+ZiLWgdsRF1m8MtlSMkFtMaMcWsdSy6IIRv
         jm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382377; x=1773987177;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gcDmUTz+2QJCEjrFt10fJ/5y22/0S6e6j1N3ESHDYEw=;
        b=d3BxkOnsFbfuBErpPzFGKe/MFAK5HmbdfovdFJvbdXINvASbFTBd+o5F3Ef91BU/3E
         Tdgy+2TrQh9K8Jn2Vdvdu7bI1PmNVjomclRLC0SmCNvv7EhxASJhNMQowlm5NVAV/XWg
         YlI3PFhOx+TTxJo8sain6Pf05gzyqOL9IxZLR4YJ1lvXKuFqWBY/M3P0oTzIY98NG9Am
         TTQ3DVutTBUOIrIDuMlMROxEgN2biywLhGGzAIpptLNeGFez/DogZg+izkbn09s4kVYD
         etS930F4RFiYH5UR7QIJQWXHDeSaeaHOoY+Zy+1uVNQPTsShz0ugjzbMy26BqZ2NPczr
         7+Yg==
X-Forwarded-Encrypted: i=1; AJvYcCW12x1DNFUTi02JH3KOFjZdYe7E5KBYJW7LLzObUWClO3U1APV0RyGvhjR1Hoplj/+q+aM4dxEZSog5zqMRHQuIC+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2zNIx7V9OXGhRfV7RY8MpTrzjqciy6LB6BRzmTmShJ+WBenII
	TPTVC+FKADLtW/pcqR3KPYpIRnzIhTgwagbCwWDpSkt0VtG/rJdHFVhiND7YI/O5rahuNGby8iB
	oj30dxqxo8r1jg7m7fVawgdrm6g==
X-Received: from pjbie24.prod.google.com ([2002:a17:90b:4018:b0:359:8bb2:c98d])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3f85:b0:359:ff8a:ee52 with SMTP id 98e67ed59e1d1-35a21e4edbamr1952130a91.6.1773382376871;
 Thu, 12 Mar 2026 23:12:56 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:12:45 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=5783;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=6l4gROx7jzaHEpW5EeWmylCHb6Dln97vDEPH0vMevUU=; b=sCHE4aruHhHNVBD2yopcHXCLUXwh+U3kB1yeszQMikNVOBJ9YprFXvSYO12Y8Y2hLpbvia8xs
 bx8ztRQait9DRBntyze/Gr5L9dhTy5q66mCYMrvVSzvfiBH4+mIYFoW
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-6-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 06/43] KVM: guest_memfd: Update kvm_gmem_populate() to
 use gmem attributes
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

Update the guest_memfd populate() flow to pull memory attributes from the
gmem instance instead of the VM when KVM is not configured to track
shared/private status in the VM.

Rename the per-VM API to make it clear that it retrieves per-VM
attributes, i.e. is not suitable for use outside of flows that are
specific to generic per-VM attributes.

Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/mmu/mmu.c   |  2 +-
 include/linux/kvm_host.h | 14 +++++++++++++-
 virt/kvm/guest_memfd.c   | 24 +++++++++++++++++++++---
 virt/kvm/kvm_main.c      |  8 +++-----
 4 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 792701b093234..f21e16f22dd7b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7978,7 +7978,7 @@ static bool hugepage_has_attrs(struct kvm *kvm, struct kvm_memory_slot *slot,
 	const unsigned long end = start + KVM_PAGES_PER_HPAGE(level);
 
 	if (level == PG_LEVEL_2M)
-		return kvm_range_has_memory_attributes(kvm, start, end, ~0, attrs);
+		return kvm_range_has_vm_memory_attributes(kvm, start, end, ~0, attrs);
 
 	for (gfn = start; gfn < end; gfn += KVM_PAGES_PER_HPAGE(level - 1)) {
 		if (hugepage_test_mixed(slot, gfn, level - 1) ||
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 0f84421b3f49e..19f026f8de390 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2534,12 +2534,24 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 #endif
 
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
-bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
+extern bool vm_memory_attributes;
+bool kvm_range_has_vm_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 				     unsigned long mask, unsigned long attrs);
 bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 					struct kvm_gfn_range *range);
 bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 					 struct kvm_gfn_range *range);
+#else
+#define vm_memory_attributes false
+static inline bool kvm_range_has_vm_memory_attributes(struct kvm *kvm,
+						      gfn_t start, gfn_t end,
+						      unsigned long mask,
+						      unsigned long attrs)
+{
+	WARN_ONCE(1, "Unexpected call to kvm_range_has_vm_memory_attributes()");
+
+	return false;
+}
 #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 
 unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn);
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index e93e95940ec74..501f4d6e87909 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -931,12 +931,31 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
+static bool kvm_gmem_range_is_private(struct gmem_inode *gi, pgoff_t index,
+				      size_t nr_pages, struct kvm *kvm, gfn_t gfn)
+{
+	pgoff_t end = index + nr_pages - 1;
+	void *entry;
+
+	if (vm_memory_attributes)
+		return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
+						       KVM_MEMORY_ATTRIBUTE_PRIVATE,
+						       KVM_MEMORY_ATTRIBUTE_PRIVATE);
+
+	mt_for_each(&gi->attributes, entry, index, end) {
+		if (xa_to_value(entry) != attributes)
+			return false;
+	}
+
+	return true;
+}
 
 static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
 				struct file *file, gfn_t gfn, struct page *src_page,
 				kvm_gmem_populate_cb post_populate, void *opaque)
 {
 	pgoff_t index = kvm_gmem_get_index(slot, gfn);
+	struct gmem_inode *gi;
 	struct folio *folio;
 	kvm_pfn_t pfn;
 	int ret;
@@ -951,9 +970,8 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
 
 	folio_unlock(folio);
 
-	if (!kvm_range_has_memory_attributes(kvm, gfn, gfn + 1,
-					     KVM_MEMORY_ATTRIBUTE_PRIVATE,
-					     KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
+	gi = GMEM_I(file_inode(file));
+	if (!kvm_gmem_range_is_private(gi, index, 1, kvm, gfn)) {
 		ret = -EINVAL;
 		goto out_put_folio;
 	}
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 7bb59679c9316..70b594dafc5cc 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -104,9 +104,7 @@ module_param(allow_unsafe_mappings, bool, 0444);
 
 #ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
-static bool vm_memory_attributes = true;
-#else
-#define vm_memory_attributes false
+bool vm_memory_attributes = true;
 #endif
 DEFINE_STATIC_CALL_RET0(__kvm_get_memory_attributes, kvm_get_memory_attributes_t);
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(STATIC_CALL_KEY(__kvm_get_memory_attributes));
@@ -2457,7 +2455,7 @@ static unsigned long kvm_get_vm_memory_attributes(struct kvm *kvm, gfn_t gfn)
  * Returns true if _all_ gfns in the range [@start, @end) have attributes
  * such that the bits in @mask match @attrs.
  */
-bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
+bool kvm_range_has_vm_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 				     unsigned long mask, unsigned long attrs)
 {
 	XA_STATE(xas, &kvm->mem_attr_array, start);
@@ -2591,7 +2589,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	mutex_lock(&kvm->slots_lock);
 
 	/* Nothing to do if the entire range has the desired attributes. */
-	if (kvm_range_has_memory_attributes(kvm, start, end, ~0, attributes))
+	if (kvm_range_has_vm_memory_attributes(kvm, start, end, ~0, attributes))
 		goto out_unlock;
 
 	/*

-- 
2.53.0.851.ga537e3e6e9-goog

