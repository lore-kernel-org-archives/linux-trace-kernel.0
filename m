Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04A0409273;
	Thu, 30 Jul 2026 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409571; cv=none; b=qTpcacZmgGIMhBbhDZLEcwbUV7RIUa4eSoYMoQwtTddUfV37m0adu4KdKDEx9B/uUKsP4V8it9HauAmyTV7TAq2lwWRNtgD2+qpAKVChcIIDjDUhdmdX6lPYcv1dFFZJrY6IJC9eLTCE+tDgiV5ngt3oQk5V4PZCr0Fcop8vacU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409571; c=relaxed/simple;
	bh=PUZhSC1gi6rvfO8jI6WcwmVBTHNrh7lYeL/4qOTqxMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2kWB6pa2RTLR0G3/Ob5xy7hR7IL8AlSmLnurcY7ik/Xffq1rNWpqvpXoWoPlvaeq2V2tpLOJok9cZWSUSs1X2Jl2MGaGSxVIeTZW8mTTDPv4MbYI6fVpKhh3NlaKnQ8bRgmO2XHI6VwnnQGbHSVLD+gnJcOU1hZiATehjHH7zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n3sB4jGT; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n3sB4jGT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785409570; x=1816945570;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PUZhSC1gi6rvfO8jI6WcwmVBTHNrh7lYeL/4qOTqxMM=;
  b=n3sB4jGT5r72nR469afhiR92iJTmbo8BTp2zReAujIt+YSTtGvbP0uW6
   qKwGm4cal6pCN6xuaNpkf25j5ZWBnp4LPlc5zfzhhzUwRWO/kOfCqBBIb
   3TxyAhTD3yOKeZnuznuxaXyC+iHzthEF3H/0XruJhJvMSYwNTvYc/aai3
   zeLO/dps4/sNULTBaT5CC7h/w6xpWNJ1/E4qps4+E6SBHaz/kkJ7pgLJd
   Ju2vg60wpdmB2ov8nt7HJXDiiwM8LfkMTV0aaSrXblsw8UZUaG6HeC1ar
   nXQtI1W1Caky2dmFMTNHhc/2u5bR7vpA05Ra18gMwbN0U4l29rXfUh/aV
   A==;
X-CSE-ConnectionGUID: 4wa30RUNTzSBwGJtTaLMEw==
X-CSE-MsgGUID: CB5QueH5Tw6t2as+xNznXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103563719"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="103563719"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 04:06:09 -0700
X-CSE-ConnectionGUID: Tjl+ELBLRduZwfpbEckF6A==
X-CSE-MsgGUID: D6pCye+pTPu2j12lE2XsAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="260875994"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.238.208.132]) ([10.238.208.132])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 04:05:55 -0700
Message-ID: <60d19013-d6d7-4eec-827a-2622e22cec98@intel.com>
Date: Thu, 30 Jul 2026 19:05:51 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 07/41] KVM: guest_memfd: Wire up core private/shared
 attribute interfaces
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
 Peter Xu <peterx@redhat.com>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-coco@lists.linux.dev
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
 <20260728-gmem-inplace-conversion-v9-7-35f9aec2aed2@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260728-gmem-inplace-conversion-v9-7-35f9aec2aed2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/2026 8:35 AM, Ackerley Tng via B4 Relay wrote:
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 33c9830190e2e..89cf922232920 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -893,6 +893,27 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>   EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
>   
>   #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
> +static bool kvm_range_is_private(struct file *file, pgoff_t index,
> +				 size_t nr_pages, struct kvm *kvm, gfn_t gfn)
> +{
> +	struct inode *inode = file_inode(file);
> +	pgoff_t last = index + nr_pages - 1;
> +	struct maple_tree *mt;
> +	void *entry;
> +
> +	if (!gmem_in_place_conversion)
> +		return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
> +							  KVM_MEMORY_ATTRIBUTE_PRIVATE,
> +							  KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +
> +	mt = &GMEM_I(inode)->attributes;
> +	mt_for_each(mt, entry, index, last) {
> +		if (kvm_gmem_interpret_entry(inode, entry) !=
> +		    KVM_MEMORY_ATTRIBUTE_PRIVATE)
> +			return false;
> +	}
> +	return true;
> +}
>   
>   static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>   				struct file *file, gfn_t gfn, struct page *src_page,
> @@ -913,9 +934,7 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>   
>   	folio_unlock(folio);
>   
> -	if (!kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + 1,
> -						KVM_MEMORY_ATTRIBUTE_PRIVATE,
> -						KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
> +	if (!kvm_range_is_private(file, index, 1, kvm, gfn)) {

It's checking if a single gfn is private.

We can just use kvm_mem_is_private()? And it seems can be a separate patch.

>   		ret = -EINVAL;
>   		goto out_put_folio;
>   	}

