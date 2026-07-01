Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1BE3B14C6;
	Wed,  1 Jul 2026 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782893142; cv=none; b=uqiyMRH76Ku3aB67QkH5z2Bbsy4O+airmFZvIIe+d9eaNZ4MVsNXzVlzxk6Qn1yd+KFbaLRs3Vgi+JMqEgZmZQpmMhjFInLdFAz90Ib/Mt2p0thW7iWYO0wNdoH4pdnmG/w/KhR+ELLMSZPT2ZXkMXS0GKmOYUr5HEv99ScYkbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782893142; c=relaxed/simple;
	bh=DP0eg4B0OM8TO8XnS8C6gHlWxSavTjQl03mk/DOj9RE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3ZIxQPx92l8bZuMB158lw1IPu0mq715AjPCOzWV7Yn8XkIZoLgw2ULu2wsXaZXJG6fbtZpeTXoGdOB+BJzZWqqDpUgajsY/SkQaxzrfq8hs0iro4/1fni0e0hbvEzT4Zcd7stP6k23/dKszWQSGJpgF3Q7985uI0qU5z+iusSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQnMfZY0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQnMfZY0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782893139; x=1814429139;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DP0eg4B0OM8TO8XnS8C6gHlWxSavTjQl03mk/DOj9RE=;
  b=FQnMfZY00VYPxz8UpUgTtZallSt5HLZjXvQLkIj4CZE9Xhaj6rSkI5e5
   lvSBLjLLeDzMpZcP/8RaPMx1reZKbmKqxCH4QmCOcyM3WNzRKZUzBc1i+
   IWNo1OIo0QXVyHQnVEayNSfOIg+cp/5Bxn2NNcqSQnpAwLCaMWmugIdvu
   HRP0kNWN+3qiU5D+6h2lejaHT8Hf0eiBIP8Vwj6AZ0bavlZR/NOHmcmok
   q/c5JnE1/PWTJid4Bj8sAVi5A8/gOx+DkmgCX5tg1O96fizfOVNbvReFa
   KlMckIPpFNf92j7LsSH+1zoR35IorV2anSD1/iscz8HnJqIjyPS1n+rsO
   A==;
X-CSE-ConnectionGUID: l98uhD6OSMS9e2lcfhniWg==
X-CSE-MsgGUID: 5TgCtMTJSB2FxG9MwSPVyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="94217852"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="94217852"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 01:05:26 -0700
X-CSE-ConnectionGUID: lVWuAtoZRb+S8bw6cD6rzw==
X-CSE-MsgGUID: G3cj1NKaRzaUjG0LX4qnIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="257401196"
Received: from unknown (HELO [10.239.158.49]) ([10.239.158.49])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 01:05:04 -0700
Message-ID: <3b64e897-93a8-4f9c-88a9-f416ff44b09d@intel.com>
Date: Wed, 1 Jul 2026 16:05:00 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/46] KVM: guest_memfd: Only prepare folios for
 private pages
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
 <20260618-gmem-inplace-conversion-v8-12-9d2959357853@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-12-9d2959357853@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> All-shared guest_memfd used to be only supported for non-CoCo VMs where
> preparation doesn't apply. INIT_SHARED is about to be supported for CoCo
> VMs in a later patch in this series.
> 
> In addition, KVM_SET_MEMORY_ATTRIBUTES2 is about to be supported in
> guest_memfd in a later patch in this series.
> 
> This means that the kvm fault handler may now call kvm_gmem_get_pfn() on a
> shared folio for a CoCo VM where preparation applies.

I don't get it clear why preparation isn't needed or should not be 
performed for shared folio.

Before this patch, userspace VMM can create the gmem with FLAG_MMAP and 
FLAG_INIT_SHARED. And KVM always faultin the pfn from gmem. In this 
case, the gmem is always shared, and kvm_gmem_prepare_folio() is always 
called when faultin from gmem. So it's OK to call preparation for shared 
folio, right? Then what is the actual reason we cannot do it now?
