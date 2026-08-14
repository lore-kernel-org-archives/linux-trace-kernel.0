Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB9033938B;
	Fri, 14 Aug 2026 06:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786689046; cv=none; b=SXYALi1RyEFyMknmd52YvXXJDMn0BMnpT1tlgnFj9/xw7A9ZCpvELgav618Bx+V0kzlRB5mVvVqfBCuFE7UILLcqKfccDbmWlo8XKyvZwgNjKSYhTpFPaGpj3Tb1iEdmWUGia/7ZzF+kZ3lUNZtbo9YmlI4wMqmylyD3qOFKGa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786689046; c=relaxed/simple;
	bh=lvF7pJW1VM34mjkgORqlnrodCT6IZU0t2OrgLf/yWf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tls+K1PHbNiKail8H61Et+lOl8G2MFg9DV4CCOrkfJtJ9fMZaZOHujXrclNp3w41fiOrKFyPGGqmXpOMlJORfxuuU/kvHQOjh+H7OqK27MrgSRRaJfYE7yzHufTsW/gbkQ4+OHqiLHj1VvQzIV5qrf6RIwI1zgHDMerSSlJ0a0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kQ7IW8DF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kQ7IW8DF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786689044; x=1818225044;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lvF7pJW1VM34mjkgORqlnrodCT6IZU0t2OrgLf/yWf8=;
  b=kQ7IW8DFgLX/G6UnC204lEgH5RYrAe15GlpDH434/7r0wUnr74bD0f+u
   J7Uf6VH2bnWYj6mX1SdLgg7GfvAGx6+HIWKJ+Q2Vo0yKM3I5ze9Gg2L1r
   qzIRxy8kDD9sC4u4YdtpjWht0SFzDbQt8Q+6KjBgdZY+pHdUVlWh+jSBQ
   HFfCeV0jVILNngbWGdm30ZHD55uEWQk8jXcBqf5mCv0E3Ex3IYzZGzv95
   zobKO//Fkoihr42/m3deash/K7kC9tTYm3oqVJmnZPaTOFD3mDfyCXi6p
   EmLSfQqOneABR/I2bJbI1SzFe53C+gy0CycHmwAAxu460UFgvNaqVZ0he
   g==;
X-CSE-ConnectionGUID: fCCMCUfeRqO027pG2/7MHg==
X-CSE-MsgGUID: G4BjdzIITQGo5vX1VvWtnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="97858860"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="97858860"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 23:30:41 -0700
X-CSE-ConnectionGUID: Dbj20DsZSw+g4w0B3MfgWw==
X-CSE-MsgGUID: TWw3KlovS5Ot+mNiNFDdEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="288934258"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 23:30:26 -0700
Message-ID: <f41624da-8461-45cf-b555-241091faeb63@linux.intel.com>
Date: Fri, 14 Aug 2026 14:30:23 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 20/41] KVM: Let userspace disable per-VM mem
 attributes, enable per-gmem attributes
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, brauner@kernel.org,
 chao.p.peng@linux.intel.com, david@kernel.org, jmattson@google.com,
 jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org,
 pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com,
 rientjes@google.com, shivankg@amd.com, steven.price@arm.com,
 tabba@google.com, willy@infradead.org, wyihan@google.com,
 yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org,
 suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org,
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
 Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-coco@lists.linux.dev,
 Xiaoyao Li <xiaoyao.li@intel.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-20-2fc18ee6d3ba@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260807-gmem-inplace-conversion-v10-20-2fc18ee6d3ba@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/2026 5:52 AM, Ackerley Tng via B4 Relay wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> Make gmem_in_place_conversion a module parameter so that userspace can
> configure enable or disable the use of VM-level memory attributes. The
> module parameter is only available if CONFIG_KVM_VM_MEMORY_ATTRIBUTES is
> enabled.
> 
> To avoid inconsistencies in the way memory attributes are tracked in KVM
> and guest_memfd, the vm_memory_attributes module_param is made

The description is stale, since there is no module_param called
vm_memory_attributes?

> read-only (0444).
> 
> Since selecting CONFIG_KVM_VM_MEMORY_ATTRIBUTES disables in-place
> conversion, 

"selecting CONFIG_KVM_VM_MEMORY_ATTRIBUTES" doesn't necessarily disable
in-place conversion, it also depends on the setting of
gmem_in_place_conversion.
To be accurate, maybe add "by default"?

actually make CONFIG_KVM_VM_MEMORY_ATTRIBUTES selectable. Make
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
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  4 +++-
>  arch/x86/kvm/Kconfig            | 14 ++++++++++----
>  virt/kvm/kvm_main.c             |  5 ++++-
>  3 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 497da6aaf2942..bb2c1ade62cf9 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1851,7 +1851,9 @@ enum kvm_intr_type {
>  	((vcpu) && (vcpu)->arch.handling_intr_from_guest && \
>  	 (!!in_nmi() == ((vcpu)->arch.handling_intr_from_guest == KVM_HANDLING_NMI)))
>  
> -#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> +#if defined(CONFIG_KVM_SW_PROTECTED_VM) ||	\
> +    defined(CONFIG_KVM_INTEL_TDX) ||		\
> +    defined(CONFIG_KVM_AMD_SEV)
>  #define kvm_arch_has_private_mem(kvm) ((kvm)->arch.has_private_mem)
>  #endif
>  
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index abb108886733a..2c3c22aeafa54 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -81,13 +81,21 @@ config KVM_WERROR
>  	  If in doubt, say "N".
>  
>  config KVM_VM_MEMORY_ATTRIBUTES
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
>  config KVM_SW_PROTECTED_VM
>  	bool "Enable support for KVM software-protected VMs"
>  	depends on EXPERT
>  	depends on KVM_X86 && X86_64
> -	select KVM_VM_MEMORY_ATTRIBUTES
>  	help
>  	  Enable support for KVM software-protected VMs.  Currently, software-
>  	  protected VMs are purely a development and testing vehicle for
> @@ -138,7 +146,6 @@ config KVM_INTEL_TDX
>  	bool "Intel Trust Domain Extensions (TDX) support"
>  	default y
>  	depends on INTEL_TDX_HOST
> -	select KVM_VM_MEMORY_ATTRIBUTES
>  	select HAVE_KVM_ARCH_GMEM_POPULATE
>  	help
>  	  Provides support for launching Intel Trust Domain Extensions (TDX)
> @@ -162,7 +169,6 @@ config KVM_AMD_SEV
>  	depends on KVM_AMD && X86_64
>  	depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
>  	select ARCH_HAS_CC_PLATFORM
> -	select KVM_VM_MEMORY_ATTRIBUTES
>  	select HAVE_KVM_ARCH_GMEM_CONVERT
>  	select HAVE_KVM_ARCH_GMEM_RECLAIM
>  	select HAVE_KVM_ARCH_GMEM_INVALIDATE
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index c8faf1cb82167..85dfc3f5af805 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -103,7 +103,10 @@ static bool __ro_after_init allow_unsafe_mappings;
>  module_param(allow_unsafe_mappings, bool, 0444);
>  
>  #ifdef kvm_arch_has_private_mem
> -bool __ro_after_init gmem_in_place_conversion = false;
> +bool __ro_after_init gmem_in_place_conversion = !IS_ENABLED(CONFIG_KVM_VM_MEMORY_ATTRIBUTES);
> +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> +module_param(gmem_in_place_conversion, bool, 0444);
> +#endif
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(gmem_in_place_conversion);
>  #endif
>  
> 

