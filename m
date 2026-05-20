Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821BF2DAFD7
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284903; cv=pass; b=skRLdgTaukLKjugmgFL32mQteGBJbfIgQ9RjzokUWnCJRWoKEJkdxMWazNF26tkuiA5ZUJTQo6M372TAdepAc/MRg5JCmKyWUoMvp14guFl9KDm6Jbl6B/tMKJhfDh7gxwEH7zgludtSWQM26ZJKzglKx9zphiFu+w5MY90IDQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284903; c=relaxed/simple;
	bh=qiAgR915c2CmHYVIagAz0GZLLG4P/KRD0iJeIn6q8LM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nusz91ZFZJDLhhDe6vfWdG8zJO0GWOGwzCvXtJvhLu7iJQGAQ9lRNjir5TtBpNH0TXUhU4xAcyeRYBpy856edMMz5Xr/Hfh2RlE7fj+CITUMiQfg0HR2PbxarOXOB3Pmx5+cDgZVhPUwwzMYbYzYW1DEzJQtA0Kf8RINzIhOU5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K/RbZjwk; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K/RbZjwk"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50d6b393d60so2941cf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 06:48:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779284899; cv=none;
        d=google.com; s=arc-20240605;
        b=MOPeI7zP6IKWin2M2JUr/vQFQymfOHUjMlImQHw0qQAzVsV6/LGFyIi4DigA8nQyLK
         F1pUBW9K+0h0ZOP8+I7yDeERKqIUISiHI0gJCsyFCX190EAWBT15z7dpVMrCC8fYX40N
         5Cy7njMN8mTBZg6ioUR3HHnvgGx3Q2q2BDrU+geiVHB/tdcaN8JUb55E/Be8ihgZBcLu
         Pp2LDZmdpfem07R3xoJjFQ6DlDwkIYI2HrruU34vp+N5FBbDBBBw0/fTKXbg9wBWCU38
         EmL2UR1zsvMqL0cla6gC05TlRcSWEeAH0hGwHkLyrOIw7SE9o9s+hTZYrCJ7c/hIU258
         7mJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ztFmjo5Zo5EuBU+qrePea2SHE7ZHtOIa9devh9QKOJ0=;
        fh=a8lRQQ9tHn5HMtj2jCwR+wGcrc3an7aRt8kI5amm4YY=;
        b=JBCQ4gTKtPEXPq6uEGVH7cPvBWF2qFElx+Lyutmp11VFBUi1ENTc6es1N0XXVQ7RUF
         jXstJmxl/hObP4abASFi4tyruV5JopKmdMVS8dZUD6hycA4GVod+euBdngANXqQaOcyC
         Z6no01bHrILDRNHXpLnOivTftDBdblrZgA6uvphBqOJhExO/pJrkRmJotDFHw/XS4VkY
         IIOpXCmWBO50U7aCma/opDy6Qen5AIlsUj71Dr+uc0hBZ4ha8ZIVoOo1pYveQjGmoKmW
         uuzPzr8KXvH/9DALBGNiGUpUUAunJSQ+g76ZKa6PBZoWbEFwYFBFlBhoqeKfnGRgPCFm
         pd8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779284899; x=1779889699; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ztFmjo5Zo5EuBU+qrePea2SHE7ZHtOIa9devh9QKOJ0=;
        b=K/RbZjwkKnueK5VYeaXGG5ti1+veDwk34125PqjMNLeygDwBNIJxxEyoy3xG5kYqRq
         pV7tEhZQDSYjXD4zjo0oJnyNV0f9npraoP9dHgddw/r/n6loeK2rh3QlQD2XmirwK6jH
         TNNMAHbyTjUWXVxRFlRlfyeTt3hhxULUE5NK/mpkRJD33OwkSgjbRdLsDOftdZeNrMwO
         drZXMOi2hek15Lbw8KevpoQ3mVkepiRznKo5skpBb7uzb00roIySIqj0d5AJ56Phso2O
         UrLpWOdG3H91SQA5iYOXFlJ0Dt8W7+jXgdQaB+Eht7IGz/1R3/8yolfoFy58LJWNuNXF
         vpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779284899; x=1779889699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztFmjo5Zo5EuBU+qrePea2SHE7ZHtOIa9devh9QKOJ0=;
        b=HrBm7p1jlluqR+kSNE9VQWq5rU5Fyz76gDkmikvoTjaYHT+IRpdjdsKZxbXctcE/RY
         FOMPhYIjSqQ3j44/GNd1eOCQiMMqCVL6f7f7iH87dVA3Wwtx7AjITexBi/zQHRsJ/Bj/
         x+YS9Weot2eaGfcUyIdrsw8SljDc3Dj5BmVaQPJSQ6uup4oqLN+WpDQUPsOtrXG1cwAS
         6uudS4faJZrVJdOaMtWoATakOQFZuxfeX85eLoPDTTodTl3njx/Lg552DhuQWwIxlfda
         bzdfj+pwtbe0FrbYevj2dP/DjH6GvMkh2zMR/NnSXSRLMd9EAePhtDo27dyB2Lq/AesI
         0MrA==
