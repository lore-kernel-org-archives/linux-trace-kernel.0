Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4BD36B935;
	Wed, 12 Aug 2026 08:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522605; cv=none; b=QnX1vWZA0fTIOWlt3aYEk81tcIL9pHikh7rdp43Vqs56sqDDpjhgWWyFB17PM8HO3HXdRpJzJbRROn71mmHA8P27a+tG/fpYfQZiHpB5yHmS44mL1AbPt0bUwLz7asUf7mH4523/3BwEzbiaNBctpbU22Bqoage8nUnQ+0yRdnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522605; c=relaxed/simple;
	bh=JSuQnVhQTnRB2r+8uupOQXcxSlYbUTdL6DRqoze9JUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dnnrsyo+ho0+ssf3E5hgB4Jv13dFUvtTT+4d7308i5lfhgdBku4+plc0J/Gq3xYAuSxqAHlvzF1wKIbuIwpOp9N7ENOsdDiFdzL1i/1JDRPmS3F0XBs5rHdhC7VA2FajHTYs8eynpH+b/nxB5Aj4WIC81Y2sOiNLrtL6mnwbqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nKSh2SIs; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nKSh2SIs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786522604; x=1818058604;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JSuQnVhQTnRB2r+8uupOQXcxSlYbUTdL6DRqoze9JUU=;
  b=nKSh2SIs8qW8afsCqKJT+tvZA77i0d11BdiUKgC2jbTeaIwfmBsmTn4f
   p9JOkQdl87Ycsc+g171QlKSNhitSY7ARVoRlb2nt/CQ60sC9c5+XBQtsb
   BxzXLcX0Vc8XDAMs3LDTPcn4o379R4L1gEENkqLup+913SgJVLm+KfE4R
   QYPXyvUZD3aAq9/8c7US/1i75JIMd/2yBwtKM6Hz9uK65JttOa0UjfKqy
   6OlaNlT4+RUI0CK9ZgsGUiiGcIsjC3jm4PLjNSToTDWSK8sn/rS6Syd1a
   7XCnIb/5O+Iz4YwMpI/p1TlGGKMjGf5pOvrseXOSNspHxJmWo3LRJEuh1
   g==;
X-CSE-ConnectionGUID: mIQFyaG8RFyO4UGqUX8i9A==
X-CSE-MsgGUID: CM7e6rWAS2WomG6Z57ucFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97414132"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="97414132"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 01:16:43 -0700
X-CSE-ConnectionGUID: BL1IvoWBSoi/4zQSJDcW7A==
X-CSE-MsgGUID: BLvW57sVSIqi8lRVaUvP2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="257378842"
Received: from unknown (HELO [10.238.208.98]) ([10.238.208.98])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 01:16:30 -0700
Message-ID: <84ad91f5-1006-410b-94a4-01e7dcc6fcbd@intel.com>
Date: Wed, 12 Aug 2026 16:16:27 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/41] KVM: guest_memfd: Use kvm_mem_is_private() when
 populating guest_memfd memory
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
 <20260807-gmem-inplace-conversion-v10-1-2fc18ee6d3ba@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260807-gmem-inplace-conversion-v10-1-2fc18ee6d3ba@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/2026 5:52 AM, Ackerley Tng via B4 Relay wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Using kvm_mem_is_private() when populating guest_memfd instead of using an
> open coded equivalent.  In addition to simplifying the populate code *now*,
> this avoids the need to provide a range-based gmem lookup API in the future
> as well.
> 
> No functional change intended.
> 
> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   virt/kvm/guest_memfd.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index b596486d184ca..a11cf6dc785da 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -811,9 +811,7 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>   
>   	folio_unlock(folio);
>   
> -	if (!kvm_range_has_memory_attributes(kvm, gfn, gfn + 1,
> -					     KVM_MEMORY_ATTRIBUTE_PRIVATE,
> -					     KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
> +	if (!kvm_mem_is_private(kvm, gfn)) {
>   		ret = -EINVAL;
>   		goto out_put_folio;
>   	}
> 

