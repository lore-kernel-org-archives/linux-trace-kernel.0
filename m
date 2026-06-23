Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12ED3FBA7;
	Tue, 23 Jun 2026 02:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782182373; cv=none; b=ZFmOGiRFgy63jZ9Q5aqT1wyL3vl7uBtK5HLXzqnayepVPeiTaVsLfuVBHs7RXc04fPx0mWzWT/Sx/VBBEtt+m8sty8jfUVOk/3S4k61LaGYXmYyRbWzGBT3VxOwwbxs/7iBRT2sM6D7BHqQgxKktTwjSrkKxYA2dLXZiSrdSe28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782182373; c=relaxed/simple;
	bh=/A0PS1KBXecicXMwu0KgF5PdNmPIby5wsNW8nHW++bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=guJm/PvVfU0uBLAK53JwooeiQgUZ5sxeeoTCLQLatjvTjWYxwt5KFAx/9MNtCWLukafdiEV6qIwUogktRgVOL0/qATS9MkSx/DaGDn4brZuuEPPHnjpA+IdIUeNsfdZz5x0gXwbiaVg+/HhOht/RnKZfQsM66BWvHCaSSURK5BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BxE2bHKI; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BxE2bHKI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782182372; x=1813718372;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/A0PS1KBXecicXMwu0KgF5PdNmPIby5wsNW8nHW++bE=;
  b=BxE2bHKIiAlcdwUbHZDbPkG9ExwvSEswy8w13RNP/Wj11uTheiU/NWps
   /yUmxayOm2RyjaqNWPciM7yYT9w0BwJoeyVtMza+To4RPncxB6QKtY/ky
   W+7gtLryIZo8Gt+zhcNYPkLA8SD9M4FwaGsz4/aU6OWGGNT1QXRIcg1NJ
   Kafc5Ls5lHcdcf1STwm/ywb1+vG84W7d+Zs8Xjis9+ghgBh/csjsaMss7
   lHrlmOxgZ1bz/IDAHHZFAVsYASMmjX9nz49ddFshfbxttlVxJ+EejmI1X
   bCRseNLrm35brUGIRwsINRxiE+k2++ePcBaGIrxE6N6nVTaQ6URIF0IDl
   w==;
X-CSE-ConnectionGUID: KEd/rY9/T6KjDCEk2HtVug==
X-CSE-MsgGUID: Y82R+kNuR/Gs0Y64SkfFeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="93281964"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="93281964"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 19:39:32 -0700
X-CSE-ConnectionGUID: bAXEwp5sTTeAhs29D3ojQQ==
X-CSE-MsgGUID: arY23Fs/TOybNGBssQOy7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="245254055"
Received: from unknown (HELO [10.239.158.46]) ([10.239.158.46])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 19:39:17 -0700
Message-ID: <9f81ea12-98c4-4ce6-a95e-233851dfe8dd@intel.com>
Date: Tue, 23 Jun 2026 10:39:14 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/46] guest_memfd: In-place conversion support
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
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
> TODOs
> 
> + Retest with TDX selftests. v7 was tested with TDX [12], but the setup there was
>    wrong. Conversions were successful (no errors), but the shared memory being
>    tested is actually in a completely different host physical page.

Glad to see you knew it already (I was going to report this to the 
original POC TDX patch)
