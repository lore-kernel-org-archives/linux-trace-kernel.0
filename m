Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021A336B076;
	Tue, 23 Jun 2026 02:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782183122; cv=none; b=m49EoHILnL38HrXdDxgZp8jLmKX10LYpyThrmmjyJkD6XB90scbJvJdhkPjbeMJ0UnQHDT6TTjfhCEwyrTi57NXlfY15eTIkVFOjuW2600w6rN0SAM0NFQzeVl760z1b1JQtoV7+oUyZRRMiimnRS69IF2OTmwkbddcd/FBpG3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782183122; c=relaxed/simple;
	bh=fjVDDQxNLoarUNyLHXojlIytkjIfDGYDPBQea8XedRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RkzLznCy/ZmFOJanuxoflGDAECZ80X49J0ROzA2ZgMOGuwT53PIZNakua6eszTTTNOcxZv5NBs249unRKOBF38JCq61AjYVkrD1oM8bynePue31s4EzK4Hk5qyeVciqOCOmkGuSIEIaV3TP7xUDQQu8OJ105sobIINTk9YE8Mvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHQ7fW2z; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHQ7fW2z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782183121; x=1813719121;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fjVDDQxNLoarUNyLHXojlIytkjIfDGYDPBQea8XedRo=;
  b=gHQ7fW2zmjieCgAX6DEQzG0VlLoSm8ph9ymp56ju59azb2TR04jhxQ4O
   cVIF0qrtkpmorm894yv9N/ZQQIMizWfbojTG5ENrORLLzjh40kdNyasz3
   uQi9+E1QhbzCfpDZuzMQ9pJm2ii8SfmE60MlSMavCd2s8xp/36YnX8JUC
   Z/SfXhe4cTEpSahToYLfCRj0WTkuK4IkXwrqeNV92nxjbVjyW6T7OmEQ/
   i1Y7sIvPxxsDkaK4S8PWnoz4BBgRPZrOVcRwyDRMW7k38Nm489nBTsFSh
   DotZ2WoRw+WzHIdVglVVa6vaxLAO8pcOnDWFGuhlkcPWEnlycyP1Zupxh
   Q==;
X-CSE-ConnectionGUID: GYqSyXu3SB2IDsBUEIMfRw==
X-CSE-MsgGUID: r3touAfoRYOjht3jh/qiAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="83010782"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="83010782"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 19:52:01 -0700
X-CSE-ConnectionGUID: DX/WscZvQoiIRwAKC5Kyvg==
X-CSE-MsgGUID: axAQd5q8QI2J7SjgRPnb8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="254374133"
Received: from unknown (HELO [10.238.2.81]) ([10.238.2.81])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 19:51:47 -0700
Message-ID: <a21bfc05-787e-4cd8-89af-8579357e6a12@linux.intel.com>
Date: Tue, 23 Jun 2026 10:51:44 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/46] KVM: Decouple kvm_has_arch_private_mem from
 CONFIG_KVM_VM_MEMORY_ATTRIBUTES
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
 <20260618-gmem-inplace-conversion-v8-4-9d2959357853@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-4-9d2959357853@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> When memory attributes become trackable in guest_memfd, the concept of
> having private memory is no longer dependent on
> CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
> 
> With this, on x86, kvm_arch_has_private_mem() is defined if some CoCo
> platform support (or the testing CONFIG_KVM_SW_PROTECTED_VM) is compiled
> in.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

One nit below.

> ---
>  arch/x86/include/asm/kvm_host.h | 4 +++-
>  include/linux/kvm_host.h        | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 8e8eb8a5e8a6b..1bde67cf6eb0e 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -2394,7 +2394,9 @@ void kvm_configure_mmu(bool enable_tdp, int tdp_forced_root_level,
>  		       int tdp_max_root_level, int tdp_huge_page_level);
>  
>  
> -#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> +#if defined(CONFIG_KVM_SW_PROTECTED_VM) ||	\
> +	defined(CONFIG_KVM_INTEL_TDX) ||	\
> +	defined(CONFIG_KVM_AMD_SEV)

Nit:
Vertically align the defined(XXX) statements for better readability?


>  #define kvm_arch_has_private_mem(kvm) ((kvm)->arch.has_private_mem)
>  #endif
>  
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 201d0f2143976..d370e834d619e 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -722,7 +722,7 @@ static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
>  }
>  #endif
>  
> -#ifndef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> +#ifndef kvm_arch_has_private_mem
>  static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
>  {
>  	return false;
> 

