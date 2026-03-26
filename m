Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AD534C140
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563877; cv=none; b=GV3sm+DLKVoPIuMQbPna8tFWfqIC3AYVTMA+2cR6ouJFJlfu0tHOGa7/r+j04paesCUuUdhLxI2yjeWj2kaTvodAGZ+LagHCIDZwxVfoN1DKoHR6ZSqEiBuYL/G3Yg1fGfp6BB0kV+gNFN1WnJrkKeEafS72qZLxXXKTM8lKsZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563877; c=relaxed/simple;
	bh=i32Zv1Qc2V8hto0b0Lqq2MavvvgIuECmKPzYxYPEz1A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cRSIsYQoFGnFoErr0q/NaRoR5xMTTihi/eAZH3G42fcErrbT22emy2yXOVBkr/lABWjcmzA7F76v8rCMPTNFzUf1egJ7Fqm+LncQIYyDiaAhXZ7XNBZHDKSrpYjLqneyk/NeTtjf6Epd7OQHRmepRWN+BMH+crOLnzWjVynelT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VZvyf41H; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VZvyf41H"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c699d8caaso2755607b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563875; x=1775168675; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n14jCm7yu9LC/vBpPkzyqFC4opRbuCMIWsyoVMZR2YQ=;
        b=VZvyf41HUbtzVJpBJqAmBrPEHmGI8wWJEnE56c38ZKtOUv1EcdseYFvMJtiE7BOdk5
         LgZH4iiZDmGQojcaZjcc3iVzN634SHD7m4ObhGISbjn0KhehCtFctWhetnPTaHVnpglF
         RqU3a5R78/fGELBvPYlwQbUCAsS1G97sKyP/WdoiGfQeUbPffhFBfb0iu2ZrltZVnQl8
         DdQlQmiJTKCt5zqDNZTqBoskVsJ/sAxG/jQOP7X8mjB6QWLZeBvPn3abD4dgwb00Uv8d
         wP5LKYAaQom0KENffiX8aBZFm+sqvYB7Smw6ehdTDK37DoewHDpqMIWf1SBT3xROW5fT
         v/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563875; x=1775168675;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n14jCm7yu9LC/vBpPkzyqFC4opRbuCMIWsyoVMZR2YQ=;
        b=RHJ3rkScHIkRNlQ2jSZ0K89b4cTB+JfBYW96wasQy6yBwrJAfn9zPKmkuQ7PdbEav2
         VwvZSFI/+acVQOIjn/m6ehnksWY1Dyfs9jOY3cDckv8DEl2biaXBLJd1IbzmSetvApq5
         TrwrMYjtL4f99rqtQnjMOleVFyguAYoYGbeplkLdcAgWLwoKCgiIbvPxWmfFDmuUOJUr
         jzoQfUc7Fqra4w1QNe4v6fJr8uagnyulhzcCaxmH9abA8JUFLuAPbLGVzCTbcOzl12QY
         2aZjxtdEbwhAbhKf9Y2i3FWpu0BRana4vj46s7jqrHZYomNJa6JWTaYkDVHdD2IFj/Hd
         vPbg==
X-Forwarded-Encrypted: i=1; AJvYcCUf9TzBfWYssLiTvFuMr3ft2MgehpEgo3DmLexoAiCpZHMKQXSLpMgJiA4eAu0xf4VzHpZzzERqBpK3Xpl7MwfCxOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqPD6njiG3yALgppPEHJ2B5wfntTBkMHiJFZ3QRp/84L2kWXVy
	ge90wmQNKciJ1HLRlMGlYXsAN/F9yjdLfY37xyQTszPaCZUGvgDmHJqStHImrZ8HpkJar6ofGdD
	IMG2m0lRQDLmmqY8TJCTx141gmw==
