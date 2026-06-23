Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A1D364028;
	Tue, 23 Jun 2026 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208120; cv=none; b=NQ1Y4/UUJnyoXPdrsUhZbwPH+103n2v5Ig10bhdvGE7eBUHo24so9z1CNolrHHlChQGfvCz2Cnwk/b0vYmRhW3AzFhkvB09JoifEkldWd0iZozuTzue8+ki15yS5dah6NyDAkvpBL2zNa7L5havsIEW0fGuN995wQJE8kUDfzFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208120; c=relaxed/simple;
	bh=5923JLJcSnP+ammi926uhmSL7dT/T35P5AbtWqZVok4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ciiKaUMGa84h68WdY1T1ASu0iq+ySji3PzvORcqE5By8l4cJrhXiNTUX94E/PmJEOQP1bxOPmsEtj+azBfjaEpvtJP3BOMRvUi/6HdMy8zw3zeVa5LkW5lWylDOflo6DOv3Prcvv9MOkQDz2SF+b1Ram4WiCeaq2gffyhbjvmz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ME1VcZpF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ME1VcZpF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782208120; x=1813744120;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5923JLJcSnP+ammi926uhmSL7dT/T35P5AbtWqZVok4=;
  b=ME1VcZpFzF2OCbL72i0cVwa6Ngw32RzHDS6NyvVLYcJpXpBG9vy5NtAW
   RTuKzXJgD/bBYRWL9InJa4DcBcgO6imcjv8NLmxRodDholSCkNs+BEsoS
   dcUo9g27r+B4CMgz/+jEUQGs0EhAPoDW/PaGVQq8diE2S5nJSt5ijIF0K
   liklGk4Gkz3tTGUi/54ubhU/JetzbJkLnpS0tRfll3ixr4dQMbsFf+hym
   Zna8OTEvtSVXV6xLq4aDmg6xUaAJCLIKshS/4OjQ5H7IifiWLUxbvQxMj
   hxlKnYjSjdrwGalvLonzfonbByDGP54PjgEVLH1kLQlb14w3cCZKKJAzw
   A==;
X-CSE-ConnectionGUID: W9TauyN9TeW0LwkQwKboow==
X-CSE-MsgGUID: CmHTuVfgQAO3g8BTCP96CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82988601"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82988601"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 02:48:38 -0700
X-CSE-ConnectionGUID: MXLmCZy4SperyKCaH8GJSA==
X-CSE-MsgGUID: DGnOq6mSRvK9V69SMz9Zcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="254572830"
Received: from unknown (HELO [10.238.2.81]) ([10.238.2.81])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 02:48:26 -0700
Message-ID: <6fc7f450-6d0a-494d-b295-297e4703148d@linux.intel.com>
Date: Tue, 23 Jun 2026 17:48:24 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 18/46] KVM: guest_memfd: Handle lru_add fbatch
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
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-coco@lists.linux.dev
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-18-9d2959357853@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-18-9d2959357853@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
> @@ -606,12 +608,20 @@ static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t start,
>  	next = start;
>  	while (safe && filemap_get_folios(mapping, &next, last, &fbatch)) {
>  
> -		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
> +		for (i = 0; i < folio_batch_count(&fbatch);) {
>  			struct folio *folio = fbatch.folios[i];
>  
> -			if (folio_ref_count(folio) !=
> -			    folio_nr_pages(folio) + filemap_get_folios_refcount) {
> -				safe = false;
> +			safe = (folio_ref_count(folio) ==
> +				folio_nr_pages(folio) +
> +				filemap_get_folios_refcount);
> +
> +			if (safe) {
> +				++i;
> +			} else if (folio_may_be_lru_cached(folio) &&
> +				   !lru_drained) {
> +				lru_add_drain_all();

It seems unprivileged userspace is able to trigger lru_add_drain_all() repeatedly
by invoking KVM_SET_MEMORY_ATTRIBUTES2 in a loop, which could lead to DoS risk?

> +				lru_drained = true;
> +			} else {
>  				*err_index = max(start, folio->index);
>  				break;
>  			}
> 

