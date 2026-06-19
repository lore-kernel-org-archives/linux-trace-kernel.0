Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F60832B114
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Jun 2026 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781858137; cv=pass; b=OT3lP24lwDEduvDAvhXD+OuLnG5b2IuQP/+5SJjdcsk/GPdjYBEphvdTZi0bC7hB6OwulrodydV2th7EC0jl+69mh8ZBlIZNoUg51Y3eeE0bLpaKTXPlhX1fRJhKbCPTsNlfjtJDaeB3MI/Iu0fDt6crPeEk92/ko6gybTWeenQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781858137; c=relaxed/simple;
	bh=/2P664m7jGEtDAIgqO27YOlQWepzpwSiTCXRoum/oLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wj+7wO7QNEjonU5b4yXVCFBaW0z7BSVPicBruDCXJS02SyQQsVLcnI7QeILAPncxOfiMHdadP+hqUifjkq1d+9nWaS3kgAenx7Kbp/vEPugDv66EmVsru5xHJH8wCh0uq6w/73EuNnGmfrHPUi+IdIE2jzEaWo8MbsdBnNSqLSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=udsHHS+i; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="udsHHS+i"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-519ed52bcc6so104631cf.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Jun 2026 01:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781858135; cv=none;
        d=google.com; s=arc-20260327;
        b=KUSKIWoJQjGVX2Q/UHSoS+JfbWEq5Q6WTJIwvPdiMbrw31j2ObtZnxXagF5f31kuaM
         dLCxP+32dwdfZlejqfiyNpQEkjgiGfye2/1kE8lagEdusqMnf3Z8txUWEZgDkGiN+vXj
         aNyGN9jybz/gtxK//fCNeRsV8qRKg389lFv0Dc084u+AhFHC/wjIhWYLE88oKNvBiLgg
         6kCNntHdH6gz/oVGjB7raDhO7wlEFvCFEUMdVV3Q7/+QQV/5CQVULcM9umQlc+opre7j
         0WwwHkzF5afLqkBW+XCue4gNYvUfjV/tGast5vPpOJFIX4CVbw8OUMqsPWD4W+dqVNHy
         jdIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vJCNxtqxuBlYp3k8AwtzAL+0dBQBaE1Rgq6EFlCIf04=;
        fh=8Brs+KqCCI1jptE7XZHHNO4HT/SxzuJIXCeEimm/szo=;
        b=sY03C4H1yH0bi7cF8aajLWXIn7pc9lXUco2Fhaot6U30+6eeVGIKyG3jhorkDqLq/w
         o6wYdK3oFe+bmprXicJrKnOhiIiuiVJTOCjWanp5o3+zPz5F34MHNgog5Skoe9X/c5j3
         zfIKs4thArL/l9YmuKD5K9wGucAay0vZkpNkSwWFNyJNf19QnbonN6R5xyMG4nBfM1hS
         2VfjOb2L08WNevF1kdpeFcxjbOI5ZYzCEwuKxnwXOw5EA0sxPiNiynLXZm/P9K2ONg49
         KL4A9UrbEcWnhcXr1qNLNaDdA/7e0/AT+gnXmnP6hwA4lBjmAmrQszMVoaUCGY0lFDji
         2IEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781858135; x=1782462935; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vJCNxtqxuBlYp3k8AwtzAL+0dBQBaE1Rgq6EFlCIf04=;
        b=udsHHS+i25aggofArHhr2DS9m2ry8BQzgg3eT2kMYyLe77BdjoruBV9gi3qxkPzyA2
         PkXqN5uCS0x92UWIv/YoFDZdkGs2Me24stmBd4Gs7t8/WcOoTlenIh/DsAcRhBUzQiVF
         AiqwjI6X1AdurJ7DJ+MPiJVXQk6UQZzveYywVdOxc9JmVtEpVvOTMkmmRqu5ZA2tmpvr
         0dtawsZDq5vMfEk7UdMyxTWkko3CgFUaLoZSUwC3wWL3flZVOM1fU3o3pwNFwX3KQYNF
         k+AeXJ8NmaI1LUw1v1yF3qYIYX9kjZ8YQUErPGaNm7Ip6+fZIdcPG9RYAsWKHBzS/44e
         ZuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781858135; x=1782462935;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vJCNxtqxuBlYp3k8AwtzAL+0dBQBaE1Rgq6EFlCIf04=;
        b=BBOSSIb50YZjWplYgUTJKITI+dZcfuZexAV8nZ+SLXLuemu0wUQlK9TpLv9eq3HZ7d
         OjkHV5WJPdeSRv5i6kd7dZtivBLbbbxQ9jeJGpSOCMsAGDLvIvDYlq8tOcDoEnFjSPgv
         ynRz/8JbRljk236H4W7WZ1O65A4VwUO6fZLjEk3674VT0e9+Ahbl18T8FowpLJF3rbKn
         wKfSZ2DS9tbeABZ7ukhFLyw/CWeCixzvFkgGqWiPCmoKXyL2NDAyjF0M+t+hyVLJ/HRC
         xf4YFdsOpz2BhRCWH8UiSQqw8QxYT43IDy7SI3w5egTWwfXtJl7j8Mpp4jfbr4mPTyN9
         jAGQ==
X-Forwarded-Encrypted: i=1; AFNElJ8h0BN4ZiEhWkwhsPZhgHm0fs304XcpIXy7U8HrhSJ2UNgydP1g7SJjmC0xz5DaNS8rR6+O1fZPRObP1wsdymGzZWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvQkGrTxMPXnN3VsDz95TZOvp5DijmrgIIjTrTaf2cdbQzulxz
	xp45lugPJ8rg514Ks2a0P0jZ9QncpCr6DdB4KCGOGyKZgb+GVbnf2Qvb+2BbqKBAVqpj4uAQkZe
	BepyH/R9RX1w5C7XixNp8iB1KJ2hWB2iW+gGRBd3Q
