Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C803D0900;
	Tue, 25 Aug 2026 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646348; cv=none; b=ifxaDh4k6j/GYvCD7keOvXOY33akaAhv29as/aZooZKyphSmS4LG3WpknO0aRsbdbOJ8esAGPulNTUn4PmqXTZOALyI2K41Qlr6rA5MRTQ8DDrEL2U72n+clg8FR91lSdOoc/NanpPeKmqhzT7SjS13QgZ1m6N2DHQJ+A8NWbzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646348; c=relaxed/simple;
	bh=gedJs0vtoiKBYvIXCEhQKxHm0BSByi7gwLqVFH+/z/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j32N7Zx49pxGuhD5LIJRvkuBtoXXMH3PCEzCk2UOLHD+IMgmFyElAsE7Tte4FE2ECSvSU1MmDajbqlqw951B2tFbGDvbA1UOVvCXalVOIA4kRe0vgAvZWwSjPf7StNPpOvSrJPSa7cNuFH6T7otWFPQKAl+nhOKjMJYtX+M1Xx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GND00vCh; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GND00vCh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787646346; x=1819182346;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gedJs0vtoiKBYvIXCEhQKxHm0BSByi7gwLqVFH+/z/Q=;
  b=GND00vCh4KEHhXaPHUT/B/pIfMUDFgGJcGJt1TULu/iMQcUks9l6MXPx
   eSeV2IHrQ79ny8uTVJ2qt2gtuI2+4edAb6Bre7E8ljcLxV5fbSTKjB3Dr
   xw/Qxb1A0EaT4t+FS4hyflFy2fDulmUnrIOEvK101O3An3z2SmDa5BkyQ
   jukF0H5ynMAexYSs/I3SKJ+b8ru3IIu7hIJRQG/r4y70kD65iK46eMSLW
   afo2SwtGC3Tl+sgS1B3pDk3UO9deTMRa7wNMCNPHF78XjddpIONli/RUN
   jOhyNwYiHH5LOQCoKgW6b1QHHiInljSubHTOlQf/YGb3FSXyF9UhLE/8P
   A==;
X-CSE-ConnectionGUID: VjZj360RR3GZQyspXZrafA==
X-CSE-MsgGUID: QGVXH6RXSSuwv3QuY53tYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="99454718"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="99454718"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 01:25:45 -0700
X-CSE-ConnectionGUID: dbEuODyNSE2d0o/gDaizJg==
X-CSE-MsgGUID: 4cGhqpINTNCvR1Dnz+3ULw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="270695629"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 01:25:29 -0700
Message-ID: <f7c2e245-ab9d-4ac7-b3f8-815fe111881d@intel.com>
Date: Tue, 25 Aug 2026 16:25:26 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 13/41] KVM: guest_memfd: Return early if range already
 has requested attributes
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
 <20260807-gmem-inplace-conversion-v10-13-2fc18ee6d3ba@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260807-gmem-inplace-conversion-v10-13-2fc18ee6d3ba@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/2026 5:52 AM, Ackerley Tng via B4 Relay wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> Provide function to check that a range has given attributes.
> 
> Optimize setting memory attributes by returning early if all pages in the
> requested range already has the requested attributes.
> 
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Tested-by: Shivank Garg <shivankg@amd.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   virt/kvm/guest_memfd.c | 23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index c9874bd85c5d8..896699afcad9d 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -95,6 +95,24 @@ static bool kvm_gmem_is_shared_mem(struct inode *inode, pgoff_t index)
>   	return !kvm_gmem_is_private_mem(inode, index);
>   }
>   
> +static bool kvm_gmem_range_has_attributes(struct inode *inode,
> +					  pgoff_t index, size_t nr_pages,
> +					  u64 attributes)
> +{
> +	struct maple_tree *mt = &GMEM_I(inode)->attributes;
> +	pgoff_t end = index + nr_pages - 1;
> +	void *entry;
> +
> +	lockdep_assert(mt_lock_is_held(mt));
> +
> +	mt_for_each(mt, entry, index, end) {
> +		if (kvm_gmem_get_attributes(inode, entry) != attributes)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>   /*
>    * Returns a locked folio on success.  The caller is responsible for
>    * setting the up-to-date flag before the memory is mapped into the guest.
> @@ -605,12 +623,15 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>   	pgoff_t end = start + nr_pages;
>   	struct maple_tree *mt;
>   	struct ma_state mas;
> -	int r;
> +	int r = 0;
>   
>   	mt = &gi->attributes;
>   
>   	filemap_invalidate_lock(mapping);
>   
> +	if (kvm_gmem_range_has_attributes(inode, start, nr_pages, attrs))
> +		goto out;
> +
>   	mas_init(&mas, mt, start);
>   	r = kvm_gmem_mas_preallocate(&mas, attrs, start, nr_pages);
>   	if (r) {
> 

