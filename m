Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8763D3BE16C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735898; cv=none; b=XLTQsVjqPcHv1gDUvqSxS0lF/MgITwrP/e+15tJAm+Mru/N4FIxJAmayXp5m/YhlzZal+vs5D63lQIlXLP9ZvN2ayKLPWMWG2err9BMuCmdOXSImocqtND6DixgeJc9PNcdGcMB7QVPIYKjvuDd+Y83vNyZXYeY91bXWJn5UBaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735898; c=relaxed/simple;
	bh=3j4HP/pcwLl+LC7YJJLl650dY7sJQ8xV6gpIzCkDtX4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bYG6DK9p5DMCzq9+tdABL4zxmm5hIlBOqqTmYgkQtitWIBku3TMDDBlwlUERWR7EpdIB9r3kitmZ1aLgc+8adpPzkuI9BnO1zoYlPB/Bpjg7NAsjDZrJl2BH/B4aLgcMFXGZyhm6jlVGeZPsrpnkV2eX23wi+8LOQeuBzXqq29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wNH1h1bs; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wNH1h1bs"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d6df0a1e18so9975305ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735892; x=1788340692; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jW6qehcQroMLAfqimWC+/98gYPjKxQ/Xm+gQk2AWdxQ=;
        b=wNH1h1bsgTCFeRxIYTNIP2Dojtsxl8ypxZ9nTNnQde/bmOzwqcPOHulhtRAcSlXr8X
         0s2oFNDoU0nwCbcRUm/sPmh+b0FnFnAFizoVGfHevIY307tJaIr4DYDHR4KU0av0iueU
         ZMY9U30lZNoVPx2dRakBMbxACtou6PUHdvfynNbQ1/lLWCZbx/ICOts6FoG3fU6D+UbY
         5bEgrpq2r0vH35MzoA9Oyo4ggBAW/CKsw2vvX4Jwf82c8h5H8QDW7/PUMNMopqmOMndP
         OCftyq3FT09SZOxeYSlCDMvWKwlMb4PhOK58xsj9yIVmcTksvUc7jA7J4HnJhbbYSg5e
         o4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735892; x=1788340692;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jW6qehcQroMLAfqimWC+/98gYPjKxQ/Xm+gQk2AWdxQ=;
        b=HBfyceL1tMirZ1CCm5JtWAw6crxWMc63pjZ0UNz5QRwEjNtJxAnWIH2bWDWRGyryK5
         9Ydila8PgpxF8UtcqBvdJz9oaRtdeIkR5HxbWM6dLEpux8lErKopuYH6BbiDoPhgG4LP
         Oh99pjVB2hVhWhybnDs5QFWvnQDSRJSLyHxL0TAMuXCSCa9koWTvi/UWqQ90/DL9nTTU
         EB6DEWr90blIJNIywQlZ5isKyXqQeRb+E+KToj1GTJhFS/M6VVKyrgctNr5HLhmgApj8
         dBHFPIkUMG+KGzGaZzvJLDWAjPF1tXYQTKWypAj3XBKgHuzkSd0EFHob6I84jUpWtrbc
         EJdA==
X-Forwarded-Encrypted: i=1; AHgh+Rr8wRNqlqeU//RroHs3KNMeu4qPJMR9PrKBC1f3Wtn7g2paQuAwy1TmbrwlV2/z2IM1PApG2BJzHF00w+e0fM9FHFQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lzEMNeeq3OX7z3zW9QVP4JHqJ07JMPYDWnu4J3N8OPw6qgroMe
	VGRSP0CtQHHr6plgjwz0ciguEctzfcVb5q1osCES1qt4bchPjdRNKZC9wZJkBIemb+pgI15Qy8A
	/CzApB38TW6+RU48P5LBe8DPxCg==
X-Received: from plbkr3.prod.google.com ([2002:a17:903:803:b0:2d7:1ff:d1ee])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:11c3:b0:2cc:f5aa:9513 with SMTP id d9443c01a7336-2d707bab981mr79455195ad.10.1787735892152;
 Wed, 26 Aug 2026 02:18:12 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:01 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=8901;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=SEnzznEA5NUsL5Y4N4re64mzaHrxr3QSDUbuTg+NomA=; b=GhCAeUsftl/MAjjcKvIK0iPyIYi5/ZehgDnv1weoDN6O1ArKkXecL34ytH/RnfWRQ8sPaegrd
 FSm/zS6foADBWKsZuwKgbLzpHYu20tO75OkT63E6a1AUG8HUylRHSUC
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-3-0a15d8a799aa@google.com>
Subject: [PATCH v11 03/46] KVM: guest_memfd: Introduce per-gmem attributes,
 use to guard user mappings
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

