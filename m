Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD3D355819;
	Fri, 14 Aug 2026 05:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786687095; cv=none; b=pssd0pjfm4ULOXFyuSv5T43h+BaMS129UoAjvxuS2Ek43Bo3IqJg2njrSpfbZDo4z2KhJxsx6byD6GHqfIoX40LZpDNndFiwQFg4IOi5QK/SClzze3ptIsxHteNK6kt5zJW+WS68XRS8OkOFxQjQpIRGXO0A8QDjSoyx/HoREnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786687095; c=relaxed/simple;
	bh=QC5S96Wlg2aYg9zmHkHBo/+oJKFdCtwv78fz5ZqTCcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kc/M5KtXHgjRGmN5++aEtEjBsHeY6B1OXZDgl52n5T+gQRMs0tr8ZGG+CU6ba7C4Y4uEk7JzJW1+VuF91HZ1jHkSfDupdEPilXtB6aVfZ4EG/SkQUElsy5U05dTL8zR09hD6SdLjIfSN0IX6YI2vNAwp0n2pOn8rRUZD0VTzU70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Enqwr2mb; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Enqwr2mb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786687093; x=1818223093;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QC5S96Wlg2aYg9zmHkHBo/+oJKFdCtwv78fz5ZqTCcY=;
  b=Enqwr2mb+vwBnJVgQ1LZlMqBXuJrqRMDp4UjsMCmfGT1q6Nn9U/+QzdN
   EMrn2ABiS7Ky2W3aXUnOghAL4W3Abykx98zTBzsU0dcts2W5of6F5LOG9
   wylASDkjULYU/YTLTRk4XqZzMtVuIpBvyGshQ4ILYpuQ7t8Bhs1+VCuIC
   4rBVxST3Xjc+F2x2DplMpMBabVuU+QA33EEjgeWIoJpv56ccfdtVi7OYF
   DRonHhLoV0eEWsINh2Hur6ZO9oGyh5XsYSgtXfpj5OnKYJCCQS3v19IbM
   FY6BdD2G68TVKl4h74AUiO0IGe0fizKodGwb4i9ipLscdXNF1Q5Ax+H3w
   Q==;
X-CSE-ConnectionGUID: 3kFp1zt0RNWpkeU/gpF5Zg==
X-CSE-MsgGUID: pWqUt+P3R9KUsHZjupKW3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="110053713"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="110053713"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 22:58:11 -0700
X-CSE-ConnectionGUID: cUW8aUaXR5u17W+d+k7SFQ==
X-CSE-MsgGUID: D9N+GuVcQ1SFu1yh9D48qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="257921021"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 22:57:57 -0700
Message-ID: <36baf0ec-0b7c-4ffd-9a1e-dfe9617e057d@linux.intel.com>
Date: Fri, 14 Aug 2026 13:57:55 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 18/41] KVM: TDX: Make source page optional for
 KVM_TDX_INIT_MEM_REGION
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
 linux-mm@kvack.org, linux-coco@lists.linux.dev
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-18-2fc18ee6d3ba@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260807-gmem-inplace-conversion-v10-18-2fc18ee6d3ba@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/2026 5:52 AM, Ackerley Tng via B4 Relay wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> Update tdx_gmem_post_populate() to handle cases where userspace requests
> "no source page". To handle "no source page", populate (perform
> TDH.MEM.PAGE.ADD) using memory in-place at the target PFN.
> 
> Allow "no source page" only when gmem_in_place_conversion is enabled,
> because retroactively adding support for out-of-place conversion would mean
> requiring a userspace update for a feature that's being deprecated.
> 
> Also, KVM supporting "no source page" without in-place conversion would
> effectively be an obscure zero-page optimization that relies on the page
> being zeroed when it is allocated by guest_memfd.
> 
> Rejecting "no source page" without in-place conversion scenario is valuable
> for KVM developers since it helps newcomers understand what exactly is and
> isn't possible.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Nit:
Is Sean's SoB intentional here?

> Tested-by: Shivank Garg <shivankg@amd.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by:Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  Documentation/virt/kvm/x86/intel-tdx.rst | 4 ++++
>  arch/x86/kvm/vmx/tdx.c                   | 8 +++++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/x86/intel-tdx.rst b/Documentation/virt/kvm/x86/intel-tdx.rst
> index 6a222e9d09541..d8d9409120e61 100644
> --- a/Documentation/virt/kvm/x86/intel-tdx.rst
> +++ b/Documentation/virt/kvm/x86/intel-tdx.rst
> @@ -158,6 +158,10 @@ KVM_TDX_INIT_MEM_REGION
>  Initialize @nr_pages TDX guest private memory starting from @gpa with userspace
>  provided data from @source_addr. @source_addr must be PAGE_SIZE-aligned.
>  
> +If guest_memfd in-place conversion is enabled, pass 0 for @source_addr
> +to represent "no source page". A source page is required if in-place
> +conversion is not enabled or not supported.
> +
>  Note, before calling this sub command, memory attribute of the range
>  [gpa, gpa + nr_pages] needs to be private.  Userspace can use
>  KVM_SET_MEMORY_ATTRIBUTES to set the attribute.
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index b272c20586a74..7654a9f5fa128 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -3189,7 +3189,7 @@ static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>  	if (KVM_BUG_ON(kvm_tdx->page_add_src, kvm))
>  		return -EIO;
>  
> -	kvm_tdx->page_add_src = src_page;
> +	kvm_tdx->page_add_src = src_page ?: pfn_to_page(pfn);
>  	ret = kvm_tdp_mmu_map_private_pfn(arg->vcpu, gfn, pfn);
>  	kvm_tdx->page_add_src = NULL;
>  
> @@ -3235,7 +3235,8 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *c
>  	if (copy_from_user(&region, u64_to_user_ptr(cmd->data), sizeof(region)))
>  		return -EFAULT;
>  
> -	if (!PAGE_ALIGNED(region.source_addr) || !region.source_addr ||
> +	if (!PAGE_ALIGNED(region.source_addr) ||
> +	    (!gmem_in_place_conversion && !region.source_addr) ||
>  	    !PAGE_ALIGNED(region.gpa) || !region.nr_pages ||
>  	    region.gpa + (region.nr_pages << PAGE_SHIFT) <= region.gpa ||
>  	    !vt_is_tdx_private_gpa(kvm, region.gpa) ||
> @@ -3266,7 +3267,8 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *c
>  			break;
>  		}
>  
> -		region.source_addr += PAGE_SIZE;
> +		if (region.source_addr)
> +			region.source_addr += PAGE_SIZE;
>  		region.gpa += PAGE_SIZE;
>  		region.nr_pages--;
>  
> 

