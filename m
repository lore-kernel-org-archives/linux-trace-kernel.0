Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300CA30ACF2;
	Tue, 23 Jun 2026 06:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782197346; cv=none; b=CkIBz8SC+4a50qepz1vV+MqBh80oj8dKZ/QGFaHDmHkUHYLIDIEzGP+KyFOXH7KYImvQb+UFSNR5nsrqGopvoHQBvTG69sIN3kgQRwCGZMHD6Tpw06aWPxJBxXJfc83ECfhnu0TdTgM2/eoWm+e4+sjR3N9BVm89x2rXMgoOyZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782197346; c=relaxed/simple;
	bh=h8AQJDX3UfNiJ86zepeJMtjP8yPCQGflfnfOwDXysvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTfvdOD/UfQiD7fgQuiCVOMxtTtyKbo2fMNpwx+DU/GZ6u+iJITeufvAQIpamJ91/JUZBIRIsHfo6tvpMv7bbMcUyiAvBV+nPj7W/onnWTAb/JakLo6LXQ1FEvVKhrpJrq90TNMmolq3C4QRFvwzu+QZyjy1Hb419zu1FNLmI74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bXK1xsux; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bXK1xsux"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782197344; x=1813733344;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h8AQJDX3UfNiJ86zepeJMtjP8yPCQGflfnfOwDXysvw=;
  b=bXK1xsuxNccQ8Ip6aNhtnU6cXJtpMepuLUyp1On0HmupbKsCHCfw1KAy
   c8kjycCVFLMLfrGqWVpbnXVYBozuVEr5y4vUv9urHvVpdzei7ylN32uNZ
   t4cT/HQSrzG7DSzKUjyuQPvE0K2GP9RFT8JdXysujXqTd4HBFybRUtIFm
   xG0B1Fydsw8OSjQTc6ssAurth7UCbnm1xZxpeSbC6TKkxhpQThxQVw+js
   /5+OeDxIHZ5lSbqzIxT7p20wn3KM2CcCgLDy058hbS/gubvI0ljpnPO7G
   hGGBgaI/Iz49bd6b4piunb7P+h1OIYn2pghPYqXOTm3e+9pr/An/9asfF
   Q==;
X-CSE-ConnectionGUID: VamQVzpbRgmoOQA8+QBoqQ==
X-CSE-MsgGUID: eu4+u/1wQ9ioe4cLA93wEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82701955"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82701955"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 23:49:03 -0700
X-CSE-ConnectionGUID: UQ6n62bSSPGTWfszTIj7Fw==
X-CSE-MsgGUID: AN4e/MmzQW2EM/WlHV3RkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="243076433"
Received: from unknown (HELO [10.238.2.81]) ([10.238.2.81])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 23:48:50 -0700
Message-ID: <120b6d16-4218-4ba6-824e-54c62dd3d74f@linux.intel.com>
Date: Tue, 23 Jun 2026 14:48:47 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/46] KVM: guest_memfd: Only prepare folios for
 private pages
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
 <20260618-gmem-inplace-conversion-v8-12-9d2959357853@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-12-9d2959357853@google.com>
Content-Type: text/plain; charset=UTF-8
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
> 
> Add a check to make sure that preparation is only performed for private
> folios.
> 
> Preparation will be undone on freeing (see kvm_gmem_free_folio()) and on
> conversion to shared.
> 
> Suggested-by: Michael Roth <michael.roth@amd.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

