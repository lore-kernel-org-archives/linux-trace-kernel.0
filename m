Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8B03542E8
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Feb 2026 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071426; cv=none; b=szGauXwejSg3Ytl/g+U7m+TL87W9ukHVCXylE+00OPqdRvIKQXOcBjtCs7QT5cYuKI3hNQj8rr+K2apGzJsFjteLODaRvCCxwc1P2uwdCD2gA5cmNAHmhIceEfvAOPEuvaQT05Z1ukwPrY03udTRsrtVaLEeCeT3pxiGLmp7nRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071426; c=relaxed/simple;
	bh=/4ze1crWALxcWyuaLtBG1Pb3XCbyM64yleJKXnEp7qk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FR0DBZ3w5EuVuX9yZaqdTfXNls3tW6oAbP556a1AMypZyIkzHee1I+lKlCV2ADpSVeDLkcJ5JZHOditGl5hH4pKkFHHlLJ4aDfJmLEFtZddX62hy+u1lsPO9EJm77pMONJ5KkIP6QWd0Xn4gvQbz5qO9lKK/A5awvac3NJyp70s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vaVzTw2Q; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vaVzTw2Q"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-352ec74a925so9580843a91.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Feb 2026 14:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770071424; x=1770676224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WJgWKdX1fXoucLet6khpaz7IZED1X+tl8lLH7XoCgYo=;
        b=vaVzTw2QpM2bPQi3nVMxlZiE9ShlM5J7jP0G0nrlAClOTxHp9SVfMKgFTDDcxpBntv
         rwFJACx+EkbzCZk4AJEMPovS10JI2ORBJLOR4WwUH50K/J7uiM/I+icvIW2DphNJJu7a
         1Hru7cHglpvCUG0SSZuN/+z9qUIOSChpKs40/EvZAFc/oNSxuxodcycLt903laGBnwH9
         xKw6TooDubnbYikOn3b247y7bGEyN0UWJHv+cXdFWQHoLRAke9WQcyqd++v4AwG0h1VZ
         DtJZghcwfOq4tckbcf2MBMK53fe7OHHvObmpy8rFMZidcEUj49V0LkCEio7BVuitqk9d
         mJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770071424; x=1770676224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WJgWKdX1fXoucLet6khpaz7IZED1X+tl8lLH7XoCgYo=;
        b=o8j0P1UTHDON0ykdv/+aS6tlHwBpZUUfaSJjxZqbLVXkxehzkhk79nignVJ9RmZ4TY
         1W3lYN9rvOuilp+/iZ7wxDBIuBL7gZdHJaplhbHDIM1AfcUzhb+J2HFUl5ZbJUfc0m8Q
         u3Q1oAux/ic5LjI1MLzUWOpJTfJtvT/42JndN/QxW1MzmmB76hd3P9z/RLZkpU1ZHINz
         sUrrXw7T+mCm5Xa3SRdEkpRqkGB4qPcUySccw0FQQ29c9hzQMon6xOXOm0jNqSVBdL2V
         3QYJ25SpvPfxH8xTns6RYJZ2hmLwT2HVDcFI59wz+K6tySBzRSjiHKP/cIxIrjjBQENP
         n3EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIkrrgzBvLsQtrFjNuV8zEyR4oo/0gqEf7l1DBjS4k6NI0wLHTNOGoWQsc71w5v2Mt6pfUWmN3tncEacJJjWAdrNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBkFyABVwSZRpRi+fmZJ+/qoEvFAX1tzP8YmKE8pN63VwdkOKa
	CJkJsHiCvqxJ9bmFZj0ot4H0HBuNrWlPEV8kHXmu8gFozo0kmvnQ8o7RqlaIrGNtifVD4RuQFEj
	hohVephcYogze6rx+rS5QhNF19Q==
X-Received: from pjuz21.prod.google.com ([2002:a17:90a:d795:b0:352:f24d:9908])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:578c:b0:34a:48ff:694 with SMTP id 98e67ed59e1d1-3543b3b5d3bmr11061858a91.31.1770071424338;
 Mon, 02 Feb 2026 14:30:24 -0800 (PST)
Date: Mon,  2 Feb 2026 14:29:39 -0800
In-Reply-To: <cover.1770071243.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <6963888973817a40a5430ef369f587572eae726a.1770071243.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 01/37] KVM: guest_memfd: Introduce per-gmem attributes,
 use to guard user mappings
