Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A424D41B37D;
	Tue, 30 Jun 2026 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816937; cv=none; b=mvbsAFgNePhUo4V2WmV9qiqv6boOxLaq5oqYz4cXr2MZGQ/JX9sFlE4wVleC8Xt3kkm6M+9BcI1/OLoDLbD3HUECHsk4vwl5pFvy6OvkdOM3m258uTaPin/POwgXAtCSlmtMfpCUCcL1iOfwHuwZb8+HzxhQfLnXWHEGhJsDT1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816937; c=relaxed/simple;
	bh=OinqCn7yZwhhZsCKKCwIFGV4JtEuLIbKl0RX5IPXpt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfFFGa0+0KibowYjoZ3agQcYdR+CcBaNgTgfyCGa29o/daamfLt2w3MsPyufM4HPGrrBR8c749zwmSVwGCUHyZoxznWluxNV5rgm/KY5QdMlI7itjQqo5tV/qWOdQI2u/+Mv8ttqNrqLMWMYZEF0Gh4mjDvmgehj0IZFKl925Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HU4nsEpy; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HU4nsEpy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782816932; x=1814352932;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OinqCn7yZwhhZsCKKCwIFGV4JtEuLIbKl0RX5IPXpt0=;
  b=HU4nsEpyZFVubkTkW/GtIp+Q6UfQRT/qtAsyb5s8qD5w8pnUWeFy/I5F
   jxtY8sU8I0YHRKK2orDN5Ej+HnRAOIRaBiUxYZhFfXCoppxV8+netiYmq
   XLpvfXByf3TKzDbKPHSEil7gNrWW6Xo6Lc5wE2oqXtNltBGjAhOwIL1Qn
   FvCEQyB1Lf0jEAiKK/qW96g0XXwNNXK2Z+Y7U7kNYl4xeat8cohBYmZ4M
   +wYeJGPsEHuLUCnjixDrhuhZrSjC0CGUa1NBvzdQYIl7gJ5Cp/A6a3p3w
   vKdvNCgYPkyifJPW2AHBVVMTOrkVp+AmFFgRi9mdQZMs0pllqP/CXuCbQ
   w==;
X-CSE-ConnectionGUID: hvAO08+JRqOyqmEu50xLtA==
X-CSE-MsgGUID: oCA/cxp/S6Swn/kyRfDLTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94677483"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="94677483"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 03:55:31 -0700
X-CSE-ConnectionGUID: QRJE9D0fTAuqi24otunImw==
X-CSE-MsgGUID: xXZpy8SqQASrfl6ZIk3hPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="290361286"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.239.158.70]) ([10.239.158.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 03:55:17 -0700
Message-ID: <39671141-d317-40ab-8c50-66252015514c@intel.com>
Date: Tue, 30 Jun 2026 18:55:14 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/46] KVM: Make CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 selectable
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
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-coco@lists.linux.dev
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-5-9d2959357853@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-5-9d2959357853@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> Make CONFIG_KVM_VM_MEMORY_ATTRIBUTES selectable, only for (CoCo) VM types
> that might use vm_memory_attributes.
> 
> Also document CONFIG_KVM_VM_MEMORY_ATTRIBUTES to specifically be about the
> private/shared attribute.

I think this patch needs to be moved later after per-gmem shared/private 
attribute is implemented. Because so far, TDX/SEV indeed depend on 
CONFIG_KVM_VM_MEMORY_ATTRIBUTES.

Not to discuss if it makes sense to report TDX as supported VM TYPE when 
CONFIG_KVM_VM_MEMORY_ATTRIBUTES is not enabled, this patch just fails 
the compilation when

   CONFIG_KVM_VM_MEMORY_ATTRIBUTES = n

and KVM_INTEL_TDX/KVM_AMD_SEV is enabled:

arch/x86/kvm/../../../virt/kvm/guest_memfd.c: In function 
‘__kvm_gmem_populate’:
arch/x86/kvm/../../../virt/kvm/guest_memfd.c:918:14: error: implicit 
declaration of function ‘kvm_range_has_memory_attributes’ 
[-Werror=implicit-function-declaration]
   918 |         if (!kvm_range_has_memory_attributes(kvm, gfn, gfn + 1,
       |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/Kconfig | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 24f96396cfa1c..c28393dc664eb 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -81,13 +81,16 @@ config KVM_WERROR
>   	  If in doubt, say "N".
>   
>   config KVM_VM_MEMORY_ATTRIBUTES
> -	bool
> +	depends on KVM_SW_PROTECTED_VM || KVM_INTEL_TDX || KVM_AMD_SEV
> +	bool "Enable per-VM PRIVATE vs. SHARED attributes (for CoCo VMs)"
> +	help
> +	  Enable support for tracking PRIVATE vs. SHARED memory using per-VM
> +	  memory attributes.
>   
>   config KVM_SW_PROTECTED_VM
>   	bool "Enable support for KVM software-protected VMs"
>   	depends on EXPERT
>   	depends on KVM_X86 && X86_64
> -	select KVM_VM_MEMORY_ATTRIBUTES
>   	help
>   	  Enable support for KVM software-protected VMs.  Currently, software-
>   	  protected VMs are purely a development and testing vehicle for
> @@ -138,7 +141,6 @@ config KVM_INTEL_TDX
>   	bool "Intel Trust Domain Extensions (TDX) support"
>   	default y
>   	depends on INTEL_TDX_HOST
> -	select KVM_VM_MEMORY_ATTRIBUTES
>   	select HAVE_KVM_ARCH_GMEM_POPULATE
>   	help
>   	  Provides support for launching Intel Trust Domain Extensions (TDX)
> @@ -162,7 +164,6 @@ config KVM_AMD_SEV
>   	depends on KVM_AMD && X86_64
>   	depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
>   	select ARCH_HAS_CC_PLATFORM
> -	select KVM_VM_MEMORY_ATTRIBUTES
>   	select HAVE_KVM_ARCH_GMEM_PREPARE
>   	select HAVE_KVM_ARCH_GMEM_INVALIDATE
>   	select HAVE_KVM_ARCH_GMEM_POPULATE
> 

