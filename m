Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8899419304;
	Wed, 12 Aug 2026 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527949; cv=none; b=D1bqff4KCT7BmLDuKU8fXrqmRrC6wqCvfM/kacJl8QJHJVf9ffMXDhVSvuxe185KkE4uJWYFB/QVT2znlSpfNyYEpH1efVGvBJDbcrEKFLHOXOh5arFRrMajNHupqjYXsv4N2syHNKsn0ZXsaYqMEIXKkwAja8vEXMkBRfpjjUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527949; c=relaxed/simple;
	bh=k2pFVBuHbEgDL9fsrNxSQM9oxmXhYdThPBDj2S6Ri8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3Jp9rRQgElBeB0EWGH9Gtozt8EbD5Ygr3w5urOIksUThF18FY109NFQM13FFN6RC3m/WFOvnKbxKrB62OucJ+aySNtupwfPDMKwLZlr5/x7oRWlLl4XDPmcV+Ho1fFM7kc4Txp8GrSfgrIvd9XhanyzpNxPPA53LhUxVUruO5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yx9zgwzI; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yx9zgwzI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786527948; x=1818063948;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k2pFVBuHbEgDL9fsrNxSQM9oxmXhYdThPBDj2S6Ri8o=;
  b=Yx9zgwzIOwyRR465ww7BXCcFgCDdfBLQapk2hZ8uNSJ+W7bYiuabiAcY
   9pMhf8xjVYNogMfHet11TjmIGjSECm2IU3EWmQOJ7jN0vs+3xW1tALdEI
   hP8Rcw3aKOhHqM3blBLMqisCzr/0r493VBWA/a+5r9KmDDLmsgeRSF6la
   BNNHcFhYym6mMslymIvy+2ywdFPDoPeXH8cOXY0nc18r2Ns4Q+KTt5avD
   tljefOM1fxHoMD78cl4liTi8n/FghrTFj0DIl9ABPG7j/8ni2zIpRllmM
   4E7yINxJ29JjBLATGWfmlyYWXT33K3vriluYuzTe0U/KA4Rw4+PxaZCzm
   A==;
X-CSE-ConnectionGUID: QnSQZY3/RlmNSOVN3FKmWQ==
X-CSE-MsgGUID: VfdbsRAzT1+vJZe81uyrqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87097282"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="87097282"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 02:45:47 -0700
X-CSE-ConnectionGUID: iA51UbaQRN6kQuJUiJ7UBg==
X-CSE-MsgGUID: Sa2YR4TXTseveV8gKuW5Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="267093839"
Received: from unknown (HELO [10.238.208.98]) ([10.238.208.98])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 02:45:32 -0700
Message-ID: <33482cef-9fb7-4a45-b45a-261e0a4e7de3@intel.com>
Date: Wed, 12 Aug 2026 17:45:29 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 07/41] KVM: guest_memfd: Stub in ability to enable
 in-place shared<=>private conversion
To: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev,
 binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com,
 david@kernel.org, jmattson@google.com, jthoughton@google.com,
 michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com,
 qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com,
 shivankg@amd.com, steven.price@arm.com, tabba@google.com,
 willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com,
 forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com,
 aneesh.kumar@kernel.org, liam@infradead.org,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, tarunsahu@google.com,
 Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-coco@lists.linux.dev
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-7-2fc18ee6d3ba@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260807-gmem-inplace-conversion-v10-7-2fc18ee6d3ba@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/2026 5:52 AM, Ackerley Tng via B4 Relay wrote:
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

The names will finalized eventually and it won't impact the 
implementation. So,

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   include/linux/kvm_host.h |  6 ++++++
>   virt/kvm/guest_memfd.c   | 26 ++++++++++++++++++++++++++
>   virt/kvm/kvm_main.c      | 12 +++++++++++-
>   3 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 65fbce46b63f4..9477ecebbbced 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2580,6 +2580,8 @@ static inline bool kvm_vm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>   #endif  /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
>   
>   #ifdef kvm_arch_has_private_mem
> +extern bool gmem_in_place_conversion;
> +
>   typedef bool (kvm_mem_is_private_t)(struct kvm *kvm, gfn_t gfn);
>   DECLARE_STATIC_CALL(__kvm_mem_is_private, kvm_mem_is_private_t);
>   
> @@ -2588,6 +2590,8 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>   	return static_call(__kvm_mem_is_private)(kvm, gfn);
>   }
>   #else
> +#define gmem_in_place_conversion false
> +
>   static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>   {
>   	return false;
> @@ -2595,6 +2599,8 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>   #endif /* kvm_arch_has_private_mem */
>   
>   #ifdef CONFIG_KVM_GUEST_MEMFD
> +bool kvm_gmem_is_private(struct kvm *kvm, gfn_t gfn);
> +
>   int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>   		     gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
>   		     int *max_order);
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 1f1ae61b4878b..75979c885e030 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -475,6 +475,32 @@ static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
>   	return 0;
>   }
>   
> +bool kvm_gmem_is_private(struct kvm *kvm, gfn_t gfn)
> +{
> +	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
> +	struct inode *inode;
> +
> +	if (!slot)
> +		return 0;
> +
> +	CLASS(gmem_get_file, file)(slot);
> +	if (!file)
> +		return 0;
> +
> +	inode = file_inode(file);
> +
> +	/*
> +	 * Rely on the maple tree's internal RCU lock to ensure a stable result.
> +	 * This result can become stale as soon as the lock is dropped, so the
> +	 * caller _must_ protect consumption of private vs. shared either by
> +	 * holding guest_memfd's invalidate lock for the entire duration, or by
> +	 * checking mmu_invalidate_retry_gfn() under mmu_lock to serialize
> +	 * against concurrent attribute updates.
> +	 */
> +	return kvm_gmem_is_private_mem(inode, kvm_gmem_get_index(slot, gfn));
> +}
> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_is_private);
> +
>   static struct file_operations kvm_gmem_fops = {
>   	.mmap		= kvm_gmem_mmap,
>   	.open		= generic_file_open,
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index a01d336eab18b..0a5a1bee8de0f 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -102,6 +102,10 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(halt_poll_ns_shrink);
>   static bool __ro_after_init allow_unsafe_mappings;
>   module_param(allow_unsafe_mappings, bool, 0444);
>   
> +#ifdef kvm_arch_has_private_mem
> +bool __ro_after_init gmem_in_place_conversion = false;
> +#endif
> +
>   /*
>    * Ordering of locks:
>    *
> @@ -2423,6 +2427,9 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
>   static u64 kvm_supported_vm_mem_attributes(struct kvm *kvm)
>   {
>   #ifdef kvm_arch_has_private_mem
> +	if (gmem_in_place_conversion)
> +		return 0;
> +
>   	if (!kvm || kvm_arch_has_private_mem(kvm))
>   		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
>   #endif
> @@ -2634,8 +2641,11 @@ EXPORT_STATIC_CALL_GPL(__kvm_mem_is_private);
>   
>   static void kvm_init_memory_attributes(void)
>   {
> +	if (gmem_in_place_conversion)
> +		static_call_update(__kvm_mem_is_private, kvm_gmem_is_private);
>   #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> -	static_call_update(__kvm_mem_is_private, kvm_vm_mem_is_private);
> +	else
> +		static_call_update(__kvm_mem_is_private, kvm_vm_mem_is_private);
>   #endif
>   }
>   #else
> 

