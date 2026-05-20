Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326FA3DCDB7
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779278944; cv=pass; b=kEZZGmI3zN8OQivwW07UrfzL/sgJa+5UcSqGohuQWychPp5u2DUjLLAlC/wdCJsTBFKgMovvAugJN0ewOJXat1xDN/UcFCNTjkyN3rsVyOneg0RKJXikMyQQf9I8a8EsQcB6TlvSIcXKkeR6BwwDgiWnCMPIbM7p+yxSjt67HII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779278944; c=relaxed/simple;
	bh=FMa1o5YM+g2gB86rOQrQFI2ffBU5ulAH2CA47u8TX+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GaG5Cs7k0LLkHTy6ru6ixD2DGJK5Z/JNs8LzhNBDtFU+Gx9Cj7Bm+SGjT/rIDoMLERPok3xC/sVEVfbGzTQvJaOICkkIvR25qNlPuSYd8KqlortrJkdASUq4esIFNqQo9X4LAHLOZqTnh0yDl+812f4Bkej8ah1+uKp87jJGebU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j4iCkVmC; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j4iCkVmC"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50d6b393d60so8031cf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 05:09:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779278941; cv=none;
        d=google.com; s=arc-20240605;
        b=CdzWgvXHvyNsbu1Uhz4qMEZ92vBSR6WelqlYClFuTjeyaOPY6YwcLSeq1IRWoYwMKq
         B4zJ9kOmYBg+7ib6uB5h0ZJem036rFw1DjbhR01RKtZGoGoua7JMbyWMbJGbhjhfrtnR
         cTHIXFMIc7KRGF3Er+e408SU1hSogyTL1xkjWu6WEp6CkNNEpLL8hxYp54867iJIMPjM
         fv9VNlghSz36EvaR6Fo+e9SZRRKDPlHdirSmmfUDzjKoGKqAFtW9OMkDAwJ71LEjpdMr
         BpmKO42tPtGhlNt/XVuj3LGPk4SIVHSBNRiCJMNVP5EKroA8ajAQsVvP7H7wE701TWz2
         gY4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1loqKNqBfUQEUiKNjIaf2//9gQU5EZIeIdKcljTtYYk=;
        fh=0NkLe4JXSJR9hpeM575G2YD/jI1P/gInZpSheui0Q4o=;
        b=LcryuUrXGwZrcsjag6Du/sOmBbrgb0a8U12902MfrCb3AKJ+V6co7xo7Am6FzSFaDs
         hZOmbdfNj2TOBFPaA5FIqAsPAtzTBgSJHX+oGThXbXws+jHlnUf+mhcrgw+rDoA9wbS1
         frVXyS7oSt6H3o1tlZVjURt5IGOiSIoHSYQtDnZwYQoMvFuA/VssTB9qkcykl2L9AWPy
         Z62527d9bTHIA00tgvwGycxS2e3Vved3cEfqnGBXBb+GG3nWKGBItVYxLeJG2Y1ePzQu
         GJWVpgEsHYoKa0ijUsURsM/LuUrpT+OgWhI1LW77CC/hh41NsDqiauQKQtl/IGN/XoPE
         fvbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779278941; x=1779883741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1loqKNqBfUQEUiKNjIaf2//9gQU5EZIeIdKcljTtYYk=;
        b=j4iCkVmCpDUaCHC2XwaUqSxhjP1da4BZ95B+6DukvZ7PBplBVZJVV9eQdIUZPdEdaR
         Fa+GUUjtUmayFkZH5bSanRMHwWBuy0J5S/YeHnxhx9oOc3MNVc+/OqNELuysI7xTkXjh
         eV3e6cnDw+MHoYVy4bNpgQgHui/bX6enw4Ol3mESUjokaDA9yF1j+GoxZ7n05zhOc31N
         m6LIXJOLhm+B2R8SM5rGVvwhWsuaMQuyx3tRQ9W/2mNRKUA3kt3VJzffN9pzgyY6Uo21
         Hpmus7sh9q7ax0vFliOmgoFbcVQgfDkOAkNi1wCHHBuENUvZIWfcPdF7TQTIm8BD16sI
         km8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779278941; x=1779883741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1loqKNqBfUQEUiKNjIaf2//9gQU5EZIeIdKcljTtYYk=;
        b=aqT4rJl7aLfXXozgqsyo+8xmaN1SzMqaT/K2qUy+hL74VLafeY5vamp6MHCQb0qYEH
         wiEv1cNKpDreAjCIdbtLZ5XTjc2KK6qFSysS54L68zifRD0vRUks+C3mkopJO1BOXkBf
         S0gG+0D2jvTEqul0LXalkko/VP7/KHJPaSQeNAJP93s/RE+3e+a0UStX0UcPXP6Dr660
         4ckqEi+wu9Du4bh1ppLDj7iTG3b4wR0EQas1lrDJwzuSabassD5DG/OXvOnavF1LE6Zl
         RFtUk3pzo8DBKgPeX/TcGDn8yOV30WrMfXeNiLPqHCHBYFHC+b0PbG3UHLaZENMOqgEh
         OuBw==
