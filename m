Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429AA3D25D0;
	Tue, 25 Aug 2026 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645216; cv=none; b=VJY6Tj+/UaftA8OISKa/PJNBFF/Iboe/0yKhCG5YwtyN9NCTGkjmKxhEDAbKe5crjQez6hks49GCmI5DfKUCRCfRVBkFHfewyOuPY+M8HUp82mVm7zt/xFXoAHxhMxQOvzsIDvOjO07EAvjlKyaJm2M6YfFpwra9wwPzSmGCBlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645216; c=relaxed/simple;
	bh=30YZPOBuBOe+Np7Wv7h084Pal631E59jEro+sbTLKVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjlzKMjJTh1fiPxM3pzwUftIAbwMFy3R5R2AgzqAAaOBUiHLC9JrYZzpt5aF56v/Hkj+Auu7+BgUYD1V/lIczCB1tTF7cq44ucqC7NsL4nyWdvp1y6iK+czmXGbST7z38uXgbbOIEjU/0FmHGMR+veMP1haCDqo3nUk9crJHTFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nRQLwNHa; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nRQLwNHa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787645214; x=1819181214;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=30YZPOBuBOe+Np7Wv7h084Pal631E59jEro+sbTLKVU=;
  b=nRQLwNHawxN18NFXyBxpP8XCUUV1dRj9qcG+DfYK3Ku1DgIOryIVT60f
   WHewRsyizCdPJpn1DMtPD0SWuyOgDGoY7q9DTO3HvCTeV+SxgiZcpbGfl
   n5QSS6eiIh+eXueBzvXzXJT7LHUh/5dAuR35DAZ9wjPdjMx9noG4syP6t
   fpBH4GKKoGnZxgcmqQS0WkFvrbB4FCVcNHhxUwwjX7x9iJSvUPfTIJIJS
   ZqGDKH4f6qyEIFICPmjKOYC4EZ+ZDdOCD8+jCWFTJ9lVroeeHXwyyMFYV
   0arN4M6NE9k1+CBbYp7kooILJQuhwAlMdyktYXBYlkkO/t1xuOhQAx8Z1
   w==;
X-CSE-ConnectionGUID: lZiNCp1IScyU1MJtFe7hgw==
X-CSE-MsgGUID: YkUsRj1SSlatxjyVZ/YVdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="99628336"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="99628336"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 01:06:53 -0700
X-CSE-ConnectionGUID: a+HswYlATkmepGAtw+t6ow==
X-CSE-MsgGUID: RDsZmMluTTORAfJvfKMcxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="305453059"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 01:06:39 -0700
Message-ID: <5f7b62a1-957b-4a43-9a16-d06b3f916e84@intel.com>
Date: Tue, 25 Aug 2026 16:06:36 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 09/41] KVM: guest_memfd: Filter both shared and
 private when invalidating
To: Sean Christopherson <seanjc@google.com>,
 Ackerley Tng <ackerleytng@google.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>, aik@amd.com,
 andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org,
 chao.p.peng@linux.intel.com, jmattson@google.com, jthoughton@google.com,
 michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com,
 qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com,
 shivankg@amd.com, steven.price@arm.com, tabba@google.com,
 willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com,
 forkloop@google.com, pratyush@kernel.org, aneesh.kumar@kernel.org,
 liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
 <20260807-gmem-inplace-conversion-v10-9-2fc18ee6d3ba@google.com>
 <13ca60c6-e154-4397-8092-09f861e90fe0@kernel.org>
 <cbf5f7ca-a960-4fb8-a760-2d2794eb6864@arm.com>
 <CAEvNRgGOyQHnF_b8dk8E0d7_=CcwXtYUdU3ko7Qbep+_O7UC0Q@mail.gmail.com>
 <aoZZMQ3Uc8yQWPNA@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aoZZMQ3Uc8yQWPNA@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/2026 9:32 AM, Sean Christopherson wrote:
