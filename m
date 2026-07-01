Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF5D2DC32E
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Jul 2026 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782920159; cv=none; b=M4yMoZFH53CERhAqNZI51HF77q+WH8pYC5MNkJgwc2c6cufYlw4mZnpZq1rHx4xmSMfK+WLGrImpwDzmXqSDNTiOYDqKij3Fm4NZqdu6+OH1Z3dVbG6Lc32dkDZ692NvNfefyOPm/beRQj4D5j1QB7Kli7WcaG6+d2MgfYIZvBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782920159; c=relaxed/simple;
	bh=1CpXWYMXeecLyxRIvlWeS8DmEwA0TLBYjkJaloihYeU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tLrVcgZVR6n9pMBXb0sVDOB0upnDD/TyWppjdRSBsy3Cat8MaYgd4hcUmdoSb5YQ3FIZXANEFO5vEkZc5oRcEXHXUhQrsOHROvvXwYq8SqYcIxoxJZIdNuVmwg+UmNE+F/2Kx68oC6SrvdHLTmmq8J5hjc5FQEAt07vqxhTWfGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nOCDtuQu; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nOCDtuQu"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ca3b3141a6so8615875ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Jul 2026 08:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782920157; x=1783524957; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/dm8qbEauKVXJhYGr90L/dxzQTMgwF1P0y0BSIo+cWM=;
        b=nOCDtuQugR4O/383c/SCPgYa+tKqM/VdSSevk8rHpAHhNPZvkBypeNZC+ncr77KTQ/
         3l1wZuQCLqSZzx/KJN5RuuuWhm120JEx/hZArQCVeTxvCEFKPoGFwIvf3LCAYcm5cwG1
         LBLYMDeTdNX4BYonN/1ljHSMA7zbKSaJL8YhDZ8dvM9THhtEIwe7+KJmQBxZNQNPw2dc
         4KK67ALH7nI6yHUNbfDftHfqPPOgC8gL98JPLVfyr51kOD2wj0m43qLt2EFcdn0MRetj
         S0hnLiHA7uCYyAxzvby1YJitfcPzREc+lUZGipsYYJW7YeeNtiUq9dyHGotMTS7m1YSg
         MFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782920157; x=1783524957;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dm8qbEauKVXJhYGr90L/dxzQTMgwF1P0y0BSIo+cWM=;
        b=W08/icHDv7R+tq5auotVZFJspKC0UTll9uUOfKr2/PF6MwCm6FXjCQdmCd7+063SBO
         klnZb1/deFTGXuqAJAgKuGOZ5ShF7WeMGSsWIc+st7zGrUJjYJe9+l7OcJRnoowRlPPN
         1QvCoZGbxMKMpxN/RLgxzWjEK7luC34bXBPTDxD1bYbN2j22YZ6Ekl40rmZXiNei1RWk
         vMdjZyi1g0PG0FVuN0lz9VVhEQ3pETTbDw+SMTA2fTcnJKPoYlYSVPDC7T4OZT70KNK5
         7VoN+MxgEJx9+u4FpvtKRo8fbo3TlJCYlBCFIRxq1gyEPzoHppQvr3zpYlW0YHpFtxys
         qXVw==
X-Forwarded-Encrypted: i=1; AHgh+RpJ4n1+kU6Am+vq2UxUmO4D8NAWg4dczxtGNsxl62GqTVBeV3xEQMipF8l5VNR0ZhaIBrX2aBcR+sb/G4PnMO3LVps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmCHb8aUFrE4kfl6kuw0XJwk4Dtt9nZQB0qsq5/nAEHBeUf+1R
	vmlCaOGppfxO8tMI5Pyi4dfpmEHHUmdoOdRudMZk6EihPsHrBqVnlbsnU0JoKQpX9Mu1wMnOyci
	sAtLOWg==
