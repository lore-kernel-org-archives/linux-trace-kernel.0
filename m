Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9193B442F;
	Wed,  1 Jul 2026 07:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889333; cv=none; b=NuIyOQ29F08W5RrZzl6qCKWyU+Q7axHjdfcaESY6tQH/Sff3mMqDx40UhjO90MYpEver9LEFGqARQ4J2OXMwQOAYYjcx3Naqng+7n4dwYyzgtPKabuBmoxT6Akeac4htXOVcWRTrvdaV9I3E/61PR8flRv/fD3iM4V+ZRu/v45Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889333; c=relaxed/simple;
	bh=uTemCS9hJuZwaBtUWAiWvpe3nJ0DnwAEJpllNENNMkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jq3J8AfXnHTCleVp+J51yzBfn7pUq4WOTICxEVg7OmRXEqP/OeHCTig/oA4ON+RuiiFiRepxj+kPLEyAsdq+CEJV9683ybnMzwl6aEWvk++2FITgAGBRWPq8vobEFE1210GAOtmdPEltGHv4VZPQHlK4JQlT0sF19dRAigCvayo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BsZxu9in; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BsZxu9in"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782889332; x=1814425332;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uTemCS9hJuZwaBtUWAiWvpe3nJ0DnwAEJpllNENNMkc=;
  b=BsZxu9inLJyO6hlBjk+JmUAqD7xGtSvRyNfHKsI/QE1xmwSDjJpZiEoT
   /AxOz6NWKW2Y2ybAphGGoyBRYDO8eN36V81zzLHkukAjqbit35Nl6WG7+
   7eIGJ5zACZJc1fuEtFzkwJSYVTaOhjPX5LbByr/u2fr3g5kd72BXXoPVj
   579v6TzS8Re53L1Uo7x2S11U2uLxo0CczUA/djVJ73F5zHsNyX2/zoHIo
   KJjaTmUu28JOWlcQC++i1qvFNW7lQBi/pIfu9SNLfs/7hFZZERwlbxc5G
   VwSbs6A+IS7ygR72cyh+HaUP9QDjEupaSx1c01W2kPc3Qu8z0+KQ12ZuG
   A==;
X-CSE-ConnectionGUID: E51+qz05Q1i+YHbwnYFRSw==
X-CSE-MsgGUID: qNcvIzXzQa2qFKuW0EbqMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="82728594"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="82728594"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 00:02:11 -0700
X-CSE-ConnectionGUID: IOyXLa5dSF2JqjSse/2n1w==
X-CSE-MsgGUID: JbKqh+eBRZqdMAtXHVxILg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="275705575"
Received: from unknown (HELO [10.239.158.49]) ([10.239.158.49])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 00:01:53 -0700
Message-ID: <e5876e41-a11a-4d5e-958f-9e247c19d387@intel.com>
Date: Wed, 1 Jul 2026 15:01:35 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/46] KVM: Rename memory attribute APIs to prepare for
 in-place gmem conversion
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
 <20260618-gmem-inplace-conversion-v8-7-9d2959357853@google.com>
 <a1b06afb-af6e-4666-8c7d-990e7fa150fa@intel.com>
 <akP9Qv_IPVEh7GAB@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <akP9Qv_IPVEh7GAB@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/1/2026 1:30 AM, Sean Christopherson wrote:
> On Tue, Jun 30, 2026, Xiaoyao Li wrote:
>> On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
>>> -bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
>>> -				     unsigned long mask, unsigned long attrs);
>>> +bool kvm_range_has_vm_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
>>> +					unsigned long mask, unsigned long attrs);
>>>    bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
>>>    					struct kvm_gfn_range *range);
>>>    bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
>>
>> We have
>>
>>   - kvm_pre_set_memory_attributes()
>>   - kvm_arch_pre_set_memory_attributes()
>>   - kvm_arch_post_set_memory_attributes()
> 
> Yeah, that's probably for the best.
> 
>> left, do they need to be renamed as well?
>>
>> then the interesting one is kvm_vm_set_mem_attributes(), which contains "vm"
>> already while it means "vm ioctl". Do we need to rename it to
>> kvm_vm_set_vm_mem_attributes()?
> 
> I say "no" on this last one, the fact that the function is scoped to a VM ioctl
> is enough to communicate that it applies to per-VM attributes.
> 
> Actually, since it's a local helper, we could go with kvm_set_vm_mem_attributes()
> to be consistent with the other functions.  That just leaves
> kvm_vm_ioctl_set_mem_attributes(), which I think it appropriately scoped.

If we finally choose to rename kvm_vm_set_mem_attributes() to 
kvm_set_vm_mem_attributes(), I think the trace 
trace_kvm_vm_set_mem_attributes() needs to be renamed to keep it consistent?
