Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FBC3AA1BA;
	Thu,  6 Aug 2026 01:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785980479; cv=none; b=alokdmzJUadm99yZ7Bc41/X6NCLbuhLB9rZEXIwqrYGZnSOO7775vbokNGDOXEEzXaAfG3UqEy1W5TYP37m72kjlkY8U7EfcAErOXNCgDPrP36MPpXuy99GZsTFPChBfz/xV/7RzYp32xSzRWGLOZ29jV3gyEqEHPbUPMeELScA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785980479; c=relaxed/simple;
	bh=ZnLZ/DOQZzlu7P9MJedwhIePtxgeG0zn9ITPXcqWNF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvNcU1pE7bDEhd30zL3nQZPfrlME0OoqdkPPcxHsTYBADyOixj0mqsXAaJthdbvF1okBPpUXt7vbn+71fD6Lh5v6w3Wp4DzAeJPybRWVmGQazcrgTZ0A1yHZa2ioP8kNz+jaY93i6M2hAOc9fNzpm7xcFQeL/CSkDquGAcUTqI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NfgkUNh0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NfgkUNh0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785980477; x=1817516477;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZnLZ/DOQZzlu7P9MJedwhIePtxgeG0zn9ITPXcqWNF8=;
  b=NfgkUNh0XFc4GUDxKHhm1wsWGrzsctFB2SfKCeUxqxUqAShx0bEm0A5x
   7qoTwJw47MtdLNc/0s057XdGQhrm0o7QMxlN3zxpOYtkudRfG5WwE7H5h
   eXEpYIRByZgMxeJ5Ixb4V4+9XUzwxrseY8AcH8vDcS/GqheN7QytiiPCg
   BAEqSHHHOmde/yWTQK8kyniGXlsjkinuOCJt6e0VoDxNZUOCkwJ6HIsw8
   HvCVeLXcv/QlKsY8m8784X0x66LKPD3hmwZArWBIVBH6Itx0mJDaDjwsg
   gsb0ZVHIPCoapj17M8VEsLQ+iKw92pFcbp/pbO4QJYSMpATMiDP/xev1B
   Q==;
X-CSE-ConnectionGUID: ODnsCHRRSBuMbjRig+u+og==
X-CSE-MsgGUID: t9bncxeTTV6ZmrTVGsStdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="85691167"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="85691167"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 18:41:16 -0700
X-CSE-ConnectionGUID: 5oIPZ2NyTCqHZV8yl6Tp9w==
X-CSE-MsgGUID: x7bSvlzdSNGXBVIWi4OGbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="260186253"
Received: from fuxiaogu-mobl1.ccr.corp.intel.com (HELO [10.238.208.47]) ([10.238.208.47])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 18:41:01 -0700
Message-ID: <fda26964-721d-4a8c-9225-46ca3a5b2785@intel.com>
Date: Thu, 6 Aug 2026 09:40:58 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/41] KVM: Enumerate support for PRIVATE memory iff
 kvm_arch_has_private_mem is defined
To: Sean Christopherson <seanjc@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>, aik@amd.com,
 andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org,
 chao.p.peng@linux.intel.com, david@kernel.org, jmattson@google.com,
 jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org,
 pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com,
 rientjes@google.com, shivankg@amd.com, steven.price@arm.com,
 tabba@google.com, willy@infradead.org, wyihan@google.com,
 yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org,
 suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org,
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
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Vlastimil Babka <vbabka@kernel.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-coco@lists.linux.dev
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
 <20260728-gmem-inplace-conversion-v9-3-35f9aec2aed2@google.com>
 <7dafaa90-f3d4-4be4-a5cc-472163f18040@intel.com>
 <CAEvNRgG3qXrG2ix2MEcyVo0GXaen-Pte4gFAwEN+9AY=VtGU5w@mail.gmail.com>
 <b9ad1a1d-c167-4adb-980b-90096515a363@intel.com>
 <anPYxp-LMWaLDbMk@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <anPYxp-LMWaLDbMk@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/2026 8:43 AM, Sean Christopherson wrote:
> On Wed, Aug 05, 2026, Xiaoyao Li wrote:
>> On 7/31/2026 4:34 AM, Ackerley Tng wrote:
>>> I think another way to phrase this is that if we don't make this change,
>>> say, on the foo architecture where there's no CoCo and no private mem
>>> support, kvm_supported_mem_attributes() would return true for the !kvm
>>> case, which is over-reporting.
>>
>> Under the condition that the foo architecture enables
>> CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
>>
>>> How about this, replacing the entire changelog paragraph above:
>>>
>>>     Explicitly guard reporting support for KVM_MEMORY_ATTRIBUTE_PRIVATE
>>>     based on kvm_arch_has_private_mem being #defined. This improves
>>>     reporting accuracy by not reporting support for
>>>     KVM_MEMORY_ATTRIBUTE_PRIVATE when kvm_supported_mem_attributes() is
>>>     called with kvm == NULL.
>>
>> It doesn't help for the case where kvm == NULL, but help for the case where
>> CONFIG_KVM_VM_MEMORY_ATTRIBUTES is defined but kvm_arch_has_private_mem not.
>>
>> sorry for being picky. I think we can say
>>
>> This improves the reporting accuracy by avoiding the case where
>> KVM_MEMORY_ATTRIBUTE_PRIVATE is reported when kvm == null even without
>> kvm_arch_has_private_mem being #defined.
> 
> How about this?
> 
> Explicitly guard reporting support for KVM_MEMORY_ATTRIBUTE_PRIVATE based
> on kvm_arch_has_private_mem being #defined in anticipation of tracking
> PRIVATE vs. SHARED state per-guest_memfd, not per-VM (to allow in-place
> conversion).

Sorry, maybe I'm stupid. I still don't understand how to connect it to 
tracking PRIVATE vs. SHARED state per-guest_memfd.

There are two diffs in this patch, and we are talking about the second 
diff, right?

If the kvm_supported_mem_attributes() will be used by gmem, I can buy 
the justification. But it won't. At least, it won't after this series.

> guest_memfd support for memory attributes is expected to be unconditional
> to avoid yet more macros (all architectures that support guest_memfd are
> expected to use per-gmem attributes at some point), at which point
> enumerating support KVM_MEMORY_ATTRIBUTE_PRIVATE based solely on memory
> attributes being supported by KVM at-large would result in a system-scope

s/memory attributes/CONFIG_KVM_VM_MEMORY_ATTRIBUTES/ ?

> check (NULL @kvm) over-reporting support on arm64.

I think arm64 won't define CONFIG_KVM_VM_MEMORY_ATTRIBUTES? So it seems 
to have nothing to do with arm64.

It matters for x86. After patch 20, CONFIG_KVM_VM_MEMORY_ATTRIBUTES is 
user-configurable. At that time, people can disable 
CONFIG_KVM_SW_PROTECTED_VM, CONFIG_KVM_INTEL_TDX and CONFIG_KVM_AMD_SEV, 
but enable CONFIG_KVM_VM_MEMORY_ATTRIBUTES on x86. In this case, 
kvm_supported_mem_attributes() reports KVM_MEMORY_ATTRIBUTE_PRIVATE for 
system-scope query which is totally wrong. I think this is the case we 
want to prevent not something won't happen for arm64?

>>
>>>     Give architectures full control over overriding the default definition
>>>     of kvm_arch_has_private_mem() by removing the coupling with
>>>     CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
>>>
>>>     In a later patch, kvm_arch_has_private_mem() will be defined based on
>>>     whether architectural features are compiled in, and made orthogonal to
>>>     CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
>>