X-Forwarded-Encrypted: i=1; AFNElJ8chh9+AJvci4NogjIIEOCgolL82pkNtAGKJObPMEhSqms8i9FRnhRBZdQSUOm51GNM9A95AhyYNXUF5HrCYycO1ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjIN7PLsYu0B0BuKcc8yOy1pDSrkZutmYEYpVhPv0ALA+6BQU3
	MOKeVIWc7UDalIqQlB6BUQa6PrnPjYb6TqnRttgKDgewJh2oBHFbjXR+WykKjaurjQrZ6bHyP9C
	QMht5Uc8+Ybzf6HFl/O+kfOrZLDkGOXUfSPVqxxjS
X-Gm-Gg: Acq92OFuQ6UOj74OoZluahJ1yJFWK8DI8229r8Lm83/a0mcJKQGjRu72Ofha3hdREWo
	d8gM0+h0b46f09uStpXiwPZD5tURuePFexgi/4A0D01KVKGZjhu8V93BABbiI5wjiilCa+aGza7
	WzzwxATwVIH2Ne7X6c3h8+/4KN3DzuTKHVIoGCDMKGYI5hFC2i6TyM1QssZ3ySHizh19THWJCgh
	iVDHt5uikdgeKpGT56K2F6gf4kPyzgZ+2dmCrPNLksvCLTR3ssD3nHQpIbroWMJkOLpgW2IS/ly
	32EoXwr8TUp8vSom9sWdhW+MQAU1Ag==
X-Received: by 2002:ac8:7fc7:0:b0:4ff:bfd9:dd31 with SMTP id
 d75a77b69052e-5167b683f38mr8972121cf.5.1779284898204; Wed, 20 May 2026
 06:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-7-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-7-91ab5a8b19a4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 20 May 2026 14:47:41 +0100
X-Gm-Features: AVHnY4Lt4aJCZG7zHyyVEbse7TC1B-amOpcSsUxTZmECQsMY0Fon9T-IHHMiF9s
Message-ID: <CA+EHjTxg6f0v40EBDE3APXrF_qt=8GTx0dGKrKDLqiNwdU_dQA@mail.gmail.com>
Subject: Re: [PATCH v6 07/43] KVM: guest_memfd: Update kvm_gmem_populate() to
 use gmem attributes
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
> From: Ackerley Tng <ackerleytng@google.com>
>
> Update the guest_memfd populate() flow to pull memory attributes from the
> gmem instance instead of the VM when KVM is not configured to track
> shared/private status in the VM.
>
> Rename the per-VM API to make it clear that it retrieves per-VM
> attributes, i.e. is not suitable for use outside of flows that are
> specific to generic per-VM attributes.
>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>
/fuad


