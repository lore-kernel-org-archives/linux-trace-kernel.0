Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC4E369D63;
	Mon, 22 Jun 2026 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119320; cv=none; b=CMOroaBmPkKHURYSYFvXEYi2h0S/is5nG5ysxK1tl99jTAtyzLBsuVZt7hroZ3qo0r4d6wGFoIYXjqFpLQHYIcv/5i+9dAJSaLzpkdTNpOfh4JN+3KMqiMKLXlzRyGzdFahlLGw81rPtUwiDj4p7kuZHFMvV/n9i3CwJD6lco/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119320; c=relaxed/simple;
	bh=FXXp3XnnK+h7it17TWsBjNahQbzhpOBnqzH77Gg3oyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nb9yn0gLfeteVeaNEPhOr6vkCixeZVLCNLCzV09ldc+N8uzFcFhO+nD4XaCkJG1OstmcYXQIh1RTZEYovmQ8vFk6FG2DJewJRgylvaYxjX8yd+GrvWa28E4TYd1PhT1ImTyWLKwkX0uk+m2TfAmtoTweWOljnYnNNHaP0VEpYYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lmC6kglw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lmC6kglw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782119318; x=1813655318;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FXXp3XnnK+h7it17TWsBjNahQbzhpOBnqzH77Gg3oyY=;
  b=lmC6kglwX4TsU4z3XINIe74vfOsN0tgAz+3DqL4263Wppp5w4iwCVzOg
   vL/sxCtV7hHh7/WrXeKJJWakNQ1O0BaLHQ2b87qLVA7ZQYK7W0Kje73fV
   GF+6nmF4PBWaU29bSAWtXZzVOQobDOA7MV+D0dW6zokgOReDvIwnHyRHJ
   KMgH2JnS+lD8VQHtNjbJlnZaTaGMl3L8qkFd1agV2w+E/vSCrYW31yZHx
   sj0bxAYOfGh8MIATUYX0yuSr1c1OKUD3wPaSF6IHcQ7VPh3ZsMBvf7bLh
   9cLT8Ws+bsYwI65QDCvOotuEi7H82io+ib4o/ynTkVxNGRA0cbU60orJp
   g==;
X-CSE-ConnectionGUID: EtiThkM6SCqhqbRSGMAI4w==
X-CSE-MsgGUID: cDls0euuRKujL0p1x8O4Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="100396428"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="100396428"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 02:08:37 -0700
X-CSE-ConnectionGUID: 4ErWbjSDR3WHIlqXrzczlQ==
X-CSE-MsgGUID: sPY+aiHyTLWvSIqlDpESFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="248291517"
Received: from unknown (HELO [10.238.2.81]) ([10.238.2.81])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 02:08:24 -0700
Message-ID: <aceb07e1-77bc-49b6-a932-5fd9b5a21727@linux.intel.com>
Date: Mon, 22 Jun 2026 17:08:21 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/46] KVM: guest_memfd: Introduce per-gmem attributes,
 use to guard user mappings
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
 <20260618-gmem-inplace-conversion-v8-1-9d2959357853@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-1-9d2959357853@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:

[...]

>  
> +static u64 kvm_gmem_get_attributes(struct inode *inode, pgoff_t index)
> +{
> +	struct maple_tree *mt = &GMEM_I(inode)->attributes;
> +	void *entry = mtree_load(mt, index);
> +
> +	return WARN_ON_ONCE(!entry) ? 0 : xa_to_value(entry);

If the entry is unexpectedly missing, returning 0 means the attribute would be treated as shared.
And then in kvm_gmem_fault_user_mapping(), it would allow the userspace to fault in the folio.

Should gmem deny such edge case?

> +}
> +
> +static bool kvm_gmem_is_private_mem(struct inode *inode, pgoff_t index)
> +{
> +	return kvm_gmem_get_attributes(inode, index) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
> +}
> +
> +static bool kvm_gmem_is_shared_mem(struct inode *inode, pgoff_t index)
> +{
> +	return !kvm_gmem_is_private_mem(inode, index);
> +}
> +
>  static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>  				    pgoff_t index, struct folio *folio)
>  {
> @@ -397,10 +423,13 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>  	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
>  		return VM_FAULT_SIGBUS;
>  
> -	if (!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
> -		return VM_FAULT_SIGBUS;
> +	filemap_invalidate_lock_shared(inode->i_mapping);
> +	if (kvm_gmem_is_shared_mem(inode, vmf->pgoff))
> +		folio = kvm_gmem_get_folio(inode, vmf->pgoff);
> +	else
> +		folio = ERR_PTR(-EACCES);
> +	filemap_invalidate_unlock_shared(inode->i_mapping);
>  
> -	folio = kvm_gmem_get_folio(inode, vmf->pgoff);
>  	if (IS_ERR(folio)) {
>  		if (PTR_ERR(folio) == -EAGAIN)
>  			return VM_FAULT_RETRY;
> @@ -557,6 +586,51 @@ bool __weak kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
>  	return true;
>  }
>  
