Received: from mta1.migadu.com (out-37.mta1.migadu.com [95.215.58.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF4035C6B4
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541783; cv=none; b=SMECv8ZA8dLttzsSnfnmvhwKhMKkfIjFO/2/GWdk0bPDh3fMAqL61EKUjBLFvf5GJrZjvJQy2VWc5TCggrajHZso2HXQtKAwdVQEeqXtl4R2cpfnFAQTd/h97MlwQPClv9Pa6Wei/qd71fz79jc4L2SHvkZhGjODrDH8bj16Z5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541783; c=relaxed/simple;
	bh=f598xMR7eSmimv3MnxLaUT+Gq6HxuH8K0zv25XFAJhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRia+NkKLJpbR2d/3sYwEfwQWzqsMGD0sXwVwXLVzCqCCEE08BndzTJGAhJ5vb75W660U4ZskZxJ0y8mAVUAU154tYa9Srv4qDUAEg91DJ4d5gfy6Wm273fTEzCl4H37VWu9uNxKIa1BHs7BCt8pBAmRZfumQbuataY5J0J4M3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uKcfGvZ7; arc=none smtp.client-ip=95.215.58.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uKcfGvZ7"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=f598xMR7eSmimv3MnxLaUT+Gq6HxuH8K0zv25XFAJhA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786541776; v=1; x=1787146576;
 b=uKcfGvZ7ctecBvJ0O5kILySa8Nq3Llucg7BI6ueEB9uUGlFpNgj2+tBlr0llTbL+TqjAv5k7
 1U7Y+uYw1+/PswuJdfxZZiJxFhgZ6qI/Hr1uOO6K/R3UzIQNktDMx3q6M++gTdApfkRi5zSrbx7
 2z7k/ddXov1wb5w+cDAS1H8c=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: from mail-qt1-f181.google.com (209.85.160.181)
	by smtp.migadu.com with ESMTPS id bd741528a7960ea5;
	Wed, 12 Aug 2026 13:36:06 +0000
X-Migadu-Flow: FLOW_OUT
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c10e86e52so228811cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 06:36:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqVwaHJPzJ84w7SC3RMJEFAAOwmCQ/hv3v4UYZBrZk+CdfgpU5+9ji6TSGK7AYD8lYu7t29L1dXydvSgq8RUeG04Ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YzapMVTe3P8JFJ7Ki84gjWsg4VQ0X0bZoUQ9LV87VdeImtL/u4a
	mDuOInbW7pChLDoa/0Qoj3LZofEBu1fxEcQtJiHhXZujrry6ue6TtP/OPw3qaBcnuNUhHURf4ad
	CQxGu5ngTFG9O/X3c0q+C9zYeVJfisPKXQg8YNrUh
X-Received: by 2002:a05:622a:40cd:b0:52b:4ec6:52ba with SMTP id
 d75a77b69052e-52d61f23159mr20505891cf.6.1786541765008; Wed, 12 Aug 2026
 06:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com> <20260807-gmem-inplace-conversion-v10-7-2fc18ee6d3ba@google.com>
In-Reply-To: <20260807-gmem-inplace-conversion-v10-7-2fc18ee6d3ba@google.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 12 Aug 2026 15:35:27 +0200
X-Gmail-Original-Message-ID: <CA+EHjTwn6oyf1vBb+pkBZ5dRgB0EJdSww=sfx2C3t5G-9f_uAQ@mail.gmail.com>
X-Gm-Features: AUfX_mxpAhCLdhwrsOspZt2G9laal9BYruBiB6OcXXxYLlQN_oMXjpKU5WvMAb8
Message-ID: <CA+EHjTwn6oyf1vBb+pkBZ5dRgB0EJdSww=sfx2C3t5G-9f_uAQ@mail.gmail.com>
Subject: Re: [PATCH v10 07/41] KVM: guest_memfd: Stub in ability to enable
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
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Aug 2026 at 23:52, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> Stub in global variable to enable in-place guest_memfd private<=>shared
> memory conversion, which will eventually be exposed to userspace via a
> module param, and wire up the __kvm_mem_is_private() static call to the
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
>  include/linux/kvm_host.h |  6 ++++++
>  virt/kvm/guest_memfd.c   | 26 ++++++++++++++++++++++++++
>  virt/kvm/kvm_main.c      | 12 +++++++++++-
>  3 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 65fbce46b63f4..9477ecebbbced 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2580,6 +2580,8 @@ static inline bool kvm_vm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>  #endif  /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
>
>  #ifdef kvm_arch_has_private_mem
> +extern bool gmem_in_place_conversion;
> +
>  typedef bool (kvm_mem_is_private_t)(struct kvm *kvm, gfn_t gfn);
>  DECLARE_STATIC_CALL(__kvm_mem_is_private, kvm_mem_is_private_t);
>
> @@ -2588,6 +2590,8 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>         return static_call(__kvm_mem_is_private)(kvm, gfn);
>  }
>  #else
> +#define gmem_in_place_conversion false
> +
>  static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>  {
>         return false;
> @@ -2595,6 +2599,8 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>  #endif /* kvm_arch_has_private_mem */
>
>  #ifdef CONFIG_KVM_GUEST_MEMFD
> +bool kvm_gmem_is_private(struct kvm *kvm, gfn_t gfn);
> +
>  int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>                      gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
>                      int *max_order);
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 1f1ae61b4878b..75979c885e030 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -475,6 +475,32 @@ static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
>         return 0;
>  }
>
> +bool kvm_gmem_is_private(struct kvm *kvm, gfn_t gfn)
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
> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_is_private);
> +
>  static struct file_operations kvm_gmem_fops = {
>         .mmap           = kvm_gmem_mmap,
>         .open           = generic_file_open,
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index a01d336eab18b..0a5a1bee8de0f 100644
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
> @@ -2634,8 +2641,11 @@ EXPORT_STATIC_CALL_GPL(__kvm_mem_is_private);
>
>  static void kvm_init_memory_attributes(void)
>  {
> +       if (gmem_in_place_conversion)
> +               static_call_update(__kvm_mem_is_private, kvm_gmem_is_private);
>  #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> -       static_call_update(__kvm_mem_is_private, kvm_vm_mem_is_private);
> +       else
> +               static_call_update(__kvm_mem_is_private, kvm_vm_mem_is_private);
>  #endif
>  }
>  #else
>
> --
> 2.55.0.654.g21b8a5bc05-goog
>
>