From: Ackerley Tng <ackerleytng@google.com>
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	bp@alien8.de, brauner@kernel.org, chao.p.peng@intel.com, 
	chao.p.peng@linux.intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, hpa@zytor.com, 
	ira.weiny@intel.com, jgg@nvidia.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, maobibo@loongson.cn, mathieu.desnoyers@efficios.com, 
	maz@kernel.org, mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, prsampat@amd.com, qperret@google.com, 
	ricarkol@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, seanjc@google.com, shivankg@amd.com, shuah@kernel.org, 
	steven.price@arm.com, tabba@google.com, tglx@linutronix.de, 
	vannapurve@google.com, vbabka@suse.cz, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

Start plumbing in guest_memfd support for in-place private<=>shared
conversions by tracking attributes via a maple tree.  KVM currently tracks
private vs. shared attributes on a per-VM basis, which made sense when a
guest_memfd _only_ supported private memory, but tracking per-VM simply
can't work for in-place conversions as the shareability of a given page
needs to be per-gmem_inode, not per-VM.

Use the filemap invalidation lock to protect the maple tree, as taking the
lock for read when faulting in memory (for userspace or the guest) isn't
expected to result in meaningful contention, and using a separate lock
would add significant complexity (avoid deadlock is quite difficult).

Signed-off-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
Co-developed-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 virt/kvm/guest_memfd.c | 134 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 118 insertions(+), 16 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index fdaea3422c30..7a970e5fab67 100644
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
@@ -32,6 +33,7 @@ struct gmem_inode {
 	struct inode vfs_inode;
 
 	u64 flags;
+	struct maple_tree attributes;
 };
 
 static __always_inline struct gmem_inode *GMEM_I(struct inode *inode)
@@ -59,6 +61,31 @@ static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
 	return gfn - slot->base_gfn + slot->gmem.pgoff;
 }
 
+static u64 kvm_gmem_get_attributes(struct inode *inode, pgoff_t index)
+{
+	struct maple_tree *mt = &GMEM_I(inode)->attributes;
+	void *entry = mtree_load(mt, index);
+
+	/*
+	 * The lock _must_ be held for lookups, as some maple tree operations,
+	 * e.g. append, are unsafe (return inaccurate information) with respect
+	 * to concurrent RCU-protected lookups.
+	 */
+	lockdep_assert(mt_lock_is_held(mt));
+
+	return WARN_ON_ONCE(!entry) ? 0 : xa_to_value(entry);
+}
+
+static bool kvm_gmem_is_private_mem(struct inode *inode, pgoff_t index)
+{
+	return kvm_gmem_get_attributes(inode, index) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
+}
+
+static bool kvm_gmem_is_shared_mem(struct inode *inode, pgoff_t index)
+{
+	return !kvm_gmem_is_private_mem(inode, index);
+}
+
 static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 				    pgoff_t index, struct folio *folio)
 {
@@ -402,10 +429,13 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
 	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
 		return VM_FAULT_SIGBUS;
 
-	if (!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
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
@@ -561,6 +591,51 @@ bool __weak kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
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
+	attrs = gi->flags & GUEST_MEMFD_FLAG_INIT_SHARED ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE;
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
@@ -591,16 +666,9 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
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
@@ -804,9 +872,13 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 	if (!file)
 		return -EFAULT;
 
+	filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
+
 	folio = __kvm_gmem_get_pfn(file, slot, index, pfn, &is_prepared, max_order);
-	if (IS_ERR(folio))
-		return PTR_ERR(folio);
+	if (IS_ERR(folio)) {
+		r = PTR_ERR(folio);
+		goto out;
+	}
 
 	if (!is_prepared)
 		r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
@@ -818,6 +890,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 	else
 		folio_put(folio);
 
+out:
+	filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
 	return r;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
@@ -931,13 +1005,41 @@ static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
 
 	mpol_shared_policy_init(&gi->policy, NULL);
 
+	/*
+	 * Memory attributes are protected by the filemap invalidation lock, but
+	 * the lock structure isn't available at this time.  Immediately mark
+	 * maple tree as using external locking so that accessing the tree
+	 * before it's fully initialized results in NULL pointer dereferences
+	 * and not more subtle bugs.
+	 */
+	mt_init_flags(&gi->attributes, MT_FLAGS_LOCK_EXTERN);
+
 	gi->flags = 0;
 	return &gi->vfs_inode;
 }
 
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
2.53.0.rc1.225.gd81095ad13-goog

