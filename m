Received: from mta0.migadu.com (out-241.mta0.migadu.com [91.218.175.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C3C47254E
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253893; cv=none; b=m0YDzT4HOax8Oy7x+24L48Mw+vbSP4TjTMpvef9wr2SWivWksXgDpufNnRzb8hCj/Z67iSdSvd0Ux+rv7o4WF538I3AgZPeMh43OU+JMv4R4col0FnZ+L/F+0Od/n5Suai9sk9zbNb8+u8YeKO5OWEezPlvIHxqupQn+Vir2BsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253893; c=relaxed/simple;
	bh=ME/aZcaXqImZ67gDzlYdShBgA2J/tOz88/5XcEiSBwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orZWChfn7EuTpiyl3b6UClbn8aFUO+Q9FOJGegkvXnEwxf/2QOpMM3NmcnZ63Y8HxOzDiS8BT8+bGGAuUdAJTmi/Bt+sjniWzYUY1034oagFdb6ND4I6pyecf+ERjQ7nz2ZLcMPsF2DC6fmi0hopVkn4LO3WlQR5o9ivzrJVp4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qZ2c/8NM; arc=none smtp.client-ip=91.218.175.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qZ2c/8NM"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ME/aZcaXqImZ67gDzlYdShBgA2J/tOz88/5XcEiSBwk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788253889; v=1; x=1788858689;
 b=qZ2c/8NMfkRXv0rK0XHuI1NhRv6eIKopndWsciskq8JFv5M67d/9su590+DzFdHzK4rdGiT4
 d8Ha/TZZ3rEMcjHCGFtIWbnUXeSRGtV+TuwvtdWzoYFNNoxtVT3cbpaRdGk8jbCCUSuWbZs/WII
 Wh/Sq4gaDA6QuauvUp3pLk/0=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6cf486c21090c115;
	Tue, 01 Sep 2026 09:11:29 +0000
X-Mizu-Trace-ID: 6cf486c21090c115
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b5e5aaf7deso6275e87.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 02:11:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwJPtilYJOr6qhaK0GYZz+Ji/zVZHInVT8RkLq7+SRG6iPQutWMPhKYACmQjsO/o5dFpopL1pIilmFjX2mx/MyBCi4=@vger.kernel.org
X-Gm-Message-State: AFuF++kZgZhvx7BYii7u2G7NgFYOxSJQS/hFACe2TN9eLMRWzRqXM8/m
	n+PP5y+QtczZEqzY3abXXNxn24zdHbshKYAdgeniiKkP95upbaT5JBOV9jiuy3oS/RYNVvT6agU
	x8j5JgFvQDIY7zm/8hwU2ij9/1xY1Ry2U8g8rsFbk
X-Received: by 2002:a05:6512:3993:b0:5b4:9dba:4ecf with SMTP id
 2adb3069b0e04-5b600a4e61cmr98369e87.13.1788253884152; Tue, 01 Sep 2026
 02:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com> <20260830-gmem-inplace-conversion-v12-9-85e5fd25252a@google.com>
In-Reply-To: <20260830-gmem-inplace-conversion-v12-9-85e5fd25252a@google.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 1 Sep 2026 10:10:47 +0100
X-Gmail-Original-Message-ID: <CA+EHjTwd507PaNQN9uHCgwftqSiVfhKhxSA7QnZVsNGqpNfGKg@mail.gmail.com>
X-Gm-Features: AcwNN1XJVfII0wEJT_6-zHDSSBrs5LG5QpKVzgnh0CqKXLcS-fmuDvdFlehw5YE
Message-ID: <CA+EHjTwd507PaNQN9uHCgwftqSiVfhKhxSA7QnZVsNGqpNfGKg@mail.gmail.com>
Subject: Re: [PATCH v12 09/45] KVM: guest_memfd: Stub in ability to enable
 in-place shared<=>private conversion
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
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
	Randy Dunlap <rdunlap@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev, 
	Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Aug 2026 at 01:25, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> Stub in global variable to enable in-place guest_memfd private<=>shared
> memory conversion, which will eventually be exposed to userspace via a
> module param, and wire up the __kvm_is_private_gfn() static call to the
> guest_memfd version when in-place conversion is enabled, i.e. when gmem is
> the sole authority on private vs. shared memory.
>
> Cc: Fuad Tabba <tabba@google.com>
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad


> ---
>  Documentation/virt/kvm/api.rst |  7 +++++++
>  include/linux/kvm_host.h       |  6 ++++++
>  virt/kvm/guest_memfd.c         | 26 ++++++++++++++++++++++++++
>  virt/kvm/kvm_main.c            | 12 +++++++++++-
>  4 files changed, 50 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index e0430cc750c9e..90a29424c54c8 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6382,6 +6382,11 @@ KVM_SET_USER_MEMORY_REGION2, e.g. shared memory can be lazily mapped/allocated
>  on-demand.
>
>  When mapping a gfn into the guest, KVM selects shared vs. private, i.e consumes
> +userspace_addr vs. guest_memfd, based on the state in guest_memfd, which is the
> +sole authority on private vs. shared memory.  See :ref:`KVM_CREATE_GUEST_MEMFD`
> +to find out more about the creation-time shared/private status.
> +
> +If in-place conversion is disabled, KVM selects shared vs. private, i.e consumes
>  userspace_addr vs. guest_memfd, based on the gfn's KVM_MEMORY_ATTRIBUTE_PRIVATE
>  state.  At VM creation time, all memory is shared, i.e. the PRIVATE attribute
>  is '0' for all gfns.  Userspace can control whether memory is shared/private by
> @@ -6429,6 +6434,8 @@ the state of a gfn/page as needed.
>
>  The "flags" field is reserved for future extensions and must be '0'.
>
> +.. _KVM_CREATE_GUEST_MEMFD:
> +
>  4.142 KVM_CREATE_GUEST_MEMFD
>  ----------------------------
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 3579feb631775..b0110143d2ff8 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2580,6 +2580,8 @@ static inline bool kvm_vm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
>  #endif  /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
>
>  #ifdef kvm_arch_has_private_mem
> +extern bool gmem_in_place_conversion;
> +
>  typedef bool (kvm_is_private_gfn_t)(struct kvm *kvm, gfn_t gfn);
>  DECLARE_STATIC_CALL(__kvm_is_private_gfn, kvm_is_private_gfn_t);
>
> @@ -2588,6 +2590,8 @@ static inline bool kvm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
>         return static_call(__kvm_is_private_gfn)(kvm, gfn);
>  }
>  #else
> +#define gmem_in_place_conversion false
> +
>  static inline bool kvm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
>  {
>         return false;
> @@ -2595,6 +2599,8 @@ static inline bool kvm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
>  #endif /* kvm_arch_has_private_mem */
>
>  #ifdef CONFIG_KVM_GUEST_MEMFD
> +bool kvm_gmem_is_private_gfn(struct kvm *kvm, gfn_t gfn);
> +
>  int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>                      gfn_t gfn, kvm_pfn_t *pfn, int *max_order);
>  #else
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index ce5efcacda36e..cd966eef45b69 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -478,6 +478,32 @@ static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
>         return 0;
>  }
>
> +bool kvm_gmem_is_private_gfn(struct kvm *kvm, gfn_t gfn)
> +{
> +       struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
> +       struct inode *inode;
> +
> +       if (!slot)
> +               return 0;
> +
> +       CLASS(gmem_get_file, file)(slot);
> +       if (!file)
> +               return 0;
> +
> +       inode = file_inode(file);
> +
> +       /*
> +        * Rely on the maple tree's internal RCU lock to ensure a stable result.
> +        * This result can become stale as soon as the lock is dropped, so the
> +        * caller _must_ protect consumption of private vs. shared either by
> +        * holding guest_memfd's invalidate lock for the entire duration, or by
> +        * checking mmu_invalidate_retry_gfn() under mmu_lock to serialize
> +        * against concurrent attribute updates.
> +        */
> +       return kvm_gmem_is_private_mem(inode, kvm_gmem_get_index(slot, gfn));
> +}
> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_is_private_gfn);
> +
>  static struct file_operations kvm_gmem_fops = {
>         .mmap           = kvm_gmem_mmap,
>         .open           = generic_file_open,
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 78278730b2ae4..46d2e123448c2 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -102,6 +102,10 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(halt_poll_ns_shrink);
>  static bool __ro_after_init allow_unsafe_mappings;
>  module_param(allow_unsafe_mappings, bool, 0444);
>
> +#ifdef kvm_arch_has_private_mem
> +bool __ro_after_init gmem_in_place_conversion = false;
> +#endif
> +
>  /*
>   * Ordering of locks:
>   *
> @@ -2423,6 +2427,9 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
>  static u64 kvm_supported_vm_mem_attributes(struct kvm *kvm)
>  {
>  #ifdef kvm_arch_has_private_mem
> +       if (gmem_in_place_conversion)
> +               return 0;
> +
>         if (!kvm || kvm_arch_has_private_mem(kvm))
>                 return KVM_MEMORY_ATTRIBUTE_PRIVATE;
>  #endif
> @@ -2634,8 +2641,11 @@ EXPORT_STATIC_CALL_GPL(__kvm_is_private_gfn);
>
>  static void kvm_init_memory_attributes(void)
>  {
> +       if (gmem_in_place_conversion)
> +               static_call_update(__kvm_is_private_gfn, kvm_gmem_is_private_gfn);
>  #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> -       static_call_update(__kvm_is_private_gfn, kvm_vm_is_private_gfn);
> +       else
> +               static_call_update(__kvm_is_private_gfn, kvm_vm_is_private_gfn);
>  #endif
>  }
>  #else
>
> --
> 2.55.0.897.gb25b4bd76c-goog
>
>