Start plumbing in guest_memfd support for in-place private<=>shared
conversions by tracking attributes via a maple tree.  KVM currently tracks
private vs. shared attributes on a per-VM basis, which made sense when a
guest_memfd _only_ supported private memory, but tracking per-VM simply
can't work for in-place conversions as the shared/private status of a given
page needs to be per-gmem_inode, not per-VM.

Use the filemap invalidation lock to protect the maple tree, as taking the
lock for read when faulting in memory (for userspace or the guest) isn't
expected to result in meaningful contention, and using a separate lock
would add significant complexity (avoiding deadlock is quite difficult).

In kvm_gmem_get_pfn(), drop the folio refcount before releasing
filemap_invalidate_lock(). This ensures that a competing conversion request
from userspace (to be added in a later patch), which also takes the
filemap_invalidate_lock(), will never see an elevated refcount due to
kvm_gmem_get_pfn().

Co-developed-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
Co-developed-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 136 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 119 insertions(+), 17 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 2c5857a73ec94..154fc9622640d 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -4,6 +4,7 @@
 #include <linux/falloc.h>
 #include <linux/fs.h>
 #include <linux/kvm_host.h>
+#include <linux/maple_tree.h>
 #include <linux/mempolicy.h>
 #include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
@@ -34,6 +35,13 @@ struct gmem_inode {
 	struct list_head gmem_file_list;
 
 	u64 flags;
+	/*
+	 * Every index in this inode, whether memory is populated or
+	 * not, is tracked in attributes. The entire range of indices,
+	 * corresponding to the size of this inode, is represented in
+	 * this maple tree.
+	 */
+	struct maple_tree attributes;
 };
 
 static __always_inline struct gmem_inode *GMEM_I(struct inode *inode)
@@ -61,9 +69,28 @@ static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
 	return gfn - slot->base_gfn + slot->gmem.pgoff;
 }
 
+static u64 kvm_gmem_get_default_attributes(struct inode *inode)
+{
+	bool init_shared = GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED;
+
+	return init_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE;
+}
+
+static u64 kvm_gmem_get_attributes(struct inode *inode, void *entry)
+{
+	if (WARN_ON_ONCE(!entry))
+		return kvm_gmem_get_default_attributes(inode);
+
+	return xa_to_value(entry);
+}
+
 static bool kvm_gmem_is_private_mem(struct inode *inode, pgoff_t index)
 {
-	return !(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED);
+	struct maple_tree *mt = &GMEM_I(inode)->attributes;
+	void *entry = mtree_load(mt, index);
+
+	return kvm_gmem_get_attributes(inode, entry) &
+	       KVM_MEMORY_ATTRIBUTE_PRIVATE;
 }
 
 static bool kvm_gmem_is_shared_mem(struct inode *inode, pgoff_t index)
@@ -364,10 +391,13 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
 	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
 		return VM_FAULT_SIGBUS;
 
-	if (!kvm_gmem_is_shared_mem(inode, vmf->pgoff))
-		return VM_FAULT_SIGBUS;
+	filemap_invalidate_lock_shared(inode->i_mapping);
+	if (kvm_gmem_is_shared_mem(inode, vmf->pgoff))
+		folio = kvm_gmem_get_folio(inode, vmf->pgoff);
+	else
+		folio = ERR_PTR(-EACCES);
+	filemap_invalidate_unlock_shared(inode->i_mapping);
 
-	folio = kvm_gmem_get_folio(inode, vmf->pgoff);
 	if (IS_ERR(folio)) {
 		if (PTR_ERR(folio) == -EAGAIN)
 			return VM_FAULT_RETRY;
@@ -520,6 +550,51 @@ bool __weak kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
 	return true;
 }
 
