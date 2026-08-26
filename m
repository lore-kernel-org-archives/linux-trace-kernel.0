Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0363D75D3
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735918; cv=none; b=kXcBYfsSv+kbPTrxcQpnVlZNPO/MoJJPn66+kamuJA+mylSPyFJzWJFSyjVmo6Zv1/h5WhtpXLnSN3B1BLy/o45gOLK51w0y9LHFPWoQNGhMinueEVp3ZQ2aCQBg70cPGK2CyT4yUeQCq/yJ2EVZo+gn/EwfFkBFBLq0n46gVNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735918; c=relaxed/simple;
	bh=cfKDOJ7DvEwyC5tuG3+q7zNHiwlxy7Kdncb8W2kXAdk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uMlYxknEUCsZ+n6pNonNMeUfVwBpwfdAPvm8bVlN8u7ir+T/PMf830dD1Xwlq0PhaELSevr1PSrVKfplrcwMSX2UuwBUJCqUt+HNpg8DrhhmYmnxykBqnX+vswp0lNOpLoZxGfZc52Vuf6c9zvSAKi1VhHRSTTfsQmza+RAuFW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HaGzLzsf; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HaGzLzsf"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbb467e56aaso608857a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735914; x=1788340714; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=63KksNRMPLdKIK2ffHPVavSJlAIn7eLDeJF6HOKSRZE=;
        b=HaGzLzsfaRLYI+8f3pewk6V6GuRHC2wrFnu/hnV41aGesT1Yog/7se8mNHBA7mcbov
         TcXho5/9BI9q2Qalr9uuGDOCc3M04duvr0wlU65pT9f6EO4N2c81mKtmkbVd4KuEko3R
         OhgXnHusw2R8oQsuwscZ1Wh5/V9IT2z4GD4j46QlLtiWEERSqzB5wN1InuAzUurG0PD6
         3euBYXUHW2r7zq3dOmpJ87rgQOxUffecK2JR2JtkgiS534qobWNCsUqZ9Rl1Z2B26/sD
         lP1yA6X7doraZBVlpwyOQckSiAL3pO4OO9S8tTssPaGgX+nHCvpZSdo/M08oMw6RGdoX
         x7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735914; x=1788340714;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=63KksNRMPLdKIK2ffHPVavSJlAIn7eLDeJF6HOKSRZE=;
        b=SXcgS9dj9oKhlvifvyLqyAYVeK9xcDpSxubxRyr/QPC02bMO5jTbrnpBNyZDRxwj0g
         c4YVjuCDRV+sddbxikz/Ztgo3saxSB838qnRxJjGfXmwj7O/phiMVU2FXes7DAsFTVfc
         IZII8u433wmA3OQKeSaRxlh43Abay5OLQzNRrTO9LyJoZ+4HxcEbIV/c0FeGsY7Ej6/T
         mF4qTPANsGcEdR7DxdS6Roeb3gzMxwP1C3GNKx9ly+Ps7qW7FBglCgEeQWzctob7Lg6Y
         AmY7Ap+l6XuovjBrkIEabu8UjSphzy3ZoWfwK2/jvZUFxF3t56k6wCfPSPmr9ekebkZz
         Plsw==
X-Forwarded-Encrypted: i=1; AHgh+RrAdthDofR2WdQqwJz1K8VKdy1LwX9aumj4tNEnsZuv8fdKx+RzTG4FZiwJkPSj/ozjHWPe/DZcn2GSoCaVQ1BocCk=@vger.kernel.org
X-Gm-Message-State: AFuF++n1J0Ap0KY9YL2IICFZ5pr5SXpOmYcB7RRXVkUNmFsTD5hrZGy3
	C63Dy7N7jv1DSkL7sv0O5QThvX1SMGqqiPMhBV09Tb73+QiHj7KqGkaagKVMwrRaK5UJoNjGTnn
	gMDyVGjrHCEUdO9Fj1ZTFUjZtZw==
X-Received: from pgcz13.prod.google.com ([2002:a63:7e0d:0:b0:c86:2164:967d])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:8986:b0:3d0:868d:8ccb with SMTP id adf61e73a8af0-3d0868d974amr686524637.13.1787735913113;
 Wed, 26 Aug 2026 02:18:33 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:13 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=6544;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=cfKDOJ7DvEwyC5tuG3+q7zNHiwlxy7Kdncb8W2kXAdk=; b=MMZaGAECpxklCf2BKRBYFhvWtCwjdKJ8nlLlIDN+BD1CFA4tZxsvWwbrbFHu/A54MMIyO+isw
 yfuQGoiyfH3Bt4RFA1hwR5XmAFrKGC9Lj6QAvTwtAmzCBhMn2uA7O3f
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-15-0a15d8a799aa@google.com>
Subject: [PATCH v11 15/46] KVM: guest_memfd: Call arch make_shared callback
 for to-shared conversion
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
	Fuad Tabba <fuad.tabba@linux.dev>
Content-Type: text/plain; charset="utf-8"

