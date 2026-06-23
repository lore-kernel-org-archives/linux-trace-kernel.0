Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B033A3E67;
	Tue, 23 Jun 2026 05:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192342; cv=none; b=u1qfz/l3vPJg7RfmEtWx0oY54OHeG6RkCWytsFjpXKeqJnMk3tozRdSKFn6v2nPJ7gECiYcK/JQk9vaQ8oOF5Kza2dhT8coqJ2zpJORyY9v7TCEBrEjp+H7ATpTI8nLEH8CPCTCKdbmb4+01qZJHN51Ts6xgGCg3kwgk30LACs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192342; c=relaxed/simple;
	bh=Uq5PeCcyAK+bL5pMg1ybj6yxp4BAEe7DhiVVYVptiko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rf5b3U1Dt5a4zL+eAtBVGEVlO42NDEwLQwMz+Au/K7CZrHPS1GUZVy2w9+CpepKdGf+C4s0tY2yBSw2eglZ6RmksCU2u/MHyNgPnD/8CzVlXjb6atkbuodTNxtFlJXwAogBMxG3Oq8zfNcpPPdIqTdGYEWUu8GDup7vx93EvNww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BgvzCYVT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BgvzCYVT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782192341; x=1813728341;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Uq5PeCcyAK+bL5pMg1ybj6yxp4BAEe7DhiVVYVptiko=;
  b=BgvzCYVT7WekwkghBtpcD1qh2JYOV8asN7CSeE4a0wEjhWbnjOQSZejL
   dtYHLbQvujqFcyXFqqLJLK/sEk4b8mYRH7x48vvadqeBxTuAhI14vBYBs
   bqOdUKXjF1DzbStpCPw0f6KxGdaBDnvIB+YYQLJ6xumGDcQaAgZX172fj
   8egJBTf4c8Xx0ycpbqOJzQIMEZEgzazZRfptbfZ4D+09MHa30zAMQ7LrQ
   j7JK7Kse6NYefL+Xe5oEPq4z9S0riyVLJLkNbOwa2DwWVP/aOXgEYdeto
   JRUtManq0SXxpIXz3q2vePFR6EuQ881u1m75dFdkoi068A/rTaoS0kU/u
   A==;
X-CSE-ConnectionGUID: uNk5dytXQHiYMnaEYhhnzw==
X-CSE-MsgGUID: J3dTFPg3RT+es+zT7QTH/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="86834044"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="86834044"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 22:25:40 -0700
X-CSE-ConnectionGUID: +QKs7F9+Ru2ErBNCyvGNzg==
X-CSE-MsgGUID: MlbtBeXQTPSGpda7Y/yfxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="245058541"
Received: from unknown (HELO [10.238.2.81]) ([10.238.2.81])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 22:25:26 -0700
Message-ID: <1b59fec2-a464-4429-8532-880394912af5@linux.intel.com>
Date: Tue, 23 Jun 2026 13:25:24 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/46] KVM: guest_memfd: Introduce function to check
 GFN private/shared status
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
 <20260618-gmem-inplace-conversion-v8-9-9d2959357853@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-9-9d2959357853@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> Introduce function for KVM to check the private/shared status of guest
           ^
Nit:       a
 > memory at a given GFN.
> 
> This will be used in a later patch.

[...]

>  
> +bool kvm_gmem_is_private(struct kvm *kvm, gfn_t gfn)
> +{
> +	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
> +	struct inode *inode;
> +
> +	/*
> +	 * If this gfn has no associated memslot, there's no chance of the gfn
> +	 * being backed by private memory, since guest_memfd must be used for
> +	 * private memory,

"guest_memfd must be used for private memory" is a bit confusing to me.


> and guest_memfd must be associated with some memslot.
> +	 */
> +	if (!slot)
> +		return 0;
> +
> +	CLASS(gmem_get_file, file)(slot);
> +	if (!file)
> +		return 0;
> +
> +	inode = file_inode(file);
> +
> +	/*
> +	 * Rely on the maple tree's internal RCU lock to ensure a
> +	 * stable result. This result can become stale as soon as the
> +	 * lock is dropped, so the caller _must_ still protect
> +	 * consumption of private vs. shared by checking
> +	 * mmu_invalidate_retry_gfn() under mmu_lock to serialize
> +	 * against ongoing attribute updates.
> +	 */
> +	return kvm_gmem_is_private_mem(inode, kvm_gmem_get_index(slot, gfn));
> +}
> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_is_private);
> +
>  static struct file_operations kvm_gmem_fops = {
>  	.mmap		= kvm_gmem_mmap,
>  	.open		= generic_file_open,
> 