+static int kvm_gmem_init_inode(struct inode *inode, loff_t size, u64 flags)
+{
+	struct gmem_inode *gi = GMEM_I(inode);
+	MA_STATE(mas, &gi->attributes, 0, (size >> PAGE_SHIFT) - 1);
+	u64 attrs;
+	int r;
+
+	inode->i_op = &kvm_gmem_iops;
+	inode->i_mapping->a_ops = &kvm_gmem_aops;
+	inode->i_mode |= S_IFREG;
+	inode->i_size = size;
+	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
+
+	/*
+	 * guest_memfd memory is neither migratable nor swappable: set
+	 * inaccessible to gate off both.
+	 */
+	mapping_set_inaccessible(inode->i_mapping);
+	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
+
+	gi->flags = flags;
+
+	mt_set_external_lock(&gi->attributes,
+			     &inode->i_mapping->invalidate_lock);
+
+	/*
+	 * Store default attributes for the entire gmem instance. Ensuring every
+	 * index is represented in the maple tree at all times simplifies the
+	 * conversion and merging logic.
+	 */
+	attrs = kvm_gmem_get_default_attributes(inode);
+
+	/*
+	 * Acquire the invalidation lock purely to make lockdep happy.  The
+	 * maple tree library expects all stores to be protected via the lock,
+	 * and the library can't know when the tree is reachable only by the
+	 * caller, as is the case here.
+	 */
+	filemap_invalidate_lock(inode->i_mapping);
+	r = mas_store_gfp(&mas, xa_mk_value(attrs), GFP_KERNEL);
+	filemap_invalidate_unlock(inode->i_mapping);
+
+	return r;
+}
+
 static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 {
 	static const char *name = "[kvm-gmem]";
@@ -550,16 +625,9 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 		goto err_fops;
 	}
 
-	inode->i_op = &kvm_gmem_iops;
-	inode->i_mapping->a_ops = &kvm_gmem_aops;
-	inode->i_mode |= S_IFREG;
-	inode->i_size = size;
-	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
-	mapping_set_inaccessible(inode->i_mapping);
-	/* Unmovable mappings are supposed to be marked unevictable as well. */
-	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
-
-	GMEM_I(inode)->flags = flags;
+	err = kvm_gmem_init_inode(inode, size, flags);
+	if (err)
+		goto err_inode;
 
 	file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR, &kvm_gmem_fops);
 	if (IS_ERR(file)) {
@@ -763,9 +831,13 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 	if (!file)
 		return -EFAULT;
 
+	filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
+
 	folio = __kvm_gmem_get_pfn(file, slot, index, pfn, max_order);
-	if (IS_ERR(folio))
-		return PTR_ERR(folio);
+	if (IS_ERR(folio)) {
+		r = PTR_ERR(folio);
+		goto out;
+	}
 
 	if (!folio_test_uptodate(folio)) {
 		clear_highpage(folio_page(folio, 0));
@@ -780,6 +852,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 	folio_unlock(folio);
 	folio_put(folio);
 
+out:
+	filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
 	return r;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
@@ -909,6 +983,15 @@ static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
 
 	mpol_shared_policy_init(&gi->policy, NULL);
 
+	/*
+	 * Memory attributes are protected by the filemap invalidation lock, but
+	 * the lock structure isn't available at this time.  Immediately mark
+	 * maple tree as using external locking so that accessing the tree
+	 * before it's fully initialized results in NULL pointer dereferences
+	 * and not more subtle bugs.
+	 */
+	mt_init_flags(&gi->attributes, MT_FLAGS_LOCK_EXTERN | MT_FLAGS_USE_RCU);
+
 	gi->flags = 0;
 	INIT_LIST_HEAD(&gi->gmem_file_list);
 	return &gi->vfs_inode;
@@ -916,7 +999,26 @@ static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
 
 static void kvm_gmem_destroy_inode(struct inode *inode)
 {
-	mpol_free_shared_policy(&GMEM_I(inode)->policy);
+	struct gmem_inode *gi = GMEM_I(inode);
+
+	mpol_free_shared_policy(&gi->policy);
+
+	/*
+	 * Note!  Checking for an empty tree is functionally necessary
+	 * to avoid explosions if the tree hasn't been fully
+	 * initialized, i.e. if the inode is being destroyed before
+	 * guest_memfd can set the external lock, lockdep would find
+	 * that the tree's internal ma_lock was not held.
+	 */
+	if (!mtree_empty(&gi->attributes)) {
+		/*
+		 * Acquire the invalidation lock purely to make lockdep happy,
+		 * the inode is unreachable at this point.
+		 */
+		filemap_invalidate_lock(inode->i_mapping);
+		__mt_destroy(&gi->attributes);
+		filemap_invalidate_unlock(inode->i_mapping);
+	}
 }
 
 static void kvm_gmem_free_inode(struct inode *inode)

-- 
2.55.0.887.g758fc8c411-goog

