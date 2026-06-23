Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099C338888E;
	Tue, 23 Jun 2026 03:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782184229; cv=none; b=nugJgZiZUQUcx15HGzCWpQ00Th3svTojLeaWAJHsyAyWmJhePQCgvBKJakctlIj2rAm2/sosebyyC6kIzanh9LpnlNBu+o8ufkMQBBKHX7amUxY3MCnDHQYFn2Plnl2+JgtZbwbE7tdZGn581RJP5EZkgAH9LuD7yprEfnGuIT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782184229; c=relaxed/simple;
	bh=FzB8Fb4p4Mjwmnh7oxOdArQm2a4Bl6t8IOGs1WP0LH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufCQaIBmfENmxZUKxWN++/biWVlTg31b/yVAgM4tVg6luJXWTEVwqSqvZ9yq3aZUgVKpvWwxYhmgsYa0DHHvVFVri3uStZJ6a7Uz4SG+Tj+MKTmZg+rbtc+bj8ldPCrK48EULGHcwYZ11H6h+I/WIiFhyhdmCrNpzZk0GxBF374=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BLl2Ug/e; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BLl2Ug/e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782184224; x=1813720224;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FzB8Fb4p4Mjwmnh7oxOdArQm2a4Bl6t8IOGs1WP0LH8=;
  b=BLl2Ug/eLj8p1uLirtLSh0KPVKuPz79n9xv/OeDHRYsBU3dRGdmatr3c
   tj/8RMSbSniF3stF0N267pPq1jw9uhz5HtGN98F3xziJDaDNOxAg3oDxs
   +dkY7LcQQVMnyDxN9TRKKhRdVyLl2JLPoUbu61nX2dfRAuvcM4Kw+Dix0
   gLBRYKma7fEnEjgA1GAkBYNPVtUP2R6JfGqNCfMguzDImuXit6BIuT1Wn
   WICJx03pjJ4Y2JMqj/IbbUnyv5JbPkBbctVOr7/0JhzVzHpuEsTqwl6Cp
   S0n7v8ant6cu8gMFBAhwNvWtNWabRp/Xz4HpPlGgRmEOac1H84k11MO2b
   w==;
X-CSE-ConnectionGUID: l/t3aqZrQROMQx24pH9cPQ==
X-CSE-MsgGUID: TTQXJxn3QvKAMpWYdGVJiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="100470615"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="100470615"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 20:10:22 -0700
X-CSE-ConnectionGUID: l6e4mZ83QTiXSvs+mWEwsQ==
X-CSE-MsgGUID: FX/cqQqIQeCB/GDWGdGDPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="254376571"
Received: from unknown (HELO [10.238.2.81]) ([10.238.2.81])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 20:10:09 -0700
Message-ID: <1c3d817b-e5d4-47fc-a716-3a8bd941375d@linux.intel.com>
Date: Tue, 23 Jun 2026 11:10:06 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/46] KVM: Enumerate support for PRIVATE memory iff
 kvm_arch_has_private_mem is defined
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
 <20260618-gmem-inplace-conversion-v8-6-9d2959357853@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-6-9d2959357853@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> Explicitly guard reporting support for KVM_MEMORY_ATTRIBUTE_PRIVATE based
> on kvm_arch_has_private_mem being #defined in anticipation of decoupling
> kvm_supported_mem_attributes() from CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
> guest_memfd support for memory attributes will be unconditional to avoid
> yet more macros (all architectures that support guest_memfd are expected to
> use per-gmem attributes at some point), at which point enumerating support
> KVM_MEMORY_ATTRIBUTE_PRIVATE based solely on memory attributes being
> supported _somewhere_ would result in KVM over-reporting support on arm64.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  virt/kvm/kvm_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 1ccc4895a4c26..7b989b659cf82 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2421,8 +2421,10 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
>  #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>  static u64 kvm_supported_mem_attributes(struct kvm *kvm)
>  {
> +#ifdef kvm_arch_has_private_mem
>  	if (!kvm || kvm_arch_has_private_mem(kvm))
>  		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
> +#endif
>  
>  	return 0;
>  }
> 

