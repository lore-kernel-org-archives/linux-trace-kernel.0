Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532C0365A0B;
	Tue, 30 Jun 2026 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832989; cv=none; b=vAmB9frnSmofYBaOQPLz2q5SCUU8AfnfmeoN6eaOhjM635aFYENG5wjRyPVO/vchbpxF2ONngRr8/PJIuHB7qBN/0zgZWgl4M4nMyjz6KU2z9hJkQe25Av1+I1CWm3Z18z44IrulrC7hqZDZ4Thjgn0pf1jpIu4rYBbXVrVX99U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832989; c=relaxed/simple;
	bh=mnhOZlEbmNxq5YsCTla36EPa18OakR+bG+jTvbDU7EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QEpVwiMe/qfO62U9HvuEZ+3Lv4pLd3W+kx0RwPfT/WFqpZGtQi2ldL4QPilbSq624sjN0RknBbvRdhF8vDqD39lUYI0NdtNOBN7sq9unn1g2LIaJJunpv32NWQHy2gFVeGcwCUzCC7FWotu5SXfkVybeCmALy3HZ4AJq2si50Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MHc1saCt; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MHc1saCt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782832988; x=1814368988;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mnhOZlEbmNxq5YsCTla36EPa18OakR+bG+jTvbDU7EM=;
  b=MHc1saCtMsiBF66Fg81f6NeGqR5kPocL6EBqbk7JMtVxhyzCaGzaiCNu
   K4hToOvkqG1nldxuyvxUADU7bLXxDVd+FncWUlt5vhbsWSOTCiYRydoHm
   nI+AtOsvVnIgZbRD78HBZzjD29t6SjSe6tMM7xZu3y7Y+utUbNDVt2tWZ
   V86GnJYPKH3CXFTpjG/Sm3iRjK4QeFvxJdx3Uhyxkm5u5kzV5pPjmsbAH
   GHHFnR79hhXJg5E4Nfu0M5kPqe1hUaZ12pu/RxD0AGPRmVuRMltAnAXrS
   IyhtMB4/xZpr0s16OqK4Yibs3k8/IJNHirUySwroFslhzlPF02Gn3sTyb
   A==;
X-CSE-ConnectionGUID: TqBX5rh4R+qB3nYFulFVLQ==
X-CSE-MsgGUID: B0anJVctRvmxLz0kjTY0xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94933094"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="94933094"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 08:23:07 -0700
X-CSE-ConnectionGUID: koRW/7MOQAWk92/0rXPmZQ==
X-CSE-MsgGUID: uXiMTSzqQL6ITT9qU5pf5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="254200312"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.232.239]) ([10.124.232.239])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 08:22:54 -0700
Message-ID: <a1b06afb-af6e-4666-8c7d-990e7fa150fa@intel.com>
Date: Tue, 30 Jun 2026 23:22:51 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/46] KVM: Rename memory attribute APIs to prepare for
 in-place gmem conversion
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
 <20260618-gmem-inplace-conversion-v8-7-9d2959357853@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-7-9d2959357853@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
> -bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> -				     unsigned long mask, unsigned long attrs);
> +bool kvm_range_has_vm_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> +					unsigned long mask, unsigned long attrs);
>   bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
>   					struct kvm_gfn_range *range);
>   bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,

We have

  - kvm_pre_set_memory_attributes()
  - kvm_arch_pre_set_memory_attributes()
  - kvm_arch_post_set_memory_attributes()

left, do they need to be renamed as well?

then the interesting one is kvm_vm_set_mem_attributes(), which contains 
"vm" already while it means "vm ioctl". Do we need to rename it to
kvm_vm_set_vm_mem_attributes()?

