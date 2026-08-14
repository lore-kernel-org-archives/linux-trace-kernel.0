Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21F9296BC8;
	Fri, 14 Aug 2026 03:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786677965; cv=none; b=QCwJExzqtNZslzsnk4ihwZLUn81QjZbqT+U8EK+OMFZr78tUzEVpcgsw1z/IxMxIXE2B5ezZaMGyVEu47Z/nszhyULBpVmoiY9Eqq1CNf5OZgvT+4xN5bYeEU8+7GNuPNcSf1MnLdji5dKwHE9T0znecm0wXBYva9c6ilvwdonc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786677965; c=relaxed/simple;
	bh=PMW+3tSZuBZ77kt9zO5BRfNKhdxheMBPxWzy74mRfwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oIY5i3a9fOFoP0b4lt1mBABpIiCr0r2N8HkO/m5gGFYAe31Y8iqlDoL9WRUcq6H5Fls17jxbfjl2ZvUERDF6iw7GmCMQFL7MNGTnJRzq4aW/ltwtNmTOdRlG1QDAu5MIW+5Yz8IaL4HoIKaiWK8ja5/VT0i6f9dCEIrWUvk2wsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eMj3o8k6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMj3o8k6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786677963; x=1818213963;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PMW+3tSZuBZ77kt9zO5BRfNKhdxheMBPxWzy74mRfwk=;
  b=eMj3o8k6PmGHc0TNTSfWPSGFK8UL8nbFtIPJ3sZO8iZxAltJnIwrEbc0
   UGDs25+h/DCuX8SQyGgcnD0q1yPZIb843y6Bk2iOBRY8KFG9ykaqmRq+g
   QyM4w8xikZTFcdAGLf5oikgXDqZfLb9TSc4QiK5Fj5Q4VUpUR/+bK5K7O
   JTOo8dud66wZ7rfZM48abXXwa+bizjR4VEF2TimNtVg8yIT0L0ZvlMe8J
   AdVil0nW4t2+l1qo215WTa0r0RPnQbLnrwWIpJ6/eaTT/LIsA/DEOa6xQ
   H2VtpEd/AuF000JwEngAwBTmxe/RrJt05F06pgvAox9jXphkKDc29j2UK
   w==;
X-CSE-ConnectionGUID: I6Je6pSsQt625Odh5p5Wrg==
X-CSE-MsgGUID: ocjE1+VUT+GgWss7y8NQxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="112801659"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="112801659"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 20:26:01 -0700
X-CSE-ConnectionGUID: OK2WNfvaROqJl2omPhlcUA==
X-CSE-MsgGUID: cGwfy+bMRAqA7Rf+rV3Kow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="267971704"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 20:25:48 -0700
Message-ID: <beecf36b-b0eb-4691-918f-fd39f46d5d8f@linux.intel.com>
Date: Fri, 14 Aug 2026 11:25:46 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 15/41] KVM: guest_memfd: Handle lru_add fbatch
 refcounts during conversion safety check
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
 linux-mm@kvack.org, linux-coco@lists.linux.dev
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-15-2fc18ee6d3ba@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260807-gmem-inplace-conversion-v10-15-2fc18ee6d3ba@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/2026 5:52 AM, Ackerley Tng via B4 Relay wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> A guest_memfd folio is safe for conversion if guest_memfd holds the last
> references on it. Any other references on the folio may indicate another
> user, and guest_memfd cannot convert it to private if there may be an
> existing host user.
> 
> A folio will have extra refcounts if it is present in a per-CPU lru_add
> fbatch. guest_memfd does not actually participate in LRU, but
> freshly-allocated folios are still added to the lru_add fbatch for batch
> LRU statistics processing.
> 
> This one known "usage" of the folio is handled by draining the lru_add
> fbatch. After draining, if the refcount is still elevated, then there's
> truly some other user of this page, and the page is not safe for
> conversion.
> 
> If the page may be dma pinned, DMA is obviously using it and hence not safe
> for conversions. If the page is still mapped after guest_memfd tried to
> unmap it earlier in the conversion process, it is also obviously not safe
> for conversion. Exit early to avoid unnecessary draining in these 2 cases.
> 
> Provide a drain status to only drain once ever while processing a batch of
> folios.
> 
> Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Suggested-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

With the updated version of change log,

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

One nit below.

[...]

> +static bool __folio_safe_for_conversion(struct folio *folio,
> +					enum lru_cache_drained *drained)
> +{
> +	const int filemap_get_folios_refcount = 1;
> +

Nit:
After adding the helper, the use of filemap_get_folios_refcount seems
less obvious. It introduces unnecessary tight coupling with the caller,
though it has only one caller currently.

Is it better to pass the value as extra_refs, similar to what
lru_cache_drain_for_folio() does? 


> +	if (folio_maybe_dma_pinned(folio) || folio_mapped(folio))
> +		return false;
> +
> +	lru_cache_drain_for_folio(folio, filemap_get_folios_refcount,
> +				  drained);
> +
> +	return folio_ref_count(folio) ==
> +	       folio_nr_pages(folio) + filemap_get_folios_refcount;
> +}
> +
>  static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t start,
>  					    size_t nr_pages, pgoff_t *err_index)
>  {
> +	enum lru_cache_drained drained = LRU_CACHE_NOT_DRAINED;
>  	struct address_space *mapping = inode->i_mapping;
> -	const int filemap_get_folios_refcount = 1;
>  	pgoff_t last = start + nr_pages - 1;
>  	struct folio_batch fbatch;
>  	bool safe = true;
> @@ -560,9 +576,8 @@ static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t start,
>  		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
>  			struct folio *folio = fbatch.folios[i];
>  
> -			if (folio_ref_count(folio) !=
> -			    folio_nr_pages(folio) + filemap_get_folios_refcount) {
> -				safe = false;
> +			safe = __folio_safe_for_conversion(folio, &drained);
> +			if (!safe) {
>  				*err_index = max(start, folio->index);
>  				break;
>  			}
> 