X-Forwarded-Encrypted: i=1; AFNElJ+Eo393xBICru9FZ9UIALz8ePS+HFmrcHgpTSDm/j6LsbGnsu/xHJjFaZhvIzDzQLEqcs6Y9TTIuhfu2Ofkfyiokk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcaNWxOTW9xOky84tid1qxs0Mz+bBpFd1Wg23ySpn0usxDrLPk
	zmJkNehRT9zqBR3QyGQFm6JAO4fXSmbQfT48lcXnyRorLm98b3fMexTadsl34qlGTmcr3i7jqyX
	wTrN3ReVs1HayEKkryoII2SqtXC5mVdx1Wm85Issd
X-Gm-Gg: Acq92OEUv7zbsKExAuhx5QwEcs/w/DNTFWmTtnZWFYzrEzbXQRzac0jyoIXb9v30sK5
	PE6+Iu0QqVVemFvonloELi3l7WzPyKcZZsn49ZKXCH67IFh7+zm2camYpmyudt2KuU9YiMgpv0w
	gGA9cxkbHw0dn0UYHKVGl9l3kmzPwf8bxbp+yFQZuPw3jpHSEeq2mbxxuSM3xVyr7XNn05EGZEc
	YzJ6Uk6pcA8JesL2vs2964SjVY+C3Qo3mCAm00gGhxZoSVQZgOfB8DDthq2IDwf5ii1p0S9ITMI
	mG1++maprgy+Kxr9e5U=
X-Received: by 2002:ac8:5907:0:b0:510:f9b:fb5f with SMTP id
 d75a77b69052e-51679440a95mr44783061cf.16.1779278940348; Wed, 20 May 2026
 05:09:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-4-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-4-91ab5a8b19a4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 20 May 2026 13:08:23 +0100
