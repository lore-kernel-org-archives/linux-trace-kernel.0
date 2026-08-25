Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AA730C16A;
	Tue, 25 Aug 2026 03:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787629595; cv=none; b=dujZh+2uy96eXtp38cxw3klZr13NJRjSirFch1iS0sIulejCVJikoblOTnkA5CMWTwRZNfba+0ANmmDSm3N/cCfJSeAILEgovDnxynwMWzkzw1A8e1eRju7uHcm2kQ6wrlD42/Trq6S2OF4GNQ/fcUiUmcMA7AZ2PlHNex8nVNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787629595; c=relaxed/simple;
	bh=pAuHVptymQ0SSWCENqu+L5Le6YmITzmlBl28M1cNQjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPO4GlKhIeO2A8H44BWWzRDnWLUUruKRuyJ1ZNeXO88UW6aK2FzkYDwokvCQ821xKkaxZYNjC+URRyDs7odbzsHis0g/zR4F47g1UeMj/RjvGWPBmg/0rTSBljZQjSueJbcNsYZ9h+KDorFXca9MygLAlu6YXqfIAFkshriJ3+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XFEfKjIr; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XFEfKjIr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787629594; x=1819165594;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pAuHVptymQ0SSWCENqu+L5Le6YmITzmlBl28M1cNQjE=;
  b=XFEfKjIre49tr6S4PIntQszVk/gWLvWGfVLdON39H2HMxG4xxcKiHpCF
   hzuhtJpHWfy7UvTMFfCFGAhQAZS0mo+qbb0zWWHOo4/3TAP5XKt4mpS0k
   rXjjhPyXLO+Uz4qlxoOVtGfyg4iwMf9D5FAbL27/4LEi953/6A7azXnXH
   PEvujOSVCnRC+lSKF15Bi0QzPYolTQheI+aVEwA0CtEakj1v7RsBG6AlL
   bZEIrasLeieW3zVfCIwsgneiIp6v7Y0eU5CmGCsMC9B/nO6IlstEECEbK
   dTLOG4B/U0uEL9g4lQATmEed24hEvA2Z34zWKVdgo6FrYCcsBdBJQjPXN
   w==;
X-CSE-ConnectionGUID: elwWBXeBTWSiY2NBsRYAkw==
X-CSE-MsgGUID: iqe5mWoOQNqknPHF4DtVKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88012620"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="88012620"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 20:46:33 -0700
X-CSE-ConnectionGUID: j6vbUiTHQOuZr4Uc0EJ5Mw==
X-CSE-MsgGUID: aVjU1SuuSLqQW72KLuxDeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="263890983"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 20:46:18 -0700
Message-ID: <54d1bd0e-c27a-4033-ab97-02cd9579a620@intel.com>
Date: Tue, 25 Aug 2026 11:46:13 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 07/41] KVM: guest_memfd: Stub in ability to enable
 in-place shared<=>private conversion
To: Ackerley Tng <ackerleytng@google.com>, aik@amd.com,
 andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org,
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
 Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-coco@lists.linux.dev
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-7-2fc18ee6d3ba@google.com>
 <a410cca6-0776-44af-8353-9b7375e2fd4e@intel.com>
 <CAEvNRgGvxMus6pp=xuDYOumH3Ge4oi0=YKjTaFykFHwXuzRDwg@mail.gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CAEvNRgGvxMus6pp=xuDYOumH3Ge4oi0=YKjTaFykFHwXuzRDwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/24/2026 10:45 PM, Ackerley Tng wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
