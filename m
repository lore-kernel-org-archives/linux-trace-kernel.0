Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F07F390C85;
	Fri, 31 Jul 2026 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488255; cv=none; b=cEmhsWqKkZOEKqntFGlPe9zgEuwef+470vnngmR17Ieh4XRsHPwRlr1PSO0zD6BZSp0tlKn7U9Vfvw7BI2S/u4oMp/meEETRWh35wPRVpGXdxOUag25+prD8oiwbWzyU85ngO8nSBn2S1jswBN3fkCz15m1HFwV499GmD++QZsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488255; c=relaxed/simple;
	bh=1b87pWmuiWigK1wPtNTyW7rMpkhrK9XpARbjh2u7/PY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QBe0LWZnLM+E9Ous+PeShv/qDSPPgDLze6wVzY1swli55eDSIIoNkr9abtwsbICdHBeV496AvgbXxurckkPTPGc8STWItCo0QHjGdjjK9pmXz5+kEC9g3oyWjdkkDmT4VYP4/L+SpZpueTrnYYsCp/lWCIXubqB+H7GyQZkBeBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aw5s8MJG; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aw5s8MJG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785488255; x=1817024255;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1b87pWmuiWigK1wPtNTyW7rMpkhrK9XpARbjh2u7/PY=;
  b=aw5s8MJGfXsoP382n7VNNcFxiZvjRJWrs3xRExx00XFzPhbf7BCJwu79
   M6rEukLPssyoel8BxlsZnyk+FKYAnmxddLw1cppDuFBz+OgZwiFu53fWY
   i5IWE+D280Xr1pYcu0/JFqgpZjFAySWWZnwNuLsoZAT893UBbE1vozNLi
   g0FKGKnnriK0MF1+1nkI2tsGFQFvMnFgXtp40onuArblKYgaomnClE2fl
   xEGAwZtHWbI7lni7ac+3sLS8f1gqCFzo2j5Moh/yW3inY70Qzhh8pFjOH
   9p3NuhkmBPLi9n6zyvpH3A6KXt1ek36mgmBpIOpmyWj+ytg2jlWDqzTVH
   A==;
X-CSE-ConnectionGUID: I/Umm3QLQH+Z/QKKVbGJ7g==
X-CSE-MsgGUID: dfjyr33qS/CR4RWtwfPpOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="86063906"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="86063906"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 01:57:34 -0700
X-CSE-ConnectionGUID: w/eqajcFTA22UWQ2rzow+g==
X-CSE-MsgGUID: HP5ylDh8QcWlI7vAtQHsxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="283856796"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.248]) ([10.124.240.248])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 01:57:18 -0700
Message-ID: <b78bfee9-29f3-4044-8ac7-f294b3cd0ad8@intel.com>
Date: Fri, 31 Jul 2026 16:57:15 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/41] KVM: guest_memfd: Introduce per-gmem attributes,
 use to guard user mappings
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
 <20260728-gmem-inplace-conversion-v9-1-35f9aec2aed2@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260728-gmem-inplace-conversion-v9-1-35f9aec2aed2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/2026 8:35 AM, Ackerley Tng via B4 Relay wrote:
> From: Sean Christopherson<seanjc@google.com>
> 
> Start plumbing in guest_memfd support for in-place private<=>shared
> conversions by tracking attributes via a maple tree.  KVM currently tracks
> private vs. shared attributes on a per-VM basis, which made sense when a
> guest_memfd_only_ supported private memory, but tracking per-VM simply
> can't work for in-place conversions as the shared/private status of a given
> page needs to be per-gmem_inode, not per-VM.
> 
> Use the filemap invalidation lock to protect the maple tree, as taking the
> lock for read when faulting in memory (for userspace or the guest) isn't
> expected to result in meaningful contention, and using a separate lock
> would add significant complexity (avoiding deadlock is quite difficult).
> 
> Co-developed-by: Vishal Annapurve<vannapurve@google.com>
> Signed-off-by: Vishal Annapurve<vannapurve@google.com>
> Co-developed-by: Fuad Tabba<tabba@google.com>
> Signed-off-by: Fuad Tabba<tabba@google.com>
> Signed-off-by: Sean Christopherson<seanjc@google.com>
> Tested-by: Shivank Garg<shivankg@amd.com>
> Co-developed-by: Ackerley Tng<ackerleytng@google.com>
> Signed-off-by: Ackerley Tng<ackerleytng@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

<...>

>   static __always_inline struct gmem_inode *GMEM_I(struct inode *inode)
> @@ -60,9 +68,25 @@ static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
>   	return gfn - slot->base_gfn + slot->gmem.pgoff;
>   }
>   
> +static u64 kvm_gmem_interpret_entry(struct inode *inode, void *entry)

Ummm, I'm not sure on the name. It doesn't look like KVM's style?

Maybe, just kvm_gmem_get_attributes()?

> +{
> +	if (WARN_ON_ONCE(!entry)) {
> +		bool initially_shared = GMEM_I(inode)->flags &
> +					GUEST_MEMFD_FLAG_INIT_SHARED;
> +
> +		return initially_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE;
> +	}
> +
> +	return xa_to_value(entry);
> +}