> On Mon, Aug 10, 2026, Ackerley Tng wrote:
>> Sean, do you know if looking up attributes in gmem to feed the KVM MMU
>> the smallest set of pages to zap will improve performance significantly?
>> Or if there's any other reason to do this lookup (more complexity in
>> gmem)?
> 
> While working through this with Ackerley, I realized this patch is buggy.  When
> in-place conversion is NOT supported, then as evidenced by the current code,
> invalidations are guaranteed to only affect one of SHARED vs. PRIVATE.  And if
> we change that to zap both, we risk overzapping.  I.e. it's not just the cost of
> the extra MMU walk, it could also be a functional bug.
> 
> Specifically, if KVM zaps both when SHARED vs. PRIVATE is tracked per-VM, then a
> PUNCH_HOLE operation on a PRIVATE guest_memfd will incorrectly zap SHARED mappings
> that have nothing to do with that gmem instance (because they're mapped via a VMA,
> not a gmem fd).  And vice versa, a PUNCH_HOLE on a SHARED gmem (if userspace is
> using an INIT_SHARED gmem for the shared branch of a memslot) could invalidate the
> PRIVATE mappings (of a different gmem instance).
> 
> That latter case in particular would be a functional bug, as spuriously zapping
> PRIVATE SPTEs is fatal to TDX (destroys the memory contents).
> 
> So, for the initial change, we want this (full patch below):
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 75979c885e03..8ff2ec148614 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -138,6 +138,9 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>   
>   static enum kvm_gfn_range_filter kvm_gmem_get_invalidate_filter(struct inode *inode)
>   {
> +	if (gmem_in_place_conversion)
> +		return KVM_FILTER_SHARED | KVM_FILTER_PRIVATE;
> +
>   	if (GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED)
>   		return KVM_FILTER_SHARED;
>   
> 
> And then in the main in-place conversion patch, have the conversion flow to only
> zap tap the "previous" types (with prep work as needed).  Ideally, that would be
> done *after* the main conversion patch, i.e. as an optimization, so that we get a
> nice bisection point if it's somehow buggy.  However, Ackerley pointed out that the
> conversion flow invalidates the entire range if the attributes of any gfn within
> the range is changing.  Addressing that would be rather annoying, e.g. there would
> need to be multiple invalidation ranges to deal with interpolated conversions,
> so going straight to a "zap only the previous" is probably the least awful option.
> 
> ---
> From: Sean Christopherson <seanjc@google.com>
> Date: Wed, 19 Aug 2026 18:06:38 -0700
> Subject: [PATCH] KVM: guest_memfd: Invalidate both SHARED and PRIVATE mappings
>   for in-place conversions
> 
> When removing one or more folios from a guest_memfd instance, invalidate
> both SHARED and PRIVATE mappings if in-place conversion is enabled, because
> stating the obvious, KVM needs to ensure that all mappings to the folio(s)
> are dropped.
> 
> Opportunistically rename the helper to capture that it returns the a filter
> for all gfns in anticipation of zapping only the previous mapping types on
> conversion.  I.e. when doing in-place conversion to PRIVATE, only SHARED
> mappings need to be zapped (ignoring that KVM would ideally not invalidate
> ranges whose attributes aren't changing in the first place).
> 
> Note, precisely zapping only the possible mapping types when in-place
> conversion is disabled is important for functional correctness, not just
> for performance.  Specifically, if KVM zaps both when SHARED vs. PRIVATE is
> tracked per-VM, then a PUNCH_HOLE operation on a PRIVATE guest_memfd will
> incorrectly zap SHARED mappings that have nothing to do with that gmem
> instance (because they're mapped via a VMA, not a gmem fd).  And vice versa,
> a PUNCH_HOLE on a SHARED gmem (if userspace is using an INIT_SHARED gmem
> for the shared branch of a memslot) could invalidate the PRIVATE mappings
> of a different gmem instance.  The latter case in particular would be a
> functional bug, as spuriously zapping PRIVATE SPTEs is fatal to TDX, as
> doing so destroys the contents of the memory.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   virt/kvm/guest_memfd.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 75979c885e03..7ae05ce3cd14 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -136,8 +136,11 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>   	return folio;
>   }
>   
> -static enum kvm_gfn_range_filter kvm_gmem_get_invalidate_filter(struct inode *inode)
> +static enum kvm_gfn_range_filter kvm_gmem_get_all_gfns_filter(struct inode *inode)
>   {
> +	if (gmem_in_place_conversion)
> +		return KVM_FILTER_SHARED | KVM_FILTER_PRIVATE;

If I understand correctly, above diff is dead code and will change 
according to

   And then in the main in-place conversion patch, have the conversion
   flow to only zap tap the "previous" types (with prep work as needed).

If so, why bother adding the change?

>   	if (GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED)
>   		return KVM_FILTER_SHARED;
>   
> @@ -188,11 +191,9 @@ static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
>   static void kvm_gmem_invalidate_start(struct inode *inode, pgoff_t start,
>   				      pgoff_t end)
>   {
> -	enum kvm_gfn_range_filter attr_filter;
> +	enum kvm_gfn_range_filter attr_filter  = kvm_gmem_get_all_gfns_filter(inode);
>   	struct gmem_file *f;
>   
> -	attr_filter = kvm_gmem_get_invalidate_filter(inode);
> -
>   	kvm_gmem_for_each_file(f, inode)
>   		__kvm_gmem_invalidate_start(f, start, end, attr_filter);
>   }
> @@ -344,7 +345,7 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
>   	 * memory, as its lifetime is associated with the inode, not the file.
>   	 */
>   	__kvm_gmem_invalidate_start(f, 0, -1ul,
> -				    kvm_gmem_get_invalidate_filter(inode));
> +				    kvm_gmem_get_all_gfns_filter(inode));
>   	__kvm_gmem_invalidate_end(f, 0, -1ul);
>   
>   	list_del(&f->entry);
> 
> base-commit: 620f8362aaec3848ee8f465949a0701175fe0896
> --

