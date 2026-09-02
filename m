Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C1F385D9C;
	Wed,  2 Sep 2026 06:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328973; cv=none; b=lQNqKVvf+SweNdSGiyPT+A9UZLQEEUW9psMe33H8pfetwp0sPzjjUFQuaLUca5lSnV9hxFiZcBodHu5NLppRPP0wapp2xHmmk2+L6XuFzoMOIe/Sguq90YHe+wMN3D8kYTyO7oi9BnKRjGhKjB6ceIjYD9AelLOECWI0hFo7fGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328973; c=relaxed/simple;
	bh=ZsQIcqiHQLyH2DKVUpBoYLA6XTARs4g/JsX3IormNF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vrck1boerbj0BDjL+yA8gak9J0uQ59FV/w58G8TXbEbeRVLsMJroNfYFowRRzAobdx9pFmxHct31doaqRoI6UXH4MQfqWy46+sinCpAoAagJz6lZonJeCJT8bJA4sfUkFRpbUK6GJzRcKl/Imnpjky2ZVgB5GfXK6gVa7c/a1Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VlsAmqAo; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VlsAmqAo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788328972; x=1819864972;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZsQIcqiHQLyH2DKVUpBoYLA6XTARs4g/JsX3IormNF8=;
  b=VlsAmqAoh/TyFjHM5pn3gWBv4y0I+8uJhwihw5puaeFdwV3RvXpmwoMi
   VE6zss0VC958Y+avrdRYScs850ivRieAr6w5iavQlbQ1UV6OUPVc5840a
   lmgfM6m8mDSGYzqYKeKlLlijc3wH6B9jEMDkXtjKPm1OVx4aa5OYwjkO/
   Dz9Jr3QyZf3+vJ+YNDRh9f0L8OM/Q+Nqb8xF9MT5VfFR15MDLpkPtaenT
   pvHhb9PHwhQLKeaPjbGpoxT5/VlxxRmtldwVBunpvWp8li/9kTzarrJJS
   xLWTVPwBJGp6In/E6qV9wspsgpxnQ3Mi5Weiucp0WxVKmDFj4gI+JnjX8
   A==;
X-CSE-ConnectionGUID: NykyEv/oT1G0Qv0LEnNYOA==
X-CSE-MsgGUID: 16rk4kJFRT+GRiCiWKWzGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="99373021"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="99373021"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 23:02:51 -0700
X-CSE-ConnectionGUID: ZHqX8Es0SsC3RVfgs1tTNg==
X-CSE-MsgGUID: waXhBzDUS2CbO17ipdXqoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="269881790"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 23:02:36 -0700
Message-ID: <64acdf25-de17-42fc-a51c-726485f2b9fb@linux.intel.com>
Date: Wed, 2 Sep 2026 14:02:34 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 13/45] KVM: guest_memfd: Pass mapping type filter to
 invalidation helper
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
 linux-mm@kvack.org, linux-coco@lists.linux.dev
References: <20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com>
 <20260830-gmem-inplace-conversion-v12-13-85e5fd25252a@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260830-gmem-inplace-conversion-v12-13-85e5fd25252a@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/2026 8:25 AM, Ackerley Tng via B4 Relay wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> Accept the mapping type filter as a parameter in the invalidation start
> helper instead of querying it internally. This allows callers to specify
> which mappings (shared, private, or both) should be invalidated.
> 
> In the next patch, the conversion process will use this new parameter to
> invalidate mappings only when they're different from the target state of
> the conversion, i.e. invalidate only shared mappings on a shared to private
> conversion and not both.
> 
> No functional change intended.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
