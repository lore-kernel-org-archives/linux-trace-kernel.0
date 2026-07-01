Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF8246AED1;
	Wed,  1 Jul 2026 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904734; cv=none; b=elMn/x79wMJ5UyMSj+4x67THzv9j5Q8KS9iry7M7CWGhRlkFpvILiJf0jsVfJpJYrSVm53OKN3VyHkzUb/R450jS1qsROYKu6HX+sjeBOyuV86rumqFd4o13IV3uGSCPU7VtwWGqiyxcAGsm9m1Xhc94idaPXJ+cFeUOSNGAXh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904734; c=relaxed/simple;
	bh=KamIF/GbQilflin+sZ24rcVjwHbCunBsl6fGoIU62PA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPsf36bdNNdRJmlagAJ4grMkf38KL0r9m9rFwNILZOOcOeyKjFVIqynuvZ3X0OCbC7IUm5w/+kkOukyDwG3l2SVDGhfgdm1KhbtXlZF2kjPK4vgdiT3pXVuL1ghPgpSZEvtmF7X5emBJHOgFkRsiUsfzpvixy1hxyE2zFHoPXuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dndkJ/bV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dndkJ/bV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782904732; x=1814440732;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KamIF/GbQilflin+sZ24rcVjwHbCunBsl6fGoIU62PA=;
  b=dndkJ/bVaRCVaQzTmC4eOUHdIbDPWWipZbV2aOIFYUgA3LgEp7wbC2Fe
   OTGygtlSlA3cku7q9IDPHGtQHg1LhhPkV+mMTsu0vHiqdjoGIOEeinfOU
   F7J0MdA+MbLru1MYrhn3i6lGH74iehhi0xHrOqIiTDF2tMT5KxniTXYeW
   SH3fMovFU6YfEHDi1hs6TSVIr4qhVIHpTFQAlXnhBC4b8uIooM4d/2RTS
   pK3lYsmvyMHbkpeD8y6znLxMDdoJaR3xNI89uo879LcuEZStJbns8ne45
   TIZpG43M44JFaLjHjjiPMXDyo9ETzkM+SxBrDUD4WUgzsiEqQmVStfr9P
   g==;
X-CSE-ConnectionGUID: dmsaC05wSCGtx9ZNbqtT8A==
X-CSE-MsgGUID: OYdVayxLQl2wHyN9HqHIEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="94789715"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="94789715"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 04:18:50 -0700
X-CSE-ConnectionGUID: aLlyHiwUTXyhs4lgY+f9QQ==
X-CSE-MsgGUID: bSTU4KQCQOiPSgzMr577Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="256461895"
Received: from unknown (HELO [10.239.158.49]) ([10.239.158.49])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 04:18:31 -0700
Message-ID: <ec45ccb5-e219-4e5e-969a-127c6166fd27@intel.com>
Date: Wed, 1 Jul 2026 19:18:27 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 25/46] KVM: guest_memfd: Enable INIT_SHARED on
 guest_memfd for x86 Coco VMs
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
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-coco@lists.linux.dev
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-25-9d2959357853@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-25-9d2959357853@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/2026 8:32 AM, Ackerley Tng via B4 Relay wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Now that guest_memfd supports tracking private vs. shared within gmem
> itself, allow userspace to specify INIT_SHARED on a guest_memfd instance
> for x86 Confidential Computing (CoCo) VMs, so long as in-place conversion
> is enabled, i.e. when it's actually possible for a guest_memfd instance to
> contain shared memory.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   arch/x86/kvm/x86.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 2fde594e86d72..57a543dadb851 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -14116,14 +14116,15 @@ bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
>   }
>   
>   #ifdef CONFIG_KVM_GUEST_MEMFD
> -/*
> - * KVM doesn't yet support initializing guest_memfd memory as shared for VMs
> - * with private memory (the private vs. shared tracking needs to be moved into
> - * guest_memfd).
> - */
>   bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
>   {
> -	return !kvm_arch_has_private_mem(kvm);
> +	/*
> +	 * INIT_SHARED is supported if in-place conversion is enabled, or if
> +	 * the VM doesn't support private memory.  If the VM has private memory
> +	 * and in-place conversion is disabled, then guest_memfd can _only_ be
> +	 * used for private memory.
> +	 */
> +	return gmem_in_place_conversion || !kvm_arch_has_private_mem(kvm);
>   }
>   
>   #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
> 

