Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40245371CFF;
	Fri, 14 Aug 2026 06:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786689392; cv=none; b=hYUXV5rO1WxmRwpd4lHQ+44s54eMrRf8eucFwhRFFPgSpWpuj1ATBFeaz8b5xtuP/xBK2yGDQF1biB+FGT9ItD2GuFfh1OmLAw3HD9tG9rQ/H1aZwNW4Wtx0SilLaKLmncwVyAF39WHQfgNqZud2fc++I3Gx9eisFfRsnW096co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786689392; c=relaxed/simple;
	bh=QS50L3Ej/o3Eh9pAbeQ2YK77qR7pbIzS03/vLRtWg60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHw0AyAtspaGxr6LdifEnXUxxw0ux9Q15mSftvOA+vBk84kwXyHIJ3m0Y/5sy2VvR/FoiYmdlNMs4BC9IfRGLeFYeQk4maFkKSafpm0qCLsCNzQC4ifxsNonbWpmT5QT9Oh86EW+ms2lpWKxrK1yULuXjo+WaiZkTVPOZRFEcIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EXnO4n68; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EXnO4n68"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786689390; x=1818225390;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QS50L3Ej/o3Eh9pAbeQ2YK77qR7pbIzS03/vLRtWg60=;
  b=EXnO4n680GlEtZhSRJjvjCapi9SVIXyQpIvY4A75L3/urY1Ktyp+5/ZH
   Va9m0TBtncGDJ5aB8Mma8/CMWbY2i9zTqlDqIWegmV9iSDAdK4YXrMQbQ
   BmsFez3bjjWEtpXN3LgT/Vv9MitasUkdGgR6R/jwCvz9np5mgUXIeQpgF
   ujxyfcD1WZfzOtIggCLVd1+pZqTmYhr17a+1LG8hyfIvTfmTNhkmVI/Pe
   OGG2/GBNXuizUPGDfrzv5182VXqQr7yUdRECR4gqiG7jcQBr8b1PYdaYx
   MZczLFuz5HUfottjbEQLrUMcAlFJqq7qmM3kqTaNZppq4s1J1ifqeaEu9
   Q==;
X-CSE-ConnectionGUID: TnO7V0sESXK3G9nTYqkGew==
X-CSE-MsgGUID: h/vRWQyvT4WwVQyNliqEbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="97859361"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="97859361"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 23:36:29 -0700
X-CSE-ConnectionGUID: GUn57tdyTJmSCwMdue8GsA==
X-CSE-MsgGUID: wgv+28R0Spi44YdDQh7WUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="288935132"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 23:36:15 -0700
Message-ID: <658c8441-972a-4298-a4b2-8ec4f2ca338a@linux.intel.com>
Date: Fri, 14 Aug 2026 14:36:13 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 21/41] KVM: guest_memfd: Enable INIT_SHARED on
 guest_memfd for x86 Coco VMs
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
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, tarunsahu@google.com,
 Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-coco@lists.linux.dev,
 Xiaoyao Li <xiaoyao.li@intel.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-21-2fc18ee6d3ba@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260807-gmem-inplace-conversion-v10-21-2fc18ee6d3ba@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/2026 5:53 AM, Ackerley Tng via B4 Relay wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Now that guest_memfd supports tracking private vs. shared within gmem
> itself, allow userspace to specify INIT_SHARED on a guest_memfd instance
> for x86 Confidential Computing (CoCo) VMs, so long as in-place conversion
> is enabled, i.e. when it's actually possible for a guest_memfd instance to
> contain shared memory.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Tested-by: Shivank Garg <shivankg@amd.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

