Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A0736F902;
	Thu, 25 Jun 2026 01:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782351597; cv=none; b=B67CF0MxWGhSzfxTRhzVJHoz4NcHowLfF2ItltLPqPyy+fHBjVpuCZb9LfnxJ+3PHnShQ5iVbANfO5tENx6iotAwcgi4XnzjYS9ReWGnyYFVU2Xh4BS0GdggwheQKGJP+txJhi8xC30ClyRf+gSJwOuqO48Z819bDZttI3NIwuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782351597; c=relaxed/simple;
	bh=v+Iu61I1bvimLxwsHz2/KZ1rwv2EUAMBFICllmwPCC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mng1wWJgLQ/mtp51F3luimXw2LA1cvlsrkwU4RH4Eh2Fk+DLrajFLP79R4EqiCBb1riZAqIdFVWbpk1jHnu+vKfWOHPS6TP0uUYVFTYXw0lmep3nTHYnBTafIiqHyX400LSFbKQ5vAo+wZ/kOrNJ69H2xkA4seHZ689TdDk0uJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pmm8o/jY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pmm8o/jY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782351595; x=1813887595;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v+Iu61I1bvimLxwsHz2/KZ1rwv2EUAMBFICllmwPCC8=;
  b=Pmm8o/jYsrXJMu1+Ht5y6CjKhwGoHAOVhfL541hBmayVBh8bMj5XO0Kk
   +UwKRyapRoQZXCjAFswgUha0NGCvQHpSGWdpWLrPaSgxLc3dTA4gJW9v5
   8zxfFq3RQ122wyqeH9fOgLA9/9QksEhaVgqbaH/tF8wuaTV5eYDoZpWL7
   +54rdiZ9ncWh4+PtR628I+IqatGyKo+t08vID+Y0+c4jK38kxjmhuW5/J
   48PjaDU8MP0dj/XgtenGqezyBfMYBytmeN+lLJ0rU3tA3jxnPmw8tqfZm
   tE9kW+LfusZD7VB82UBUNbyzIxS+8jx/IrLjM3MaZsVKUE9GTpaqYsKiU
   g==;
X-CSE-ConnectionGUID: Kb8HlvCCQDK16QnKxc28zA==
X-CSE-MsgGUID: IkkkinCGRqiwVtUSNrzpXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="108668573"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="108668573"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 18:39:54 -0700
X-CSE-ConnectionGUID: bjCsAtM5Q2qyMj+6s5rL+Q==
X-CSE-MsgGUID: oxVpr/AoQXahHt8jEyg6AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="254484804"
Received: from unknown (HELO [10.238.2.81]) ([10.238.2.81])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 18:39:41 -0700
Message-ID: <2d862356-d9cb-462b-b8cf-bceca6366d40@linux.intel.com>
Date: Thu, 25 Jun 2026 09:39:38 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/46] KVM: guest_memfd: Introduce function to check
 GFN private/shared status
To: Ackerley Tng <ackerleytng@google.com>
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
 <20260618-gmem-inplace-conversion-v8-9-9d2959357853@google.com>
 <1b59fec2-a464-4429-8532-880394912af5@linux.intel.com>
 <CAEvNRgG-WDzHp-15Mig4hiU5Dag0pFCu70-R-9b=PkD69W=ZMg@mail.gmail.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <CAEvNRgG-WDzHp-15Mig4hiU5Dag0pFCu70-R-9b=PkD69W=ZMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/24/2026 10:38 PM, Ackerley Tng wrote:
> Binbin Wu <binbin.wu@linux.intel.com> writes:
> 
>>
>> [...snip...]
>>
>>> +bool kvm_gmem_is_private(struct kvm *kvm, gfn_t gfn)
>>> +{
>>> +	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
>>> +	struct inode *inode;
>>> +
>>> +	/*
>>> +	 * If this gfn has no associated memslot, there's no chance of the gfn
>>> +	 * being backed by private memory, since guest_memfd must be used for
>>> +	 * private memory,
>>
>> "guest_memfd must be used for private memory" is a bit confusing to me.
>>
> 
> Hmm good point. Is the source of confusion that guest_memfd can be used
> for both shared and private memory?

Yes.

> 
> Perhaps this can be rephrased as:
> 
> guest_memfd is the only provider of private memory and guest_memfd must
> be used with a memslot, hence if there's no associated memslot, there's
> no chance of this gfn being private.

LGTM.

> 
>>> and guest_memfd must be associated with some memslot.
>>> +	 */
>>> +	if (!slot)
>>> +		return 0;
>>> +
>>>
>>> [...snip...]
>>>
> 

