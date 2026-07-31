Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDDD39C006;
	Fri, 31 Jul 2026 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486412; cv=none; b=lsUBRYXsrhjeD158wU54IDuvBXUzx1ax82Hm5jPEY/gWouwvFN4t78phUj8rO99oaB+fJiFid/WGFUb78rbTolNXgvbndYEZivTnj42h2RMLwBAPJe371ZO/UaPl+hytNH4BYFFUQ7aR08Yx6WphazCkDupkuaOrtlmzj6qvpgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486412; c=relaxed/simple;
	bh=5dNmxu5/DKV/iLc1cxX1Ef3+PAoXGe1Aq8VEZB3JYrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCBTsoNegyP4RIUwdovUOwXnRBfFCi8qCRlg9raWrGdkPMSmqjCFMIlc4sxyQnH/MkWb4A/rsoxJsyZbp0H6fgeMoLTs3NUy7/dT2kE6M5BdzL77QTrFqsUsJD1o6ERvintNdKfeKWALLy9gNzsb+2MJF3f2j9S5vQ05qT5m1LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gdg2fqhM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gdg2fqhM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785486410; x=1817022410;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5dNmxu5/DKV/iLc1cxX1Ef3+PAoXGe1Aq8VEZB3JYrg=;
  b=Gdg2fqhMtLlqtXxM4xLVfTOddYFQDcvosHiDDMT+snUBaMVJZakq+b8B
   52LNo5Kqq6uifBNjDrncn6PLuw0hoApytt2qyE8G8QII0KQaLfwK5jMIY
   jnT+/T15UKMKMYrYT507FrMAw4PHjkxPT8y9QgobtOzKXxwwyFdScokv3
   JUF72F+rY6Wusmx7FzBSHydPK+5J3glfHIc3bAquIindtbjR8k+FTc+bp
   L2IlYn+Kw7vCX4YFnoxHH8C5S9jlrQmnVvHwT7JP2UkhVTFOtYhS6EJ8K
   zqXQMLwjUIMriC65363djFj34MfIUuWd5g2kCd7q+S2b5DbVVoCxCgD5h
   w==;
X-CSE-ConnectionGUID: DrJGb3BqSfuiA+wHrDz02w==
X-CSE-MsgGUID: orpSC3qvQKG9TIDv0WO5Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="86126073"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="86126073"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 01:26:48 -0700
X-CSE-ConnectionGUID: KbSyPLdZQD6xu1UMvfTcHw==
X-CSE-MsgGUID: g90yMGrGQQeZJeLvX6Oqmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="265591573"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.248]) ([10.124.240.248])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 01:26:34 -0700
Message-ID: <d3fef015-0546-4993-b354-a8464d79e48c@intel.com>
Date: Fri, 31 Jul 2026 16:26:30 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 18/41] KVM: TDX: Make source page optional for
 KVM_TDX_INIT_MEM_REGION
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
 <20260728-gmem-inplace-conversion-v9-18-35f9aec2aed2@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260728-gmem-inplace-conversion-v9-18-35f9aec2aed2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/2026 8:35 AM, Ackerley Tng via B4 Relay wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> Update tdx_gmem_post_populate() to handle cases where userspace requests
> "no source page". To handle "no source page", populate (perform
> TDH.MEM.PAGE.ADD) using memory in-place at the target PFN.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Tested-by: Shivank Garg <shivankg@amd.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>   Documentation/virt/kvm/x86/intel-tdx.rst | 4 ++++
>   arch/x86/kvm/vmx/tdx.c                   | 8 +++++---
>   2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/x86/intel-tdx.rst b/Documentation/virt/kvm/x86/intel-tdx.rst
> index 6a222e9d09541..d8d9409120e61 100644
> --- a/Documentation/virt/kvm/x86/intel-tdx.rst
> +++ b/Documentation/virt/kvm/x86/intel-tdx.rst
> @@ -158,6 +158,10 @@ KVM_TDX_INIT_MEM_REGION
>   Initialize @nr_pages TDX guest private memory starting from @gpa with userspace
>   provided data from @source_addr. @source_addr must be PAGE_SIZE-aligned.
>   
> +If guest_memfd in-place conversion is enabled, pass 0 for @source_addr
> +to represent "no source page". A source page is required if in-place
> +conversion is not enabled or not supported.
> +
>   Note, before calling this sub command, memory attribute of the range
>   [gpa, gpa + nr_pages] needs to be private.  Userspace can use
>   KVM_SET_MEMORY_ATTRIBUTES to set the attribute.
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index d1af0a752e97e..e890da5f18aed 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -3192,7 +3192,7 @@ static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>   	if (KVM_BUG_ON(kvm_tdx->page_add_src, kvm))
>   		return -EIO;
>   
> -	kvm_tdx->page_add_src = src_page;
> +	kvm_tdx->page_add_src = src_page ?: pfn_to_page(pfn);
>   	ret = kvm_tdp_mmu_map_private_pfn(arg->vcpu, gfn, pfn);
>   	kvm_tdx->page_add_src = NULL;
>   
> @@ -3238,7 +3238,8 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *c
>   	if (copy_from_user(&region, u64_to_user_ptr(cmd->data), sizeof(region)))
>   		return -EFAULT;
>   
> -	if (!PAGE_ALIGNED(region.source_addr) || !region.source_addr ||
> +	if (!PAGE_ALIGNED(region.source_addr) ||
> +	    (!gmem_in_place_conversion && !region.source_addr) ||

Sorry, I still want to discuss why we only allow in-place PAGE.ADD for 
gmem_in_place_conversion only. Though Yan raised this opinion[1] in 
previous v8, I'm not quite following her argument. So let me try again.

I think in-place PAGE.ADD of TDX doesn't need to depend on 
gmem_in_place_conversion. There are two use cases actually.

1). Userspace sets the gmem page as private, and invokes the in-place 
PAGE.ADD by passing a 0 source_addr. Due to patch 16, the target PFN 
will be ADD'ed to TD as a all-0 page.

2). Userspace sets the gmem page as shared, and writes the desired 
content to it. Then converts the page to private, and invokes the 
in-place PAGE.ADD by passing a 0 source_addr. The target PFN will be 
ADD'ed to TD with desired content.

For gmem_in_place_conversion == false, only case 1) is possible.
For gmem_in_place_conversion == true, both case 1) and 2) are possible.

Basically, this patch is changing the behavior of 
KVM_TDX_INIT_MEM_REGION. Before, it returns -EINVAL when 
region.source_addr == 0. Now it wants to allow the "region.source_addr 
== 0" case. If we can allow it unconditionally, why bother adding the 
restriction to allow it only when gmem_in_place_conversion == true?


[1] https://lore.kernel.org/all/akI9m02jgKAdi4gX@yzhao56-desk.sh.intel.com/

>   	    !PAGE_ALIGNED(region.gpa) || !region.nr_pages ||
>   	    region.gpa + (region.nr_pages << PAGE_SHIFT) <= region.gpa ||
>   	    !vt_is_tdx_private_gpa(kvm, region.gpa) ||
> @@ -3269,7 +3270,8 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *c
>   			break;
>   		}
>   
> -		region.source_addr += PAGE_SIZE;
> +		if (region.source_addr)
> +			region.source_addr += PAGE_SIZE;
>   		region.gpa += PAGE_SIZE;
>   		region.nr_pages--;
>   
> 

