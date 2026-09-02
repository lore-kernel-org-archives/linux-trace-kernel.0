Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF130387345;
	Wed,  2 Sep 2026 05:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328585; cv=none; b=hLWsUWpdavNM9QOC3pL56ZGPc4ZDQbCwAtEWYmaiD0t//jf0+RWh4N9GZtPNxZpU1xOvIQfnoJVcwPnP93l6G27e0ARTbdne9E63Nta25LmZejFXyo1N/8Zzv4ir8mNfvf1sDUSnTdK1du8zzZTpaImWgBiMu1m+KsgCg3xfxms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328585; c=relaxed/simple;
	bh=NAYW1On/VkYGYqw0erKARmYKHyJS6na03C92eWmMvkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HotApl99QN0jcXGjNEbjolSNP9SsFR4J7SgXU6wzYvvUO3pRAmnjQlZe8+Gs251xlsVPppSKJ6K2HhJLEAyze0GLm3ng8GpOtTECwDunRGPrU7VDkK4K1qdVIrHjl/E2E7ka/By2XtmWhgEuuWiIrj4QdGhANHf1LeTQW37ZvjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEZKfKVm; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEZKfKVm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788328583; x=1819864583;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NAYW1On/VkYGYqw0erKARmYKHyJS6na03C92eWmMvkY=;
  b=CEZKfKVmp5UAjoESIKX4lp2dvMw/w4WVaOE5ILkhjWaGqj7V4d/i0S0n
   s0fSmd6I33QyKu11S/utqE2gPUyVZFT9c/RxgJi032Of5gWFMb/lIU4kL
   EVNbqzGLSo+t8dvzKssmHED+J0yToZwIQDz2cQlJwcpMK8XJ297FbT7Mt
   V1VHCJKC4PVPfPaOa9PTRdeJYsnom81B8r1YP8wvjg4oI+DgnqsWwFDSM
   a6S6LndTHkjFIwt9fokepKLXFeMmVNvIfBnujQvYNdsUTZd/19TbL4F+p
   +7J+TgVFX5IUMqCLWY3AdoM5EejlIJIvFdBr2ZMHvWVKO+AZ5WNhpVEwg
   g==;
X-CSE-ConnectionGUID: kwbMKqWIQsafOwzdmAuWJA==
X-CSE-MsgGUID: O3w3eGOJQrGTevZZFcKZag==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="91286618"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="91286618"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 22:56:21 -0700
X-CSE-ConnectionGUID: TKdU4rLOTfitm42CraiH0Q==
X-CSE-MsgGUID: F4dTuqYWTCK6sK9qyDwvcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="294139596"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 22:56:08 -0700
Message-ID: <33431813-fc94-48fb-9042-5cfc68af05b8@linux.intel.com>
Date: Wed, 2 Sep 2026 13:56:06 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 23/45] KVM: Let userspace disable per-VM mem
 attributes, enable per-gmem attributes
To: Sean Christopherson <seanjc@google.com>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev,
 brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org,
 jmattson@google.com, jthoughton@google.com, michael.roth@amd.com,
 oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com,
 rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com,
 steven.price@arm.com, willy@infradead.org, wyihan@google.com,
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
 Peter Xu <peterx@redhat.com>, tarunsahu@google.com,
 Randy Dunlap <rdunlap@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-coco@lists.linux.dev, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com>
 <20260830-gmem-inplace-conversion-v12-23-85e5fd25252a@google.com>
 <CA+EHjTzALzghuG5J-LFuG5pXJ4WgEfrMHgwkMHnq1U-D6yS7Pg@mail.gmail.com>
 <apcY5b2o5k04XffH@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <apcY5b2o5k04XffH@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/2026 2:26 AM, Sean Christopherson wrote:
> On Tue, Sep 01, 2026, Fuad Tabba wrote:
>> Hi Sean, Ackerley,
>>
>> On Mon, 31 Aug 2026 at 01:25, Ackerley Tng via B4 Relay
>> <devnull+ackerleytng.google.com@kernel.org> wrote:
>> ...
>>> +       kvm.gmem_in_place_conversion=
>>> +                       [KVM] Controls whether KVM enables in-place conversion
>>> +                       support for guest_memfd and tracks the private/shared
>>> +                       state of memory per guest_memfd instead of per VM.
>>> +
>>> +                       If enabled, KVM enables the KVM_SET_MEMORY_ATTRIBUTES2
>>> +                       ioctl on guest_memfd file descriptors and disables the
>>> +                       legacy VM-scoped KVM_SET_MEMORY_ATTRIBUTES ioctl for
>>> +                       private memory state tracking. Only the
>>> +                       KVM_MEMORY_ATTRIBUTE_PRIVATE attribute moves to
>>> +                       per-guest_memfd tracking; other attributes remain
>>> +                       per-VM.
>>> +
>>> +                       This parameter toggles KVM's in-place conversion
>>> +                       capability support. Whether a VMM uses separate backends
>>> +                       or out-of-place memory management is determined by
>>> +                       userspace VMM design.
>>> +
>>> +                       Note, this parameter is only available when
>>> +                       CONFIG_KVM_VM_MEMORY_ATTRIBUTES=y. When
>>> +                       CONFIG_KVM_VM_MEMORY_ATTRIBUTES is not set, in-place
>>> +                       conversion is unconditionally enabled.
>>> +
>>> +                       Default is Y (on).
>>
>> The parameter is only settable when CONFIG_KVM_VM_MEMORY_ATTRIBUTES=y, and
>> in that config gmem_in_place_conversion initialises to
>> !IS_ENABLED(CONFIG_KVM_VM_MEMORY_ATTRIBUTES), i.e. N, not Y. Is the doc line
>> wrong, or is N-by-default not what was intended here?
> 
> The doc is wrong.  The intent is to maintain backwards compatibility with existing
> deployments if KVM_VM_MEMORY_ATTRIBUTES=y.
> 

Will it result in the situation that kernel builds with CONFIG_KVM_VM_MEMORY_ATTRIBUTES
enabled by default for backwards compatibility, which requires users to explicitly enable 
gmem_in_place_conversion by the kernel option? Then it effectively disables
gmem_in_place_conversion by default.

But I guess it's OK for CSPs since they know what they want.


>>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>>> index 05c518c9b8078..929fd3e1a01e6 100644
>>> --- a/virt/kvm/kvm_main.c
>>> +++ b/virt/kvm/kvm_main.c
>>> @@ -103,7 +103,10 @@ static bool __ro_after_init allow_unsafe_mappings;
>>>  module_param(allow_unsafe_mappings, bool, 0444);
>>>
>>>  #ifdef kvm_arch_has_private_mem
>>> -bool __ro_after_init gmem_in_place_conversion = false;
>>> +bool __ro_after_init gmem_in_place_conversion = !IS_ENABLED(CONFIG_KVM_VM_MEMORY_ATTRIBUTES);
>>> +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>>> +module_param(gmem_in_place_conversion, bool, 0444);
>>> +#endif
>>>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(gmem_in_place_conversion);
>>>  #endif
> 

