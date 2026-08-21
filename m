Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374E336680E;
	Fri, 21 Aug 2026 03:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787281947; cv=none; b=AIUYhn9RV2FuiGixZ2kRwUNPcPJ2K/v2xmLwweFKq6ali60n+Z7YxTPbvRmgUQuqNZk/JUg1b2TEYgc1Ah26tV0DDuQLhXW16DJ9mBS7X7TKVQdYM33AQ4H8Kg/CKt/ElD3c+Oy+g6aCQNgiysVjES5sFatqvSU3OA0mez2eqqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787281947; c=relaxed/simple;
	bh=LLdCyUIMvTLvV0Qwwzwy3ePPzmdPaDmUaU/9K8yTvoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBazlZrK35CtADQtBV3z36aHBvYDmEdHsLgJVSqh2QVFzzsUht2ckiYWFIMijDY0hLBPYqVBjtdo3TLPKiuSsyxGKDTrkIGTX8qeuMYF3PTiUE3SmvOJBlVEIy8lznEk8Fl1bwO3V2qkL3R2rwZrf3F507exT88lEB0S0EiaLGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AErrDzW8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AErrDzW8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787281936; x=1818817936;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LLdCyUIMvTLvV0Qwwzwy3ePPzmdPaDmUaU/9K8yTvoE=;
  b=AErrDzW8Lrl5OggMZs0wUlBqQT8JGU9lcIhvZi2TX2GPtBnUm/ITBPNp
   K0JF6fxRz9uyGc7gLJBoA8Dl6i/jVvkgDxkDu6suVACFl8clfHGG8DGS0
   P9HZHdz/IOqrE9FgxXYPbLkPA827HbamAJTkuSKTbw9TzreU1D0uCf1R+
   sj+w0rTHpwGawgCEUenRtnWOQu5KCISzptlUHuqDANImrjykhX+mWEclp
   JCrTm7uwUQXCnH2LRPvVjQYVPfYpOaoeU8Nny7fUZ4X5J160hMOqlCplT
   o/Vzft3+d3Uht0lq3vX8CLUpfbSnOXfbIi+/63SG3d0EyJ+p7Q8znCL1E
   g==;
X-CSE-ConnectionGUID: uSZJSUhnRTuS7aB8Gs0/FQ==
X-CSE-MsgGUID: hoW+MYjVTmedm2DPYhCJ8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="91701114"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="91701114"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 20:12:09 -0700
X-CSE-ConnectionGUID: NOkWPYcAQ6ua/qZWMjhxVQ==
X-CSE-MsgGUID: OFKp6eRTSFCxoY11hYwwiA==
X-ExtLoop1: 1
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 20:11:54 -0700
Message-ID: <fe1c6359-7371-4ccd-9807-1d81c160d12b@intel.com>
Date: Fri, 21 Aug 2026 11:11:51 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 40/41] KVM: selftests: Update
 private_mem_conversions_test to mmap() guest_memfd
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
 <20260807-gmem-inplace-conversion-v10-40-2fc18ee6d3ba@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260807-gmem-inplace-conversion-v10-40-2fc18ee6d3ba@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/2026 5:53 AM, Ackerley Tng via B4 Relay wrote:
> From: Ackerley Tng<ackerleytng@google.com>
> 
> Update the private memory conversions selftest to also test conversions
> that are done "in-place" via per-guest_memfd memory attributes. In-place
> conversions require the host to be able to mmap() the guest_memfd so that
> the host and guest can share the same backing physical memory.
> 
> This includes several updates, that are conditioned on the system
> supporting per-guest_memfd attributes (kvm_has_gmem_attributes):
> 
> 1. Set up guest_memfd requesting MMAP and INIT_SHARED.

If I understand correctly, even with in-place gmem, the model that 
shared memory comes from the userspace_addr and private memory comes 
from gmem can still work without passing GUEST_MEMFD_FLAG_MMAP flag.

Since this model is not prohibited by KVM. I think we should keep the 
testcase for this model to ensure test coverage?
