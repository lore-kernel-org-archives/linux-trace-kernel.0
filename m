Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B25C409E12;
	Thu, 30 Jul 2026 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405501; cv=none; b=BgrOooJvEM8hrSvhd3X+t5PwOjb9Vj7D+LfyfwsfsmFPk7abIGEaoFuEj9z6yHmbKD7wsLAhWaaczhlvzUlYINix81tsELCvkFcddzo0jt7oGEEKZHdKX+sgleb0AKG+QI0JYycOvvTH/MrcpF6t5Ql+I5TP6RbYqxQoj+husuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405501; c=relaxed/simple;
	bh=jfFI1NumX8PLykOdxR0JzkYx01P6yXcIgS+lSqQphOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tO6YNqRXittZn7ICWN3It6R2jRxFTu7Z3hju6gK7Dv/815zcj4jVb5EgvvL3M8DVufjpDSHyF3ZC2HF4zUyIJltPULXr3YunHDIzvG06EfjqG66rLJNFSj/z8e5obRheiMMFcDFhX3Laob4Z+5XiSGCG+r1utzzF6e1Ew1K1CzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6pqvCS4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6pqvCS4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785405498; x=1816941498;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jfFI1NumX8PLykOdxR0JzkYx01P6yXcIgS+lSqQphOE=;
  b=h6pqvCS4Efivn20CNXwveoViC1SEUusGH6hX42d8xmP2SDXqZDmWnG68
   tl3eIZ0gUoVFbH3RebNJ5n6xv0CluvniVuZ+dTGZwk86As5ihG2/ls6RO
   ycpQGAk80H9S4k7jN38WAY7DqnLW4F7S+bAQTg7it6XLI1n1BugCHlvsg
   5tW9JB0JavQioMqqAxjnChLnHJVah9+60pEuTUvPwWNUEqW7f7cn5OY0c
   0c7e/cOQXHh4RL6th54twkYJUsIqvEpkp8Gwadvi5AXdrChXWigCAYZ1P
   BVhlkNrSpqwuRnpYs+8KKFEhKRwGH9xl9bfvOdcBV5TSOPhtfEXBLZNnM
   A==;
X-CSE-ConnectionGUID: MCcofGXgR4mBQLUcyQbyUQ==
X-CSE-MsgGUID: EoBgdGihSKGaxo8NAYYN5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86211547"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="86211547"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 02:58:17 -0700
X-CSE-ConnectionGUID: oS52XiaARmuPWXkloKb0ig==
X-CSE-MsgGUID: U5RpQ7eVQcaEsE41l48cdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="257576394"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.238.208.132]) ([10.238.208.132])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 02:58:00 -0700
Message-ID: <7dafaa90-f3d4-4be4-a5cc-472163f18040@intel.com>
Date: Thu, 30 Jul 2026 17:57:57 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/41] KVM: Enumerate support for PRIVATE memory iff
 kvm_arch_has_private_mem is defined
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
 <20260728-gmem-inplace-conversion-v9-3-35f9aec2aed2@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260728-gmem-inplace-conversion-v9-3-35f9aec2aed2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/2026 8:35 AM, Ackerley Tng via B4 Relay wrote:
> From: Sean Christopherson <seanjc@google.com>

Though the patch order and diff of this patch is adjusted to what looks 
in v7, per Sean's request [1], the changelog still looks somewhat 
confusing and part incorrect to me.

[1] https://lore.kernel.org/all/akVGZOeR1ytfkamK@google.com/

> Explicitly guard reporting support for KVM_MEMORY_ATTRIBUTE_PRIVATE based
> on kvm_arch_has_private_mem being #defined in anticipation of decoupling
> kvm_supported_mem_attributes() from CONFIG_KVM_VM_MEMORY_ATTRIBUTES.

As I commented in v8, the "in anticipation of" thing is not correct.

> guest_memfd support for memory attributes will be unconditional to avoid
> yet more macros (all architectures that support guest_memfd are expected to
> use per-gmem attributes at some point), at which point enumerating support
> KVM_MEMORY_ATTRIBUTE_PRIVATE based solely on memory attributes being
> supported _somewhere_ would result in KVM over-reporting support on arm64.

1. I'm not sure what "memory attributes being supported somewhere" means.

2. the kvm_supported_mem_attributes() will be renamed to 
kvm_supported_vm_mem_attributes() and it's still under the guard of
CONFIG_KVM_VM_MEMORY_ATTRIBUTES, what's relationship with "guest_memfd 
support for memory attributes"?

> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Tested-by: Shivank Garg <shivankg@amd.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>   include/linux/kvm_host.h | 2 +-
>   virt/kvm/kvm_main.c      | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 9f78a466c6f3e..c125d2e8155a7 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -722,7 +722,7 @@ static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
>   }
>   #endif
>   
> -#ifndef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> +#ifndef kvm_arch_has_private_mem
>   static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
>   {
>   	return false;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 902aa166c9c0c..9501dd8d015d1 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2421,8 +2421,10 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
>   #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>   static u64 kvm_supported_mem_attributes(struct kvm *kvm)
>   {
> +#ifdef kvm_arch_has_private_mem
>   	if (!kvm || kvm_arch_has_private_mem(kvm))
>   		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
> +#endif
>   
>   	return 0;
>   }
> 

