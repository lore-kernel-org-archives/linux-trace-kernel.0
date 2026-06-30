Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA5E22424C;
	Tue, 30 Jun 2026 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782836661; cv=none; b=O7EJU2HW9/eO7q7j0t46W24odreTSlmJA+kFz5QWbv916Wh6IWwt37u5ynEa8+kTijniB+c/7cHqitd8lSFRApouludtFHoxSkngLFcvFQI4CeHGDytFtmacWWN8Mj7RIYpobWCX3UcqdOzr1E4BwdVaVxIcUhU+aODiN/9+rBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782836661; c=relaxed/simple;
	bh=jA+Z5cSC4JkMlTEcMPICRNGh0TWd7xD+/PkK+LHbEkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzautW5UrxyUhbTsegYN+nLNpOwnGvpXai3QbsGdX2cufcHOCf0VBGbEXSkpz3AbsNVCK7qE1UwmPwEmtAUJ4FHw5YYFlQ6JbogqNdj3cSPJvlnZtK4cLRsdEH8PXCrdiTE/PaENEr2ri13K+zQhrQtw+a3d21vEgQbGvBgW2xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTTXsdkT; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTTXsdkT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782836660; x=1814372660;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jA+Z5cSC4JkMlTEcMPICRNGh0TWd7xD+/PkK+LHbEkI=;
  b=aTTXsdkTovPhZjBYaKleTJ4/+2a3bF0b90/KIpB+bqrY+WgZ12PAAOcR
   RHmc1xR8Z8hda6yE7PZi6SELpadpfJ2mdtLQICaboVXISLVglfOuWqpR1
   wn+wGmBkrV5EjUfvhDsv17/Ldac2rpruQO2wBa0wQ1Bf5GJB3TIuH6JN2
   iP0Z1wo1FpgR1kvIigWLnpgs1NIxzrXHmWeEVuwcwRnozY7XAIXpGqxom
   zzHPdJur4p50EY2+HjtfWmp2lHmMss4vaN5eYzlSEK4jYz3hFYntrAORm
   2ZW3pmdtJznuGXg59jrtxwNIaYV5SBKiTsEe6T+d47J9O/nyq/zQRr2FE
   g==;
X-CSE-ConnectionGUID: Me/vS7ygRiWMvHi99tfDlA==
X-CSE-MsgGUID: 2GlluxpcRJ6R0n+/r8Or3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="100983374"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="100983374"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 09:24:19 -0700
X-CSE-ConnectionGUID: P5X392gpQj6ht692ZNvZ0w==
X-CSE-MsgGUID: Y/RTZ8sDRUCfvUTyYMkP/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="251255791"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.232.239]) ([10.124.232.239])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 09:24:05 -0700
Message-ID: <6df5cb10-645c-42de-b0f8-3fdf61067653@intel.com>
Date: Wed, 1 Jul 2026 00:24:02 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/46] KVM: Decouple kvm_has_arch_private_mem from
 CONFIG_KVM_VM_MEMORY_ATTRIBUTES
To: Sean Christopherson <seanjc@google.com>
Cc: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev,
 binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com,
 david@kernel.org, jmattson@google.com, jthoughton@google.com,
 michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com,
 qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com,
 shivankg@amd.com, steven.price@arm.com, tabba@google.com,
 willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com,
 forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com,
 aneesh.kumar@kernel.org, liam@infradead.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
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
 <6b1f0c77-f059-4f8d-8f46-443b944c59a0@intel.com>
 <akO_Y0-ERgBoCqoQ@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <akO_Y0-ERgBoCqoQ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/30/2026 9:06 PM, Sean Christopherson wrote:
> On Tue, Jun 30, 2026, Xiaoyao Li wrote:
>> On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
>>>    arch/x86/include/asm/kvm_host.h | 4 +++-
>>>    include/linux/kvm_host.h        | 2 +-
>>>    2 files changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>>> index 8e8eb8a5e8a6b..1bde67cf6eb0e 100644
>>> --- a/arch/x86/include/asm/kvm_host.h
>>> +++ b/arch/x86/include/asm/kvm_host.h
>>> @@ -2394,7 +2394,9 @@ void kvm_configure_mmu(bool enable_tdp, int tdp_forced_root_level,
>>>    		       int tdp_max_root_level, int tdp_huge_page_level);
>>> -#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>>> +#if defined(CONFIG_KVM_SW_PROTECTED_VM) ||	\
>>> +	defined(CONFIG_KVM_INTEL_TDX) ||	\
>>> +	defined(CONFIG_KVM_AMD_SEV)
>>
>> Maybe we can just remove the #ifdef and make it always avaiable?
> 
> No, because common KVM keys off the macro to determine whether or not PRIVATE is
> a supported attribute:
> 
>    #ifdef kvm_arch_has_private_mem
>    static u64 kvm_supports_private_mem(struct kvm *kvm)
>    {
> 	return !kvm || kvm_arch_has_private_mem(kvm);
>    }
>    #else
>    #define kvm_supports_private_mem(kvm) false
>    #endif
> 
> And also whether or not to provide the in-place conversion param (without PRIVATE,
> conversions aren't supported in general):
> 
>    #ifdef kvm_arch_has_private_mem
>    bool __ro_after_init gmem_in_place_conversion = !IS_ENABLED(CONFIG_KVM_VM_MEMORY_ATTRIBUTES);
>    module_param(gmem_in_place_conversion, bool, 0444);
>    EXPORT_SYMBOL_FOR_KVM_INTERNAL(gmem_in_place_conversion);
>    #endif
> 
> I agree the #ifdeffery is ugly, but kvm_supports_private_mem() in particular
> needs to evaluate to false if PRIVATE memory isn't supported.

I agree with the above after seeing the later patches. But just to the 
state where this patch applies on top, the #ifdef is not necessary.

Maybe add some log to explain it will be helpful.
