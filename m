Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736593AA504;
	Thu, 30 Jul 2026 08:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399590; cv=none; b=oBogsAilI/P80feSow/1mwzh0+4VGDElZq/Cdjt0xUlByrPkHXoNtMOJAmfG2EDLljB46zhDLlmsLyuNeYFcfZEP0gU64FrNwVpmtFlF3Ug7Qy0/Lnpv/q/5AmUG84abOz3c1X2tlUyD53FtsR8eaDYRDu0sYq7eyAt+5CiG04Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399590; c=relaxed/simple;
	bh=wpfIrMcHN8QikkXCKITCLw0AA407+GAAoFiif3VfJc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1RILAYFplIkkbfRa009Xugi9dW+FFNA7OjN45E6BLxVtXIeJC5DptMKy9PdC8WpwrfMe1LrLRs7OWYU0IM83XzM0HQviCeb+v4vhFYXYs0mIz/AAiQQUA83z/AZ64DFpzCho9ILsGNsIDUg1U4di6xUHA7DXul5ZsFFyRcS+kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I3QOOEV7; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3QOOEV7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785399588; x=1816935588;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wpfIrMcHN8QikkXCKITCLw0AA407+GAAoFiif3VfJc0=;
  b=I3QOOEV73HGlKGqseDzRPfT+U48RxhP3u55EfFdnWEbRukk4HefA1bR8
   393wDOdrfKAgeJ8AP36M058z1p11k7c9Z5uifGckATHmmcG5Xiq7kbLCL
   Vy49AgiNj/uHKaNFt2f328Paopfr3EZnZBLeE9y12xEWLI0olqFJrY6Ew
   qFrsU1jS1A4S/ik6SoHuoC6V+r44BQj6mNJFZDqu08l1MEN1+XF62SxTC
   gnuBq+L77D9WEnyEuhlvxV6zaveszOtChlwmvMajRWWkdOpWcn4xnnZ/A
   0FuaZwfUOexmpLddbk34iAWz1e03sNBAuSWHi5IbTnsc3H0NK9Ha4oa4V
   g==;
X-CSE-ConnectionGUID: mqBI/tinTl6nf1kg+8s5Vg==
X-CSE-MsgGUID: Z6Vbqc7vT1+QLc+N48VI9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86091135"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="86091135"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 01:19:45 -0700
X-CSE-ConnectionGUID: 0mKvQIstRByDOckKXDh64w==
X-CSE-MsgGUID: iicRvDLaTO+wZke7z8GHMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="259664017"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.238.208.132]) ([10.238.208.132])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 01:19:34 -0700
Message-ID: <df06e0ec-9462-4072-a0c7-054f1978bf89@intel.com>
Date: Thu, 30 Jul 2026 16:19:30 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/41] KVM: Rename memory attribute APIs to prepare for
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
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-coco@lists.linux.dev
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
 <20260728-gmem-inplace-conversion-v9-4-35f9aec2aed2@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260728-gmem-inplace-conversion-v9-4-35f9aec2aed2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/2026 8:35 AM, Ackerley Tng via B4 Relay wrote:
> From: Sean Christopherson<seanjc@google.com>
> 
> Rename memory attribute APIs to add a "vm_" in the name in anticipation of
> moving PRIVATE tracking into guest_memfd, to allow in-place conversion
> between SHARED and PRIVATE.  At that point, there will effectively be two
> (potential) sources of memory attributes: the VM and guest_memfd.
> 
> kvm_vm_set_mem_attributes() already has "vm" in the name to indicate that
> it is a VM ioctl. Rename it to kvm_set_vm_mem_attributes() to show that it
> is setting the VM's memory attributes. (Drop the VM-ioctl scoping since it
> is a helper local to the file.) Update the accompanying trace function to
> match.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson<seanjc@google.com>
> Reviewed-by: Fuad Tabba<tabba@google.com>
> Tested-by: Shivank Garg<shivankg@amd.com>
> Signed-off-by: Ackerley Tng<ackerleytng@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