X-Received: from pfbhw2.prod.google.com ([2002:a05:6a00:8902:b0:829:9a65:4170])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:23c8:b0:82a:805a:7cc with SMTP id d2e1a72fcca58-82c959d4be3mr153491b3a.4.1774563874655;
 Thu, 26 Mar 2026 15:24:34 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:14 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=3889;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=nVwpFGhdInAIYcCOHyVf1SHbYDR/5EzcpRzGcQJhTh0=; b=lflg/f6MMNyq8okFwTq8rOBXOZkFUGGSvNBdwadMelTajGXnQi6GmTxDhWAO0pxC0zzFjJp3+
 HdOJ+KijHgvBGAbFtTm0ldKzRrFPcdzb6FLv+Jrlabq3WDMpA8igjmx
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-5-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 05/44] KVM: guest_memfd: Wire up kvm_get_memory_attributes()
 to per-gmem attributes
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

Implement kvm_gmem_get_memory_attributes() for guest_memfd to allow the KVM
core and architecture code to query per-GFN memory attributes.

kvm_gmem_get_memory_attributes() finds the memory slot for a given GFN and
queries the guest_memfd file's to determine if the page is marked as
private.

If vm_memory_attributes is not enabled, there is no shared/private tracking
at the VM level. Install the guest_memfd implementation as long as
guest_memfd is enabled to give guest_memfd a chance to respond on
attributes.

guest_memfd should look up attributes regardless of whether this memslot is
gmem-only since attributes are now tracked by gmem regardless of whether
mmap() is enabled.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/kvm_host.h |  2 ++
 virt/kvm/guest_memfd.c   | 37 +++++++++++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c      |  3 +++
 3 files changed, 42 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5393854ca5966..0f84421b3f49e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2542,6 +2542,8 @@ bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 					 struct kvm_gfn_range *range);
 #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 
+unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn);
+
 #ifdef CONFIG_KVM_GUEST_MEMFD
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		     gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index aa2caf5114da2..6f4252c8b3f59 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -515,6 +515,43 @@ static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
+{
+	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
+	struct inode *inode;
+	unsigned long attrs;
+
+	/*
+	 * If this gfn has no associated memslot, there's no chance of the gfn
+	 * being backed by private memory, since guest_memfd must be used for
+	 * private memory, and guest_memfd must be associated with some memslot.
+	 */
+	if (!slot)
+		return 0;
+
+	CLASS(gmem_get_file, file)(slot);
+	if (!file)
+		return 0;
+
+	inode = file_inode(file);
+
+	/*
+	 * Acquire the filemap lock to ensure the mtree lookup gets a
+	 * stable result.  The caller _must_ still protect consumption
+	 * of private vs. shared by checking
+	 * mmu_invalidate_retry_gfn() under mmu_lock to serialize
+	 * against ongoing attribute updates.  Acquiring the filemap
+	 * lock only ensures a stable _lookup_, the result can become
+	 * stale as soon as the lock is dropped.
+	 */
+	filemap_invalidate_lock_shared(inode->i_mapping);
+	attrs = kvm_gmem_get_attributes(inode, kvm_gmem_get_index(slot, gfn));
+	filemap_invalidate_unlock_shared(inode->i_mapping);
+
+	return attrs;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_memory_attributes);
+
 static struct file_operations kvm_gmem_fops = {
 	.mmap		= kvm_gmem_mmap,
 	.open		= generic_file_open,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index dbdcef90a4950..7bb59679c9316 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2660,6 +2660,9 @@ static void kvm_init_memory_attributes(void)
 	if (vm_memory_attributes)
 		static_call_update(__kvm_get_memory_attributes,
 				   kvm_get_vm_memory_attributes);
+	else if (IS_ENABLED(CONFIG_KVM_GUEST_MEMFD))
+		static_call_update(__kvm_get_memory_attributes,
+				   kvm_gmem_get_memory_attributes);
 	else
 		static_call_update(__kvm_get_memory_attributes,
 				   (void *)__static_call_return0);

-- 
2.53.0.1018.g2bb0e51243-goog

