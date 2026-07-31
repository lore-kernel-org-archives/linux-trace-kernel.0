Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0193C3D75D3;
	Fri, 31 Jul 2026 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785487737; cv=none; b=QRyL2xcCMZDiP7xjEGmW4RFKrk3JBXv3asXDTxpToSmwf2Z2VDYlW8G5R6B7X7/fHNvw0T5iDeh20WZ8i8WmOE+zWfiiOPkptN5gtzA0l8/hwYvF61m60nLhfTmEKANb0jRUqeYRC1DF4d7i/9A4VWk5BzxysWcrruRLQytg2O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785487737; c=relaxed/simple;
	bh=HUslESBRwUMZ0nIYtDZHqU/vSK5vrxqzYKo2GaPJ8E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNdPdqRx+t2MLb7bxtIFUn6nf11OU/MX1B+KyPZdXKzbqvY8/VFWPvFnq80ZdjVeBGupJ6oOV6XONDGaSY9Rbw7DcbTUVZ89RxcfBXx2Ekaz8HdAP+LN0M78p2V9ExXycHSPFqunZk2h7r1IgzhTsy+UV2pEZ5Ab02Zt+oWsffE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fG3ztazc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fG3ztazc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785487734; x=1817023734;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HUslESBRwUMZ0nIYtDZHqU/vSK5vrxqzYKo2GaPJ8E4=;
  b=fG3ztazcN5tw9OIkae9RsZIahi9YChRM/X6b4vHmCCSo7LaFT7D95lfL
   YqPy44uQKwcEIJQz8CkAqlC/ciwc2NXKv83Xzd/WEXxfQdMr/I7d3STte
   uM5MurQgHTkOA6OLW8hd0pf1qwTDnkEqs8Zfsds6Fmv6kI5jiPl1D4WyA
   4ebd4jlcUU9hA52zQIFgDwe+M29O4k4ZKo9TNGa1CuX+8i7Z00+lUM+9/
   TMugwNBwd+qxvB9deYvCo+MjN/wnySED8v4ovFnkEgz1XRmtCkxP8skMd
   utxfViX8QT6FHEH7Jimqz+QXOqmNPRhlbYPl3Ie6lhWPGTlxkkuBeLoxY
   Q==;
X-CSE-ConnectionGUID: DZt75D95SmmslyFgxfhFfQ==
X-CSE-MsgGUID: GcyvQWFMQA2S4IVki/I8EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="86062840"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="86062840"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 01:48:51 -0700
X-CSE-ConnectionGUID: u7DGKLPZS/eJ51NjhAIFwA==
X-CSE-MsgGUID: ExP7CWv0QIW+0DfJQgeuiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="262491487"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.248]) ([10.124.240.248])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 01:48:35 -0700
Message-ID: <7f23d149-b7f0-465a-a9c0-5c7484e289d2@intel.com>
Date: Fri, 31 Jul 2026 16:48:29 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 20/41] KVM: Let userspace disable per-VM mem
 attributes, enable per-gmem attributes
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
 Peter Xu <peterx@redhat.com>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-coco@lists.linux.dev
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
 <20260728-gmem-inplace-conversion-v9-20-35f9aec2aed2@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260728-gmem-inplace-conversion-v9-20-35f9aec2aed2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/2026 8:35 AM, Ackerley Tng via B4 Relay wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> Make gmem_in_place_conversion a module parameter so that userspace can
