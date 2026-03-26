Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE0733F385
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563879; cv=none; b=A4rb5ZYDOadi4LsmqMoP2bU8zvkihz6otKKeaLfr93MP8oYgV4t4vVZJyd6slj+Uv4NoFOaA9awV40Yo7ehWrNn8QA78a8fZGr+D3QFW4KzprFXL3NVu8qy2rcoGa3SnZwjzd6whzYAZFibs853Ql4k1lPE22bF+oQvkJD3nd4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563879; c=relaxed/simple;
	bh=vymNc3F4VBBGneenNd8IucPbAr1SdMuDYSLrejXwwUQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i1coSM4YMY+mr8Ig/59znBivqI/LvmCqPMONqn1xJWlBO0yOuaAT3/v1Ls1clTvqzVQqBnqoFxXkAQfqvFKj1v7iKQ3SWGeLZFWdE6hbQTlLGKNQHd3Sp6MZk8C+wZJtcThcMNkUrnEBakdvqVl8BNDZf6tduYamTheuBZRZ12Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WvS3T43J; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WvS3T43J"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7414516609so1052936a12.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563877; x=1775168677; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L64Ei+w9HuDhN4D3+e2YG8ZNRPlnX30IypUuq/5FXOw=;
        b=WvS3T43J3zS+dqWZKkD72bxGuh/DRC7k99vWg6cNrpeDpwBce62OJevZJyx1T3qf2G
         JLw7FG/b7KExzKtwxbOvFWtuy6wEinO2f53sxcByXEiGTzi7pDEmm5vy3OH34o+luYLv
         itz1xBfxYzz3XpHpGiGjHPGRydjYHvfbMAUXFhR9aB+i99QixPScIPvMWN+5Cz9ukWy9
         INPOn7OI4eHMwhQ04Ywzik3jd6vfYpSV6a4EeQ4qt71xy+ynQFzI9nDUx9Fhbl38hVon
         tAm6EyEb7sIbx+t1AOInonKcqtZlot1fkHStKv7e5AvwnxfBY4bQTpU44WoUZ/NzY3jk
         2vBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563877; x=1775168677;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L64Ei+w9HuDhN4D3+e2YG8ZNRPlnX30IypUuq/5FXOw=;
        b=iZGvbMYJi6knt7PQJFbDZNzciDX/vc+6W3PSyXRr21Q9X7JlNmycbr/nF8hq9pLZue
         CyPhW9YLd5x5b1xuo3LsbdQWgJ/CUk5+zxrKJDm5JD1n3UpqvL+yreYow6rbQDxX0itJ
         i4/078oWb0wO8/D67Wr8iKk/6PD05CeQr7O1onuaSqf3dQXXZkmQ4DLbjvFwugIPHEua
         ntmIRMq4OTTiHDA13YLEYVFWkMTj2STHcEK+a7G8wFGFfAm9UTS2FCAfgPWmgy93qr11
         NChS6T+a7z2okY5XDsuFKjxxf8XERmHyS0/P4LeLVKWihbJM4vfj5I6BjfpSi6/ZABG+
         z5Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUpl4n84GDottAc1PPYGBlf3BvNw5+VX0TgdJ9TiJNCTAMyQxW5vKS/rwcjPU5JCQf1f/4e/y6j/AN+ZqT5m/TyZzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3w55RB2AJWaz2BAbmQcLKLE/lRVYRaB5hccoK8PTFgQXLHFKG
	79rrd/1fZI6jszmnMHtjRWMWCuyQL0DDPtRKy/jwqGiUY9169AckwBQ4E+2v+jx6HxGYBltXKuE
	SNd70oQikfSs+pGNrhmz+8K7tmw==
X-Received: from pgbcr6.prod.google.com ([2002:a05:6a02:4106:b0:c73:c1e2:84e7])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:431d:b0:38d:ee4a:e82f with SMTP id adf61e73a8af0-39c87c4aed6mr312128637.63.1774563876758;
 Thu, 26 Mar 2026 15:24:36 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:15 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=5802;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=vymNc3F4VBBGneenNd8IucPbAr1SdMuDYSLrejXwwUQ=; b=1LWUYI7gs645uKY5pvp+JN0SJPLpfIcJb5vTHCCN4uONoDtA/ZkQwB57ZGcilNgQcL6dc3IRn
 laHi/lbCytrCWoczD6QHAkpcw7DrsnR7zLOahw4n2P3/9JSmm1eBIJs
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-6-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 06/44] KVM: guest_memfd: Update kvm_gmem_populate() to
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
index 6f4252c8b3f59..b6ffa8734175d 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -936,12 +936,31 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
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
+		if (xa_to_value(entry) != KVM_MEMORY_ATTRIBUTE_PRIVATE)
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
@@ -956,9 +975,8 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
 
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
2.53.0.1018.g2bb0e51243-goog

