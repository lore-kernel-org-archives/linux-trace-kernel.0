Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0313F6C24;
	Tue, 30 Jun 2026 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816384; cv=none; b=NrWhaO46xL+8aqFUYnP6EFvo3lYCjG0BJj5gak9nB4Whn9o5U2Ef1v4vCKbXDWbv9H2mG1So0hKI7y0/WcRfW6tzoMFowtbKJJ0qCyy+Vm09n3lvF3tgwHSvPEP+54ovmj7eJ+6TddoBlubMMaumcxU0Q51h/ge9ERcD7g2gKYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816384; c=relaxed/simple;
	bh=ydIclReBsYd1/Q40BSDyaWtNirB1lFLBEoV1UQ/28ZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hakst+JU7A/7dWMnszcfHkWpMU8lH8Ud1UyYBHQ+X78qKe+rE6NdeIcyts3xlEczfUvxZ3F/c5lpJCVy7xiXRY8uckW6YnLNYwmcwrV4nY9AU0Qj3PozBDyX35TGM+jCIMywpYxIuEe7hZYcPNR6fOStcVfBXI9WJZ9/+4/uPsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gtM/IFl0; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gtM/IFl0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782816379; x=1814352379;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ydIclReBsYd1/Q40BSDyaWtNirB1lFLBEoV1UQ/28ZM=;
  b=gtM/IFl0xfUKYxV7PyzhtVN8sE+JyIyTkHGfWVYM3+mEoNJ58MoLx1Mw
   Frdc0LR+658KuA/QIYqhor8T8/eeHYk0AuKZh1d7SlIkYwuTq6KjbEgHa
   aaE/xhdfqr/k1TZrtG0ZVYhGsp2Z+AXNyToJGWM/n4GgE/6SqaWqTC4eb
   jK1kwJbzbnBhR4B5k6ObWnb/6UL68SR9qiMegZFwNJgLboZbd4J49eNZ7
   +vWNdaCB83E1sXEYYc+Pb+6CmSYlgF6YtEkgQcFouELrzeBP3yjJsHiI+
   EhvyD+CkiTPZzpwFoKY59LXn0bzTprNnBFhPcP3mSMaMofI9zEwJW1JDV
   A==;
X-CSE-ConnectionGUID: f69p6dk9TouSJTzczhHRsA==
X-CSE-MsgGUID: /0cef8X2RsuU0kNhEpo0tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94676844"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="94676844"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 03:46:13 -0700
X-CSE-ConnectionGUID: kIS6WMq4Rfum65TODXoe7A==
X-CSE-MsgGUID: q2IEDfAAQJKrOxUnJNZT+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="251179296"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.239.158.70]) ([10.239.158.70])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 03:45:57 -0700
Message-ID: <a22b7696-9923-470a-9696-4db40f80861c@intel.com>
Date: Tue, 30 Jun 2026 18:45:54 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/46] KVM: Move KVM_VM_MEMORY_ATTRIBUTES config
 definition to x86
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
 <20260618-gmem-inplace-conversion-v8-3-9d2959357853@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-3-9d2959357853@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
> From: Sean Christopherson<seanjc@google.com>
> 
> Bury KVM_VM_MEMORY_ATTRIBUTES in x86 to discourage other architectures
> from adding support for per-VM memory attributes, because tracking private
> vs. shared memory on a per-VM basis is now deprecated in favor of tracking
> on a per-guest_memfd basis, and while RWX memory attributes are on the
> horizon, they too are expected to be x86-only.
> 
> This will also allow modifying KVM_VM_MEMORY_ATTRIBUTES to be
> user-selectable (in x86) without creating weirdness in KVM's Kconfigs.
> Now that guest_memfd supports in-place conversions, it's entirely possible
> to run x86 CoCo VMs without support for KVM_VM_MEMORY_ATTRIBUTES.
> 
> Leave the code itself in common KVM so that it's trivial to undo this
> change if new per-VM attributes do come along.
> 
> Signed-off-by: Sean Christopherson<seanjc@google.com>
> Reviewed-by: Fuad Tabba<tabba@google.com>
> Signed-off-by: Ackerley Tng<ackerleytng@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