When memory in guest_memfd is converted from private to shared, the
platform-specific state associated with the guest-private pages must be
invalidated or cleaned up.

Iterate over the folios in the affected range and call the
kvm_arch_gmem_make_shared() hook for each PFN range. This allows
architectures to update hardware metadata or encryption states to
transition pages to the shared state.

Invoke this helper after indicating to KVM's mmu code that an invalidation
is in progress to stop in-flight page faults from succeeding. Calling the
invalidation helper also calls the arch invalidate hook. For SNP, this
kicks any vCPU with a registered VMSA within the range being converted out
of the guest. This ensures that make_shared never fails due to the VMSA
page being in-use and is important because if make_shared fails, the RMP
table would track the page as private while guest_memfd is unaware and
tracks the page as shared.

Omit support for calling the arch hook to make private, since SNP, the only
implementer of the arch make-private hook today, would actually prefer
making private only just before faulting memory into the NPTs.

Calling the make-private arch hook would require iterating both bindings
and the filemap to find the intersection of bindings and allocated
folios. On top of that, SNP would need to figure out whether to actually
make private based on whether the memory is about to be faulted, or
whether it is a conversion.

Calling the make-shared arch hook and not the make-private arch hook does
leak SNP-specific details into guest_memfd (as in, why only make-shared
during conversions but not make-private?), but the additional complexity is
not worth taking on until guest_memfd has a user actually requiring an arch
make-private call.

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  2 +-
 arch/x86/include/asm/kvm_host.h    |  2 +-
 arch/x86/kvm/x86.c                 |  5 +++++
 include/linux/kvm_host.h           |  1 +
 virt/kvm/guest_memfd.c             | 42 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index e213c9ae3e301..67b43c167045b 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -150,7 +150,7 @@ KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
 KVM_X86_OP_OPTIONAL_RET0(gmem_make_private)
 #endif
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
+#if defined(CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT) || defined(CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM)
 KVM_X86_OP_OPTIONAL(gmem_make_shared)
 #endif
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 744c1f6ff03ed..83e26ce45fb79 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1732,7 +1732,7 @@ struct kvm_x86_ops {
 	int (*gmem_make_private)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 				 kvm_pfn_t nr_pages);
 #endif
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
+#if defined(CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT) || defined(CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM)
 	void (*gmem_make_shared)(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
 #endif
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 29e41d334cedf..147b3e529cd26 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10653,6 +10653,11 @@ int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 {
 	return kvm_x86_call(gmem_make_private)(kvm, gfn, pfn, nr_pages);
 }
+
+void kvm_arch_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages)
+{
+	kvm_x86_call(gmem_make_shared)(pfn, nr_pages);
+}
 #endif
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ab87effdd221f..485f18454eb45 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2610,6 +2610,7 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
 
 int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 			       kvm_pfn_t nr_pages);
+void kvm_arch_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
 #ifndef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
 #define kvm_arch_has_gmem_convert() false
 #endif
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index e4722eb6405b6..d1134b23576e4 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -575,6 +575,43 @@ static bool kvm_gmem_has_outstanding_references(struct inode *inode,
 	return has_outstanding;
 }
 
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
+static void kvm_gmem_make_shared(struct inode *inode, pgoff_t start, pgoff_t end)
+{
+	struct folio_batch fbatch;
+	pgoff_t next = start;
+	int i;
+
+	folio_batch_init(&fbatch);
+	while (filemap_get_folios(inode->i_mapping, &next, end - 1, &fbatch)) {
+		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
+			struct folio *folio = fbatch.folios[i];
+			pgoff_t start_index, end_index;
+			kvm_pfn_t start_pfn;
+			kvm_pfn_t nr_pages;
+
+			start_index = max(start, folio->index);
+			end_index = min(end, folio_next_index(folio));
+			/*
+			 * end_index is either in folio or points to
+			 * the first page of the next folio. Hence,
+			 * all pages in range [start_index, end_index)
+			 * are contiguous.
+			 */
+			start_pfn = folio_file_pfn(folio, start_index);
+			nr_pages = end_index - start_index;
+
+			kvm_arch_gmem_make_shared(start_pfn, nr_pages);
+		}
+
+		folio_batch_release(&fbatch);
+		cond_resched();
+	}
+}
+#else
+static void kvm_gmem_make_shared(struct inode *inode, pgoff_t start, pgoff_t end) {}
+#endif
+
 static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
 				     size_t nr_pages, uint64_t attrs,
 				     pgoff_t *err_index)
@@ -624,7 +661,12 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
 
 	filter = to_private ? KVM_FILTER_SHARED : KVM_FILTER_PRIVATE;
 	kvm_gmem_invalidate_start(inode, start, end, filter);
+
+	if (!to_private && kvm_arch_has_gmem_convert())
+		kvm_gmem_make_shared(inode, start, end);
+
 	mas_store_prealloc(&mas, xa_mk_value(attrs));
+
 	kvm_gmem_invalidate_end(inode, start, end);
 out:
 	filemap_invalidate_unlock(mapping);

-- 
2.55.0.887.g758fc8c411-goog

