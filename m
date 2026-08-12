Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC97E3B14C2;
	Wed, 12 Aug 2026 08:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523036; cv=none; b=sNuzP5zVIlnIu3lP6IWyR+/dH4PwcwTCz58SM1Bmm+gG0F1HbzQ9JP6CwAgJ3ihdF00QrNTv2N//ga1a5SqovSM7rcrl5wLDhhvMQ8w/y9Rf1+FQlGy1lc8cFBQ/D0yeH0/wDQMgzq1SY/MyHLPbiDdzZ80WrNsH+oJVWw6d1F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523036; c=relaxed/simple;
	bh=W+jcq+2Wzamwh76nz0OcGlGI0ou5c5gwJ2B1PP/p9zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TirvHX9G45P1K+ny1Xl+XasBe/95vN9znAsCuxImeHOO8rSqSQB658p2L/70850kIFt5Bhou6tfCW/wdD7f+PjyJ8ePB+Mbd7Azv9zTZJO4UsnrKzQLtEU5VGSl8SrjpEGrSTP/4UcUGmTzujoksBupcY34QvA0ANaTBYIooGpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwAyO77L; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwAyO77L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786523034; x=1818059034;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W+jcq+2Wzamwh76nz0OcGlGI0ou5c5gwJ2B1PP/p9zc=;
  b=iwAyO77Lo6lBb6+g4b2tI7LUg2VT6cotOs2bWrp4VmWDIAASSOMBrT5U
   qIIRuv+/SQNvzUU4ihHx+QN4SjUC/jm9ZCNtdtCB2tA5/yFTdJVeiGZyh
   xC48v+DpXl2gAZ3fEM0goc2rFtVeSyyY9rV0zci2ydjsglRLjtdaTnSNj
   HLK7z3qVSICsRWxGL25m5oZN0eZ2LWj2ifw3CIeV2IfwiXX6zwPYIVcqS
   ussQYa9GvThMdSsKLsPJNvthSMhyDMan40zsS1b4ijc6EEerosC0hNyoQ
   42bMXuxtOzhcmIH6ZWnKlE4KRMoM/s66C9oL+c9QD7TX8P95O4do4R5Zq
   w==;
X-CSE-ConnectionGUID: ZueSlsXgTXap1rgwctY1NA==
X-CSE-MsgGUID: nNxRgY5aSEeJgWHFQEABVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97414832"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="97414832"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 01:23:53 -0700
X-CSE-ConnectionGUID: BVDpwXjLQ5mrX6YTBE6jjA==
X-CSE-MsgGUID: wd0espIgTjCF/EZNhS5SlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="257380624"
Received: from unknown (HELO [10.238.208.98]) ([10.238.208.98])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 01:23:34 -0700
Message-ID: <2f68b143-f3e1-48b7-8666-52072249e0be@intel.com>
Date: Wed, 12 Aug 2026 16:23:31 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/41] KVM: Enumerate support for PRIVATE memory iff
 kvm_arch_has_private_mem is defined
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
 <20260807-gmem-inplace-conversion-v10-4-2fc18ee6d3ba@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260807-gmem-inplace-conversion-v10-4-2fc18ee6d3ba@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/2026 5:52 AM, Ackerley Tng via B4 Relay wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Explicitly guard reporting support for KVM_MEMORY_ATTRIBUTE_PRIVATE based
> on kvm_arch_has_private_mem being #defined in anticipation of tracking
> PRIVATE vs. SHARED state per-guest_memfd, not per-VM (to allow in-place
> conversion).
> 
> guest_memfd support for memory attributes is expected to be unconditional
> to avoid yet more macros (all architectures that support guest_memfd are
> expected to use per-gmem attributes at some point), at which point
> enumerating support KVM_MEMORY_ATTRIBUTE_PRIVATE based solely on memory
> attributes being supported by KVM at-large would result in a system-scope
> check (NULL @kvm) over-reporting support on arm64.
> 
> Give architectures full control over overriding the default definition of
> kvm_arch_has_private_mem() by removing the coupling with
> CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
> 
> In a later patch, kvm_arch_has_private_mem() will be defined based on
> whether architectural features are compiled in, and made orthogonal to
> CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Tested-by: Shivank Garg <shivankg@amd.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   include/linux/kvm_host.h | 2 +-
>   virt/kvm/kvm_main.c      | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 3e86cdd00e59b..e3666d0b40b74 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -722,7 +722,7 @@ static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
>   }
>   #endif
>   
> -#ifndef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> +#ifndef kvm_arch_has_private_mem
>   static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
>   {
>   	return false;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index e3a77d1e6d8ae..560ff05e95959 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2422,8 +2422,10 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
>   #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>   static u64 kvm_supported_mem_attributes(struct kvm *kvm)
>   {
> +#ifdef kvm_arch_has_private_mem
>   	if (!kvm || kvm_arch_has_private_mem(kvm))
>   		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
> +#endif
>   
>   	return 0;
>   }
> 