X-Gm-Features: AVHnY4Kw8N8ACb__H9yJPhDqghW33wyYCjP9ISJAFWq6b956Jd8VrKBSA3-Ts4o
Message-ID: <CA+EHjTyJcR5Vnd2t0Jwy2OxL4DoyE60-hafytFjNi_Ys0DXHiw@mail.gmail.com>
Subject: Re: [PATCH v6 04/43] KVM: Stub in ability to disable per-VM memory
 attribute tracking
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
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
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 May 2026 at 21:22, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> Introduce the basic infrastructure to allow per-VM memory attribute
> tracking to be disabled. This will be built-upon in a later patch, where a
> module param can disable per-VM memory attribute tracking.
>
> Split the Kconfig option into a base KVM_MEMORY_ATTRIBUTES and the
> existing KVM_VM_MEMORY_ATTRIBUTES. The base option provides the core
> plumbing, while the latter enables the full per-VM tracking via an xarray
> and the associated ioctls.
>
> kvm_get_memory_attributes() now performs a static call that either looks up
> kvm->mem_attr_array with CONFIG_KVM_VM_MEMORY_ATTRIBUTES is enabled, or
> just returns 0 otherwise. The static call can be patched depending on
> whether per-VM tracking is enabled by the CONFIG.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  arch/x86/include/asm/kvm_host.h |  2 +-
>  include/linux/kvm_host.h        | 23 ++++++++++++---------
>  virt/kvm/Kconfig                |  4 ++++
>  virt/kvm/kvm_main.c             | 44 ++++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 62 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 60b997764beef..c9aa50bcdac2d 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -2369,7 +2369,7 @@ void kvm_configure_mmu(bool enable_tdp, int tdp_forced_root_level,
>                        int tdp_max_root_level, int tdp_huge_page_level);
>
>
> -#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> +#ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
>  #define kvm_arch_has_private_mem(kvm) ((kvm)->arch.has_private_mem)
>  #endif
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 7d079f9701346..c5ba2cb34e45c 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2528,19 +2528,15 @@ static inline bool kvm_memslot_is_gmem_only(const struct kvm_memory_slot *slot)
>         return slot->flags & KVM_MEMSLOT_GMEM_ONLY;
>  }
>
> -#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> +#ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
> +typedef unsigned long (kvm_get_memory_attributes_t)(struct kvm *kvm, gfn_t gfn);
> +DECLARE_STATIC_CALL(__kvm_get_memory_attributes, kvm_get_memory_attributes_t);
> +
>  static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
>  {
> -       return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
> +       return static_call(__kvm_get_memory_attributes)(kvm, gfn);
>  }
>
> -bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> -                                    unsigned long mask, unsigned long attrs);
> -bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
> -                                       struct kvm_gfn_range *range);
> -bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
> -                                        struct kvm_gfn_range *range);
> -
>  static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>  {
>         return kvm_get_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
> @@ -2550,6 +2546,15 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>  {
>         return false;
>  }
> +#endif
> +
> +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> +bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> +                                    unsigned long mask, unsigned long attrs);
> +bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
> +                                       struct kvm_gfn_range *range);
> +bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
> +                                        struct kvm_gfn_range *range);
>  #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
>
>  #ifdef CONFIG_KVM_GUEST_MEMFD
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 5119cb37145fc..3fea89c45cfb4 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -100,7 +100,11 @@ config KVM_ELIDE_TLB_FLUSH_IF_YOUNG
>  config KVM_MMU_LOCKLESS_AGING
>         bool
>
> +config KVM_MEMORY_ATTRIBUTES
> +       bool
> +
>  config KVM_VM_MEMORY_ATTRIBUTES
> +       select KVM_MEMORY_ATTRIBUTES
>         bool
>
>  config KVM_GUEST_MEMFD
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index abb9cfa3eb04d..ee26f1d9b5fda 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -101,6 +101,17 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(halt_poll_ns_shrink);
>  static bool __ro_after_init allow_unsafe_mappings;
>  module_param(allow_unsafe_mappings, bool, 0444);
>
> +#ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
> +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> +static bool vm_memory_attributes = true;
> +#else
> +#define vm_memory_attributes false
> +#endif
> +DEFINE_STATIC_CALL_RET0(__kvm_get_memory_attributes, kvm_get_memory_attributes_t);
> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(STATIC_CALL_KEY(__kvm_get_memory_attributes));
> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(STATIC_CALL_TRAMP(__kvm_get_memory_attributes));
> +#endif
> +
>  /*
>   * Ordering of locks:
>   *
> @@ -2418,7 +2429,7 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
>  }
>  #endif /* CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT */
>
> -#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> +#ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
>  static u64 kvm_supported_mem_attributes(struct kvm *kvm)
>  {
>  #ifdef kvm_arch_has_private_mem
> @@ -2429,6 +2440,12 @@ static u64 kvm_supported_mem_attributes(struct kvm *kvm)
>         return 0;
>  }
>
> +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> +static unsigned long kvm_get_vm_memory_attributes(struct kvm *kvm, gfn_t gfn)
> +{
> +       return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
> +}
> +
>  /*
>   * Returns true if _all_ gfns in the range [@start, @end) have attributes
>   * such that the bits in @mask match @attrs.
> @@ -2625,7 +2642,24 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
>
>         return kvm_vm_set_mem_attributes(kvm, start, end, attrs->attributes);
>  }
> +#else  /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
> +static unsigned long kvm_get_vm_memory_attributes(struct kvm *kvm, gfn_t gfn)
> +{
> +       BUILD_BUG_ON(1);
> +}
>  #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
> +static void kvm_init_memory_attributes(void)
> +{
> +       if (vm_memory_attributes)
> +               static_call_update(__kvm_get_memory_attributes,
> +                                  kvm_get_vm_memory_attributes);
> +       else
> +               static_call_update(__kvm_get_memory_attributes,
> +                                  (void *)__static_call_return0);
> +}
> +#else  /* CONFIG_KVM_MEMORY_ATTRIBUTES */
> +static void kvm_init_memory_attributes(void) { }
> +#endif /* CONFIG_KVM_MEMORY_ATTRIBUTES */
>
>  struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn)
>  {
> @@ -4925,6 +4959,9 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>                 return 1;
>  #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>         case KVM_CAP_MEMORY_ATTRIBUTES:
> +               if (!vm_memory_attributes)
> +                       return 0;
> +
>                 return kvm_supported_mem_attributes(kvm);
>  #endif
>  #ifdef CONFIG_KVM_GUEST_MEMFD
> @@ -5331,6 +5368,10 @@ static long kvm_vm_ioctl(struct file *filp,
>         case KVM_SET_MEMORY_ATTRIBUTES: {
>                 struct kvm_memory_attributes attrs;
>
> +               r = -ENOTTY;
> +               if (!vm_memory_attributes)
> +                       goto out;
> +
>                 r = -EFAULT;
>                 if (copy_from_user(&attrs, argp, sizeof(attrs)))
>                         goto out;
> @@ -6527,6 +6568,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
>         kvm_preempt_ops.sched_in = kvm_sched_in;
>         kvm_preempt_ops.sched_out = kvm_sched_out;
>
> +       kvm_init_memory_attributes();
>         kvm_init_debug();
>
>         r = kvm_vfio_ops_init();
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
