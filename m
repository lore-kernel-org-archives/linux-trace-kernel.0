Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEB0471249;
	Tue,  1 Sep 2026 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256078; cv=none; b=spoaVjUFjQe+56sNjAd8nllLIE439kDgf7pDPBvege85kMYL6Tw42zRIz/KLGH28X2W7s/C6uXPj9LEQoU4+5mjdFG1qly4NKUqNepCXO5del8Inczqe1EaMNKDMDaoid7ptt+lhDo681tTsmjIlguWir4czcpAWdMw/zYxqQbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256078; c=relaxed/simple;
	bh=PqWpX5qzfJy+A/rydNLTfBbEMaehm3F4tTQxb73Ubm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQ+ks+orS6xpm24IBBYzJgli85o/7JIITN2+O5I+k82h2E8GdxCsD+hMaGb/xUzskamtBcBPFuY3fQNpWnhx9wUwTPua+kWSh1rXByj1ki3CeFXD7Bl1X2vRAiOqTDt481wNFta+sXR0i64H0egF19goM59Ylh1AVcrqojjd74c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DppYxOJz; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DppYxOJz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788256077; x=1819792077;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PqWpX5qzfJy+A/rydNLTfBbEMaehm3F4tTQxb73Ubm0=;
  b=DppYxOJz5o2DYe9cb2dpdung0brsnmbiV4ZjXOujHezRluqRnY0WqhKe
   bCNjpnQBQhh1dMHKQ8GiCdRTf7YWBoz3+mEQbsPdSO9uc4tQ5nKATnp0r
   n6RQHnyrDEm+NTrKKJDVlX1EXj52PlhkyFnyuUhZqbQJsGFIufYZU7lt2
   K3erSsvscCfmfMPj8KCyZ76RYlYiMMrvlGKjfVTMoUNEFSMzNK8+miGH0
   nPkpnHDivbtdBwmAw5ZQsZePxwvm5haN/Nnhgrt90hX+y3Y0iVRW6p4Ay
   6egSVFVVHmQDWeo/BlPw/94zy7kTw/v/2GuyFvWEPryuDKlBH8zdsS0ua
   g==;
X-CSE-ConnectionGUID: I7JeRyJlRT+bgVDoUEdt7Q==
X-CSE-MsgGUID: PRqjNat+RSSAfyQnnXZV/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="92546885"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="92546885"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 02:47:54 -0700
X-CSE-ConnectionGUID: fV2Zhz8TSAW2Arb2x6ej0w==
X-CSE-MsgGUID: 2maLF6D4Rr6e+knV4AZ/ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="307263818"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 02:47:40 -0700
Message-ID: <b5b02db8-2bd8-4952-8d35-5c0ecb664206@linux.intel.com>
Date: Tue, 1 Sep 2026 17:47:37 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 09/45] KVM: guest_memfd: Stub in ability to enable
 in-place shared<=>private conversion
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, brauner@kernel.org,
 chao.p.peng@linux.intel.com, david@kernel.org, jmattson@google.com,
 jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org,
 pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com,
 rientjes@google.com, shivankg@amd.com, steven.price@arm.com,
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
 Peter Xu <peterx@redhat.com>, tarunsahu@google.com,
 Randy Dunlap <rdunlap@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Fuad Tabba <fuad.tabba@linux.dev>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-coco@lists.linux.dev,
 Xiaoyao Li <xiaoyao.li@intel.com>
References: <20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com>
 <20260830-gmem-inplace-conversion-v12-9-85e5fd25252a@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260830-gmem-inplace-conversion-v12-9-85e5fd25252a@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/2026 8:25 AM, Ackerley Tng via B4 Relay wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Stub in global variable to enable in-place guest_memfd private<=>shared
> memory conversion, which will eventually be exposed to userspace via a
> module param, and wire up the __kvm_is_private_gfn() static call to the
> guest_memfd version when in-place conversion is enabled, i.e. when gmem is
> the sole authority on private vs. shared memory.
> 
> Cc: Fuad Tabba <tabba@google.com>
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

One nit below.

> ---
>  Documentation/virt/kvm/api.rst |  7 +++++++
>  include/linux/kvm_host.h       |  6 ++++++
>  virt/kvm/guest_memfd.c         | 26 ++++++++++++++++++++++++++
>  virt/kvm/kvm_main.c            | 12 +++++++++++-
>  4 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index e0430cc750c9e..90a29424c54c8 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6382,6 +6382,11 @@ KVM_SET_USER_MEMORY_REGION2, e.g. shared memory can be lazily mapped/allocated
>  on-demand.
>  
>  When mapping a gfn into the guest, KVM selects shared vs. private, i.e consumes
> +userspace_addr vs. guest_memfd, based on the state in guest_memfd, which is the
> +sole authority on private vs. shared memory.  See :ref:`KVM_CREATE_GUEST_MEMFD`
> +to find out more about the creation-time shared/private status.
> +
> +If in-place conversion is disabled, KVM selects shared vs. private, i.e consumes

Nit: i.e -> i.e.
>  userspace_addr vs. guest_memfd, based on the gfn's KVM_MEMORY_ATTRIBUTE_PRIVATE
>  state.  At VM creation time, all memory is shared, i.e. the PRIVATE attribute
>  is '0' for all gfns.  Userspace can control whether memory is shared/private by
> @@ -6429,6 +6434,8 @@ the state of a gfn/page as needed.
>  
