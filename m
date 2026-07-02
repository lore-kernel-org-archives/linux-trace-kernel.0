Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404013C2B8F;
	Thu,  2 Jul 2026 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989544; cv=none; b=RtmYXHiXnDrnPJ+7t36rH+L+ZxyTTiCSVQ/1L6HUZlo7zTnYjTDSbD6asvcdjg4arrmleaF3iexaleQrzumb0tNbqayCgLZvxppqbkGEjuU1jn9FyDvRE+P/RNyimiYNaj0b/velI53gHvP3nj24zR3tSTsBRFSqOnigjnEgrUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989544; c=relaxed/simple;
	bh=Tgt4hhMcByBvGKOTB4ie6cqyN7pvf1X8oWW3X+m/fC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lusDGBetqqU+N6AYRa9rmhPrwKeCrIK6UTY5Ed1tfGOjVVszr6DI/ZYCj62CYieA5f4dHLN+kIqaUmonK32jTljK6hHQ34Ugx5hln5HRLF7Kt8Wa9UxF2uKrASWj44t1EI6J0SE7D9U0wHajg2D/7/3Wpp72/sjzzoWK55cwIu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WTcgxXBi; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTcgxXBi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782989544; x=1814525544;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Tgt4hhMcByBvGKOTB4ie6cqyN7pvf1X8oWW3X+m/fC8=;
  b=WTcgxXBi+65sNoPmVSFNOMdw9c0jmKFqzuJWGvv8zAAzlxEFuXD1xJ2Q
   0rFANfbOZniroBy/acnataEM+q+Yh9cC+k4tILdoZZ+nnuACyPVbCY42N
   sn3O0bzYXnkDoUqVmHqrPDD9B6/xzIK14YjB1J24geHTFAuz3VvGezN/7
   0LrMzkclEOLUS9nzEIvEP3rw8VPVpW6BvzPK2DChO0vfLdtXJrYFn5ob1
   CG6zfH0DIz2dmohf88muSCM3cRPwTkk+EPVRYoN48hpFlQRXzPdqp2IVH
   zL5+KdM0i2arW8ouWNeWyPQX3wuoMwrVRuO2pDU1t5d16fXvTGstxBTvj
   Q==;
X-CSE-ConnectionGUID: wGoCylRLTJq37RpQoZeLQA==
X-CSE-MsgGUID: AiFwafKvTDOG/Yf7BvGXfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="94341064"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="94341064"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 03:52:23 -0700
X-CSE-ConnectionGUID: I7qt9/olRoyxa2x0VmcfeQ==
X-CSE-MsgGUID: Yp1EvDSzRoq8GXy7mZVstQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="282905050"
Received: from unknown (HELO [10.239.158.38]) ([10.239.158.38])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 03:52:09 -0700
Message-ID: <c0e2df0a-19b2-4234-b0f7-41e010452b06@intel.com>
Date: Thu, 2 Jul 2026 18:51:46 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 17/46] KVM: guest_memfd: Advertise
 KVM_SET_MEMORY_ATTRIBUTES2 ioctl
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
 <20260618-gmem-inplace-conversion-v8-17-9d2959357853@google.com>
 <584a8f9a-1538-4f8b-b576-75ef0fa961c7@intel.com>
 <akU7uAKb5E_Tklx-@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <akU7uAKb5E_Tklx-@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/2026 12:09 AM, Sean Christopherson wrote:
> On Wed, Jul 01, 2026, Xiaoyao Li wrote:
>> On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
>>> @@ -4969,6 +4973,11 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>>>    		return 1;
>>>    	case KVM_CAP_GUEST_MEMFD_FLAGS:
>>>    		return kvm_gmem_get_supported_flags(kvm);
>>> +	case KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES:
>>> +		if (!gmem_in_place_conversion || !kvm_supports_private_mem(kvm))
>>> +			return 0;
>>> +
>>> +		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
>>>    #endif
>>>    	default:
>>>    		break;
>>
>> this looks inconsistent with the
>>
>> 	case KVM_SET_MEMORY_ATTRIBUTES2:
>> 		if (!gmem_in_place_conversion)
>> 			return -ENOTTY;
>>
>> Well, the check of
>>
>> 	if (!kvm_arch_has_private_mem(f->kvm))
>> 		return -EINVAL;
>>
>> is buried in the following kvm_gmem_set_attributes(). How about moving of
>> kvm_arch_has_private_mem() check to put it along with
>> gmem_in_place_conversion check in kvm_gmem_ioctl() in Patch 13?
> 
> Me confused, patch 13 already adds the kvm_arch_has_private_mem() in
> kvm_gmem_set_attributes().

I wanted to make the check in KVM_SET_MEMORY_ATTRIBUTES2 in Patch 13 
like something below:

	case KVM_SET_MEMORY_ATTRIBUTES2:
		if (!gmem_in_place_conversion || !kvm_arch_has_private_mem(f->kvm))
		return -EXXX;

and finally, with the introduction of kvm_supports_private_mem() in this 
patch, it becomes:

	case KVM_SET_MEMORY_ATTRIBUTES2:
		if (!gmem_in_place_conversion || !kvm_supports_private_mem(f->kvm))
		return -EXXX;

So that the guard for KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES and 
KVM_SET_MEMORY_ATTRIBUTES2 is consistent.

> That said, the ordering here is wonky and misleading.  A cursory read of the series
> would make one think that waiting to advertise KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES
> makes it safe/ok for KVM to plumb in support for KVM_SET_MEMORY_ATTRIBUTES2 over
> multiple patches.  But that's not actually true, because the ioctl becomes live
> the instant the code exists, userspace doesn't need to wait for KVM to formally
> advertise support.
> 
> To further confuse matters, it is actually safe/ok to iteratively add support,
> because it's all effectively dead code until "Let userspace disable per-VM mem
> attributes, enable per-gmem attributes".

yeah, before patch 24, gmem_in_place_conversion is always false. So 
KVM_SET_MEMORY_ATTRIBUTES2 on gmem fd always return -ENOTTY.

> So, I think we should go a step further than what I think Xiaoyao is suggesting,
> and fully squash patch 17 into patch 13.  That way the reader doesn't have to jump
> through as many mental hoops to piece together what is happening.  It'll obviously
> be a bigger patch, but should be easier to review/understand overall.
> 
> Oh, and that combined patch should carve out error_offset straightaway, so that
> the full uAPI can be reviewed in a single patch.

It sounds good.