X-Received: from plbkr11.prod.google.com ([2002:a17:903:80b:b0:2c7:3d65:ed18])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecc6:b0:2c9:fa31:84f9
 with SMTP id d9443c01a7336-2ca7e682af0mr20521695ad.5.1782920156755; Wed, 01
 Jul 2026 08:35:56 -0700 (PDT)
Date: Wed, 1 Jul 2026 08:35:56 -0700
In-Reply-To: <20260618-gmem-inplace-conversion-v8-13-9d2959357853@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-13-9d2959357853@google.com>
Message-ID: <akUz3M5Z2vnioB72@google.com>
Subject: Re: [PATCH v8 13/46] KVM: guest_memfd: Add base support for KVM_SET_MEMORY_ATTRIBUTES2
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
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
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 18, 2026, Ackerley Tng wrote:
> Introduce base support for KVM_SET_MEMORY_ATTRIBUTES2 in guest_memfd, which
> just updates attributes tracked by guest_memfd.
> 
> Validate input fields in general. Guard usage of KVM_SET_MEMORY_ATTRIBUTES2
> by making sure requested attributes are supported for this instance of kvm.
> 
> A new KVM_SET_MEMORY_ATTRIBUTES2 is defined to support writes (unlike

Phrase this as a command using imperative mood.  The wording is also weird,
because "support writes" makes it sound like it allows controlling WRITE attributes,
whereas what you mean by "support writes" is "allowing KVM to write back error
information to the struct without technically violating the semantics embedded
in the ioctl".  It's doubly confusing because the macros use a different polarity:
IOW means userspace is writing, but this implicitly refers to IOW as "reads".

> KVM_SET_MEMORY_ATTRIBUTES) in addition to reads so it can provide error
> details to userspace. This will be used in a later patch.
> 
> The two ioctls use their corresponding structs with no overlap, but
> backward compatibility is baked in for future support of
> KVM_SET_MEMORY_ATTRIBUTES2 and struct kvm_memory_attributes2 in the VM
> ioctl.

I don't understand what this paragraph is trying to say with respect to backwards
compatibility.  It's a new ioctl and struct, there's no compatibility in sight.

E.g.

  Add a new ioctl (and matching struct), KVM_SET_MEMORY_ATTRIBUTES2, using
  the same base ioctl number (0xd2), but with R/W semantics for the kernel
  instead of just read semantics.  "Officially" documenting that KVM writes
  to the payload will allow KVM to support partial/incremental conversions,
  instead of all-or-nothing updates (which requires complex unwinding), by
  recording the failing offset if an error occurs.

  Opportunistically add a new struct as well, even though KVM could squeeze
  the error offset into "struct kvm_memory_attributes", as there's no cost
  to doing so in practice.  Pad the struct with a pile of extra space to try
  and avoid ending up with "struct kvm_memory_attributes3" in the future.
  Use the same layout for the fields that common to version 1 of the struct,
  e.g. to ease upgrading userspace, and to provide flexibility in KVM ever
  adds support for KVM_SET_MEMORY_ATTRIBUTES2 at VM scope.

> The process of setting memory attributes is set up such that the later half
> will not fail due to allocation. Any necessary checks are performed before
> the point of no return.

Explain *why*.  Readers can usually understand the "what" by reading the code,
but it's much harder to discern *why* things were done a certain way.  Some things
go without saying, e.g. "validate input fields", but in that case, just drop the
changelog blurb (if we _weren't_ validating input, *that* would be interesting and
worth calling out).

> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> Co-developed-by: Sean Christoperson <seanjc@google.com>
> Signed-off-by: Sean Christoperson <seanjc@google.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  include/uapi/linux/kvm.h |  13 ++++++
>  virt/kvm/Kconfig         |   1 +
>  virt/kvm/guest_memfd.c   | 116 +++++++++++++++++++++++++++++++++++++++++++++++
>  virt/kvm/kvm_main.c      |  12 +++++
>  4 files changed, 142 insertions(+)
> 
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 419011097fa8e..956877a6aab05 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1649,6 +1649,19 @@ struct kvm_memory_attributes {
>  	__u64 flags;
>  };
>  
> +#define KVM_SET_MEMORY_ATTRIBUTES2              _IOWR(KVMIO,  0xd2, struct kvm_memory_attributes2)
> +
> +struct kvm_memory_attributes2 {
> +	union {
> +		__u64 address;
> +		__u64 offset;
> +	};
> +	__u64 size;
> +	__u64 attributes;
> +	__u64 flags;
> +	__u64 reserved[12];
> +};
> +
>  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
>  
>  #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 297e4399fbd49..cfa2c78ba5fb9 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -102,6 +102,7 @@ config KVM_MMU_LOCKLESS_AGING
>  
>  config KVM_GUEST_MEMFD
>         select XARRAY_MULTI
> +       select KVM_MEMORY_ATTRIBUTES
>         bool
>  
>  config HAVE_KVM_ARCH_GMEM_PREPARE
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 65ce795c090d9..0d14548c1ed22 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -541,11 +541,127 @@ bool kvm_gmem_is_private(struct kvm *kvm, gfn_t gfn)
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_is_private);
>  
> +/*
> + * Preallocate memory for attributes to be stored on a maple tree, pointed to
> + * by mas.  Adjacent ranges with attributes identical to the new attributes
> + * will be merged.  Also sets mas's bounds up for storing attributes.
> + *
> + * This maintains the invariant that ranges with the same attributes will
> + * always be merged.
> + */
> +static int kvm_gmem_mas_preallocate(struct ma_state *mas, u64 attributes,
> +				    pgoff_t start, size_t nr_pages)
> +{
> +	pgoff_t end = start + nr_pages;
> +	pgoff_t last = end - 1;
> +	void *entry;
> +
> +	/* Try extending range. entry is NULL on overflow/wrap-around. */
> +	mas_set(mas, end);
> +	entry = mas_find(mas, end);
> +	if (entry && xa_to_value(entry) == attributes)
> +		last = mas->last;
> +
> +	if (start > 0) {
> +		mas_set(mas, start - 1);
> +		entry = mas_find(mas, start - 1);
> +		if (entry && xa_to_value(entry) == attributes)
> +			start = mas->index;
> +	}
> +
> +	mas_set_range(mas, start, last);
> +	return mas_preallocate(mas, xa_mk_value(attributes), GFP_KERNEL);
> +}
> +
> +static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
> +				     size_t nr_pages, uint64_t attrs)
> +{
> +	struct address_space *mapping = inode->i_mapping;
> +	struct gmem_inode *gi = GMEM_I(inode);
> +	pgoff_t end = start + nr_pages;
> +	struct maple_tree *mt;
> +	struct ma_state mas;
> +	int r;
> +
> +	mt = &gi->attributes;
> +
> +	filemap_invalidate_lock(mapping);
> +
> +	mas_init(&mas, mt, start);
> +	r = kvm_gmem_mas_preallocate(&mas, attrs, start, nr_pages);
> +	if (r)
> +		goto out;
> +
> +	/*
> +	 * From this point on guest_memfd has performed necessary
> +	 * checks and can proceed to do guest-breaking changes.
> +	 */
> +
> +	kvm_gmem_invalidate_start(inode, start, end);
> +	mas_store_prealloc(&mas, xa_mk_value(attrs));
> +	kvm_gmem_invalidate_end(inode, start, end);
> +out:
> +	filemap_invalidate_unlock(mapping);
> +	return r;
> +}
> +
> +static long kvm_gmem_set_attributes(struct file *file, void __user *argp)
> +{
> +	struct gmem_file *f = file->private_data;
> +	struct inode *inode = file_inode(file);
> +	struct kvm_memory_attributes2 attrs;
> +	size_t nr_pages;
> +	pgoff_t index;
> +	int i;
> +
> +	if (copy_from_user(&attrs, argp, sizeof(attrs)))
> +		return -EFAULT;
> +
> +	if (attrs.flags)
> +		return -EINVAL;
> +	for (i = 0; i < ARRAY_SIZE(attrs.reserved); i++) {
> +		if (attrs.reserved[i])
> +			return -EINVAL;
> +	}
> +	if (!kvm_arch_has_private_mem(f->kvm))
> +		return -EINVAL;
> +	if (attrs.attributes & ~KVM_MEMORY_ATTRIBUTE_PRIVATE)
> +		return -EINVAL;
> +	if (attrs.size == 0 || attrs.offset + attrs.size < attrs.offset)
> +		return -EINVAL;
> +	if (!PAGE_ALIGNED(attrs.offset) || !PAGE_ALIGNED(attrs.size))
> +		return -EINVAL;
> +
> +	if (attrs.offset >= i_size_read(inode) ||
> +	    attrs.offset + attrs.size > i_size_read(inode))
> +		return -EINVAL;
> +
> +	nr_pages = attrs.size >> PAGE_SHIFT;
> +	index = attrs.offset >> PAGE_SHIFT;
> +	return __kvm_gmem_set_attributes(inode, index, nr_pages,
> +					 attrs.attributes);
> +}
> +
> +static long kvm_gmem_ioctl(struct file *file, unsigned int ioctl,
> +			   unsigned long arg)
> +{
> +	switch (ioctl) {
> +	case KVM_SET_MEMORY_ATTRIBUTES2:
> +		if (!gmem_in_place_conversion)
> +			return -ENOTTY;
> +
> +		return kvm_gmem_set_attributes(file, (void __user *)arg);
> +	default:
> +		return -ENOTTY;
> +	}
> +}
> +
>  static struct file_operations kvm_gmem_fops = {
>  	.mmap		= kvm_gmem_mmap,
>  	.open		= generic_file_open,
>  	.release	= kvm_gmem_release,
>  	.fallocate	= kvm_gmem_fallocate,
> +	.unlocked_ioctl	= kvm_gmem_ioctl,
>  };
>  
>  static int kvm_gmem_migrate_folio(struct address_space *mapping,
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 01761f6e25d25..a08b518cdb175 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -105,6 +105,18 @@ module_param(allow_unsafe_mappings, bool, 0444);
>  bool __ro_after_init gmem_in_place_conversion = false;
>  #endif
>  
> +#define MEMORY_ATTRIBUTES_MATCH(one, two)				\

Use the same terminology as the memory region asserts, i.e.
SANITY_CHECK_MEM_ATTRIBUTES_FIELD.  MEMORY_ATTRIBUTES_MATCH() reads like a helper
that checks if the two objects have the same attributes.

And put the checks where it actually matters, i.e. in the case-statement for
KVM_SET_MEMORY_ATTRIBUTES (again, same as KVM_SET_USER_MEMORY_REGION).  Because
the only reason it matters for KVM is if we want to add VM-scoped support for
KVM_SET_MEMORY_ATTRIBUTES2 in the future, at which point we'll want to use the
same overlay shenanigans that we did for KVM_SET_USER_MEMORY_REGION2.

> +	static_assert(offsetof(struct kvm_memory_attributes, one) ==	\
> +		      offsetof(struct kvm_memory_attributes2, two));	\

And then once these are landed in function scope, use BUILD_BUG_ON() with a
do { ... } while (0).

> +	static_assert(sizeof_field(struct kvm_memory_attributes, one) ==\
> +		      sizeof_field(struct kvm_memory_attributes2, two))
> +
> +/* Ensure the common parts of the two structs are identical. */
> +MEMORY_ATTRIBUTES_MATCH(address, address);
> +MEMORY_ATTRIBUTES_MATCH(size, size);
> +MEMORY_ATTRIBUTES_MATCH(attributes, attributes);
> +MEMORY_ATTRIBUTES_MATCH(flags, flags);

Please put these asserts in the location where the overlay matters.  Actually, I
don't think we need to enforce this?
