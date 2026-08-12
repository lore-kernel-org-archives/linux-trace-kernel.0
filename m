Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A2F21D591;
	Wed, 12 Aug 2026 03:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786504392; cv=none; b=a8pb/G5kwjV0p0pf4OuA8H1menBtgMr0d7sNdohjlyTTmmCM5Qs75n8jfey7STfsWdP6XVAhmsril+ylxClT76+pZoLEbcUNjUrsuWannAsSvP8m4DCH4eZiWawNrVsG9hivgodLR3hQvsb73vXs8EKmOJgRQt1rJnhKU3iQ6Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786504392; c=relaxed/simple;
	bh=AkKijx+yhl0VzD/BsT+PyE6ekz5n9cwWuOOi+c1ujAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U4MeesotSY88uQbejb2iJz3R/nfLrstmukCfpZDuxml9XIpoFx+/sl04h9VQDL5p/l7eEDe5jQgfWNKCxRq8VfutKdn4w5kpDw0Sr5/o8kRvE9bTAkSu+5yLW8J7KsoHam4g909ndgPmbnrbbmsQ/BEJCkHdgxchc4l3ZxA+Aw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TnMfDSKr; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TnMfDSKr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786504390; x=1818040390;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AkKijx+yhl0VzD/BsT+PyE6ekz5n9cwWuOOi+c1ujAc=;
  b=TnMfDSKr548TJGD8PuteND1I/uTXa4UjUYFZJ6ippm3R/scduuHmxGV/
   8mOjngGXt6eJBCGlV+lhkcWWnJV9v8GkezVEmaZZ6xSEmF9nmNZz846Vc
   tBcy3I9O/M6FNw6ndxKMjX9gjizdYNYxYfKDeojb4q6BzP6SfhuzJb/kn
   /kz0Q9vl4C/NMQRUe0yh5G3ELUrRBezN/jmlZ7AxnbQv0L/HdFLr7fhB2
   J4VaYO0W+d8Ubfy/83KhcehJk53CB+Rxb5hGBjOTaY4ovOzrwrcVrFgg0
   srz6SNtb0rs7GoxsHFi35fEgc0/boKLs02fecsG+IxeyBb0HdDIVMM5XK
   A==;
X-CSE-ConnectionGUID: 7uqvdKkjQiy7DozZi3KQRQ==
X-CSE-MsgGUID: m3+IpmOySNqDDaCL1bjM1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87069595"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="87069595"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 20:13:09 -0700
X-CSE-ConnectionGUID: +2b0w5VQSvqkwpgU/D8G6w==
X-CSE-MsgGUID: /572NDDhT8KJyc2EdBGfOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="267358694"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 20:12:55 -0700
Message-ID: <06f8fbe4-80b3-4d5b-a8cd-2144087e3dbe@linux.intel.com>
Date: Wed, 12 Aug 2026 11:12:53 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/41] KVM: guest_memfd: Use kvm_mem_is_private() when
 populating guest_memfd memory
To: ackerleytng@google.com
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
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, tarunsahu@google.com,
 Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-coco@lists.linux.dev,
 Xiaoyao Li <xiaoyao.li@intel.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-1-2fc18ee6d3ba@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260807-gmem-inplace-conversion-v10-1-2fc18ee6d3ba@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/2026 5:52 AM, Ackerley Tng via B4 Relay wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Using kvm_mem_is_private() when populating guest_memfd instead of using an

Nit:
Using -> Use?
> open coded equivalent.  In addition to simplifying the populate code *now*,
> this avoids the need to provide a range-based gmem lookup API in the future
> as well.
> 
> No functional change intended.
> 
> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  virt/kvm/guest_memfd.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index b596486d184ca..a11cf6dc785da 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -811,9 +811,7 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>  
>  	folio_unlock(folio);
>  
> -	if (!kvm_range_has_memory_attributes(kvm, gfn, gfn + 1,
> -					     KVM_MEMORY_ATTRIBUTE_PRIVATE,
> -					     KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
> +	if (!kvm_mem_is_private(kvm, gfn)) {
>  		ret = -EINVAL;
>  		goto out_put_folio;
>  	}
> 