> ---
>  arch/x86/kvm/mmu/mmu.c   |  2 +-
>  include/linux/kvm_host.h | 14 +++++++++++++-
>  virt/kvm/guest_memfd.c   | 24 +++++++++++++++++++++---
>  virt/kvm/kvm_main.c      |  8 +++-----
>  4 files changed, 38 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 153bcc5369985..bfcf9be25598e 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -7997,7 +7997,7 @@ static bool hugepage_has_attrs(struct kvm *kvm, struct kvm_memory_slot *slot,
>         const unsigned long end = start + KVM_PAGES_PER_HPAGE(level);
>
>         if (level == PG_LEVEL_2M)
> -               return kvm_range_has_memory_attributes(kvm, start, end, ~0, attrs);
> +               return kvm_range_has_vm_memory_attributes(kvm, start, end, ~0, attrs);
>
>         for (gfn = start; gfn < end; gfn += KVM_PAGES_PER_HPAGE(level - 1)) {
>                 if (hugepage_test_mixed(slot, gfn, level - 1) ||
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 28a54298d27db..1deab76dc0a2c 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2549,12 +2549,24 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>  #endif
>
>  #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> -bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> +extern bool vm_memory_attributes;
> +bool kvm_range_has_vm_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
>                                      unsigned long mask, unsigned long attrs);
>  bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
>                                         struct kvm_gfn_range *range);
>  bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
>                                          struct kvm_gfn_range *range);
> +#else
> +#define vm_memory_attributes false
> +static inline bool kvm_range_has_vm_memory_attributes(struct kvm *kvm,
> +                                                     gfn_t start, gfn_t end,
> +                                                     unsigned long mask,
> +                                                     unsigned long attrs)
> +{
> +       WARN_ONCE(1, "Unexpected call to kvm_range_has_vm_memory_attributes()");
> +
> +       return false;
> +}
>  #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
>
>  unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn);
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index f055e058a3f28..9d025f518c025 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -924,12 +924,31 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
>
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
> +static bool kvm_gmem_range_is_private(struct gmem_inode *gi, pgoff_t index,
> +                                     size_t nr_pages, struct kvm *kvm, gfn_t gfn)
> +{
> +       pgoff_t end = index + nr_pages - 1;
> +       void *entry;
> +
> +       if (vm_memory_attributes)
> +               return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
> +                                                      KVM_MEMORY_ATTRIBUTE_PRIVATE,
> +                                                      KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +
> +       mt_for_each(&gi->attributes, entry, index, end) {
> +               if (xa_to_value(entry) != KVM_MEMORY_ATTRIBUTE_PRIVATE)
> +                       return false;
> +       }
> +
> +       return true;
> +}
>
>  static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>                                 struct file *file, gfn_t gfn, struct page *src_page,
>                                 kvm_gmem_populate_cb post_populate, void *opaque)
>  {
>         pgoff_t index = kvm_gmem_get_index(slot, gfn);
> +       struct gmem_inode *gi;
>         struct folio *folio;
>         kvm_pfn_t pfn;
>         int ret;
> @@ -944,9 +963,8 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>
>         folio_unlock(folio);
>
> -       if (!kvm_range_has_memory_attributes(kvm, gfn, gfn + 1,
> -                                            KVM_MEMORY_ATTRIBUTE_PRIVATE,
> -                                            KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
> +       gi = GMEM_I(file_inode(file));
> +       if (!kvm_gmem_range_is_private(gi, index, 1, kvm, gfn)) {
>                 ret = -EINVAL;
>                 goto out_put_folio;
>         }
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 4139e903f756a..0a4024948711a 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -103,9 +103,7 @@ module_param(allow_unsafe_mappings, bool, 0444);
>
>  #ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
>  #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> -static bool vm_memory_attributes = true;
> -#else
> -#define vm_memory_attributes false
> +bool vm_memory_attributes = true;
>  #endif
>  DEFINE_STATIC_CALL_RET0(__kvm_get_memory_attributes, kvm_get_memory_attributes_t);
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(STATIC_CALL_KEY(__kvm_get_memory_attributes));
> @@ -2450,7 +2448,7 @@ static unsigned long kvm_get_vm_memory_attributes(struct kvm *kvm, gfn_t gfn)
>   * Returns true if _all_ gfns in the range [@start, @end) have attributes
>   * such that the bits in @mask match @attrs.
>   */
> -bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> +bool kvm_range_has_vm_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
>                                      unsigned long mask, unsigned long attrs)
>  {
>         XA_STATE(xas, &kvm->mem_attr_array, start);
> @@ -2584,7 +2582,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
>         mutex_lock(&kvm->slots_lock);
>
>         /* Nothing to do if the entire range has the desired attributes. */
> -       if (kvm_range_has_memory_attributes(kvm, start, end, ~0, attributes))
> +       if (kvm_range_has_vm_memory_attributes(kvm, start, end, ~0, attributes))
>                 goto out_unlock;
>
>         /*
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
