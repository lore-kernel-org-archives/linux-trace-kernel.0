Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8443D9680;
	Wed,  5 Aug 2026 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785919895; cv=none; b=DtUM0ExM/Tdk3tWrmZLXSs4D9gg7JNHuXl7YE3xsUVfEFLZSJpYuH8K3soqsIZvO7tM6k7k/zEXxQ6ZBBe2zUQDo9AgUv9XOKMQd5NfB2VfaD6yOgVwxYIfpW3oy6phBhPKpIY/+b3M1Yfa72D9qCKr4q26xF10wNa4BBxmkfms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785919895; c=relaxed/simple;
	bh=906UFDydbGu9lslP/ICAwTRGBdF+G9rFbkPozEz0hlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9r02/hZzZ/yFRY+l4eRaIz8jYz9Nt8sKg3kBAWvQeXH9H8zX0UTGok8x7WDW0egCIouhh5/ejHKTy4Pa2zEspUXJPdgeYVrN2woUNkAdk7/wjSaNblXtYASFXzZyZBGOpU6Cr35YiZ7wL5WOSJb4Sa54rEQHOGxh5WkrNnn4AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CdykzEKh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CdykzEKh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785919893; x=1817455893;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=906UFDydbGu9lslP/ICAwTRGBdF+G9rFbkPozEz0hlg=;
  b=CdykzEKhc42+Nti0stbtS7X1dG29jphW6pF+dAHEAM4K2QrX2MqAkCoI
   qVPSeiUXmcIQO9MfMVW/fACheBjLzzXaux6s4RnG4zozbYYuCaeamd3eW
   xeqpcR1P8bFW0xqkbqLtWKFkU6nu+VxliDxec6Hv0d2nMoWFfQ1bk8fgg
   yRv7t7ua0TiLjr1VbOWSlJnS9G7myuPTGoSoQ/jmkfQQTTD8Q/jhq706X
   qk8oOpE1aG/6p5xbC4egWaX3tgCn88I5CdQvU0GOlVAe84A/9lJ17yuog
   XkT8KPw5yg+ABFRz6egyynJ8KPcCLTl6A43Mp5hGt2EJ4zL13LhEmbMuA
   Q==;
X-CSE-ConnectionGUID: Rqx5RGBeQ+63N3qA/+2XRQ==
X-CSE-MsgGUID: rxxCj8zgQmeXKyfEpKawYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86603454"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="86603454"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 01:51:32 -0700
X-CSE-ConnectionGUID: xl8+sgnqTkGG1UwygjFcIw==
X-CSE-MsgGUID: MdQoRWnhTqKbstjwpzVllg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="259988166"
Received: from fuxiaogu-mobl1.ccr.corp.intel.com (HELO [10.238.208.47]) ([10.238.208.47])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 01:51:20 -0700
Message-ID: <b9ad1a1d-c167-4adb-980b-90096515a363@intel.com>
Date: Wed, 5 Aug 2026 16:51:17 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/41] KVM: Enumerate support for PRIVATE memory iff
 kvm_arch_has_private_mem is defined
To: Ackerley Tng <ackerleytng@google.com>, aik@amd.com,
 andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org,
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
 Peter Xu <peterx@redhat.com>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-coco@lists.linux.dev
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
 <20260728-gmem-inplace-conversion-v9-3-35f9aec2aed2@google.com>
 <7dafaa90-f3d4-4be4-a5cc-472163f18040@intel.com>
 <CAEvNRgG3qXrG2ix2MEcyVo0GXaen-Pte4gFAwEN+9AY=VtGU5w@mail.gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CAEvNRgG3qXrG2ix2MEcyVo0GXaen-Pte4gFAwEN+9AY=VtGU5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/2026 4:34 AM, Ackerley Tng wrote:
> I think another way to phrase this is that if we don't make this change,
> say, on the foo architecture where there's no CoCo and no private mem
> support, kvm_supported_mem_attributes() would return true for the !kvm
> case, which is over-reporting.

Under the condition that the foo architecture enables 
CONFIG_KVM_VM_MEMORY_ATTRIBUTES.

> How about this, replacing the entire changelog paragraph above:
> 
>    Explicitly guard reporting support for KVM_MEMORY_ATTRIBUTE_PRIVATE
>    based on kvm_arch_has_private_mem being #defined. This improves
>    reporting accuracy by not reporting support for
>    KVM_MEMORY_ATTRIBUTE_PRIVATE when kvm_supported_mem_attributes() is
>    called with kvm == NULL.

It doesn't help for the case where kvm == NULL, but help for the case 
where CONFIG_KVM_VM_MEMORY_ATTRIBUTES is defined but 
kvm_arch_has_private_mem not.

sorry for being picky. I think we can say

This improves the reporting accuracy by avoiding the case where 
KVM_MEMORY_ATTRIBUTE_PRIVATE is reported when kvm == null even without 
kvm_arch_has_private_mem being #defined.

>    Give architectures full control over overriding the default definition
>    of kvm_arch_has_private_mem() by removing the coupling with
>    CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
> 
>    In a later patch, kvm_arch_has_private_mem() will be defined based on
>    whether architectural features are compiled in, and made orthogonal to
>    CONFIG_KVM_VM_MEMORY_ATTRIBUTES.