> configure enable or disable the use of VM-level memory attributes. The
> module parameter is only available if CONFIG_KVM_VM_MEMORY_ATTRIBUTES is
> enabled.
> 
> To avoid inconsistencies in the way memory attributes are tracked in KVM
> and guest_memfd, the vm_memory_attributes module_param is made
> read-only (0444).
> 
> Since selecting CONFIG_KVM_VM_MEMORY_ATTRIBUTES disables in-place
> conversion, actually make CONFIG_KVM_VM_MEMORY_ATTRIBUTES selectable. Make
> the config only selectable for (CoCo) VM types that might use
> vm_memory_attributes.
> 
> Since memory attributes are trackable in guest_memfd, the concept of having
> private memory is no longer dependent on
> CONFIG_KVM_VM_MEMORY_ATTRIBUTES. Define kvm_arch_has_private_mem() based on
> platform config, so that having private memory is dependent on (CoCo) VM
> type.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Tested-by: Shivank Garg <shivankg@amd.com>
> [Define module_param only if CONFIG_KVM_VM_MEMORY_ATTRIBUTES is enabled]
> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>   arch/x86/include/asm/kvm_host.h |  4 +++-
>   arch/x86/kvm/Kconfig            | 14 ++++++++++----
>   virt/kvm/guest_memfd.c          |  2 ++
>   virt/kvm/kvm_main.c             |  5 ++++-
>   4 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index ceb2abf43b76f..766eb094eaae6 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1849,7 +1849,9 @@ enum kvm_intr_type {
>   	((vcpu) && (vcpu)->arch.handling_intr_from_guest && \
>   	 (!!in_nmi() == ((vcpu)->arch.handling_intr_from_guest == KVM_HANDLING_NMI)))
>   
> -#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> +#if defined(CONFIG_KVM_SW_PROTECTED_VM) ||	\
> +    defined(CONFIG_KVM_INTEL_TDX) ||		\
> +    defined(CONFIG_KVM_AMD_SEV)
>   #define kvm_arch_has_private_mem(kvm) ((kvm)->arch.has_private_mem)
>   #endif
>   
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index abb108886733a..2c3c22aeafa54 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -81,13 +81,21 @@ config KVM_WERROR
>   	  If in doubt, say "N".
>   
>   config KVM_VM_MEMORY_ATTRIBUTES
> -	bool
> +	bool "Enable per-VM PRIVATE vs. SHARED attributes (for CoCo VMs)"
> +	depends on KVM_SW_PROTECTED_VM || KVM_INTEL_TDX || KVM_AMD_SEV
> +	help
> +	  Enable support for tracking PRIVATE vs. SHARED memory using per-VM
> +	  memory attributes.  Using per-VM attributes is deprecated in favor of
> +	  tracking PRIVATE state in guest_memfd.  Select this if you need to run
> +	  CoCo VMs using a VMM that doesn't support guest_memfd memory
> +	  attributes.
> +
> +	  If unsure, say N.
>   
>   config KVM_SW_PROTECTED_VM
>   	bool "Enable support for KVM software-protected VMs"
>   	depends on EXPERT
>   	depends on KVM_X86 && X86_64
> -	select KVM_VM_MEMORY_ATTRIBUTES
>   	help
>   	  Enable support for KVM software-protected VMs.  Currently, software-
>   	  protected VMs are purely a development and testing vehicle for
> @@ -138,7 +146,6 @@ config KVM_INTEL_TDX
>   	bool "Intel Trust Domain Extensions (TDX) support"
>   	default y
>   	depends on INTEL_TDX_HOST
> -	select KVM_VM_MEMORY_ATTRIBUTES
>   	select HAVE_KVM_ARCH_GMEM_POPULATE
>   	help
>   	  Provides support for launching Intel Trust Domain Extensions (TDX)
> @@ -162,7 +169,6 @@ config KVM_AMD_SEV
>   	depends on KVM_AMD && X86_64
>   	depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
>   	select ARCH_HAS_CC_PLATFORM
> -	select KVM_VM_MEMORY_ATTRIBUTES
>   	select HAVE_KVM_ARCH_GMEM_CONVERT
>   	select HAVE_KVM_ARCH_GMEM_RECLAIM
>   	select HAVE_KVM_ARCH_GMEM_INVALIDATE
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index ea2752989f8bd..df67a6188aa99 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -1137,10 +1137,12 @@ static bool kvm_range_is_private(struct file *file, pgoff_t index,
>   {
>   	struct inode *inode = file_inode(file);
>   
> +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>   	if (!gmem_in_place_conversion)
>   		return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
>   							  KVM_MEMORY_ATTRIBUTE_PRIVATE,
>   							  KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +#endif
>   
>   	return kvm_gmem_range_has_attributes(inode, index, nr_pages,
>   					     KVM_MEMORY_ATTRIBUTE_PRIVATE);

With my suggestion[1] on patch 7, this diff block can be dropped.

[1] 
https://lore.kernel.org/all/dd4201f2-3660-46ad-958f-c70feb1ab1c3@intel.com/

The code looks good to me,

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index e961cc297ba2a..eb9f433278d2f 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -102,7 +102,10 @@ static bool __ro_after_init allow_unsafe_mappings;
>   module_param(allow_unsafe_mappings, bool, 0444);
>   
>   #ifdef kvm_arch_has_private_mem
> -bool __ro_after_init gmem_in_place_conversion = false;
> +bool __ro_after_init gmem_in_place_conversion = !IS_ENABLED(CONFIG_KVM_VM_MEMORY_ATTRIBUTES);
> +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> +module_param(gmem_in_place_conversion, bool, 0444);
> +#endif
>   EXPORT_SYMBOL_FOR_KVM_INTERNAL(gmem_in_place_conversion);
>   #endif
>   
> 

