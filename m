Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E134C288C81;
	Thu,  7 May 2026 03:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778124921; cv=none; b=RZajjD8YhbKkPAxlE/aAuAlU5UZI9yGJkrBLbnX7/vYzWkCPB0zS9WZkYgT5s1cLzO1hSmpkllas1NgbFE4HOSW1vqhrBq/H4TzxymS/BIO6qwsybB/MUbzOmOb2ezJh4roiu4el6a2GSCcuR+gB9wP8vDe3WxGNDUaQarPIB9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778124921; c=relaxed/simple;
	bh=ej0K96f1BIdI/Z3P9sfwL5kOSt5hSoaymO40jXhvVfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7mR5aGSW7hdJnlHsNtJ06VnhB1Ablus/AmwdzgSsLDtcnbLl/ixLxtlYwSmw3zQHZi1sq4+1TyIMn+RwtU7m2R979LPc1pqD9J0MByS8D3auWlJnhcxsEkpLiKDf7IYCSVJQic7kgO8DjoajdaXlvmvur8+OBR0igKA9VXkW2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zceOFB18; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zceOFB18"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lTWtM7aAvxWsgbfxNcm2HPqp/xVemJl/ZDl+oEpPXh4=; b=zceOFB185ADeycRkW+Yndduifi
	uIG0xGUceRU+kIAdPa7QJ8YGQKCWk9Q99DyTgWkZ569DpzpmjtCTBcNlD/cVsAcw0mR906e5FYX+t
	SgSowFDEbzlgTUCXFUUSD2A53qO4xtrsF+sb0uJT9wBb0/xSgDUYFE/QHtdPG4DcXL3pSsCAOFuej
	EoSAzrN5nadMrg1N+y/OpKFYDYx+JAqKFZGKQRJXmPAAOnHwTYKEhU1E3Xu3gLie4Dj3v7wnyZ0UD
	s6VXTgrcpBnAwPnlgXfb0HzrcqZPG1SyKJGzutbgYJt5HIlfPRDR1bs+MhBw0iVxWCWLjFQEZSK2a
	0RcDxuQg==;
Received: from [213.147.98.98] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKpVb-00000002dtN-3eeD;
	Thu, 07 May 2026 03:34:44 +0000
Date: Thu, 7 May 2026 05:34:28 +0200
From: "Liam R. Howlett" <liam@infradead.org>
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, steven.price@arm.com, 
	tabba@google.com, willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Vishal Annapurve <vannapurve@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Youngjun Park <youngjun.park@lge.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Subject: Re: [PATCH RFC v5 01/53] KVM: guest_memfd: Introduce per-gmem
 attributes, use to guard user mappings
Message-ID: <byywwfin2aenobdwuesqihm6nzxyx6ecedwgbt7f5tvaaul6fi@u7bmexpavwdn>
References: <20260428-gmem-inplace-conversion-v5-0-d8608ccfca22@google.com>
 <20260428-gmem-inplace-conversion-v5-1-d8608ccfca22@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-gmem-inplace-conversion-v5-1-d8608ccfca22@google.com>

