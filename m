Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865F8346A04;
	Fri, 14 Aug 2026 05:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786684717; cv=none; b=omiDrswumaSrjXLBoPBlQKC1QQyFg9LFdHv9DxmfjneJwHH8Pt/SLpFWV/hpDW2phLDa/oFgT7fRKorrg5wKTszsT5ItHEIvzVqx3EB1+i3LNBmLdMjlVhwTYaBZIrAzKid3KW+APknNK5K3QPmNXwJl8G5O56xBud1R87ZPA8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786684717; c=relaxed/simple;
	bh=+MUxfRWOkqREAuoekA780+CfxxKTEqlm5E/NKiwihFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EqP04Dc8rKKALwPXMed/HPrSR7MmaRdN86c/QccuQzeEm1MUCYdh2vxkSvmP4mq2PxKAyUGIxW/q2oifs1teLhlEp2Hjwtf/ENHoeuD+T9JxA67e9cuJSoA7AcEEbP3bc0Nn8oXkp+LNXf4DCXRk09M4zbrEHGRKJ8f8tV/cXKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P1kHph+z; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P1kHph+z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786684715; x=1818220715;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+MUxfRWOkqREAuoekA780+CfxxKTEqlm5E/NKiwihFE=;
  b=P1kHph+zrCFpTLxg8CIkAkdkjhiuKSHXRCYAK7lTE1/8HU0mB3OVubg1
   2BAytgo0YmAoX+4n5xlaij/qwnDx4IryD0Ek9UF0G6KWfHYT+H8IjLDPH
   FKjUzluaZ5kbA9cMujrKMwoZQ2P/yv8t7Y+28wvFaYI+VwOIPX5GZxkwI
   gW4+53d/MqJCRuTXV4B7yjUGbFvhDXz3rRoiLYoPtmuse4JjeTqRzRoOG
   4mOGkwwf0/SD65ZExxbTNOr2+q9UtUlXrdxHPLg9VpxJWXWp8iIRv6Aof
   /cSEp+j909mfj7JlnI7TIUJDAKbK8BRMn4mir1HlY4+BLfs21mAUs1W5I
   w==;
X-CSE-ConnectionGUID: Z3Veuck/TZeR6EpD4DSAaw==
X-CSE-MsgGUID: 5M++MCpnSomnIdFo8yQZsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87481113"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="87481113"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 22:18:34 -0700
X-CSE-ConnectionGUID: IN/b0L//SVCz/TGsloL3PQ==
X-CSE-MsgGUID: VWlRvfb+T1OqDKsfu60fhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="266117899"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 22:18:20 -0700
Message-ID: <645af2bd-2791-473a-9441-40db01f58913@linux.intel.com>
Date: Fri, 14 Aug 2026 13:18:17 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 16/41] KVM: guest_memfd: Zero page while getting pfn
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
 <20260807-gmem-inplace-conversion-v10-16-2fc18ee6d3ba@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260807-gmem-inplace-conversion-v10-16-2fc18ee6d3ba@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/2026 5:52 AM, Ackerley Tng via B4 Relay wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> Move the folio initialization logic from kvm_gmem_get_pfn() into
> __kvm_gmem_get_pfn() to also zero pages if the page is to be used in
> kvm_gmem_populate().
> 
> With in-place conversion, the existing data in a guest_memfd page can be
> populated into guest memory through platform-specific ioctls.
> 
> Without first zeroing the page obtained using __kvm_gmem_get_pfn(), it
> might contain uninitialized host memory, which would leak to the guest if
> the populate completes.
> 
> guest_memfd pages are zeroed at most once in the page's entire lifetime
> with guest_memfd, and that is tracked using the uptodate flag.
> 
> Zeroing the page in __kvm_gmem_get_pfn() is chosen over zeroing in
> kvm_gmem_get_folio() since other flows, such as a future write() syscall,
> can get a page, write to the page and then set page uptodate without
> zeroing.
> 
> This aligns with the concept of zeroing before first use - the other place
> where zeroing happens is in kvm_gmem_fault_user_mapping().
> 
> Don't mark the page uptodate again after populating, since the page would
> already be marked uptodate before the post_populate() call.
> 
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Tested-by: Shivank Garg <shivankg@amd.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  virt/kvm/guest_memfd.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 030af0855f8b0..41950c8105b5d 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -1079,6 +1079,11 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
>  		return ERR_PTR(-EHWPOISON);
>  	}
>  
> +	if (!folio_test_uptodate(folio)) {
> +		clear_highpage(folio_page(folio, 0));
> +		folio_mark_uptodate(folio);
> +	}
> +
>  	*pfn = folio_file_pfn(folio, index);
>  	if (max_order)
>  		*max_order = 0;
> @@ -1108,11 +1113,6 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  		goto out;
>  	}
>  
> -	if (!folio_test_uptodate(folio)) {
> -		clear_highpage(folio_page(folio, 0));
> -		folio_mark_uptodate(folio);
> -	}
> -
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
>  	if (kvm_gmem_is_private_mem(file_inode(file), index))
>  		r = kvm_arch_gmem_make_private(kvm, gfn, *pfn,
> @@ -1159,8 +1159,6 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	}
>  
>  	ret = post_populate(kvm, gfn, pfn, src_page, opaque);
> -	if (!ret)
> -		folio_mark_uptodate(folio);
>  
>  out_put_folio:
>  	folio_put(folio);
> 