X-Gm-Gg: AfdE7clX34huEnIDAYgCSvFZyiT0K6Y/qknplRtCeFAlxz7inxmxbELJ9KONjzyNVcm
	fOGx60isbisJlE+BQzRuhSvtT+1FaNAuTvHAaZyeLZl40YnYcfl7g22Gc9zGYzmz8W8PXGYR/DS
	N+xlBIw7K85bs3DC4CfqTC4YBM13kQnttg360/Yx1aUhtVKLo971fL44y2HF1+MFJkN9Sst8X07
	j3oywPGYQd6Xeufq4tBF4UkxNPmjPz799LNn2BGLH2H3oJh7v3GYgldDlFLWIEOk/1A1Kwq3Q==
X-Received: by 2002:a05:622a:8893:b0:517:99ea:ab7e with SMTP id
 d75a77b69052e-519e4a70452mr6973311cf.24.1781858134705; Fri, 19 Jun 2026
 01:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-10-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-10-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 19 Jun 2026 09:34:57 +0100
X-Gm-Features: AVVi8Ce8UOYY3ibWf7EXz5J6tTWRIQf_RIk-gcXz8kRs-aLeFMDUqknE2c7ssDk
Message-ID: <CA+EHjTyGPo0JMsN8WFMer-2NWv6kNNUnyads+YHEXC20CwPjXQ@mail.gmail.com>
Subject: Re: [PATCH v8 10/46] KVM: guest_memfd: Wire up core private/shared
 attribute interfaces
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
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jun 2026 at 01:31, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> With in-place conversion, guest_memfd is able to track the private/shared
> status of memory. Use a global flag to toggle between tracking
> private/shared status per-vm or within guest_memfd.
>
> When queried for supported vm memory attributes, return 0 if attributes are
> tracked in guest_memfd.
>
> When querying for memory attributes over a range, look up memory attributes
> based on the flag's state at query time.
>
> For per-GFN memory attribute queries, choosing an implementation (VM or
> guest_memfd lookup) at KVM load time.
>
> The flag is always false for now and will be made toggle-able after all
> in-place conversion features are added in subsequent patches.
>
> If/since the flag is false, if CONFIG_KVM_VM_MEMORY_ATTRIBUTES is also not
> selected, the per-GFN memory attribute query defaults to returning
> 0 (false/not private).
>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  include/linux/kvm_host.h |  4 ++++
>  virt/kvm/guest_memfd.c   | 22 +++++++++++++++++++---
>  virt/kvm/kvm_main.c      | 12 +++++++++++-
>  3 files changed, 34 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 27687fb9d5201..acb552745b428 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2560,6 +2560,8 @@ static inline bool kvm_mem_range_is_private(struct kvm *kvm, gfn_t start,
>  #endif  /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
>
>  #ifdef kvm_arch_has_private_mem
> +extern bool gmem_in_place_conversion;
> +
>  typedef bool (kvm_mem_is_private_t)(struct kvm *kvm, gfn_t gfn);
>  DECLARE_STATIC_CALL(__kvm_mem_is_private, kvm_mem_is_private_t);
>
> @@ -2568,6 +2570,8 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>         return static_call(__kvm_mem_is_private)(kvm, gfn);
>  }
>  #else
> +#define gmem_in_place_conversion false
> +
>  static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>  {
>         return false;
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index bca912db5be6e..e0e544ef47d69 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -926,6 +926,24 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
>
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
> +static bool kvm_gmem_range_is_private(struct file *file, pgoff_t index,
> +                                     size_t nr_pages, struct kvm *kvm, gfn_t gfn)
> +{
> +       struct maple_tree *mt = &GMEM_I(file_inode(file))->attributes;
> +       pgoff_t end = index + nr_pages - 1;
> +       void *entry;
> +
> +       if (!gmem_in_place_conversion)
> +               return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
> +                                                         KVM_MEMORY_ATTRIBUTE_PRIVATE,
> +                                                         KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +
> +       mt_for_each(mt, entry, index, end) {
> +               if (xa_to_value(entry) != KVM_MEMORY_ATTRIBUTE_PRIVATE)
> +                       return false;
> +       }
> +       return true;
> +}
>
>  static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>                                 struct file *file, gfn_t gfn, struct page *src_page,
> @@ -946,9 +964,7 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>
>         folio_unlock(folio);
>
> -       if (!kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + 1,
> -                                               KVM_MEMORY_ATTRIBUTE_PRIVATE,
> -                                               KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
> +       if (!kvm_gmem_range_is_private(file, index, 1, kvm, gfn)) {
>                 ret = -EINVAL;
>                 goto out_put_folio;
>         }
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 8b238e461b854..01761f6e25d25 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -101,6 +101,10 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(halt_poll_ns_shrink);
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
> @@ -2422,6 +2426,9 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
>  static u64 kvm_supported_vm_mem_attributes(struct kvm *kvm)
>  {
>  #ifdef kvm_arch_has_private_mem
> +       if (gmem_in_place_conversion)
> +               return 0;
> +
>         if (!kvm || kvm_arch_has_private_mem(kvm))
>                 return KVM_MEMORY_ATTRIBUTE_PRIVATE;
>  #endif
> @@ -2633,8 +2640,11 @@ EXPORT_STATIC_CALL_GPL(__kvm_mem_is_private);
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
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