On 26/04/28 04:24PM, Ackerley Tng via B4 Relay wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Start plumbing in guest_memfd support for in-place private<=>shared
> conversions by tracking attributes via a maple tree.  KVM currently tracks
> private vs. shared attributes on a per-VM basis, which made sense when a
> guest_memfd _only_ supported private memory, but tracking per-VM simply
> can't work for in-place conversions as the shareability of a given page
> needs to be per-gmem_inode, not per-VM.
> 
> Use the filemap invalidation lock to protect the maple tree, as taking the
> lock for read when faulting in memory (for userspace or the guest) isn't
> expected to result in meaningful contention, and using a separate lock
> would add significant complexity (avoid deadlock is quite difficult).
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> Co-developed-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Fuad Tabba <tabba@google.com>
> ---
>  virt/kvm/guest_memfd.c | 139 +++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 123 insertions(+), 16 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 69c9d6d546b28..17e5a23fec0a1 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -4,6 +4,7 @@
>  #include <linux/falloc.h>
>  #include <linux/fs.h>
>  #include <linux/kvm_host.h>
> +#include <linux/maple_tree.h>
>  #include <linux/mempolicy.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/pagemap.h>
> @@ -33,6 +34,12 @@ struct gmem_inode {
>  	struct list_head gmem_file_list;
>  
>  	u64 flags;
> +	/*
> +	 * Every index in this inode, whether memory is populated or
> +	 * not, is tracked in attributes. There are no gaps in this
> +	 * maple tree.
> +	 */
> +	struct maple_tree attributes;
>  };
>  
>  static __always_inline struct gmem_inode *GMEM_I(struct inode *inode)
> @@ -60,6 +67,31 @@ static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
>  	return gfn - slot->base_gfn + slot->gmem.pgoff;
>  }
>  
> +static u64 kvm_gmem_get_attributes(struct inode *inode, pgoff_t index)
> +{
> +	struct maple_tree *mt = &GMEM_I(inode)->attributes;
> +	void *entry = mtree_load(mt, index);
> +
> +	/*
> +	 * The lock _must_ be held for lookups, as some maple tree operations,
> +	 * e.g. append, are unsafe (return inaccurate information) with respect
> +	 * to concurrent RCU-protected lookups.
> +	 */

Can you please elaborate how you see inaccurate information and which
information is inaccurate?

Your comment is incorrect and misleading as append will not be used in
rcu mode.  Note that you have not set this tree up in rcu mode.

> +	lockdep_assert(mt_lock_is_held(mt));
> +
> +	return WARN_ON_ONCE(!entry) ? 0 : xa_to_value(entry);
> +}
> +
> +static bool kvm_gmem_is_private_mem(struct inode *inode, pgoff_t index)
> +{
> +	return kvm_gmem_get_attributes(inode, index) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
> +}
> +
> +static bool kvm_gmem_is_shared_mem(struct inode *inode, pgoff_t index)
> +{
> +	return !kvm_gmem_is_private_mem(inode, index);
> +}
> +
>  static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>  				    pgoff_t index, struct folio *folio)
>  {
> @@ -397,10 +429,13 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>  	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
>  		return VM_FAULT_SIGBUS;
>  
> -	if (!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
> -		return VM_FAULT_SIGBUS;
> +	filemap_invalidate_lock_shared(inode->i_mapping);
> +	if (kvm_gmem_is_shared_mem(inode, vmf->pgoff))
> +		folio = kvm_gmem_get_folio(inode, vmf->pgoff);
> +	else
> +		folio = ERR_PTR(-EACCES);
> +	filemap_invalidate_unlock_shared(inode->i_mapping);
>  
> -	folio = kvm_gmem_get_folio(inode, vmf->pgoff);
>  	if (IS_ERR(folio)) {
>  		if (PTR_ERR(folio) == -EAGAIN)
>  			return VM_FAULT_RETRY;
> @@ -556,6 +591,51 @@ bool __weak kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
>  	return true;
>  }
>  
> +static int kvm_gmem_init_inode(struct inode *inode, loff_t size, u64 flags)
> +{
> +	struct gmem_inode *gi = GMEM_I(inode);
> +	MA_STATE(mas, &gi->attributes, 0, (size >> PAGE_SHIFT) - 1);
> +	u64 attrs;
> +	int r;
> +
> +	inode->i_op = &kvm_gmem_iops;
> +	inode->i_mapping->a_ops = &kvm_gmem_aops;
> +	inode->i_mode |= S_IFREG;
> +	inode->i_size = size;
> +	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
> +
> +	/*
> +	 * guest_memfd memory is neither migratable nor swappable: set
> +	 * inaccessible to gate off both.
> +	 */
> +	mapping_set_inaccessible(inode->i_mapping);
> +	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
> +
> +	gi->flags = flags;
> +
> +	mt_set_external_lock(&gi->attributes,
> +			     &inode->i_mapping->invalidate_lock);
> +
> +	/*
> +	 * Store default attributes for the entire gmem instance. Ensuring every
> +	 * index is represented in the maple tree at all times simplifies the
> +	 * conversion and merging logic.
> +	 */
> +	attrs = gi->flags & GUEST_MEMFD_FLAG_INIT_SHARED ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE;
> +
> +	/*
> +	 * Acquire the invalidation lock purely to make lockdep happy.  The
> +	 * maple tree library expects all stores to be protected via the lock,
> +	 * and the library can't know when the tree is reachable only by the
> +	 * caller, as is the case here.
> +	 */
> +	filemap_invalidate_lock(inode->i_mapping);
> +	r = mas_store_gfp(&mas, xa_mk_value(attrs), GFP_KERNEL);
> +	filemap_invalidate_unlock(inode->i_mapping);
> +
> +	return r;
> +}
> +
>  static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>  {
>  	static const char *name = "[kvm-gmem]";
> @@ -586,16 +666,9 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>  		goto err_fops;
>  	}
>  
> -	inode->i_op = &kvm_gmem_iops;
> -	inode->i_mapping->a_ops = &kvm_gmem_aops;
> -	inode->i_mode |= S_IFREG;
> -	inode->i_size = size;
> -	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
> -	mapping_set_inaccessible(inode->i_mapping);
> -	/* Unmovable mappings are supposed to be marked unevictable as well. */
> -	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
> -
> -	GMEM_I(inode)->flags = flags;
> +	err = kvm_gmem_init_inode(inode, size, flags);
> +	if (err)
> +		goto err_inode;
>  
>  	file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR, &kvm_gmem_fops);
>  	if (IS_ERR(file)) {
> @@ -797,9 +870,13 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	if (!file)
>  		return -EFAULT;
>  
> +	filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
> +
>  	folio = __kvm_gmem_get_pfn(file, slot, index, pfn, max_order);
> -	if (IS_ERR(folio))
> -		return PTR_ERR(folio);
> +	if (IS_ERR(folio)) {
> +		r = PTR_ERR(folio);
> +		goto out;
> +	}
>  
>  	if (!folio_test_uptodate(folio)) {
>  		clear_highpage(folio_page(folio, 0));
> @@ -815,6 +892,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	else
>  		folio_put(folio);
>  
> +out:
> +	filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
>  	return r;
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
> @@ -944,6 +1023,15 @@ static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
>  
>  	mpol_shared_policy_init(&gi->policy, NULL);
>  
> +	/*
> +	 * Memory attributes are protected by the filemap invalidation lock, but
> +	 * the lock structure isn't available at this time.  Immediately mark
> +	 * maple tree as using external locking so that accessing the tree
> +	 * before it's fully initialized results in NULL pointer dereferences
> +	 * and not more subtle bugs.
> +	 */
> +	mt_init_flags(&gi->attributes, MT_FLAGS_LOCK_EXTERN);
> +
>  	gi->flags = 0;
>  	INIT_LIST_HEAD(&gi->gmem_file_list);
>  	return &gi->vfs_inode;
> @@ -951,7 +1039,26 @@ static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
>  
>  static void kvm_gmem_destroy_inode(struct inode *inode)
>  {
> -	mpol_free_shared_policy(&GMEM_I(inode)->policy);
> +	struct gmem_inode *gi = GMEM_I(inode);
> +
> +	mpol_free_shared_policy(&gi->policy);
> +
> +	/*
> +	 * Note!  Checking for an empty tree is functionally necessary
> +	 * to avoid explosions if the tree hasn't been fully
> +	 * initialized, i.e. if the inode is being destroyed before
> +	 * guest_memfd can set the external lock, lockdep would find
> +	 * that the tree's internal ma_lock was not held.
> +	 */
> +	if (!mtree_empty(&gi->attributes)) {
> +		/*
> +		 * Acquire the invalidation lock purely to make lockdep happy,
> +		 * the inode is unreachable at this point.
> +		 */
> +		filemap_invalidate_lock(inode->i_mapping);
> +		__mt_destroy(&gi->attributes);
> +		filemap_invalidate_unlock(inode->i_mapping);
> +	}
>  }
>  
>  static void kvm_gmem_free_inode(struct inode *inode)
> 
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
> 
> 
