Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B74F3EBF35;
	Tue,  4 Aug 2026 02:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809492; cv=none; b=t3VGm/zg4mrG61bguNPxsyo80hn5BiEWlGxYwzL2LeHtREi4CaNXMVylJRPXU4u/D9dS7b+RQUblqlUn1ber9UWKBWc9NIwE87dpNz1TfGqGxjtvA0p0s7oTlY5FGg6XtuWGqmz5jirRAGR2zOHI0Je+JYf8upzc0uQ3GZ5lZNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809492; c=relaxed/simple;
	bh=B+nmhdc2wKhIJIpBwW+MwyfYVUtbdARoiSCqxXo6ddg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/qgCb3ElSS3P3kwWkxl1HEAMrYqjfzWvti3xg1VBazgdtF83wQjrBHNkusf+YLcWj8utRTz8qNoGrWThogDsU5dGeH18DSfmQEigCXXxKqHL6AFkMPNzsK38QMLop7qKdpwh+xjVC/7Bqa35/uzrSrnADeoVfBTNYxRfE9hSpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xtzv3LVa; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xtzv3LVa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785809488; x=1817345488;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B+nmhdc2wKhIJIpBwW+MwyfYVUtbdARoiSCqxXo6ddg=;
  b=Xtzv3LVa3UehsCqM6p8fBwnQS2gwu+bKqu9ZOG/dmGXYwmqs9ATRKQWI
   VJXWn9v4cmQqCpJ86qkYYR9udXy0zQ2V67gT4a3g1J1K+f4pV7z0eTIld
   sj9tGfLCILOi5sqMN9dCAjZMbDFin+Gelu7Eig+0MEVbwR8XKuiWD2VDq
   ta79LDKwxFO5sB5YCrNCUs6shqKWOdgskjKyLLNVrKCVIn6vD4LENlhUQ
   BZbxsbH6XYs9DvrADevURiVtuljG1kcJ3wuGXezbBbg/W6gHzMAfdDHM/
   nE7IWTryuBrkEt4XAM2t8GEymy1jAX8vHvBv6G4WJ9B7Aehbqw81TrnYm
   w==;
X-CSE-ConnectionGUID: 5Bm+EVg0REiduRwbaRqR6g==
X-CSE-MsgGUID: TRs68jxFSTaItZKtaKTAqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86121625"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86121625"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:11:25 -0700
X-CSE-ConnectionGUID: KUMwzY9FTRiSU0SR1Bn47g==
X-CSE-MsgGUID: U8Dg8g26SGOUT5Pc2eda4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="266494953"
Received: from fuxiaogu-mobl1.ccr.corp.intel.com (HELO [10.238.208.47]) ([10.238.208.47])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:11:07 -0700
Message-ID: <aaaa3463-87b7-4e01-9f0e-8ff1b732d260@intel.com>
Date: Tue, 4 Aug 2026 10:11:05 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 07/41] KVM: guest_memfd: Wire up core private/shared
 attribute interfaces
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
 <20260728-gmem-inplace-conversion-v9-7-35f9aec2aed2@google.com>
 <60d19013-d6d7-4eec-827a-2622e22cec98@intel.com>
 <CAEvNRgF0SxmoMtqq69tUih54A9K7j_wcMFRrq=r9w6TnAGAUQQ@mail.gmail.com>
 <dd4201f2-3660-46ad-958f-c70feb1ab1c3@intel.com>
 <amzMtg4K6qEEsudx@google.com>
 <25ab36cf-888a-4547-b3f7-5bd4e057c1d0@intel.com>
 <anC0uuZIrbxlGubN@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <anC0uuZIrbxlGubN@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/3/2026 11:33 PM, Sean Christopherson wrote:
> On Mon, Aug 03, 2026, Xiaoyao Li wrote:
>> On 8/1/2026 12:26 AM, Sean Christopherson wrote:
>>> On Fri, Jul 31, 2026, Xiaoyao Li wrote:
>>>> On 7/31/2026 4:42 AM, Ackerley Tng wrote:
>>>> If kvm_range_is_private() is useful/required by huge page support, then let
>>>> the huge page series to introduce it. It has nothing to do with the in-place
>>>> conversion series.
>>>
>>> If it weren't for the fact that the range-based search is used later in this
>>> series, I would 100% agree with Xiaoyao.
>>> But since the core logic is used and needed elsewhere,
>>
>> I don't see it a problem. Without introducing kvm_range_is_private() in this
>> patch, the core logic of range-based search on gmem can still be introduced
>> as kvm_gmem_range_has_attributes() directly in patch 10 or in a separate
>> patch.
>>
>>> and because kvm_range_has_vm_memory_attributes() takes a range, my vote is
>>> to provide the plumbing now, even though a small portion of it isn't
>>> strictly necessary.
>>
>> So my initial feedback was "we can just use kvm_mem_is_private(kvm, gfn)".
>> It makes code simpler.
> 
> My apologies, I hadn't actually applied v9 to look at the full context.  I agree,
> providing kvm_range_is_private() is completely unnecessary.  It's not even really
> a problem with this patch, it's a pre-existing issue that can and should be
> addressed with a prep patch.

yea, that's why I said "it seems can be a separate patch. "

>> And as a bonus, the logic to choose between gmem-based attribute query and
>> vm-based attribute query is hidden from the static call.
> 
> I don't follow.  What do you mean by "hidden from the static call?"  The whole
> point of using a static call is to select between gmem-based and vm-based private
> memory.  Or are you saying the populate() flow doesn't need to manually check
> gmem_in_place_conversion?

yea. By using kvm_mem_is_private(), we don't need the 
kvm_range_is_private() introduced by this patch, which has the 
gmem_in_place_conversion check.

>> The second bonus of dropping kvm_range_is_private() is that we can eliminate
>> one more chunk in patch 20.
> 
> Ya.
> 
> Untested, but unless I'm missing something, patches 6 and 7 of this series can
> be replaced with the attached patches (6 and 7 should be squashed together no
> matter what).

The attached patches are just what I wanted. They look good!
