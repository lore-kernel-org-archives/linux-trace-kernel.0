Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02E2377EBF;
	Sun, 26 Jul 2026 23:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785109860; cv=none; b=mZd1rOUKGI301f/vqLuHElDDS+8iPBk8d4lDqFfHWFDq8LeQ1iGm0QZJk6XzwTvdaOYgVZGGH7/MRlSMvp/eW23OobREsimI6K65H8YF9T9TC+LGxv52K0FfjM5n7DOPaU0T5kup7ZShc0zOZB8s3mGLMh+q2oaGC5O4pqt/aBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785109860; c=relaxed/simple;
	bh=w3YBSvvfVz5JF33QARLRRJQqjXjDJFyb9uG/iZgc4mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VfTNjjEK9UZAdPhxSUOKi81tafFXc0Al7dfaldUMJy0ekrdvHXwpVOS/Q5QIxEhavcAYp0mVUhe3cTfGzpStEa23QJkya77wCdV+e4zqkn8DLRO+MDvqCR1LedGhtaXJtaMOExV87izqng+p55jZ41C7+QWhG32+9t3Zxlr17ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=neUycue3; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="neUycue3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785109858; x=1816645858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w3YBSvvfVz5JF33QARLRRJQqjXjDJFyb9uG/iZgc4mc=;
  b=neUycue3R2dLu5MQYFeuWgQs0/uvtv7GpVwyyVhD25QrKNG/2xX4H3E4
   imSSkxllX2d+3FU5df9FzJ9UXn1Xm1SQT8KJqd+E6U/5O1KiTmVkeldeC
   WT1MpPn7gcObI0Q2zfq39sBB4cBqlFDTQlwg7V1HFFpmhcqWJ2YyeJUtv
   MOiLenP4bysejnYES22rgGhvE9dJbTcIw6F6Gpw2NCBEFot6QZ34h3qoc
   Eh7M4qUfRq9tWMG+HX1qje+gFMVYNMV1JpaanPqdZv9ck94NeUxMBi1FA
   p/a8VYn20T2huhBBRIcQw8+mxP4Fz0XfgbUAaoVIHj9tHzjdRtGEOLu1K
   A==;
X-CSE-ConnectionGUID: faEvjhpAThmA73feqWRuZw==
X-CSE-MsgGUID: MoAsjdJwTD6f1Pwu1A9slg==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="85865817"
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="85865817"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 16:50:58 -0700
X-CSE-ConnectionGUID: agLzIQEmTc6jL3Ev+0bsew==
X-CSE-MsgGUID: agHlASBAQU66Z+XbiSxRcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="282588009"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.238.208.132]) ([10.238.208.132])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 16:50:45 -0700
Message-ID: <5692db20-9428-4d88-a358-b90668b930e3@intel.com>
Date: Mon, 27 Jul 2026 07:50:43 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 17/46] KVM: guest_memfd: Advertise
 KVM_SET_MEMORY_ATTRIBUTES2 ioctl
To: Ackerley Tng <ackerleytng@google.com>,
 Sean Christopherson <seanjc@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com,
 brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org,
 jmattson@google.com, jthoughton@google.com, michael.roth@amd.com,
 oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com,
 rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com,
 steven.price@arm.com, tabba@google.com, willy@infradead.org,
 wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com,
 pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org,
 liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
 <20260618-gmem-inplace-conversion-v8-17-9d2959357853@google.com>
 <584a8f9a-1538-4f8b-b576-75ef0fa961c7@intel.com>
 <akU7uAKb5E_Tklx-@google.com>
 <c0e2df0a-19b2-4234-b0f7-41e010452b06@intel.com>
 <CAEvNRgHmhpP=Re-RzojAp7E3E-TsdoUPhtZ6eSW4bf+5RVbzew@mail.gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CAEvNRgHmhpP=Re-RzojAp7E3E-TsdoUPhtZ6eSW4bf+5RVbzew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/2026 4:26 AM, Ackerley Tng wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
>> On 7/2/2026 12:09 AM, Sean Christopherson wrote:
>>> On Wed, Jul 01, 2026, Xiaoyao Li wrote:
>>>> On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
>>>>> @@ -4969,6 +4973,11 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>>>>>     		return 1;
>>>>>     	case KVM_CAP_GUEST_MEMFD_FLAGS:
>>>>>     		return kvm_gmem_get_supported_flags(kvm);
>>>>> +	case KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES:
>>>>> +		if (!gmem_in_place_conversion || !kvm_supports_private_mem(kvm))
>>>>> +			return 0;
>>>>> +
>>>>> +		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
>>>>>     #endif
>>>>>     	default:
>>>>>     		break;
>>>>
>>>> this looks inconsistent with the
>>>>
>>>> 	case KVM_SET_MEMORY_ATTRIBUTES2:
>>>> 		if (!gmem_in_place_conversion)
>>>> 			return -ENOTTY;
>>>>
>>>> Well, the check of
>>>>
>>>> 	if (!kvm_arch_has_private_mem(f->kvm))
>>>> 		return -EINVAL;
>>>>
>>>> is buried in the following kvm_gmem_set_attributes(). How about moving of
>>>> kvm_arch_has_private_mem() check to put it along with
>>>> gmem_in_place_conversion check in kvm_gmem_ioctl() in Patch 13?
>>>
>>> Me confused, patch 13 already adds the kvm_arch_has_private_mem() in
>>> kvm_gmem_set_attributes().
>>
>> I wanted to make the check in KVM_SET_MEMORY_ATTRIBUTES2 in Patch 13
>> like something below:
>>
>> 	case KVM_SET_MEMORY_ATTRIBUTES2:
>> 		if (!gmem_in_place_conversion || !kvm_arch_has_private_mem(f->kvm))
>> 		return -EXXX;
>>
>> and finally, with the introduction of kvm_supports_private_mem() in this
>> patch, it becomes:
>>
>> 	case KVM_SET_MEMORY_ATTRIBUTES2:
>> 		if (!gmem_in_place_conversion || !kvm_supports_private_mem(f->kvm))
>> 		return -EXXX;
>>
> 
> Is the request here to make KVM_SET_MEMORY_ATTRIBUTES2 return -ENOTTY
> instead of -EINVAL? kvm_gmem_set_attributes() also checks for
> !kvm_arch_has_private_mem() and returns -EINVAL.

Not really.

I want both "KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES" and 
"KVM_SET_MEMORY_ATTRIBUTES2 on gmem" to check gmem_in_place_conversion 
and kvm_supports_private_mem() in the same if(), or side by side if two 
different return code is desired.

Because the current code somewhat confused me on why 
KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES checks two conditions while 
KVM_SET_MEMORY_ATTRIBUTES2 on gmem only checks gmem_in_place_conversion. 
Only later did I realize that KVM_SET_MEMORY_ATTRIBUTES2 on gmem also 
checks kvm_supports_private_mem(), but buried in the following handling.

> I'm about to post v9, which squashes the patches as Sean
> suggested. Please review v9 instead to see if this concern is already
> addressed :)

sure.

