Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A651712C534;
	Tue, 23 Jun 2026 02:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782182943; cv=none; b=C/tjbn0sA1hscNOmFGGD6u7aBv6c9/EzIl7KUUweDRh5mCEevSvFO62211Ot0AMpEjpkZgEME6TdrA+cD3k7T7aq/+Ebyky4ak2tScCl1/aVIjdi8sghu/DZUnOOb2dsN+WzFMv7glwygB4uW80QF8Im6P1Y0pKVRvjpzAyOcSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782182943; c=relaxed/simple;
	bh=ArTZKS9r3TPMaQgQTYCYM5ecuBaoroMU8Bd1y5b6InM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ha76xv2LD2nCPW50TW9Hs9PQcG548r+EtZdkad2L8+wCDWLhsUqEXZMLuAEuI0Q9Hk0a3P+xKEboVUgzoa0bQy7amL/Jg8lw3n72bKK00wqGveO4hKIfGnG+V1l3tfZJlyc6k6nvxPB2MKDfeHZMz06QDZTgTwIX3a0rnyboPRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dXoHy5sa; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dXoHy5sa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782182942; x=1813718942;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ArTZKS9r3TPMaQgQTYCYM5ecuBaoroMU8Bd1y5b6InM=;
  b=dXoHy5sarqEj5a0KUrSbpVBQ8DLF6VNKGNj8jG+rEj21YIl5JrP9UJIO
   MXynErSo3ypODBROL3rs9YfkgqcNbXHioIC+yH0t1Un6EacHo70mNH4UD
   wbktJ4B9/rWDfcedviHlqM8oPSnsvLWXQI3E9TNXe4eJM5FLf+48UBCk+
   kw8xv20DgODcR5jYyd6PXW3D+bU7pQX+bPx3FUcvOXyYm416aELoQqBDt
   D4forreRG//xrSyMKk/n+n0XV63JxJxd72L8Va8v+1VUOCZdpiIjxvq2S
   m2vX2gr79KvC//BWlms+yhCSP7zYMeYn7LPrTfLEtwR+b06lf00d8umHW
   w==;
X-CSE-ConnectionGUID: 6kX36fGsSiGnscGOn2SfFw==
X-CSE-MsgGUID: FLRXOuHZRvOMijy+m3B7cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="108462681"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="108462681"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 19:49:02 -0700
X-CSE-ConnectionGUID: VyLcM+fpRMG4zA1uPD/clw==
X-CSE-MsgGUID: qZ1vfIQ/Rfi813vIpp5Oqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="249521046"
Received: from unknown (HELO [10.238.2.81]) ([10.238.2.81])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 19:48:48 -0700
Message-ID: <47e32f37-ba46-49d0-919b-8c0889afb0ff@linux.intel.com>
Date: Tue, 23 Jun 2026 10:48:46 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/46] KVM: Move KVM_VM_MEMORY_ATTRIBUTES config
 definition to x86
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
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-coco@lists.linux.dev
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-3-9d2959357853@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-3-9d2959357853@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Bury KVM_VM_MEMORY_ATTRIBUTES in x86 to discourage other architectures
> from adding support for per-VM memory attributes, because tracking private
> vs. shared memory on a per-VM basis is now deprecated in favor of tracking
> on a per-guest_memfd basis, and while RWX memory attributes are on the
> horizon, they too are expected to be x86-only.
> 
> This will also allow modifying KVM_VM_MEMORY_ATTRIBUTES to be
> user-selectable (in x86) without creating weirdness in KVM's Kconfigs.
> Now that guest_memfd supports in-place conversions, it's entirely possible
> to run x86 CoCo VMs without support for KVM_VM_MEMORY_ATTRIBUTES.
> 
> Leave the code itself in common KVM so that it's trivial to undo this
> change if new per-VM attributes do come along.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  arch/x86/kvm/Kconfig | 3 +++
>  virt/kvm/Kconfig     | 3 ---
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 26f6afd51bbdc..24f96396cfa1c 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -80,6 +80,9 @@ config KVM_WERROR
>  
>  	  If in doubt, say "N".
>  
> +config KVM_VM_MEMORY_ATTRIBUTES
> +	bool
> +
>  config KVM_SW_PROTECTED_VM
>  	bool "Enable support for KVM software-protected VMs"
>  	depends on EXPERT
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 5119cb37145fc..297e4399fbd49 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -100,9 +100,6 @@ config KVM_ELIDE_TLB_FLUSH_IF_YOUNG
>  config KVM_MMU_LOCKLESS_AGING
>         bool
>  
> -config KVM_VM_MEMORY_ATTRIBUTES
> -       bool
> -
>  config KVM_GUEST_MEMFD
>         select XARRAY_MULTI
>         bool
> 