>> On 8/8/2026 5:52 AM, Ackerley Tng via B4 Relay wrote:
>>> From: Sean Christopherson <seanjc@google.com>
>>>
>>> Stub in global variable to enable in-place guest_memfd private<=>shared
>>> memory conversion, which will eventually be exposed to userspace via a
>>> module param, and wire up the __kvm_mem_is_private() static call to the
>>> guest_memfd version when in-place conversion is enabled, i.e. when gmem is
>>> the sole authority on private vs. shared memory.
>>
>> I find this patch changes the default memory type for a @gfn.
>>
>> - When memory attribute is tracked per-VM, the default memory type is
>> always shared.
>>
>> - when gmem_in_place_conversion is true,
>>     - if the @gfn has no memslot, or the memslot where the @gfn locates
>>       doesn't have gmem bound, the default memory type is shared,
>>     - otherwise, the default memory type is determined by the
>>       GUEST_MEMFD_FLAG_INIT_SHARED flag.
>>
>> I think we should document this change.
>>
> 
> In a way it's not really a "change" since gmem_in_place_conversion is
> set up as false in this patch.

I agree. It is not this patch making the change but the patch allows 
gmem_in_place_conversion to be true.

> When it is enabled in a later patch, another way to see it is that the
> default remains "shared unless defined as private".
> 
> Before:
> 
> + no memslot, or memslot not bound to gmem => shared
> + memory is shared unless VM ioctl used to make gfn private.
> 
> After:
> 
> + no memslot, or memslot not bound to gmem => still shared
> + otherwise, ask gmem about status, which I think is already captured in
>    the module param concept.
>      + The very usage of gmem (without INIT_SHARED) is defining memory as
>        private, I think that is already documented elsewhere when
>        INIT_SHARED was introduced, that now the default is private.
> 
> So in summary, I feel that this has already been documented in various
> places. I'll also add the following in v11's "KVM: Let userspace disable
> per-VM mem attributes, enable per-gmem attributes", in
> Documentation/admin-guide/kernel-parameters.txt:
> 
> 	kvm.gmem_in_place_conversion=
> 			[KVM] Controls whether KVM enables in-place conversion
> 			support for guest_memfd and tracks the private/shared
> 			state of memory per guest_memfd instead of per VM.
> 
> 			If enabled (the default), KVM enables the

I think the default is disabled?

> 			KVM_SET_MEMORY_ATTRIBUTES2 ioctl on guest_memfd file
> 			descriptors and disables the legacy VM-scoped
> 			KVM_SET_MEMORY_ATTRIBUTES ioctl for private memory state
> 			tracking. Only the KVM_MEMORY_ATTRIBUTE_PRIVATE
> 			attribute moves to per-guest_memfd tracking; other
> 			attributes remain per-VM.
> 
> 			This parameter toggles KVM's in-place conversion
> 			capability support. 

I start to think that the term "in-place conversion" seems to read 
inaccurate. I think it is describing the shared/private conversion of a 
gfn, and in-place means when a gfn is converted between shared/private, 
the backend comes from the same gmem page, thus in-place. But KVM 
doesn't enforce the "in-place".

If "in-place conversion" describes the shared/private conversion of a 
gmem page, then "in-place" is redundant because the conversion a 
specific gmem page is always in-place.

>                       Whether a VMM uses separate backends
> 			or out-of-place memory management is determined by
> 			userspace VMM design.
> 
> 			Note, this parameter is only available when
> 			CONFIG_KVM_VM_MEMORY_ATTRIBUTES=y. When
> 			CONFIG_KVM_VM_MEMORY_ATTRIBUTES is not set, in-place
> 			conversion is unconditionally enabled.
> 
> 			Default is Y (on).

I'm looking at the doc of KVM_SET_USER_MEMORY_REGION2, which reads

# When mapping a gfn into the guest, KVM selects shared vs. private, i.e 
consumes
# userspace_addr vs. guest_memfd, based on the gfn's 
KVM_MEMORY_ATTRIBUTE_PRIVATE
# state.  At VM creation time, all memory is shared, i.e. the PRIVATE 
attribute
# is '0' for all gfns.  Userspace can control whether memory is 
shared/private by
# toggling KVM_MEMORY_ATTRIBUTE_PRIVATE via KVM_SET_MEMORY_ATTRIBUTES as 
needed.
